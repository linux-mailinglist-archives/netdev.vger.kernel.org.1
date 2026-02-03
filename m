Return-Path: <netdev+bounces-256418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AlXKTs7gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:15:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15118DD68A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB39304C487
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6843A63E9;
	Tue,  3 Feb 2026 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IEiJBWwC"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FAA27A916
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142484; cv=none; b=afbJeMYnUk6zFPubcru51vB6snU8kLKL20SmpdHwoX3ZnQOKqJ+CjK5Q3X0Mx8PTksKcxp8c4vsheiuZ9u3w2OqHvgO8oDGRf6ZwEpTQ6oodQ+v4URzZyF6amh7JXLJBnCRzWwGCp9IvYwKvCot1y+XdK7OImQh2/y2cEO0L9EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142484; c=relaxed/simple;
	bh=beE9oQ8nLlVRe8/YiWUTZyc4GmVn4vV0Pmrv+nxFBG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsTeOVhm1qwEXK9+GdBSsEwgagmqeHTU4HmuAiZ3xxdfDiqVaexOw6LXBhDgZVCMoqT+z0Ui5/fOPGd37M1+EKt6KdeFYVMSJcg+kNS20Zqlac73yZD9l+UTFpy5fkfpFGmiMgvVPo/4E9+mssnKCMXhoY58e1zR60jcPnyIbyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IEiJBWwC; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9CBE5C24387;
	Tue,  3 Feb 2026 18:14:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 553AA60728;
	Tue,  3 Feb 2026 18:14:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F875119A8888;
	Tue,  3 Feb 2026 19:14:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770142479; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=8ltGvsqYxO64uG+3VjjJYH8ZR4dn0u5VjBsKIwyYqOw=;
	b=IEiJBWwCZ8Zs01FujA6ZPFFA/kzE3/GXlF0YwZ0gWner62riylNqgMAPQMtQYfjl8wyxoM
	/Sks8aK/Q/WImLP6N4/lPYD3RKVKYWooECwSHpbByYIXzfZcyUzR1sqHNGV90SRHLzsamu
	1izzhSzTHVpSJGsAswUCsAPjGO6/8zWVW25ZqeLwFPgDOB13WJAaIxo8xr57hxeHSM+PNa
	O9E+GX5UQiRwNF1YCL2cnrSBte10KmDn6WKTnTC58U1sgL2Apr4Jbw9L/8FTV/NtB+gcj8
	4JqNSSalMpu27HEb53Rffn2CVcMJLU3yOfe1LU2sQ5AY1RGSWNswmpxgZ2SBWQ==
Message-ID: <c4fa6923-1a80-4bf4-9dfd-eb5a77cf6532@bootlin.com>
Date: Tue, 3 Feb 2026 19:14:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 10/11] netlink: specs: Add ethernet port
 listing with ethtool
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260201151249.642015-1-maxime.chevallier@bootlin.com>
 <20260201151249.642015-11-maxime.chevallier@bootlin.com>
 <aYI2fZPCehPkke1G@horms.kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aYI2fZPCehPkke1G@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256418-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15118DD68A
X-Rspamd-Action: no action

Hi Simon,

On 03/02/2026 18:55, Simon Horman wrote:
> On Sun, Feb 01, 2026 at 04:12:47PM +0100, Maxime Chevallier wrote:
> 
> ...
> 
>> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
>> index af56c304cef4..3e673755800b 100644
>> --- a/Documentation/networking/ethtool-netlink.rst
>> +++ b/Documentation/networking/ethtool-netlink.rst
>> @@ -2522,6 +2522,40 @@ Within each channel nest, only the metrics supported by the PHY will be present.
>>  See ``struct phy_mse_snapshot`` kernel documentation in
>>  ``include/linux/phy.h``.
>>  
>> +PORT_GET
>> +========
>> +
>> +Retrieve information about the physical connection points of a network device,
>> +referred to as "ports". User needs to specify a PORT_ID for the DO operation,
>> +in which case the DO request returns information about that specific port.
>> +
>> +As there can be more than one port, the DUMP operation can be used to list the
>> +ports present on a given interface, by passing an interface index or name in
>> +the dump request.
>> +
>> +Request contents:
>> +
>> +====================================  ======  =================================
> 
> Hi Maxime,
> 
> make htmldocs complains that "Bottom/header table border does not match top
> border.".

Ah indeed ! I'll address this in V5 then. Thank you for the report !

Maxime


