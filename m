Return-Path: <netdev+bounces-101045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4368FD08C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2571F26BFB
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7271755A;
	Wed,  5 Jun 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4tISxFL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5015AF1;
	Wed,  5 Jun 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596829; cv=none; b=rbmsAZIN31JV+ZTWzfy819Mehsz1iYOZT6h+hkHeNSfiWKmoiAqpEpPRCLXN30Six4LBzEQ52lXdkOh3tkg4rVu/tUXuCgE3dw+jsN6ZeMFJsfnWhnN6Uq0MMUl+RLWfUKGbNmgN70ZqNpYoPURJsEqjuOi/PQxWGuyMnvoo3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596829; c=relaxed/simple;
	bh=GHFmcIWwlPHBK7h/YNeH5HkMcMTK6uPyOkIxmyzATy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLsyNywU7mVpQh1MWeENgLPN5lxix1HTlV3QrzXGf1wZKN3llToA03OGTnioveCqANvZJZ+9Pn2YTvfq0BKPhwDMWfENEsHR6PK1NS1TSXM6n+OghY4Uk1knvCTd5Xv4RcBadIkF4gHx0cbwYRzpeVzPB9ZKzqM/z5vgDyJ0FRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4tISxFL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so1894815a12.0;
        Wed, 05 Jun 2024 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717596826; x=1718201626; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vbzuReACK7at884YBCFNwf/OFIdQJpCwqd1m+LraEcI=;
        b=Q4tISxFLJ6hnBrmI8f8olJuWorxIrRPaX+gHMMXODuuGMG4ioMxv6AfbCn+HnV0NPC
         evvdx5dSEWfkipSzIfTH46FIn1DXsyOWYTtkTSnxYoko7pBdm5I5Xin4UZwV5lPI2wCO
         VKGix+A/GMJSISxf88/vQ5KX4ZSaWdpgFl2MwJ5gmALQc6zGOkidKbfrM4r3cNetJ7Xx
         CvaFPnjGut2GaaqoaICI9Udiqfbct5rq2OsgqORvpiszuZVbRotJbakKPIR6SEd7CkuY
         MuR+EnabnDJ/tMbbNd6h6iYYj+p0DP1GlHD1+Ov7PMCf4e2C62iHhRa8s6YcZdXydnlV
         2xEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717596826; x=1718201626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbzuReACK7at884YBCFNwf/OFIdQJpCwqd1m+LraEcI=;
        b=xPDxuHQQoln9YcZZheD/qULJiv9wHR5lAH/1EU57NGVJ/w19uk3PYuQs1bA6iBk9OO
         e+mlmF8r2axPrX6M0ZQiWiePImDr0twPlb5HLuoHa7BrDPhjjNeNNdt1vLk/uaeDUy4+
         1ruXh/o1eARVtfzrorJZCZ/rkUrgr/wbJaEG1jYtUEJU0pzReYZL90CpEhvPZsnFtNxy
         QbsOdHN8UjE5t6wEXpvkjP5F0buPZgInuPGiPoaWEVx8Hsd/6NgamzdcsVgmt0qLosDE
         gwabK3B7gKHz4zqCmJoecqJ6+vSicUoTP4YWxNh3k+SL81UjuPko8X3aUPXUsDM4abBt
         dcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkt4qlYIHC/kkEjRcsBmnsotRc8jjRdVH6etgVB0pcK1PTy0HzoNeZrF/HaQC6iuc5hHpmCVjKhUN8HOcHFnLod2dJnlAbYUGmJ3ZN
X-Gm-Message-State: AOJu0YweUI+vqDjPgL0cf9DEQFRGhZJvXhxwREtVni25DhAaMGIlbE7u
	2LipAms9mLEOFtJo3xPEHWTMH56LApb61gPAXTyyjI1kBatxJCix
X-Google-Smtp-Source: AGHT+IHAMo4apfMNgMERqpXvmQyB0/TJQA9cp05lft7qdGZN749NBW6AOL8GMxa/Xif8hkOW4DukyQ==
X-Received: by 2002:a50:cd93:0:b0:572:2efe:4d14 with SMTP id 4fb4d7f45d1cf-57a8b6b88d1mr2061068a12.10.1717596825684;
        Wed, 05 Jun 2024 07:13:45 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a95ce2825sm1251442a12.60.2024.06.05.07.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 07:13:44 -0700 (PDT)
Date: Wed, 5 Jun 2024 17:13:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	trivial@kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH 2/2] net: include: mii: Refactor: Use BIT() for
 ADVERTISE_* bits
Message-ID: <20240605141342.262wgddrf4xjbbeu@skbuf>
References: <20240605121648.69779-1-csokas.bence@prolan.hu>
 <20240605121648.69779-1-csokas.bence@prolan.hu>
 <20240605121648.69779-2-csokas.bence@prolan.hu>
 <20240605121648.69779-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605121648.69779-2-csokas.bence@prolan.hu>
 <20240605121648.69779-2-csokas.bence@prolan.hu>

On Wed, Jun 05, 2024 at 02:16:49PM +0200, Csókás, Bence wrote:
> Replace hex values with BIT() and GENMASK() for readability
> 
> Cc: trivial@kernel.org
> 
> Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
> ---

You can't use BIT() and GENMASK() in headers exported to user space.

I mean you can, but the BIT() and GENMASK() macros themselves aren't
exported to user space, and you would break any application which used
values dependent on them.

