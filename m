Return-Path: <netdev+bounces-213872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B9FB272FA
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25E5722D49
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D68287505;
	Thu, 14 Aug 2025 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4+Bw4zC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2AE28507F
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213764; cv=none; b=qGUTXU6VXBBvlJtvg6wmiRAwLeS8YF5b6p9+XBJIJXlDR82YxZZOzvdtOyu/+9azRD/aKRxAidTNQVKSN2040zQsysIQoHTMxVUjgrPZQl2HJ2dojkEC230YNimgPyHxvqQdK2sjWiyNQbU1oEunldROYqyUdryKjUEuMeSdZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213764; c=relaxed/simple;
	bh=YQ7YCZjjUdesfp/4AmnBBp2EwgfrYAy7oWynoXY99mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGT18FKappBkmfpVhsMg21AhrBvkeSQeQzrnhcSWJ6QkqC0Kq5vOgCtpe7nem2OjhDLWQqR8Ft0aLDu7srZA0rJ2TEcEcTJ0UKQZtLbbceXp9v26L0Kzlf8uSFFb69gimW1jaUx1RPTou5qOGJcBmf7TAGAO6wNJKT2HlweZx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4+Bw4zC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4717390ad7so1084860a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755213762; x=1755818562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ7YCZjjUdesfp/4AmnBBp2EwgfrYAy7oWynoXY99mk=;
        b=U4+Bw4zCHPYz4w0y1OyYPNn4xWLtuUtQ048u/0/5zhnhwG5vxwvgGbByWYsI1uBRxX
         hRERXh5V6LuAfMJnSfUVO1b7LgMpfckEKK1BBfGayhyuzEu5qwJ0M4Fig2OOk30IaEz5
         zQu5RTwLPU5LKNcrC2+Qt4AVLrI5ZPxwEiS+0ZuaVrU8fQZE31uE4v2XiOrnD5TulPlc
         vEVQLDCT94QNLHXccWCS2SH/UDz2ZBGgpAHKrorzlDTTKaZwc3H0dw92VWa43I7Xe+cf
         E1NuiFf0yhrHbwgoeJFa8EiCVumonb5lVP7REl5+bE1SWf1cjmD2fvXhgBV2yw4Jhfm3
         Mqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755213762; x=1755818562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ7YCZjjUdesfp/4AmnBBp2EwgfrYAy7oWynoXY99mk=;
        b=oPsk2ri5UcPaU5f2QiMuY7vlFxdvpd8MLP1FXpwsAurXuNSK51MfjR35Ml3N6JRo0e
         1JpZmSMBNGks5gAwc2jlccf/cXFm/pk+B+UWFJWCuw5B2aVBHMmvkU924C1eIytm080m
         zSpxcidQKuBQFnq15WdDjKLET6NjBAXNw4wHTp7E1cDCdAJScQGIC8rR2hLnupDfjMYA
         V308nWx9SDLlxDYbqrrv2aB98KMRzR28+NkHnH3CtKERKd00MQUWFGH3qaXHcKseobBV
         Irx/gEpYgZnyGV+CvLgE93cfZXEWlwDq3YhkqnBV4oksdEVIfS2ofVawEgsArD14SpGq
         xg6A==
X-Forwarded-Encrypted: i=1; AJvYcCXLAOcDPj6YRYItXmNLsS5J4xd+WS6WmFobKvU5zdvxHqzIZPzrFvIy6oVrLKjrJpXI1u3VgY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMt4WS2buafBz62C99aj2gojsaRu0raIR+DH6qgZznW9WcXYfl
	aPXjfgkI3c44UwRn1W2t2ER3BZgmwMwYFR8dM3D9Bo5QfTwJ3CrlAAXl8pRJrzIr3/pGnT0Ew44
	kwPS5K3XDKoSthi80y4NzABu1tTxaU2NCcWlFp1RM
X-Gm-Gg: ASbGncs9RolfcVlbbM2Wz4CD++/8P2mgbY7ak761uCGelKCsVyE+hyox7N5isC3SCk/
	7OQtAj0huYXkXUkA0irg3NIhHOvcFsMmMf1305JMzEqxRWhpJPwKIlpksipJMHWGBVb74ric+pL
	lfdbfRuaZm0/OWWvMubPbs+fil6w6F6NPUxIZ60OeTvSSII27brXb7W3aQ0lXlTxZVAOMZ+Nflp
	ctmfh/TeC0ZcSO4iXErh/gqhYdsEpZ6Id0WYIzyoQ/kXp61I/DQ4+c2
X-Google-Smtp-Source: AGHT+IG+GzkTFoWSxjI/UBpeB+AhhE8U81bSEVut4K3CLnycOTHj2PFasfm2kLor4XHXf2jf8tiH2o7md6AgbgQhI+o=
X-Received: by 2002:a17:903:2444:b0:23f:c945:6067 with SMTP id
 d9443c01a7336-244586c3d33mr71675685ad.41.1755213762138; Thu, 14 Aug 2025
 16:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com> <20250814200912.1040628-10-kuniyu@google.com>
 <pl47mmcmxu53ptfa5ubd7dhzsmpxhsz2qxpscquih4773iykjf@3uhfasbornxc> <7pbqwjm4yl3oxebibihbdqkdusamnnui5ypzhfh32pxfkcordq@o3hottcdlavs>
In-Reply-To: <7pbqwjm4yl3oxebibihbdqkdusamnnui5ypzhfh32pxfkcordq@o3hottcdlavs>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 14 Aug 2025 16:22:31 -0700
X-Gm-Features: Ac12FXwLp2y7n2f70IACCfZi6vRBARC4QHPOIBg0j8Z8siCHACfmll_htqDpnyQ
Message-ID: <CAAVpQUDxXZaYz98hen3ariCek4s9TQ9JxWqS_zRoDK=ON-asbQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 09/10] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 3:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Aug 14, 2025 at 03:00:05PM -0700, Shakeel Butt wrote:
> > On Thu, Aug 14, 2025 at 08:08:41PM +0000, Kuniyuki Iwashima wrote:
> > > We will store a flag in the lowest bit of sk->sk_memcg.
> > >
> > > Then, we cannot pass the raw pointer to mem_cgroup_under_socket_press=
ure().
> > >
> > > Let's pass struct sock to it and rename the function to match other
> > > functions starting with mem_cgroup_sk_.
> > >
> > > Note that the helper is moved to sock.h to use mem_cgroup_from_sk().
> >
> > Please keep it in the memcontrol.h.
> >
>
> Oh is this due to struct sock is not yet defined and thus sk->sk_memcg
> will build fail?

Right, we can't touch any field of struct sock in memcontrol.h as
noted in patch 6.

