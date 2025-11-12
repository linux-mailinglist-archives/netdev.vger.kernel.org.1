Return-Path: <netdev+bounces-238054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D4C53690
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91F742557D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EA8341648;
	Wed, 12 Nov 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BdPMQ8BF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67ED33D6EC
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962954; cv=none; b=pMQqztDMjVrKDcDoQ1uDRvM8+5+uTwlTu5eiUhSsUyZOBl2+vlYA1ghPWbydXPZcXC3+b7m3dfW8DNvg00gvnvOjOTdx5Ra0kNVmm9PPUu33c0++MGeu+BGEycbrS8VErHSz6QVaSQ6NyKX0AgO3T0HU+Nuc7ETIwnW/6GLZ4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962954; c=relaxed/simple;
	bh=sy7RM1ynApjR9oHxBXwGPgxqq1j6rQIWu1zSMYe9TF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSibfOLcDyp9wKxCdodVbKNqCkgbUZh5YUemri/NxuACTbpCr60K+VUKSuGNAROHvq4M5NG6hse1WCAMOcuMbXL8WPBHs5oKbw/wpvSt+8QfQsUdUPZFcAtTNA891QYFUZuwnivnxyQlNnzI4Y7D/68WXLxUyMJiJA4B9WjXdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BdPMQ8BF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=elLG3G1DYO7aJGMInpk4Xr+4Jq3CjkQn2oipPw9V8e4=; b=BdPMQ8BF+p1MrAFNnU+Tu9tYhK
	W7Gqfac9RLZqD1i7+jzsrUb2Gc7VWnTqMMZSDt1LQ+f5U7hypKcVD7/dOwvBZ2rUqVfXVlCQ+bZfp
	IH2kE2HRILxSEnV1jgw1cMajNwaxKvITU/zkY40lvrSVT4pt+NzniOr3dKk1D4Vmbktib031Gq+Qe
	GYuL1N04dYzatuIv3xIaLEv70WiyLeH1Xw0a1cIoHJyPvZmGi7BfV6kDs+rvj81VeoNZVT0o4fvLk
	ppRKvXJ2CqCCK0PBmPwFOqNk7lY2y9y4AJmFYQFIXtiLy1Nqgr1KithJYhZKciSACOEN+WHP2oWGD
	g+eVubXQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56438)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJDCH-000000004Cm-2WaU;
	Wed, 12 Nov 2025 15:55:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJDCG-0000000040M-1dym;
	Wed, 12 Nov 2025 15:55:48 +0000
Date: Wed, 12 Nov 2025 15:55:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net: dp83822/dp83tc811: do not blacklist EEE for now
Message-ID: <aRSuBOxAZf3tN-hk@shell.armlinux.org.uk>
References: <aRRGbAR26GuyKKZl@shell.armlinux.org.uk>
 <20251112135935.266945-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112135935.266945-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 12, 2025 at 02:59:35PM +0100, Oleksij Rempel wrote:
> Note: dp83tc811 wires phydev->autoneg to control SGMII autoneg, which
> can't be proper decision. But it is a different issue.

Yep, that is just wrong. You didn't state whether you are happy with my
plan to squash this into my patch. What would you like to happen with
authorship etc?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

