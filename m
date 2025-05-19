Return-Path: <netdev+bounces-191545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5497ABBF2E
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D843B18F3
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850DA8249F;
	Mon, 19 May 2025 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b="dTVFQZnn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBF1FF5E3
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747661477; cv=none; b=oMFXE6irya5QnfRwjiZSzppW4zONWb/9+Vz1VWbYqgZqK9MVimSgYTnUiCvIxMywfcgCW6O5iPOb+sqZ5gLOD4V0K+Qsga/c4hdC5c5maYyBFvGkYwfrpmbEhvhRytH1X3+R+Enqae7oltHUX05Ct8YgedqMp8kpIgWCMn+QytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747661477; c=relaxed/simple;
	bh=NFzwrs6GkGp26MgXdV6yraZs/s5o334N3lPzV6Q9J8o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IlW/mHQYs3750oq2/s0QH7Ic+o0ITgxY6pyXzpweUgh4tLoFSHuOI4snmx37b3a6B7+oB1ACNyx8bVysj4wH/7jvEaxad2YAz0YjOuPeDJc8jY0/R1krDrvJZkwYYQ0TxEBL+hgf3642v7zUN30hmBvrK30qcxYKFPiHtsnB97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com; spf=pass smtp.mailfrom=deepl.com; dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b=dTVFQZnn; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepl.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32909637624so20403591fa.1
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepl.com; s=google; t=1747661473; x=1748266273; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aOycn6ibqjiLVj3SmjnHLh84fJnIytfYzcCSNvoQRTo=;
        b=dTVFQZnnsnJx5Hf5boitOgNbpSa1NWyDQlGdcISg7Wph7VOxJJ6v435rWejtV7Mwnv
         QVll6W4Q9HJGnr5TyZWVWY9XtjwtHW7ygiHSShPCR+RK7nyU3mZ7bu0dd+MHUW9sr0w1
         xZmw0vFR7jdJyhYKb8KjVvsIbCS8z69UcbmhSU+dUsKmfm8gVO4R+l5GjlrBV7r17zci
         kKn8fWq/pspEYL/umTqMO/2Ezcc1wgp9OjWPdJ7GYZIpobARIk810ioXD6bO3tC+0oTi
         Ab4jPkZPaT+bZ9yiGCPXi9r8kHYNxLcGW+ur0JGEflS28bAkyF2hmYB9+a4dxyx47Rkx
         rVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747661473; x=1748266273;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOycn6ibqjiLVj3SmjnHLh84fJnIytfYzcCSNvoQRTo=;
        b=WxZ2VUrPS2U/8Ha239DoR8BQHtWXAglZs/rz4PcSwPBPZfHP4BosemEIS8r0jv4XWB
         6I66LEntJNofgK7zS6B3GeYJrPLmrk8JTiksXmmia40h/qwKYdwbw7RzT0WAbxuEbvkL
         fEQrNnftNg6S1XDwzRniXN7HPNsS2NN1tkUzbYn8kpEuEt3RJZEDpPoJvv1LssAiXkUt
         VfAhoKIRL9uoYM9gGkAlMpIVduZEpRUw3lUcBJ4KTpqN/oP1v8oOpFUcGZP8YG7MNKky
         XuHPZmCxetK9MDj43ql5/mpvUWrJ2RfcOsI5x3c1xTTji2ywVuKBZCe22SrTyk3TI5E2
         mM3w==
X-Gm-Message-State: AOJu0YyZixhUt5TFaUuXd2nDe4vtOIHBO40y+lJGrBHYSaKhxdpscxBB
	8uzMrVJx0pyUBvn2vU9CLKTwuB7oMlyRj6m0tsjEPtvfQvPxxluOOXBu+L7aoCvts/NZYrXajjJ
	bAZtzS4DfnWkc50FDYGgPPqYx+S0ZHVuoONswvma605ug+JqpcRdBgL8=
