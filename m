Return-Path: <netdev+bounces-232604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FAEC07068
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5357E1C258A3
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32EF3191D8;
	Fri, 24 Oct 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYx/AKPw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A722A313552
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320556; cv=none; b=V8mJEQD8DJlIvmYGhrkdwB+NhE8T4Q+BFkL3RUop6dNqyjAIqWJoJSQcWznZGDkvtIt+nrKGnXDmUo7v/YBeqI96IDm9w7YV1heSpMvaJ30h+hTSWOc/4r40qX4OOwE4mfZpRuAR6rhtn+8p04EpkZN6IS9TWp4tKPmJ67hj2v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320556; c=relaxed/simple;
	bh=geaxphpgZMYezesD1k4vttOMq1EmLFkTymesQAlOWOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNFAQDBeZQg0eKRtBlhsk50xtaJKn6RMjwepLAFdPIEuLVSsHOAch90uzBzIlrzK6+19U1stdWZH/ONZEgZC3rZjTw539ia5a04uWCJmrjIiToH6rC6Q8T9oTbZgXDP32vCMSLsCHI7Jh9sui2Cvv6mPpSHc03qRvnqCwEu/IpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYx/AKPw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109c6b9fcso20097661cf.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761320553; x=1761925353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXT8x9qzusyXEWglBo/xXgOU7ANwZgarpkTFXeSrsiE=;
        b=oYx/AKPwHUxDpU8LLLolCmMHs1VMZsFL8Pp6icsYRB8j73WhgBwxtuQv0tFsiFRlN1
         O5go8ql5n+TDRzs59n4UTPdll33oUyOpbZLZfbATg1+j3sUf1/SXLTe94ggNE4dJvUsq
         hGBd7K4/pbTNsKhUv5BE1rzYzDbLGyAbNrHibGIbKc/5n5DPPh9K+F6YlB51bV3RPldZ
         /gQZYJ1odUP/7A/PTUtAC/csobQnIaNz9l6p6+FBCcQzuWf2N3ZyI//bNstDh7MreCVZ
         Tg5WaX9GuHtMWwPtrpHMUp7aEp6AXrtLL86A9mWgzOaBb3Xr/rhQBFl35Rx5dcYMY5/V
         KTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761320553; x=1761925353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXT8x9qzusyXEWglBo/xXgOU7ANwZgarpkTFXeSrsiE=;
        b=WcxHdRRXKwOl2p8bQ4ngH/1jJEd4kU5DPQltv8CASZ7tBjxe0Phta09qM7ydpj+Fuo
         JWuuct4apAQGlgF8iUI6xyDLgcFWUytRSGFRSXJg6224ZljPXoycfLQEe+RMI1V6akg/
         63ABkDnpBkn+I2P3Daoh3k+K3xuktCF28FQJYL2ozRjZqtRivxzhzbObXaDfVXV7MBzw
         wU0WdylM6SamrLtKylwcjyl8lQs1+mszT7oeMEnuhsgB09yOqFMXOVD1JxNFsxc/Nxne
         OVI7qjyEtwsiR97UTo0qoWyfg0WO3NbjcdlhlJft9l9LYlE6G1fKR0cUniOV+8isJ7dM
         UOQA==
X-Forwarded-Encrypted: i=1; AJvYcCUk4AbutSrW7DouGCYTgtvxTVMIIYiD569pisRn3Cvpxtn8RbjpIWkSEi3BW1VvEk5019dk7AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWk+eA41+spUzzyj/gOn7BDZk0CFB8siJckk3XEcer7TopoClx
	/i4kUYrAil5XdnPdw1avwoLO+ZvDVr3rAN7FrN4lnxHpBWNRe0TdizWzNK03N3h789qlj8ISukq
	qsnecMoTXO5h1gpRdm8g8hhnuZKZlInh8bjyF0OwP
