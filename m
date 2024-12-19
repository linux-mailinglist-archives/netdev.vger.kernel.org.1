Return-Path: <netdev+bounces-153468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A291A9F8270
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C8D7A16BB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75A01AA7B7;
	Thu, 19 Dec 2024 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XuyMFC5L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7FE1AA786
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630419; cv=none; b=eSr4fuWqswNHNo/Mxv+lHQj+HOgN2DuU/RB1m+QnBXuCKjOo8arNqmY5K9A5ZVvD+lZ1W9rJfF9qULBtpTZL87MEBJb965XzHSadtWfo+zV0nETEIiF0bpg48nQomp0aeJPvxB+26lthDTaZIXySY2NofKDXbexzooUtsxnNyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630419; c=relaxed/simple;
	bh=hxWF5SdaFU/TOk1ZS3kxkR9/S8Pftk4iW2vjG+33/cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZLUK3X3yot0Q62GseBdAnzSbfhYQvZHMHO/kwCiFJPE/zqjLzrKhAdmzpWH7xWVMUMxvALr+0YqaT+q0A+9oBTcPP41SMLfWgYkjbJAJP1DZ8+e+UlI1azPfCoeWki5R5U+b7AS/MBjoHZc1GwUrURgWnguAl+7b0kAjrRaSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XuyMFC5L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aFAkUnVPleBd08tCRYbEcJfJhz1WqmU6VW6Jaqay9yk=; b=XuyMFC5L9+3IdldEysLeuVwmnA
	2Y9spvVH6atzumHHVTV4RpCVkjYm755rj/VXXyy8st6nYAmrgIRREieje0KhHfcm+FfcYE4e3HDRk
	nqEZcDc9RWuBVXapnZu4OHgiR9ed0KKPXyW6hB6bU85O1F01PkQfYO0kT/hTtMU6mPzE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOKbv-001hpd-Df; Thu, 19 Dec 2024 18:46:55 +0100
Date: Thu, 19 Dec 2024 18:46:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs
 on user ports
Message-ID: <a509dc4c-b5e6-4315-9fad-d2ce9932805c@lunn.ch>
References: <20241219173805.503900-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219173805.503900-1-alexander.sverdlin@siemens.com>

On Thu, Dec 19, 2024 at 06:38:01PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> If the PHYs on user ports are not specified explicitly, but a common
> user_mii_bus is being registered and scanned there is no way to limit
> Auto Negotiation options currently.

Please could you expand on this. This sounds like a reason you would
want to explicitly list the PHY on an MDIO bus so that you can use the
max-speed property in the PHY node.

	Andrew

