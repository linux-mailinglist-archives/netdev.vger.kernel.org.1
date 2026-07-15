Return-Path: <netdev+bounces-307633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hNkWL/zgVmpFCQEAu9opvQ
	(envelope-from <netdev+bounces-307633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 03:23:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47796759DC6
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 03:23:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=yVJcr72W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307633-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307633-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6E4730174E9
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9946737A854;
	Wed, 15 Jul 2026 01:23:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEE9379EDA;
	Wed, 15 Jul 2026 01:23:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078586; cv=none; b=NCZp8XHqVjyx7vszcs6cerAO4akzZDNHPLa5wQUqOc9J2epRbU9LxXJDhR0c/FV0+E7W+qy6ww5BB3vKfAYn9lZJtKRqdof4lxKT5w5gsgPhLzsu/jPY47jk2E5XIgiLqmpMu/nOQiDass+9UKyTpwIhofdva1kXO2l9B8BaJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078586; c=relaxed/simple;
	bh=ALNjLK7mfttHKLhhylYdx/L25TSASK/bzxXH7dwg8VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H16pkl/ZF1MaPnR8vHAB2gOJYDlYRPeNpJ4/XKa7eRhu3rIpo5oLsfiqdhhpjTZnRsSD1HQ3Tc3TtF8Rvql0d/Cr03qEyyrWhRqI/QZHOLzqM7jjyTEIgiVAW0SUSl1gry4CG4oEo2RWzEwqbPRUpNwjeLXbu/XYEQvzSRm/32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yVJcr72W; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=46KRPMy9u5mU2TKTccVzrsXsAqZY9tVODkcEVrUETYY=; b=yVJcr72W8TTwXeNlB+kFnhdYDO
	fyUw7Fto58/Ps3cswXSx/M3Dh7S7VF32FAx23uQEnNWL9YrY9hfz2hne+dR/st6O0IfrD77k5DEPT
	V+kD7wV0i6eWdwbbiHl0uBcEgtMhxBiukbNoK3YH0VLvC6yThZxshugf2l571JTurhCo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjoKs-00CHOV-4g; Wed, 15 Jul 2026 03:22:54 +0200
Date: Wed, 15 Jul 2026 03:22:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: dinguyen@kernel.org, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org,
	robh@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/4] net: stmmac: dwmac-socfpga: Add support
 for Agilex5 TSN GMAC with FPGA converter
Message-ID: <2f3763bc-678e-4346-b060-d3bc8afb67b3@lunn.ch>
References: <20260714021303.30042-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260714021303.30042-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714021303.30042-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307633-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47796759DC6

On Mon, Jul 13, 2026 at 07:13:03PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
> implemented as FPGA soft IP between gmac1 and its PHY. This converter
> provides the RGMII TX/RX clock delays, so the MAC interface selector
> must be configured for GMII while the PHY is configured without delays.
> 
> Add the "altr,socfpga-stmmac-agilex5-tsn" compatible to the match table
> and detect it in probe to force GMII for the MAC interface selector and
> strip the delay bits from phy_interface so the PHY is not configured to
> add delays already provided by the FPGA converter.
> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