X-Gm-Gg: ASbGncsCuDAqQW1h4ePWmjONUEsWF1bS46h+6cpeoa8QUFphHx5fV2qz3WQeMjeOKJO
	ehwjTvcUgi9gnyWqBEotznNifXYZvvwknRXvyrfE0oYhYnCvtCTUCurZrCvZ7keJfENp13UfYh0
	w7V7geZWvqBFfaicTRS/E9FCVNuPhiXPZv6fa2cNUf5CPwN+6800RDlP/6w2ihuSc1eDJdisstD
	dlxgOLIUyrRC/CKDfx5olD6Ad/1qn4gbHsuNiwhbFEAu9c1DWv7NeueejqBeSvBoVJ7aS2asdgt
	UzXC
X-Google-Smtp-Source: AGHT+IHPrWBYCyJ7VRSwsHPq7D8cmCtiifUp5v852TB4hBK5lLPRllWeKSTIar0DuXyDNMSBd3my8bfYSYvwRC2IFxM=
X-Received: by 2002:ac8:584f:0:b0:4e0:8896:6172 with SMTP id
 d75a77b69052e-4eb8109baf3mr69640441cf.34.1761320553035; Fri, 24 Oct 2025
 08:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024075027.3178786-1-edumazet@google.com> <20251024075027.3178786-4-edumazet@google.com>
 <1a43cc72-126a-41d3-8af9-b1a3a303386a@nvidia.com> <CANn89iK0qqpt_aLhf+HN8V_Kvwt6sEFVbAiJhpe9_F+H+SUDNQ@mail.gmail.com>
In-Reply-To: <CANn89iK0qqpt_aLhf+HN8V_Kvwt6sEFVbAiJhpe9_F+H+SUDNQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 08:42:21 -0700
X-Gm-Features: AS18NWALFH9AzX6wf7W999JdgB4lWDU-Co5FO7h3EetiFr-dmyIIfmdSr98hSV8
Message-ID: <CANn89iLzZxHhu=p+wq=ZH7qa1GbBDXPnY3XO7192MEbySyyD=g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: fix too slow tcp_rcvbuf_grow() action
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Oct 24, 2025 at 8:13=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.c=
om> wrote:
> >
> > On 24.10.25 09:50, Eric Dumazet wrote:
> > > While the blamed commits apparently avoided an overshoot,
> > > they also limited how fast a sender can increase BDP at each RTT.
> > >
> > > This is not exactly a revert, we do not add the 16 * tp->advmss
> > > cushion we had, and we are keeping the out_of_order_queue
> > > contribution.
> > >
> > > Do the same in mptcp_rcvbuf_grow().
> > >
> > > Tested:
> > >
> > > emulated 50ms rtt (tcp_stream --tcp-tx-delay 50000), cubic 20 second =
flow.
> > > net.ipv4.tcp_rmem set to "4096 131072 67000000"
> > >
> > > perf record -a -e tcp:tcp_rcvbuf_grow sleep 20
> > > perf script
> > >
> > > Before:
> > >
> > > We can see we fail to roughly double RWIN at each RTT.
> > > Sender is RWIN limited while CWND is ramping up (before getting tcp_w=
mem limited)
> > >
> > > tcp_stream 33793 [010]  825.717525: tcp:tcp_rcvbuf_grow: time=3D10086=
9 rtt_us=3D50428 copied=3D49152 inq=3D0 space=3D40960 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D131072 rcv_ssthresh=3D103970 window_clamp=3D112128 rcv_wnd=
=3D106496
> > > tcp_stream 33793 [010]  825.768966: tcp:tcp_rcvbuf_grow: time=3D51447=
 rtt_us=3D50362 copied=3D86016 inq=3D0 space=3D49152 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D131072 rcv_ssthresh=3D107474 window_clamp=3D112128 rcv_wnd=
=3D106496
> > > tcp_stream 33793 [010]  825.821539: tcp:tcp_rcvbuf_grow: time=3D52577=
 rtt_us=3D50243 copied=3D114688 inq=3D0 space=3D86016 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D201096 rcv_ssthresh=3D167377 window_clamp=3D172031 rcv_wnd=
=3D167936
> > > tcp_stream 33793 [010]  825.871781: tcp:tcp_rcvbuf_grow: time=3D50248=
 rtt_us=3D50237 copied=3D167936 inq=3D0 space=3D114688 ooo=3D0 scaling_rati=
