Return-Path: <netdev+bounces-101064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36528FD1B4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0AFB22EEF
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624911773D;
	Wed,  5 Jun 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb2PPK7m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8033D2E6;
	Wed,  5 Jun 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601500; cv=none; b=hCb+kTXLFO4jikbIy/xcE8M9UJjitX4jSuFRwyO2htp6rmorW3tBptV0JKswUbZXOoUGFyBOUQUhh69aNZzPqTxyovDek7SsHoo1pPBpka4sszfvvbRZSOBTtmDrPcHO9FC8QsRxBTgUsMUIETMlOBm0JgnowBzUeaVI6QJautM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601500; c=relaxed/simple;
	bh=By8UN7bEgE6tHMTsl5RtwzENBGGtoe2bMTEaO/znMUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee6W0guWLQThQ5rFmkPILgNp4pS5rTM0Jr0bm4pKPylcNgYxe+oV/9ovODQkE11XpevarA9E5f7aFqt9RSzHynYSqu2F5SaSD6HIkFr5owVxZKW9r47cU31lQ1AOWPjSxSQ1vwfsftJ9pApn3nQUCz1zF7LPCNBJvMwhf2KPNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb2PPK7m; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b962c4bb6so5962930e87.3;
        Wed, 05 Jun 2024 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717601497; x=1718206297; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8UVI+FJG+cytwZoj1NugeGBUyl9BCIHH6pWrnkmyvyA=;
        b=hb2PPK7mBSNrQ/oXGhHUHSNYG5r/FZI+Yc/kcnMpBBD3PhZRMJlIM0bNcXUVF5ktLt
         etITPYRV45lN4acva8vR3rm5kDZfgVh2vSdr79py0AvRadZH2u8txPloRzgi9m5m5+5l
         B/kZdqpZ0brYo0SNGK722mOjj+jgcnYWpONJL/U6RQ4C+G8qtPk5tBAfcoiPbxti1O1T
         0Bgspnr9JrJIItA1ZhnahZqkfAokNLHakorOU4JsLU7iNv3IQQEPFjJlNekYL41RPj9k
         Km/ET5PkOMOg94g/T3RFTX4ZM61jZowICCqbjMMqPWdKfhjtrQBDDhxWx4yDoS8sUhTd
         OCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717601497; x=1718206297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UVI+FJG+cytwZoj1NugeGBUyl9BCIHH6pWrnkmyvyA=;
        b=m/32NRFUNHB17iREBkQspIQhf37TNFQUqJlvR6bmVOKsuUSyslLQjRi5UhReCet4lD
         wV4llt6h1zHp2LczJP3iC3sw5W8Z1zzwmCMedlbpjFoxYqzkpfHw8d8adLC9ewwGYBYC
         jS8Mmt6iKgYdTz937BXE7EJ8MmhcIpZFirfacYORTCuSni3fIVWEguo8fLOVH3glyPi6
         WZlyCcANBiqj0hoEUkfFwSyp9iLMLe3PGJj75RpPMbtxFOfZY62JBDi2VWju8YWqRNle
         vy7k1DP2/4awsrQZB3OL/Uw4c6VjahgYOlU5TFNFgv1SvACJR4Q+plKZzlgFTU6TIaZs
         GH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/dS+0jwGFY3Hz0Gs4IiPLzyoIfWF7i+paZLV0D8vzJu5ChzRkU747XUYcJ5gjzC3p+YXxfQUg/U5jJM8bvJ8gvC32UJIvsMsdeGIV
X-Gm-Message-State: AOJu0YzNZlWEsPbXt6grhBkBfz8NU4n3vjRAT3+Kg/0HT2mPxwgWpbGo
	HdqJOboUy9bJOR9EdZmMmyRyUiFZDTQnPAPCBWdb2MacwVjJAsMh
X-Google-Smtp-Source: AGHT+IFkGzUgT0m4yyFlD+rq2PxwrsZAnFic8ufJk/ij2VBoo48gtb5OdaSoLnDec68LWufwqDP34w==
X-Received: by 2002:a05:6512:2253:b0:523:9515:4b74 with SMTP id 2adb3069b0e04-52bab4ca5e9mr2807710e87.14.1717601496450;
        Wed, 05 Jun 2024 08:31:36 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a690f03320csm449345866b.184.2024.06.05.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:31:35 -0700 (PDT)
Date: Wed, 5 Jun 2024 18:31:33 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	trivial@kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH 2/2] net: include: mii: Refactor: Use BIT() for
 ADVERTISE_* bits
Message-ID: <20240605153133.ronpeb2tcn3loqu5@skbuf>
References: <20240605121648.69779-1-csokas.bence@prolan.hu>
 <20240605121648.69779-1-csokas.bence@prolan.hu>
 <20240605121648.69779-2-csokas.bence@prolan.hu>
 <20240605121648.69779-2-csokas.bence@prolan.hu>
 <20240605141342.262wgddrf4xjbbeu@skbuf>
 <52b9e3f4-8dd4-4696-9a47-0dc4eb59c013@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52b9e3f4-8dd4-4696-9a47-0dc4eb59c013@prolan.hu>

On Wed, Jun 05, 2024 at 04:47:27PM +0200, Csókás Bence wrote:
> Hi!
> 
> On 6/5/24 16:13, Vladimir Oltean wrote:
> > On Wed, Jun 05, 2024 at 02:16:49PM +0200, Csókás, Bence wrote:
> > > Replace hex values with BIT() and GENMASK() for readability
> > > 
> > > Cc: trivial@kernel.org
> > > 
> > > Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
> > > ---
> > 
> > You can't use BIT() and GENMASK() in headers exported to user space.
> > 
> > I mean you can, but the BIT() and GENMASK() macros themselves aren't
> > exported to user space, and you would break any application which used
> > values dependent on them.
> > 
> 
> I thought the vDSO headers (which currently hold the definition for `BIT()`)
> *are* exported. Though `GENMASK()`, and the headers which would normally
> include vdso/bits.h, might not be... But then again, is uapi/linux/mii.h
> itself even exported?

grep through the output of "make -j 8 headers_install O=headers" is
a good place to start.

> And if so, why aren't these macros? Is there any reason _not_ to
> export the entire linux/bits.h?

Sorry, I'm not the person who can answer these questions.

