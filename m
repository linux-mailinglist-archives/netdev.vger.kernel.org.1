Return-Path: <netdev+bounces-226545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAADBA1B7B
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 00:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A3C3BBC23
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F3A2750FB;
	Thu, 25 Sep 2025 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mCsdIWll"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588D22D4F9;
	Thu, 25 Sep 2025 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837652; cv=none; b=sG2TqatbO1Jhyh5iqemjFzWldLor/jjKIFSqHGoX/c3x8OazxprECRxxyxkNUNYzgKvyC/QSPUQ8MuAKkCSyPn48TU3QGd6o+hoPZqsurzi8P5COMq8QKnKetfs+efPqR3XD2/jCdXFG3dM+CrrqnEnGf5dx2979xA3wuXgJyIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837652; c=relaxed/simple;
	bh=OZ2mSDCtHXvMzea0lTp5F7xIMOMGoZ1WJKVYVSPzMfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOF2OxJQtfwTbR/OzbN7cvlslBh4h4vYB4glP5FoMz5atdSRNbbnFf5v4q8rMwd+1w3qFtJrQNhHhjqrcDdOEcvgn96U10DWw9CgB5nBH80rKsrqxP7oeWYfqizPi6IuxI+iFZiAht6nQrIECLdMx4StSbMP31lorsdynFPUh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mCsdIWll; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y1AKqVxOcQwyhkid55ZdNasv23OvCJ6hz4wrxtH2pCU=; b=mCsdIWllhqrnL/pnEdyHEhDO5b
	3oQWdovzkYjSCMj+gzLTtK5Ml+JZhmXSnVNwgFHfUX5J4Rlkm84KrVoGDDCIewGoxwrYYZzAzJnF/
	dwwQ8bvOFuTmx/j9ySJVm6hoHlGdP4Etp/SY3zW3vyub6kHyEwcqddeUzdXMsP4b/7fA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v1u0o-009Vna-GM; Fri, 26 Sep 2025 00:00:26 +0200
Date: Fri, 26 Sep 2025 00:00:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josef Raschen <josef@raschen.org>
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: microchip_t1: LAN887X: Fix device init issues.
Message-ID: <3e2ea3a1-6c5e-4427-9b23-2c07da09088d@lunn.ch>
References: <20250925205231.67764-1-josef@raschen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925205231.67764-1-josef@raschen.org>

On Thu, Sep 25, 2025 at 10:52:22PM +0200, Josef Raschen wrote:
> Currently, for a LAN8870 phy, before link up, a call to ethtool to set
> master-slave fails with 'operation not supported'. Reason: speed, duplex
> and master/slave are not properly initialized.
> 
> This change sets proper initial states for speed and duplex and publishes
> master-slave states. A default link up for speed 1000, full duplex and
> slave mode then works without having to call ethtool.

Hi Josef

What you are missing from the commit message is an explanation why the
LAN8870 is special, it needs to do something no other PHY does. Is
there something broken with this PHY? Some register not following
802.3?

    Andrew

---
pw-bot: cr