X-Gm-Gg: ASbGnct4XUJVk0r7xNDO3h/ocjTg7xbnzJBFufXH1b7mmYFfyTREZAs27OxjOpOH8WV
	lrcIjuxYSslJ/DTxYsE4NVgbWhpPljV6S3F3W2QwTFMdMMYnehLUuTfsRQ/YTLnmtx9oi2EcVau
	Ve95WCtfI7NqXa1rxooqpONMErJKWHMq0qOpugbudUwSDQq7/pnpuc3gm0mshTqpb89RorK/pRI
	1DMlw==
X-Google-Smtp-Source: AGHT+IFI1XSTUxmlTmpLvXc4fgXgV8TcIOb7C0zDvw12f4c+2QaOmxpPqeP9pG2ATmyBM5quxehF0HNDHW6FJjIucmY=
X-Received: by 2002:a2e:8a9c:0:b0:30b:efa3:b105 with SMTP id
 38308e7fff4ca-3280774786fmr39445361fa.19.1747661472529; Mon, 19 May 2025
 06:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Simon Campion <simon.campion@deepl.com>
Date: Mon, 19 May 2025 15:31:01 +0200
X-Gm-Features: AX0GCFuzuIfPMldsxYl_k5tGZpoNrg6Ti1W7erqpgrznGlzJISbpGu4EEZto7Vs
Message-ID: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
Subject: tcp: socket stuck with zero receive window after SACK
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

We have a TCP socket that's stuck in the following state:

* it SACKed ~40KB of data, but misses 602 bytes at the beginning
* it has a zero receive window
* the Recv-Q as reported by ss is 0

Due to the zero window, the kernel drops the missing 602 bytes when
the peer sends them. So, the socket is stuck indefinitely waiting for
data it drops when it receives it. Since the Recv-Q as reported by ss
is 0, we suspect the receive window is not 0 because the owner of the
socket isn't reading data. Rather, we wonder whether the kernel SACKed
too much data than it should have, given the receive buffer size, not
leaving enough space to store the missing bytes when they arrive.
Could this happen?

We don't have a reproducer for this issue. The socket is still in this
state, so we're happy to provide more debugging information while we
have it. This is the first time we've seen this problem.

Here are more details:

# uname -r
6.6.83-flatcar

The stuck socket is used by the in-kernel cephfs driver to fetch data
from an OSD on a storage node. The storage node runs the same kernel
version.

In tcpdump, we see SACK {603:42189} and win 0:

# tcpdump -ni any 'host 10.70.3.48 and tcp port 6945'
...
10:02:56.739075 eth1a Out IP 10.70.112.146.35432 > 10.70.3.48.6945:
Flags [P.], seq 4260252836:4260252845, ack 838667293, win 0, options
[nop,nop,TS val 1683964360 ecr 1218657118,nop,nop,sack 1 {603:42189}],
length 9
10:02:56.739157 eth1b In  IP 10.70.3.48.6945 > 10.70.112.146.35432:
Flags [.], ack 9, win 518, options [nop,nop,TS val 1218662238 ecr
1683964360], length 0
10:03:01.859080 eth1a Out IP 10.70.112.146.35432 > 10.70.3.48.6945:
Flags [P.], seq 9:18, ack 1, win 0, options [nop,nop,TS val 1683969480
ecr 1218662238,nop,nop,sack 1 {603:42189}], length 9
10:03:01.859185 eth1b In  IP 10.70.3.48.6945 > 10.70.112.146.35432:
Flags [.], ack 18, win 518, options [nop,nop,TS val 1218667358 ecr
1683969480], length 0

Every two minutes, the storage node will try to transmit the missing 602 bytes:

10:03:10.896289 eth1b In  IP 10.70.3.48.6945 > 10.70.112.146.35432:
Flags [.], seq 1:603, ack 27, win 518, options [nop,nop,TS val
1218676396 ecr 1683974600], length 602
10:03:10.896319 eth1a Out IP 10.70.112.146.35432 > 10.70.3.48.6945:
Flags [.], ack 1, win 0, options [nop,nop,TS val 1683978517 ecr
1218676396,nop,nop,sack 1 {603:42189}], length 0

