Return-Path: <netdev+bounces-159445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77763A15820
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 20:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D145C3A96CE
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5011A4E70;
	Fri, 17 Jan 2025 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/8P7uJu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F6E25A62F
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737142160; cv=none; b=RWCbxavJMEckuD5KEBbqdCdB76uZrLu0ogu75k+1w1ltBoKE1tCFkN1byL2xFRLqFxfD+FFoeWid6n1EeuJWsH0r17/elWx3aja39KV5dyy8+xUESMdDc6Q2+goUx9sOVHCuuTe75d8lErcOs/wS28Krj5ntxceSEhL9eTnA4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737142160; c=relaxed/simple;
	bh=gEgkqwlptORI08/9TKZUenSI8+PXDoKFAC8oIa3x6y4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HMEy68YGxbDxK5UUCggp4XHX+DXt7Z/xxT6VYJjyGVHtOnXdHlDatcuUDmnsjC2WnFQTyB9c2p2hyB4Gezg+xLoLzlvzlRx46b2NK3LdcuYIIoL2gzWiM2DfPNWTzMumWkCV8M4tZVTDlCGd2ykN+T67ALyUsfudtt2vjssYE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/8P7uJu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21631789fcdso46632445ad.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 11:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737142158; x=1737746958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UWyZBTfDGirVnw+36Z7v5WzwnLh7WC7cYyZeG88Zcg=;
        b=H/8P7uJuYgvNO33/PwFtGDGJjpooemrd19DLVUDDjkQtEn4Jcz4x3gMi+1+dxuphGj
         Vn+0sbusO6Crd7+3svuCBAN1hHDk9GFQjnLbjgASJSV8KZzD41ioZ6om3AUEftKzYWOu
         8y4+K2ZylDjp9zi4NqnGyKSjdCdOJrAlnScxCNFsAT6yFjnLT39s3sr3XQP4VC7bEXFz
         IS559jY6YaNLEYKJgIpDNLIxdlex1tvLJ4D+dcwTUcgR5dswvJ/8WMMSDnw39xZs8DNY
         QOfSUsJ/hYt/5gRP6cjXG56bxiztRB/MAKqaAicMSvxTGDVkc0zTK8gnsSPdLPxAUXBn
         UQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737142158; x=1737746958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UWyZBTfDGirVnw+36Z7v5WzwnLh7WC7cYyZeG88Zcg=;
        b=YaEoFAI7TzJc5AVWeCZBeysFfiq+93rQRXALfC952M7nudnwDuzA8hhhCsjUN+KB74
         Ku6Qx2/NIMjlSkI3jocrwsZbwCKeNhVyFj6++6DVEUNbNZ7hGhAlkM+NjPu1JLMcGsa4
         S2NWnG2GYvzJeuDfVOYFgcPesMJHMHUhDVTh3IMbcU6FR+kaCD8k6AhpWNaCGnyWKG5y
         kp1CaEtE8wkL06yy1qtrrd4u8takxOFxCa3fKRTPukDQ387w5USjr4KIz3AeykhG03+Q
         SImt2U9WRdahvfEB9NiaMotuk9V5Lb3tGvba0xdZYx3AmNdKBd51ydAfGXEFYfOqahL5
         +5ZQ==
X-Gm-Message-State: AOJu0YxgXBBuXc0oa1tKH4y01S25RrHtyNNuAQvMdgT1rZ/mYRYe2Gx3
	rF3T9VqCoYFbFcY/IluGD2/FIM2RXQZxFlPS5flCJcs4WmODzIwARXu11icH
X-Gm-Gg: ASbGncv9Al/p/rbSKrYnAPpxZhFJclIqpefuUeQ1iDjp3HkvQdHJNFA/HzVTp3lmaUw
	lH8QjRHBJHKZXdMvhkUon9Rbqz8GgGfrNZ0uFyG44b56z8d3u+Jr2661JA1dj9ctXo5yvCb81bk
	rbZv+qX7W4wRr913irllfNdvyxnSUSokir5rOOpBicnDaqF1uK19jXCLJ0Ome1zwYprmcIaS6z7
	p00bxOdIKGpqtkYlCGnbHpZkDF5eTRZO9ZSXELqVOGN34PQe/fv40AYrHJ0
X-Google-Smtp-Source: AGHT+IF4oWmDgsNir2HZUyA9/sadzUr8tbcXqh8xap/mnLM7r98bp8TvTz7eYQDyfFG5hz9sxwkfFA==
X-Received: by 2002:a05:6a00:6f2a:b0:725:4915:c10 with SMTP id d2e1a72fcca58-72d8c7709cbmr19199492b3a.10.1737142157474;
        Fri, 17 Jan 2025 11:29:17 -0800 (PST)
