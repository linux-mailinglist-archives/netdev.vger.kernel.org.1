Return-Path: <netdev+bounces-207553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FEDB07C2A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C15A5836EF
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899552F6F94;
	Wed, 16 Jul 2025 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3wZaUD0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C62F6F92
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687453; cv=none; b=GhAdg1YsOfyahzGLSuj9SWiAbTZlv5tatQZP1lXdBQf0zo0mTIMimkwugUk3YvIVDwloLgcE1KXQ+2ftXe8gEfvLZuTxUYosCQeCvxX1RkBKx3x32ry+EBWXr2x/J7E0DUAZnaK9eU8W20iNL4x3u2O+Giq3XIYCC8CvFO5tBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687453; c=relaxed/simple;
	bh=clan/sxhTicsqHwu7ouKa5VOxER+iX3EACQ/Lf9yoX8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JCYzleLio5jyWOyH02As92VAygEo3Ppln45kXJvyBDblsNEWTJrtRo472j2LJ4ecjK2D2pc/QY7swNUO9vnkIWL45+bo5WF9aIUN29N2Ki416tDV32VU/5g3KKeAnDqgOjJhkZkgIxN/Q234lLoUeZ5IVPfLV9HsXyPLapa1XK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3wZaUD0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-711d4689084so543997b3.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752687451; x=1753292251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvvzgtuHknsZtBklBqpqUC6BxKpxnoj0m65cICv2QYg=;
        b=E3wZaUD0vofWAuneAQ60ntJSahdqecz/VNu2KWNQcSZ7Q0Fh4+42OGzFsq5259AJ+i
         mpGpwllYbBb9qz9qd8jYbWexkQQ3mci7cPu9KqkQl3YN44kCe2rjtXv4JjpR41vZX5iw
         dfNzA/v8IHqV5l3kA0LB4aYm4yhPJK5m4Y4tokxn8KJnbLHp9ksfT2FZS/vG9gjYjJc5
         NI/2VSnQPELL2F7KfBV4jZJGYwltHYH5jPrGcvPSazIWKpg69vRS3pL15ZW97LEUNYoB
         vJw1VXUyRVseIVRVaucHkAUQrImIms/fm+6pzsALKSQP7z6J45DZGTURp6DiQOQHWUgv
         wh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752687451; x=1753292251;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dvvzgtuHknsZtBklBqpqUC6BxKpxnoj0m65cICv2QYg=;
        b=oRNJGOVgAl0+dPIM3xvOjF+hlTV9WyaMysNeJz9SKWMM/gB5rfpdAbwBEEiGP5367c
         sasx774JZO4SjkuxfDNkA7qeuaYoQhGAzxN3z6CaNPJFigr0Piffbq+j82KMKIeHxZPg
         HW+COf/rjTqrfWI9oWxWr9PjcpY1FULy3PWbTVvosSiaPu6PeqroUTfea40EfQThnMHD
         7o6qTC3FRt2p6TJMTUBaQeWbtgpR4KTQkckAMmw2t55OLNEIOLJgVBX+YFA6utHXQ+sA
         VyiPt5Z5yIUdFoDPruImJYNkJ0IOXtmRf6yNjAtDIYHxVjYSu2Xb/yWFE6zwzKKUV6z3
         JcTg==
X-Forwarded-Encrypted: i=1; AJvYcCVz0I6CMRqSu5zjS//fozUw90+1fFVZy7mlKxouyjqn/oGIWStZ6X8fcuBgJqZ3qNontfom1i0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Vk6FgiPo7WBdgPqfxLaW7CtRuKSqF/IJslz+CoWPIhI7eoXk
	IzUkRgw6OaYrxaRCN7L6Yq7mkmGVFMwFO5RQOQXaMlGQP6FP0a0uR5uP
X-Gm-Gg: ASbGncshVlbduVRnx6K8PJQhnMo0NSl5Ttc/1qpXp9XUxNoP8TYp95TAIdMuQo8OzGl
	1P1RWSuQrWbbidqHWv/3CnH9tFF5vxLYE7GOmxUCRg5zomZ1QkC8zfo/ecTO4r1FXIbMPPxBPwY
	iVXWRLLb+TtwSCqk9wZJ1WM5JxEg8wx8wBbECjLlv/u6+P40cAicG5YYFhd07A0HnVXURhXlA/0
	9pg4l3CqpPqi5tql0GDSyA43vRiHzzlETqFB6VbSjxJx2KDOWsykjQfLC/bx2kXrZibRYRwx8vO
	5nNikAYd2o2bcN5v4ECWcK/YON/TI+0iOZMoobhFz5rzKEv7V/cCYWYYHKqEcRt7fYA17euuIOC
	KNTzYvDLNvssqcP/z3R8zMdIjV/+rRdR2/Hk4PwGorTwvBEuZWQ8/wXemh7NyDXqADgOgjA==
X-Google-Smtp-Source: AGHT+IECchF7TqcOEKq8BvdIySIJPBb1U8e3+w2KGVYk+nX/WakRj1cH71EsDzA2S2aViX65QDrv8g==
X-Received: by 2002:a05:690c:708a:b0:6f9:7920:e813 with SMTP id 00721157ae682-71834f35972mr58152097b3.4.1752687450916;
        Wed, 16 Jul 2025 10:37:30 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c5d72fa6sm30166767b3.40.2025.07.16.10.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:37:30 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:37:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <6877e35a7b12_796ff294a6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250716144551.3646755-9-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
 <20250716144551.3646755-9-daniel.zahka@gmail.com>
Subject: Re: [PATCH net-next v4 08/19] net: psp: add socket security
 association code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add the ability to install PSP Rx and Tx crypto keys on TCP
> connections. Netlink ops are provided for both operations.
> Rx side combines allocating a new Rx key and installing it
> on the socket. Theoretically these are separate actions,
> but in practice they will always be used one after the
> other. We can add distinct "alloc" and "install" ops later.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

