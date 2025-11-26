Return-Path: <netdev+bounces-241823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E3FC88C9D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5947E4E94A4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96331B814;
	Wed, 26 Nov 2025 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3dXoDxe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5AB30DEA4
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147448; cv=none; b=GVRRGIuSZruu5qlKYD18M88usO5b7v9UBnMshJ1YA197CnYFA1iXYf970EBsIiaGVlu24Pus3ptAWUJ7wiFX5kVZCteJYRUK/tc0+sg94eu5zV17zeFNQEOyiELVRH4+MjhFF77ZBf8stuMWPpCAs88QSJoLnOHcW0q9RJJUflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147448; c=relaxed/simple;
	bh=PEMRM4SfiLbGU93b8d8dO8w8yPLvJ4lzq9WQeKexhbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZenVbyuakyBJAQE4K1L8m1aMUir0SKasbVkZmv3x5XciEpRpXKHG6GlNjr8ovgEfUwH8yOupx1vZsxYhE/TRdtdfbrT5LmZHRaWpzpaI0/pD9deeMYQJkadFBOi6UjGJ2rWDDVJ13QsAYeKYrr+m4pm0CDht0kAxVOxI7RCmpuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3dXoDxe; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-11beb0a7bd6so687675c88.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147446; x=1764752246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OyD4sn9jsMLtWXgnyFdyRLUkPxYCW2TqpmGHV9ixsxU=;
        b=i3dXoDxe4pMLfCXXlUcbmq4yp+KNj909HNYQAp/NWWmKNbpLHddLiCZXDW4vrt0Xu7
         dJtyfZtt9tCephdMenM9/Ens1yGgnzcrMfsGK+jEIuNzaNGWw0ulS8QRtzKArqdFGQ42
         CZOkBJsAu7rx88C4s+kYqDhHlzgWMiYuJkiAchyij2hxqrVC9heSKT2qpEiABAxN2+To
         67t6Axs71KnLLqrBwM2Qyer1ZwyoSuOo5L/Th8Rfc9BNx1LC2kWfcO07UY45KjifcIpR
         ijNIcgcOChVBSnTmW/Egu5VWOhXvZ2+PnVlnDi3/WXmMEjM0UCLMQ5XadjANJIf6z3zn
         nbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147446; x=1764752246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyD4sn9jsMLtWXgnyFdyRLUkPxYCW2TqpmGHV9ixsxU=;
        b=FY346cLyEWXQEFT0zISKRnXTSyVASRRtSYlyoSsS+i6jx2Zjur5CZqWSFplPCrNGC2
         BV5gRL/7kDMcvcymM3WU3JfvnexUJEnEJmapLc7b/NyXBaNUXuBb7OrpxE9q5Tbr1Fx6
         S/Rh4fsmYNGTsJ9YEVz+DfLMBM1iUj9mXO7n8p+0ijqq8uL/Y3IfvKw3wlNkejolHn6U
         4OshlxJhJmv0cpVw6upuvBPFk0M+4Ebp85u8HrHCZm9BHw4mpCGw98gJIA68/1/bIMvI
         tzKd+fzJw7DOE7Bpx65VXtOf9nI1vdRUAO56F4qIDBtk3cvvnw13V/5x6NXPYKOMDi5k
         ADcw==
X-Forwarded-Encrypted: i=1; AJvYcCVmldFREFQrKyVs92+L8PJ14hs+pjyW5OmmSGveKk9WWRhzjk5DalIKANb73VVseA+01GVYGA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9p0uPx3QRf2hoIQN6CFmJhLbX3nUlpyqsQOHcyjH7ZMZcLbO
	FH6DpcDAW5QnIOLWoa+od3QvgWnLFVcOUQqi5q7RFh0B466cXLkTRzL8
X-Gm-Gg: ASbGncvYOpZ6ADzEKid6VH5aCPwY05u2csEzV+XAsyYa06vN1BSU9ypQDlyJ5OUeh5M
	0Ikn8tsJ2VxQU+9Kh/1zj0eOO4sdD4lRB2p2OgojxTnaQB6mkVRnEelwyixFYT5yFCluwb+Xtns
	ATNS7aDg6D4x+/GmyMbw2ICOL2ObkvTABaFqxg7WeL2khWre37Fd6CPOzN816aVCgQy07zs/0Pl
	xvYKFRdk1CUydO6nQaOHTToMl3bEkE+RWpMIDG7kGzvi8Qr9YwWOgCJSaW+bRkETcmHR3sVAoMM
	JUhvgS/yJmmSBFdWQbmBSUStRHxVsNqsirC7e73X7RSbsLehajPI6rGbwQ2Lj3FEXjGYNn4vsBL
	WofJ/cKlVPXWGnOBIuW4MNwthtInSFHR2Ib08LFKBiGyDWqw0IkiQpLwBiFNbPr0At+m5DLV7l2
	7ylZQtiskIG58d6ufAdMQA0RCdIlqI+B4mhaXMavCSDLQ=
