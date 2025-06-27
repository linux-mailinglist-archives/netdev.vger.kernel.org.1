Return-Path: <netdev+bounces-201776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2219DAEB004
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDC116774A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 07:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AA01AB52D;
	Fri, 27 Jun 2025 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g16cW0r1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7F2F1FEA
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008913; cv=none; b=rkwHegNb5I81GOQocZBGowIfP4BTLfaZZFPpKGtx+6B1xUOcQEmPLQuW/J4WEbdMWFn+cNTgvvkf9c/hVdjGPJyAtmwkYidSNvtN31gi57qlvdfvpfapns9Pt6jnbBlV0BWVwq/HSwjCAWwrTuzDOVJ5PR2cyTpQDwzKZWUcUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008913; c=relaxed/simple;
	bh=0EN/pMLNS6Hb1rbxyMjQmi9PlwBlpt5lzi7p7WyG0gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqAPWGIuDxwYBk0XQXQFglJU7foEAmcbvLsPKtga0+2hl15P6vd2zl8dg/wvQelVT6BWHT+g9uxfRm/r1k+zQ+H9HNfSIlYo4Fh4UuJgey0vRXY9sWIj0xe6AorP22Dqi7qY+iZLZ+TaUWc41SrqiTYA0NiKzgNacbvQZBUAFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g16cW0r1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a4bb155edeso23010391cf.2
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 00:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751008911; x=1751613711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EN/pMLNS6Hb1rbxyMjQmi9PlwBlpt5lzi7p7WyG0gE=;
        b=g16cW0r1hLWCqawlHf4BfovjB+25bNr1Uhi9Ax6uuiKCjatq2N+OXWtpdlZE8EspoU
         sKcdeRd8YfK4K6QKoDbiWlO8eT4ANvr3GqLjIH+/VUxcnMbAe4s/IK3XnQoqvuQsBFQr
         K8haHg843RYrHVK1TUS8jjx0bDrz3wpmuVZg1PzaVx1Y+muEVyGv+ONegKJC6T5y0v9b
         igRPasGKvjt52uOeIgyhrCvDORbEYoECNPeeyE4lFXrACjseCBtAP5TGbTRebtu6c4Yn
         tgGq4cHJqhUEzgqIaWkrh/aDm4tCp/VWeV9xKBIaFopLPJIF3IcJnLSbkWtj+eNoPpiG
         V/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751008911; x=1751613711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EN/pMLNS6Hb1rbxyMjQmi9PlwBlpt5lzi7p7WyG0gE=;
        b=Ftm+TIUVCHFNc1CUtk5qtI9YUpz4epu44csDVS+JWjiT20qouheLjY68Lbcs/fKK3Y
         VtU1H9ndnkN1iC3Z7qflE56Pr/t+vIS0XzvkrYLbV/k9NVDvCpjP5e5hqysz4yAB52BH
         2KgWB9r6tgnevhDVZuhbA60NOYGiCVyR0SOWXge40Tf6SWwiC28vmKFo/MykcFvKaVNW
         eTcJnZ8Ug59w671bSbIM+gdeIUwMlYyCvJLpI9EB5B57FuGBeEtkkiDRKC7jcQn3Ds3U
         W7mfYD4YyLRHXsBb8epBcAIpNO5i5crcB2U1+n0NpGlpRYjZGje0QN2/9E/JaD1tfEmX
         Jw2w==
X-Forwarded-Encrypted: i=1; AJvYcCUvqfZdc0aXKgL9eascfplzwahbZOHNom9nho1IjYGGZm+Ah84smAOGWlwCy+MOH9PnE9z37sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7/ApXq15LaAKy1ImdMrBTzCN6bDkd7Cpq2kN3/y0Pi5gIm/u
	6kTtHGSAvjlZnf49zgue9OIPVrOJT4zwD2PQwFdm779VYQXrTdMCWFYmg9TtW7q82cQfyDDcHGn
	PyiuAVTeSDh0K147l858pVQYB+TvXjt5aZX1m4sBl
X-Gm-Gg: ASbGncv67DVmc92KF6JkxAumGnHsssAiwx+ejPo/2Bvt46M4ce3FbdZNI9kuq6fqhzH
	/m8+Hti8OjoI12QpC3MGyrxLElSI5sUP/mNTrCo9ORW+jy3qVeoSVD/fxm7FVkJnwkeuWvU9Oqq
	IS4u4MjdtM0QcfXNOFBsSY4RvD0uaM1LMVF73RsWuP+g==
X-Google-Smtp-Source: AGHT+IEw5Nw08ypT47RC9p1WBhXqU/4RoC6q7E4bFDwfDqTcvmWC5gRr2EDS2fSQmfzYnx5WgG0t/4aq+QWflCe64CY=
X-Received: by 2002:a05:622a:248a:b0:4a4:4128:c2ef with SMTP id
 d75a77b69052e-4a7fcd07474mr38826551cf.6.1751008910491; Fri, 27 Jun 2025
 00:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-7-kuni1840@gmail.com>
 <CANn89i+aMsdJ+oQmo1y4sbjJM40NJpFNYn2YT5Gf1WrfMc1nOg@mail.gmail.com> <CAAVpQUDa8w49-mvf4=nAYLKv0aX9hmAt312_0CD+u4nSWWAv3A@mail.gmail.com>
In-Reply-To: <CAAVpQUDa8w49-mvf4=nAYLKv0aX9hmAt312_0CD+u4nSWWAv3A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Jun 2025 00:21:38 -0700
X-Gm-Features: Ac12FXzMF_ElCgWh58YcjM2Bv8wKKssmL5J-MbAX7tFfSTeY210_4pS26Ihs3Yw
Message-ID: <CANn89iLpv6esFywtGMZTuNU2Ppdj_Ps_vff-c+Sp_iPNZrkxJA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 06/15] ipv6: mcast: Don't hold RTNL for
 IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 6:01=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>

> I'll post a follow-up for other rt6_lookup() users and dst.dev
> users under RCU.

I have prepared a series adding annotations and helpers.

