Return-Path: <netdev+bounces-291546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD5sNLY1FWqwTgcAu9opvQ
	(envelope-from <netdev+bounces-291546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:55:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05D45D0FC4
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB8AB3006900
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 05:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B682C3BF69D;
	Tue, 26 May 2026 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Itf7GHzR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0BA30C140
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779774897; cv=none; b=oQmfn7bhX6shofj+s0l/7yY1hsN0yKjGDoeGFd9G0awlods7aCfEEjEjaYvD4I2dBfXwrnCH5wVMS69p/e33oXY0Oqrp3guGvZ66GWmgs7DW/2rfvf01VS0TSuIQgoyiTOet8rTg9HW2S/HXV4mVcWouBaO6sxBUins5RVdeGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779774897; c=relaxed/simple;
	bh=XV8WXEBQ+KA6ck7/dQgBHUtYvxXLzHdoZQRLWtMR3XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/VFP6ykTHsTksCwOpHgckkcn+32kFcJYHk9D06dlkuse+Ghqo7CpZ8V/H3xEUKJIhYq44FWhlSpDPTGDinM7VWV3yfWVoBwi3YXlAUEyldrVYMXYaoD9u+/6cFcfG4bdTQufOYO0wjvBFN6lNFPcqM7CO0epKi1lwQRv7fds90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Itf7GHzR; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0D533C79AB0;
	Tue, 26 May 2026 05:54:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B77FB60732;
	Tue, 26 May 2026 05:54:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47FBA108881DE;
	Tue, 26 May 2026 07:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779774891; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2kREDJHLsmhhE8imBhUGXJe35E0fWxX/crf+AB4czco=;
	b=Itf7GHzRlgpkV6OfXnVvoKneyxplAI2bfh1rj0CJ4uwmDYfLn3CeAEKnHb+56tHDqvgm9m
	Uk2LEsFJZjqpQa9LI8ncCq8p62wB3RDeUO4/XtKJJko8IEblFy48qFG8RKNA6rqQZ7UhE+
	jg04u4qvKnGhD4wSclckAOqqDu/s/erKLqPBMQSZk2MeR7moc0ilcn8rEyeOuz8OtkUQf7
	s1HfWQry1LopOYSpEr0NnlV3NBGcAvlMRE0iPWHhuoYU76c44qEcNJFogeheoTY9mj1toH
	c29MBAlQwgqBSAcvhRLQyh9KAouxRudQ8VK4oJGv6qJo2hIbctLl7kS6hnFUUA==
Message-ID: <e35a197f-dff7-401d-be1a-9efca61af75f@bootlin.com>
Date: Tue, 26 May 2026 07:54:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/10] net: phy: phy_port: Store information
 about a port's upstream
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
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
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>
References: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
 <20260521121040.1199622-7-maxime.chevallier@bootlin.com>
 <20260525132537.7fa42301@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260525132537.7fa42301@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291546-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D05D45D0FC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

On 5/25/26 22:25, Jakub Kicinski wrote:
> On Thu, 21 May 2026 14:10:34 +0200 Maxime Chevallier wrote:
>> --- a/include/linux/phy.h
>> +++ b/include/linux/phy.h
>> @@ -791,6 +791,7 @@ struct phy_device {
>>   	struct sfp_bus *sfp_bus;
>>   	struct phy_port *sfp_cage_port;
>>   	struct phy_port *mod_port;
>> +	struct phy_port *upstream_port;
>>   	struct phylink *phylink;
>>   	struct net_device *attached_dev;
>>   	struct mii_timestamper *mii_ts;
> 
> nit: missing kdoc here

Ah damn, missed that...

> 
> Are all the sashiko reports false positive at this stage?

I'm going through them, it's a mixed bag of correct and incorrect
stuff, I'll reply inline and followup.

Thanks,

Maxime

