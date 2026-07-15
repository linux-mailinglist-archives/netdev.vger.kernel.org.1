Return-Path: <netdev+bounces-307732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZZQTO9ZrV2rbNgEAu9opvQ
	(envelope-from <netdev+bounces-307732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:15:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07F75D760
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:15:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=bzUt7K+j;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307732-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307732-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 979B33012CCA
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62F44682E;
	Wed, 15 Jul 2026 11:15:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8254483B2
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 11:15:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114131; cv=none; b=YHzTA01lQL8IMBxhHq4QH6m2f/LH+T5Qmy+KbbKS6L8AwN+ff96zKN9C1SzR1zReZybjTY763+gj/Ct2qZKHcRo7T6L1WdaerzeYQuss4waY59L091CYW6VXA175AwmKBZvg4EdlCZXy5p/AefVazevbOkA3hCdMmGj9nIeIZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114131; c=relaxed/simple;
	bh=4909ZvzqE/qBkcTGctD2aEwJFWkjePdcil0/KSV46/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnDW9o4tek26nPs5PunIOEydcBrMGlRV0yCyyJKBz1WTTQJlIjZzIqJ2aAo9qSsHx8bbMRi1eL/7FfT5k6nMW98w0iGbD5Ono9mHJBWZyNWc0I2+7+jfw9t2YUGqekuQBfRHD21ccK+vGDQCQIMBkvifW13LhHgRcqTV18dnaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bzUt7K+j; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 270ADC2B9CE;
	Wed, 15 Jul 2026 11:15:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 28C9D6035C;
	Wed, 15 Jul 2026 11:15:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 382CA11BD1518;
	Wed, 15 Jul 2026 13:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784114126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4909ZvzqE/qBkcTGctD2aEwJFWkjePdcil0/KSV46/U=;
	b=bzUt7K+jxAzqnf65ic/3Zie1qUXtfMBGduxbcKwUfBdB1KeAAZfgZ/B7xaRDidQOL2PpN4
	yqdRp3nwCPDU1UsC51v/JUPSWtl6syPTBbMZesdWBiW8crQ7Tn5NG2pzEAgQEoa736/qlg
	6pgk8z0Abu7J7saLFLyPNtIvH5eufO7hAgGl9F8cFkTDLW+9DiziKVZovPCqzYVibM9h+9
	uR7FlrzvlVezzkPZ9llu9KcYfSjuv0KpAJ8p23dA4G3z7pw6l++foLmhk6BV3U+eBhLSTk
	UBZAUdFnCQM1bSyWnheRIsBLKNr9VE2INnZ8TJ1TrZkcN2oSRwBPvOL7GziK2A==
Message-ID: <f81a233a-ad96-499f-8a79-c3418dc99ac3@bootlin.com>
Date: Wed, 15 Jul 2026 13:15:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] net: stmmac: move XPCS lifetime management to
 platform drivers
To: Christian Marangi <ansuelsmth@gmail.com>, Coia Prant <coiaprant@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, robh@kernel.org,
 krzk+dt@kernel.org, heiko@sntech.de, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
References: <20260714191341.690906-1-coiaprant@gmail.com>
 <20260714191341.690906-2-coiaprant@gmail.com>
 <dc21b2fc-ae11-4fde-a5b9-09e2c6bee5c9@bootlin.com>
 <CALj3r0gWyfHHp0S4=71M1-TjgHKcgGax4Lr0DzPi37Q69-iCwA@mail.gmail.com>
 <6a574873.3027643f.39eab0.b4c0@mx.google.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <6a574873.3027643f.39eab0.b4c0@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:coiaprant@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C07F75D760

Hi Christian,

> I think the idea of Maxime is to test that series on most Scenario as
> possible to verify for fragility or regression on it.

I've tested your RFC on a few boards that use the .select_pcs() callback,
and didn't find any regressions :)
> (but just for Maxime the feature is getting actively used on OpenWrt by 3
> different SoC and no complain for now)

I have no doubt that the fwnode PCS registration works, however there's no
user of the .fill_available_pcs() path in this series. You may not have access
to HW to test this though, but this is my main concern that we discover issues
when using "internal" PCS with the new API.

I _may_ have time to play around with is on mvpp2, hard to say when though, but
feel free to send another iteration for review :)

Maxime

