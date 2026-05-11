Return-Path: <netdev+bounces-286804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJo6EN4tAmq/ogEAu9opvQ
	(envelope-from <netdev+bounces-286804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:28:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9586B5151F7
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A1403028B5F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA884D2EDC;
	Mon, 11 May 2026 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QMG49vky"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368A4C9019;
	Mon, 11 May 2026 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527422; cv=none; b=YKKTuRrjtHCDflVLVc1tLhEJs3gv2D5luOdYuxkR3piaNRtbIph/wxIbL3ZexsxGhiUhWiyjZF5a/In/lTKB8R1oxGK576GK0Kb0YGwcbB0M35gT3uafiKRWf+s6fwq7IwDH8NV1I04rRzbgtMneU43droZFWbsCVnZv+zhgMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527422; c=relaxed/simple;
	bh=2eDJwSupo1qWp4ZTpHWBFCKSQ4/uALO9LVe0DMqm2xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rke4xXdbY2WxP1XXQWDFHZjDPAnIrisjd/sDgnaNsiio+mPlUx4oATWkqaXxCrorQPE4QcMzH4oIIsssSB6CvSXxug1s17V7PMjrwqOQlAXDxjZ2cR7wVxr7c0ctL/mevWUotYcdEKtMPntLSVRTYJHzLO/sxv1l7IZg1lfkWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QMG49vky; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ENLd4KF43327LLjcpS8p94bb8KCR2F7+2jjA4sggnFI=; b=QMG49vkyytsS59eiBMrgH/BsNO
	p7anqIGp76CdG9f9ku3fLLaYcN7ImyPw4ivFqiBQZZZ2q6nYtNIOlLVpc4UzTcPU4PCKrYdVRqLF1
	i6ZXfXLE6tXg7k8JGoNRa4mtZGsPt89FRcOgb8xJ/Noop2WqeC1QxtSB+RtuaIhGR+RQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMWDy-002Qex-WB; Mon, 11 May 2026 21:23:31 +0200
Date: Mon, 11 May 2026 21:23:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/9] net: phy: ncn26000: Added PHY loopback
 and read/write MMD callbacks
Message-ID: <774d54e2-235c-4685-a582-f9714132923a@lunn.ch>
References: <CY8PR02MB9249CDA8F2C560FDD0F662D883382@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249CDA8F2C560FDD0F662D883382@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: 9586B5151F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286804-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim,onsemi.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 06:19:11PM +0000, Selvamani Rajagopal wrote:
> - PHY loopback has to set only BMCR_LOOPBACK bit. As a result, we can't
>   use generic, genphy_loopback.
> - Direct MMD calls via Clause 45 read/write avoids indirect calls.

The threading of the patch appears to be broken.

Also, one patch, one type of change.

> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  drivers/net/phy/ncn26000.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
> index 68b0e4647..d302e04c8 100644
> --- a/drivers/net/phy/ncn26000.c
> +++ b/drivers/net/phy/ncn26000.c
> @@ -162,6 +162,39 @@ static int ncn26000_config_intr(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +/* Directly accessing via Clause 45 read avoids the extra
> + * SPI accesses required by indirect access.
> + */
> +static int ncn26000_read_mmd(struct phy_device *phydev, int dev, u16 reg)
> +{
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int addr = phydev->mdio.addr;
> +
> +	return __mdiobus_c45_read(bus, addr, dev, reg);
> +}

This needs more explanation. Maybe you need to look into
phydev->is_c45.

	Andrew