Received: from localhost.localdomain ([220.181.41.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab815f1bsm2358126b3a.65.2025.01.17.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 11:29:17 -0800 (PST)
From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
To: netdev@vger.kernel.org
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Zhongqiu Duan <dzq.aishenghu0@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [RFC PATCH] tcp: fill the one wscale sized window to trigger zero window advertising
Date: Sat, 18 Jan 2025 03:28:59 +0800
Message-Id: <20250117192859.28252-1-dzq.aishenghu0@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the rcvbuf of a slow receiver is full, the packet will be dropped
because tcp_try_rmem_schedule() cannot schedule more memory for it.
Usually the scaled window size is not MSS aligned. If the receiver
advertised a one wscale sized window is in (MSS, 2*MSS), and GSO/TSO is
disabled, we need at least two packets to fill it. But the receiver will
not ACK the first one, and also do not offer a zero window since we never
shrink the offered window.
The sender waits for the ACK because the send window is not enough for
another MSS sized packet, tcp_snd_wnd_test() will return false, and
starts the TLP and then the retransmission timer for the first packet
until it is ACKed.
It may take a long time to resume transmission from retransmission after
the receiver clears the rcvbuf, depends on the times of retransmissions.

This issue should be rare today as GSO/TSO is a common technology,
especially after 0a6b2a1dc2a2 ("tcp: switch to GSO being always on") or
commit d0d598ca86bd ("net: remove sk_route_forced_caps").
We can reproduce it by reverting commit 0a6b2a1dc2a2 and disabling hw
GSO/TSO from nic using ethtool (a). Or enabling MD5SIG (b).

Force split a large packet and send it to fill the window so that the
receiver can offer a zero window if he want.

Reproduce:

1. Set a large number for net.core.rmem_max on the RECV side to provide
   a large wscale value of 11, which will provide a 2048 window larger
   than the normal MSS 1448.
   Set a slightly lower value for net.ipv4.tcp_rmem on the RECV side to
   quickly trigger the problem. (optional)

   sysctl net.core.rmem_max=67108864
   sysctl net.ipv4.tcp_rmem="4096 131072 262144"

2. (a) Build customized kernel with 0a6b2a1dc2a2 reverted and disabling
   the GSO/TSO of nic on the SEND side.
   (b) Or setup the xfrm tunnel with esp proto and aead rfc4106(gcm(aes))
   algo. (Namespace and veth is okay, helper xfrm.sh is at the end.)

3. Start the receiver but don't receive. (netcat-bsd with MD5SIG support)
   (a) nc -l -p 11235
   (b) nc -l -p 11235 -S

4. Send.
   (a) nc 9.9.6.110 11235 <bigdata
   (b) nc -S 9.9.7.110 11235 <bigdata

5. After tens of seconds, the receiver clears the rcvbuf. (ss -tnpOHoemi)

ESTAB 0      0      9.9.6.120:11235 9.9.6.110:48038 users:(("nc",pid=1380,fd=4)) ino:19894 sk:c cgroup:/ <-> skmem:(r0,rb262144,t0,tb46080,f266240,w0,o0,bl0,d19) ts sack cubic wscale:7,11 rto:200 rtt:1.177/0.588 ato:200 mss:1448 pmtu:1500 rcvmss:1448 advmss:1448 cwnd:10 bytes_received:392784 segs_out:139 segs_in:295 data_segs_in:293 send 98419711bps lastsnd:125850 lastrcv:55400 lastack:22130 pacing_rate 196839416bps delivered:1 rcv_rtt:0.977 rcv_space:194408 rcv_ssthresh:2896 minrtt:1.177 snd_wnd:64256

6. The sender remains in the retransmission state. (ss -tnpOHoemi)

ESTAB 0      45104  9.9.6.110:48038 9.9.6.120:11235 users:(("nc",pid=1349,fd=3)) timer:(on,30sec,7) ino:16914 sk:8 cgroup:/ <-> skmem:(r0,rb131072,t0,tb96768,f4048,w86064,o0,bl0,d0) ts sack cubic wscale:11,7 rto:32000 backoff:7 rtt:49.988/0.047 mss:1448 pmtu:1500 rcvmss:536 advmss:1448 cwnd:1 ssthresh:14 bytes_sent:208888 bytes_retrans:13032 bytes_acked:194409 segs_out:149 segs_in:92 data_segs_out:147 send 231736bps lastsnd:1100 lastrcv:38270 lastack:34530 pacing_rate 5839704bps delivery_rate 231944bps delivered:139 busy:38270ms rwnd_limited:38180ms(99.8%) unacked:1 retrans:1/9 lost:1 dsack_dups:1 rcv_space:14480 rcv_ssthresh:64088 notsent:43656 minrtt:0.254 snd_wnd:2048

Tcpdump:

```
51:10.437 S > R: seq 1910971411, win 64240, length 0
51:10.438 R > S: seq 2609098178, ack 1910971412, win 65160, length 0
51:10.439 S > R: ack 1, win 502, length 0
51:10.439 S > R: seq 1:1449, ack 1, win 502, length 1448
51:10.439 S > R: seq 1449:2897, ack 1, win 502, length 1448
51:10.439 S > R: seq 2897:4345, ack 1, win 502, length 1448
51:10.440 R > S: ack 2897, win 31, length 0
51:10.440 S > R: seq 4345:5793, ack 1, win 502, length 1448
51:10.440 R > S: ack 4345, win 31, length 0
51:10.440 S > R: seq 5793:7241, ack 1, win 502, length 1448
51:10.440 R > S: ack 7241, win 30, length 0
<...>
51:10.485 S > R: seq 85809:87257, ack 1, win 502, length 1448
51:10.527 R > S: ack 87257, win 2, length 0
51:10.527 S > R: seq 87257:88705, ack 1, win 502, length 1448
51:10.527 S > R: seq 88705:90153, ack 1, win 502, length 1448
51:10.577 R > S: ack 90153, win 1, length 0
51:10.578 S > R: seq 90153:91601, ack 1, win 502, length 1448
51:10.627 R > S: ack 91601, win 1, length 0
<...>
51:14.077 S > R: seq 191513:192961, ack 1, win 502, length 1448
51:14.127 R > S: ack 192961, win 1, length 0
51:14.127 S > R: seq 192961:194409, ack 1, win 502, length 1448
51:14.177 R > S: ack 194409, win 1, length 0
<rcvbuf full>
51:14.177 S > R: seq 194409:195857, ack 1, win 502, length 1448
51:14.431 S > R: seq 194409:195857, ack 1, win 502, length 1448
51:14.691 S > R: seq 194409:195857, ack 1, win 502, length 1448
51:15.201 S > R: seq 194409:195857, ack 1, win 502, length 1448
51:16.241 S > R: seq 194409:195857, ack 1, win 502, length 1448
51:18.321 S > R: seq 194409:195857, ack 1, win 502, length 1448
51:22.401 S > R: seq 194409:195857, ack 1, win 502, length 1448
51:30.961 S > R: seq 194409:195857, ack 1, win 502, length 1448
51:47.601 S > R: seq 194409:195857, ack 1, win 502, length 1448
<clear rcvbuf>
51:51.504 R > S: ack 194409, win 2, length 0
<retransmission timer timeout>
52:20.242 S > R: seq 194409:195857, ack 1, win 502, length 1448
52:20.242 R > S: ack 195857, win 3, length 0
<...>
52:20.245 S > R: seq 223369:224817, ack 1, win 502, length 1448
52:20.245 R > S: ack 223369, win 30, length 0
```

File: xfrm.sh

```
if [ "$1" = "l" ]; then
        mode=tunnel
        daddr=9.9.6.110
        laddr=9.9.6.120
        xdaddr=9.9.7.110
        xladdr=9.9.7.120
        ispi=0x20
        ospi=0x10
        dev=veth0
elif [ "$1" = "r" ]; then
        mode=tunnel
        daddr=9.9.6.120
        laddr=9.9.6.110
        xdaddr=9.9.7.120
        xladdr=9.9.7.110
        ispi=0x10
        ospi=0x20
        dev=veth1
else
        echo "Usage: $0 <l|r>"
        exit 1
fi

ip xfrm state flush
ip xfrm policy flush
ip link set $dev up
ip addr add $laddr/24 dev $dev
ip link add xfrm0 type xfrm dev $dev if_id 3
ip link set xfrm0 up
ip addr add $xladdr/24 dev xfrm0
ip xfrm state add src $laddr dst $daddr spi $ospi proto esp mode $mode if_id 3 aead 'rfc4106(gcm(aes))' 0x856f15d0ccabe682286b4286bccf5d595b88b168 128
ip xfrm state add src $daddr dst $laddr spi $ispi proto esp mode $mode if_id 3 aead 'rfc4106(gcm(aes))' 0x856f15d0ccabe682286b4286bccf5d595b88b168 128
ip xfrm policy add dir in  tmpl src $daddr dst $laddr proto esp spi $ispi mode $mode if_id 3
ip xfrm policy add dir out tmpl src $laddr dst $daddr proto esp spi $ospi mode $mode if_id 3
```

Signed-off-by: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
---
 net/ipv4/tcp_output.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0e5b9a654254..61debda90f6d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2143,6 +2143,9 @@ static bool tcp_snd_wnd_test(const struct tcp_sock *tp,
 {
 	u32 end_seq = TCP_SKB_CB(skb)->end_seq;
 
+	if (tp->rx_opt.snd_wscale && (1 << tp->rx_opt.snd_wscale) == tp->snd_wnd)
+		return true;
+
 	if (skb->len > cur_mss)
 		end_seq = TCP_SKB_CB(skb)->seq + cur_mss;
 
@@ -2806,7 +2809,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		}
 
 		limit = mss_now;
-		if (tso_segs > 1 && !tcp_urg_mode(tp))
+		if (!tcp_urg_mode(tp))
 			limit = tcp_mss_split_point(sk, skb, mss_now,
 						    cwnd_quota,
 						    nonagle);
-- 
2.34.1


