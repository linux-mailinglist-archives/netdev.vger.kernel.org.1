Return-Path: <netdev+bounces-284816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJRaH5c3+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:44:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 054904DA678
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88D12309B923
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C0B44CF5B;
	Wed,  6 May 2026 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uUkmLDnR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75943E4A9
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071193; cv=none; b=kXv6ODGpRh7X4ZTfIeIO65eqCJR7aDWM9YKtHyDVs0zhYjsjBYEe6U66PKdrEDfFFhKb74C4BReqrvcX5DwxctDjln2Cj+i9yTy4JDawKpLTDDVGxAc9zD8zphj+Z/SCsDFhHpBly1yf1j+4mlPPhnSQBj60igsEkBG0gYI1SNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071193; c=relaxed/simple;
	bh=dcUsp3eDN08mhGEPEOKTdjFKeAPZPYk4Eevrg96/aMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hsqljs5196yoPOdcs1o470tqfvYk+PucFxyQEtHmsNdClyj6WrNZeu6mEk6s1+1sPjegsyWo7YxCvVXPs32SrRZkLccD4gEjWfclXXZzqJnTCdaSxRcabAI7ZwGfWI0KFioU/FMIm8QPKQFe2myysXcGaLFVl9+2jXoNtv4/7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uUkmLDnR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UCfwcMyYej1X3CdP6H1s2pU7FOACwOy/8EFy1L1nI8A=; b=uUkmLDnRpg0eEui8UmYyeN3aTj
	TcljOrlBnchvjbKQqFtH58ctrtunfdADJIW/RLul9y71GKHOipU/p0Z1HyxgwOtQe9ZuBmAQCLqnT
	uoJTKYGKxgN81kECwlRceAn49cv1S2Rj3k3m27Jn2S8IgIq1rYVtZtmiBxWnZpWaYSkA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKbXU-001dVG-Gz; Wed, 06 May 2026 14:39:44 +0200
Date: Wed, 6 May 2026 14:39:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Message-ID: <7778cd41-cf36-4524-a347-408a8fb0bde0@lunn.ch>
References: <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
 <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
X-Rspamd-Queue-Id: 054904DA678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-284816-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

> So for me it somewhere happens in phylink_validate_mac_and_pcs()

I was expecting to see more debug output, but reading the code, i was
also thinking we need to look at phylink_validate_mac_and_pcs().

You are going in the correct direction putting lots of printk() in the
code. We need to find where it returns EINVAL:

static int phylink_validate_mac_and_pcs(struct phylink *pl,
					unsigned long *supported,
					struct phylink_link_state *state)
{
	struct phylink_pcs *pcs = NULL;
	unsigned long capabilities;
	int ret;

	/* Get the PCS for this interface mode */
	if (pl->mac_ops->mac_select_pcs) {
		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
		if (IS_ERR(pcs))
			return PTR_ERR(pcs);
Possibly.


	}

	if (pcs) {
		/* The PCS, if present, must be setup before phylink_create()
		 * has been called. If the ops is not initialised, print an
		 * error and backtrace rather than oopsing the kernel.
		 */
		if (!pcs->ops) {
			phylink_err(pl, "interface %s: uninitialised PCS\n",
				    phy_modes(state->interface));
			dump_stack();
We don't see a stack dump, so not here.

			return -EINVAL;
		}

		/* Ensure that this PCS supports the interface which the MAC
		 * returned it for. It is an error for the MAC to return a PCS
		 * that does not support the interface mode.
		 */
		if (!phy_interface_empty(pcs->supported_interfaces) &&
		    !test_bit(state->interface, pcs->supported_interfaces)) {
			phylink_err(pl, "MAC returned PCS which does not support %s\n",
				    phy_modes(state->interface));
No error message....				    
			return -EINVAL;
		}

		/* Validate the link parameters with the PCS */
		if (pcs->ops->pcs_validate) {
			ret = pcs->ops->pcs_validate(pcs, supported, state);
			if (ret < 0 || phylink_is_empty_linkmode(supported))
Could be...			
				return -EINVAL;

			/* Ensure the advertising mask is a subset of the
			 * supported mask.
			 */
			linkmode_and(state->advertising, state->advertising,
				     supported);
		}
	}

	/* Then validate the link parameters with the MAC */
	if (pl->mac_ops->mac_get_caps)
		capabilities = pl->mac_ops->mac_get_caps(pl->config,
							 state->interface);
	else
		capabilities = pl->config->mac_capabilities;

	phylink_validate_mask_caps(supported, state, capabilities);

	return phylink_is_empty_linkmode(supported) ? -EINVAL : 0;

Also possible.

}

In the end, we are probably going to find that what the MAC says its
capabilities are don't match what the PCS says it can do.

Thinking about that, it says phy mode RGMII. You generally don't use a
PCS with RGMII, so that is suspicious.

    Andrew

