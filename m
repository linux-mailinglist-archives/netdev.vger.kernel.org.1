Return-Path: <netdev+bounces-233233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9809FC0F039
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8F63AD625
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152430BB8F;
	Mon, 27 Oct 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4uJo2DYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB02C1587
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579467; cv=none; b=Hxheaz7MU7iTqei3jaKGev9JYCud10Xpr+6UWecXtaufFrHaDsnpyyi4/xKbPoKF4zvijqqOpY7r48paavDc2HgOY1KLb/uNfocbA6RX5dXPr6J+mlCGZ9LEVUbrdeLSe4g30mXbveYjMnTgz4u5MrHec51WpmyY1cEu7y2q2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579467; c=relaxed/simple;
	bh=NdUAfjwZC1lFLK5bvSbfokgl26V1lQo1BXF/Zvx74FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gbrx15xUq2UXfzaFAlD94Bj43iOdNwjM97V+tC8VC6aknWNPP43VQfsjhNmm+AmyjcBCp1K42RMul+wSR31skjK++aqVEucyAyXCEs90/m+ydEd2LkzkDFt+kKBItFSsOBQJyNdV4hWBYgrMaqc033dWBhijyGV61yQ9RjeXg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4uJo2DYO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e89c433c00so52713581cf.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761579465; x=1762184265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sSWe1Uo3g0JRlD22okBKF06kGAx/lLaSwV3VLAdORo=;
        b=4uJo2DYOssHoCrFjLJs4zvgdhuXzfpXjVez87V2y4FLzZHQ34bEJ9HYesb7HcbP0OZ
         h/1MS3vmDVXWPmafbQcVcZJJFGZvFD9d933R5BDyMWXdl63fZdA7JhkaupiMXWT+pUEW
         SweMdpGb6GhzPNhYDq8/cQNVnLra/tSNSwWaBrsy+0XqQylNhRB6EgqsWa89SakObIEa
         Xm/H9hBoeFX5n5j3YZFw34pS22IUxfFval0kp89K6vno99f6z3ar7p/gC5m46RRS7heM
         ZGnWjeTh15bw4nstCbjTuPqInQU7KMoSMIokPaT8jb+U/uy4BQXTihuUKTCF8xUTvjFQ
         D7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579465; x=1762184265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sSWe1Uo3g0JRlD22okBKF06kGAx/lLaSwV3VLAdORo=;
        b=DAOCZqufrk2Z5MU+47GpljuBYspKHlWaI5wY100No92rVJAUF5a6VruycwbxntsVr8
         yrGqR6r+x4WsOKVnB9eJsqEn3vmre4tqwG6LIyGW8mDug7ZDEZD3fCaL49/KcFEVbJ/3
         FGGqdwCMxtRhFOxeAhLLc4srp1YYcsN2RGYRaa+qt7xUg4MgF557wGIeioUaMohrk1d/
         SL2riiKV8Jt9NsdmKrOiBXQ75Y6BR97vkWmTAM5Vcn/nIq/3d3e7piX+tAQx8m4KE5dt
         qBxcMBxhUvspnL+WM9+nRmdOvAKIUYexg6e1tJeBEOFr+wCsGC5uYE4hLQ/+2cQpIQAS
         y2EA==
X-Forwarded-Encrypted: i=1; AJvYcCUeglB8muxv0WksmuepmikJ9ZOXhe5OUl+mYXGN3FkOQtQC3hg4Mlv/NbGC2aPOyyu5kP2sUXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxXr4N2ok5ODuRquxQIjKCBkdXXNjl4fr8sdSeVMfRoiqun3V9
	D9PzhluzsJE9rbR09DQ4L1MbSuGiEkW1c39D18G8Hmu1JXGm1fkpcISLJZMDNzRHDjeX+GCCGQw
	DqZiTJ9zqRwYXGDGaoMTyay2QI+99ifiV1IDE81bT
