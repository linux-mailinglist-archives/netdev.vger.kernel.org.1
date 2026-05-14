Return-Path: <netdev+bounces-287953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMxnLHvEBWrDbAIAu9opvQ
	(envelope-from <netdev+bounces-287953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:47:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B944541E56
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6740930075DB
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C962D0601;
	Thu, 14 May 2026 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a2uNjhZ9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0A282F2F;
	Thu, 14 May 2026 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762838; cv=none; b=gMMwzr0k5gZDIH12k0lAfLMNN9+stgNpdTJC/OC1Xw+94gwwJPUq8ydZxd5Gj9EnKfnTIOIs+2KPvWZtMj0uaCGuEBJ1kOuPJcaNkr/3SM1/HtPa9UMUNb4yQBqE/496Pts63TAq00BTySjC/6UGc9xKwHBbzK4UyatnxvgGTjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762838; c=relaxed/simple;
	bh=yoVAvp7pHRVc4DkQdbSy/XLc3BwEObT4InsDVt4WFy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxzTTi5dIceH9LHlmqo2+F2XiSpd5xFqhPeUi71GJueNOakhAEMoHyeUu+Z2TbH663E4VrMoHwWd0i6i34PelMclEwIPyYW9EAsr3u1hS2rhhCqt8AiQoruXIyGSTy6KmeGgk5KUaIIJJeq6cys5eM0WRlwifvvSx1QNMmCi6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a2uNjhZ9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j4bRrTNfRBQLwsFjpSvhQl/Ejn6DGvSdQI//AyCtSfk=; b=a2uNjhZ998zIqSK9knSkpQ0rpW
	3sCQ/8aRhYvZwUs2DuJIpmoXaQn7vxREQIEole1EsRVAnoueZaHvyBZve8Jplg8Dntwk58GX/499Q
	O1kjRv6J3lwWlzD1ma9XePL3wgzKdSeyclHDUMdqKU1Es4W/bsUVsdqQATx1voxwgT1k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNVT3-002u9f-Rh; Thu, 14 May 2026 14:47:09 +0200
Date: Thu, 14 May 2026 14:47:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x device
Message-ID: <053eaadf-07f3-431f-a0a4-28980adb8213@lunn.ch>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-3-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514105028.42942-3-thangaraj.s@microchip.com>
X-Rspamd-Queue-Id: 1B944541E56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287953-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 04:20:25PM +0530, Thangaraj Samynathan wrote:
> Reads the SFP enable bits from the strap registers to determine
> if the hardware is configured for SFP usage.

What exactly does this strapping mean? Is there a definition in the
documentation?

> Introduce CONFIG_LAN743X_SFP to guard SFP-specific code

Why? Does this add a lot of code? Most MAC drivers don't have such a
Kconfig configuration, so i think this needs some justification.

> +#ifdef CONFIG_LAN743X_SFP
> +	if (adapter->is_pci11x1x && !adapter->is_pcs_en &&
> +	    adapter->is_sfp_support_en) {
> +		netif_err(adapter, drv, adapter->netdev,
> +			  "Invalid EEPROM configuration: SFP_EN strap specified without SGMII_EN strap\n");
> +		adapter->is_sfp_support_en = false;

Shouldn't that be fatal? You have no way to drive the hardware, so is
there any point going further?

What also seems to be missing here is the case where the strapping is
set to indicate SFP, but CONFIG_LAN743X_SFP is not enabled. That
should also be a fatal error.

	Andrew