o=3D219 rcvbuf=3D268129 rcv_ssthresh=3D224722 window_clamp=3D229375 rcv_wnd=
=3D225280
> > > tcp_stream 33793 [010]  825.922475: tcp:tcp_rcvbuf_grow: time=3D50698=
 rtt_us=3D50183 copied=3D241664 inq=3D0 space=3D167936 ooo=3D0 scaling_rati=
o=3D219 rcvbuf=3D392617 rcv_ssthresh=3D331217 window_clamp=3D335871 rcv_wnd=
=3D323584
> > > tcp_stream 33793 [010]  825.973326: tcp:tcp_rcvbuf_grow: time=3D50855=
 rtt_us=3D50213 copied=3D339968 inq=3D0 space=3D241664 ooo=3D0 scaling_rati=
o=3D219 rcvbuf=3D564986 rcv_ssthresh=3D478674 window_clamp=3D483327 rcv_wnd=
=3D462848
> > > tcp_stream 33793 [010]  826.023970: tcp:tcp_rcvbuf_grow: time=3D50647=
 rtt_us=3D50248 copied=3D491520 inq=3D0 space=3D339968 ooo=3D0 scaling_rati=
o=3D219 rcvbuf=3D794811 rcv_ssthresh=3D671778 window_clamp=3D679935 rcv_wnd=
=3D651264
> > > tcp_stream 33793 [010]  826.074612: tcp:tcp_rcvbuf_grow: time=3D50648=
 rtt_us=3D50227 copied=3D700416 inq=3D0 space=3D491520 ooo=3D0 scaling_rati=
o=3D219 rcvbuf=3D1149124 rcv_ssthresh=3D974881 window_clamp=3D983039 rcv_wn=
d=3D942080
> > > tcp_stream 33793 [010]  826.125452: tcp:tcp_rcvbuf_grow: time=3D50845=
 rtt_us=3D50225 copied=3D987136 inq=3D8192 space=3D700416 ooo=3D0 scaling_r=
atio=3D219 rcvbuf=3D1637502 rcv_ssthresh=3D1392674 window_clamp=3D1400831 r=
cv_wnd=3D1339392
> > > tcp_stream 33793 [010]  826.175698: tcp:tcp_rcvbuf_grow: time=3D50250=
 rtt_us=3D50198 copied=3D1347584 inq=3D0 space=3D978944 ooo=3D0 scaling_rat=
io=3D219 rcvbuf=3D2288672 rcv_ssthresh=3D1949729 window_clamp=3D1957887 rcv=
_wnd=3D1945600
> > > tcp_stream 33793 [010]  826.225947: tcp:tcp_rcvbuf_grow: time=3D50252=
 rtt_us=3D50240 copied=3D1945600 inq=3D0 space=3D1347584 ooo=3D0 scaling_ra=
tio=3D219 rcvbuf=3D3150516 rcv_ssthresh=3D2687010 window_clamp=3D2695167 rc=
v_wnd=3D2691072
> > > tcp_stream 33793 [010]  826.276175: tcp:tcp_rcvbuf_grow: time=3D50233=
 rtt_us=3D50224 copied=3D2691072 inq=3D0 space=3D1945600 ooo=3D0 scaling_ra=
tio=3D219 rcvbuf=3D4548617 rcv_ssthresh=3D3883041 window_clamp=3D3891199 rc=
v_wnd=3D3887104
> > > tcp_stream 33793 [010]  826.326403: tcp:tcp_rcvbuf_grow: time=3D50233=
 rtt_us=3D50229 copied=3D3887104 inq=3D0 space=3D2691072 ooo=3D0 scaling_ra=
tio=3D219 rcvbuf=3D6291456 rcv_ssthresh=3D5370482 window_clamp=3D5382144 rc=
v_wnd=3D5373952
> > > tcp_stream 33793 [010]  826.376723: tcp:tcp_rcvbuf_grow: time=3D50323=
 rtt_us=3D50218 copied=3D5373952 inq=3D0 space=3D3887104 ooo=3D0 scaling_ra=