X-Gm-Gg: ASbGncsdmjw6J88ZJ1XjePnKVrgnVo+enrlGtXbr21rJGwzcNclitxyR56Fv7m8Rh68
	42t5Ytj0xqUx713NyYxs31y/1Tm9jANxtD2m9QAMsmLtfPUXGMfA8UoiGe0eBRHtUiC2bgNLhov
	JkUlKw5gANAYJy/yniV0F9wqLkV7XexXVJkSa4SEqsbxtU7iTm72En3oOzs0pmGTgfO9fI1K4tl
	9KO2NHn4dVrjE0M5QfRVPhJqvHml2RhFzcuHGyhq5gsxtwcxx3aTACyHtCyIXpOjLFLY+Q=
X-Google-Smtp-Source: AGHT+IEQsrIzQEeOHP3u8+DXADK42mZjrOz0eC2kOXhskE0pR+ratF0X132RqD/vyktKzWcdvaoIDdzJI8PB26vkjyY=
X-Received: by 2002:a05:622a:1311:b0:4e8:aad2:391e with SMTP id
 d75a77b69052e-4ed075baa00mr5408431cf.40.1761579464615; Mon, 27 Oct 2025
 08:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027073809.2112498-1-edumazet@google.com> <20251027073809.2112498-3-edumazet@google.com>
 <d4d71883-d249-4fbd-a703-930e62a16b96@kernel.org>
In-Reply-To: <d4d71883-d249-4fbd-a703-930e62a16b96@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Oct 2025 08:37:32 -0700
X-Gm-Features: AWmQ_bk1ELfUhwRvs8N_MqSPcV6lSpPS2PvzkEvE6a1bSq6t8i7NJ9wXK-i2IrM
Message-ID: <CANn89iJ+n12nw-PDJNk-i1tcSbiJ33nqYS0V9+TeqY9iHsVUJQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/3] tcp: add newval parameter to tcp_rcvbuf_grow()
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:50=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> On 27/10/2025 08:38, Eric Dumazet wrote:
> > This patch has no functional change, and prepares the following one.
> >
> > tcp_rcvbuf_grow() will need to have access to tp->rcvq_space.space
> > old and new values.
> >
> > Change mptcp_rcvbuf_grow() in a similar way.
>
> Thank you for the v2, and for having adapted MPTCP as well.
>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/tcp.h    |  2 +-
> >  net/ipv4/tcp_input.c | 15 ++++++++-------
> >  net/mptcp/protocol.c | 16 ++++++++--------
> >  3 files changed, 17 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 5ca230ed526ae02711e8d2a409b91664b73390f2..ab20f549b8f9143671b75ed=
0a3f87d64b9e73583 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -370,7 +370,7 @@ void tcp_delack_timer_handler(struct sock *sk);
> >  int tcp_ioctl(struct sock *sk, int cmd, int *karg);
> >  enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_=
buff *skb);
> >  void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
> > -void tcp_rcvbuf_grow(struct sock *sk);
> > +void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
> >  void tcp_rcv_space_adjust(struct sock *sk);
> >  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
> >  void tcp_twsk_destructor(struct sock *sk);
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 31ea5af49f2dc8a6f95f3f8c24065369765b8987..600b733e7fb554c36178e43=
2996ecc7d4439268a 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -891,18 +891,21 @@ static inline void tcp_rcv_rtt_measure_ts(struct =
sock *sk,
> >       }
> >  }
> >
> > -void tcp_rcvbuf_grow(struct sock *sk)
> > +void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
> >  {
> >       const struct net *net =3D sock_net(sk);
> >       struct tcp_sock *tp =3D tcp_sk(sk);
> > -     int rcvwin, rcvbuf, cap;
> > +     u32 rcvwin, rcvbuf, cap, oldval;
> > +
> > +     oldval =3D tp->rcvq_space.space;
>
> Even if the series as a whole is OK, NIPA (and the MPTCP CI) are
> complaining about this line, because in this patch, 'oldval' is set but
> not used. It is used in the next patch.
>
> I guess we want to fix this to prevent issues with 'git bisect'. If yes,
> do you mind moving the declaration to the next patch please?

This is quite annoying.

Whole point was to have separate patches to help review, not to add more wo=
rk.

I will not have time to send a V3 soon, I am OOO.

