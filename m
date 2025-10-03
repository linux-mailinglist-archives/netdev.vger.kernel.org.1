Return-Path: <netdev+bounces-227745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8EABB67C9
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 12:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 010D64E3ABB
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 10:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816572EAB65;
	Fri,  3 Oct 2025 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if5H8jHK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B52EA486
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488691; cv=none; b=urFwpgBADEVvgm+JxfT5u/6DMgIHnMtb+weggiVS/iY0pumUOpt39MTtOrUSFrpczm4nc0iJR4dKfxSQJhoVU8wRt4AWlKE6CBdlUelYUsk/jn5c1p2GdO88MlkCH/7xlwNk18jOK7gF22VNhIo7eYJ4kW7ynnQ9zJwjhlIUNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488691; c=relaxed/simple;
	bh=7WuQvN47KuHlxwLh6G7nSK8xpgJhPrN20X/kb2POtC0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ufOMQPJ1MRkqcr5Dubch5t0raBGKdwQm8U17MW8epbAhVPA9d+N4hTAwob9G2OvBNZzSIp9jDduTcHXLDOKWQ3+undJv4yE77YBXFUz0mxzoHUm0xFhBJ0pAOzucmVlOxKWblreu188uaTTTbA4cuADZjGqRvBNADgVXx9qxlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if5H8jHK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso1535520a12.1
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759488689; x=1760093489; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZqbWA0IXZxSaSS6yEesjjunZ8q/gDhE+C4uxmvRgz8=;
        b=if5H8jHKV5hp/39fO7rge7OEiqFDBY2xYz46avQgGzkMrpdlIS1W8HW5r9RycOOJcj
         SUYt4mJOe+5BHt8bH7oEwaZ0YLL1NCZ3L31YnyiU/S64wAkDANvTDUbk63Ax4PaBWq2d
         HecPBa7I+Z95/qHivlYgPsjvZt3DYPz8MMLGLz+rXutwnz9rcKMrjWOcTM8HWZ6T/MuP
         9OLbB/eZfWsPX4YuwKGYCFEPxvaOZScDjddmFtevbjd+DRwGqtGWQFVWRfS1aNtWILVv
         bEuSfFYtnhlourWB4ccS5wBfW6ri2C+xbzDaSQB0ieUWwknrqcq+QoGGDq7jogKuN8M4
         x9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759488689; x=1760093489;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CZqbWA0IXZxSaSS6yEesjjunZ8q/gDhE+C4uxmvRgz8=;
        b=GP8/lIDc/9YSDS0TRi/35VHh5Bd//La+FX+R2dZMbWVyYs8QIMh+i8nQ0OBgtTAx1r
         0A56qdciKGgZkJhOJaqJrRUfPy9iFpWe2B7yTj7n1GHAAYXPixlwooUoxnDBwjVR1oat
         kvUZ6BDw1Ogk9lkFxIMaW3zL9xd5JQr9/Xx+++9alt5RZFeyBCaLeJZSTOSIWsUWsqqX
         8U8eZJFUu4PLxYoj5gWjFByPdFwExvOtvG3nFNL62U2Lt4STh8Ro2hdBJWVq0LgkX3Uo
         33QVhtxcjmRDTCXZl4H2AyXDSgT8tv1AFKZslG0Q7JOfpKkvyRQc6nmkX0uoMDJ3vkmn
         XI1g==
X-Forwarded-Encrypted: i=1; AJvYcCXfRhQeKN9ygns8Hv8lgNA+9SRYKWoyndiTOmr/Cwg2G6jWFmACK0AkPv+dvbHTutAhq05BLwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyivFut40QhShSDyTtPGvlhlhXumV016J8Z2MtnNvEytodqKOfh
	pwMpoVsRNsHOxNjnHBFW3mHX26F70gQ1INnF1NLWIarRs0mv6PVkQu9l
X-Gm-Gg: ASbGncsEVMFOR/lDTTb+KnIIUMej4unVYJ8OgsaF+UQKO+MEG5akMOp7vWf1asYLyXM
	bq0XtSiAPFcgKy2JJLlM2p6JvZdsARXaRNCnkoW0W99ICIgrX4dZIxdOinGSDDhck8epo9mjRb6
	qlcv75FL9LpS4c+6sGdnxlIForK310LPC48hYRhCxsiyTLfEVf7kax1bBA+3nZ4+NR1UmxxWs0x
	sd6rjpfirzGWmmZjMehBe3kgZvwwP/QEbQnaadM02Tlq4VviobapDiFEVSggWkYnOrpjSuQEOHh
	CQdqyjI6PRUQjFU76L+zv9XBvKAIP3DZjCNomDDpDcGaWaehU/PWfhwBewBVvzWVVH+OViu0lfr
	9mrbOuvSyQvV/jjB1SwH3I+9n+Aqw0NekM4MH0yxxtPk=
X-Google-Smtp-Source: AGHT+IE019qLAGqT7xhh+U6XQyWt1WqJ6du27GF4XNEYndo9ZUvlHYAGBIV5Qn2fBOC1wrpWm/3mZQ==
X-Received: by 2002:a17:903:41c9:b0:27e:de8a:8654 with SMTP id d9443c01a7336-28e9a674da9mr31151765ad.57.1759488689195;
        Fri, 03 Oct 2025 03:51:29 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d038e4asm47405025ad.0.2025.10.03.03.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 03:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Oct 2025 19:51:25 +0900
Message-Id: <DD8MONMKM9ZD.1PT79LGCA7U06@gmail.com>
Subject: Re: [PATCH net] net: dlink: use dev_kfree_skb_any instead of
 dev_kfree_skb
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251003022300.1105-1-yyyynoom@gmail.com>
 <20251003081729.GB2878334@horms.kernel.org>
In-Reply-To: <20251003081729.GB2878334@horms.kernel.org>

On Fri Oct 3, 2025 at 5:17 PM KST, Simon Horman wrote:
> On Fri, Oct 03, 2025 at 11:23:00AM +0900, Yeounsu Moon wrote:
>> Replace `dev_kfree_skb()` with `dev_kfree_skb_any()` in `start_xmit()`
>> which can be called from hard irq context (netpoll) and from other
>> contexts.
>>=20
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
>> Tested-on: D-Link DGE-550T Rev-A3
>
> Hi,
Hello, Simon!
>
> I am curious to know why this problem has come up now.
This came up because I have the hardware and recently dug into the code.
Until then, it was not considered an issue, because nobody raised it as
such.
> Or more to the point, why it has not come up since the cited commit
> was made, 20 years ago.
I think there are two combined reasons why it has not surfaced for two
decades:
1. very few people actually had this device/driver in use.
2. The problem is difficult to reproduce: one must use `netpoll`, and at
the same time the `link_speed` must drop to zero.
>
> I am also curious to know how the problem was found.
> By inspection? Through testing? Other?
While looking at the `dl2k.c` code, I noticed that its logic calls
either `dev_kfree_skb()` or `dev_consume_skb_irq()` depending on
interrupt context. That logic gave me the sense that a similar issue
could exist elsewhere.
>
> ...
And read other driver codes and commit messages, check `networking/netdevic=
es`
(.ndo_start_xmit), enable `netpoll` and set up  `netconsole`, read
`net/core/netpoll.c`, read comment in `include/linux/netdevice.h`,
add countless `printk()`s, build millions of times... and so on.

