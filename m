Return-Path: <netdev+bounces-159454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95739A1585D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 20:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5023A8A56
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E04C1A841B;
	Fri, 17 Jan 2025 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAzr2q7/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F3647
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143460; cv=none; b=JewNtKzOG5Je0YfQEVZMvdw+z1ICSpMef/S6W0laNnNNVKGNRkRUuQvVRVpjZcEFxcH4jU1F9yrhCa8/VNv6H5vxa0MjmeHz/KOWJi0u7FWmUddnB06LhA3Ekj+f5NmpOvqFUqJRbD3hekz3IfeU0x+B//eJXLm7LvPt9ZxMjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143460; c=relaxed/simple;
	bh=zvHO8rKlubCNawlHRLTd9BEiAZEGFeHezsgdazIMQMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfmHTRoYwmFtAc8J2/jI8URxBBiqE8R4POyuZEBkwaGfm1OSwqXTWQRmIUFKDIgX+cSkfH0lDVdSmVf7/vGlVAVWIeQsUC+BdW3rvwRrdlQtdyVdH52grPhaqvj5FqRt2OIogB5yiRyBUt+CKiyrzXIjtOGlxCN3nn5B4ToQxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GAzr2q7/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso3491916a12.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 11:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737143457; x=1737748257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7DkWl8dmcozoBw1kXeWroubmC0Dc4MmN52KQvm3y8c=;
        b=GAzr2q7/HXIzrKU+YdSVJYITSlX3/4Z55QsiwQcaFwXiP+HpvPovP6EKN6Gplj938z
         ZdIiSCCQBl8OOiYBkN5dPq4B4CBL1IDAW7uxxrZZ3pTLzngfmUOUd+oOliHUN71KYS0y
         L7tk6vXgj8BEmaOPsAwBbAZnPZShbT8Ivo2i5oXvS795o0umIs6UdUToFZAh5uKJ5h2Y
         Mm1Co6wLmGedlSygAd1kAmHQXfr6Hk3kTjlY+B/fR9iHKhgIRt6u0oYy+VTscedTyIma
         P9IqVoULx30X1TQ1OZP/QTEZv4/WooKWc6daRRQRURFArczX8imRYqiz78noAVp9nHpN
         qGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737143457; x=1737748257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7DkWl8dmcozoBw1kXeWroubmC0Dc4MmN52KQvm3y8c=;
        b=tcIMEFIsei/wyX7gCAWBHdUNDOo4cs71SGr7YzXz/nyDLT/TmV9ZRytfZH8Sp/2wIU
         KBEqExo6/8sMBvSA9PssKPvfUYusNMM9JYW81yLtjCVNlbSNX2bFcHBXXWPIQyhAfOht
         SnTfldNrbZWa0XaHsieoYbfqnIyjM5B5jD1Agqj/2vXtDENPp5m+bOEsvqVz6YRaoSNk
         SicMDJBSbdgxq7b+bd0GPCg2TKC/IwEpykUM4rvkImwFLXwjPhgrL6fDg4o07fgZKJiI
         m6GD5sPtFuLMgJTElyipCr7YFZ4uaIAHaXem0THVhCEhdIcikhGSDATDYlUAdo3SgJao
         Zs5w==
X-Gm-Message-State: AOJu0YzeiboXw2ZNjKa2/CnNG/rH4vS5uxLQhYVfAbKRrlLywszgDRST
	vjsIhEQR6DLMidSwwEcC5iN73PT6B7hDsxvycYpJq+12GOx011jgSVyWfcDW5eevKwT/ZYqZbVC
	8SRp99s2/76zuK/SHlqummDjWdhHXZtR+Btj4
X-Gm-Gg: ASbGncsUhPTGPdMZ4HA/2nGIUy+R5iSXrQ+KwiKMspMY1fda9B11PlYPwl1/vqIDpV9
	FFoSdA9gxcuNALa3xEAmQSaXrb2BP7aBRN8Ii+A==
