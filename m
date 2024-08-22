Return-Path: <netdev+bounces-121101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ECA95BB09
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8A9B23DAD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DBB1CCED0;
	Thu, 22 Aug 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h60PjGww"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4861CCED8;
	Thu, 22 Aug 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341842; cv=none; b=F+atwR2mvPjZpNpMJ5i/199qDuHCAIkDWjq3c09l0lLqwLzuzK9/swH3mbj+uF5xY4QEWEhjtj9ssl7SjDc3mIdHRBblmpGsX0h+LFSjoY66aD3STNPXzmdlTFxaguBjoV3wyn1lUlyDaktT1L/aJYwtQbSEVZ7Jgpm2on7n5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341842; c=relaxed/simple;
	bh=YLr7U4WuN7r4DANy/NK+UIDzVlCZ3BdQDPUgdZksTmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIEdH4qb5ryUSF3ALrZ6F5FjemV2Kq4MhH9FbhYAjqf09VTlLGadAGVhG1SKxWad6d7zgUx12PdoP9k+tT8aOuwxE5SsdaHLGDP4EncZ3fzRXXVKwnKmCezTUCSxZaMEVV/cC5IN7bjGX3vQiZ2JVgmt6VMBrGDo6T2XcL2HKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h60PjGww; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YY6B1q/3dDOEaOOiRTjhyN4W4NVDnqCSJaEbhKIHa0c=; b=h60PjGwwMjPJl9EjMbiSULMd/C
	xttWOIL+D8WwEbaBIKarBDGlMmqtbJAx81ksoMkjzFqzCEMPQ0hMJK+CYZIN3OVQjx8Wpe4qnICMt
	kahUcea08sQaqztwYvQEpPNX0NheqS+uHAcAbSag3dbEf0ZeTBOuM7MJMtLWVIZPjb0o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1shA50-005Rbl-LF; Thu, 22 Aug 2024 17:50:30 +0200
Date: Thu, 22 Aug 2024 17:50:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v3 3/3] phy: dp83td510: Utilize ALCD for cable
 length measurement when link is active
Message-ID: <3b5f1f4e-d132-4f42-a516-29a0a827bf59@lunn.ch>
References: <20240822120703.1393130-1-o.rempel@pengutronix.de>
 <20240822120703.1393130-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822120703.1393130-4-o.rempel@pengutronix.de>

On Thu, Aug 22, 2024 at 02:07:03PM +0200, Oleksij Rempel wrote:
> In industrial environments where 10BaseT1L PHYs are replacing existing
> field bus systems like CAN, it's often essential to retain the existing
> cable infrastructure. After installation, collecting metrics such as
> cable length is crucial for assessing the quality of the infrastructure.
> Traditionally, TDR (Time Domain Reflectometry) is used for this purpose.
> However, TDR requires interrupting the link, and if the link partner
> remains active, the TDR measurement will fail.
> 
> Unlike multi-pair systems, where TDR can be attempted during the MDI-X
> switching window, 10BaseT1L systems face greater challenges. The TDR
> sequence on 10BaseT1L is longer and coincides with uninterrupted
> autonegotiation pulses, making TDR impossible when the link partner is
> active.
> 
> The DP83TD510 PHY provides an alternative through ALCD (Active Link
> Cable Diagnostics), which allows for cable length measurement without
> disrupting an active link. Since a live link indicates no short or open
> cable states, ALCD can be used effectively to gather cable length
> information.
> 
> Enhance the dp83td510 driver by:
> - Leveraging ALCD to measure cable length when the link is active.
> - Bypassing TDR when a link is detected, as ALCD provides the required
>   information without disruption.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

