Return-Path: <netdev+bounces-229690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5C2BDFCE0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701FB1A213AF
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B48F338F3C;
	Wed, 15 Oct 2025 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WndUeiBb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37032E75F;
	Wed, 15 Oct 2025 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547889; cv=none; b=QnhKApVWFdgMFLOwkSH3EKLezZdnjvLEjaIZF2qc5LSzftf7QtVBEjhy/8OFbtaNXfUf52QAD3vJ9OCsngAlGZ2nzswOzNgSIWk9OeoKbyYN7crLSZytbJdH9vya6KtAb4CszeqDtzQjJPHgbTSPAaJVX9Tn339P6yLDVeZ4xi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547889; c=relaxed/simple;
	bh=qY8fH23M7LXRmtaxUiEL5LBNYRnxpYUSwqiou9zh4+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxmufHmBS084R6dO7lIHNuhYiQ+oCRqJLLYlY1bBGWcK4VPFZiz/m5Zj9aBgvKPRdDY2mybwSv48pzrtWRZhf1WQix1QFYnl9uayG2Fqm0apx2lOGh4sof0bRP/a0gK8c2R+Nr4SrDLBE2dLjRh4pFS+m/NleRn7JDVgz6BN6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WndUeiBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085EBC4CEF8;
	Wed, 15 Oct 2025 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760547887;
	bh=qY8fH23M7LXRmtaxUiEL5LBNYRnxpYUSwqiou9zh4+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WndUeiBbh0EI7cO8+k/x+DFKzHS38lpu53rFmyQPkGykg4Z99cQlQBu4e0GkV3yun
	 A+pbK+zgukl/0TfvPB4llhP6fEkLp87976u/7iKVDI3BE+U9UCoXhRd2MOKo6q8sf/
	 VMfEhD8+5c/bsDRm9fED3g6aABoqjx5jnUTtvyP/m9DjCU/eDvVqUTxs3T/L7Cr9gQ
	 nAz74chBSv4fPPwgf2HEpuODBIclRimS5+O36VIRsf3dnBS6cOArwa85ve8F+VR0uk
	 BpHKrV5uApk6HSwCgg204yjTr9UCvWqpIYJLiDrBauONGchw2mNub62mWqVFAWde7Q
	 1NZdP5mNlkr7w==
Date: Wed, 15 Oct 2025 18:04:42 +0100
From: Simon Horman <horms@kernel.org>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] net: mdio: reset PHY before attempting to access
 registers in fwnode_mdiobus_register_phy
Message-ID: <aO_UKlH-Zxl1tq3W@horms.kernel.org>
References: <20251015134503.107925-1-buday.csaba@prolan.hu>
 <20251015134503.107925-4-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015134503.107925-4-buday.csaba@prolan.hu>

On Wed, Oct 15, 2025 at 03:45:03PM +0200, Buday Csaba wrote:

...

>  drivers/net/mdio/fwnode_mdio.c | 37 +++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
> index ba7091518..6987b1a51 100644
> --- a/drivers/net/mdio/fwnode_mdio.c
> +++ b/drivers/net/mdio/fwnode_mdio.c
> @@ -114,6 +114,38 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
>  }
>  EXPORT_SYMBOL(fwnode_mdiobus_phy_device_register);
>  
> +/**
> + * fwnode_reset_phy() - Hard-reset a PHY before registration

Hi Buday,

This is not a full review. But as this is a Kernel doc (a comment in Kernel
doc format), it should also document:

1. The function arguments:

  * @bus: ...
  * @addr: ...
  * @phy_node: ...

2. The return value:

  * Returns: ...

Flagged by ./scripts/kernel-doc -none -Wall

Thanks!

> + */
> +static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,

...

-- 
pw-bot: cr

