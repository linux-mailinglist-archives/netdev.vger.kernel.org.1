Return-Path: <netdev+bounces-159579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB4AA15EF5
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 22:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4693A63D5
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 21:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D060189BAC;
	Sat, 18 Jan 2025 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxhKeK+B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF91EA6F
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737236394; cv=none; b=gWDLPelM/mQiu8OVQUwlu8ziflcl8D0taflmfldB+ZJACmae6JUGW4qqNnAPZl/bbKjcwh3GYM4daGLeXb7N0vdXN/oXp7cc64vGVEQzbqjdesifpL9m9q7iin+9VmmmCncHH6XEZrRj0Gr4jqjw2MgdkQPWdlsVLLxCKwqi7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737236394; c=relaxed/simple;
	bh=NYeRShtRTmgMIikDKKH/bYH5b7G6u56mWjaeAm+tsaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIRpwOp5nJrqpwjntqTKS3VblQIjcCs5GEvSMZY1Kedb9iNN2rJ3PX/EeIzKCjgiXQLrbJCAKEni0dnPU3bZo5UrDqyBaafWzeV8aDwvf9xviIYhw6KW5oJicomYbyuH2bDGDkRGvMrSEdyu8rg9JKxk3Qm7q9xmM8r3q1YEzWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxhKeK+B; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dce7263beaso30551396d6.3
        for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 13:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737236391; x=1737841191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DisvYTvH+GSSSEIZhkUT3fDMcSRKS57aGtn7bfOXTSM=;
        b=AxhKeK+BCUnZy/PxSSRdudWmDvQn8tMYSAc84TWvie7xu+a62DVweUzcCQd5CBxnnP
         4jjzZN+NJPBtDBdx8bJiCoeY7GqedLoqenv3l8ht1oiPvNLeTfmvWbenEAH1uHv+9TuJ
         cAtCvlmS/bznOjMeF5y6aGrzYMsyoPOsf7gjTmv0F7uA16MrETWcJtp6JHhxOmff83ky
         tZb4sCEGMx7UqTFtJOXHrKuGfEmOn/t6aKxy0BmFgZj9y0kG7lpy4vAW/cCzzXP4jYVa
         EnwzUeVOzspEfkn/XLufk/Lh0Dvdbteb/tmkTVNp+5AS9Bb00dgD6ooqmdO3VK5lM/r7
         6NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737236391; x=1737841191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DisvYTvH+GSSSEIZhkUT3fDMcSRKS57aGtn7bfOXTSM=;
        b=erjk/xCjPqRChmv2M/+tjJc+efZ9fuST4CwPvQ5Iv7KMW3XaxjnJAc6jVHQFsEaPuW
         bHsTycYxuY+z5yEKeP6CdzE4JLDRnXY7zQK6TcA00Y9xtAjPVgstIzV+GxeF5dU2deBL
         ZhkJUPa4gTW7GkqX/lQMHygG+OdRAdt6M+9mJNNdb4SU41mMOcF7iRe9rD8mVViD8jbc
         O4yuGyIIAOTumtPmxDpOabs+JFVZx3Hjd7uGsHkxRkhLxyQsd7nUFja9OabNKbvFbCSl
         nFLuUH28e4DU6fM7fUxKCJGyW2JbT0/QchWDAd6IL8hoS4hwNk8TFpncxj1tRsmHk4GI
         jH+A==
X-Gm-Message-State: AOJu0Yynbh5uieC5n8WM+/hTjqcq7f8SLVGmkc0+xW94pCRc7DtsD5vU
	ubIS6iPSLDEAQsPZrVa4NzDIRT/laljXOBe3Xduukh6Q07yiI2QwUsq7X0r0jFLkYceWGpRQ3q3
	vjaLT/rbcHnA2bXJsukRnL9j6PbI=
X-Gm-Gg: ASbGncu+GdOsAjD2LrBxis26h1LA3qmmXti5xP3nLJB38hPC/k5OkWG1Ut0wfsnlOnG
	m92NCEGe7TUVHCsBbTzJyBv/W2uPkkX632YNFZsKVgDfCp2Pa/hA=
