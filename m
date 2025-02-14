Return-Path: <netdev+bounces-166548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471CCA36663
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B001888F16
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59719F121;
	Fri, 14 Feb 2025 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNtGwCFj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD918FDA5;
	Fri, 14 Feb 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562332; cv=none; b=gzH+Zi16Z0UXevcFj4NujELqIckDnpNKzisBiOaD2oT0WSaBB0bCzeOHTEYqWhC2JKr8PnXG60CXWqDpvO2GhzrLvxOrhqRvU3EuwNbzvFn1r8QCkeGiyHkeVWEGebMmnysJbRIRUIVhQxPNadBeIN5Qb6gquqcC43gXNtNrGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562332; c=relaxed/simple;
	bh=T7u5z+QwRoLy9/63MT1e9QQtU6T14mIbkkv4v5ZJF9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5JN2/HucNlDrs7x9eQRBBjtBdM/wZ+/DVXRFC+rWZXuQszNfTFop9k4p5+szNhulxmZQXT+C2oX4/CE8drzc1WrphP7+I/WCB/PtQ+kG+hOYPA//C2EeYfYajRQBq1AjOPZggvWvwboW075FY1+8BIwSxkyN1sDo9tFMtk3FHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNtGwCFj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de594e2555so3842634a12.2;
        Fri, 14 Feb 2025 11:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739562329; x=1740167129; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZ/jvAGI98iV+Cxun4FobOiX6NRkhqzXnRvGUzFIH/A=;
        b=mNtGwCFj41LLV+Vyg38q6EmDDaLHlH8Joa1pPxIeJyjwH9Pa0+oPi9IwGCVZUx2id/
         HBonGETf9qA7NKUkO/jLyYacn20YAo5Rrr17Y9LdQivtygIpRyFQdPOwAFDDYYntW1V0
         230HYW0uDNcXEd071nAIQeB+V4cpspLl3RbWmwPj0bhWuob6x+9HquZwyG8QSpLwTJHr
         dukObHoEmFwsncBaylmeNnaVkw+j0L4cZJ48tY9cXYOWLowlaxdP24wwuSt1tmJGAUoX
         m3R6GA4GQUPdqomwB/zc3J+T2yMOdvlxD0FJ6d1PzrNTRkGG0M0YcaCODWRh9XxE+zQz
         Gz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562329; x=1740167129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ/jvAGI98iV+Cxun4FobOiX6NRkhqzXnRvGUzFIH/A=;
        b=iW1J4TqXSFPpJH8EV8i6qIKuWar/uNi73YsU7F/TY1HJTHE5E03JIKu1h4z5+MCnh6
         fRzI/+4l01rMze3wuyizWi0Bsf3AV+ZRpaR3BwkIcMqWtlp/+zD7Z46J1cF3p4vH8oBo
         7xSyKOMPmb2bTnBtlB+1/NuyG4KzKC0uH0bVBwlh1gqXaNk7O+lqsqbbBoba/t3w3H4x
         1/G4tY+KZ3NAAM1n/BjC89MONCShF0JEK4GrqGP9yYI+G7pJwgAoQh6B19CP0CDvkfxK
         6I8Ckh3eGAjZ7b5EWXgcPtlRf3Iu4xSzzwhcAJUvuPZlfWcBfPaavIYT0ahhN0WXsrkI
         Z8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUplKQA+8akc6P9DcEO9yrikasmzDofsI2TpXK15Ks119nYyP4xTaUt0bYk3OkK/P9C8S84gnAABX6Pf54=@vger.kernel.org, AJvYcCVvnFb8HtQJ2jGmKGhIamtlcpJPn5Q412LpYcX6DKeJbkq+KLQmsm4VA+Ik/+riOzgOMsA5rbBv@vger.kernel.org
X-Gm-Message-State: AOJu0YyGPkcC+s5u5XEbZqIBclMSj96Jlj9dNBHWv7ipns8UkaaEkAFZ
	LHBLKW+eeUMB1RPwJwdLzkl/saQyaYQxgkkkb5HACcHzqBlvq6hD
X-Gm-Gg: ASbGncuOp2js6fWsgBQbDdMcWn06txQIGWKmP6Zw2sjV7k+xjFkyOW3J3mdV+V/efWG
	blrzffCPdeoJdTWgT8yGoDgBxip76JBzHb4Sx1s6CFUKvFM1URYJEwMUgZoooXDvexX3322jGGW
	Sum3jCMzjBL3+m3sRluYXpKDVQ2zUzM2fS5mA80wKRt30xBCiQgeOHO9TIq8JCgE+KaSGPGRObl
	3Fg0NnareZ8k0g7RnnRqqRkRXfFeJyy8jbkMoqPKZCzp2M8huZn1PSvAntlTg4cPiEkQLSpcI/H
	GGHuiTbky3+j
X-Google-Smtp-Source: AGHT+IFmY8S4CmPnYZPRRMnGarZAay6gLhuzXhzozTh7ogLbaFsihzUpbpbirYdJSoAss3sFAJKZwA==
X-Received: by 2002:a17:907:7f27:b0:ab2:c1da:b725 with SMTP id a640c23a62f3a-abb70bcb88amr48693066b.30.1739562329160;
        Fri, 14 Feb 2025 11:45:29 -0800 (PST)
Received: from debian ([2a00:79c0:653:f300:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339dc35sm393812566b.137.2025.02.14.11.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:45:28 -0800 (PST)
Date: Fri, 14 Feb 2025 20:45:26 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: marvell-88q2xxx: enable
 temperature sensor in mv88q2xxx_config_init
Message-ID: <20250214194526.GB244828@debian>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
 <20250214-marvell-88q2xxx-cleanup-v1-3-71d67c20f308@gmail.com>
 <20250214175938.GE2392035@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214175938.GE2392035@ragnatech.se>

Hi Niklas,

Am Fri, Feb 14, 2025 at 06:59:38PM +0100 schrieb Niklas Söderlund:
> Hi Dimitir,
> 
> Thanks for your work.
> 
> On 2025-02-14 17:32:05 +0100, Dimitri Fedrau wrote:
> > Temperature sensor gets enabled for 88Q222X devices in
> > mv88q222x_config_init. Move enabling to mv88q2xxx_config_init because
> > all 88Q2XXX devices support the temperature sensor.
> 
> Is this true for mv88q2110 devices too? The current implementation only 
> enables it for mv88q222x devices. The private structure is not even 
> initialized for mv88q2110, and currently crashes. I have fixed that [1], 
> but I'm not sure if that should be extended to also enable temperature 
> sensor for mv88q2110?
> 
Yes, according to the datasheet. I don't have a mv88q2110 device, so I
can't test it. I would like to see it enabled. So if you can test it and
it works why not enabling it. Thanks for finding this.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> 
> In either case with [1] for an unrelated fix this is tested on 
> mv88q2110.
> 
> Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> 1.  https://lore.kernel.org/all/20250214174650.2056949-1-niklas.soderlund+renesas@ragnatech.se/
>
[...]

Best regards,
Dimitri Fedrau

