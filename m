Return-Path: <netdev+bounces-256771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL+DN395g2nyngMAu9opvQ
	(envelope-from <netdev+bounces-256771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:53:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A034EA942
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73E74300EC81
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7886433DEE7;
	Wed,  4 Feb 2026 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="khDme/4m"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3B33DECB;
	Wed,  4 Feb 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223995; cv=none; b=hxNOyQuL1TOABbUqaoHxpVMsWk0kCL39BYyD/pSHkbQZCTLCXnJaTkPWKK7pTZ59I4FRUk2Cb8jcUhZBakS3MjCPYsOrNpsW3jvllogz8kDNT6urCG78s8thPEo8nSFVQLj74smYSxhzK/S6KSLHdki+g6KtGWod9aH5IeR86IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223995; c=relaxed/simple;
	bh=CWsZlV5vgEUXwSlVyA8def71CkN4oknRgrw0BEcdEYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryXLxFXLpCSyYvY0Cbdgo5pcFsZEIHDhIA1x2l/524F8VKPfdE5exARhwbKc7uUKBoAlmpZBZgFMH3VzGlxlaatyipTSTgGn4wJC7mNsvJxFZRMPU0aS2jFgvZK5EXqKbHHk0e/TGd8pxe3Y8CH1Tdhp1HFILWr1QcHsYiTVLVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=khDme/4m; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C86B61A0D18;
	Wed,  4 Feb 2026 16:53:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 931A160705;
	Wed,  4 Feb 2026 16:53:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F1D9119A865B;
	Wed,  4 Feb 2026 17:53:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770223991; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QDPf8MZb/op4nLM/mCR37g1vR6uE9/uLKPsuBNKnDP0=;
	b=khDme/4mJgdYnAX+ZFKEMCwtaKPWZZ9s21E3VWwQbOu1UDr4f2ZMmvyXp/fT8XxUG7mE+u
	6jN9IKDiItQQufm1RHQ/VkUdKONZf2xBBgPelqLp9gF13tJNDDTwJuB+l8meXlM7ooYonk
	70CzJV2K+j0hxNnRaHPqexak7XcWylXWJHx2AidRmK+QFTWJ0GpsGgeqOgj9Ie5Ek1hqQI
	9kBE4hrdGbUtC8Gon0Otj141zEsN46arTwY4NQVeBBfWEiMDxL6WF/8aEMVkQ8aQFPiiaH
	4fyBVhQrxHkrtmRDroaLQSx1WreB3teuxWHKB7aawXdqIlAEiA2VBw5e1tpsPw==
Message-ID: <8e355184-1593-4bac-bc57-40258cd56c78@bootlin.com>
Date: Wed, 4 Feb 2026 17:53:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 12/13] netlink: specs: Add ethernet port
 listing with ethtool
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
References: <20260203172839.548524-1-maxime.chevallier@bootlin.com>
 <20260203172839.548524-13-maxime.chevallier@bootlin.com>
 <20260204081413.7bab62ab@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260204081413.7bab62ab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256771-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A034EA942
X-Rspamd-Action: no action

Hi Jakub

On 04/02/2026 17:14, Jakub Kicinski wrote:
> On Tue,  3 Feb 2026 18:28:36 +0100 Maxime Chevallier wrote:
>> +Request contents:
>> +
>> +====================================  ======  =================================
>> +  ``ETHTOOL_A_PORT_HEADER``             nested  request header
>> +  ``ETHTOOL_A_PORT_ID``                 u32     port id
>> +  ====================================  ======  ===============================
> 
> No idea what happened but suddenly last doc build run started noticing
> that this table is malformed. Even tho the patches have been present in
> previous builds already and there was no error. Very odd. But the table
> does look wonky..
> 
> Documentation/networking/ethtool-netlink.rst:2538: ERROR: Malformed table.
> Bottom/header table border does not match top border.
> 
> ====================================  ======  =================================
>   ``ETHTOOL_A_PORT_HEADER``             nested  request header
>   ``ETHTOOL_A_PORT_ID``                 u32     port id
>   ====================================  ======  ===============================

Yeah I noticed too late... Simon made the same comment on V3, but his
review and my V4 crossed and the issue is still there, as are a few
other ones like the smatch problem :(

I'll slow down my horses a bit :)

Thanks,

Maxime

