Return-Path: <netdev+bounces-275107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAmEG9vdz2mn1QYAu9opvQ
	(envelope-from <netdev+bounces-275107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:33:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66789395C8C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13F74300C3BC
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC833C9ED6;
	Fri,  3 Apr 2026 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hcJSb6U4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD23C944F;
	Fri,  3 Apr 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230067; cv=none; b=uncpFGxvLw1BAj13J14vZCCnzXSuM0P41e9Ct879jyQyYuPAwwjs/XLyt3g+OeXeC5v1kMwv0Nx0Fp2U25Z0Oy0lgOEJ6kkemSfmrSQStWs8Par2BrZtSvjrKC2S4A9f2yY2/7NMAiyvrYC7vvzWIek5fVf3pfKTbXR5ouYDT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230067; c=relaxed/simple;
	bh=2YMI5pgxql3AtVXz91JbKDz8JNfnuo7TDqvJp1BwkfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao16OKAtH9EWznOnM8oQGf4Geu8mBpRT708Kzg9ikdmXDOxxS0b02trgdZSi01QrY8u7kkjve7V313Pf+wGuF5UPRo6LPLFstr5wPDBeF1dw1CBbCZGT1ul21IBjKFZI3s5YNWvLweVqOEEvOSNutbEXnXM3GEEUDNjdeHM+An8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hcJSb6U4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tKVOhuzgNNUeA7HRd/Hj2OZajDtiYpskD9RzY7YjiGY=; b=hcJSb6U4IL74l+lmShyRUWSEAV
	56deHxP69l0VbcJ4h123W7CbK+8ZeoNRMFgHIv/Itl7wcxeFYR5r9avrK8rozpBQlOrLaiRSIfOqZ
	NAi71RW+J3VhxNyh1adyNi9TYPzvE3ReOStay3EGthC8MYIsIg4GPozLWfvCbyiq4TsE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8gQn-00EgJ4-1z; Fri, 03 Apr 2026 17:27:33 +0200
Date: Fri, 3 Apr 2026 17:27:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/3] net: phy: add support for disabling
 PHY-autonomous EEE
Message-ID: <fcf80c9b-de04-469f-b66b-b39760fc9af4@lunn.ch>
References: <20260403090656.733985-1-nb@tipi-net.de>
 <20260403090656.733985-2-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403090656.733985-2-nb@tipi-net.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,armlinux.org.uk,broadcom.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-275107-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 66789395C8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> + * @autonomous_eee_disabled: Set when autonomous EEE has been disabled via
> + *	phy_support_eee(), used to re-apply after PHY soft reset

Thinking ahead to when autonomous EEE is supported, there will be
other reasons to disable it than just phy_support_eee(). So i would
not say this here.

>   * @eee_cfg: User configuration of EEE
>   * @lp_advertising: Current link partner advertised linkmodes
>   * @host_interfaces: PHY interface modes supported by host
> @@ -739,6 +741,7 @@ struct phy_device {
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_disabled_modes);
>  	bool enable_tx_lpi;
>  	bool eee_active;
> +	bool autonomous_eee_disabled;
>  	struct eee_config eee_cfg;
>  
>  	/* Host supported PHY interface types. Should be ignored if empty. */
> @@ -1359,6 +1362,21 @@ struct phy_driver {
>  	void (*get_stats)(struct phy_device *dev,
>  			  struct ethtool_stats *stats, u64 *data);
>  
> +	/**
> +	 * @disable_autonomous_eee: Disable PHY-autonomous EEE
> +	 *
> +	 * Some PHYs manage EEE LPI autonomously without forwarding LPI
> +	 * signaling to the MAC.

My understanding is that LPI is always from the MAC to the PHY?


> +	 * Called by phy_support_eee() when the MAC indicates it supports
> +	 * EEE. PHY drivers that implement autonomous EEE should provide
> +	 * this callback.

Again, there will be other reasons to call this, than just
phy_support_eee().

    Andrew

---
pw-bot: cr
	

