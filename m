Return-Path: <netdev+bounces-163167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F778A2979A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0BB1882EB0
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF561FDE0B;
	Wed,  5 Feb 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5bCldwEu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918641FBEB5;
	Wed,  5 Feb 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776937; cv=none; b=qtTkEsXMeLUcLM/mnkhYgCCTrAPzDS/XcoABLyWDLEmMdEXvUm6sjjMcS24AT2cuTqmBkIx2LyZfYNOkYuRQFDBiDJ4f1NWfeskJJhr3qmWW2WQbQ5sbb/QqM2gUWgsKU7jdhMmcjoPbweix+8aOBxRnErdEG24RWdx8TcVZYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776937; c=relaxed/simple;
	bh=RF230ajZK9ScZgY4DNLI12feMN+aiLBGq4A8PJWSIPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4wdsBe6BYlAM8JL8cA5weX7bUyXZt7i0iEIJJu1CZvJP4kSCWnfgNb/OV3GT9aCnKn7ND5PX26P7oPj9zrHyPNJHhKsOxBWUpDU8DtN1+Sroq+yLDB+42niJNkwbJnSezNZQF6LZ2zugTk7KFEVnQS5Ch9NMCuAEwxLvREAHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5bCldwEu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WguZZNGkDfEvvyuO31rjTnIRBf9fhn5uKj5NRs7jMd0=; b=5bCldwEuBaYraPFQB6jSOeP9nB
	B5ssN2zbZ+WI0SHSK4cQItK18bcfexGKYAXKJZKGWyUDkK8Y/2CNyfm8wMCKB2VEgxNeoqpl7iLBL
	XcApr933Fcq3ARYnxjmAYSB14BSjQxCtel6rJYd59hTnETtv5CwMMZc/9mhGT6mglRZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tfjJ9-00BFpE-AT; Wed, 05 Feb 2025 18:35:27 +0100
Date: Wed, 5 Feb 2025 18:35:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: dp83tg720: Add randomized
 polling intervals for unstable link detection
Message-ID: <f609893a-aa26-4a6c-86cd-c944fdf9ff4a@lunn.ch>
References: <20250205091151.2165678-1-o.rempel@pengutronix.de>
 <20250205091151.2165678-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205091151.2165678-3-o.rempel@pengutronix.de>

> + * Return: Time (in milliseconds) until the next update event for the PHY state
> + * machine.

Same here.

    Andrew

---
pw-bot: cr