X-Google-Smtp-Source: AGHT+IESWZqlTgYE/NriOAiISZXQeWMRxq+sCaW8DWfkBahLHY6BjEexKiZbFo4x2Atrj2AbdjDNPcTGEN9uilMayeg=
X-Received: by 2002:a05:6402:84c:b0:5da:a97:ad73 with SMTP id
 4fb4d7f45d1cf-5db7d2f8825mr3097633a12.13.1737143456323; Fri, 17 Jan 2025
 11:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117192859.28252-1-dzq.aishenghu0@gmail.com>
In-Reply-To: <20250117192859.28252-1-dzq.aishenghu0@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Jan 2025 20:50:43 +0100
X-Gm-Features: AbW1kvZGE1KUPzVyaibmP37MS-GEtEGX9rZOrPgFzhm0uubxQuAZqg96nTGDmm4
Message-ID: <CANn89i+KDDrP4xOniv6zej4SAjd5SNwR=qfu2f66F-L2+J=ZSw@mail.gmail.com>
Subject: Re: [RFC PATCH] tcp: fill the one wscale sized window to trigger zero
 window advertising
To: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Cc: netdev@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 8:29=E2=80=AFPM Zhongqiu Duan <dzq.aishenghu0@gmail=
.com> wrote:
>
> If the rcvbuf of a slow receiver is full, the packet will be dropped
> because tcp_try_rmem_schedule() cannot schedule more memory for it.
> Usually the scaled window size is not MSS aligned. If the receiver
> advertised a one wscale sized window is in (MSS, 2*MSS), and GSO/TSO is
> disabled, we need at least two packets to fill it. But the receiver will
> not ACK the first one, and also do not offer a zero window since we never
> shrink the offered window.
> The sender waits for the ACK because the send window is not enough for
> another MSS sized packet, tcp_snd_wnd_test() will return false, and
> starts the TLP and then the retransmission timer for the first packet
> until it is ACKed.
> It may take a long time to resume transmission from retransmission after
> the receiver clears the rcvbuf, depends on the times of retransmissions.
>
> This issue should be rare today as GSO/TSO is a common technology,
> especially after 0a6b2a1dc2a2 ("tcp: switch to GSO being always on") or
> commit d0d598ca86bd ("net: remove sk_route_forced_caps").
> We can reproduce it by reverting commit 0a6b2a1dc2a2 and disabling hw
> GSO/TSO from nic using ethtool (a). Or enabling MD5SIG (b).
>
> Force split a large packet and send it to fill the window so that the
> receiver can offer a zero window if he want.
>
> Reproduce:
>
> 1. Set a large number for net.core.rmem_max on the RECV side to provide
>    a large wscale value of 11, which will provide a 2048 window larger
>    than the normal MSS 1448.
>    Set a slightly lower value for net.ipv4.tcp_rmem on the RECV side to
>    quickly trigger the problem. (optional)
>
>    sysctl net.core.rmem_max=3D67108864
>    sysctl net.ipv4.tcp_rmem=3D"4096 131072 262144"
>
> 2. (a) Build customized kernel with 0a6b2a1dc2a2 reverted and disabling
>    the GSO/TSO of nic on the SEND side.
>    (b) Or setup the xfrm tunnel with esp proto and aead rfc4106(gcm(aes))
>    algo. (Namespace and veth is okay, helper xfrm.sh is at the end.)
>
> 3. Start the receiver but don't receive. (netcat-bsd with MD5SIG support)
>    (a) nc -l -p 11235
>    (b) nc -l -p 11235 -S
>
> 4. Send.
>    (a) nc 9.9.6.110 11235 <bigdata
>    (b) nc -S 9.9.7.110 11235 <bigdata
>
> 5. After tens of seconds, the receiver clears the rcvbuf. (ss -tnpOHoemi)
>
> ESTAB 0      0      9.9.6.120:11235 9.9.6.110:48038 users:(("nc",pid=3D13=
80,fd=3D4)) ino:19894 sk:c cgroup:/ <-> skmem:(r0,rb262144,t0,tb46080,f2662=
40,w0,o0,bl0,d19) ts sack cubic wscale:7,11 rto:200 rtt:1.177/0.588 ato:200=
 mss:1448 pmtu:1500 rcvmss:1448 advmss:1448 cwnd:10 bytes_received:392784 s=
