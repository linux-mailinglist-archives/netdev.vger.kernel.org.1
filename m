Return-Path: <netdev+bounces-70280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F4384E3B8
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44DB1C227E3
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF1A7AE53;
	Thu,  8 Feb 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3PKArxAq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA07AE79
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404881; cv=none; b=iQaR/PvwyHHpXdBXMTMSeW3ikW8ect8OLiMYR2A7er1N6FgjGqAc5vBwsDh3aXD/HxPtov9UJ7PFfjJ5uAsXQTiPcKRuMDQrQzUphHssFC6MQibs8bX/tUgNxbPOJ5vHBky2GZDGR46mXy3Bf3+Q56I37hCEH/Mjke8YgjR8Vvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404881; c=relaxed/simple;
	bh=TVcdDND6hEBUFSL9Yv4KbBUlreiPwfb/9s1evUC9YGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNZa4ruzPrrfCMgcWrwdKKtSjvlQ0lpq9PGBLM0oKMn1ozGXLJ8LiM47j1hOSty8Ry5DvV3yEz4SpQPy4FOxuQmuoyNjpPttmMufpxbdrPTrhnHqk1vTM/I4vUgCiVx0LDAPyxX7oHWz67DO3XTN6PUUhMEbdi3AD4cxTyo4790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3PKArxAq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wI7JNjp8R8iZhX7Vkyt20ljUsHjWI1NZSeFxO8MDtYA=; b=3PKArxAqY51EFjS20aHyd27sZ4
	osMpqtkldo438PeTdawZ3TgXbNELdnf191y6zwNnSBjJNwbnYq7sO9JLUFSre1nLwwZuOeW42DOQ6
	txcehSX/PKF4eZ7d+kt2Pw+REnWBwbxFEdSqWsq8237WgtUwbfixBcKiZ3YG3u4YVRl8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rY60A-007Jnr-My; Thu, 08 Feb 2024 16:07:46 +0100
Date: Thu, 8 Feb 2024 16:07:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: realtek: use generic MDIO helpers to
 simplify the code
Message-ID: <566dee8d-b5e1-4f5a-8b51-936333ceffdf@lunn.ch>
References: <422ae70f-7305-45fd-ab3e-0dd604b9fd6c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422ae70f-7305-45fd-ab3e-0dd604b9fd6c@gmail.com>

On Thu, Feb 08, 2024 at 07:59:18AM +0100, Heiner Kallweit wrote:
> Use generic MDIO helpers to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