X-Google-Smtp-Source: AGHT+IFjTR9VzdiupmIQDYmqclfg4b1e4AVW8HIoVGzsZl9mgtyy5bEVvwKILa/6UNHAqsy0j+I2xgPgG6Xh474RJcg=
X-Received: by 2002:a05:6214:2f91:b0:6d8:9c92:654a with SMTP id
 6a1803df08f44-6e1b217904dmr153196746d6.10.1737236390831; Sat, 18 Jan 2025
 13:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117192859.28252-1-dzq.aishenghu0@gmail.com> <CANn89i+KDDrP4xOniv6zej4SAjd5SNwR=qfu2f66F-L2+J=ZSw@mail.gmail.com>
In-Reply-To: <CANn89i+KDDrP4xOniv6zej4SAjd5SNwR=qfu2f66F-L2+J=ZSw@mail.gmail.com>
From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Date: Sun, 19 Jan 2025 05:39:39 +0800
X-Gm-Features: AbW1kvZnwG5xfCzdc25RcIfhokVIcVPGAKDNMwn_jQgcbaoVacacEPaXJGnzn9o
Message-ID: <CAFmV8NcGuqz6rrGnM2x8D0JkGmmg6QxqKJNPSWRt+8vpQWuu8A@mail.gmail.com>
Subject: Re: [RFC PATCH] tcp: fill the one wscale sized window to trigger zero
 window advertising
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 3:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Jan 17, 2025 at 8:29=E2=80=AFPM Zhongqiu Duan <dzq.aishenghu0@gma=
il.com> wrote:
> >
> > If the rcvbuf of a slow receiver is full, the packet will be dropped
> > because tcp_try_rmem_schedule() cannot schedule more memory for it.
> > Usually the scaled window size is not MSS aligned. If the receiver
> > advertised a one wscale sized window is in (MSS, 2*MSS), and GSO/TSO is
> > disabled, we need at least two packets to fill it. But the receiver wil=
l
> > not ACK the first one, and also do not offer a zero window since we nev=
er
> > shrink the offered window.
> > The sender waits for the ACK because the send window is not enough for
> > another MSS sized packet, tcp_snd_wnd_test() will return false, and
> > starts the TLP and then the retransmission timer for the first packet
> > until it is ACKed.
> > It may take a long time to resume transmission from retransmission afte=
r
> > the receiver clears the rcvbuf, depends on the times of retransmissions=
.
> >
> > This issue should be rare today as GSO/TSO is a common technology,
> > especially after 0a6b2a1dc2a2 ("tcp: switch to GSO being always on") or
> > commit d0d598ca86bd ("net: remove sk_route_forced_caps").
> > We can reproduce it by reverting commit 0a6b2a1dc2a2 and disabling hw
> > GSO/TSO from nic using ethtool (a). Or enabling MD5SIG (b).
> >
> > Force split a large packet and send it to fill the window so that the
> > receiver can offer a zero window if he want.
> >
> > Reproduce:
> >
> > 1. Set a large number for net.core.rmem_max on the RECV side to provide
> >    a large wscale value of 11, which will provide a 2048 window larger
> >    than the normal MSS 1448.
> >    Set a slightly lower value for net.ipv4.tcp_rmem on the RECV side to
> >    quickly trigger the problem. (optional)
> >
> >    sysctl net.core.rmem_max=3D67108864
> >    sysctl net.ipv4.tcp_rmem=3D"4096 131072 262144"
> >
> > 2. (a) Build customized kernel with 0a6b2a1dc2a2 reverted and disabling
> >    the GSO/TSO of nic on the SEND side.
> >    (b) Or setup the xfrm tunnel with esp proto and aead rfc4106(gcm(aes=
))
> >    algo. (Namespace and veth is okay, helper xfrm.sh is at the end.)
> >
> > 3. Start the receiver but don't receive. (netcat-bsd with MD5SIG suppor=
t)
> >    (a) nc -l -p 11235
> >    (b) nc -l -p 11235 -S
> >
> > 4. Send.
> >    (a) nc 9.9.6.110 11235 <bigdata
> >    (b) nc -S 9.9.7.110 11235 <bigdata
> >
> > 5. After tens of seconds, the receiver clears the rcvbuf. (ss -tnpOHoem=
i)
> >
> > ESTAB 0      0      9.9.6.120:11235 9.9.6.110:48038 users:(("nc",pid=3D=
1380,fd=3D4)) ino:19894 sk:c cgroup:/ <-> skmem:(r0,rb262144,t0,tb46080,f26=
6240,w0,o0,bl0,d19) ts sack cubic wscale:7,11 rto:200 rtt:1.177/0.588 ato:2=
00 mss:1448 pmtu:1500 rcvmss:1448 advmss:1448 cwnd:10 bytes_received:392784=
 segs_out:139 segs_in:295 data_segs_in:293 send 98419711bps lastsnd:125850 =
