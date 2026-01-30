Return-Path: <netdev+bounces-255058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOnrKzJqfGn+MQIAu9opvQ
	(envelope-from <netdev+bounces-255058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:22:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB5EB8494
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 810B23015D2E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89104350D53;
	Fri, 30 Jan 2026 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F1+0BKIM"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D03090D5
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769761325; cv=none; b=rkOBjWzgJqMe2mnDMlNxXNCZcdPA4FF58itkWYgVWHN0BjwIoWVQnhiZ+rbn+75/DfA3r9Fag1QlmuV0FGv8zNA3/I28mELFhawbjJAdONe9agaOuzdLvSY5ZN6of5yFzfRa+4rQv5g0J0URyNLiv3UPWIxNkVvK6hNV4dCEtv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769761325; c=relaxed/simple;
	bh=J4DRfww7ucPy2nhQw/aPntBZirkdW0Scw5xAmzu42fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnI772/cCB5nHxvWNhiAkwy4ILhlIeCk2wsY2iEom7dU9yfEh4VnDMi/qnd2+EC1IpPVRN/0VmyR7NlKMZ2QMiekoiQji3oMlecgKkWRPcA9Xmmgqo0boniotLjBkzINld7D7Yc8/cky4ej3dp0zOwBe7mlfxXc8FW4/iLfQZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F1+0BKIM; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 40FC61A2B24;
	Fri, 30 Jan 2026 08:22:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 067056075A;
	Fri, 30 Jan 2026 08:22:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BCA7119A8884;
	Fri, 30 Jan 2026 09:21:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769761319; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=lXxHuYrh03fUzcI/Zkqg/QgX8e+Lo3imXwlEfiMCCoo=;
	b=F1+0BKIMCEEQVxHIfFUbH0XsABCOysbrdjT4ZUVaqej1JgD6sQ6z1a40oqdQmWHE0ECe8E
	XdeRnPa145UOig/TbRUDiHZwIKL6vqWIEtpTwKPl7s7CwBWqTTx9SgQTFtgDzqPASHmVfY
	n5YDH1EuLUcpOKpL++0f+HbGupISfHfTmaVRcMQd7hrT2WoPiqwcJDByYs6KRGxma6Pt4y
	52bPbLnSAgb2+FAbePlILKFEoZ6vC92GWyse4nsTHt0pGfWLaKwUOQBmhaT+NVFQPXXoAi
	/Y8JNuw067UsnT6RQ81apn0vewWZcEwlqC93vqSZJw6RZl4xYubWDQZktgL0DQ==
Message-ID: <598a828a-2c29-49d2-8e33-11c8748e3202@bootlin.com>
Date: Fri, 30 Jan 2026 09:21:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12] net: phy_port: SFP modules
 representation and phy_port listing
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
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260128204526.170927-1-maxime.chevallier@bootlin.com>
 <20260129195955.3bbff4fd@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260129195955.3bbff4fd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255058-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BB5EB8494
X-Rspamd-Action: no action

Hi Jakub,

On 30/01/2026 04:59, Jakub Kicinski wrote:
> On Wed, 28 Jan 2026 21:45:13 +0100 Maxime Chevallier wrote:
>> Here's V2 of the second phy_port series, this time bringing support for
>> more phy_port use especially for SFP, as well as the beggining of a
>> ethnl uAPI. That's a quick repost, but with the build issues and AI
>> review, I think it's worth getting this version out there for review.
>>
>> It builds on the recent addition of phy_port representation to enable
>> listing the front-facing ports of an interface. For now, we don't control
>> these ports, we merely list their presence and their capabilities.
>>
>> As the most common use-case of multi-port interfaces is combo-ports that
>> provide both RJ45 and SFP connectors on a single MAC, there's a lot of
>> SFP stuff in this series.
>>
>> This series is in 2 main parts. The first one aims at representing the
>> SFP cages and modules using phy_port, as combo-ports with RJ45 + SFP are
>> by far the most common cases for multi-connector setups.
>>
>> The second part is the netlink interface to list those ports, now that
>> most use-cases are covered.
> 
> I'll send out the AI code review. The one on patch 9 looks plausible,
> not sure about the rest. LMK if none of them in fact make sense.

Thanks, I'll look carefully into that :)

Maxime

