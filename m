Return-Path: <netdev+bounces-283500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGsZFfed9mnVWwIAu9opvQ
	(envelope-from <netdev+bounces-283500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 02:59:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B374B3ECE
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 02:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC0B7300A63B
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 00:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4983E1A3029;
	Sun,  3 May 2026 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zalznL43"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C07540DFB7;
	Sun,  3 May 2026 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777769972; cv=none; b=cQWUG+yXNL61j5r+VMMb/1ShaaTz8hUU04/MERGADRRBLflC9LskM6WxpthgZJfH26IWwXD9oIdz6HGol6lntaEc3S3tp1DqAV5IhbDri1Y/RVuPoV6RjZBUy8uJx7bJcxR+kBx7NfPVVohVa4LpU/GbT5emHp5YUsF+LObTGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777769972; c=relaxed/simple;
	bh=S3y+5FVzHEScFe5M4UgfRVEuCLEYfsI5xZre4lPfGyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6f/1IX6BERgdaorOH6bukgUgGlzbbjdGqn5GEgGDBLzT2P+6UfATzz552rt2JhXvf8SAirABS/nuOI6lYhW2ogK5jCvbq7pvCZetEl3Jje7piprkwifKtmx7JOEA/5XNbXuAU5xJcmdoiv8JJxgMIlzZVNueHHy07bZFxyrsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zalznL43; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2yUfi3pXTAet5ghmShnvmVDBs2ywpSHtlzsQUKJnwdI=; b=zalznL43MqRNA8eKq0ZoL0QyHA
	CfMsidnPtN1Bfp/Olru+7DG6GfNjCrTageaq5ps0uE/TdNfMvBzEu2BKGRKi3LnJD768jeerFOmgl
	aX+zE1yXrGWNyWYDXokTz18y54kozg4nIM0wWSxsNs3f1493hsJS5D8tVYGCn+4/4Od8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJLAx-0014J1-NG; Sun, 03 May 2026 02:59:15 +0200
Date: Sun, 3 May 2026 02:59:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: ethernet: adi: Add a driver for the
 ADIN1140 MACPHY
Message-ID: <f477a03e-1d1f-4a38-af47-4cc16f5d87a5@lunn.ch>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-4-dd043cdd88f0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503-adin1140-driver-v1-4-dd043cdd88f0@analog.com>
X-Rspamd-Queue-Id: 88B374B3ECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283500-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> +static int adin1140_get_phy_c45_mms(int devnum)
> +{
> +	switch (devnum) {
> +	case MDIO_MMD_PCS:
> +		return ADIN1140_PHY_C45_PCS_MMS2;
> +	case MDIO_MMD_PMAPMD:
> +		return ADIN1140_PHY_C45_PMA_PMD_MMS3;
> +	case MDIO_MMD_VEND2:
> +		return ADIN1140_PHY_C45_VS_PLCA_MMS4;
> +	default:
> +		return devnum;
> +	}
> +}
> +
> +static int adin1140_mdiobus_read_c45(struct mii_bus *bus, int addr,
> +				     int devnum, int regnum)
> +{
> +	struct oa_tc6 *tc6 = bus->priv;
> +	u32 regval;
> +	u32 mms;
> +	int ret;
> +
> +	mms = adin1140_get_phy_c45_mms(devnum);
> +	ret = oa_tc6_read_register(tc6, ADIN1140_MMS_REG(mms, regnum),
> +				   &regval);
> +	if (ret)
> +		return ret;
> +
> +	return regval;
> +}
> +
> +static int adin1140_mdiobus_write_c45(struct mii_bus *bus, int addr,
> +				      int devnum, int regnum, u16 val)
> +{
> +	struct oa_tc6 *tc6 = bus->priv;
> +	int ret;
> +
> +	ret = adin1140_get_phy_c45_mms(devnum);
> +	if (ret < 0)
> +		return ret;
> +
> +	return oa_tc6_write_register(tc6, ADIN1140_MMS_REG(ret, regnum), val);
> +}

At a quick look, these seem the same as oa_tc6_mdiobus_read_c45() and
oa_tc6_mdiobus_write_c45(). Please export them and use them.

> +static int adin1140_mdiobus_read(struct mii_bus *bus, int addr, int regnum)
> +{
> +	struct oa_tc6 *tc6 = bus->priv;
> +	u32 reg_val;
> +	int ret;
> +
> +	/* The ADIN1140's standard PHY C22 register map (OA TC6 0xFF00 -
> +	 * 0xFF1F), of which only 0xFF00 - 0xFF03 are implemented) cannot be
> +	 * accessed while frames are being received by the PHY. In case this
> +	 * happens the CONFIG0 and CONFIG2 register values will get corrupted,
> +	 * getting a random value. Both reads and writes cause the same
> +	 * behavior. This is a workaround that avoids MDIO accesses all
> +	 * together. Since this is a 10BASE-T1S PHY, only the loopback and
> +	 * reset (AN) bits in the control register (0x0) can be written.
> +	 * These functionalities have custom implementations in the PHY
> +	 * driver. Since the MAC and PHY are integrated in the same device, we
> +	 * can read the OA TC6 MACPHY ID register instead of the PHYID (0x2
> +	 * and 0x3) ones, as their value matches. C45 accesses do not cause
> +	 * this issue.
> +	 */
> +
> +	switch (regnum) {
> +	case MII_BMCR:
> +		return ADIN1140_PHY_CTRL_DEFAULT;
> +	case MII_BMSR:
> +		return ADIN1140_PHY_STATUS_DEFAULT;
> +	case MII_PHYSID1:
> +		ret = oa_tc6_read_register(tc6, ADIN1140_MACPHY_ID_REG,
> +					   &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		return FIELD_GET(GENMASK(31, 16), reg_val);
> +	case MII_PHYSID2:
> +		ret = oa_tc6_read_register(tc6, ADIN1140_MACPHY_ID_REG,
> +					   &reg_val);
> +		if (ret)
> +			return ret;

Is it even worth reading this register? Why not hard code this as
well? Or do you expect a new version of the device which is less
FUBAR, and having a different PHY ID?

> +static int adin1140_mdiobus_write(struct mii_bus *bus, int addr, int regnum,
> +				  u16 val)
> +{
> +	return 0;

-EIO. Since writes are not support, you want to know if something
 actually does a write.

> +static int adin1140_mdio_register(struct adin1140_priv *priv)
> +{
> +	priv->mdiobus = mdiobus_alloc();
> +	if (!priv->mdiobus) {
> +		netdev_err(priv->netdev, "MDIO bus alloc failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	priv->mdiobus->read = adin1140_mdiobus_read;
> +	priv->mdiobus->write = adin1140_mdiobus_write;
> +	priv->mdiobus->read_c45 = adin1140_mdiobus_read_c45;
> +	priv->mdiobus->write_c45 = adin1140_mdiobus_write_c45;

Name? id? 

      Andrew