tio=3D219 rcvbuf=3D9087658 rcv_ssthresh=3D7755537 window_clamp=3D7774207 rc=
v_wnd=3D7757824
> > > tcp_stream 33793 [010]  826.426991: tcp:tcp_rcvbuf_grow: time=3D50274=
 rtt_us=3D50196 copied=3D7757824 inq=3D180224 space=3D5373952 ooo=3D0 scali=
ng_ratio=3D219 rcvbuf=3D12563759 rcv_ssthresh=3D10729233 window_clamp=3D107=
47903 rcv_wnd=3D10575872
> > > tcp_stream 33793 [010]  826.477229: tcp:tcp_rcvbuf_grow: time=3D50241=
 rtt_us=3D50078 copied=3D10731520 inq=3D180224 space=3D7577600 ooo=3D0 scal=
ing_ratio=3D219 rcvbuf=3D17715667 rcv_ssthresh=3D15136529 window_clamp=3D15=
155199 rcv_wnd=3D14983168
> > > tcp_stream 33793 [010]  826.527482: tcp:tcp_rcvbuf_grow: time=3D50258=
 rtt_us=3D50153 copied=3D15138816 inq=3D360448 space=3D10551296 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D24667870 rcv_ssthresh=3D21073410 window_clamp=3D2=
1102591 rcv_wnd=3D20766720
> > > tcp_stream 33793 [010]  826.577712: tcp:tcp_rcvbuf_grow: time=3D50234=
 rtt_us=3D50228 copied=3D21073920 inq=3D0 space=3D14778368 ooo=3D0 scaling_=
ratio=3D219 rcvbuf=3D34550339 rcv_ssthresh=3D29517041 window_clamp=3D295567=
35 rcv_wnd=3D29519872
> > > tcp_stream 33793 [010]  826.627982: tcp:tcp_rcvbuf_grow: time=3D50275=
 rtt_us=3D50220 copied=3D29519872 inq=3D540672 space=3D21073920 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D49268707 rcv_ssthresh=3D42090625 window_clamp=3D4=
2147839 rcv_wnd=3D41627648
> > > tcp_stream 33793 [010]  826.678274: tcp:tcp_rcvbuf_grow: time=3D50296=
 rtt_us=3D50185 copied=3D42053632 inq=3D761856 space=3D28979200 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57238168 window_clamp=3D5=
7316406 rcv_wnd=3D56606720
> > > tcp_stream 33793 [010]  826.728627: tcp:tcp_rcvbuf_grow: time=3D50357=
 rtt_us=3D50128 copied=3D43913216 inq=3D851968 space=3D41291776 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D5=
7316406 rcv_wnd=3D56524800
> > > tcp_stream 33793 [010]  827.131364: tcp:tcp_rcvbuf_grow: time=3D50239=
 rtt_us=3D50127 copied=3D43843584 inq=3D655360 space=3D43061248 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D5=
7316406 rcv_wnd=3D56696832
> > > tcp_stream 33793 [010]  827.181613: tcp:tcp_rcvbuf_grow: time=3D50254=
 rtt_us=3D50115 copied=3D43843584 inq=3D524288 space=3D43188224 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D5=
7316406 rcv_wnd=3D56807424
> > > tcp_stream 33793 [010]  828.339635: tcp:tcp_rcvbuf_grow: time=3D50283=
 rtt_us=3D50110 copied=3D43843584 inq=3D458752 space=3D43319296 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D5=
7316406 rcv_wnd=3D56864768
> > > tcp_stream 33793 [010]  828.440350: tcp:tcp_rcvbuf_grow: time=3D50404=
 rtt_us=3D50099 copied=3D43843584 inq=3D393216 space=3D43384832 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D5=
7316406 rcv_wnd=3D56922112
> > > tcp_stream 33793 [010]  829.195106: tcp:tcp_rcvbuf_grow: time=3D50154=
 rtt_us=3D50077 copied=3D43843584 inq=3D196608 space=3D43450368 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57290728 window_clamp=3D5=
