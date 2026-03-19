Return-Path: <netdev+bounces-269563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO/4KUMvvGnquAIAu9opvQ
	(envelope-from <netdev+bounces-269563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:15:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 174F82CFB0E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F222B30ADD2A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F8E3F54A3;
	Thu, 19 Mar 2026 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6HZCgH1V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D963D3CE4;
	Thu, 19 Mar 2026 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939800; cv=none; b=TAzsoUsXwOu/a7AJx1aW3Gg24f6QfBd5FyuBfJFbTgJJHWp20/7ueIkdDPtELt96XczHDifod+ahIH+Td3+3VBAs133Y62nRuulTngmpkLU1/TS2ssXWUGRUK0hFLb4eHrds+poMOP25P8oQKf3CrU+kpHX4XI5CpHNhjyPqg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939800; c=relaxed/simple;
	bh=H6mbJkD4bY73bkEnSvHAiPbJH+mnQLOf3o9uaqpmHDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCcTTO9RVBvnQiX8TmaauY27Pqhkdm01UsuPvBSkXXUAP5QLW65aXW3UwiIR8K+Mnm1WgLAmuRTAoKXp/d/3oMJpfCIGhZC4fVigGIQOg/YooEJJIyojFca9z9uk14yx+8wFPFF1l11jUuBUZC37S8CiFfP6gymwt/mnmU3XM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6HZCgH1V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mIj9dM4yySJHztmJxGxux7K0mwRPGPNHgYqFd1tuVmw=; b=6HZCgH1VXO9zOTio/h4jSeVbYE
	cyjyrjOaH2Tar6wpfXCLqFZPtMXwVWd+f1P8HgaLDa9Y7egINePeGKSNPH2JvZe3HE/PtKv0RiNOg
	ZyQqqGYpkJFnq3bBzRBypnNQGKc/TuGXMjilCP6N1UdA9ZWUE1l7RDmc1jnoWR8RDlRo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3Gm5-00CQAH-4W; Thu, 19 Mar 2026 18:03:09 +0100
Date: Thu, 19 Mar 2026 18:03:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: mdio: add a driver for PIC64-HPSC/HX
 MDIO controller
Message-ID: <c1e28c56-70b7-45b8-a43d-21aca1942764@lunn.ch>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-3-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317184610.315852-3-charles.perry@microchip.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269563-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 174F82CFB0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +	u32 bus_freq;

> +	of_property_read_u32(np, "clock-frequency", &bus_freq);

clock-frequency is not required. So this can return an error, and
leave bus_freq untouched, which is a stack variable with random
contents.

	Andrew

