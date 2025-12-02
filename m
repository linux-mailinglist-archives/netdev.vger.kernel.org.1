Return-Path: <netdev+bounces-243233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107A6C9BFF4
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 16:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90993A12F8
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB418288530;
	Tue,  2 Dec 2025 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fjiviGxS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF9823AB95
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690116; cv=none; b=N5psOQNTs8Z7uqDAcHM7FnkM4lR/iZ+cyd0mjTSGU9bjorad669p3//14zt46QGnuUsMZOrjtpvzAVUqxdOc5xpLpL3AV6d5cR/S9P6oHtmb1GRpA1ZAo4UMQo8BtZQ4BLy7zBhSOkl6YP5cGNJG1dHSsJV8k43e7t7Y5mi7FBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690116; c=relaxed/simple;
	bh=wvY1L8zYkyr9nSF3OWDfGXWvbfdGQHsF5YwL/Kljws8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3xvq3Xo5miFDyVx03mT6h0aEjksq2yQ6T6SJPVnEsXrHEe+Dd1SWqjUX3eXkixgHcPa7wnyco4mHSEw980FknraQlJcTeUXGLI16pAGeOxGVqkc5rsxZLKX1Q1Z5sEKFhok1FHg+OLyIuYJYy78cuShAkX1j5TQxXtsxvlsmTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fjiviGxS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zGJgb05jkPrXibYMPvxj+6+xMRK2J7E1glNDjEhvY4Y=; b=fjiviGxSD7cQHcbrFhLqGenhOh
	vrAZOI0MGYo/Udi/zXn3Gj4qEGBRGTnbmA8+DS2Ii75W+AwjYfrTyyuOAT/6QmsxnkRHuzbNfoeCd
	LLvb/TPwty1owlBbGK4vy+hfrNIEp09UhjYB3i5Zj1hmvNdG60i+IaEpsWXtOzZ5DUfk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQSVh-00FiFH-OJ; Tue, 02 Dec 2025 16:41:49 +0100
Date: Tue, 2 Dec 2025 16:41:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Subject: Re: [PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode
Message-ID: <f14f1078-311e-47ff-ad5f-01d2fd9ea40d@lunn.ch>
References: <20251201.201706.660956838646693149.rene@exactco.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201.201706.660956838646693149.rene@exactco.de>

> While at it, enable wake on magic packet by default, like most other
> Linux drivers do.

Please give examples, because i think that is false.

You should have the option to enable any WoL mode the hardware
supports, but none should be enabled by default.

> There is still another issue that should be fixed: the dirver init
> kills the OOB BMC connection until if up, too. We also should probaly
> not even conditionalize rtl8168_driver_stop on wol_enabled as the BMC
> should always be accessible. IMHO even on module unload.

Is there any way to know there is a BMC connected?

   Andrew

