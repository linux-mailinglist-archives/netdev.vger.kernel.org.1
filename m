Return-Path: <netdev+bounces-176159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF27A692F9
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE0F7AC3AE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF781C4A16;
	Wed, 19 Mar 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VZa5Npq6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946D194A44;
	Wed, 19 Mar 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397470; cv=none; b=nWxMkkwfpy6rXQX3MxL8O18FNWZGo0POsYhzUKATgx2MFdfwSXTW4soLwXpwtUNRFRw+ay4OXp7hqCfnt12B6EEdiwOMXJqnCRgrRmtGi4MY3u9lQiLYtSEjygf7JotKCfgS9s4ymINtVbFRgptA8dkAsV5BDuVzhwv1uRzqNyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397470; c=relaxed/simple;
	bh=A7YMN3C+lZUIIok5CKL1qnI0bleeWmqst3SnXTg9A2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wln+34EiLqbtdRQspCJQ97hTEeyOXcdsHbcB3ydpO9ESEgnGtyeDiO68aM3eqF0NwL+8UK1f4JOLN4vuR9vgx7Xup/qO+8BbrwmlqduDdTy+bVknq0SgvtlCgS8+G+iOsxzEEa0l3vD0fsOD1Lk/gmOEYy9MSNUxUSE8bsoLL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VZa5Npq6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rcOcd6bo74EaRky7HF1JkNvP8cCX0oJBdVRtfi82gPs=; b=VZa5Npq6rPOsP2HiPNUu+MK1gV
	2zgEhn1xDOjItZxFrBN1meL54AkdosNYRYbJCtWR14/xizXQmSHsuoYtri6+d2a+qmkQrtwoKYMgZ
	klML9THf66p/Uy4WB/29ofyt0keObyIlPsL0UKOsDmzH5Q5zAHtPKCcDlp/7bZUklfanKQoA/chTC
	J4sOSquH+kzr5p42AOhMxgFxc0Lk82K7zA2uFUi44SOl/VaCKmi/iJTMnUUNultd/Y1PIwRcW235+
	JuWyWrh+22pB8wFr9NMD5scQ8apycG02Or0mdJ4LvowXwyEKnah4+igH4cSGJkWEak/hF1JgwEZT+
	CbkfcxjQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59924)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuvAh-0006af-2P;
	Wed, 19 Mar 2025 15:17:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuvAe-0005iE-03;
	Wed, 19 Mar 2025 15:17:28 +0000
Date: Wed, 19 Mar 2025 15:17:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 2/6] net: pcs: Implement OF support for PCS
 driver
Message-ID: <Z9rgB1Ko_xAj44zS@shell.armlinux.org.uk>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318235850.6411-3-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 12:58:38AM +0100, Christian Marangi wrote:
> Implement the foundation of OF support for PCS driver.
> 
> To support this, implement a simple Provider API where a PCS driver can
> expose multiple PCS with an xlate .get function.
> 
> PCS driver will have to call of_pcs_add_provider() and pass the device
> node pointer and a xlate function to return the correct PCS for the
> requested interface and the passed #pcs-cells.
> 
> This will register the PCS in a global list of providers so that
> consumer can access it.
> 
> Consumer will then use of_pcs_get() to get the actual PCS by passing the
> device_node pointer, the index for #pcs-cells and the requested
> interface.
> 
> For simple implementation where #pcs-cells is 0 and the PCS driver
> expose a single PCS, the xlate function of_pcs_simple_get() is
> provided. In such case the passed interface is ignored and is expected
> that the PCS supports any interface mode supported by the MAC.
> 
> For advanced implementation a custom xlate function is required. Such
> function should return an error if the PCS is not supported for the
> requested interface type.
> 
> This is needed for the correct function of of_phylink_mac_select_pcs()
> later described.
> 
> PCS driver on removal should first call phylink_pcs_release() on every
> PCS the driver provides and then correctly delete as a provider with
> the usage of of_pcs_del_provider().
> 
> A generic function for .mac_select_pcs is provided for any MAC driver
> that will declare PCS in DT, of_phylink_mac_select_pcs().
> This function will parse "pcs-handle" property and will try every PCS
> declared in DT until one that supports the requested interface type is
> found. This works by leveraging the return value of the xlate function
> returned by of_pcs_get() and checking if it's an ERROR or NULL, in such
> case the next PCS in the phandle array is tested.
> 
> Some additional helper are provided for xlate functions,
> pcs_supports_interface() as a simple function to check if the requested
> interface is supported by the PCS and phylink_pcs_release() to release a
> PCS from a phylink instance.
> 
> Co-developed-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

As a general comment, should we be developing stuff that is DT-centric
or fwnode-centric. We already have users of phylink using swnodes, and
it seems bad to design something today that is centred around just one
method of describing something.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

