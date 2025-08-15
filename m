Return-Path: <netdev+bounces-214216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D562B288A6
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49865C0980
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4F72D0639;
	Fri, 15 Aug 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1SpXAuBm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A72D0C71
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755299578; cv=none; b=bdxgb/1V+thtpRazcxX0zTgfD2z4FXveLdgFvJrERPd1IGR8epO/uJ7D4HaRvWzVQuLowbMBcHF+1VHZEJJ+5bA0gtE2N6BKVeY1W5senw0S30rE1Dac00L62LQ7PzT07YONsosqAdleYDUBgCTmTt2lZISLNkjs/ahXYK0NbSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755299578; c=relaxed/simple;
	bh=5Y00NnKwhn2Iphgvkj9VotIXsl+3uymlyZ1ASi9xFl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVCB1z63zzsHDI/auyswZJXiZerDASbxUE95dP/ZCa/zG8FDY1opbengHKX+g5s3lBbWe5F768xbyi2CR2EFk3VEq/YqDXXM5+59JXVRpwjIs8L2nEAOsptu3dmum5Sj8X2j1LoSjCfAEKwYfsxCh2x6PKufc/kNTb6ktluk1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1SpXAuBm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XbPrRD7l6OeaYA5tFnaYhwXY8sb25OSjNI9kpGS9JV0=; b=1SpXAuBm1xFWmKXH93VSXVWO34
	NzATGnPCLcsLH9bg9WzvNHUpkdM0jnK1t6AJLcX+xEK17JtEGws2DkNBjI+P8ZY4aeP+o/wDorxnv
	FhT7e6Gjhty9xTpjtGgo3NJWHauZtRnImxEPYzXRRujH0pnd/H4KBR5w8xFq7BWPpNPo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un3bK-004s0s-5K; Sat, 16 Aug 2025 01:12:46 +0200
Date: Sat, 16 Aug 2025 01:12:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: dsa: Move KS8995 to the DSA subsystem
Message-ID: <66c7bd97-b8de-4097-9798-cd253033cdc3@lunn.ch>
References: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
 <20250813-ks8995-to-dsa-v1-1-75c359ede3a5@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-ks8995-to-dsa-v1-1-75c359ede3a5@linaro.org>

On Wed, Aug 13, 2025 at 11:43:03PM +0200, Linus Walleij wrote:
> By reading the datasheets for the KS8995 it is obvious that this
> is a 100 Mbit DSA switch.
> 
> Let us start the refactoring by moving it to the DSA subsystem to
> preserve development history.
> 
> Verified that the chip still probes the same after this patch
> provided CONFIG_HAVE_NET_DSA, CONFIG_NET_DSA and CONFIG_DSA_KS8995
> are selected.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

