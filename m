Return-Path: <netdev+bounces-142634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF819BFCE6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD20D281DCC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C4C1119A;
	Thu,  7 Nov 2024 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9WhlYKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F736D
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730949403; cv=none; b=k3iLbLtphscCFv7wCWYNVQHRc+MNt03WHI2eM+WnrhITp43nMPdT1GOfrPuKfWTXCSkxcUOAd1+Z5yQcyJ+AqI2jI5KvJT8q2bhdNzXLZmHMmsxeK8liax6f8kzDAH4iL4FN+zODp4TDQqWL0klytMv0OXsJAzI+S5bPxKJ3zjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730949403; c=relaxed/simple;
	bh=Ykb4jUv44f+R6MN9HsZPTDNmGCQMWcnx2WmgI1buPbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5kz3CfyauTHOZHlk8ZMj05jGpYDfs6ST6XkCZ/PIRrJF4WOJG8DgNzcfcQjQFGy6bFduOVRVFnAUTeTmQPhWCpRXCjebEhTeBe17cqcfQqJZeZV3Ae5eoGQYCzK2qKh/hnhpOL5wsm7dQSkJdgsZtFzJsQ1W41WJz/CSfLuos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9WhlYKC; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a6c1cfcb91so2215605ab.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 19:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730949401; x=1731554201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT5UyjjBCr2mcwbLMixn2ZQvNwv9VyDO5LZLAEbEVF8=;
        b=a9WhlYKCsyciH/E5bxV9fhuejh3F3B2YwyAHZ6H5yenIE0otN5Gy76MXxFVhk1cvKY
         rkkFCW9zeA8EDfn5SJreklcV9+6sT408Jci1/0/v11ZX2uc2bVQVQItU/7VPHRHkulYA
         2fr611tUIVXs14p5ljEiiKxMUdGj/cI3zDS/5OIun5GCY7rybFyyGfW4BFU7Q1486JKY
         F/mexrhsuJLZ28zyNeVSS2yk9MZIfkhwux115eoHO6VQZ6cFd3M4NIJKruubwvTStjGo
         /iEiA709KuoLd9fwCCCLkhWByMYcLockBD6L2AkE7VwVvnU7Qzkydw0RosHiBI15i4xB
         lLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730949401; x=1731554201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aT5UyjjBCr2mcwbLMixn2ZQvNwv9VyDO5LZLAEbEVF8=;
        b=okJ67kJhW4jJZl9D/HfowvRdcJ5fo9KMmMiXSojixjOPC7Tra/LI5XiOwAgAN0ffHc
         dRbkhb32Wwc4+6zulrB90uApap6lNu/i17XOlKnFKXuJe9xOl2F2JZvn/cdjXemF8vPF
         fPNDN+p+iCbvgCAZOhi+IjywX572XNuKZyOFjYWqFcISX492nJ3d2q3O/KPpXAy2W/Fl
         Tv115pLX0EZ0+tXnh4WsMsvNRPVeOkfanCre1lP2AyeJzkHr6t8ncTkSawEgRZLejIg0
         VKMKNFlKDMnKg3GeV3qhY6V7dCxr+C38BgjwXvpUBK3TOsEqUKC5u93ziomzxxgGqa74
         zDMg==
X-Gm-Message-State: AOJu0Yzmcvo9ie1Ipi7kwPbjZYm8B+iVHB+0U6Lt/QZD9z5TXcKaqIy1
	am7m46Bt9Xjc8RIm6+uatujxvvgujt658KGEdE5h2A950ZCo7E+alPSYT0TgrEGd5Fh3H1vNhGA
	EuLzSqtIac41nbtEAND9BFjjzfFfXU4IJ
X-Google-Smtp-Source: AGHT+IGyhjy8yQSkIuZEhAXdEovoFowbze3UQqAndK1JpKZxXDp4mAwsyrHLWiC2FQqAjAk9MqVVsNtigMwOEwhEZQQ=
X-Received: by 2002:a05:6e02:1a4a:b0:3a0:5642:c78 with SMTP id
 e9e14a558f8ab-3a6eb25585emr5149595ab.15.1730949400773; Wed, 06 Nov 2024
 19:16:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
