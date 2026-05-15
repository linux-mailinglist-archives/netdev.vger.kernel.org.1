Return-Path: <netdev+bounces-288206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOTEC1zKBmrynwIAu9opvQ
	(envelope-from <netdev+bounces-288206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:25:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A157054A85D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F44D307CC40
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066C53E5A34;
	Fri, 15 May 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bp6a4v2C"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A23E5592
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829771; cv=none; b=IK2uFPue1/YFkX06WyeYgl8A5t2p3R3A0acnJer9gfqSr+21gXBoQGYecpUs2/m9iF9m/A/2fNqE5NlcbRbpG1WNw89brXJaZAd8HGpvcvC4/osXd0LqEFAGl6cP/DNqxLFqfqIIniqvEVU9VjduMSmVjt+l2PZ1rbUFv2Jb+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829771; c=relaxed/simple;
	bh=M5vd016TcRdRSUv4seola20l4iNFnPrQGzS8Z2y9bNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dw/jcJ73azoyzAuHet942ZvEGHonosWp/7xh2M1vW8lnmbVMh+qKmkUBdojvhC8Tp6MUVYGLCft8BYDZNK15j7MZvOY2eNp/jJF4eqtArxybY0wyfkduTxFluJQYbb72Yhr073XK2SxawbpXYqhrA8ocAdj6I2UKB1MWiWK/XvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bp6a4v2C; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CADF51A35DE;
	Fri, 15 May 2026 07:22:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8B829606FD;
	Fri, 15 May 2026 07:22:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE0F011AF8528;
	Fri, 15 May 2026 09:22:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778829760; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LiYd4Q77TJoxE4Lg0VNL4iDlwSTHKmAt01MSoUIgW7w=;
	b=Bp6a4v2CJypag5hsee3IozT6CUlV2Ym0MEo+vW6q/ELA/EtUo9tYsIr8BgkdEX2Q1ft0B9
	1VFXHoPADNqqMcmpDVx0400w9cjB73eZBdUOLrxC4o64S6X40RJzkT3aYNdvIYe+63YXuW
	nxEptrspMNCAM1Z4idDoiBaCdk107BiztgStMa4+o8oByxsHGpy776Oyds5fynBqhfFjtO
	kfrdB7TCRgu28vo4L9nvNeZRXpRlnCwD9tWocZId0mfJa1pE4vkh8QBRxo8v4XqRfyHU33
	2Dzah9zmBxROsIVR7psn1a1DiyAAryYvdB5pP6fBsqhuSBwDTEM5PD1vxvxWjg==
Message-ID: <c68f3abd-7a3d-4d37-9589-02433bbd5c5c@bootlin.com>
Date: Fri, 15 May 2026 09:22:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 6/9] net: phy: phy_port: Store information
 about a MII port's vacant state
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
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>
References: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
 <20260513130521.1064094-7-maxime.chevallier@bootlin.com>
 <97cd33a0-ee74-4f64-b11a-bb5b88bce79a@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <97cd33a0-ee74-4f64-b11a-bb5b88bce79a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: A157054A85D
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
	TAGGED_FROM(0.00)[bounces-288206-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

Hi Andrew,

On 5/14/26 15:58, Andrew Lunn wrote:
>> We have information about what MII they can handle, however we don't
>> store anything about whether they are currently connected to an SFP
>> module or not. As phy_port aims at listing the front-facing ports, let's
>> store an "vacant" bit to know whether or not a MII port is currently
>> vacant (i.e. there's no module in the SFP cage), or not (i.e.
>> there's an SFP module).
> 
> vacant == False actually means a bit more than there is a module in
> the cage. It also means that, so far, we have not had any errors
> trying to use the module. If there is an error, we might have a module
> physically in the cage, but vacant == True.

This is a good point. Even with an error, we should have vacant = false.

TBH I'm unsure how to name this, vacant may not be the best word there, 
but I'm struggling to find a better term.

maybe "empty" ?

> We should be careful with the wording, both in the commit message, and
> here:
> 
>> + * @vacant: For MII ports, indicates whether or not the port has a connection to
>> + *	    another device (e.g. for SFP ports, indicates the absence or presence
>> + *	    of an SFP module)
>>    */

I'll reword this along with the netlink doc. Thank you very very much 
for the reviews,

Maxime

> 
>      Andrew


