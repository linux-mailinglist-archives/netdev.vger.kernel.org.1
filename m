Return-Path: <netdev+bounces-137019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 496479A408A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DC81F243E7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826D82032A;
	Fri, 18 Oct 2024 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECDYyyBC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846619476
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259733; cv=none; b=uJNEMf1BlJHskPxumREnaHS09X0ew29uFHoBtNADVrRZJus9D58iOO0dmCci+GPUklEGiz3zKTx8hpNoZI55ou2MDverJTLYw75388i3jvtu8FJUUMGeDGU7T9TkFwHRDtSBaAiUspdXERtWqH6jh54Jx5vAV1/ywlyWp2JqJvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259733; c=relaxed/simple;
	bh=1FtuUGxLXX+BJO2DnZAU/FRczWTGU8z1QeJEe637rGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itE3coW0Jd8ioGbQ90q4xB1KfpPIQiTqpaZQmmyLQ8K7Xu5ABTvhcGAimp7bDsFk3cVc+UxVWxre2jC6WfsYNIL7nWdu/2J+WhJvBSCBPFfHrDEnM8/bgDUz7fwDSlYuMc+o6smJusPfC+tlQBXOoXT2nHawp4z14fi+6aDpSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ECDYyyBC; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso80138866b.3
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729259730; x=1729864530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FtuUGxLXX+BJO2DnZAU/FRczWTGU8z1QeJEe637rGo=;
        b=ECDYyyBCWJQ8/7sL0jc9U8d6osGWZUkGizMiIJ2OvnFugHhIsDEBGqJOAKf8S9G6f/
         81hk3pMB9flVyZBBdH5rR84MfFZM8nMJzprbqo3kI1Mn9vjyfaFlzbAx+4qn8ozRBkj7
         LppX3Kwlu3jIX9N83YN7xk4BgpmzE6IcXoUyMoIeOL80yrFdzK1KDWKR6U6KOE5NnZCL
         VQoZX/l0mDJGogvF39V7P73k6QOD4jXAF3Lv1tTZ5AawmYXWI3DP75eNtpvizAZX9wBk
         3gMsq1gfVnveAqlRRKJY58Kkr3cMzOH5Gw5J3okKyp+RSsfFaRVScell+4rbap4ahTHL
         p9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259730; x=1729864530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FtuUGxLXX+BJO2DnZAU/FRczWTGU8z1QeJEe637rGo=;
        b=fE4xXzEM5moaPEgltenitD4FrWULoOhTp9UcoMH40nsFqxTbN8nFNIE4pHGGSXY8Jz
         JU6+9rXDVCNgM1f7+95gEdQHgwJgK/SADBCOI/KSZ8H6xazbuUHDpdmVzmBGgSJBgleq
         e15vWRD+xy997Y6IhS1kzpQvMv6Gtw5MDYKutOLM99o4iE/3007gvB10nTC763j+Qzsi
         rpLgMhE1ZBBpWIVcMnLrhFGW9rCyE5Lo8scYEMlfkcIZQlFCRX0qg0s+pSD+eW+iJ7xH
         A/CqXHKLkQNrZQwrNnl2XyVRQ90k38vCXlN6hme0ewwHti6fzsdljlrFNRrAXWC4Y4TQ
         RHhw==
X-Forwarded-Encrypted: i=1; AJvYcCXKdg1V8Z0f/lbU5HOG3DKKSpY93JfOEU5bLfTb8mPDB+4Fo5xanE2j/GgvYuPBPyOzlnqHXoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wlKLK+90NNWBCZf1zvnWp/HCTVqdvm6Che+Az7pXXjevc2pi
	tqf1mxko+aRr+m0r6X32NjefTJXCqxetydOxoir8KolVX6/vXFBdKpaJ2Q/wikVZz0g+p14NcMn
	Hxl+41wBQCeHAl8qLhWw/XxuyUCnb6jUN7DLS
X-Google-Smtp-Source: AGHT+IEpv/2vWYXzU3uWUUBqj/jlYiy5qCaj/2e7l5+XAA3lPLouc7t3l54t+HzF55KGXBSlpZlyYPHVBWw3nIBlWgc=
X-Received: by 2002:a17:907:7f12:b0:a9a:5004:cecf with SMTP id
 a640c23a62f3a-a9a6996a645mr202515966b.9.1729259729498; Fri, 18 Oct 2024
 06:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018012225.90409-1-kuniyu@amazon.com> <20241018012225.90409-9-kuniyu@amazon.com>
In-Reply-To: <20241018012225.90409-9-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 15:55:17 +0200
Message-ID: <CANn89iLRR0NnwhoVQdJMT8Q4GCpBkMOusOWomjk6c11kPyEnOQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 08/11] rtnetlink: Define rtnl_net_lock().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:25=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will need the per-netns version of rtnl_trylock().
>
> rtnl_net_trylock() calls __rtnl_net_lock() only when rtnl_trylock()
> successfully holds RTNL.
>
> When RTNL is removed, we will use mutex_trylock() for per-netns RTNL.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