In-Reply-To: <20241105025511.42652-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 11:16:04 +0800
Message-ID: <CAL+tcoB9a7eKzU9sz8AaY0sqeKn9fkK9ejDJkfh9EpdcG17k-w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Tue, Nov 5, 2024 at 10:55=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> We found there are rare chances that some RST packets appear during
> the shakehands because the timewait socket cannot accept the SYN and
> doesn't return TCP_TW_SYN in tcp_timewait_state_process().
>
> Here is how things happen in production:
> Time        Client(A)        Server(B)
> 0s          SYN-->
> ...
> 132s                         <-- FIN
> ...
> 169s        FIN-->
> 169s                         <-- ACK
> 169s        SYN-->
> 169s                         <-- ACK

I noticed the above ACK doesn't adhere to RFC 6191. It says:
"If the previous incarnation of the connection used Timestamps, then:
     if ...
     ...
     * Otherwise, silently drop the incoming SYN segment, thus leaving
         the previous incarnation of the connection in the TIME-WAIT
         state.
"
But the timewait socket sends an ACK because of this code snippet:
tcp_timewait_state_process()
    -> // the checks of SYN packet failed.
    -> if (!th->rst) {
        -> return TCP_TW_ACK; // this line can be traced back to 2005

I think the following patch follows the RFC:
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bb1fe1ba867a..cc22f0412f98 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -231,15 +231,17 @@ tcp_timewait_state_process(struct
inet_timewait_sock *tw, struct sk_buff *skb,
           but not fatal yet.
         */

-       if (th->syn && !th->rst && !th->ack && !paws_reject &&
-           (after(TCP_SKB_CB(skb)->seq, rcv_nxt) ||
-            (tmp_opt.saw_tstamp &&
-             (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0=
))) {
-               u32 isn =3D tcptw->tw_snd_nxt + 65535 + 2;
-               if (isn =3D=3D 0)
-                       isn++;
-               *tw_isn =3D isn;
-               return TCP_TW_SYN;
+       if (th->syn && !th->rst && !th->ack && !paws_reject) {
+               if (after(TCP_SKB_CB(skb)->seq, rcv_nxt) ||
+                   (tmp_opt.saw_tstamp &&
+                    (s32)(READ_ONCE(tcptw->tw_ts_recent) -
tmp_opt.rcv_tsval) < 0)) {
+                       u32 isn =3D tcptw->tw_snd_nxt + 65535 + 2;
+                       if (isn =3D=3D 0)
+                               isn++;
+                       *tw_isn =3D isn;
+                       return TCP_TW_SYN;
+               }
+               return TCP_TW_SUCCESS;
        }

        if (paws_reject)

Could you help me review this, Eric? Thanks in advance!

Thanks,
Jason

> 169s        RST-->
> As above picture shows, the two flows have a start time difference
> of 169 seconds. B starts to send FIN so it will finally enter into
> TIMEWAIT state. Nearly at the same time A launches a new connection
> that soon is reset by itself due to receiving a ACK.
>
> There are two key checks in tcp_timewait_state_process() when timewait
> socket in B receives the SYN packet:
> 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)
>
> Regarding the first rule, it fails as expected because in the first
> connection the seq of SYN sent from A is 1892994276, then 169s have
> passed, the second SYN has 239034613 (caused by overflow of s32).
>
> Then how about the second rule?
> It fails again!
> Let's take a look at how the tsval comes out:
> __tcp_transmit_skb()
>     -> tcp_syn_options()
>         -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) + t=
p->tsoffset;
> The timestamp depends on two things, one is skb->skb_mstamp_ns, the
> other is tp->tsoffset. The latter value is fixed, so we don't need
> to care about it. If both operations (sending FIN and then starting
> sending SYN) from A happen in 1ms, then the tsval would be the same.
> It can be clearly seen in the tcpdump log. Notice that the tsval is
> with millisecond precision.
>
> Based on the above analysis, I decided to make a small change to
> the check in tcp_timewait_state_process() so that the second flow
> would not fail.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp_minisocks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index bb1fe1ba867a..2b29d1bf5ca0 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -234,7 +234,7 @@ tcp_timewait_state_process(struct inet_timewait_sock =
*tw, struct sk_buff *skb,
>         if (th->syn && !th->rst && !th->ack && !paws_reject &&
>             (after(TCP_SKB_CB(skb)->seq, rcv_nxt) ||
>              (tmp_opt.saw_tstamp &&
> -             (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) <=
 0))) {
> +             (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) <=
=3D 0))) {
>                 u32 isn =3D tcptw->tw_snd_nxt + 65535 + 2;
>                 if (isn =3D=3D 0)
>                         isn++;
> --
> 2.37.3
>