egs_out:139 segs_in:295 data_segs_in:293 send 98419711bps lastsnd:125850 la=
strcv:55400 lastack:22130 pacing_rate 196839416bps delivered:1 rcv_rtt:0.97=
7 rcv_space:194408 rcv_ssthresh:2896 minrtt:1.177 snd_wnd:64256
>
> 6. The sender remains in the retransmission state. (ss -tnpOHoemi)
>
> ESTAB 0      45104  9.9.6.110:48038 9.9.6.120:11235 users:(("nc",pid=3D13=
49,fd=3D3)) timer:(on,30sec,7) ino:16914 sk:8 cgroup:/ <-> skmem:(r0,rb1310=
72,t0,tb96768,f4048,w86064,o0,bl0,d0) ts sack cubic wscale:11,7 rto:32000 b=
ackoff:7 rtt:49.988/0.047 mss:1448 pmtu:1500 rcvmss:536 advmss:1448 cwnd:1 =
ssthresh:14 bytes_sent:208888 bytes_retrans:13032 bytes_acked:194409 segs_o=
ut:149 segs_in:92 data_segs_out:147 send 231736bps lastsnd:1100 lastrcv:382=
70 lastack:34530 pacing_rate 5839704bps delivery_rate 231944bps delivered:1=
39 busy:38270ms rwnd_limited:38180ms(99.8%) unacked:1 retrans:1/9 lost:1 ds=
ack_dups:1 rcv_space:14480 rcv_ssthresh:64088 notsent:43656 minrtt:0.254 sn=
d_wnd:2048
>
> Tcpdump:
>
> ```
> 51:10.437 S > R: seq 1910971411, win 64240, length 0
> 51:10.438 R > S: seq 2609098178, ack 1910971412, win 65160, length 0
> 51:10.439 S > R: ack 1, win 502, length 0
> 51:10.439 S > R: seq 1:1449, ack 1, win 502, length 1448
> 51:10.439 S > R: seq 1449:2897, ack 1, win 502, length 1448
> 51:10.439 S > R: seq 2897:4345, ack 1, win 502, length 1448
> 51:10.440 R > S: ack 2897, win 31, length 0
> 51:10.440 S > R: seq 4345:5793, ack 1, win 502, length 1448
> 51:10.440 R > S: ack 4345, win 31, length 0
> 51:10.440 S > R: seq 5793:7241, ack 1, win 502, length 1448
> 51:10.440 R > S: ack 7241, win 30, length 0
> <...>
> 51:10.485 S > R: seq 85809:87257, ack 1, win 502, length 1448
> 51:10.527 R > S: ack 87257, win 2, length 0
> 51:10.527 S > R: seq 87257:88705, ack 1, win 502, length 1448
> 51:10.527 S > R: seq 88705:90153, ack 1, win 502, length 1448
> 51:10.577 R > S: ack 90153, win 1, length 0
> 51:10.578 S > R: seq 90153:91601, ack 1, win 502, length 1448
> 51:10.627 R > S: ack 91601, win 1, length 0
> <...>
> 51:14.077 S > R: seq 191513:192961, ack 1, win 502, length 1448
> 51:14.127 R > S: ack 192961, win 1, length 0
> 51:14.127 S > R: seq 192961:194409, ack 1, win 502, length 1448
> 51:14.177 R > S: ack 194409, win 1, length 0
> <rcvbuf full>

I have not seen a "win 0" though...


> 51:14.177 S > R: seq 194409:195857, ack 1, win 502, length 1448
> 51:14.431 S > R: seq 194409:195857, ack 1, win 502, length 1448
> 51:14.691 S > R: seq 194409:195857, ack 1, win 502, length 1448
> 51:15.201 S > R: seq 194409:195857, ack 1, win 502, length 1448
> 51:16.241 S > R: seq 194409:195857, ack 1, win 502, length 1448
> 51:18.321 S > R: seq 194409:195857, ack 1, win 502, length 1448
> 51:22.401 S > R: seq 194409:195857, ack 1, win 502, length 1448
> 51:30.961 S > R: seq 194409:195857, ack 1, win 502, length 1448
> 51:47.601 S > R: seq 194409:195857, ack 1, win 502, length 1448
> <clear rcvbuf>
> 51:51.504 R > S: ack 194409, win 2, length 0
> <retransmission timer timeout>
> 52:20.242 S > R: seq 194409:195857, ack 1, win 502, length 1448
> 52:20.242 R > S: ack 195857, win 3, length 0
> <...>
> 52:20.245 S > R: seq 223369:224817, ack 1, win 502, length 1448
> 52:20.245 R > S: ack 223369, win 30, length 0
> ```
>
> File: xfrm.sh
>
> ```
> if [ "$1" =3D "l" ]; then
>         mode=3Dtunnel
>         daddr=3D9.9.6.110
>         laddr=3D9.9.6.120
>         xdaddr=3D9.9.7.110
>         xladdr=3D9.9.7.120
>         ispi=3D0x20
>         ospi=3D0x10
>         dev=3Dveth0
> elif [ "$1" =3D "r" ]; then
>         mode=3Dtunnel
>         daddr=3D9.9.6.120
>         laddr=3D9.9.6.110
>         xdaddr=3D9.9.7.120
>         xladdr=3D9.9.7.110
>         ispi=3D0x10
>         ospi=3D0x20
>         dev=3Dveth1
> else
>         echo "Usage: $0 <l|r>"
>         exit 1
> fi
>
> ip xfrm state flush
> ip xfrm policy flush
> ip link set $dev up
> ip addr add $laddr/24 dev $dev
> ip link add xfrm0 type xfrm dev $dev if_id 3
> ip link set xfrm0 up
> ip addr add $xladdr/24 dev xfrm0
> ip xfrm state add src $laddr dst $daddr spi $ospi proto esp mode $mode if=
_id 3 aead 'rfc4106(gcm(aes))' 0x856f15d0ccabe682286b4286bccf5d595b88b168 1=
28
> ip xfrm state add src $daddr dst $laddr spi $ispi proto esp mode $mode if=
_id 3 aead 'rfc4106(gcm(aes))' 0x856f15d0ccabe682286b4286bccf5d595b88b168 1=
28
> ip xfrm policy add dir in  tmpl src $daddr dst $laddr proto esp spi $ispi=
 mode $mode if_id 3
> ip xfrm policy add dir out tmpl src $laddr dst $daddr proto esp spi $ospi=
 mode $mode if_id 3
> ```
>
> Signed-off-by: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
> ---
>  net/ipv4/tcp_output.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 0e5b9a654254..61debda90f6d 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2143,6 +2143,9 @@ static bool tcp_snd_wnd_test(const struct tcp_sock =
*tp,
>  {
>         u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
>
> +       if (tp->rx_opt.snd_wscale && (1 << tp->rx_opt.snd_wscale) =3D=3D =
tp->snd_wnd)
> +               return true;

This is not generic.

What if tp->snd_wnd =3D=3D (2 <<  tp->rx_opt.snd_wscale), for wscale =3D=3D=
 10 ?

> +
>         if (skb->len > cur_mss)
>                 end_seq =3D TCP_SKB_CB(skb)->seq + cur_mss;
>
> @@ -2806,7 +2809,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigne=
d int mss_now, int nonagle,
>                 }
>
>                 limit =3D mss_now;
> -               if (tso_segs > 1 && !tcp_urg_mode(tp))
> +               if (!tcp_urg_mode(tp))
>                         limit =3D tcp_mss_split_point(sk, skb, mss_now,
>                                                     cwnd_quota,
>                                                     nonagle);
> --
> 2.34.1

I think you are trying to solve the issue at the sender side, in the
fast path, adding lots of cycles.

While the issue seems to be a receive side one, failing to send a "win
0" at the right time/conditions.

If the last ACK had a "win 1", I fail to see why a packet with length
<=3D 2048 can not be received.

