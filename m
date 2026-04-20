Return-Path: <netdev+bounces-279736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OACtAfIk5ml1sgEAu9opvQ
	(envelope-from <netdev+bounces-279736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:06:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A042B3A1
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7D3230AEEAC
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0CF39EF1C;
	Mon, 20 Apr 2026 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5I4a1zCb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7439BFEF;
	Mon, 20 Apr 2026 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689738; cv=none; b=le5RVHVzE1vnFq4XIUDAeZ4Oobqw1CMWcZEwkETNkixwfZBJWlfppCLb7LbU1Oc6+hwXrPrhK06wEVDHVAr4H4WE17znWBGFbkp8Ii96fwSw17fv3CtoMwkMEwgJz6mgo0E0qnM8cRmMcGsP4eetkWYdESAu6DFoQPtTO3jdWcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689738; c=relaxed/simple;
	bh=d45Xa2/GroMjYI6hcMvyw5rjVTXSny3hJGB9SMNsRD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klanM9IccQIWcrRHDBb4Gva0rAmfeAk+YpFzdXsuALwenXhmfBNEnA6HqzmF7yYdxgpBl6o1hxBQYTdqcIqQBOov4uNpBe96+UJcRE94s6UGnSstNC20zoDv8Ith8k9whhAcO/EudQlV1DZWi41qKy7pctw8Ffsfx23Ja+MSd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5I4a1zCb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7k/G0mxDu1BDRg79O+iI7CDpqcKHLLmptJc15ZbXb3Q=; b=5I4a1zCbI0NK0BDPExyF8GLQsF
	BUfSW0wmwEQRnHPY8gHW0EWjRWpHpnCZ4sXGfZNclCcglgialSjiNpXtt/NtPtBnag8kHODd2N5Sw
	jaIBtGiHG3nqfxVea1Le5LoHgWRnYMKl60nwpqFmC68tW+NeylN3DUqHgUMzbMT5GTBM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wEo9p-00Gk6o-79; Mon, 20 Apr 2026 14:55:21 +0200
Date: Mon, 20 Apr 2026 14:55:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/1] net: phy: realtek: Add support for PHY LEDs on
 RTL8221B
Message-ID: <92e843f7-aec2-4c6c-bc8f-a869c542fcb4@lunn.ch>
References: <20260420100800.2435204-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420100800.2435204-1-amadeus@jmu.edu.cn>
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[jmu.edu.cn:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,armlinux.org.uk,makrotopia.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	TAGGED_FROM(0.00)[bounces-279736-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[lunn.ch:s=20171124];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jmu.edu.cn:email]
X-Rspamd-Queue-Id: 563A042B3A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 06:08:00PM +0800, Chukun Pan wrote:
> Realtek RTL8221B Ethernet PHY supports three LED pins which are used to
> indicate link status and activity. Add netdev trigger support for them.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
> Changes in v2:
> - Invert the LED polarity in led_brightness_set to achieve LED_ON.

Nice idea.

> +static int rtl822xb_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				       unsigned long rules)
> +{
> +	u16 val = 0;
> +	bool act;
> +	int ret;
> +
> +	if (index >= RTL8211x_LED_COUNT)
> +		return -EINVAL;
> +
> +	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
> +	    test_bit(TRIGGER_NETDEV_LINK_10, &rules))
> +		val |= RTL822X_VND2_LCR_LINK_10;
> +
> +	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
> +	    test_bit(TRIGGER_NETDEV_LINK_100, &rules))
> +		val |= RTL822X_VND2_LCR_LINK_100;
> +
> +	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
> +	    test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
> +		val |= RTL822X_VND2_LCR_LINK_1000;
> +
> +	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
> +	    test_bit(TRIGGER_NETDEV_LINK_2500, &rules))
> +		val |= RTL822X_VND2_LCR_LINK_2500;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
> +			    RTL822X_VND2_LED(index), val);
> +	if (ret < 0)
> +		return ret;
> +
> +	act = test_bit(TRIGGER_NETDEV_RX, &rules) ||
> +	      test_bit(TRIGGER_NETDEV_TX, &rules);
> +
> +	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR6,
> +			      RTL822X_VND2_LED_ACT(index), act ?
> +			      RTL822X_VND2_LED_ACT(index) : 0);

I think to be safe, you probably should set the polarity back to its
default. Or you need to add to the commit message that you have
verified that ledtrig-netdev will always turn the LED off before
offloading to hardware, so resetting the polarity.

    Andrew

---
pw-bot: cr

