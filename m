Return-Path: <netdev+bounces-307594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /QZYMuelVmqc/gAAu9opvQ
	(envelope-from <netdev+bounces-307594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:11:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4869C758E32
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:11:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="k/pS35lF";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307594-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307594-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44B49311867A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D318A93F;
	Tue, 14 Jul 2026 21:10:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434A3EE1E0;
	Tue, 14 Jul 2026 21:10:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063436; cv=none; b=hgk90SSENYYvV/3VsLuSjWJgroWlIE6LvNmh6mJJLtAPFJEBVeJdO2K5nnS3cEaKk9ec0aWCOwxWpoDFdvONzMhOcEHg8WpM24MZ7n+8o8me86RJHIJlo9t7in8bMkg/ZxmNtQHuXfLsSZnitd5dJXmfEM8ZJagWxAOHPfzVyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063436; c=relaxed/simple;
	bh=IcEJmuTPE9jE/amBtGeHjk/t+2TufmGIIh6T68FLO74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs1RMQX4n33Z9jTdoeE7BXl7NiPBz1oyhBpXHwqwzujRglhsd0DEolNwqoV+IsemTTApst5uvsQ9oeuPmz7xXALCUXDSTZZRn6P29ZaaYANBe0+p+GImTqTSpe1OgbJMSEI9tjBQcmD7vC+lv9Eznw6xZqpGGih0+AJdp6kPCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k/pS35lF; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fVzJp1PtFU6eLocHLlsp+LofsYQuwB8oj2Q0MWCAPLQ=; b=k/pS35lFAvrd2vQDOTXvG2tCer
	RI9PzEaTfZew9sV5GhhbZpDKuzQL8ZzCAfslktAidq9QaG83VH76Hrj8o5ZiJ9QuusAdySQdelPg/
	rqSWSvS/4p9XFneLvvzLZDXlEpAo2btDcDvB7sCNiksJL6DnFJqnt7WRYJAAllWno9mA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjkOT-00CFc1-Py; Tue, 14 Jul 2026 23:10:21 +0200
Date: Tue, 14 Jul 2026 23:10:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: add DAPU Telecom
 DAP8211R(I) PHY binding
Message-ID: <a7374c67-5e0c-446d-bd90-92622c31ef0c@lunn.ch>
References: <20260713131223.279555-1-a.shimko.dev@gmail.com>
 <20260713131223.279555-2-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713131223.279555-2-a.shimko.dev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-307594-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:a.shimko.dev@gmail.com,m:netdev@vger.kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:ashimkodev@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4869C758E32

> +  rx-internal-delay-ps:
> +    description:
> +      RGMII RX clock delay in picoseconds. The PHY supports 150 ps steps
> +      from 0 to 2250 ps. If not specified, defaults to 1950 ps. If the
> +      requested value does not exactly match a supported step, the driver
> +      selects the nearest supported value and issues a warning.
> +    enum: [0, 150, 300, 450, 600, 750, 900, 1050, 1200, 1350, 1500,
> +           1650, 1800, 1950, 2100, 2250]
> +    default: 1950

The cover letter says you round to the nearest, but here you list
specific values.

Please remove the rounding and return EINVAL for the value is not one
of the listed values.

   Andrew
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy@1 {
> +            compatible = "ethernet-phy-ieee802.3-c22";
> +            reg = <1>;
> +            rx-internal-delay-ps = <1050>;
> +            tx-internal-delay-ps = <1150>;

Using values which probably don't work is maybe not a good idea. There
are too many DT developers who just cut/paste and don't think.

These are optional, so don't even bother? Or 2100 which probably does
actually work.

      Andrew