lastrcv:55400 lastack:22130 pacing_rate 196839416bps delivered:1 rcv_rtt:0.=
977 rcv_space:194408 rcv_ssthresh:2896 minrtt:1.177 snd_wnd:64256
> >
> > 6. The sender remains in the retransmission state. (ss -tnpOHoemi)
> >
> > ESTAB 0      45104  9.9.6.110:48038 9.9.6.120:11235 users:(("nc",pid=3D=
1349,fd=3D3)) timer:(on,30sec,7) ino:16914 sk:8 cgroup:/ <-> skmem:(r0,rb13=
1072,t0,tb96768,f4048,w86064,o0,bl0,d0) ts sack cubic wscale:11,7 rto:32000=
 backoff:7 rtt:49.988/0.047 mss:1448 pmtu:1500 rcvmss:536 advmss:1448 cwnd:=
1 ssthresh:14 bytes_sent:208888 bytes_retrans:13032 bytes_acked:194409 segs=
_out:149 segs_in:92 data_segs_out:147 send 231736bps lastsnd:1100 lastrcv:3=
8270 lastack:34530 pacing_rate 5839704bps delivery_rate 231944bps delivered=
:139 busy:38270ms rwnd_limited:38180ms(99.8%) unacked:1 retrans:1/9 lost:1 =
dsack_dups:1 rcv_space:14480 rcv_ssthresh:64088 notsent:43656 minrtt:0.254 =
snd_wnd:2048
> >
> > Tcpdump:
> >
> > ```
> > 51:10.437 S > R: seq 1910971411, win 64240, length 0
> > 51:10.438 R > S: seq 2609098178, ack 1910971412, win 65160, length 0
> > 51:10.439 S > R: ack 1, win 502, length 0
> > 51:10.439 S > R: seq 1:1449, ack 1, win 502, length 1448
> > 51:10.439 S > R: seq 1449:2897, ack 1, win 502, length 1448
> > 51:10.439 S > R: seq 2897:4345, ack 1, win 502, length 1448
> > 51:10.440 R > S: ack 2897, win 31, length 0
> > 51:10.440 S > R: seq 4345:5793, ack 1, win 502, length 1448
> > 51:10.440 R > S: ack 4345, win 31, length 0
> > 51:10.440 S > R: seq 5793:7241, ack 1, win 502, length 1448
> > 51:10.440 R > S: ack 7241, win 30, length 0
> > <...>
> > 51:10.485 S > R: seq 85809:87257, ack 1, win 502, length 1448
> > 51:10.527 R > S: ack 87257, win 2, length 0
> > 51:10.527 S > R: seq 87257:88705, ack 1, win 502, length 1448
> > 51:10.527 S > R: seq 88705:90153, ack 1, win 502, length 1448
> > 51:10.577 R > S: ack 90153, win 1, length 0
> > 51:10.578 S > R: seq 90153:91601, ack 1, win 502, length 1448
> > 51:10.627 R > S: ack 91601, win 1, length 0
> > <...>
> > 51:14.077 S > R: seq 191513:192961, ack 1, win 502, length 1448
> > 51:14.127 R > S: ack 192961, win 1, length 0
> > 51:14.127 S > R: seq 192961:194409, ack 1, win 502, length 1448
> > 51:14.177 R > S: ack 194409, win 1, length 0
> > <rcvbuf full>
>
> I have not seen a "win 0" though...
>
>
> > 51:14.177 S > R: seq 194409:195857, ack 1, win 502, length 1448
> > 51:14.431 S > R: seq 194409:195857, ack 1, win 502, length 1448
> > 51:14.691 S > R: seq 194409:195857, ack 1, win 502, length 1448
> > 51:15.201 S > R: seq 194409:195857, ack 1, win 502, length 1448
> > 51:16.241 S > R: seq 194409:195857, ack 1, win 502, length 1448
> > 51:18.321 S > R: seq 194409:195857, ack 1, win 502, length 1448
> > 51:22.401 S > R: seq 194409:195857, ack 1, win 502, length 1448
> > 51:30.961 S > R: seq 194409:195857, ack 1, win 502, length 1448
> > 51:47.601 S > R: seq 194409:195857, ack 1, win 502, length 1448
> > <clear rcvbuf>
> > 51:51.504 R > S: ack 194409, win 2, length 0
> > <retransmission timer timeout>
> > 52:20.242 S > R: seq 194409:195857, ack 1, win 502, length 1448
> > 52:20.242 R > S: ack 195857, win 3, length 0
> > <...>
> > 52:20.245 S > R: seq 223369:224817, ack 1, win 502, length 1448
> > 52:20.245 R > S: ack 223369, win 30, length 0
> > ```
> >
> > File: xfrm.sh
> >
> > ```
> > if [ "$1" =3D "l" ]; then
> >         mode=3Dtunnel
> >         daddr=3D9.9.6.110
> >         laddr=3D9.9.6.120
> >         xdaddr=3D9.9.7.110
> >         xladdr=3D9.9.7.120
> >         ispi=3D0x20
> >         ospi=3D0x10
> >         dev=3Dveth0
> > elif [ "$1" =3D "r" ]; then
> >         mode=3Dtunnel
> >         daddr=3D9.9.6.120
> >         laddr=3D9.9.6.110
> >         xdaddr=3D9.9.7.120
> >         xladdr=3D9.9.7.110
> >         ispi=3D0x10
> >         ospi=3D0x20
> >         dev=3Dveth1
> > else
> >         echo "Usage: $0 <l|r>"
> >         exit 1
> > fi
> >
> > ip xfrm state flush
> > ip xfrm policy flush
> > ip link set $dev up
> > ip addr add $laddr/24 dev $dev
> > ip link add xfrm0 type xfrm dev $dev if_id 3
> > ip link set xfrm0 up
> > ip addr add $xladdr/24 dev xfrm0
> > ip xfrm state add src $laddr dst $daddr spi $ospi proto esp mode $mode =
if_id 3 aead 'rfc4106(gcm(aes))' 0x856f15d0ccabe682286b4286bccf5d595b88b168=
 128
> > ip xfrm state add src $daddr dst $laddr spi $ispi proto esp mode $mode =
if_id 3 aead 'rfc4106(gcm(aes))' 0x856f15d0ccabe682286b4286bccf5d595b88b168=
 128
> > ip xfrm policy add dir in  tmpl src $daddr dst $laddr proto esp spi $is=
pi mode $mode if_id 3
> > ip xfrm policy add dir out tmpl src $laddr dst $daddr proto esp spi $os=
pi mode $mode if_id 3
> > ```
> >
> > Signed-off-by: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
> > ---
> >  net/ipv4/tcp_output.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 0e5b9a654254..61debda90f6d 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -2143,6 +2143,9 @@ static bool tcp_snd_wnd_test(const struct tcp_soc=
k *tp,
> >  {
> >         u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
> >
> > +       if (tp->rx_opt.snd_wscale && (1 << tp->rx_opt.snd_wscale) =3D=
=3D tp->snd_wnd)
> > +               return true;
>
> This is not generic.
>
> What if tp->snd_wnd =3D=3D (2 <<  tp->rx_opt.snd_wscale), for wscale =3D=
=3D 10 ?
>

Hi Eric,

Thank you for your attention.

I think it must be 1-wnd in the end, nothing about wscale here.

This is a mistake, I should at least consider snd_una in.

> > +
> >         if (skb->len > cur_mss)
> >                 end_seq =3D TCP_SKB_CB(skb)->seq + cur_mss;
> >
> > @@ -2806,7 +2809,7 @@ static bool tcp_write_xmit(struct sock *sk, unsig=
ned int mss_now, int nonagle,
> >                 }
> >
> >                 limit =3D mss_now;
> > -               if (tso_segs > 1 && !tcp_urg_mode(tp))
> > +               if (!tcp_urg_mode(tp))
> >                         limit =3D tcp_mss_split_point(sk, skb, mss_now,
> >                                                     cwnd_quota,
> >                                                     nonagle);
> > --
> > 2.34.1
>
> I think you are trying to solve the issue at the sender side, in the
> fast path, adding lots of cycles.
>
> While the issue seems to be a receive side one, failing to send a "win
> 0" at the right time/conditions.
>
> If the last ACK had a "win 1", I fail to see why a packet with length
> <=3D 2048 can not be received.

Let me try to describe it a little more clearly.

With window scaling disabled, the receiver can gradually shrink the
window to less than MSS and then wait for the last packet to close the
window. Or, if lucky, shrink the window directly to zero. Although
tcp_write_xmit() will not send the last MSS sized packet since
tcp_snd_wnd_test() does not allow it, but no packet was not ACKed,
and tcp_send_probe0() will send a partial packet to fill the gap later.
So the receiver can always close its receive window.

If window scaling is enabled and the scaled send window is larger than
N*MSS, the receiver will advertise a 1-wnd at the end. We need at least
two packets to close the window. But all the packets before the last one
will not be ACKed because tcp_try_rmem_schedule() cannot schedule more
memory, and tcp_snd_wnd_test() does not allow us to send the last packet
beyond the window. The sender entered retransmit.

So let us send the partial packet to fill the 1-wnd gap when wscale is on.

I don't know if I described it clearly, and how about this below ?

Best regards,
Zhongqiu

---
 net/ipv4/tcp_output.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0e5b9a654254..28b814e42121 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2139,14 +2139,25 @@ static inline bool tcp_nagle_test(const struct
tcp_sock *tp, const struct sk_buf
 /* Does at least the first segment of SKB fit into the send window? */
 static bool tcp_snd_wnd_test(const struct tcp_sock *tp,
                             const struct sk_buff *skb,
-                            unsigned int cur_mss)
+                            unsigned int cur_mss,
+                            bool *need_split)
 {
        u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
+       bool ret;

        if (skb->len > cur_mss)
                end_seq =3D TCP_SKB_CB(skb)->seq + cur_mss;

-       return !after(end_seq, tcp_wnd_end(tp));
+       ret =3D !after(end_seq, tcp_wnd_end(tp));
+
+       if (!ret && tp->rx_opt.snd_wscale &&
+           before(TCP_SKB_CB(skb)->seq, tcp_wnd_end(tp))) {
+               if (need_split)
+                       *need_split =3D true;
+               ret =3D true;
+       }
+
+       return ret;
 }

 /* Trim TSO SKB to LEN bytes, put the remaining data into a new packet
@@ -2760,6 +2771,7 @@ static bool tcp_write_xmit(struct sock *sk,
unsigned int mss_now, int nonagle,
        while ((skb =3D tcp_send_head(sk))) {
                unsigned int limit;
                int missing_bytes;
+               bool need_split =3D false;

                if (unlikely(tp->repair) && tp->repair_queue =3D=3D
TCP_SEND_QUEUE) {
                        /* "skb_mstamp_ns" is used as a start point
for the retransmit timer */
@@ -2788,7 +2800,7 @@ static bool tcp_write_xmit(struct sock *sk,
unsigned int mss_now, int nonagle,

                tso_segs =3D tcp_set_skb_tso_segs(skb, mss_now);

-               if (unlikely(!tcp_snd_wnd_test(tp, skb, mss_now))) {
+               if (unlikely(!tcp_snd_wnd_test(tp, skb, mss_now,
&need_split))) {
                        is_rwnd_limited =3D true;
                        break;
                }
@@ -2806,7 +2818,7 @@ static bool tcp_write_xmit(struct sock *sk,
unsigned int mss_now, int nonagle,
                }

                limit =3D mss_now;
-               if (tso_segs > 1 && !tcp_urg_mode(tp))
+               if ((tso_segs > 1 || need_split) && !tcp_urg_mode(tp))
                        limit =3D tcp_mss_split_point(sk, skb, mss_now,
                                                    cwnd_quota,
                                                    nonagle);
@@ -2947,7 +2959,7 @@ void tcp_send_loss_probe(struct sock *sk)

        tp->tlp_retrans =3D 0;
        skb =3D tcp_send_head(sk);
-       if (skb && tcp_snd_wnd_test(tp, skb, mss)) {
+       if (skb && tcp_snd_wnd_test(tp, skb, mss, NULL)) {
                pcount =3D tp->packets_out;
                tcp_write_xmit(sk, mss, TCP_NAGLE_OFF, 2, GFP_ATOMIC);
                if (tp->packets_out > pcount)