7316406 rcv_wnd=3D57090048
> > >
> > > After:
> > >
> > > It takes few steps to increase RWIN. Sender is no longer RWIN limited=
.
> > >
> > > tcp_stream 50826 [010]  935.634212: tcp:tcp_rcvbuf_grow: time=3D10078=
8 rtt_us=3D50315 copied=3D49152 inq=3D0 space=3D40960 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D131072 rcv_ssthresh=3D103970 window_clamp=3D112128 rcv_wnd=
=3D106496
> > > tcp_stream 50826 [010]  935.685642: tcp:tcp_rcvbuf_grow: time=3D51437=
 rtt_us=3D50361 copied=3D86016 inq=3D0 space=3D49152 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D160875 rcv_ssthresh=3D132969 window_clamp=3D137623 rcv_wnd=
=3D131072
> > > tcp_stream 50826 [010]  935.738299: tcp:tcp_rcvbuf_grow: time=3D52660=
 rtt_us=3D50256 copied=3D139264 inq=3D0 space=3D86016 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D502741 rcv_ssthresh=3D411497 window_clamp=3D430079 rcv_wnd=
=3D413696
> > > tcp_stream 50826 [010]  935.788544: tcp:tcp_rcvbuf_grow: time=3D50249=
 rtt_us=3D50233 copied=3D307200 inq=3D0 space=3D139264 ooo=3D0 scaling_rati=
o=3D219 rcvbuf=3D728690 rcv_ssthresh=3D618717 window_clamp=3D623371 rcv_wnd=
=3D618496
> > > tcp_stream 50826 [010]  935.838796: tcp:tcp_rcvbuf_grow: time=3D50258=
 rtt_us=3D50202 copied=3D618496 inq=3D0 space=3D307200 ooo=3D0 scaling_rati=
o=3D219 rcvbuf=3D2450338 rcv_ssthresh=3D1855709 window_clamp=3D2096187 rcv_=
wnd=3D1859584
> > > tcp_stream 50826 [010]  935.889140: tcp:tcp_rcvbuf_grow: time=3D50347=
 rtt_us=3D50166 copied=3D1261568 inq=3D0 space=3D618496 ooo=3D0 scaling_rat=
io=3D219 rcvbuf=3D4376503 rcv_ssthresh=3D3725291 window_clamp=3D3743961 rcv=
_wnd=3D3706880
> > > tcp_stream 50826 [010]  935.939435: tcp:tcp_rcvbuf_grow: time=3D50300=
 rtt_us=3D50185 copied=3D2478080 inq=3D24576 space=3D1261568 ooo=3D0 scalin=
g_ratio=3D219 rcvbuf=3D9082648 rcv_ssthresh=3D7733731 window_clamp=3D776992=
1 rcv_wnd=3D7692288
> > > tcp_stream 50826 [010]  935.989681: tcp:tcp_rcvbuf_grow: time=3D50251=
 rtt_us=3D50221 copied=3D4915200 inq=3D114688 space=3D2453504 ooo=3D0 scali=
ng_ratio=3D219 rcvbuf=3D16574936 rcv_ssthresh=3D14108110 window_clamp=3D141=
79339 rcv_wnd=3D14024704
> > > tcp_stream 50826 [010]  936.039967: tcp:tcp_rcvbuf_grow: time=3D50289=
 rtt_us=3D50279 copied=3D9830400 inq=3D114688 space=3D4800512 ooo=3D0 scali=
ng_ratio=3D219 rcvbuf=3D32695050 rcv_ssthresh=3D27896187 window_clamp=3D279=
69593 rcv_wnd=3D27815936
> > > tcp_stream 50826 [010]  936.090172: tcp:tcp_rcvbuf_grow: time=3D50211=
 rtt_us=3D50200 copied=3D19841024 inq=3D114688 space=3D9715712 ooo=3D0 scal=
ing_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57245176 window_clamp=3D57=
316406 rcv_wnd=3D57163776
> > > tcp_stream 50826 [010]  936.140430: tcp:tcp_rcvbuf_grow: time=3D50262=
 rtt_us=3D50197 copied=3D39501824 inq=3D114688 space=3D19726336 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57245176 window_clamp=3D5=
