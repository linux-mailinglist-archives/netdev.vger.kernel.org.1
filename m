Return-Path: <netdev+bounces-130848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4F598BBF3
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E7284A3A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A51C2DAA;
	Tue,  1 Oct 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rY1ZEzIj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2731C2455
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785137; cv=none; b=haM4VX4Xhk7J2QDz/IwsRmFAsPIeHnpqebf2FKoxgI4u7O8wFoekD5DWW68kTqY6uZy7NYR5y+VGxXeCiswjukOJtu/IcUypZNP429VqHeSPewcV8Wk0DRvPZpAIMu8UXdCu4cVYvw9JAOMhgtiYelLMp3xSKtbXYDVW2eQMbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785137; c=relaxed/simple;
	bh=exD/W91A6KTrKgI85hjeq/JC4z1YFQjKc8gZaCQ/5ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1VJ0EUXVK86RDlGFlbWv5MKy+5zHd8tsCCdEa6RhPrqG7LKYZyaosT8YDh6fUZs9aVy8snMiZ5uJfL2oUK1Gk3ifAXcBfqC2fRP5bJsUCwJSltjmAj53aX6LCtYJtsUVjfyazQ6yRUaFfQ/iP91Kq6WU+bwjY3Cn16TsKPlfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rY1ZEzIj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso156317a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727785134; x=1728389934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33gVipYBrYxdgxy8Ey1LVUIGXOqD2SvOvxAZE25/hBM=;
        b=rY1ZEzIjzc1CUeEK0xmDw5nvocpwgIJ7aUr7LevDag2YyEsTlelpMhgrQ14+Gbe0t0
         +u9/VmFEZaccrQww+/4Btn3EoHu0Rfa0kex3f5NXNh3J74GUGj26nN4HGkLl9fEb7HVE
         jin0UbXsIWa35fGfOrZAZvnQ3z7rJEwHHn4ejPfIIURiFN8ctej4TtI9HxIEAcb8sQ0J
         Qn6DwIrhQzb1szFzBlIt6AUvGWWIqsbIWyDtO4LEQGe69s1Rt1cgnVqbddMEJKOheXFP
         /5/84hsBpdDA1vcaQ1ingGFuAIbNgGyJb8uNKdqH04NUcZFwjUhzh4fg90/aTPYLjebv
         MTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727785134; x=1728389934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33gVipYBrYxdgxy8Ey1LVUIGXOqD2SvOvxAZE25/hBM=;
        b=rMt6y5rSqCTmfAGy4MVnr+Gsa2MqbuGSD02Dr2J+WcCLtXbFhvG6ITB0ND8BLjVeJz
         Jc/08caYjXTm+ovFFHV2JouZF4cRpzzQL5MSjZIFHOolQlcD26eDcPgcwKXv1df6Ei0A
         CYqJZTNVy6ZEl7Ky+8bY31Xm9w+wEimSC7S00TwjeMILL7b2tse25rEEx/vbr7DEpmWe
         DoG7e3Xebi+7/e1T0PoASBiLb1DdkJLTEuwTDvOd6NukqSMSECzZk2V3ia+U/3b/rqoP
         wprA5d7qHD92Uzow4vE5lM3lqb1Ne87+If3lNzvke+l4qcuxt8VgE1ZBl4TN+5AlyuYX
         THzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+AkTOYEcr/k2rjuzgEBPm5/3GutGgKhy6Hb7kgCBbRn1ZhL53yCdaUHRWpSrSnubXXPyOA78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpiHk6My2wjUFvhShw6QXZE6+TFSGOqzgsKPJTh4OzQg+GSuM
	WFnbBG+VeFxCRSMfpoMXI//QSnvM+Syum+QO8iXhpRMZwAWFtAh4tzPiJw946rcwHWT+WAmUBVI
	NtH2haaAG0smTK7rG3mUxVLCTz2WspxiGQT47
X-Google-Smtp-Source: AGHT+IHIo8cO8K0l9LocwHAXilnd6bZmTK415SF7wqoT/cc91xuzRjXUNCTODZLKZyWa+gjTM3h2uEw8ktwAiUiq9O0=
X-Received: by 2002:a05:6402:3811:b0:5c5:cf1f:4433 with SMTP id
 4fb4d7f45d1cf-5c882603b62mr13532077a12.32.1727785133701; Tue, 01 Oct 2024
 05:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930202524.59357-1-kuniyu@amazon.com> <20240930202524.59357-2-kuniyu@amazon.com>
In-Reply-To: <20240930202524.59357-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 14:18:39 +0200
Message-ID: <CANn89i+KoYzUH+VPLdGmLABYf5y4TW0hrM4UAeQQJ9AREty0iw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/3] rtnetlink: Add per-net RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:27=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> The goal is to break RTNL down into per-net mutex.
>
> This patch adds per-net mutex and its helper functions, rtnl_net_lock()
> and rtnl_net_unlock().
>
> rtnl_net_lock() acquires the global RTNL and per-net RTNL mutex, and
> rtnl_net_unlock() releases them.
>
> We will replace 800+ rtnl_lock() instances with rtnl_net_lock() and
> finally removes rtnl_lock() in rtnl_net_lock().
>
> When we need to nest per-net RTNL mutex, we will use __rtnl_net_lock(),
> and its locking order is defined by rtnl_net_lock_cmp_fn() as follows:
>
>   1. init_net is first
>   2. netns address ascending order
>
> Note that the conversion will be done under CONFIG_DEBUG_NET_SMALL_RTNL
> with LOCKDEP so that we can carefully add the extra mutex without slowing
> down RTNL operations during conversion.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/linux/rtnetlink.h   | 13 +++++++++
>  include/net/net_namespace.h |  4 +++
>  net/Kconfig.debug           | 14 +++++++++
>  net/core/net_namespace.c    |  6 ++++
>  net/core/rtnetlink.c        | 58 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 95 insertions(+)
>
> diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> index a7da7dfc06a2..c4afe6c49651 100644
> --- a/include/linux/rtnetlink.h
> +++ b/include/linux/rtnetlink.h
> @@ -49,6 +49,19 @@ extern bool refcount_dec_and_rtnl_lock(refcount_t *r);
>
>  DEFINE_LOCK_GUARD_0(rtnl, rtnl_lock(), rtnl_unlock())

We probably should revert 464eb03c4a7c ("rtnetlink: add guard for
RTNL") because I doubt
this will ever be used once we have a per-netns rtnl.

