Return-Path: <netdev+bounces-233986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E486C1B7BC
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B17266783B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6059B244687;
	Wed, 29 Oct 2025 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cc3W224A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F91C358D18
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745387; cv=none; b=RCHHtiU2yhAfQMobZt1tE2bi4lARmegbX7ZC7HQaSg150Jrl7l+15KulKQ3jfLsfo9lRiYfiwAKB1xueaOz5ExpeVlKto4rHkespIAcuKUTVLl33IQ59GkBs12rRgicsy/ESEM2eQfwwjW5VsBbAZL+khv3nMI8Ecn+ykUmzKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745387; c=relaxed/simple;
	bh=7soHO9LaDuEcrh4CS1BaPHwK4b5qra2+PXKb/ErM4yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7UJSUrAVnF8P4+Uhs0LSh3Mn6m3WG73YsMYo13fzlMQXf5v79uMagk8cvpLcHKkynKIrar2g+rQUcaSX0iCvR3oY0T/x8s6YzNgN0zPZApNXZ3DCdpx6h/pzN1bIlH6vV7K1otcRQNIeefifLX2PBsQrTp6KNHTMzpeA+aP0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cc3W224A; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso353501cf.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761745384; x=1762350184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Efu2b3TBu5wmyvdmKqEZLni7Qy5XpG2TvGkeSVZD7U=;
        b=Cc3W224AD44KJBeEM78txSo9nLY73PuEAFQATv4j7s+oL+/xXZpU451jHAKhtbu3fY
         7dXQaT9o/8MRCg66JQKf00AC1kTko5iJmLtBaIz32XMgXpI7WFvMxd1eCR5yE6ndgD+L
         EXkwpoPBGS657HViQEVgxC31U/3JB4EVeH0h/tcm6bUKDtjKecSoE+N5yxfN4aO4g4tt
         Om4FSlZV9gP6JgNLnNagLaH+jYaxxgvo5Qa4il7KgX3iJWMHhHbJTz8X+UP43LKDF2lo
         Iumbt9zE6N1YUWgvKG9btpkOFlSYibpWaPiLvb88tiO28Y9pUx+Ov0GglpNSKfSfUYW+
         zWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745384; x=1762350184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Efu2b3TBu5wmyvdmKqEZLni7Qy5XpG2TvGkeSVZD7U=;
        b=oy+YGz5Rox9nJGi9TWQKsOQDErgiUZl5ZYcqF9fF4rQsLvoJcJFuNe4iJ/noOlOfjC
         +26AojQBfYy0PInQFU9o5WUUJCFqrWsDcz5ZV2swhVGWzBsmUkr+1UgYviDvjaKVXNmq
         FbL84824qxZezRk4dif0yJnWaRybobC8NAuuEeGILCyqn39kvN6yYlF34zBQOpfw7Yjn
         wm6kk2p0NNFIVWcb2wFPnEXjBj1JHORrg6LuFt8JTOWW4ti11joZ8ED+sWnfNrtfdIk+
         AN3TJ+ZSKfnaGGD6wMcc2d0Ul8mnWdBwEbk2ZHWwD+MuZ1U+AOAbFKNFUhIvLjQJqeNt
         BEYw==
X-Forwarded-Encrypted: i=1; AJvYcCUZC+0FBr8K3zLBHEWIg+itJFHabl0GdLx9DouqrSGtm2em2j49QvcHtGsEFnESuHEsyrz17w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTt6NDvd7/y+L7MeCaKI228EG/ipcNiUq1oTRZpsTxPR2O01fC
	Eqjpn955sTMDIgcbZf9Gck5EIDUdGUGwu1G/44Wl/BdWY8rcF7HrJLdEAwKiCmXw1E7mxoNU+vv
	q2KGF5kP3WwObvJrrmLh7mG7+GY1oaFplBMJ330Qi
