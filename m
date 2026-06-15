Return-Path: <netdev+bounces-299553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2kefI4Y1MGoKQAUAu9opvQ
	(envelope-from <netdev+bounces-299553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:25:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3234688D55
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:25:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=Tu2Q+9FV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299553-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299553-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9703130CE7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A572641362E;
	Mon, 15 Jun 2026 17:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6C411695
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 17:19:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543958; cv=none; b=dwMSnm8BngKromXkkq3+fnxTo6XRXVI5FHKqmqDanAtlEsfUxd0ZUuOkbM47NrkTekBSZad1TpGqtYwqXOoRDZOV7fNcj+TGYQe0tFH7PWftbRY23M1Dae319gwQQZ10m+XdkRlGXCw7xcdqqSzsjkmYHb4Sg7Fdgt+lHYUPk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543958; c=relaxed/simple;
	bh=wbYoLma2CMZQ7WQBuZbeCdna6PIX7E+9uWxHemNpbUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHukvExR++J6VNFUjoFo7sZ0RpPMTF8nHd9UDIqawgDskmkpa4vMXrmuO7EksL544FrXpX+WxkNEZuVGtqrVSa2ekfYLKSKd/O7bETAsdfKWt5thmm+ahY6h2nUuL3AJz4NAfO6xztmRXRc/kkFfkItoVXfDdbDBCasgWGQvqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tu2Q+9FV; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 97D05C51474;
	Mon, 15 Jun 2026 17:19:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49EC560015;
	Mon, 15 Jun 2026 17:19:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A141A106C96C2;
	Mon, 15 Jun 2026 19:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781543953; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jhNSiRQ30BnlVswWDQJYLs05F5wmSrj7Tp+I0w+TuNA=;
	b=Tu2Q+9FVVa4Xi1RwwsSA+66TDJ0gtHs8y42c8kZOtKTU300RfeKdU1swZ3M8Zb1CU7WDRs
	AbVCkqsPPHv294X1fOjD1sZoqQ6OaXxsdX8Bv1hARygsVbgJG69qj62AXl1Sv3L24LCnYy
	k4uvTLVKnM72jOI3iPVRPfy0da7sRd2RzCD7lMCIB3RBXmvaD35tp9gVV8GO3qw6KMiomX
	w1C2uZtIhRiyucfkkLNRMWf3LPWvPrK2tdIiDiY1GeOZZkKPyXrbkaQdwunRBRfpig5qvr
	CS8LIzL5rKDWzn15aUlwoPOwaJocR2Dcl5ApbxnjCYiFycalfXG5w937xeWZpg==
Message-ID: <df98cce0-e9ff-4680-92a1-9d5a6e18be47@bootlin.com>
Date: Mon, 15 Jun 2026 19:19:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: phy: sfp: detect presence via I2C when
 no MOD_DEF0 GPIO
To: Greg Patrick <gregspatrick@hotmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Manuel Stocker <mensi@mensi.ch>
References: <20260611175341.2223184-1-gregspatrick@hotmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260611175341.2223184-1-gregspatrick@hotmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299553-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.com,armlinux.org.uk,lunn.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregspatrick@hotmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mensi@mensi.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3234688D55

Hi,

On 6/11/26 19:53, Greg Patrick wrote:
> An SFP cage (compatible "sff,sfp") whose MOD_DEF0 signal is not wired to a
> GPIO currently falls back to sff_gpio_get_state(), which unconditionally
> reports the module as present. An empty cage therefore fails its probe and
> is parked in SFP_MOD_ERROR forever; because SFP_F_PRESENT never deasserts
> there is no REMOVE event to recover the state machine, so a module inserted
> after boot is never detected, and empty cages spam -EIO at boot.
> 
> This affects boards that route none of the cage presence signal to a
> software-readable input. On the NicGiga S100-0800S-M (RTL9303, 8x SFP+) the
> cage I2C bus is the switch's SMBus master; TX_DISABLE is driven via a
> PCA9534 I/O expander, but no MOD_ABS/MOD_DEF0 line reaches a readable GPIO
> (the RTL9303 gpio0 lines read stuck-low, the single PCA9534 is fully
> consumed by TX_DISABLE, and there is no RTL8231). The Horaco ZX-SW82TS-L2P
> (RTL9302D, 2x SFP+) is independently affected in the same way.
> 
> For such an SFP cage, derive presence from a throttled single-byte I2C read
> of the module EEPROM instead: a successful read asserts SFP_F_PRESENT,
> R_PROBE_ABSENT consecutive failures clear it (to ride out a transient error
> on a live module). The existing poll then emits SFP_E_INSERT / SFP_E_REMOVE
> normally, giving working hot-plug and silencing the boot-time -EIO spam on
> empty cages. Presence is re-probed every T_PROBE_PRESENT, so insertion is
> detected within that interval and removal within
> T_PROBE_PRESENT * R_PROBE_ABSENT.
> 
> A soldered-down module (compatible "sff,sff") has no presence signal and is
> genuinely always present, so it continues to use sff_gpio_get_state(); the
> new path is gated on the cage type advertising SFP_F_PRESENT.
> 
> Signed-off-by: Greg Patrick <gregspatrick@hotmail.com>
> Tested-by: Manuel Stocker <mensi@mensi.ch>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

And it doesn't regress any boards I've tested this on (although this was
very quick testing), so

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

I'm wondering if a followup could be to add another loud warning to
dmesg that the HW design is broken, leading to potentially quirky behaviour.

We have lots of those for SFP.

Maxime

