Return-Path: <netdev+bounces-287587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM+kDpZ4BGqpKAIAu9opvQ
	(envelope-from <netdev+bounces-287587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:11:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5B533BF5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7334030C60F8
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771AE4963AA;
	Wed, 13 May 2026 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sgVlDKOd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645B48A2DD
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676587; cv=none; b=uI2KLyMAuczJgM0kKeJ50Q6jRiimeycVq55T+o5C5sypScR9a8Nyaabzz95MYa9VGB355JScIkHLpHGxiD+W5bjysa6LhfvrNVBtPNSJ8CNmBeVUKaXwDvS0xlgE8uPmDyjOcb7dAB4S5S5OwxVFmnebA4RWWyMjTXwat39Pkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676587; c=relaxed/simple;
	bh=CfNcVj10qBM9P9PLyzMgngcL8HLdsqCqIUisDHfByCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKcl2Tb4mm2oQJWVHHEKRewqOzXihEopLgnnaq9Rf3JjAjoIZ3FGoiJ2hWYQ3OK9eL6/wx3nrGpKNdFSPBJGNwvBmG3bE2sLXGfK/YSeel8O6GFGFNu9sst8Iuk5F8t44lAiirKGN7Eqwbb9PUMHSyGSNnSQOwSZFhEwr0BdOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sgVlDKOd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 917371A3592;
	Wed, 13 May 2026 12:49:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 636855FE21;
	Wed, 13 May 2026 12:49:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CA8A11AF9021;
	Wed, 13 May 2026 14:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778676581; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=RtgLHFuD2Bclv96Rf+7+3DMG5yroMjMm+9TZ0Z3c6RY=;
	b=sgVlDKOdp65Wsq8xbOV2LpNP1xjlUt1OUDJmNcahu2ETny/h1e9ju9EmoDvkugwEsphpBU
	6jyIPCFFrm/7atPQrUH0ofwNnObeg/WAflYnbtyFCwfVFrGp1MVx86MbxKlfARkO1UyEhs
	IMJzkhzlZ5jSPZ8ESzRZj+nxnAB8q1V3SUq2WxxCDB8UJD3/f6t6OVcuYw9OMng/1fFIvS
	P3aeXpdtyAVzQ9fPOI9D70ZIY/otIeCL0RctoRVUMQZzKcYSFQJVabp9H9JBl23AvFSyy6
	VWUeuX6eEXHBJvMIC0xk3VmgS5B97IkoxDBgWVtWjyMFB2f3qmtUmAopoO2T+A==
Message-ID: <3c8c7d5e-9f21-4a2b-aec3-d79d68559e42@bootlin.com>
Date: Wed, 13 May 2026 14:49:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 03/10] net: phylink: Register a phy_port for
 MAC-driven SFP busses
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
 <20260403123755.175742-4-maxime.chevallier@bootlin.com>
 <7838a71b-ae3a-4681-8516-c450ea8a5321@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <7838a71b-ae3a-4681-8516-c450ea8a5321@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: BDD5B533BF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287587-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Andrew,

On 4/15/26 01:38, Andrew Lunn wrote:
>> This phy_port represents the SFP cage itself, and not the module
> 
>> +static int phylink_create_sfp_port(struct phylink *pl)
> 
> I'm thinking about naming here. If this represent the cage, why not
> call this phylink_create_sfp_cage_port(). I assume as some point there
> is going to be something for the module, and it seem like the naming
> is going to be confusing.
> 
>> +{
>> +	struct phy_port *port;
>> +	int ret = 0;
>> +
>> +	if (!pl->netdev || !pl->sfp_bus)
>> +		return 0;
>> +
>> +	port = phy_port_alloc();
>> +	if (!port)
>> +		return -ENOMEM;
>> +
>> +	port->is_sfp = true;
>> +	port->is_mii = true;
>> +	port->active = true;
> 
> If this is a cage, not a module, does is_sfp = true make sense?
> 
> And what does an active cage mean?

My bad I realised that I forgot to reply to this comment :( So, is_sfp 
is meant for sfp cages, I'll followup with some documentation update.

Active means we want this port to be used. For now, every port we 
represent is active. The next step for that work will implement the 
muxing and port switchover logic, where the active ports will represent 
the ones that actually got the link. For now, we don't have the logic
to expose and use that.

In retrospect, It's something that should've been added in later steps.

Maxime

> 
> 	Andrew