X-Gm-Gg: ASbGncuKNnwpMJpRBkq5IzgwqfXtCB2T4bjHcy0vcX58ZEZYHhAVM0h2WQPi+GzGrqy
	d5us9rEYGi1QhFZvdm1Z+BkcqtdYUI+kVK9Fi9+7yPlglQbID0J4NX1zgUnKxG3WxMcWL4P80zV
	KM0lJENTdoXqd5ULP59JSgUlZWJbjm4zVevPzYwtv9kgEtAeEkzmkP4Iy415iCfeRaIIQE8y8XE
	lVHM3Mk3E7UDEunB/hMqXug7SZyA2BBIzRLlnuLaALMUzXTxyMs9w47yjK2HEyWt1cqSq+mmU1v
	YYROji2nIXjU85TpzGcldpYLU7YTAV/BTP1R8UZG6OwAyllzpQ==
X-Google-Smtp-Source: AGHT+IFep33ARYzlPHTxdEMcSpa5nOb5jyduzTR8U+HMJiuH9EhqsySS+kqdMKz2s3RAh8Z2dflJHLBxW9htAh56QOQ=
X-Received: by 2002:a05:622a:4d99:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-4ed1657e9f6mr6357411cf.7.1761745383809; Wed, 29 Oct 2025
 06:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org> <20251028-net-tcp-recv-autotune-v3-4-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-4-74b43ba4c84c@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 29 Oct 2025 09:42:46 -0400
