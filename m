Return-Path: <netdev+bounces-256417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAQTGuI6gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:13:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9493DD64F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 517F0306CF6C
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC653A4F23;
	Tue,  3 Feb 2026 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c4TzU77g"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059535D603;
	Tue,  3 Feb 2026 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142413; cv=none; b=A4Orxb11s2pJAnH1NMA6B4riFHbVQgYLgQP9vbk1G3yhzwz/+eClgQF2Ft9cujyaobzph4O9DEuPcKYqC7Plldhhvm/HORL/D2p5+5EVo+HAAIzQnNMzg7TK/FH8LkkiDpvPxCG6L9U/yS7i8XAV9kGmDObqV+uTCQl9VaHIfow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142413; c=relaxed/simple;
	bh=u8NylxVF2JlP5nMbnnSG+Oe77PCNA/XQK/X9dE9mpfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6lZNg2MaByCGqixqX7Xj5L5huY+o/IgiuSMHmM6LjL9YnYOhfQOjVT1RH5ff1SiiH3oSVwpfon4x6fxQ1EFWAPYfs2NXWiInTUivQaMA+doWVIr/XJXHcf2xLfwGoXQpMe24qmbdE2m0fCxkTenitiNISHUQVnZYTHBRQbcya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c4TzU77g; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 79AB31A2BC8;
	Tue,  3 Feb 2026 18:13:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F4DE60728;
	Tue,  3 Feb 2026 18:13:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84584119A8888;
	Tue,  3 Feb 2026 19:13:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770142409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Ed3or68aEwgmwcc/zs1hej7Lg065JiO88cddjD7f2II=;
	b=c4TzU77gFBa2+aUPDBspPWDfcQv6HPPTIMJQjlXA06GZ4Pkbt+u2A19AmaNPPh0Yrj1nNd
	rO2u2Vobh0V9IMdWxoOgfxlilJxAr+B8h/ilzq0lvq+qSOWXPS1S0ZKuUfjC7+IdZSJOUS
	fnXFJ+9gfM6GMnXVI+OwgtsW4LkGAb/pWH1Ffdjh/Dn1lmkKrNcthCEDKaETevutxCP/78
	qS+ycGFe9SueHR/UpVsxfyjnEeTC0RHbfVPQFxEO0YTPYDXjNjz2eCcMUr32jIrxzVD0yX
	lO4MIUacxLBN0MVvVyWGArwAx+1Z6cDZDSQwYlXjGonnJE6busQlk7OkJf3ZDw==
Message-ID: <fd033a0e-4154-47e0-a15e-df92dd114f27@bootlin.com>
Date: Tue, 3 Feb 2026 19:13:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v3,01/11] net: phy: phy_port: Correctly recompute the
 port's linkmodes
To: Simon Horman <horms@kernel.org>
Cc: christophe.leroy@csgroup.eu, thomas.petazzoni@bootlin.com,
 andrew@lunn.ch, kuba@kernel.org, mwojtas@chromium.org, kabel@kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 nicveronese@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@google.com, dimitri.fedrau@liebherr.com, herve.codina@bootlin.com,
 o.rempel@pengutronix.de, romain.gantois@bootlin.com, netdev@vger.kernel.org,
 daniel@makrotopia.org, vladimir.oltean@nxp.com, f.fainelli@gmail.com,
 kory.maincent@bootlin.com
References: <20260201151249.642015-2-maxime.chevallier@bootlin.com>
 <20260203175813.2175230-1-horms@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260203175813.2175230-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256417-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[csgroup.eu,bootlin.com,lunn.ch,kernel.org,chromium.org,vger.kernel.org,redhat.com,davemloft.net,gmail.com,armlinux.org.uk,google.com,liebherr.com,pengutronix.de,makrotopia.org,nxp.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,bootlin.com:mid,bootlin.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9493DD64F
X-Rspamd-Action: no action

Hi Simon

On 03/02/2026 18:58, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: phy: phy_port: Correctly recompute the port's linkmodes
> 
> This commit fixes phy_port_update_supported() to properly filter linkmodes
> instead of incorrectly or'ing medium-specific modes to the existing support.
> It moves the medium iteration inside a check for empty port->supported.
> 
> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
> 
>> diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
>> --- a/drivers/net/phy/phy_port.c
>> +++ b/drivers/net/phy/phy_port.c
> 
> [ ... ]
> 
>> @@ -132,6 +126,19 @@ void phy_port_update_supported(struct phy_port *port)
>>  			port->pairs = max_t(int, port->pairs,
>>  					    ethtool_linkmode_n_pairs(mode));
>>
>> +	if (linkmode_empty(port->supported)) {
>> +		for_each_set_bit(i, &port->mediums,
>> +				 __ETHTOOL_LINK_MEDIUM_LAST) {
>> +			__ETHTOOL_DECLARE_LINK_MODE_MASK(med_supported) = {0};
>> +
>> +			phy_caps_medium_get_supported(med_supported, i,
>> +						      port->pairs);
>> +			linkmode_or(supported, supported, med_supported);
>> +		}
>> +
>> +		linkmode_and(port->supported, port->supported, supported);

Yeah :(

>> +	}
> 
> Jakub Kicinski raised a concern in v2 about the AND operation when
> port->supported starts empty. The v3 fix adds the
> 'if (linkmode_empty(port->supported))' check, but then still performs:
> 
>     linkmode_and(port->supported, port->supported, supported);
> 
> inside that block. Since we just confirmed port->supported is empty,
> ANDing it with anything will always produce an empty result.
> 
> Should this be linkmode_copy() or linkmode_or() instead of linkmode_and()
> when port->supported starts empty?
> 
> Reference: https://lore.kernel.org/all/20260130040009.707764-1-kuba@kernel.org/

True, that's already addressed in V4 :)

Maxime

