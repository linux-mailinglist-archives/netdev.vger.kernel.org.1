Return-Path: <netdev+bounces-51601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F8B7FB4FD
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBE61F20F5F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3339199CF;
	Tue, 28 Nov 2023 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="BykxVZt3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E146138
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:57:41 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50baa3e5c00so3934936e87.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701161860; x=1701766660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ5f4xCIO2ZXm2cUVIZd9fOfVKkANnuLxl9JfSDH3H4=;
        b=BykxVZt3ADcr/JfZmgteC6QClsl4e0+e/lD8tk1ttdCiE2NhUj1i91XVxlakBisFAR
         NyFmWPeUm6xalZUM9K7w+d74hw6yBaCNzco+VL+8CPDT5QL4cONU8Z1t/fonepBwiF5X
         eE9847dKF8noCvO83/g5gEpTfLIL+O+h2XlmgAkGXyk0j57HEFbvdcgu0LaZqD+AFXLn
         s0gVIreJKHntV4YmTwVrS41djxJSNSNnR4TSvvK4mKNFav0JHhkdtAcOOLlSJyuQSoRW
         8Qmz+nGgFGbVnhXCm76lfQFGxPx5LUi7yxUQM7yv3dbX1wW++RTN7THv10KExg/SAV6n
         Pwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161860; x=1701766660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ5f4xCIO2ZXm2cUVIZd9fOfVKkANnuLxl9JfSDH3H4=;
        b=Yayo4gKGwvB0+Z3zrUwPsJWJlHJDaTq90QSMXdANy8TbpQ2lWOE+FymbbA5tYUV3Vv
         CH/fH2DzENAQRPmo/oE3KOWgwn248a17BsDn8qOuAVcHWnIPPyUd6Y60xY3W3dDP+O1l
         1/UbwrYPAYxusgrzaIs3/W6h7KE/RLJ9KPnGf84zdEHVhj9+AukTDk/FEQbrINbL5L87
         BTbUZ2Joa+hb5iVVMBM9TpaZ0MLba/pfzrYVCp+NVw4Oh0s79k/ucr9Ys05s2CwcA95c
         E/phrfBh8H7DPNx1Sh3Vjk0EgamEtJ7yUHsG8hnr8zDfHMRWyIcjb5T1udtCpEOdTQ/E
         Xcag==
X-Gm-Message-State: AOJu0Yxl65TGwY+X8DLlFV+QS8PzGO3gp4ExTyIAL6AGNHvp+zH6UD9p
	GfeJYZi3Vv4xxS18Yrsr4/PbOQ==
X-Google-Smtp-Source: AGHT+IF34nWU7hOhaSOTP7wYX7j9yWUCipg9dusjDeaF8bjTmFBJ66VMTNPJbpiQ+ehJdbpDj763XQ==
X-Received: by 2002:a19:5e03:0:b0:507:a003:57a2 with SMTP id s3-20020a195e03000000b00507a00357a2mr5918449lfb.52.1701161859761;
        Tue, 28 Nov 2023 00:57:39 -0800 (PST)
Received: from debian ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b0050aaaa33204sm1776147lfl.64.2023.11.28.00.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:57:39 -0800 (PST)
Date: Tue, 28 Nov 2023 09:57:35 +0100
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: microchip_t1s: additional phy support and
 collision detect handling
Message-ID: <ZWWrf4svgQc8x1PU@debian>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <d79803b5-60ec-425b-8c5c-3e96ff351e09@lunn.ch>
 <ZWS2GYBGGZg2MS0d@debian>
 <270f74c0-4a1d-4a82-a77c-0e8a8982e80f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270f74c0-4a1d-4a82-a77c-0e8a8982e80f@lunn.ch>

On Mon, Nov 27, 2023 at 05:03:54PM +0100, Andrew Lunn wrote:
> > * 3-4 nodes (depending on how many usb ports and dongles I have)
> > * run iperf with long cables and CSMA/CD
> > * run iperf with long cables and CMSA/No CD
> > 
> > I'll report back the results. Anything you'd like to add/focus on with
> > evaluation?
> 
> Humm, thinking about how CSMA/CD works...
> 
> Maybe look at what counters the MAC provides. Does it have collisions
> and bad FCS? A collision should result in a bad FCS, if you are not
> using CD. So if things are working correctly, the count for CD should
> move to FCS if you turn CD off. If CD is falsely triggering, FCS as a
> % should not really change, but you probably get more frames over the
> link?
> 

That is some really cool input, I have to do some datasheet digging and
hacking. I'll try to set everything up today, tomorrow I can hang in
the lab after hours and test things out!

Partihban suggested that Microchips support might be able to help with
testing, might give them a ping soon as I a solid plan.

Really appreciate the insight! 
R