X-Google-Smtp-Source: AGHT+IFrIMIkTPrxwRfvEMQ5cEoCTFWA9fomBn7RLpjcNkpm60ZPM71v6rIQ9mqGMQwZqmC/nqOzYQ==
X-Received: by 2002:a05:7022:ec17:b0:11b:9386:a382 with SMTP id a92af1059eb24-11c9cabc4f0mr12703137c88.21.1764147445929;
        Wed, 26 Nov 2025 00:57:25 -0800 (PST)
Received: from fedora (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db556csm92664267c88.1.2025.11.26.00.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:57:25 -0800 (PST)
Date: Wed, 26 Nov 2025 00:57:22 -0800
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <aSbA8i5S36GeryXc@fedora>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
 <SEYPR06MB5134BC17E80DB66DD385024D9DD1A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1c2ace4e-f3bb-4efa-a621-53c3711f46cb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c2ace4e-f3bb-4efa-a621-53c3711f46cb@lunn.ch>

Hi Andrew,

On Wed, Nov 26, 2025 at 12:49:57AM +0100, Andrew Lunn wrote:
> > I try to summary in the following informations that I understand.
> > 
> > 1. with rx-internal-delay-ps OR tx-internal-delay-ps OR both
> > 
> >   Use "rx/tx-internal-delay-ps" property to configure RGMII delay at MAC side
> >   Pass "phy-mode" to PHY driver by calling of_phy_get_and_connect()
> 
> Yes, since they are new properties, you can assume the phy-mode is
> correct for these delays. We just need to watch out for DT developers
> setting these delays to 2000ps and 'rgmii', which would be against the
> guidelines.
> 
> 
> > 2. withour rx-internal-delay-ps AND tx-internal-delay-ps
> > 
> >   If "phy-mode" is 'rgmii-rxid' or 'rgmii-txid':
> > 	Keep original delay
> > 	Print Warning message
> > 	  "Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> > 
> > There are FOUR conditions in delay configuration:
> > 'X' means RGMII delay setting from bootloader
> > A: 7500 <= X <= 8000, 0 <= X <= 500
> > B: 500 < X < 1500
> > C: 1500 <= X <= 2500
> > 	Mean "Enable RGMII delay" at MAC side
> > D: 2500 < X < 7500
> > 
> >   If "phy-mode" is 'rgmii':
> > 	Condition A:
> > 		Keep original delay
> > 		Update "phy-mode" to 'rgmii-id'
> > 		Print Information message
> > 			"Forced 'phy-mode' to rgmii-id"
> 
> So 0 <= X <= 500 is a small tuning value, so yes, is correct.
> 
> > 	Condition B and D
> > 		Keep original delay
> > 		Print Warning message
> > 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> 
> Yes.
> 
> > 	Condition C:
> > 		Disable RGMII delay at MAC side
> > 		Update "phy-mode" to 'rgmii-id'
> > 		Print Warning message
> > 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> 
> 'rx/tx-internal-delay-ps are probably not required in this case, the
> 2ns from the PHY is probably sufficient.
> 
> > 
> >   If "phy-mode" is 'rgmii-id':
> > 	Condition A:
> > 		Keep original delay
> > 		Keep "phy-mode" to 'rgmii-id'
> > 	Condition B and D
> > 		Keep original delay
> > 		Print Warning message
> > 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> > 	Condition C:
> > 		Disable RGMII delay at MAC side
> > 		Update "phy-mode" to 'rgmii-id'
> > 		Print Warning message
> > 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> > 
> 
> These look correct.
> 
> How many different boards do you have you can test with? Do you only
> have access to RDKs? Or do you have a test farm of customer boards for
> regression testing. I would throw the patchset at as many boards as
> you can to make sure there are no regressions.

I synced with Jacky offline a few times, and I'm happy to test the
patches on my Facebook Network OpenBMC platforms.

Hi Jacky,

Looking forward to your v5, and please don't hesitate to ping me offline
if you need more info about my test hardware.


Cheers,

Tao