pwru shows that the packet with the missing 602 bytes is dropped
because of SKB_DROP_REASON_TCP_ZEROWINDOW:

# ./pwru 'src host 10.70.3.48 and tcp port 6945 and greater 100'
...
SKB                CPU PROCESS          NETNS      MARK/x        IFACE
      PROTO  MTU   LEN   TUPLE FUNC
0xff1100014dd71f00 10  <empty>:0        4026531840 0
eth1b:5      0x0800 9086  654
10.70.3.48:6945->10.70.112.146:35432(tcp) inet_gro_receive
0xff1100014dd71f00 10  <empty>:0        4026531840 0
eth1b:5      0x0800 9086  654
10.70.3.48:6945->10.70.112.146:35432(tcp) tcp4_gro_receive
0xff1100014dd71f00 10  <empty>:0        4026531840 0
eth1b:5      0x0800 9086  654
10.70.3.48:6945->10.70.112.146:35432(tcp) tcp_gro_receive
0xff1100014dd71f00 10  <empty>:0        4026531840 0
eth1b:5      0x0800 9086  654
10.70.3.48:6945->10.70.112.146:35432(tcp) skb_defer_rx_timestamp
0xff1100014dd71f00 10  <empty>:0        4026531840 0
eth1b:5      0x0800 9086  668
10.70.3.48:6945->10.70.112.146:35432(tcp) skb_ensure_writable
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 9086  654
10.70.3.48:6945->10.70.112.146:35432(tcp) ip_rcv_core
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 9086  654
10.70.3.48:6945->10.70.112.146:35432(tcp) nf_hook_slow
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 9086  654
10.70.3.48:6945->10.70.112.146:35432(tcp) nf_checksum
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 9086  654
10.70.3.48:6945->10.70.112.146:35432(tcp) nf_ip_checksum
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 9086  654
10.70.3.48:6945->10.70.112.146:35432(tcp) tcp_v4_early_demux
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 65536 654
10.70.3.48:6945->10.70.112.146:35432(tcp) ip_local_deliver
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 65536 654
10.70.3.48:6945->10.70.112.146:35432(tcp) nf_hook_slow
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 65536 654
10.70.3.48:6945->10.70.112.146:35432(tcp) ip_local_deliver_finish
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 65536 634
10.70.3.48:6945->10.70.112.146:35432(tcp) ip_protocol_deliver_rcu
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 65536 634
10.70.3.48:6945->10.70.112.146:35432(tcp) raw_local_deliver
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 65536 634
10.70.3.48:6945->10.70.112.146:35432(tcp) tcp_v4_rcv
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 65536 634
10.70.3.48:6945->10.70.112.146:35432(tcp) tcp_filter
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 65536 634
10.70.3.48:6945->10.70.112.146:35432(tcp) sk_filter_trim_cap
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 65536 634
10.70.3.48:6945->10.70.112.146:35432(tcp) security_sock_rcv_skb
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 65536 634
10.70.3.48:6945->10.70.112.146:35432(tcp) selinux_socket_sock_rcv_skb
0xff1100014dd71f00 10  <empty>:0        4026531840 300
eth1b:5      0x0800 65536 634
10.70.3.48:6945->10.70.112.146:35432(tcp) tcp_v4_fill_cb
0xff1100014dd71f00 10  <empty>:0        0          300             0
      0x0800 65536 634   10.70.3.48:6945->10.70.112.146:35432(tcp)
tcp_v4_do_rcv
0xff1100014dd71f00 10  <empty>:0        0          300             0
      0x0800 65536 634   10.70.3.48:6945->10.70.112.146:35432(tcp)
tcp_rcv_established
0xff1100014dd71f00 10  <empty>:0        0          300             0
      0x0800 65536 634   10.70.3.48:6945->10.70.112.146:35432(tcp)
