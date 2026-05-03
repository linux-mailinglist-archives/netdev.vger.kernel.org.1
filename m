Return-Path: <netdev+bounces-283504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZeNPEHCh9mmgXAIAu9opvQ
	(envelope-from <netdev+bounces-283504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 03:14:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CE84B3F8D
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 03:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB2A430048F5
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 01:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10421D3F4;
	Sun,  3 May 2026 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N2JoHuYi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C341BBBE5;
	Sun,  3 May 2026 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770428; cv=none; b=hQnIu7MPVPWV4hRLzuJvIUck9xTxjgrO36s5N/Ls8y8MUm7feQtw8VRjuWUro5CuMtbKq2LxCNCPWbs91nRRi7PIjnem8Zjft8ccsnWMOOcmtQksoTgjrGcRfNLkJysLKxQUFdp3Q3u+BYe7llkPq5/DCgQlWmSlbeyNuxEs6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770428; c=relaxed/simple;
	bh=xHVeCTvro9mydvIDUiH+Ipm5YcNn5dH+Gj8qneqcIhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUwm0ETkUfve5cyV3ABsbA4lH1PjUIqofG+jMlM0lKVuIBhY46hhOR259+/nrQ0JJ5bnWH0uZT4ue97C9S37q6dGb6xXeNG2bQ9sdoOyFpHUJAll+eENbkhDqoQt2JibP34lkW1rleziorehDGce/TPCVnF0vWDSJZ9PS/nlqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N2JoHuYi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iTliig7XY22fu4H32jB0NZpBHHicET4PgwXZUH5txE4=; b=N2JoHuYiOIPFUgca2LUzPPX8pT
	qqh1+MInrcZI0EbTccvR75qQWgPnTk8kfEwc6xO8PVxqeJO9qAwf3FkV9PA53pj3WHYSBUrPKXWhU
	3Uhi1k5uBi/zqgUeMQMajSkAJiGg3bU447q8BzAJsjL36J0mgWNyvhWjeJ3pPZ0HcOA0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJLIO-0014NM-Ld; Sun, 03 May 2026 03:06:56 +0200
Date: Sun, 3 May 2026 03:06:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] dt-bindings: net: Add bindings for the
 ADIN1140
Message-ID: <05ae6249-1f40-4530-b2dc-e52e4f454c0d@lunn.ch>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-5-dd043cdd88f0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503-adin1140-driver-v1-5-dd043cdd88f0@analog.com>
X-Rspamd-Queue-Id: D3CE84B3F8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283504-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[lunn.ch:s=20171124];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.825];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.0:email,lunn.ch:dkim,lunn.ch:mid]

> +  The ADIN1140 (also called AD3306) is a low power single port
> +  10BASE-T1S MAC-PHY. It integrates an Ethernet PHY with a MAC
> +  and all the associated analog circuitry.
> +  The device implements the Open Alliance TC6 10BASE-T1x MAC-PHY

The device _tries_ to implements the Open Alliance TC6 10BASE-T1x MAC-PHY.

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet@0 {
> +            compatible = "adi,adin1140";
> +            reg = <0>;
> +            spi-max-frequency = <23000000>;
> +
> +            interrupt-parent = <&gpio>;
> +            interrupts = <6 IRQ_TYPE_EDGE_FALLING>;

Table 1: OPEN serial 10BASE-T1x Interface Pin Definition

IRQn MAC-PHY Interrupt Request (Active Low)

Or is this something else which the device gets wrong?

	Andrew

