Return-Path: <netdev+bounces-253094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJwLAKUUdWlPAgEAu9opvQ
	(envelope-from <netdev+bounces-253094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:51:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C9B7E8D1
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2F1D300292B
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 18:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CC326D4DF;
	Sat, 24 Jan 2026 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uoNT2/v3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91742641C6;
	Sat, 24 Jan 2026 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280671; cv=none; b=VN1ae5zt/EHO0eEnZGYTNCG2wCho1R/XPIzON4aPRGmqgk1qp8U6uzJOEdy60IDPbrrhawci7LMi0hdIctu08BhRPvEIDas43iWBjksiYfHQ381JReDitO774jEhSaiWanc9GoizXKgi8qsVdbPcMsoU4hV3eDSKcPpfbxE6Ajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280671; c=relaxed/simple;
	bh=DhGa3juANfZ7vVYnVY69A48j2DsbZveEIMtrkKqA/ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruABLg3ZMd+3VAvalomdmZT7ggd/lt6qmfr/kWqYP4qsUtqZii3OLQ2dpPl+PtkcHBjN71iq1aT8tyCShLibpHdo3WSbQGAvovDYbB+VMe9Nnufs37ptY2sgP+2x326M6chRmS13DoEe9rjQ0ep9AgrZfmgYYXYiAWyFcGhfUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uoNT2/v3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=++GOc+HlZ7U6+DmkIuWp/qijuKTxwdtHRJtjRUOdUiM=; b=uoNT2/v35GOWeGkKpuFx38uEuT
	C//NWyHqexAOL/F5oACzqYwdyiYDvED+JWHwsthVWQ6mqNXOhQmC498XL+0AeR0FpkZci1ruYI74S
	91auAWCY0YyvcFPLl2EkjGw8a51xspxvQ29EAuMngRUNUWEUxhCS3KlBAqf/V2+ocmgQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjiix-004VE2-Ka; Sat, 24 Jan 2026 19:51:07 +0100
Date: Sat, 24 Jan 2026 19:51:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH net-next] net: usb: replace unnecessary get_link
 functions with usbnet_get_link
Message-ID: <8a1e7173-2520-4b53-aed3-e3186503927e@lunn.ch>
References: <20260124082217.82351-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124082217.82351-1-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253094-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 21C9B7E8D1
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 12:22:06AM -0800, Ethan Nelson-Moore wrote:
> usbnet_get_link calls mii_link_ok if the device has a MII defined in
> its usbnet struct and no check_connect function defined there. This is
> true of these drivers, so their custom get_link functions which call
> mii_link_ok are useless. Remove them in favor of usbnet_get_link.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