tcp_validate_incoming
0xff1100014dd71f00 10  <empty>:0        0          300             0
      0x0800 65536 634   10.70.3.48:6945->10.70.112.146:35432(tcp)
tcp_urg
0xff1100014dd71f00 10  <empty>:0        0          300             0
      0x0800 65536 634   10.70.3.48:6945->10.70.112.146:35432(tcp)
tcp_data_queue
0xff1100014dd71f00 10  <empty>:0        0          300             0
      0x0800 0     602   10.70.3.48:6945->10.70.112.146:35432(tcp)
kfree_skb_reason(SKB_DROP_REASON_TCP_ZEROWINDOW)
0xff1100014dd71f00 10  <empty>:0        0          300             0
      0x0800 0     602   10.70.3.48:6945->10.70.112.146:35432(tcp)
skb_release_head_state
0xff1100014dd71f00 10  <empty>:0        0          300             0
      0x0800 0     602   10.70.3.48:6945->10.70.112.146:35432(tcp)
skb_release_data
0xff1100014dd71f00 10  <empty>:0        0          300             0
      0x0800 0     602   10.70.3.48:6945->10.70.112.146:35432(tcp)
skb_free_head
0xff1100014dd71f00 10  <empty>:0        0          300             0
      0x0800 0     602   10.70.3.48:6945->10.70.112.146:35432(tcp)
kfree_skbmem

If we interpret the ss output below correctly, the Recv-Q is 0 and
receive buffer is almost full (127kb/131kb):

# ss --tcp -timo | grep -A 1 10.70.3.48:6945
ESTAB    0      0                 10.70.112.146:35432
10.70.3.48:6945
         skmem:(r127488,rb131072,t0,tb46080,f3584,w0,o0,bl0,d2821) ts
sack cubic wscale:7,7 rto:201 rtt:0.11/0.02 ato:40 mss:1434 pmtu:9086
rcvmss:1434 advmss:9034 cwnd:2 ssthresh:2 bytes_sent:610174
bytes_retrans:36 bytes_acked:610139 bytes_received:102223
segs_out:70278 segs_in:70365 data_segs_out:67444 data_segs_in:2927
send 209Mbps lastsnd:4071 lastrcv:345233042 lastack:4071 pacing_rate
249Mbps delivery_rate 417Mbps delivered:67441 app_limited busy:2957ms
retrans:0/4 rcv_rtt:0.075 rcv_space:45056 rcv_ssthresh:45056
minrtt:0.058 rcv_ooopack:31 snd_wnd:66304 rehash:1

Here's the `ss` output from the other end of the TCP connection, the
storage node:

# ss --tcp -timo | grep -A 1 10.70.112.146:35432
ESTAB    0      186408    10.70.3.48:6945   10.70.112.146:35432
   timer:(on,35sec,0)
         skmem:(r0,rb2420208,t0,tb332800,f3032,w332840,o0,bl0,d0) ts
sack cubic wscale:7,7 rto:120000 rtt:0.066/0.015 ato:40 mss:1434
pmtu:1486 rcvmss:536 advmss:1434 cwnd:1 ssthresh:2 bytes_sent:1852143
bytes_retrans:1707732 bytes_acked:102223 bytes_received:613144
segs_out:70712 segs_in:70622 data_segs_out:2941 data_segs_in:67774
send 174Mbps lastsnd:84760 lastrcv:1638 lastack:1638 pacing_rate
6.64Gbps delivery_rate 6.98Gbps delivered:107 busy:346940689ms
rwnd_limited:209ms(0.0%) unacked:32 retrans:1/2834 lost:1 sacked:31
rcv_rtt:362445 rcv_space:64677 rcv_ssthresh:66234 notsent:144220
minrtt:0.044 rcv_wnd:66304

The receive buffer has the default size:

# cat /proc/sys/net/ipv4/tcp_rmem
4096    131072  6291456

Let us know if any other information would be helpful to diagnose this
issue further.

Thanks for your help!
Simon

