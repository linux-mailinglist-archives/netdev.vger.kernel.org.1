Return-Path: <netdev+bounces-134206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A7299865F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71AB1F2200A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A321C32F1;
	Thu, 10 Oct 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kh70uKKl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589FC1C245C
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564294; cv=none; b=cqUOcrYGZIpGjuBQH6Vnglly8bh0bI0XV4Fu6CLQDVZ8fmn0sUjOOhuyi62x2vw2NuDWr0zlCwdHU+dte7jdxbriCdImqHZi9K72eQs4UQVasXsENj4aHq8EP0n7O7AHm7r6XCqQM1gkC4VJNpq7OJilvqI1YBdksjhBfEj15+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564294; c=relaxed/simple;
	bh=aGYUoFPbFdUihQpaRRopqjJ67pUHWQvGVO070Y5OKEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G64SFRvR1Wf39a0kOzCuJjAIHk3FBSsf82Hcvnv5n2ZSig4Ja0kkJzHgT23F3fl88fsTHlr21BlZNC6BkdCt6pIUdreKDXUtrT38F5vY2zGZzWrhX1sTgxdiM5+ukALbnlGdEqkrgaZ85Z3DA0rZcQXD8WJDS5jkOTzlKPrzOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kh70uKKl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9428152c0so282367a12.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 05:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728564292; x=1729169092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/wO85J16ECTRQZ2LUF6xVReM11hGotYMvlnpbRGloo=;
        b=Kh70uKKlew7DO06ZU7vPOzFecGTqQWEnOUa2eVIYcsXwe3NKec6rSbytXvjILbeELP
         sDq7C8AHsXUtbmF14KDTW+xbKJQa7DMLB5YQyNfJuwJepjlEc6I5v9JT0BY8ljEE5opC
         bSpDq/zEZ8ctIufGsJdSpHu83Tu7IteO+N6n0itnapkYitkzf2M+6zD7JTv93RonP6Sb
         Blrlps69m2INgs4D0Pm9bSaeNQ8aOfN5OxWN+Uw+R3w3Q5f1rmn0cY+lhleSFN2fq8eA
         vtYVUXApEcI4duJ5/I1uE1KeZVHq9RRv268ohg+YiYV0SoByw9Qt+n3ym+ZGps7/wqOv
         07gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564292; x=1729169092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/wO85J16ECTRQZ2LUF6xVReM11hGotYMvlnpbRGloo=;
        b=kECm1wWsLHPsiBwKEP1YGMVC2YltbSbfdUC62dyMjwg9CHPAcXgD6gStm4eWf0vjPc
         Kft6r484KJi02TrJJ2zgr55IC+4YU71WWyCdqvBI5focBCmTEE7Fc5L9fy9lwR8ydJoy
         osfJncWgrTDw0d8aJoayFCmtwkC+0899Sui5EP2jpuQHwX2oevFOpHLrYVGSVh+MhWS1
         ga0EGqEvMcqg6IqUrp4Vkhmix4C6yrqHgGTfMpVRLZXuRNja6ILGA/bu92782YMNsw8p
         28keGx2kFLA0u4jar7xqcG/F55T4iaWdiTDMAt11AtgxPuKHzXbjSUpThQF1XPQ04yhk
         O+sA==
X-Forwarded-Encrypted: i=1; AJvYcCXL3TCNe1+cvaBwU1VzF8u+q4jG+bIrOh5cIhn4fLHJKRNhUlHPwOk51N9/UHOtqzLEKHNPOk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynnzOJfYB/JJOov3TC7ZLQbtNuczdqSW49D5Hu4LRV+iyprbEn
	issgNd9EPenKD6NJPVEe+vot1AUJe+N6JHHx4JkQ1kFwkk3m0+kN9gozuyAyIOdhvPLbUz3fAZU
	Adxv3miOG5x2Inba75CtmumhlcZY9bRrqxaAU
X-Google-Smtp-Source: AGHT+IFg7Z0/XZNPbiQ+UWyK5bijpxb4IHq2f0DxQWXPK7WhXQuFrNtltTLnK2O5gUcPAb010QwOHbIvMq0iJ7avZF0=
X-Received: by 2002:a05:6402:2349:b0:5c8:9861:a2c0 with SMTP id
 4fb4d7f45d1cf-5c91d676b83mr5660846a12.25.1728564291482; Thu, 10 Oct 2024
 05:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-3-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 14:44:40 +0200
Message-ID: <CANn89iJ3UFP7AbiT879fH3ivdmUxX77VVKs-h6R+crzdA5by8w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 02/13] rtnetlink: Call validate_linkmsg() in do_setlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:17=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> There are 3 paths that finally call do_setlink(), and validate_linkmsg()
> is called in each path.
>
>   1. RTM_NEWLINK
>     1-1. dev is found in __rtnl_newlink()
>     1-2. dev isn't found, but IFLA_GROUP is specified in
>           rtnl_group_changelink()
>   2. RTM_SETLINK
>
> The next patch factorises 1-1 to a separate function.
>
> As a preparation, let's move validate_linkmsg() calls to do_setlink().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

