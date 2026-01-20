Return-Path: <netdev+bounces-251459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIYZIb5qcWmaGgAAu9opvQ
	(envelope-from <netdev+bounces-251459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:09:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CF45FD4A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D046964AB2E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1A3D7D70;
	Tue, 20 Jan 2026 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hovWwipu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617FF3A9631;
	Tue, 20 Jan 2026 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908581; cv=none; b=RbAWCWX510pWsLF1n3SoF5Rgzl3AhLVXv6AHAZHrKojdOvJ3XBhaTVG7PMmoKFN34rp0iQXJD5tNA86vanoEMyzAhhAePuVo9tU/LwyIJKiLQNe4QAsTmbRKMyDho/KsRiPQ3aS4ZlSW/khuOgo38CkD0O1tenUM6q2SBFX+dpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908581; c=relaxed/simple;
	bh=zD8PS2BxyO8mlqAByme4yWQvJMWzaVsGbWniXAdX0VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRsEnsUq2KE3bfWOWxFzYX9wJWgDg+aTVIuboj3MDfz+pmbhzEtSQIld1PuSwIDUizDJi+J9BAfMnu7KLKC/CW+NeoG5yAyybAadGSsMgE7sXuzNscdwTa4gpsWe9uY2qyAG54rjhobcS7i9nIXTSDyuuMIKox+5jaeDhnscV2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hovWwipu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AjnwvV2BqvE2aPiFrCHPh0/mzQujqmD6N4sIt6a5sZU=; b=hovWwipuHB57LKi4MlszUuI8DP
	CgD3oSh3KhgWsMTfb486kUstGtEakbhWKS3+1iC5/urnMW79/L40gcwZ5abtlbaHeVDneWxj/KXyX
	eTJv0JZfc3wkTMmGRw7nkB0HxBhoRPNL5zkIKvCd+Dsv6eBFJLW2/pEYOO2FIvMQl4Su8K1KY6UZi
	PrXKLOXfxQQycmy+X6n53r84bKvM9JlWyEx096TTXdb2WDyBWNjezyvY8YMZ1iQmo/Hfbr+wGtFAY
	C9aaJwM1f6p7mnsw1EmmDjJrl5vXbwvoF6LduEgFjCuro5aKLguFLKEm7NSzHR4V0bm8WPRMvX/zN
	vUNCdoYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59282)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vi9us-000000006A6-2vXc;
	Tue, 20 Jan 2026 11:28:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vi9uj-000000007Tq-3hBk;
	Tue, 20 Jan 2026 11:28:49 +0000
Date: Tue, 20 Jan 2026 11:28:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <me@ziyao.cc>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add glue layer for Spacemit K3
 SoC
Message-ID: <aW9m8YOVO1ClIQOd@shell.armlinux.org.uk>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-4-inochiama@gmail.com>
 <aW9jbqBSgkiLLw8r@pie>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9jbqBSgkiLLw8r@pie>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[36];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : No valid SPF,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,cqsoftware.com.cn,disroot.org,nxp.com,bp.renesas.com,linux.intel.com,bootlin.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251459-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F0CF45FD4A
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 11:13:50AM +0000, Yao Zi wrote:
> On Tue, Jan 20, 2026 at 12:36:08PM +0800, Inochi Amaoto wrote:
> > +static int spacemit_dwmac_probe(struct platform_device *pdev)
> > +{
> 
> ...
> 
> > +	of_property_read_u32(pdev->dev.of_node, "tx-internal-delay-ps", &tx_delay);
> > +	of_property_read_u32(pdev->dev.of_node, "rx-internal-delay-ps", &rx_delay);
> 
> According to of.h, of_property_read_u32, which in turn calls
> of_property_read_u32_array, could fail with -ENODATA if there's no value
> associated with the property. Should the case be handled?

You cut too much. This had:

	unsigned int tx_delay = 0;
	unsigned int rx_delay = 0;

at the start of the function.

of_property_read_u32_array() says:

 * @out_values: pointer to return value, modified only if return value is 0.

and of_property_read_u32() passes &tx_delay or &rx_delay to this. Thus,
if any error occurs, these will be zero. In other words, a missing
property is equivalent to setting these to zero, which is entirely
reasonable.

However, "unsigned int" _may_ be type equivalent to "u32", but really
these should be "u32" if of_property_read_u32_array() is used.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

