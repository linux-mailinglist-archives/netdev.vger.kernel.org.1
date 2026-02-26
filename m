Return-Path: <netdev+bounces-261459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJTkEnmHoGlvkgQAu9opvQ
	(envelope-from <netdev+bounces-261459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:48:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2561ACDA3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB6C734EE9EF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ABA4C77B9;
	Thu, 26 Feb 2026 16:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E53744103F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121987; cv=none; b=fgG9Lb0pFKa7VwDmjKH3y3O1hf6fLaZWoRarKgnDK2WKWzLSRQLoNP6/Xp2z49tL7oEc8qO6pueJcnWWsXpLx2VwbLmWZX6Fv4ze0yo8e7kTDYgkNkTPe0UTmSOjzmLjyXDXBC322wefLYwKIBZXOs7pxwta2OxcWQJPf7OqDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121987; c=relaxed/simple;
	bh=Ihx26FJcEqx3rS49sNroyXVpZ7+ilkUxM1VHMpsimPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwltfKdSapSYr9vtxyX9zsay0/A3UTtf2UygxD2yoU6OL/i09x9XXXvqLAFR1D9vK7Tb5nTzYvlSq4SHKRaRX4TIqffrFth2cW1crWVTuj66Px/dNj8ZDkitndzRNrsiVsvbxMOfVkje+hu0T+qxj5uoVEkySO/W8qrp2Z+nxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vvdsO-00000000310-1Uak;
	Thu, 26 Feb 2026 16:06:08 +0000
Date: Thu, 26 Feb 2026 16:06:00 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v4] net: ethernet: mtk_eth_soc: avoid writing to ESW
 registers on MT7628
Message-ID: <aaBvaG3M58W4lhVC@makrotopia.org>
References: <20260226154547.68553-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226154547.68553-1-joey@tinyisr.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261459-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid,denx.de:email]
X-Rspamd-Queue-Id: CA2561ACDA3
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 03:45:18PM +0000, Joris Vaisvila wrote:
> The MT7628 has a fixed-link PHY and does not expose MAC control
> registers. Writes to these registers only corrupt the ESW VLAN
> configuration.
> 
> This patch explicitly registers no-op phylink_mac_ops for MT7628, as
> after removing the invalid register accesses, the existing
> phylink_mac_ops effectively become no-ops.
> 
> This code was introduced by commit 296c9120752b
> ("net: ethernet: mediatek: Add MT7628/88 SoC support")
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>

Reviewed-by: Daniel Golle <daniel@makrotpia.org>

Cc: Stefan Roese <sr@denx.de>

