Return-Path: <netdev+bounces-224617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 758DCB86F36
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C7BC4E0734
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7373C2D63E8;
	Thu, 18 Sep 2025 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jH5eHICG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D6D528
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228533; cv=none; b=tbDv3YhYL+gbAgBjzPwX92v1XOlggxFZ8FbOaYiKR0EZwo4i+7YBxn/1elrUNTwecGAEPbDxO19PbWKF18BBkSsIj7RnWRT7GL4J8jX3rFqwMusIp07HeXiicH3E1mVgIhndD2fL+ozzeSwqYufvcZtLqmk0VRbJ/tBBsnsAv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228533; c=relaxed/simple;
	bh=+BRLkX5v7x3+4TP/taHbOnPSLKsUHshn82IA2idE8Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOryVYf6OSA0CiteH0lWvpNfCc8QjYR6N2+yCWcFFm0Tp1sIXtIwgcu7gyQ6z027X9yqNg2bIivxQXfKxE4oiz45oZAQpKC3700CkcDKtd4ud7Xya/x/fwyjVn+jHCkFKK9aVSUCkFDmDMth6tydLGw1cK1iVuE91MG2NoVgoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jH5eHICG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tclC/sMiGQ+QdUCCQh9RCW2+nqAKyhxKCCpAhEKnsXE=; b=jH5eHICGPHqb+OrWiNR4Oa6pKe
	IjDGzwKmY2tWrVg8CKafWNvMAurnGqM+SJ/wNInFgjcES30/9TUXQGtANJY0W9tD0+bny7rAlNyHR
	d2EV5PKh5aLWH0DpFI2qKSRf/xH8xV2B4fOoTjxv8NjThhJSzsAz2cMJl7EM0Kba+3OY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzLYf-008sL5-Ev; Thu, 18 Sep 2025 22:48:49 +0200
Date: Thu, 18 Sep 2025 22:48:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 07/20] net: dsa: mv88e6xxx: convert PTP
 ptp_enable() method to take chip
Message-ID: <4a52396e-78af-438a-882b-b00e4a1f543e@lunn.ch>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIbP-00000006mzi-2Xsh@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uzIbP-00000006mzi-2Xsh@rmk-PC.armlinux.org.uk>

On Thu, Sep 18, 2025 at 06:39:27PM +0100, Russell King (Oracle) wrote:
> Wrap the ptp_ops->ptp_enable() method and convert it to take
> struct mv88e6xxx_chip. This eases the transition to generic Marvell
> PTP.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

