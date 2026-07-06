Return-Path: <netdev+bounces-305103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VVbgG+TOS2qmagEAu9opvQ
	(envelope-from <netdev+bounces-305103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:51:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 610B4712D27
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:50:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=SDjUcqLQ;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305103-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305103-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8D2B30FE8CB
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EFE4252BD;
	Mon,  6 Jul 2026 14:57:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC6421F00;
	Mon,  6 Jul 2026 14:57:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349861; cv=none; b=GwWAQZ0kg2ZSltHI9N3mmXOk8fKA4lCIBYiApoIPeLQpJ1FIsPoO2I3g2kxQpgCh1Lq1xTnZyLwXjQbs5v8DTs/jWqN7HQIVqCh8eFi5ytAieC2K7XkoiWnavr8hlpsedHNpl4v3ybNFReHKpxQDMTRjugzLWAcbjq1X0xTZDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349861; c=relaxed/simple;
	bh=VTvytXf49n9wDy4qHB7eU0wl2Euee5GucAXeQgkW1r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGE8BB0P4+o14QMV+GzalPdA1E9ThW1OtS3ERB6kjrLPnECyfvznmNIaBjSBenTE7RLcvLmeCJBjOquXtq6B9A+KJ1+VZwA3auP5DdJyDfhADyDtpdGfzD95JrfI/6icvWQGX7vkIXYW24rnFN/eU4wp0J65rlO/hyZhYE1CFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SDjUcqLQ; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ADaEzG5k+SdavN1eHzHBe+2hNmvFIXHsmoacs5qvmYM=; b=SDjUcqLQVM9+ct2Tl1Dpp6lmbL
	r+rH8J3EJnI1wsdMkIvrWsN6Hd84jsKsX82Di6Dltnfoi44kSgm2E+6LZDs4pui2lepL0ljcUQEbo
	Ul4664ULpjAbaZIUX28xkaPTqUiYo7MtfhFIxPjdRANKyyjAyLVsB8ssBN/viQm9bN1E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgklE-00B0Wp-Ny; Mon, 06 Jul 2026 16:57:28 +0200
Date: Mon, 6 Jul 2026 16:57:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yanan He <grumpycat921013@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 3/5] net: phy: motorcomm: Enable optional clock for
 YT8531
Message-ID: <e73a58e4-f9d2-46ea-8124-730f67936aee@lunn.ch>
References: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
 <20260706-rv1126-alientek-dlrv1126-v2-3-ff3176ca362b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-rv1126-alientek-dlrv1126-v2-3-ff3176ca362b@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-305103-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:grumpycat921013@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:Frank.Sae@motor-comm.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com,motor-comm.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 610B4712D27

On Mon, Jul 06, 2026 at 05:14:43PM +0800, Yanan He wrote:
> Some boards feed the YT8531 PHY from an SoC-provided external
> reference clock described by the common ethernet-phy "clocks" property.
> 
> Enable the optional PHY clock during probe so boards can model this
> clock as a PHY input instead of keeping the clock alive from the MAC
> driver.
> 
> This is needed on the Alientek DLRV1126, where the PHY reference clock
> is provided by CLK_GMAC_ETHERNET_OUT.
> 
> Signed-off-by: Yanan He <grumpycat921013@gmail.com>

Please separate this out and post to netdev.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

