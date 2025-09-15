Return-Path: <netdev+bounces-223029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C234CB579AB
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1EF3ADE3F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85B2FE063;
	Mon, 15 Sep 2025 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r5754uGW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C18E1519B4;
	Mon, 15 Sep 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937718; cv=none; b=FeJm7DsTOhi/t3wOuiJDpW4dvDP5mRBCf/vsZLnJZrgx4fNJUHEU87sM7ipAJotpZy6b/EeaWZo9HX04kh8X6VIgdWXc8L611AcciEooXku7qMBnlG6OEsUhMFsqoCfhTHR2WD1zMeEPcYhRngprCaxRBLKoAO6vF+6cpdXM270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937718; c=relaxed/simple;
	bh=+WtHQs295H3vxQFqZDro2SqnZZjKJ31/hrt5spFK47M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxBG8pEj+ITObTOW8uW/M8MFp5DfekXXj8D7uu90Vqc28KraaKVsQTKDViNPNS82KzvTvV0yiquZmoYbgprYuJARAFrY0V+JS2hV9EQfCdjKSqU+LuaTm0mDVz9/36MEhzmi4ihYT18urNwyScsvFAvk86yR9EJMO6lV/JAmNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=r5754uGW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=va3oKp7BOBHUURZCdWCTqGG5NbY9CSNNWRqUTFrPKVI=; b=r5754uGWSbsgM9H86dzIDXTLdw
	t1hz+xPCkyrdciw/qJd09VyzM09Abx+TGPu+NwGpOSKRfLTUIwyomUfLXcqWqvlF3oZBR/9GZyyC3
	Fh8cohBBhchoaj+lLqjMdzsrJcGutu/Ri1IyM/f6SHE9Hp8JoCsz/vWKKQoDPMau2NY5qkR4gWEGk
	xIPSIax/uc4Die6DWncRUGi8Sd/5ar1TfSIKhtOUI5LgoEzaHScNxI8nVuPrkEb17n/3TkVT1y3lq
	C5yXR81rtaHg1Qh3ikzoO+jLH5eHLj+nQ2rlNfk6jg+vVZRpQh2VPGsZV3A9G0NJ3Zoq1enYcAI8Z
	eTRqnpFw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36322)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uy7ty-000000008RS-2jMS;
	Mon, 15 Sep 2025 13:01:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uy7tw-000000006di-0hHz;
	Mon, 15 Sep 2025 13:01:44 +0100
Date: Mon, 15 Sep 2025 13:01:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: micrel: Add Fast link failure support
 for lan8842
Message-ID: <aMgAKIn0YRyxK0Fn@shell.armlinux.org.uk>
References: <20250915091149.3539162-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915091149.3539162-1-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 15, 2025 at 11:11:49AM +0200, Horatiu Vultur wrote:
> +static int lan8842_set_fast_down(struct phy_device *phydev, const u8 *msecs)
> +{
> +	if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_ON)
> +		return lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS,
> +					      LAN8842_FLF,
> +					      LAN8842_FLF_ENA |
> +					      LAN8842_FLF_ENA_LINK_DOWN,
> +					      LAN8842_FLF_ENA |
> +					      LAN8842_FLF_ENA_LINK_DOWN);
> +
> +	if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_OFF)
> +		return lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS,
> +					      LAN8842_FLF,
> +					      LAN8842_FLF_ENA |
> +					      LAN8842_FLF_ENA_LINK_DOWN, 0);

Would this be more readable?

	u16 flf;

	switch (*msecs) {
	case ETHTOOL_PHY_FAST_LINK_DOWN_OFF:
		flf = 0;
		break;

	case ETHTOOL_PHY_FAST_LINK_DOWN_ON:
		flf = LAN8842_FLF_ENA | LAN8842_FLF_ENA_LINK_DOWN;
		break;

	default:
		return -EINVAL;
	}

	return lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS,
				      LAN8842_FLF,
				      LAN8842_FLF_ENA |
				      LAN8842_FLF_ENA_LINK_DOWN, flf);

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

