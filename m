Return-Path: <netdev+bounces-133926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208CD9977C1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E0F1F23F19
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06437192D83;
	Wed,  9 Oct 2024 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B/X3ythS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C518B47E
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510399; cv=none; b=XZc/PhUJ2SdkcBXzK37HdHXyz/ifZ65xV31pTjBWuPM5hyW7vHoT5ALfJ6QNcvslnhd16/tpwRxfWInO31yNydrZi7Wt5gKQpdom+VT+TTjQQohTy8dBL8jdJuVIbXUMr7Ze+YYt/IwaAmh1m7cN1UPdvAEkehzOj+FOeJRdeJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510399; c=relaxed/simple;
	bh=LXFQq4cvcSOzmh+VSEJifllaIjnMQkAQDJOlptwZ8og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhTVNzrZgO8L6WcrK8Tk5iyG/ozcW0YEAPjz2PU9ZL64UkSY42Ldn8Vop3TuZ2VTNVvYO6/JBagU4Jfr7xLdUPi7pkAfVMV9N6lBl42qua9c0jrBWmdYGsTXaJm5TbsmO8ySUuFkiarKpNJkuwsrmpkWVB4TDlg1FDXs8IjJ/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B/X3ythS; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6de14e0f050so3360697b3.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728510397; x=1729115197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXFQq4cvcSOzmh+VSEJifllaIjnMQkAQDJOlptwZ8og=;
        b=B/X3ythSrKMI89/NxEakD32iSxy/c2NB9RRw8mVDQbsX2nWcGUqYv78w7jxnuzKMRA
         wlNbaGmBdNAz7o1wvgGmnVXp59HBbt7P4PufIxOH1mJ2DHpdlncOkA5OtYz2NahwW3/5
         b4nsOJK9AzwHYDyqlRAGMCccHzBXvEtaXMiGCmcFyP3L0WWDC7mushMnqwn6nDbUqL7r
         7wTQaTyr/iiHGBNziYX3Zv7rRyWM3s6Zd3ThVCYWBrtCHs4z8z/UKy9w3Izyd5jvDonY
         JNg9K6P/taYyS/sHA5IoyY2m0EjGG5QNA5LpIee6HwJGzd7yFs4eH7HVtFiwiADHQiHd
         UzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728510397; x=1729115197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXFQq4cvcSOzmh+VSEJifllaIjnMQkAQDJOlptwZ8og=;
        b=cmKqMyOXypDW+lxUiUesbzkCxRgTDr5co9qOjYTbuk4DDsfmquvDpa9hZKCfNrMpLK
         wc0sJPSFrV/3/5bQesL4Vse9FG21qaapyICkBpg7v55B2AOhP7xyOZt7r7pa6mlUJ/Gn
         O5XFc3O9F9R7HyQKQRufaVJek9C+FjEYNem76uOuwi3ikrtsCAfKaFgQL5AD8Rx4qB7D
         UqnF8+o6LXTNJikn2gJVjYgv1VnYRo+PysLu/ZiZ84jZq94P+Nlu5sg1Dgb2jS4RLoPJ
         Vse2WCTsIcr8BZhajl0YBp5CdXeQ3+MKfN5Z2rDhGba+3zCrVVBlGrALNaKq7tq6nXOK
         jc8g==
X-Forwarded-Encrypted: i=1; AJvYcCUBgUOKcWkXb1TO2UHyyNEWpgRAVT2ExUppjLNnJL11v20mgC5NgK6nf3R7vXesHx5g6fjxK1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhwbLzGbS9Ik40tw2WMWlduVJdzbAgdq/6b6lO9ndZ4QF+VLp
	94OmNwmovMIb+r7/BizdMRvJpkgSwk9Slmouijt2xzkaIwUDEbErKQNoUtpjOnToW6XwVTQ9Gox
	+mFHfvMH8aBDpICyCU5mO5kbbGf5AQsbGedbO
X-Google-Smtp-Source: AGHT+IE1D5PWRvqXNfRKyWsuevMOAJs9BGWU7JCR6FZfOmNBKloSiRVXNUTMQ9NwlRuQiTFERb3gOsFpYHbfeby7GkI=
X-Received: by 2002:a05:690c:6a08:b0:6e2:547:5e7b with SMTP id
 00721157ae682-6e32219f138mr44127597b3.43.1728510397381; Wed, 09 Oct 2024
 14:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009203218.26329-1-richard@nod.at> <20241009213345.GC3714@breakpoint.cc>
In-Reply-To: <20241009213345.GC3714@breakpoint.cc>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Oct 2024 17:46:26 -0400
Message-ID: <CAHC9VhSFHQtg357WLoLrkN8wpPxDRmD_qA55NHOUEwFpE_pbrg@mail.gmail.com>
Subject: Re: [PATCH] netfilter: Record uid and gid in xt_AUDIT
To: Florian Westphal <fw@strlen.de>
Cc: Richard Weinberger <richard@nod.at>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, 
	kadlec@netfilter.org, pablo@netfilter.org, rgb@redhat.com, 
	upstream+net@sigma-star.at
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:34=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
> Richard Weinberger <richard@nod.at> wrote:
> > When recording audit events for new outgoing connections,
> > it is helpful to log the user info of the associated socket,
> > if available.
> > Therefore, check if the skb has a socket, and if it does,
> > log the owning fsuid/fsgid.
>
> AFAIK audit isn't namespace aware at all (neither netns nor userns), so I
> wonder how to handle this.
>
> We can't reject adding a -j AUDIT rule for non-init-net (we could, but I'=
m sure
> it'll break some setups...).
>
> But I wonder if we should at least skip the uid if the user namespace is
> 'something else'.

This isn't unique to netfilter and the approach we take in the rest of
audit is to always display UIDs/GIDs in the context of the
init_user_ns; grep for from_kuid() in kernel/audit*.c.

--=20
paul-moore.com

