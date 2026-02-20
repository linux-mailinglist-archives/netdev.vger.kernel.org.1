Return-Path: <netdev+bounces-259730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI4OACZ6mGnoJAMAu9opvQ
	(envelope-from <netdev+bounces-259730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:13:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E7168CC7
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6235308206E
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCEF3446AB;
	Fri, 20 Feb 2026 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bu7NjwTu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3313191CE;
	Fri, 20 Feb 2026 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600389; cv=none; b=NPb5WLqOMHjWa2mM6YOTYmAKAMiRfOaNJZePB4vh01XgN5pJxawPDCjRktAjFyzVMendFEGAlIdDtKPLU/xRU5pA0HTCw/PdAosKVyRmnB+JAjH39ruO65audm78RUM2hztzQZQRWrZUp4t8OaCD/wBPsv+3HhOkxDcYFDYYOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600389; c=relaxed/simple;
	bh=Fa4N8Zt2U/CkIqTaUNoew/2A40MXue604G1Rgpx22/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t77/rOja9z53HoaMHClkPIIAr2+6hbS5S7Hh2B7BEQQc8YT4oyzBw5/mOLwglgPpSQyIOmlqWJNeo8tX9yn5JLx//vwdvbFBSBONmfZGp1sglbicwkn85ON43G1SzsyUB+Sxkt0Cv8wcnEySlycxdCAXX4CtLnqr+DGAgqTXzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bu7NjwTu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=glnVZ1vMZv9aWF2wKZdYdswnC52ACNG6S8Ew13Mey4U=; b=bu7NjwTuqCQKObShYzfB2fAsDD
	yztfSUs+GKhARZ6yLw1yBpDA9f6HpeGy86k+DZhaaN0LQVSvZQ8/A/wEYuMMANgJGD+Tb04Rq0EbP
	jIE8Mo7cpxjuW+oxEQ1F6xU4pZwegPqodjR63cWvWT83ne0i0sQS19U1wfrKr6R8822k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vtSBf-0085Nd-SQ; Fri, 20 Feb 2026 16:12:59 +0100
Date: Fri, 20 Feb 2026 16:12:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [RFC PATCH 4/8] xilinx: tsn: Add Ethernet MAC (EMAC) and MDIO
 support to the TSN driver
Message-ID: <39ae9c0f-d832-4771-8177-838995fff4da@lunn.ch>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <20260219054911.2017362-5-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219054911.2017362-5-srinivas.neeli@amd.com>
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
	TAGGED_FROM(0.00)[bounces-259730-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 589E7168CC7
X-Rspamd-Action: no action

> +#define TSN_EMMC_LINKSPEED_10		0x0	   /* 10 Mbit */

If the MAC cannot do 10Mbps, why have this?

> +static int emac_open(struct net_device *ndev)
> +{
> +	struct tsn_emac *emac = netdev_priv(ndev);
> +	struct phy_device *phydev = NULL;
> +
> +	if (emac->phy_node) {
> +		phydev = of_phy_connect(emac->ndev, emac->phy_node,
> +					tsn_adjust_link_tsn,
> +					emac->phy_flags,
> +					emac->phy_mode);
> +		if (!phydev)
> +			dev_err(emac->common->dev, "of_phy_connect() failed\n");
> +		else
> +			phy_start(phydev);
> +	}

Somewhere around here, i would expect you to tell phylib the MAC
cannot do 10Mbps. You don't want the PHY offering those speeds for
autoneg, otherwise it might actually negotiate 10Mbps.

I also think you should be using phylink, not phylib. But we first
need to finish the discussion about DSA vs pure switchdev. If this
ends up being a DSA driver, you will be using phylink anywhere. If it
is a pure switchdev driver, i would still recommend using phylink, you
are less likely to get things wrong, because the API is better
designed.

    Andrew

