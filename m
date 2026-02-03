Return-Path: <netdev+bounces-256210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMsSC5a8gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:15:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6793D6A9B
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE8A30B4171
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF22396B86;
	Tue,  3 Feb 2026 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="efUwOsx9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD87260F;
	Tue,  3 Feb 2026 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109802; cv=none; b=eUOB6mQf5SWq5Ql84ge+9Z2+mBmLXYGsJ1Y/zl46n+8JnVTHZMvRFo7ow4eMRVyDLt+tXGzqawHMec38Y/EaO1pCks+yvGZ8UEyuc7Oz3l5IHKBgAwE7D5kyCsxl7/QpFAH842l9Hb6g83Wuze0jQtHNTJ3ll2Dm5EcqfTBKbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109802; c=relaxed/simple;
	bh=L7Kh/bqhafCATcc9hmnZnvvIskm6OmlNj10QxSsKNbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niOVtcKv+ml8mjaK4SYgiGcA74/S/sGYKaUJGsu+4Jo0NeoRFW+lI6DwgJ8ZI7VplUAmxm2ZvfwR0hxkJR7hLEeKX4F12Q1NcNTv1W3CT9pgc0tZSnITw0U7XM/CvxvA3eKDNGnxrOnwu5W0OkT28+mJ3HUFNmC1pv/sdIOpoI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=efUwOsx9; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8EF46C211D6;
	Tue,  3 Feb 2026 09:10:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5779960728;
	Tue,  3 Feb 2026 09:09:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F060F119A88FD;
	Tue,  3 Feb 2026 10:09:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770109796; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QOT/HywNFpZOIuExwAQ6ejkkEBKtyxh49WINkpm07Cw=;
	b=efUwOsx9RK054mZF2HF3Q0OTGS2uw8nH/eF6hdYdjXDFDtVoRMap2MDsZZ0iStv34tDqcy
	DUJSUI+42ezuUpvXkVYy5iRLk3xK03mu0bMaIYGeX0+SRPkfvZhGsPdFEEJMrcI/JFMZRw
	yqun50MkEQjC127rBsOJ9+zqNTZfFpRhnhInyTGVfTlDT0Ns6WPvG+okLEvYGMCkeVZq9B
	52P9Ub2ahyLleS7Gu2/GJcRjFc/sFXoKuF6nKwAiHUV86EpxK8HZcfxvkr2eK4wGvrzjrk
	3PGzyQzyZi9cMRmJDu+1tbxTcbCelN3+ICs3h9ET/N3dHkaUCj4p3JIl0G4+EA==
Message-ID: <75c590f9-aa08-4b8d-8dbf-422273012c74@bootlin.com>
Date: Tue, 3 Feb 2026 10:09:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] dt-bindings: net: ethernet-phy: add property
 enet-phy-lane-order
To: Damien Dejean <dam.dejean@gmail.com>, andrew@lunn.ch, krzk+dt@kernel.org,
 robh@kernel.org, kuba@kernel.org
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com, hkallweit1@gmail.com
References: <20260202200411.373161-1-dam.dejean@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260202200411.373161-1-dam.dejean@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256210-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6793D6A9B
X-Rspamd-Action: no action

Hi,

On 02/02/2026 21:04, Damien Dejean wrote:
> Add property enet-phy-lane-order to the device tree bindings to define
> the lane order of the PHY. To simplify PCB design some manufacturers
> allow to wire the pairs in a reverse order, and change the order in
> software.
> 
> The property can be set to 0 to force the normal lane order (ABCD), or 1
> to force the reverse lane order (DCBA).
> 
> Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 58634fee9fc4..8347d4e134d2 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -126,6 +126,12 @@ properties:
>        e.g. wrong bootstrap configuration caused by issues in PCB
>        layout design.
>  
> +  enet-phy-lane-order:

As this is specific to BaseT, maybe rename that "enet-phy-pair-order" ?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description:
> +      For normal (0) or reverse (1) order of the pairs (ABCD -> DCBA).

We now have a binding in DT for ethernet-connectors, and I'd says this
is typically the kind of info I'd put in there :

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/Documentation/devicetree/bindings/net/ethernet-connector.yaml

The way you'd use that is by adding a ".attach_mdi_port()" callback in your
phy driver, and in there you'd parse these properties and do the proper settings.

We're missing a few things, such as storing a ref to the of_node corresponding
to the connector into phy_port.

This is brand new though, maybe Maintainers would like for phy_port to stabilize
before building more on top of it ?

Maxime


