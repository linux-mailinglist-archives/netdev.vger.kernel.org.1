Return-Path: <netdev+bounces-290080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN24ETM3DmpC8gUAu9opvQ
	(envelope-from <netdev+bounces-290080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:35:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAE459C1E4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD133329BD62
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4562367DF;
	Wed, 20 May 2026 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="T/pqa5Hk"
X-Original-To: netdev@vger.kernel.org
Received: from srv4.3e8.eu (srv4.3e8.eu [193.25.101.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FBA3469F6
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.25.101.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305672; cv=none; b=PVMxfyuIpwTNHfbvr/i5qKganKf4OfMeuBXtWTg376xZpRReIhFtSc3ijeuKxlQvKU++UOAVyLvpKl/jnHWWMRN50Kzv60iEmp5hv6w7GJBXdQ6S8J6YnGywTqJYwYzRAmCr9Cd0FGldxUcJE5pN3z/R4UoQ9NroBDTAlUVQ8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305672; c=relaxed/simple;
	bh=Ps9r1dbo8FjNVIPDw0T+23sQrwR5riwPhWC1nSF4yZM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p5vPx0vYbVHcsyeGbTYsYrRNspn1p7n4RFvCiw39wF26h9wk67mm9J2VwXK45gX5CDLscsUadlqiqNaq3UFy4gBNL7bwrWCCtu2ZWaTUFR4DnJyM9fRPL/9ybWST4x0Vnj02XVQ7+Sr/151sZttCA+V6pA0VWCxUEPPBLI7u9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=T/pqa5Hk; arc=none smtp.client-ip=193.25.101.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Received: from [IPV6:2003:ed:4732:25a0:50c3:56a0:3512:8308] (p200300ed473225a050c356a035128308.dip0.t-ipconnect.de [IPv6:2003:ed:4732:25a0:50c3:56a0:3512:8308])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv4.3e8.eu (Postfix) with ESMTPSA id D5AD2400D1;
	Wed, 20 May 2026 21:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1779305602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oOEzfbBHPC8r9KpG96ViZs/3f+GP1SliqG4aMfSM2bA=;
	b=T/pqa5HkW95z8YcfdexeFz7Go9LlS4ttsSchpEOqx4+ZgCzI3Hz7aKGnwrgm72mw/YNyYq
	H+1BsBn2ZcctWeMlGxWWD/LlTPKAqOAIe+i5O7aKQJcXGG7RRuTawvQFg3TY+Amr1Lo3PB
	Jn3CCXKVrE4GtczNPhwzjG8hIeTE/ouBAEhF59MfpGeXKp1rc3MLWD+Dtp2TEkZ+uvWCW9
	JTBL2+gZSv5sKqgqvZLf8Cq8dmLo1rJuvVaWAs+XgFX05NAtBcS85YT+qiPv8s4Vvlu+5W
	ccfUvXaeMydfUysQIjGfwKKZ9EqhTrLiNaSu0mjb0bLQNnh2WTkz41rIa4MH4A==
Message-ID: <c90c514a-2da4-42a5-b416-506cb2aadf0e@3e8.eu>
Date: Wed, 20 May 2026 21:33:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jan Hoffmann <jan@3e8.eu>
Subject: Re: [PATCH net-next v4] net: phy: sfp: probe for RollBall I2C-to-MDIO
 bridge in mdio-i2c
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Petr Wozniak <petr.wozniak@gmail.com>, netdev@vger.kernel.org
Cc: bjorn@mork.no, andrew@lunn.ch, linux-phy@lists.infradead.org,
 kuba@kernel.org
References: <20260519043249.2868-1-petr.wozniak@gmail.com>
 <e563f0be-8cdc-4451-ac93-af3a35485af9@bootlin.com>
Content-Language: en-US
Autocrypt: addr=jan@3e8.eu; keydata=
 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
 AqNjQxfojjo=
In-Reply-To: <e563f0be-8cdc-4451-ac93-af3a35485af9@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290080-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[3e8.eu:?];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	NEURAL_HAM(-0.00)[-0.994];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[3e8.eu : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan@3e8.eu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[3e8.eu:s=mail20211217];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,3e8.eu:mid]
X-Rspamd-Queue-Id: EAAE459C1E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-29 at 12:13, Maxime Chevallier wrote:
> Hi Petr,
> 
> On 5/19/26 06:32, Petr Wozniak wrote:
>> The "OEM"/"SFP-10G-T" quirk entry in sfp_fixup_rollball_cc()
>> unconditionally forces MDIO_I2C_ROLLBALL for all modules matching that
>> vendor/part-number combination.  This works for modules that genuinely
>> implement a RollBall I2C-to-MDIO bridge, but silently breaks modules
>> that share the same EEPROM strings without having such a bridge.
>>
>> The Realtek RTL8261BE-CG is one such module: a pure copper 10G SFP+
>> media converter with no I2C-to-MDIO bridge.  Its EEPROM reports
>> vendor="OEM", part="SFP-10G-T-I", and -- critically -- Vendor OUI
>> 00:00:00, making OUI-based differentiation impossible.  With
>> MDIO_I2C_ROLLBALL the kernel stalls waiting for a PHY that never
>> appears:
>>
>>    sfp sfp2: probing phy device through the [MDIO_I2C_ROLLBALL] protocol
> 
> Is it really stalling, or are you facing the 25 seconds retry loop for 
> rollball ?

The retry loop unfortunately takes much longer than 25 seconds if the 
controller in the module is not responding to the Rollball protocol:

- The ".read_c45" method of the Rollball implementation returns 0xffff 
on timeout (which happens after 10 tries, sleeping 20 ms for each).

- When all reads return 0xffff, "get_phy_c45_ids" reads 62 registers 
("MDIO_DEVS1" and "MDIO_DEVS2" for MMD devices 0-29, plus "MDIO_STAT2" 
for MMD 30 and 31).

Considering the 25 attempts for probing, this means the actual retry 
loop is at least 5.5 minutes long. In practice it is even worse, as the 
I2C transfers also take some time.

It seems to me like this is the core of the issue here. If the timeout 
was just 25 seconds, it would be a bit annoying, but still usable.

Jan


