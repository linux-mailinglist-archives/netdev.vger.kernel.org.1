Return-Path: <netdev+bounces-307695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id httpGBw/V2pIIAEAu9opvQ
	(envelope-from <netdev+bounces-307695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:04:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3975BB52
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:04:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=xVAYKK8C;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307695-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307695-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAEEA30078C4
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D063C5855;
	Wed, 15 Jul 2026 08:01:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888073C585B
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:01:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102466; cv=none; b=mt02Any9/pQYbNvHbRiwzIOAnmX2cyVvdx96MGszi8HSUZuiXp5DPi3KsxD0+HR7X2QYrTNCij0p7xXOyxefVBBaYipKBFTmXvASWxO+6UQGYMg8vQ7KOQwyJnX0hz+CKueAwo7WzFavrH2PuyQMjSDPZ3CS5kKWOBq76Q+5bHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102466; c=relaxed/simple;
	bh=AwRoD730ywa1NVTdKm1hcywFchtrUaeuJBJeCo88Ygo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXbnof/lrLGNjN9AP/Y3LdBmESIHyrn7p/0pI50bVZBRVI7IdWwCYzb3n49gLvsDnbqObMhw5p6f53dU4od2hWoZtynPIPknL/eC0k1bEGcVk0j2T3OpOQkPNfPRTVXhM5nD+ghYnVT5TVTzGQ/7sXg91PnXxnwkkzdD45bl+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xVAYKK8C; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C133F1A0FE7;
	Wed, 15 Jul 2026 08:01:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7ECD96035C;
	Wed, 15 Jul 2026 08:01:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35CF511BD3C2C;
	Wed, 15 Jul 2026 10:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784102456; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=WPah4Lj6C1tr5dlCzUPgneT4QWM6p0ibR836vXxl90g=;
	b=xVAYKK8CeyR8WnVmNmVsobCKwjZaCm735k+3HZvzKGCr/g6FEOrtkTvc3XaOBIy8MLKAAT
	efihiHIu+LIJVOE++E5vC3dlQ/fVfyHZ7zNw6Xz4atIPMu8D3UknyxEPO/nCcmYSp+zr9+
	nRsNTZJ4pYc4L2GA1Pgj1k0ObWwE5OCMZDfPssRbzjvPZg/cm4rl7x3UOC9mRKEjYbS8R9
	yRpzyvJxqm5Mznm05d3iGF7hJLxT9MbCc/3I3vhHMVRFW4MHBfcUPXwPIyYy+fu08eQEA0
	5T0nNMSjVwWAdlTU8+hC7rmcRJcqhBinogaQXIawydWnA/xXuBZbT0d6yVpD0Q==
Message-ID: <619ddc01-5352-452e-a9bf-00790349d08a@bootlin.com>
Date: Wed, 15 Jul 2026 10:00:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: phy: sfp: drop 1000Base-T support for
 FCLF8521P2BTL
To: Michael Walle <mwalle@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260714125008.2466023-1-mwalle@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260714125008.2466023-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307695-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mwalle@kernel.org,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid,coherent.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEE3975BB52



On 7/14/26 14:49, Michael Walle wrote:
> The FCLF8521P2BTL is marketed as a drop in replacement for fiber
> modules using 1000Base-X autoneg towards the host as default. See the
> referenced application note, esp. question #11. Drop the 1000baseT
> capability, so 1000Base-X will eventually be used.
> 
> This is esp. important if the TX_DISABLE pin is not connected on a
> board. Usually, pin is used as a reset line to the PHY on the copper
> SFP. If a bootloader expects the default mode and doesn't do any
> reconfiguration of the SFP module, a link might not be established.
> 
> Link: https://www.coherent.com/resources/application-note/networking/1000base-t-sfp-faq-an-2036.pdf
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> I'm not sure, this is the correct place for the fix, nor if it goes in
> the right direction. There is a comment in
> 
> /*
>  * Clause 22 copper SFP modules normally operate in Cisco SGMII mode with
>  * negotiation enabled, but some may be in 1000base-X - which is for the
>  * PHY driver to determine.
>  */
> 
> I haven't found any traces of that though. So any pointers, what flags
> have to be modified is appreciated (phydev->supported?
> phydev->possible_interfaces?).

Well I've tried in the past to change the resolution of the phy_interface_t
for a module, possible_interfaces won't work as this is populated too late
(at config init time), and we do the SFP interface resolution before that.

What we need is for PHYs to expose the list of interfaces they support at
drive-probe time.

Thing is, Russell has code for that :

http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue

but that code isn't upstream. I've tried to ask multiple times how we should
go forward with that, but with no reply :

https://lore.kernel.org/netdev/20260114225731.811993-3-maxime.chevallier@bootlin.com/

Russell's supported_interfaces approach works, I'm using that for SGMII to 100FX
modules, but the question is "how do we upstream that", especially with Russell
being away at the time :(

Maxime


