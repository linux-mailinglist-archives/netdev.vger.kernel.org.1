Return-Path: <netdev+bounces-293753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPpINEuAHWpZbQkAu9opvQ
	(envelope-from <netdev+bounces-293753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:51:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3434A61F923
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 293E33043539
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423A37C11E;
	Mon,  1 Jun 2026 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LZI9tNmR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087137754B;
	Mon,  1 Jun 2026 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317697; cv=none; b=WE0slmfeV58YA8V5/oQ6fx0UgP/OXx7JviAP1n1ILSHTlYXEdwDWeQb4FvmVOr5dZaxR9zrmZECaLft/cp07BXatBSCUk3OV4ayqT3fmiDdzPj1YUkpO7vuQroRctmgy9RT57MPKOxOfELtuoqZ/OBZNocZzZocru14vOozS5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317697; c=relaxed/simple;
	bh=u4PiSoSZooAbUd8wQdKaA6ZrLL49kJDCTZG3iOKcX3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiMXeD+djpRA1VqECMnqsDqGYBOCgeMmtXuyfAarCwHjYNogM7fgw1uZZxL8QbbWbzYE8QAIXxhnqM7AJL19LkrHuIhKMW75xzZdRSYHpHQNdYYdzZDMaSf38mOOMkeA4qglAboiK141Vv+RNUWtlk6mOHpNb3MNSYKHoZx5O3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LZI9tNmR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KsRqxM2R9ENQMMWQg6HVaoMnok6ORhowIPBct5USSBg=; b=LZI9tNmRp5agDatUF4NteFVizk
	1FazNsOCxMqPiDYqbUWZ5NcQhxIrLGpiHDmdhkWC0eIpTJTO3ZvOrK5EWTYhI1mFs8ykjLsHkMgDH
	Lc81Umq+BLuScG1sAAg6kix2W8AX3+XPCw/Gf/FHlU6YDNoyu/uD/2ZsY20antJvxiPw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wU1xM-005VIq-Pg; Mon, 01 Jun 2026 14:41:24 +0200
Date: Mon, 1 Jun 2026 14:41:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj.S@microchip.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Bryan.Whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x device
Message-ID: <e6ef6386-47e2-4a96-ad89-bcf018d794fe@lunn.ch>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-3-thangaraj.s@microchip.com>
 <053eaadf-07f3-431f-a0a4-28980adb8213@lunn.ch>
 <DSWPR11MB971561B42BB157F7C8C436C2EC082@DSWPR11MB9715.namprd11.prod.outlook.com>
 <af49a018-952a-439a-8beb-2e300a1d266a@lunn.ch>
 <DSWPR11MB97156347E4D54CC898A1CA43EC152@DSWPR11MB9715.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DSWPR11MB97156347E4D54CC898A1CA43EC152@DSWPR11MB9715.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293753-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3434A61F923
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > In practice distributions turn on nearly everything. So the code is likely to be
> > built. Rather than a Kconfig symbol, can you move the code into a module,
> > which only gets loaded for pci11x1x?
> [Thangaraj Samynathan] Thanks for the suggestion. We agree this is a reasonable direction.
> For this series, CONFIG_LAN743X_SFP addresses the dependency concern.
> For distro builds that enable most options, a separate module would
> typically be built and loaded as well, so the practical result is the
> same.

Not necessarily. You have a strapping pin, which indicates if the
hardware has been designed for SFP. Use that to load the kernel module
with all the SFP code.

Maybe also go talk to Marketing. What has this device been designed
for and what applications is it marketed towards? You talk about Intel
drivers. They are used in servers and desktop machines. You generally
don't worry too much about code size for those targets, there is a lot
of RAM available. However, if the target market is deeply embedded,
RAM can be short. However, why would use pick an embedded SoC which
does not have integrated Ethernet?  Pretty much all embedded SoCs do.

Make the architecture fit the use case.

   Andrew

