Return-Path: <netdev+bounces-157475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E51A0A62B
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 22:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C464165C0A
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59BA1B78F3;
	Sat, 11 Jan 2025 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qurNsf6e"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321972BAF9
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736631708; cv=none; b=mAZXR4H/KEAmoVETNFjFS5If7w+Icq3omdHi+1b92Fs8uoEdCWpjUF5u66ReFfazChZHJRaIfRHVJ+0NqDZmuHrHnGj0zizX/l1hZS2XTAvui1qat3d5wlKP9mn9Z5T8t2ndIs2ERnzqMkEyVgoQzKH3GjziwiBrtOOZH8QgWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736631708; c=relaxed/simple;
	bh=JN2eEwPqZhc+tVys8skUF03G8Z+xqntz/0bC3NN6kkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYoi57uGhxyLYXG1S0gc3jvcUor3w5aPcbjEA7ju4fG8LJFMtv1h8MKa55hW/S0P6RDGw4PgYGCIebIVxuV8UjcdlSJADzKQW2HHqZT6XGs7WEVWNDPd3hKp/zDDf4hkoMHPnA1FN0ZVzL6T7mhVzcXATVZnjECOIGahuvE5X1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qurNsf6e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ybRs8dEAOqsMt+HD8o6qcUbeprh1wp5VZJ/wXhiRSRI=; b=qurNsf6eaH8k1DWcWoS3z0pjcN
	/ujFEmzQaIt0vjjDmJ2W8Nnogfh2t5I/OXuMxruDXlvtJhW5f9IqgE21ApXQjAwJpWc4lYke7+CU6
	0W+wby+b6Wf7LFmtrI5QqX+FG7oE/jQnB3t9jbssvnPs+rpyvss7OjHvzkaIxDggqeic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWjEe-003dKH-Er; Sat, 11 Jan 2025 22:41:36 +0100
Date: Sat, 11 Jan 2025 22:41:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net: phy: realtek: add support for
 reading MDIO_MMD_VEND2 regs on RTL8125/RTL8126
Message-ID: <2907c46a-d248-437d-836b-bdafa7a80587@lunn.ch>
References: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
 <e821b302-5fe6-49ab-aabd-05da500581c0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e821b302-5fe6-49ab-aabd-05da500581c0@gmail.com>

On Sat, Jan 11, 2025 at 09:49:31PM +0100, Heiner Kallweit wrote:
> RTL8125/RTL8126 don't support MMD access to the internal PHY, but
> provide a mechanism to access at least all MDIO_MMD_VEND2 registers.
> By exposing this mechanism standard MMD access functions can be used
> to access the MDIO_MMD_VEND2 registers.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

