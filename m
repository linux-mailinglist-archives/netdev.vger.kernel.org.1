Return-Path: <netdev+bounces-103812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C21909999
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 20:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85801F214B0
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35523EA72;
	Sat, 15 Jun 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BBD67olG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8BB266AB
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718476398; cv=none; b=nyHR9Y/77r5j64IiH2cI8fA2LvBV+9u2nX+DZztYqm61v14IWRxqK4QC5KN4I5LDf9RkS4yF4FQQIWgRmUtyMthNDCsVGoxacorRPyZXdHr0Fr6lYhPhfuQdQ364s2Bll7zBQJ1TIWNnSYcVYEbvCa3azS9nivG6Wz5GHGucfWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718476398; c=relaxed/simple;
	bh=JpGqASoCZ86bv0shQ5QKjxonvdNmSrTh2q9zZrJZxTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctugpycwCHLNjzYAr7Oj5VhvoRbz7zXgwXpTehnxp1t+ZD0A9xswvjKSWTm3PNltPgikyf/1lG+6u7v7WKaFabwHgiUhHlWgdss2n8cN0ZkblOtybNkEhIfi6pluDt9GrqORgnml5miVtqv1/tndQ7jbjoo/0FEatxEsJ8tBP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BBD67olG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6WtuBsvTVAZZ1ae/0FKDU2wWMj93n4nLEHbmdKnFP7k=; b=BB
	D67olGHxz/PqHxY6cKZPMPqY5QFRGP8zY6F/zFRAHkGxJMPZn8ARqVFigOEUD5n0Oa4ParcEH2b9Z
	gIO394qan3RIewAi8tTHrGjudcMDkJdd4ZD86S8U22Q5/I5jRzvUjvGa/oQa/bky2UT2djJDQTSox
	Nx8Doeuyt9qWYa0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sIYD2-0008wW-9C; Sat, 15 Jun 2024 20:33:04 +0200
Date: Sat, 15 Jun 2024 20:33:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, kuba@kernel.org,
	netdev@vger.kernel.org, horms@kernel.org, jiri@resnulli.us,
	pabeni@redhat.com, linux@armlinux.org.uk, naveenm@marvell.com,
	jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
Message-ID: <00d00a1c-2a78-4b7d-815d-8977fb4795be@lunn.ch>
References: <20240611045217.78529-5-fujita.tomonori@gmail.com>
 <20240613173038.18b2a1ce@kernel.org>
 <1ae2ddab-b6d2-499d-9aa1-3033c730bb87@gmx.net>
 <20240615.180209.1799432003527929919.fujita.tomonori@gmail.com>
 <2f9cf951-f357-402c-9da7-77276a9a6a63@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f9cf951-f357-402c-9da7-77276a9a6a63@gmx.net>

> /* Sizes of tx desc (including padding if needed) as function of the SKB's
>  * frag number
>  * 7 - is number of lwords in txd with one phys buffer
>  * 3 - is number of lwords used for every additional phys buffer
>  * for (i = 0; i < TN40_MAX_PBL; i++) {
>  *    lwords = 7 + (i * 3);
>  *        if (lwords & 1)
>  *            lwords++;    pad it with 1 lword
>  *        tn40_txd_sizes[i].qwords = lwords >> 1;
>  *        tn40_txd_sizes[i].bytes = lwords << 2;
>  * }
>  */
> static struct {
>     u16 bytes;
>     u16 qwords;        /* qword = 64 bit */
> } const tn40_txd_sizes[] = {
>     { 0x20, 0x04 },
>     { 0x28, 0x05 },
>     { 0x38, 0x07 },

Nice comment section. Please keep it to help explain the table.

I did wounder if calculating the value as needed would be any
slower/faster than doing a table access. Doing arithmetic is very
cheap compared to a cache miss for a table lookup. Something which
could be bench marked and optimised later.

     Andrew

