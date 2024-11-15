Return-Path: <netdev+bounces-145507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F999CFB01
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2E11F225BD
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF8E1991DD;
	Fri, 15 Nov 2024 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOQrlN+c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CCF18DF8D;
	Fri, 15 Nov 2024 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712754; cv=none; b=NZ5VgMHwepjGDq1hMl+kDkDeu+urJOVQS6clXcMo/xky3bhQGR3S23EnsJL/V0lMPxED+EsS0wsCSCBKPU9Rmlns2SGZ23lSzKcO6kA/Bb/9J5gZ+OwOhNqA96QqSWismJ4nDCmeAiMm8kTbhBH1VAK85o/rY9+dDLstNEvcPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712754; c=relaxed/simple;
	bh=0yPcBEN00O1vZYAhrNKkld6XHKq6EJuKc9z33Rq3qZY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qbx5SECUWlpuAqc7GKrS/5zSgixPfdBRr3vzGWqKDMvlmA8DMwnPqQKeHL2keYKXrpkA+sibFST2TyueJ27+qRZbmL/RGunhSdz9m5HSXciO4ec/xV624aX4ZlyrhOfWZ8WDc1P1KOxeCgCg7/fvP38lMd+QzbMSHE+7L0VpDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOQrlN+c; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43161c0068bso1387455e9.1;
        Fri, 15 Nov 2024 15:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731712751; x=1732317551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CiJda9W8rYQ25aoVKNjG4upIlR/b8ZNesPsVfBmzmp4=;
        b=hOQrlN+cR3GZL5SO13TBkOtsENBYh0ynKGqgCkv4pHb7BnsUOx2GR2mnXeIU15XB+e
         SVdzgrYi5hjsyaOs5x9JHXV9g0CMOW9IC4cKj02W2eZkWWeKvueRHrpiRIkWyJZXPrWG
         PzvsJFKn5w9tj6FlHxwc2jbilB6P4cfdYTBXEJEVdTLHZPLr5Y37iMArFmg6teWjKx+z
         4qYdVNFmnDRIUQejIeXUPIbRFkvbxAGzMEf+ALSGAy7wlgLZ3gjkmnEaB+7l7MVSG3Fz
         RVvTqHlYvPSSozcr1QwGXN3FpINTMFsSRC/Fbyj2FKBJ9acvkkzFrJlr533rbldq5zgQ
         g3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731712751; x=1732317551;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiJda9W8rYQ25aoVKNjG4upIlR/b8ZNesPsVfBmzmp4=;
        b=gWT/wTaOnZrj0ETLNp2ru6kAxKvSpqiaxD0YSkTV6Qp47NndeR5L+1YoFXma937B87
         npD+WQz+pQAmJ3ex6Z8pATpngRfTbweqwMFKYomQ11jUV8mh9ydi211MTcrh2yjR2u1H
         7B8uExcOpPwCszoNeyUotLpJig1kGaIA2jhikiZeN9h/HzI/j+JoSFIC5re82JzYUjPt
         zNF7FkcRS+66JEihDe+YTfXTR4HIBdqVf7J+JCPpb7z8VUVUXG1iZSE4Of1aTn8N0XkS
         sVcvPn5gKW26OFDQ37cxrCFZHKLF/zihNraWP2trP7QMa0anIBusWn22niatNIt0RvYf
         F6tw==
X-Forwarded-Encrypted: i=1; AJvYcCUNu2vptPcQBnISsaIHHjVQsujC0oQmDtPA6Aaoy3IYt8ruo7xrDXaB1ZxZowNd1lFPMdxdX7hqCdLz@vger.kernel.org, AJvYcCVpMb7ja8DSgRYqwP1FZQoallLZksAwivEyPdfM0NuYwbKqIRUSNbuMuXgj3wFG3Fyb2Rx45w3x@vger.kernel.org, AJvYcCWqEqZR3iivA6FDLUxgI0i8eYFk6cNv1FNxU1ZR4gBSjCrZamnzWPWoTtN+BKuGDEsPRmBjFtivPoBYyEev@vger.kernel.org
X-Gm-Message-State: AOJu0YxO9dMkK3U6wZ8Zz7oZvdWJH6cI/wa68vBFtT5LVmZ39c39peJ7
	Qiuy/Gah98EMoQ0UWpda8ehAqsVRmOcC4O3eHZUWUcnhWaijKVFo
X-Google-Smtp-Source: AGHT+IEuO6BO2OZ0lz6Px1gCfwr1s+/P/FdZIjh0SxJhkn+AIGHj1BkY+4LWXmmNkKyjGdn4wRI4SQ==
X-Received: by 2002:a05:600c:3111:b0:431:5c7b:e937 with SMTP id 5b1f17b1804b1-432df74c8bdmr41371685e9.17.1731712751200;
        Fri, 15 Nov 2024 15:19:11 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298c81sm73081885e9.39.2024.11.15.15.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 15:19:10 -0800 (PST)
Message-ID: <6737d6ee.050a0220.34072b.91c7@mx.google.com>
X-Google-Original-Message-ID: <ZzfW6oLHfmanuyV-@Ansuel-XPS.>
Date: Sat, 16 Nov 2024 00:19:06 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v5 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20241112204743.6710-1-ansuelsmth@gmail.com>
 <20241112204743.6710-4-ansuelsmth@gmail.com>
 <20241114192202.215869ed@kernel.org>
 <6737c439.5d0a0220.d7fe0.2221@mx.google.com>
 <20241115145918.5ed4d5ec@kernel.org>
 <6737d35f.050a0220.3d6fb4.8d89@mx.google.com>
 <20241115151553.71668045@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115151553.71668045@kernel.org>

On Fri, Nov 15, 2024 at 03:15:53PM -0800, Jakub Kicinski wrote:
> On Sat, 16 Nov 2024 00:03:55 +0100 Christian Marangi wrote:
> > > > Ok I will search for this but it does sounds like something new and not
> > > > used by other DSA driver, any hint on where to look for examples?  
> > > 
> > > It's relatively recent but I think the ops are plumbed thru to DSA.
> > > Take a look at all the *_stats members of struct dsa_switch_ops, most
> > > of them take a fixed format struct to fill in and the struct has some
> > > extra kdoc on which field is what.  
> > 
> > Thanks for the follow-up, they are the get_stats64 I assume, quite
> > different to the ethtools one as we need a poll logic. Ok I will check
> > what to drop and rework it.
> 
> https://elixir.bootlin.com/linux/v6.12-rc1/source/include/net/dsa.h#L915-L927
> 
> am I looking in the wrong place?

Yep should be those.

-- 
	Ansuel

