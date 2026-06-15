Return-Path: <netdev+bounces-299485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YUjsA78NMGpNMgUAu9opvQ
	(envelope-from <netdev+bounces-299485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:35:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D61A6873AF
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:35:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=TYCQPqE2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299485-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299485-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9272930360B8
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8883F88B8;
	Mon, 15 Jun 2026 14:29:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980536AB7C
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:29:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533760; cv=none; b=q5hM8MVOJImHZVj2Ehk35EP4WZWoP3V7AVCi5pNBT/za+o2JTFNX3g4wHdl7Z/Cv6T1XeXbAolNe9bGdeJoNoe8/vI3naW5R7Xa9xDVTd67WqX7D8r22SSoWJEfrWtFranlQ8mVlS0H3N1wCARpteiOmWCZL10IdFbWwMLjYT4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533760; c=relaxed/simple;
	bh=7cbZh0H/gGZPnJCdul/uOhQlZasghqu8qchZzA/13Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=De/RoePAHQaWO+V7fF+a3JsYnnAfii5+A8ZnIvuZtW9ocWFS1T7AJG3n6HNmQujSv2+3d8KweO1HwKbLJIoZNdwnZOrh5+8G/e3VJil5GrZgZpgUjCfCiDNMEQYPfbuPfySciiGiB1Zb0iWX3Ws4CataK0XuKT1NkEhpVNohIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TYCQPqE2; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4017F4E42EFF;
	Mon, 15 Jun 2026 14:29:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0F2B660015;
	Mon, 15 Jun 2026 14:29:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2F0A106C968A;
	Mon, 15 Jun 2026 16:29:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781533754; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3rMsrZ7GVRodQT0vv+F6bubXVUBI/vtcGoamkCWzv8c=;
	b=TYCQPqE2QSvlgUb/4JT5XIhXAMpBRqUwvWyNEa+AQy1qdwmW6is6Lmk+BBvd8vCY6XZMAR
	pwX8hKmcij0KqlCHhAlICumWm1QN2FZpcQJU6O7XsrMHtUQxNzIyv+BR6zpWNAIlARpmOg
	pxw3LQMtXaYy7Eqkn3zjJv20NkpuRWIUcKUGeogMRyT+s0lLkwQ8735Upe2rAEiENbqn6e
	Se7LvxooQiSsU2E8wgag4N7J85IMrGMXrMPWjlzvZT9VZa/7qXDuaAryDPwaE9RbQeRqpC
	Ytp6PSShO0oL0EttURSQGkMNnMAEp8fQJH/9H4LNFihxMGSQWut+wskXWQ2uOQ==
Message-ID: <7702ac09-75fd-49de-8ad2-fceaa122b627@bootlin.com>
Date: Mon, 15 Jun 2026 16:29:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 05/12] net: phylink: support late PCS provider
 attach
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
 <20260615122950.22281-6-ansuelsmth@gmail.com>
 <867a39de-ccc2-4dcf-be24-ab2542d20ab6@bootlin.com>
 <6a3007ce.73de60af.3a056d.d903@mx.google.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <6a3007ce.73de60af.3a056d.d903@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299485-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D61A6873AF



On 6/15/26 16:10, Christian Marangi wrote:
> On Mon, Jun 15, 2026 at 04:07:03PM +0200, Maxime Chevallier wrote:
>> Hi Christian,
>>
>> On 6/15/26 14:29, Christian Marangi wrote:
>>> Add support for late PCS provider attachment to a phylink instance.
>>> This works by creating a global notifier for the PCS provider and
>>> making each phylink instance that makes use of fwnode subscribe to
>>> this notifier.
>>>
>>> The PCS notifier will emit the event FWNODE_PCS_PROVIDER_ADD every time
>>> a new PCS provider is added.
>>>
>>> phylink will then react to this event and will call the new function
>>> fwnode_phylink_pcs_get_from_fwnode() that will check if the PCS fwnode
>>> provided by the event is present in the pcs-handle property of the
>>> phylink instance.
>>>
>>> If a related PCS is found, then such PCS is added to the phylink
>>> instance PCS list.
>>>
>>> Then we link the PCS to the phylink instance and we refresh the supported
>>> interfaces of the phylink instance.
>>>
>>> Finally we check if we are in a major_config_failed scenario and trigger
>>> an interface reconfiguration in the next phylink resolve.
>>>
>>> In the example scenario where the link was previously torn down due to
>>> removal of PCS, the link will be established again as the PCS came back
>>> and is now available to phylink.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>
>> [...]
>>
>>> @@ -2151,6 +2204,10 @@ void phylink_destroy(struct phylink *pl)
>>>  	if (pl->link_gpio)
>>>  		gpiod_put(pl->link_gpio);
>>>  
>>> +	/* Unregister notifier for late PCS attach */
>>> +	if (pl->fwnode_pcs_nb.notifier_call)
>>> +		unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
>>
>> I wanted to try this out, but I get :
>>
>> drivers/net/phy/phylink.c:2218:17: error: implicit declaration of function ‘unregister_fwnode_pcs_notifier’; did you mean ‘register_fwnode_pcs_notifier’? [-Werror=implicit-function-declaration]
>>  2218 |                 unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
>>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>       |                 register_fwnode_pcs_notifier
>>
>> I guess you either need to stub this, or there's a missing Kconfig
>> dependency somewhere
>>
> 
> Hi yes if you want toi test just enable CONFIG_FWNODE_PCS. I forgot to add
> the static declaration for unregister_fwnode_pcs_notifier. 

I'll give it a go with this yeah, I have a few devices here I'd like to
try this on.

Can you CC me for the next rounds ?

Maxime

> 


