Return-Path: <netdev+bounces-169820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BD1A45CEE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8708116C902
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97E9214222;
	Wed, 26 Feb 2025 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/RDbaeN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96C18BC3F
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568938; cv=none; b=Y1jSAgQQ3kEc2PpO9+llVLP1bSmhJ9kjJy0OrhGor1utwMdwTw/gAnZbmETPiLlKuNFk8BoeTFE0esr94wTrYr7Kks9Hb2XKZ0w83ekGsLUtWKl1Th8/Mfcmt49V6tLfGbN1hP8gjrVGh8AQpQfMdidg4UNHIcMlLo0rSBtlQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568938; c=relaxed/simple;
	bh=5JzikJBbjRzXw0RnW9q48Pq3mAM5rcVX8kLueCrjSkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYM89mA6AsZNtJfiEqKKO8rgaZC0YQdjG0tthaxW/ewnGz4wVe9yrimdKZFzk8WTDKTIEBF4PZUPPl5ibE/d6CTXB3EPVstli4D4WXLScI41mMjWWdFvhTaNB9iivhwnNjBI4D1oW2noG8N06kbfwNAmq25KUxknonE/mUp7ufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/RDbaeN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so9017216a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740568934; x=1741173734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JzikJBbjRzXw0RnW9q48Pq3mAM5rcVX8kLueCrjSkI=;
        b=t/RDbaeNhJ1sfNLCSLgpxD6ZBPOdOmTBovsNGDJyn93ijaQfOO9cQ7bJAOt8uuVgVv
         vPqWNwDKj5/DhtnwRHYlIWMG5yVY9ZIndMnM/UJzfGC2r2kStasBMVBC39hBFGQmPgWh
         5aIdSjldIhKgsqosj/zj+yZuiq1y6OamrZOPIAEpr4L8/wtIOg+QOjxJFBEWBaIxG+Lg
         ciSrQjdd6R4Sf6sNr64kbQlLdMOKgHlbmLelgwchBe/mz4HNRuwq6Cr7fawo+n3CiN3r
         q+MJ60l36DtOULMqmYzeV6LJZvBSzfQ6hQeODmqPfpxrLdZ+dNd29woBlyekw2OCWQ0H
         sqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740568934; x=1741173734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JzikJBbjRzXw0RnW9q48Pq3mAM5rcVX8kLueCrjSkI=;
        b=bXAOAiEmTJlJQC41BGbB7XQrxGYdbraa9yKn4MePXLsuapiNe8emgUWhLX85DyiL9E
         gPK7rfy38TyM42UGn2YRZ6ivj8HAxasVUspovIx+xX3uriRayNGfg8f0DwrLrfG6StEV
         heHMUEEVxoxW4h4nWQCjK/h4Bbgoi03WP1xz2u7kijW9ps6Xw+MpzPfsrFU1m5Ar7I7R
         E3EbGq8nB/IyjU0Qfi5KAtSZCPWEjhDBN5tKOEEJnsdh2/9AzZTyb1LbOKQoKcaN0wAC
         3U+OVevahIyE223mQMRlWEcTuebi0uCow7xfztFqtJdo6U1+Feqxq36ERBvIcl71TXLN
         9fAg==
X-Forwarded-Encrypted: i=1; AJvYcCXTm+HNJxgipY9REXD0i4+8EBZ8N1z/cfgRcIJKhQb10Aq6sLBtB2A6MrrFBAU+D7uis+4bPNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOx3TiwVE+LNZz4jqx105ihcGoBVbUnhbhjfukMHori3zTkQ5N
	H+DxFr07QNaMjobKVz6rzfUhFMmT7R5VWpSYfUiVncCGoWmMMWkaA55e3ZUsreVfunUz5E1qd2R
	8OK16kUFfd5Nf7Gd79yNlhO4HXAjpYPWe8hwy
X-Gm-Gg: ASbGncuIk7Ggh3m/YlQ663EGBw7thjkc6siMENlMYr0+iR3yYGVhbAznS97SUsFS12U
	FSQxXALK+sGESI0vTfZLZND9j0lZ+m5jgHXtJMp4F1heY+yQscBqUBrAwHO/6AeFv1JXj3Ty2bM
	unD+piy/Q=
X-Google-Smtp-Source: AGHT+IF9jiBiUZ+XxtLl7o8RBFNEyP6DCs/c+IwkMBOBYq6kcdkIVbH5btZHVn+kRBywAFcPlcqltEYFttuiuNsbd54=
X-Received: by 2002:a05:6402:40c4:b0:5e1:a37c:7ebe with SMTP id
 4fb4d7f45d1cf-5e4a0bf22cemr3120786a12.0.1740568933993; Wed, 26 Feb 2025
 03:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-9-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-9-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 12:22:01 +0100
X-Gm-Features: AQ5f1Jo7BXtKBhBIKevEMe2jUV35uZn_ywmjWywiHuPxmPqqFCkBHBH_pNFBCx0
Message-ID: <CANn89i+LRXpfX-Hh0oHPKBHbona-g8XjxANK8icWs9i8tfJaSQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 08/12] ipv4: fib: Namespacify fib_info hash tables.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
> Then, we need to have per-netns hash tables for struct fib_info.
>
> Let's allocate the hash tables per netns.
>
> fib_info_hash, fib_info_hash_bits, and fib_info_cnt are now moved
> to struct netns_ipv4 and accessed with net->ipv4.fib_XXX.
>
> Also, the netns checks are removed from fib_find_info_nh() and
> fib_find_info().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

