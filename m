Return-Path: <netdev+bounces-207368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D872B06E2B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739924A4196
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 06:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C6E17B50A;
	Wed, 16 Jul 2025 06:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQLNz9Se"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28953946C
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648360; cv=none; b=tRFiFhmooONUP0TuwKnHrhmQFpqSziOniwfk57mxmTH5jxj4QzlAnMyAMjwFdvvMCTA2fCtEmCwFktdYrP2VOpCL8tp7C5Q6ABPl3bJ/QZugTyrFltURjVV7P3V2AhA04NTdYu93QMi6SM3T2qZByZO761rJeZTHRVTntC29Uhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648360; c=relaxed/simple;
	bh=FGHGoKmWwE9rBUE5D92umejqifhyuwDS29mHCgY0Ivk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpsRkV1REa44lnoJjMEm0yZvibm3n0ackIFMOAAXDt2IAE4/oLydlsy3xdqnugHVHnuSG4MywxmhtHskEeDlp/cfCLSxKPS9bJYpsEXsV+Mf7j7DJ41qXTgZt8Ax/qUVplzPkCnUE0SoiMc3Sr5Mx4z+sHEXLCAUGYvDfymuLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQLNz9Se; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-315c1b0623cso6206172a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 23:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752648358; x=1753253158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZCHyCLbp3Y9oOBBnF8pwFYLDtQ8uo06GFGJCViqofs=;
        b=SQLNz9SeiALep7PkRzFK5c2B5GOlvj/1AMdu4H/9te4NeNKPDHI8C8hX4eUE+tz0Jd
         Gu/4lvixE8auhRWzGxPJ57x02B9LlDDY10sVHgLPBcxzvlO22JTpvneuF1G6yRADrFNR
         NwSPWDfMTIbGM2qgo3+XzF/QbkQ5qWg4eUN+B+DDXhyEX1wifBebfyumr4UtJSSFqx8F
         ssXT9Z33oGIjR/A/THDH3F5PeTx5Z1VMH61n6hXI47IztYHHUUX1TEk5R9bc9sKtweU2
         J07jlNcCgjeQg6uR/p+n12Z+GH7hLDI0lA2nlGlX4GkwSv62iqNWoX34VSyAPJHpMX7p
         Lajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752648358; x=1753253158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZCHyCLbp3Y9oOBBnF8pwFYLDtQ8uo06GFGJCViqofs=;
        b=CSioMSt5CN2O/h2XYu/B7MVpKj/WO3Y/AFTunGoDrzIXVMn3hpQKFuGMEwk1hQ4J52
         LS3eLOk3+KXT+GOgG1P3/PoY635b9+AcV9f4QvoyIfjuANdmysBtwNmtiNoE6KTCblKS
         WqxO9xGlmxgt7Z90S4O41h/0isrSYstT5qiiPmVYbXjzqKzZo26X7VsvtF8N+zDP1Ncb
         3qJme1ebrvoPcAsvlasfeNb4qJH986u65DQRmXPE+Fu9PxNzY4U9oNxgMfeQNEMVTuXI
         oSnpH/grCe7UwJOoGMRElvyeDknNgIKdfItyzkcv7NNfxiTgARMn/RKtLLmBvR7zSw0P
         OB2g==
X-Forwarded-Encrypted: i=1; AJvYcCXS1jfYdNcSgVdG/B+VDxhiMvCU0GYGNMeokTIP49DFtdpLsW+nqEzju6gy62D/F2AiVpdR/lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsP3s/PlSg8KZq6OzIanOMb4KeI/6qM5OIXnTdNHuugSuYvLV
	0K89V1RwoCa/jI+W60NKE9JNyEc/IaIee+6YJHYbKTVNdCy3tMC+XmtOYxM3JO/bLXfnf2nsdiO
	kAQzlpkBRppaqwTbilmNQuUzwtWOlGRvihUEqGrLt
X-Gm-Gg: ASbGncvHweIKggnFh+z3SLupV0RJudJO0ytHJNJHiRZmlpmN75cSP+v3W4WswSentYA
	Jy/x5w5Q7LIRxFYmrLgGFLINYJy5AH4FDcQgJulPffvO0fTpjVct0qR3HSwdknFd1lONSpLBi50
	MZTCK+XcRl9PtIIvv1LxKF2o9KRH5Dv4ZkqIUE3xup2N04Dpn/YiJ+1U1Qv2HmOHMppbqfIy9DF
	JbN8+fZU34wW0Njpduq0ofIPBCM9LT2qbGplr7T
X-Google-Smtp-Source: AGHT+IEKzLtCCcFv1uWKQxZzZx7HTw9Y2/6BCXS7JHZas0rzCRIHNkRAQZE84CaktCa+tU3Q1HR4+4aDjbnbF4dlUT4=
X-Received: by 2002:a17:90b:2d81:b0:313:bf67:b354 with SMTP id
 98e67ed59e1d1-31c9f2a0103mr2687058a91.0.1752648358141; Tue, 15 Jul 2025
 23:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com> <20250712203515.4099110-2-kuniyu@google.com>
 <20250715181756.3c9f91ec@kernel.org>
In-Reply-To: <20250715181756.3c9f91ec@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 15 Jul 2025 23:45:45 -0700
X-Gm-Features: Ac12FXzi07_q1U2jeIHxQ5ujBty6wlY-pBcilg6jt1PZhAN2S_LoZvhjJU3ZMYc
Message-ID: <CAAVpQUD6M134pHpERL0eREUXK=7=AcWhog1C7rRwgy5cRA7hbQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 01/15] neighbour: Make neigh_valid_get_req()
 return ndmsg.
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 12 Jul 2025 20:34:10 +0000 Kuniyuki Iwashima wrote:
> > -             return -EINVAL;
> > +             err =3D -EINVAL;
> > +             goto err;
> >       }
>
> nit, I guess, but why the jumps?
> You could return ERR_PTR(-EINVAL); directly, lower risk someone will
> forget to set err before jumping?

I guess I tried to avoid repeating ERR_PTR() but agree, actually
it was me who forgot to set err in v1 of the previous series :p