X-Gm-Features: AWmQ_blM3nXt0K4DkE9fj5uTx0bD3zz8OQN-MjU7m93BFU5U1NDhs27rt6_9h4A
Message-ID: <CADVnQykUuOTK2M5LfkzvBNU+_tPLQj=8e2sm4EdVyzfktohuZQ@mail.gmail.com>
Subject: Re: [PATCH net v3 4/4] tcp: fix too slow tcp_rcvbuf_grow() action
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:58=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> While the blamed commits apparently avoided an overshoot,
> they also limited how fast a sender can increase BDP at each RTT.
>
> This is not exactly a revert, we do not add the 16 * tp->advmss
> cushion we had, and we are keeping the out_of_order_queue
> contribution.
>
> Do the same in mptcp_rcvbuf_grow().
>
> Tested:
>
> emulated 50ms rtt (tcp_stream --tcp-tx-delay 50000), cubic 20 second flow=
.
> net.ipv4.tcp_rmem set to "4096 131072 67000000"
>
> perf record -a -e tcp:tcp_rcvbuf_grow sleep 20
> perf script
>
> Before:
>
> We can see we fail to roughly double RWIN at each RTT.
> Sender is RWIN limited while CWND is ramping up (before getting tcp_wmem
> limited).
>
> tcp_stream 33793 [010]  825.717525: tcp:tcp_rcvbuf_grow: time=3D100869 rt=
t_us=3D50428 copied=3D49152 inq=3D0 space=3D40960 ooo=3D0 scaling_ratio=3D2=
19 rcvbuf=3D131072 rcv_ssthresh=3D103970 window_clamp=3D112128 rcv_wnd=3D10=
6496
> tcp_stream 33793 [010]  825.768966: tcp:tcp_rcvbuf_grow: time=3D51447 rtt=
_us=3D50362 copied=3D86016 inq=3D0 space=3D49152 ooo=3D0 scaling_ratio=3D21=
9 rcvbuf=3D131072 rcv_ssthresh=3D107474 window_clamp=3D112128 rcv_wnd=3D106=
496
> tcp_stream 33793 [010]  825.821539: tcp:tcp_rcvbuf_grow: time=3D52577 rtt=
_us=3D50243 copied=3D114688 inq=3D0 space=3D86016 ooo=3D0 scaling_ratio=3D2=
19 rcvbuf=3D201096 rcv_ssthresh=3D167377 window_clamp=3D172031 rcv_wnd=3D16=
7936
> tcp_stream 33793 [010]  825.871781: tcp:tcp_rcvbuf_grow: time=3D50248 rtt=
_us=3D50237 copied=3D167936 inq=3D0 space=3D114688 ooo=3D0 scaling_ratio=3D=
219 rcvbuf=3D268129 rcv_ssthresh=3D224722 window_clamp=3D229375 rcv_wnd=3D2=
25280
> tcp_stream 33793 [010]  825.922475: tcp:tcp_rcvbuf_grow: time=3D50698 rtt=
_us=3D50183 copied=3D241664 inq=3D0 space=3D167936 ooo=3D0 scaling_ratio=3D=
219 rcvbuf=3D392617 rcv_ssthresh=3D331217 window_clamp=3D335871 rcv_wnd=3D3=
23584
> tcp_stream 33793 [010]  825.973326: tcp:tcp_rcvbuf_grow: time=3D50855 rtt=
_us=3D50213 copied=3D339968 inq=3D0 space=3D241664 ooo=3D0 scaling_ratio=3D=
219 rcvbuf=3D564986 rcv_ssthresh=3D478674 window_clamp=3D483327 rcv_wnd=3D4=
62848
> tcp_stream 33793 [010]  826.023970: tcp:tcp_rcvbuf_grow: time=3D50647 rtt=
_us=3D50248 copied=3D491520 inq=3D0 space=3D339968 ooo=3D0 scaling_ratio=3D=
219 rcvbuf=3D794811 rcv_ssthresh=3D671778 window_clamp=3D679935 rcv_wnd=3D6=
51264
> tcp_stream 33793 [010]  826.074612: tcp:tcp_rcvbuf_grow: time=3D50648 rtt=
_us=3D50227 copied=3D700416 inq=3D0 space=3D491520 ooo=3D0 scaling_ratio=3D=
219 rcvbuf=3D1149124 rcv_ssthresh=3D974881 window_clamp=3D983039 rcv_wnd=3D=
942080
> tcp_stream 33793 [010]  826.125452: tcp:tcp_rcvbuf_grow: time=3D50845 rtt=
_us=3D50225 copied=3D987136 inq=3D8192 space=3D700416 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D1637502 rcv_ssthresh=3D1392674 window_clamp=3D1400831 rcv_w=
nd=3D1339392
> tcp_stream 33793 [010]  826.175698: tcp:tcp_rcvbuf_grow: time=3D50250 rtt=
_us=3D50198 copied=3D1347584 inq=3D0 space=3D978944 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D2288672 rcv_ssthresh=3D1949729 window_clamp=3D1957887 rcv_w=
nd=3D1945600
> tcp_stream 33793 [010]  826.225947: tcp:tcp_rcvbuf_grow: time=3D50252 rtt=
_us=3D50240 copied=3D1945600 inq=3D0 space=3D1347584 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D3150516 rcv_ssthresh=3D2687010 window_clamp=3D2695167 rcv_w=
nd=3D2691072
> tcp_stream 33793 [010]  826.276175: tcp:tcp_rcvbuf_grow: time=3D50233 rtt=
_us=3D50224 copied=3D2691072 inq=3D0 space=3D1945600 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D4548617 rcv_ssthresh=3D3883041 window_clamp=3D3891199 rcv_w=
nd=3D3887104
> tcp_stream 33793 [010]  826.326403: tcp:tcp_rcvbuf_grow: time=3D50233 rtt=
_us=3D50229 copied=3D3887104 inq=3D0 space=3D2691072 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D6291456 rcv_ssthresh=3D5370482 window_clamp=3D5382144 rcv_w=
nd=3D5373952
> tcp_stream 33793 [010]  826.376723: tcp:tcp_rcvbuf_grow: time=3D50323 rtt=
_us=3D50218 copied=3D5373952 inq=3D0 space=3D3887104 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D9087658 rcv_ssthresh=3D7755537 window_clamp=3D7774207 rcv_w=
nd=3D7757824
> tcp_stream 33793 [010]  826.426991: tcp:tcp_rcvbuf_grow: time=3D50274 rtt=
_us=3D50196 copied=3D7757824 inq=3D180224 space=3D5373952 ooo=3D0 scaling_r=
atio=3D219 rcvbuf=3D12563759 rcv_ssthresh=3D10729233 window_clamp=3D1074790=
3 rcv_wnd=3D10575872
> tcp_stream 33793 [010]  826.477229: tcp:tcp_rcvbuf_grow: time=3D50241 rtt=
_us=3D50078 copied=3D10731520 inq=3D180224 space=3D7577600 ooo=3D0 scaling_=
ratio=3D219 rcvbuf=3D17715667 rcv_ssthresh=3D15136529 window_clamp=3D151551=
99 rcv_wnd=3D14983168
> tcp_stream 33793 [010]  826.527482: tcp:tcp_rcvbuf_grow: time=3D50258 rtt=
_us=3D50153 copied=3D15138816 inq=3D360448 space=3D10551296 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D24667870 rcv_ssthresh=3D21073410 window_clamp=3D21102=
591 rcv_wnd=3D20766720
> tcp_stream 33793 [010]  826.577712: tcp:tcp_rcvbuf_grow: time=3D50234 rtt=
_us=3D50228 copied=3D21073920 inq=3D0 space=3D14778368 ooo=3D0 scaling_rati=
o=3D219 rcvbuf=3D34550339 rcv_ssthresh=3D29517041 window_clamp=3D29556735 r=
cv_wnd=3D29519872
> tcp_stream 33793 [010]  826.627982: tcp:tcp_rcvbuf_grow: time=3D50275 rtt=
_us=3D50220 copied=3D29519872 inq=3D540672 space=3D21073920 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D49268707 rcv_ssthresh=3D42090625 window_clamp=3D42147=
839 rcv_wnd=3D41627648
> tcp_stream 33793 [010]  826.678274: tcp:tcp_rcvbuf_grow: time=3D50296 rtt=
_us=3D50185 copied=3D42053632 inq=3D761856 space=3D28979200 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57238168 window_clamp=3D57316=
406 rcv_wnd=3D56606720
> tcp_stream 33793 [010]  826.728627: tcp:tcp_rcvbuf_grow: time=3D50357 rtt=
_us=3D50128 copied=3D43913216 inq=3D851968 space=3D41291776 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D57316=
406 rcv_wnd=3D56524800
> tcp_stream 33793 [010]  827.131364: tcp:tcp_rcvbuf_grow: time=3D50239 rtt=
_us=3D50127 copied=3D43843584 inq=3D655360 space=3D43061248 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D57316=
406 rcv_wnd=3D56696832
> tcp_stream 33793 [010]  827.181613: tcp:tcp_rcvbuf_grow: time=3D50254 rtt=
_us=3D50115 copied=3D43843584 inq=3D524288 space=3D43188224 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D57316=
406 rcv_wnd=3D56807424
> tcp_stream 33793 [010]  828.339635: tcp:tcp_rcvbuf_grow: time=3D50283 rtt=
_us=3D50110 copied=3D43843584 inq=3D458752 space=3D43319296 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D57316=
406 rcv_wnd=3D56864768
> tcp_stream 33793 [010]  828.440350: tcp:tcp_rcvbuf_grow: time=3D50404 rtt=
_us=3D50099 copied=3D43843584 inq=3D393216 space=3D43384832 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D57316=
406 rcv_wnd=3D56922112
> tcp_stream 33793 [010]  829.195106: tcp:tcp_rcvbuf_grow: time=3D50154 rtt=
_us=3D50077 copied=3D43843584 inq=3D196608 space=3D43450368 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D57316=
406 rcv_wnd=3D57090048
>
> After:
>
> It takes few steps to increase RWIN. Sender is no longer RWIN limited.
>
> tcp_stream 50826 [010]  935.634212: tcp:tcp_rcvbuf_grow: time=3D100788 rt=
t_us=3D50315 copied=3D49152 inq=3D0 space=3D40960 ooo=3D0 scaling_ratio=3D2=
19 rcvbuf=3D131072 rcv_ssthresh=3D103970 window_clamp=3D112128 rcv_wnd=3D10=
6496
> tcp_stream 50826 [010]  935.685642: tcp:tcp_rcvbuf_grow: time=3D51437 rtt=
_us=3D50361 copied=3D86016 inq=3D0 space=3D49152 ooo=3D0 scaling_ratio=3D21=
9 rcvbuf=3D160875 rcv_ssthresh=3D132969 window_clamp=3D137623 rcv_wnd=3D131=
072
> tcp_stream 50826 [010]  935.738299: tcp:tcp_rcvbuf_grow: time=3D52660 rtt=
_us=3D50256 copied=3D139264 inq=3D0 space=3D86016 ooo=3D0 scaling_ratio=3D2=
19 rcvbuf=3D502741 rcv_ssthresh=3D411497 window_clamp=3D430079 rcv_wnd=3D41=
3696
> tcp_stream 50826 [010]  935.788544: tcp:tcp_rcvbuf_grow: time=3D50249 rtt=
_us=3D50233 copied=3D307200 inq=3D0 space=3D139264 ooo=3D0 scaling_ratio=3D=
219 rcvbuf=3D728690 rcv_ssthresh=3D618717 window_clamp=3D623371 rcv_wnd=3D6=
18496
> tcp_stream 50826 [010]  935.838796: tcp:tcp_rcvbuf_grow: time=3D50258 rtt=
_us=3D50202 copied=3D618496 inq=3D0 space=3D307200 ooo=3D0 scaling_ratio=3D=
219 rcvbuf=3D2450338 rcv_ssthresh=3D1855709 window_clamp=3D2096187 rcv_wnd=
=3D1859584
> tcp_stream 50826 [010]  935.889140: tcp:tcp_rcvbuf_grow: time=3D50347 rtt=
_us=3D50166 copied=3D1261568 inq=3D0 space=3D618496 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D4376503 rcv_ssthresh=3D3725291 window_clamp=3D3743961 rcv_w=
nd=3D3706880
> tcp_stream 50826 [010]  935.939435: tcp:tcp_rcvbuf_grow: time=3D50300 rtt=
_us=3D50185 copied=3D2478080 inq=3D24576 space=3D1261568 ooo=3D0 scaling_ra=
tio=3D219 rcvbuf=3D9082648 rcv_ssthresh=3D7733731 window_clamp=3D7769921 rc=
v_wnd=3D7692288
> tcp_stream 50826 [010]  935.989681: tcp:tcp_rcvbuf_grow: time=3D50251 rtt=
_us=3D50221 copied=3D4915200 inq=3D114688 space=3D2453504 ooo=3D0 scaling_r=
atio=3D219 rcvbuf=3D16574936 rcv_ssthresh=3D14108110 window_clamp=3D1417933=
9 rcv_wnd=3D14024704
> tcp_stream 50826 [010]  936.039967: tcp:tcp_rcvbuf_grow: time=3D50289 rtt=
_us=3D50279 copied=3D9830400 inq=3D114688 space=3D4800512 ooo=3D0 scaling_r=
atio=3D219 rcvbuf=3D32695050 rcv_ssthresh=3D27896187 window_clamp=3D2796959=
3 rcv_wnd=3D27815936
> tcp_stream 50826 [010]  936.090172: tcp:tcp_rcvbuf_grow: time=3D50211 rtt=
_us=3D50200 copied=3D19841024 inq=3D114688 space=3D9715712 ooo=3D0 scaling_=
ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57245176 window_clamp=3D573164=
06 rcv_wnd=3D57163776
> tcp_stream 50826 [010]  936.140430: tcp:tcp_rcvbuf_grow: time=3D50262 rtt=
_us=3D50197 copied=3D39501824 inq=3D114688 space=3D19726336 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57245176 window_clamp=3D57316=
406 rcv_wnd=3D57163776
> tcp_stream 50826 [010]  936.190527: tcp:tcp_rcvbuf_grow: time=3D50101 rtt=
_us=3D50071 copied=3D43655168 inq=3D262144 space=3D39387136 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57259192 window_clamp=3D57316=
406 rcv_wnd=3D57032704
> tcp_stream 50826 [010]  936.240719: tcp:tcp_rcvbuf_grow: time=3D50197 rtt=
_us=3D50057 copied=3D43843584 inq=3D262144 space=3D43393024 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57259192 window_clamp=3D57316=
406 rcv_wnd=3D57032704
> tcp_stream 50826 [010]  936.341271: tcp:tcp_rcvbuf_grow: time=3D50297 rtt=
_us=3D50123 copied=3D43843584 inq=3D131072 space=3D43581440 ooo=3D0 scaling=
_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57259192 window_clamp=3D57316=
406 rcv_wnd=3D57147392
> tcp_stream 50826 [010]  936.642503: tcp:tcp_rcvbuf_grow: time=3D50131 rtt=
_us=3D50084 copied=3D43843584 inq=3D0 space=3D43712512 ooo=3D0 scaling_rati=
o=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57259192 window_clamp=3D57316406 r=
cv_wnd=3D57262080
>
> Fixes: 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
> Fixes: e118cdc34dd1 ("mptcp: rcvbuf auto-tuning improvement")
> Reported-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/589
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric and Matthieu!

neal