7316406 rcv_wnd=3D57163776
> > > tcp_stream 50826 [010]  936.190527: tcp:tcp_rcvbuf_grow: time=3D50101=
 rtt_us=3D50071 copied=3D43655168 inq=3D262144 space=3D39387136 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57259192 window_clamp=3D5=
7316406 rcv_wnd=3D57032704
> > > tcp_stream 50826 [010]  936.240719: tcp:tcp_rcvbuf_grow: time=3D50197=
 rtt_us=3D50057 copied=3D43843584 inq=3D262144 space=3D43393024 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57259192 window_clamp=3D5=
7316406 rcv_wnd=3D57032704
> > > tcp_stream 50826 [010]  936.341271: tcp:tcp_rcvbuf_grow: time=3D50297=
 rtt_us=3D50123 copied=3D43843584 inq=3D131072 space=3D43581440 ooo=3D0 sca=
ling_ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57259192 window_clamp=3D5=
7316406 rcv_wnd=3D57147392
> > > tcp_stream 50826 [010]  936.642503: tcp:tcp_rcvbuf_grow: time=3D50131=
 rtt_us=3D50084 copied=3D43843584 inq=3D0 space=3D43712512 ooo=3D0 scaling_=
ratio=3D219 rcvbuf=3D67000000 rcv_ssthresh=3D57259192 window_clamp=3D573164=
06 rcv_wnd=3D57262080
> > >
> > > Fixes: 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
> > > Fixes: e118cdc34dd1 ("mptcp: rcvbuf auto-tuning improvement")
> > > Reported-by: Neal Cardwell <ncardwell@google.com>
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/ipv4/tcp_input.c | 8 +++++++-
> > >  net/mptcp/protocol.c | 7 +++++++
> > >  2 files changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index c8cfd700990f28a8bc64e4353a2c78a82bb6bcb2..f004072654a4c50da14b9=
dafc46133feb71f12cd 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -896,6 +896,7 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
> > >       const struct net *net =3D sock_net(sk);
> > >       struct tcp_sock *tp =3D tcp_sk(sk);
> > >       u32 rcvwin, rcvbuf, cap, oldval;
> > > +     u64 grow;
> > >
> > >       oldval =3D tp->rcvq_space.space;
> > >       tp->rcvq_space.space =3D newval;
> > > @@ -904,9 +905,14 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval=
)
> > >           (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
> > >               return;
> > >
> > > -     /* slow start: allow the sender to double its rate. */
> > > +     /* DRS is always one RTT late. */
> > >       rcvwin =3D newval << 1;
> > >
> > > +     /* slow start: allow the sender to double its rate. */
> > > +     grow =3D (u64)rcvwin * (newval - oldval);
> > > +     do_div(grow, oldval);
> > > +     rcvwin +=3D grow << 1;
> > > +
> > >       if (!RB_EMPTY_ROOT(&tp->out_of_order_queue))
> > >               rcvwin +=3D TCP_SKB_CB(tp->ooo_last_skb)->end_seq - tp-=
>rcv_nxt;
> > >
> > Hi Eric,
> >
> > When applying this series I see a regression in a simple 25G iperf test=
:
> > retransmissions are seen due to packet drops (out of buffer) on the
> > server side.
> >
> > The test:
> > - server: iperf3 -s -A 5
> > - client: iperf3 -c 1.1.1.1 -B 25G
> > - Configuration:
> >   - Server has a single queue with affinity set on CPU 5.
> >   - Ring size: 1K (4K ring size seems ok)
> >   - MTU: 1500
> >   - Client uses TSO, server uses SW GRO.
> >
> > Before series (includes first patch):
> > <...>-2192  [005]   162.451893: tcp_rcvbuf_grow: time=3D1622 rtt_us=3D1=
596 copied=3D76781 inq=3D30408 space=3D14480 ooo=3D0 scaling_ratio=3D188 rc=
vbuf=3D131072 rcv_ssthresh=3D91990 window_clamp=3D96256 rcv_wnd=3D66560
> > <...>-2192  [005]   162.451998: tcp_rcvbuf_grow: time=3D106 rtt_us=3D10=
5 copied=3D158720 inq=3D0 space=3D46373 ooo=3D0 scaling_ratio=3D188 rcvbuf=
=3D131072 rcv_ssthresh=3D91990 window_clamp=3D96256 rcv_wnd=3D92160
> > <...>-2192  [005]   162.453254: tcp_rcvbuf_grow: time=3D142 rtt_us=3D44=
 copied=3D292496 inq=3D91512 space=3D158720 ooo=3D0 scaling_ratio=3D188 rcv=
buf=3D432258 rcv_ssthresh=3D270533 window_clamp=3D317439 rcv_wnd=3D253952
> > <...>-2192  [005]   162.454446: tcp_rcvbuf_grow: time=3D113 rtt_us=3D44=
 copied=3D343176 inq=3D127424 space=3D200984 ooo=3D0 scaling_ratio=3D188 rc=
vbuf=3D547360 rcv_ssthresh=3D349656 window_clamp=3D401967 rcv_wnd=3D345088
> > <...>-2192  [005]   162.455726: tcp_rcvbuf_grow: time=3D52 rtt_us=3D44 =
copied=3D264464 inq=3D40544 space=3D215752 ooo=3D0 scaling_ratio=3D188 rcvb=
uf=3D587579 rcv_ssthresh=3D391036 window_clamp=3D431503 rcv_wnd=3D194560
> > <...>-2192  [005]   162.456444: tcp_rcvbuf_grow: time=3D37 rtt_us=3D36 =
copied=3D322560 inq=3D0 space=3D223920 ooo=3D0 scaling_ratio=3D188 rcvbuf=
=3D609824 rcv_ssthresh=3D391036 window_clamp=3D447839 rcv_wnd=3D323584
> > <...>-2192  [005]   162.456865: tcp_rcvbuf_grow: time=3D40 rtt_us=3D36 =
copied=3D421840 inq=3D73848 space=3D322560 ooo=3D0 scaling_ratio=3D188 rcvb=
uf=3D878461 rcv_ssthresh=3D581105 window_clamp=3D645119 rcv_wnd=3D515072
> > <...>-2192  [005]   162.457762: tcp_rcvbuf_grow: time=3D38 rtt_us=3D36 =
copied=3D430176 inq=3D65160 space=3D347992 ooo=3D0 scaling_ratio=3D188 rcvb=
uf=3D947722 rcv_ssthresh=3D631969 window_clamp=3D695983 rcv_wnd=3D467968
> > <...>-2192  [005]   162.463191: tcp_rcvbuf_grow: time=3D35 rtt_us=3D34 =
copied=3D411336 inq=3D0 space=3D365016 ooo=3D0 scaling_ratio=3D188 rcvbuf=
=3D994086 rcv_ssthresh=3D666017 window_clamp=3D730031 rcv_wnd=3D354304
> > <...>-2192  [005]   162.469069: tcp_rcvbuf_grow: time=3D38 rtt_us=3D34 =
copied=3D444520 inq=3D0 space=3D411336 ooo=3D0 scaling_ratio=3D188 rcvbuf=
=3D1120234 rcv_ssthresh=3D783379 window_clamp=3D822671 rcv_wnd=3D679936
> >
> > After series:
> > <...>-2585  [005]  1061.768676: tcp_rcvbuf_grow: time=3D623 rtt_us=3D60=
0 copied=3D72437 inq=3D28960 space=3D14480 ooo=3D0 scaling_ratio=3D188 rcvb=
uf=3D131072 rcv_ssthresh=3D81968 window_clamp=3D96256 rcv_wnd=3D82944

Looking again, it seems the initial rtt_us is much bigger than the
rtt_us of 55 usec you have later (or 34 usec on previous samples)

DRS is fooled by the apparent explosion (more than traditional Slow
Start) of the incoming traffic.

1) Do you have a large initial cwnd ? (standard is IW10)
2) iperf3 does not seem to be able to read the queue fast enough. Is
it reading 1000 bytes at a time ?

