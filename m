Return-Path: <netdev+bounces-261587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBVuFXS1oGnClwQAu9opvQ
	(envelope-from <netdev+bounces-261587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:04:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5E21AF622
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A34230293E0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E530EF8B;
	Thu, 26 Feb 2026 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="brihGOPh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1091D30DEB6;
	Thu, 26 Feb 2026 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139880; cv=none; b=LxdU7E+GM6V0a1MoOFIPCTPC+fUQcy5ieHEs8f6Me1nDeUj0+Hqgx1y6ALd1FGYPf0Iqu5+eZ6kwYHKqHO6OnNJ8z8AHrRC+Db9uW5DylwjRhaBC/fYPmXQkDIB6gDxvNPyl7ZRG+164mhR4DEKILFlJxrF1r9I6hWw8puKxTrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139880; c=relaxed/simple;
	bh=xGtm/tBPND0FtMRSURhQ9FS5yD+L7hfv9/2dPO1NBF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYoCl1IJ/C0vuOP6he8wTeB3hHHJF9AWqoODBXSha8P6oLMpCHqEBuVCdA3BorV07nVGVKELOUsH2JkdLcT+vcXHYs6mmxJCoQzOvcVOj+mPk2ZzzM/UTGUz7T3RixxJSTyqmnFMCwBZ/94zBg+SVCXSGZiEpqzpz2W3KqON8LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=brihGOPh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZQdq8YyptvKqS7gHRNFduaoYEtuz2OOc9PshXdt7tSU=; b=brihGOPh+rWVN/uFV9yMNLuyia
	ajMIO+rCdN14o5BpSwkm1bfwR+7to7TKBC+vha//Jmv8c91kdsWMP2mmXFJ3nA7SEve+ZFdGPBcXj
	Gx44Fj7jDgT3dkNAJA8KzibZcx0sDLrGow/FLrVwzfZ9dCoLyEikvGgqEH/FI3lrd5Z4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vviX7-008wqy-J5; Thu, 26 Feb 2026 22:04:29 +0100
Date: Thu, 26 Feb 2026 22:04:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next v2 2/8] bng_en: query PHY capabilities and
 report link status
Message-ID: <c2fab025-310d-48c6-87fa-adc496541eac@lunn.ch>
References: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
 <20260226182133.1566714-3-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226182133.1566714-3-bhargava.marreddy@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261587-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: AE5E21AF622
X-Rspamd-Action: no action

> +int bnge_hwrm_set_pause(struct bnge_net *bn)
> +{
> +	struct hwrm_port_phy_cfg_input *req;
> +	struct bnge_dev *bd = bn->bd;
> +	int rc;
> +
> +	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_CFG);
> +	if (rc)
> +		return rc;
> +
> +	bnge_hwrm_set_pause_common(bn, req);
> +
> +	if ((bn->eth_link_info.autoneg & BNGE_AUTONEG_FLOW_CTRL) ||
> +	    bn->eth_link_info.force_link_chng)
> +		bnge_hwrm_set_link_common(bn, req);
> +
> +	rc = bnge_hwrm_req_send(bd, req);
> +	if (!rc && !(bn->eth_link_info.autoneg & BNGE_AUTONEG_FLOW_CTRL)) {
> +		/* Since changing of pause setting doesn't trigger any link
> +		 * change event, the driver needs to update the current pause
> +		 * result upon successful return of the phy_cfg command
> +		 */

This commit is a little bit misleading. 

/* Since changing of pause setting, with pause auto negotiation off,
   doesn't trigger any link change event, the driver needs to update
   the current MAC pause upon successful return of the phy_cfg command
   */
   
The pause auto negotiation off is important here.

The code is not the easiest to read because it mixes up PHY and MAC
configuration.

1) If autoneg and autoneg pause is used, you only configure the PHY.
When autoneg completes, you then configure the MAC with the results of
the negotiation.

2) If autoneg is used, but not pause autoneg, you can optionally
remove pause from being advertised by the PHY, but you need to
immediately configure the MAC.

3) If autoneg is off, you you need to immediately configure the MAC.

	Andrew

