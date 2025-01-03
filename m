Return-Path: <netdev+bounces-155051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28637A00D4E
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674351882311
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF221FBEB8;
	Fri,  3 Jan 2025 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="RRl0qjbd"
X-Original-To: netdev@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE941FC0F8
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735927265; cv=pass; b=JjNeBHSx5FGgC6hT5qJVJH9i4PGsCqf47nUOuhUjbU0st2f4uFFlDSYc3RKgWw5tua92KSAe00DoHoC92OVHNefDAFCjn19OoOiKqtXiR98tRZ/n8xXyJuNfNQ0v3epf/wi01flfr4PAi82N0gEMQPGhcFW/yovUwoDVfprM5bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735927265; c=relaxed/simple;
	bh=I+XvwTWfTCyn9779IV+rw59qFFQOfp740bZAAoWA+xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlpF7FAp0YMeiIukmPJYYgDF2ggpJPDxIb81Afx6pEXM4g/dWnA7KppWEZo1KB4guO7yXYfry7jlcQsc5+cyqiB1ebh6pAil2pDt2+IG4KmoKmn6zGVggMW+Tam9j2lUHynw32Y34jqFcwhQUn+1rUIJRVXOXQg+Y/eOfCNz3DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=RRl0qjbd; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=instance-europe-west4-07zg.prod.antispam.mailspamprotection.com; s=arckey; t=1735927262;
	 b=P9yyjbDvhjlPdGheW38y6asgaZX6Hpr6ulUO2X+7Vuarp52W55QOFzD6y48Gmbvfq5kx2AN/hS
	  AIHdLW3ufRQnkAbgntCzWwPfOWFuAP4mDNOJ9AaEqkOAbatnuR+7uVTcZ+ovc+lXCn7hcHaAnw
	  Ws5y9CSLlSmaHs9QiSnU+H6Lgx5U35wyfoERb4PpPkQJKNrJVVe2AtF5qWzrJpDh/CKqKMzptJ
	  LIR0IbHb0eTND5FjyNWluUWSrfaaIFz7PazJ6zOZOHB4bcRnys1qWvQAqEwnW1mxs524yPXZOB
	  Bo9O9PbjZP+WUJ1IzKFXuXRPP+FvJEq3+Lsxx+xzBVdRPg==;
ARC-Authentication-Results: i=1; instance-europe-west4-07zg.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=instance-europe-west4-07zg.prod.antispam.mailspamprotection.com; s=arckey; t=1735927262;
	bh=I+XvwTWfTCyn9779IV+rw59qFFQOfp740bZAAoWA+xM=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature;
	b=q+o7dQG3xWGk6JV2d6CcJ5wiLKOV6dP3WFrIh2meS2DVhhWeUAycnJEq2RWVISVANHTN1Doo+L
	  Auy2i0MDOiiu5x/82wDqULC4THsmJSmsQ/9Cs+cJNLoH+196I8qeacp+CnmAJ/thCzfdgZOS7c
	  RVdh0ym3Brb+UA6m9GcgZeLCQGBT5itzMCE65PTKvLXWdif7QXMVY/SnhbNWVJfhK90/Gym+pC
	  Pgj0hX8ZUZH///X5Oy/DmraMsI6YQUX23QgdsJJkJC8WnRbo/d7Kf4RpFwUs0vZvG1DMnSeQbN
	  jhXEpcrAyRKlmb8WsCUO5/GnGepht6idvRzrLt24PM8/8w==;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-07zg.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tTlye-0000000DPKo-3PJv
	for netdev@vger.kernel.org;
	Fri, 03 Jan 2025 18:00:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=vBp0/474977aaXzbpEwDwebO8ZGb4XOznmhHhfYn+hw=; b=RRl0qjbdahmECbthExD8V8et3d
	wuNRpJaE3qQy5/QTbBQGrguTH4HPOmfw9x3V8qou07Qn7g/ulUpvg0GpGI+iQjJhpUIUz52i/KWN8
	CdByYUrQ2ljK+Nz67sDxxxBQu6hXAGi3PJu+FQpWs1HG3c/XBCSvgrCVG1XUKfXPdU70=;
Received: from [87.11.41.26] (port=61961 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tTlyY-00000000NUJ-12P8;
	Fri, 03 Jan 2025 18:00:46 +0000
From: Francesco Valla <francesco@valla.it>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH] net: phy: don't issue a module request if a driver is available
Date: Fri, 03 Jan 2025 19:00:45 +0100
Message-ID: <2793441.QOukoFCf94@fedora.fritz.box>
In-Reply-To: <c94c5555-1d3a-4d81-8595-1e70c6c352f6@lunn.ch>
References:
 <20250101235122.704012-1-francesco@valla.it>
 <2105036.YKUYFuaPT4@fedora.fritz.box>
 <c94c5555-1d3a-4d81-8595-1e70c6c352f6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 2e7ec65ae4bf6df404e0f8ed9a3ce5a4
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
Authentication-Results: instance-europe-west4-07zg.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Thursday, 2 January 2025 at 15:21:51 Andrew Lunn <andrew@lunn.ch> wrote:
> > > One other question, how much speadup do you get with async probe of
> > > PHYs? Is it really worth the effort?
> > 
> > For me it's a reduction of ~170ms, which currently accounts for roughly the 25%
> > of the time spent before starting userspace (660ms vs 490ms, give or take a
> > couple of milliseconds). That's due to the large reset time required by the PHYs
> > to initialize
> 
> 170ms seems like a long time for a reset. Maybe check the datasheet
> and see what it says.
> 
> 	Andrew
> 

Turned out that another 50-60ms could be shaven off. I trusted the original
implementation for the platform on the reset timings, but the datasheet used
the same name for two time quantities and they chose the wrong one.

Regards,
Francesco



