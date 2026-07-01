Return-Path: <netdev+bounces-303763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iAqNES5ARWqi9QoAu9opvQ
	(envelope-from <netdev+bounces-303763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:28:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 906236EFCA2
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:28:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=Ega3eiN1;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=z8CEGQ9o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303763-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303763-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3271B30ECE9B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19ED367284;
	Wed,  1 Jul 2026 16:22:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC83624D3;
	Wed,  1 Jul 2026 16:22:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922961; cv=none; b=X1q1qpzNMq5jH827ro3pX7mA6f9hTmwAvtDG2pgp/r8eEXDgjUgBdsZSm7rmIOM8JTN5dRP+0Bor5uRFLZciNVDWEUlqhMXT4GLweG4W/9XrC113q1J5X0w5bS4YqXioJT7kdSXO7Cl9ZT2uQq07gD3y+1sFnRPe0T070DAIoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922961; c=relaxed/simple;
	bh=9r9O2ufCTzriCbWaRkBTRjC9drlHvL+RJ30HB4Dh/ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GIukqFYZR8MDFMUklPKOQs+x4FnA89SMZFvnjafRblukGLUKL2SliFi2H9/HzWjWitf+qVkjaDKNaaz96veA5d1FAghqL8uEAsCEgYCWy+b22XxrcJzDJGTpCJuReSMEmQzdukfc/qAz/vk5d2bFL6Fvdpu2Wfu3ZnytExNamcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Ega3eiN1; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=z8CEGQ9o; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782922958;
	bh=9r9O2ufCTzriCbWaRkBTRjC9drlHvL+RJ30HB4Dh/ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ega3eiN1uWMiYDleZ/nARjeArKecSAsfuxTUjkimscrMYYF/xLjJqZ9RJJdhkjFoJ
	 lhNRdRAQAbmLOGoslFsbbBUhcbCyQX3X7FrfUEI0onATvMV5PamugB+Htyea2RW4U+
	 Q3UxQbeeGB6CMloOhBeHxvAQsov2dRms8zJZdQLavJ03ziSrblOEsvpOJdP+y+7Cqw
	 xBeNH9lK/sHm0EAM9QULcMyuI7rykCBhTldUX4dOTwE6yal9/SQ7ofS0PQKRvTpH6s
	 8MfoKqUa27UHzMHly3X41QvQMr2ix7SOy3SY67sfiTYeoFJfka+CTUAwVAEECwdGFd
	 65KD5Pvld5Ouw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 8A9654935C; Wed,  1 Jul 2026 16:22:38 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782922957;
	bh=9r9O2ufCTzriCbWaRkBTRjC9drlHvL+RJ30HB4Dh/ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=z8CEGQ9ofzAtJkRNvPeQKpvnnP5qrc6g055SqSI9goXjILlnspaW9mGCbDQeCS82H
	 kKHCIGC9swNIHmc9qMneDsxxzHiCdvRn6/qXbgQIP88EIUTZwWeFK66EVP/ouRBiRQ
	 nw/NJnnoTNVvpsvSlfrHwNRjQqGiSU4QvcQM7KsiLyfpEh8s/BRUs4DKJ2RDsXvmGO
	 OCGiiESK5CnkfhoBtivWL6NoEMUPNGwCNRCxbZ9kAGvvWnBPqWWAqGrK9avTQeo+e6
	 yuonPDZBf5vZYTPMydZZDPLBYrB8CgR+zBs8ezj3tLiN159dbZhWwnkkbCgMg75teG
	 RHCAAzlza6OUQ==
Received: from [IPV6:2003:c6:9f1c:3c00::1c8] (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id A833B49349;
	Wed,  1 Jul 2026 16:22:37 +0000 (UTC)
Message-ID: <d2edb164-91c8-40e4-a104-db690609cb57@birger-koblitz.de>
Date: Wed, 1 Jul 2026 18:22:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ax88179_178a: Add support for ethtool pause parameter
 configuration
To: Andrew Lunn <andrew@lunn.ch>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
 <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
 <947860cc-de6e-48b8-804b-e27f27b2f82c@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <947860cc-de6e-48b8-804b-e27f27b2f82c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303763-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,birger-koblitz.de:dkim,birger-koblitz.de:mid,birger-koblitz.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 906236EFCA2

Hi Andrew,

thanks for reviewing this patch-series! I will answer to the other questions later,
so that the answers stay together. But it is probably best if I give this answer
immediately:
On 7/1/26 17:08, Andrew Lunn wrote:
>>> +static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
>>> +	if (!(bmcr & BMCR_ANENABLE)) {
>>> +		pause->autoneg = 0;
>>> +		pause->rx_pause = 0;
>>> +		pause->tx_pause = 0;
>> The best way to have this correct is to use phylink, but for that you'd need to
>> have a proper PHY driver instead of using the mii_ API here.
> 
> I said the some to one of the other patches.
> 
> Do we know what PHYs are being used? Can register 2 and 3 be read to
> get the PHY IDs?
> 
> 	Andrew

I tested
   id1 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_PHYSID1);
   id2 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_PHYSID2);

and got:
Renkforce AX88179A: ID1 7c9f, ID2 7061
Delock AX88279  ID1 03a2, ID2 a411
UGreen AX88772D ID1 e65b, ID2 2c61
TP-Link AX88179A ID1 e65b, ID2 2c61

The UGreen 100MBit PHY has the same ID as the TP-Link 1GBit PHY.
The vendor and device IDs look rather arbitrary, but I checked, they
are consistent between unplugging and pluging back. They are not
known PHY-IDs, not even the vendor makes sense.

My understanding is that this does not look promising. I also have
the problem that I do not have any of the older AX88179 devices, which
all have the same USB vendor and device ID as the AX88179A-based devices,
which is the reason for adding them to this existing driver.

Birger


