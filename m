Return-Path: <netdev+bounces-217884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48160B3A466
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641F11C80D98
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596B22AE7F;
	Thu, 28 Aug 2025 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Im4kBZaR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B2221FC4
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394923; cv=none; b=Ma7hfXqEIpRPi3Dr8DEhvuEK/0jMAJzUx1cn8TYHfPmq1GLO6JjPz1A+qu6x9NRcpKYLbTo0NsAAMXiaNr9LVX39J9QPDRtm2vg1HxIZdM/Zhm0RvrCCLo3F9aBwPlMaceEceNUFi73vA+a5aAxgfSL+V+4lzzJWi0fZGdLTNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394923; c=relaxed/simple;
	bh=HGZLe7DTRuz1r+tooyR6QTpWMuRK0oD7wwj0haGcwpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlRnHZ4kIxGsnRqkTKs78gxUEcV3Ld3CUBknBxuvQjd6pXuKotRc3KYXfqckrdkCzaqpxukNe4gEeHx3GFdra/nWL2sM2ao9k0l7pxksWZ6EwEyzLVjoPaZmF0rF/13+1o9U/wrQ5mIslyr8k+iuy0WN2rV9ItMxxAIefzspmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Im4kBZaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F2DC4CEEB;
	Thu, 28 Aug 2025 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394922;
	bh=HGZLe7DTRuz1r+tooyR6QTpWMuRK0oD7wwj0haGcwpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Im4kBZaReNs/7kHrN/Q+bICp4U2subu1TwCnRvs9G4O5FY5R7eUhYQ6Gd9X3D/gUH
	 lcVaJHWHnnqu+9v/qg9o5lVFhQ/yOtMvOV/RTPR4+VkKISFVy9tVqY0amO7+TvA/6P
	 lyXUrHBRwluXgDAQpurq0Zj50IJOm1olVjq7Eu0uOlRYwuwBvjyP2HwxKWHDt/uR7U
	 LW2JGxPV4XcW0Fi1fPyAOM4bdiDsoLBTXhhoS4ngc/DyTGMQWCocP4tZttd/O1/VoR
	 wxeJ1mLrIDk3sV3uT4G+L8WjxCvifHamyUZx6uWSkLMhgilWunlSJIu4lKc9RBs0zk
	 30QzehCzjaA5Q==
Date: Thu, 28 Aug 2025 16:28:38 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: mdio: clean up c22/c45 accessor
 split
Message-ID: <20250828152838.GU10519@horms.kernel.org>
References: <E1urGBn-00000000DCH-3swS@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1urGBn-00000000DCH-3swS@rmk-PC.armlinux.org.uk>

On Wed, Aug 27, 2025 at 02:27:47PM +0100, Russell King (Oracle) wrote:
> The C45 accessors were setting the GR (register number) field twice,
> once with the 16-bit register address truncated to five bits, and
> then overwritten with the C45 devad. This is harmless since the field
> was being cleared prior to being updated with the C45 devad, except
> for the extra work.
> 
> Remove the redundant code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Untested, as I don't have my Jetson Xavier NX platform with me (and
> probably won't do for a few weeks.)
> 
> While this patch has been prepared on top of "net: stmmac: mdio: use
> netdev_priv() directly" it shouldn't conflict if that patch is not
> applied before this one.

Reviewed-by: Simon Horman <horms@kernel.org>


