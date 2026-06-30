Return-Path: <netdev+bounces-303004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bQAvK5JsQ2roYAoAu9opvQ
	(envelope-from <netdev+bounces-303004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:13:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D86E1020
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:13:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=ukauNkjo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303004-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303004-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2865C30607F0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB66F3D6CC3;
	Tue, 30 Jun 2026 07:10:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E23D1CCF;
	Tue, 30 Jun 2026 07:10:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803453; cv=none; b=OEww4ttPJZgu54qNjJproBYCxU3QTCa0LBXqDN0ReP7JU4dfqXT/minLehJjr8PK61bItsjZkFss1i1tHws6/V5Ptl63wPrEDdbX7j8tzsboRtedi8NZiQSz+zmq4lZwGVTpUJVZ5ecypbTvgzBh7D0thQPg7BR54VefUmaAfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803453; c=relaxed/simple;
	bh=coe15ogFPnrnNLGsSFkOoXrK9juFWi8tMyZD8xBfr7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xtp5TeBQ0KGL8ip2nbiZ8DZOGPdt9iJozFjEEQtdxip5nP2J2Azj7K4wb1/Uw2TbKj8nE6vS/xQ4IO5qBm7kRQNdUHasomy6KQILaZG+smaFldA/CeBOgQhmqIcxNGFXAS7n6/ZrXGYwdUiEpvka7egn5KHUFjP0Th522TbDpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ukauNkjo; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EFF13C5CD4C;
	Tue, 30 Jun 2026 07:10:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6543F60233;
	Tue, 30 Jun 2026 07:10:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7836106F1C3F;
	Tue, 30 Jun 2026 09:10:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782803447; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2WEvFOUe3RFPl/fYwecdyACzR7RbrE8OMXLcd2G9smQ=;
	b=ukauNkjoFa+Izzi7oPn2g0tA9q7whk8DxJSbSLP4SFqYdfTnlnKGZ1S4XqYxEEwP8ROc9E
	HBc0hiAPp7t+IiAp+olwJx+tnk551HcHvSjWCDN0CAqAC9n0GWw0PdeayEatvn0B87x+i2
	UtCQ70rLf2WOGxPOPxiLprWMeC8InZK5XbLOStrcUyN9FT/CSPIE8djSzaSgoUsGbVtrxe
	ZHuWI77VuVPssz2DRPOR0uitBZkzZoNSB2PL41BJvUg7Ik0Og/41Mijhl8L8HyfqFLpmni
	K2yR3zqh15Dqv+kBkWLY7EwbaAqDcVbg9hQlF4vujxerOUvHat58mr27FL4SvQ==
Message-ID: <0083a957-7afb-489b-b2db-de3acd71b445@bootlin.com>
Date: Tue, 30 Jun 2026 09:10:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/6] dt-bindings: ethernet: eswin: add EIC7700
 eth1 RX clock inversion variant
To: lizhi2@eswincomputing.com, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
 weishangjuan@eswincomputing.com, horms@kernel.org, lee@kernel.org,
 wens@kernel.org
References: <20260630063123.1118-1-lizhi2@eswincomputing.com>
 <20260630063239.1158-1-lizhi2@eswincomputing.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260630063239.1158-1-lizhi2@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303004-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lizhi2@eswincomputing.com,m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:weishangjuan@eswincomputing.com,m:horms@kernel.org,m:lee@kernel.org,m:wens@kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,eswincomputing.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F9D86E1020

Hi,

On 6/30/26 08:32, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> The EIC7700 SoC integrates two GMAC instances. The eth1 MAC exhibits
> different RX clock sampling characteristics due to silicon-inherent
> timing behavior.
> 
> The eth1 MAC has a fixed, non-configurable RX clock-to-data skew at the
> MAC input in the order of 4-5 ns. This cannot be compensated solely by
> the standard MAC internal delay configuration and PHY delay, and RX clock
> inversion is required at 1000Mbps for correct sampling.
> 
> The eth1 TX path also includes a fixed silicon-inherent delay of
> approximately 2 ns. This delay is always present and cannot be disabled.
> It is therefore part of the effective transmit timing observed on the
> wire.
> 
> For the eth1 variant, the valid tx-internal-delay-ps values include
> this fixed delay component. Consequently, the effective range becomes
> 2000-4540 ps (approximately 2000 ps fixed delay plus 0-2540 ps
> programmable delay).
> 
> Introduce a dedicated compatible string
> "eswin,eic7700-qos-eth-clk-inversion" to represent the eth1 variant,
> allowing the driver to apply RX clock inversion only when required by
> hardware variant selection.
> 
> This keeps SoC-level differentiation without exposing silicon-fixed skew
> as configurable device tree parameters.
> 
> To reflect this, model the TX internal delay as a base 0-4540 ps range,
> and constrain valid values per compatible using conditional schema rules.
> 
> Update the binding schema as follows:
> 
>   - Define tx-internal-delay-ps as a base range: 0-4540 ps
>   - Add compatible-specific constraints using if/then rules:
>     * eswin,eic7700-qos-eth:
>         max 2540 ps
>     * eswin,eic7700-qos-eth-clk-inversion:
>         minimum 2000 ps (effective range 2000-4540 ps)
> 
Maybe Andrew can help answering that one, but does it ever make sense to insert
a delay beyond 2540 ps ?

Maxime