> > <...>-2585  [005]  1061.769859: tcp_rcvbuf_grow: time=3D89 rtt_us=3D55 =
copied=3D250560 inq=3D46336 space=3D43477 ooo=3D0 scaling_ratio=3D188 rcvbu=
f=3D592631 rcv_ssthresh=3D302062 window_clamp=3D435213 rcv_wnd=3D230400
> > <...>-2585  [005]  1061.775618: tcp_rcvbuf_grow: time=3D56 rtt_us=3D55 =
copied=3D405296 inq=3D140016 space=3D204224 ooo=3D0 scaling_ratio=3D188 rcv=
buf=3D4668930 rcv_ssthresh=3D1927847 window_clamp=3D3428745 rcv_wnd=3D19281=
92
> > <...>-2585  [005]  1061.777324: tcp_rcvbuf_grow: time=3D57 rtt_us=3D55 =
copied=3D450664 inq=3D131072 space=3D265280 ooo=3D0 scaling_ratio=3D188 rcv=
buf=3D4668930 rcv_ssthresh=3D3106743 window_clamp=3D3428745 rcv_wnd=3D30064=
64
> > <...>-2585  [005]  1061.783411: tcp_rcvbuf_grow: time=3D58 rtt_us=3D55 =
copied=3D521280 inq=3D41160 space=3D319592 ooo=3D0 scaling_ratio=3D188 rcvb=
uf=3D4668930 rcv_ssthresh=3D3364731 window_clamp=3D3428745 rcv_wnd=3D208691=
2
> > <...>-2585  [005]  1061.790393: tcp_rcvbuf_grow: time=3D55 rtt_us=3D55 =
copied=3D524288 inq=3D0 space=3D480120 ooo=3D0 scaling_ratio=3D188 rcvbuf=
=3D4668930 rcv_ssthresh=3D3364731 window_clamp=3D3428745 rcv_wnd=3D2492416
> > <...>-2585  [005]  1061.935387: tcp_rcvbuf_grow: time=3D55 rtt_us=3D55 =
copied=3D537824 inq=3D0 space=3D524288 ooo=3D0 scaling_ratio=3D188 rcvbuf=
=3D4668930 rcv_ssthresh=3D3364731 window_clamp=3D3428745 rcv_wnd=3D2258944
> > <...>-2585  [005]  1062.977374: tcp_rcvbuf_grow: time=3D57 rtt_us=3D55 =
copied=3D545064 inq=3D0 space=3D537824 ooo=3D0 scaling_ratio=3D188 rcvbuf=
=3D4668930 rcv_ssthresh=3D3428745 window_clamp=3D3428745 rcv_wnd=3D2223104
> > <...>-2585  [005]  1064.873376: tcp_rcvbuf_grow: time=3D57 rtt_us=3D55 =
copied=3D549408 inq=3D0 space=3D545064 ooo=3D0 scaling_ratio=3D188 rcvbuf=
=3D4668930 rcv_ssthresh=3D3428745 window_clamp=3D3428745 rcv_wnd=3D2509824
> > <...>-2585  [005]  1065.984340: tcp_rcvbuf_grow: time=3D59 rtt_us=3D55 =
copied=3D574024 inq=3D0 space=3D549408 ooo=3D0 scaling_ratio=3D188 rcvbuf=
=3D4668930 rcv_ssthresh=3D3428745 window_clamp=3D3428745 rcv_wnd=3D2336768
> > <...>-2585  [005]  1066.210718: tcp_rcvbuf_grow: time=3D410 rtt_us=3D55=
 copied=3D589448 inq=3D0 space=3D574024 ooo=3D0 scaling_ratio=3D188 rcvbuf=
=3D4668930 rcv_ssthresh=3D3428745 window_clamp=3D3428745 rcv_wnd=3D3364864
> >
> > Is this expected?
>
> Typical cubic reaction I would say, with pfifo_fast ?
>
> I do not think that artificially slowing down senders by not growing
> rwin fast enough is the right answer.
>
> If you have drops, that is because the sender is sending too fast or
> with too large burts.
>
> Try using the fq packet scheduler and see if it helps.

