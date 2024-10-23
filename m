Return-Path: <netdev+bounces-138311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F19ACEE5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AB61F21B6E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFD41C174A;
	Wed, 23 Oct 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8V4rNZR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB71ACDE8
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697697; cv=none; b=avF/63p0uhWXu5oJ9HuKIgIUzf6hcEVOOdIOel8sMa2FipfBlrJUUc2JtdoBqcLy5gH4QrU7ts8uyg+LtT3huS0nL5MxjD1Q8VeTxoRalVqkT2uD+iqiVIUOJGwweH0Fxi4C+2WDMurIy5hHAL0aPUOU7ZaWX9bGugpL3YjUYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697697; c=relaxed/simple;
	bh=/s9HW9dGv14NV4XVNza+0FX7UHSWaYuZts+yDTSVlcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjKXcR+dju6i1rVDEACXc7Nw7u1geomWJUODfZjbgxF+L5HLF6DD51bCG6d8al8GAz0onkfPgbY97kerQ9imv1UDjtJYbX6E6435VOgdKM75riZ6XdKRGxYbXUzggRXOGJQ2FuQ0B2R5MYIvrxVDdnyZ21PXcyVcKOa1uoNlYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8V4rNZR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9acafdb745so64884366b.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729697695; x=1730302495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/s9HW9dGv14NV4XVNza+0FX7UHSWaYuZts+yDTSVlcE=;
        b=E8V4rNZRD1ztWIW2odM3gzEwiqbiLRR8CXa0rcSz6XyK618/4/miTXrpNhik8TWI3t
         rVcAHCqmhYWt6UXb9ND68+RYFGavykG+MSW22OIgF4GxontKXxndr2YC2sfSJ/PlMprQ
         dhY2br8t45wFqhkCDzpueAz8ofbetxKVYtgYVtz6GF4+mjNkzOOm+MgLlGFWQZExftn3
         rgbLwv+QS980rJJrwUT4+aFPYmcOf0me+pUA7ZswWlPcetXVY/5664DVJjrqxAC14rba
         yOldHWKKwrKk9S+QztvodtR98HduCiUtsCKscfSeUjSAiz21S4s7+4QOTcPQZioeFqjR
         FTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697695; x=1730302495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/s9HW9dGv14NV4XVNza+0FX7UHSWaYuZts+yDTSVlcE=;
        b=tkjTYk3Wxz7PtiER4SG6B1WNcYyaxjODKDi88/xhFhm9HMhILlmWcJtCuJr1iF8a1Y
         68RHMYJaEx+Q7vYBqHcpsFw9i9uHGm4bOCH6Zgc1Q+7d7UPGRT66PVwj9CEFBIWqkmf3
         tCgeRJ0uJDHacjP5XUDEG/KLaUhZC+RQ8NquB3YCFUDjnqL0YOEJBbJ3gatS1R0+wfP8
         YqfZqB9zuZBrgJg0DhCbU11y5CmcL/Bd2kts976LpOIsbi8JOuHz6FZvxjcKv7lOuBF/
         WiR2hGv0Kz80YxYxcsnw28yAt+Ah4+mpBkFyNa4QJCNGNeMPPuLhlpIlJQ+bQdhTef8O
         /Z0g==
X-Forwarded-Encrypted: i=1; AJvYcCUrdxL5Ov/Z1wUkxR85pzhmOZS2/pQXMSZDCA14Le4wAXCEwIgGsLjCaf/w0F6uY9Qu6Cwv4sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB8OO6WRwtcEpZUZk1ELGWjof0mX5/bz2syddpK/x0cmUpu6MU
	cknXpZl4FwUamQjaIt5XNEWRZ4DdXTyGtq8PUm+HnyHquU7flfK3fD+lvBQx2+TdFDBUdBqVhJY
	z0N1mkhlsJp80Y6KTlrNlYKHfVaRfjuAxMEqN
X-Google-Smtp-Source: AGHT+IGONfFqZHs6vUTcfzg66BfA92KmrTP5ZRAYQ5MqeNiXa4xTToaTGLnEBRiEXxIAj5+GUk7O1CtoAxcZ3kpRaZw=
X-Received: by 2002:a17:906:da87:b0:a9a:130e:11fd with SMTP id
 a640c23a62f3a-a9aaa4f4be6mr833527166b.5.1729697694438; Wed, 23 Oct 2024
 08:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017183140.43028-1-kuniyu@amazon.com> <20241017183140.43028-10-kuniyu@amazon.com>
In-Reply-To: <20241017183140.43028-10-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 17:34:42 +0200
Message-ID: <CANn89i+vfRjHvz5eYmMpxz+qVZi7vquKRsWNQBufOVGCkxUM=A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 9/9] phonet: Don't hold RTNL for route_doit().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Now only __dev_get_by_index() depends on RTNL in route_doit().
>
> Let's use dev_get_by_index_rcu() and register route_doit() with
> RTNL_FLAG_DOIT_UNLOCKED.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

