Return-Path: <netdev+bounces-272815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pjzBDps0yGnaiAUAu9opvQ
	(envelope-from <netdev+bounces-272815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:05:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8192C34FE55
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F9CA306707A
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 20:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53FF33CE92;
	Sat, 28 Mar 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="F9Bh3rrs"
X-Original-To: netdev@vger.kernel.org
Received: from srv4.3e8.eu (srv4.3e8.eu [193.25.101.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5233F369;
	Sat, 28 Mar 2026 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.25.101.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728202; cv=none; b=pCjjW8lsZzP4kID0CbzbGfoRXDiWdjV7BvSR+WPuihvQ5cnwzNk/4WRnzljV94J3lqTjwQi3I15+dTxWpOU/RTxDn35464l/qTNjCZfqh8Ybe/u1VJTuZPet2//YeaNrW7BFpYj2ae8cbSMiZ7VUiG1Ave1A6s1p0NwTYd7sUlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728202; c=relaxed/simple;
	bh=LOSMQgslP4TrtJFgfUffaAG45tS6CyTkAR0ssvy7MXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLgk5nmjcXheAsZMD9dheKobfiBVqe+OLo+45HGC/yXToRvilMhx0e5bEvBhdlJhVxdBnCtVPQPJxJdUDttD6uCPiLku8VD9KHjvjVDk67iAAjOrICeW8EwDsztpFPU2cpQiSyRBeRSBHjONKMT5iqEj7/QNOV/pXCHBj9zEn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=F9Bh3rrs; arc=none smtp.client-ip=193.25.101.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Received: from [IPV6:2003:ed:4701:bfa0:9bcb:9dce:e3f7:b116] (p200300ed4701bfa09bcb9dcee3f7b116.dip0.t-ipconnect.de [IPv6:2003:ed:4701:bfa0:9bcb:9dce:e3f7:b116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv4.3e8.eu (Postfix) with ESMTPSA id C7BE0402E1;
	Sat, 28 Mar 2026 21:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1774728156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HxCBC5AKAsQBm+nqKl27GCFO5qEFiMFsQvR5c0kAdZg=;
	b=F9Bh3rrsPgMhlS4re3BifLcycdAC/4aiaTH7rXBm+oz8LZvBbA50szAPPQZSomkXnbeZv1
	Mw3Thl4775pzSZOkDkIsTNpug+9vx5gzlIRBiwShbl6wCJIG26pKjRAAwASqvZkyrHG5fM
	unhUoWEX879fGvYUjH7PPXhKhzjVAojbOv24lBvr+1zlfOCEfWdjaDk6+pqGnOxcHFI8rJ
	MU7KiZK5PFFM3XAUWryI9Pb+Z6oj7auAomAuJpBUpFgoN5wzm4TdqyvRvrgXai+aaUuyUY
	Zh3JrU4X6bCLcumspKgyqNLuJ8OGMpc2qi1gGYt27FAG9AiWAtNQ5gJTTwD7yA==
Message-ID: <58089a15-61e4-4899-b74f-2f5a495a206c@3e8.eu>
Date: Sat, 28 Mar 2026 21:02:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: sfp: add quirk for ZOERAX SFP-2.5G-T
To: Jakub Kicinski <kuba@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260325164034.1542787-1-jan@3e8.eu>
 <20260327205020.1c020731@kernel.org>
Content-Language: en-US
From: Jan Hoffmann <jan@3e8.eu>
Autocrypt: addr=jan@3e8.eu; keydata=
 xsFNBFTH+vEBEADkcsHlJpyRJydfNeBm35/sU5Rm/gzvrwatYF44RSosfzNvZ7Ihb0ouazI5
 3PzOS46yAc8LyujrZnH/06/nWqTLyxxwXoAIeUc87MboDKYQzskP3HAyqF6NgPH+MgUQB/8a
 56ypfOD1f0MSod7kO3sz/y3QdO6kky+JX7Sq3CsfKUg4DrARvpGKrrqHA0xNpsz++9pYUveW
 i7jJlDz917HpcX39GnBQnLByDTML5cfQYiRMjQiPfwWRUUgsnxWDLkfOlWVW+wU9zvEKJGNP
 6VAT38C3WuurCeHbslp26D2J4NBZdmmgMl3fHB2TYbVj/WzrNsci6uAc2CIiA+RSIjAdXhB8
 w8Fp7FRDY/8/yEuirpQsuYs6BWRpiFv2Lqe1Z2aNshux965VBZhkB2UFCkSe5B2aXqZS4r6S
 kdZijN9v8/NII84j3skfYH8du426GrJFW1TV/sS4JsKhbFRnVrGVaSRB8j82XY+7Bq5mhIwX
 qULQKMZV+y6YHKOaKOGJal6Y8rq+vjpf+kMvekb8zlQ2sStnGuXiQGlfSYMVeV12zv6xtX4U
 GTnQn8Nm6ekJm3PFZ8Jdhy37FzcwLKs7GE6jFHrzWyeKa0ATNuFN/wRmxQzVx2CRxujZ83/I
 gtqte3TzJjDOhIJdAzz/qhZZRQ1TJVBc0nyVHmGsckCsw56H4QARAQABzRlKYW4gSG9mZm1h
 bm4gPGphbkAzZTguZXU+wsGOBBMBCAA4FiEEmLuY0iqAFrsdfdQ4eNoW6ZLnw4cFAlvNvmUC
 GwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQeNoW6ZLnw4fFMw/9GhCiWWIw/u+qJ+Z8
 zV32B7C9jwpVcBoxyHMrbDl/KzEUoF3nSm6YNPfkmxgsQ2u0wd50p7nsLoPWwSET1wCE3VKU
 Cux5fXVC4m7y238HdmSNGmeYgKqvCKti1l+pR58HefMnct0DVsPvfsHc+AUtZCc8AqyJN/Jk
 aZiAKW3sKf3t4RoIyUl7aHwj2TBsi1rvB3VwXPbj5ZrD2imZaE3m7mfSj8Z6n/C83K9+vQEf
 zxxSA1SuV2k5PE/sY4hxD0jgkmk/IForze+BjjKOwuClkfgT4HcTvWwnq9R1f09jscR4JJ7r
 OSzixcxOoC1QBrCoEEr3cQK9z9knn5Y6DMmiAABz472joo0QZR2uWAcQXUF2opxdCstwCWYT
 djc88F9XkdsEh1xY3MpfhQLg4RqYju8hXrRyA+KeQObnEzfUTd0Q8wObK44OrzZt7jyjdwyX
 f7FhTJMyhHwDCWZASkAe2o/mJSlZBAUKcLLegL5tMeo2nx93pJcZVhO5cFv3CM1iIOaho374
 GleMUhOy4urTT5gMKBm3G4SZmzfqOBDrr1ps/goSmpVXEn/IbDvCD1OusideZfYmUTjYHPln
 a7GmFF4fdfL62a0yi96+3l4DSsIF6998F5U8zteWwBCtTm4HBsLpRu0DbDP2IUuEmNCyQhnp
 7EbpdxMJeysv+0U5jgTOwU0EVMf68QEQANpRg30TZ5rVNt7dJNiOf57dRUpdluSRROmyFt5S
 fS3IUaH3dpLCYkHqwRQl5BrDxkUrxkbhoK0bftW9uHt3Cn4o199k1WuyHc/GD8Q9EjbfLXIQ
 WgPjZgNcoxKt8PfSscD6Y/YhUYBQBa+8C346ozR1eugXsbw3Nfuzc4ZXseSOMSLSjlPhrYQC
 swmYt5kLjiWfxSBWpw4hm+S2zA77sBAGaf4JXOTgibY8y4JOLvdNwL3GxBdmc/vunyr5FwBz
 8AZD0FEfxRgDinOiLSoTXUOj4kR+FT+98kUJqlUNwvVUq3tpFEXefWPrqcsVEinWoZsm3K31
 2m1jJfeNbjldep72C1iQC1ut365ZNCMZmVctGZ90dFKDs4l+GkaBJ8S+n3TuMH7sRDVwHG8b
 cAm7kR/3YT5cz26vKy5dGMwm8CFvYF/3UU0aQPGrM711ploz4JdhxRvE1RtRUeqnsiXeBtMo
 BSHtCfP2J5+YZSB+wj0OY00RSDhlwHszkmEBqstZiFECYazv+CsgQfbrX7eQqAsqKRtO3EOM
 QKBwTR+yAtNTrFrQmjE5u9QuIqrvbRTnxhZMRyyimpR6jKYlczNAKVN8RFmxBHOrpUf7slk5
 H2GrHFIXygOA7zZtr+2ufY4TVZjnymKbbrC20JBin4/UNSJF0BDGcXKbpil78YlXu/EfABEB
 AAHCwV8EGAECAAkFAlTH+vECGwwACgkQeNoW6ZLnw4fqFxAA0mGTZXLNlsAAma7XAIdkMqDZ
 aAU+N8SHtceQjeIuhdOV34T9AhbiIhDbf/MeVBz1D/skRtnwk5qtQBjDhzVFfxUu9XFeZHKs
 ZFugcWwmzC0kLWG9xnzeWOl5VSq/CW5i4naaWNic5R2suNQiTFF7ZtGxv4i0H/FA1F6conbE
 5Pi2NN2t6cN22uMZm9tAdXW0QmLfoHzrqkmnFCYHlnLwzhMuBnSrErlV6biYyNRki/uGig69
 ixQ9PRJdEpP1NFrTDexQalb5+JDpHCsGt5mzRBnT5WutZ/HBVj5PbzCxNXemtv0OCnN57Hae
 p2EFXZjDLfOUYdJSpnudtSvBtmJgs7TgwmzcGCOZfWqPd0mRFjG101mhHh0g4GhlUBPvDe4k
 +E5YwEYEWQuO5G0tqwTGXU2bD/8NoMsWPGkABltaVeOvzOITuOe3HHZANwbyMCguTALQ29RF
 5ZxUUfXMU9BxSf7dh5YiYqgceD5ey86nIjKTyxWb1wONrLtsirO2aX+Ch24UyAIHO0H6NVlU
 h8gKGU/jv0XySGZQsU/j79NdOR4sr0c9N6PH6TZiByTVuHDa6FBWeSq8JJltDu1V3kIa07X6
 DPttzFhJHSBzcx5TSQTyN6ErfdYFT8mfBuvG5XJjYoR4xpMl0BLTPJSTmHokossdcyiu4ng+
 AqNjQxfojjo=
In-Reply-To: <20260327205020.1c020731@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[3e8.eu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[3e8.eu:s=mail20211217];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272815-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[3e8.eu:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan@3e8.eu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[3e8.eu:dkim,3e8.eu:email,3e8.eu:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8192C34FE55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-28 at 04:50, Jakub Kicinski wrote:
> On Wed, 25 Mar 2026 17:35:58 +0100 Jan Hoffmann wrote:
>> This is a 2.5G copper module which appears to be based on a Motorcomm
>> YT8821 PHY. There doesn't seem to be a usable way to to access the PHY
>> (I2C address 0x56 provides only read-only C22 access, and Rollball is
>> also not working).
>>
>> The module does not report the correct extended compliance code for
>> 2.5GBase-T, and instead claims to support SONET OC-48 and Fibre Channel:
>>
>>    Identifier          : 0x03 (SFP)
>>    Extended identifier : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>>    Connector           : 0x07 (LC)
>>    Transceiver codes   : 0x00 0x01 0x00 0x00 0x40 0x40 0x04 0x00 0x00
>>    Transceiver type    : FC: Multimode, 50um (M5)
>>    Encoding            : 0x05 (SONET Scrambled)
>>    BR Nominal          : 2500MBd
>>
>> Despite this, the kernel still sets 2500Base-X as interface mode based
>> on the (incorrect) nominal signaling rate.
>>
>> However, it is also necessary to disable auto-negotiation for the module
>> to actually work. Thus, create a SFP quirk to do this.
>>
>> Signed-off-by: Jan Hoffmann <jan@3e8.eu>
>> ---
>> Note: I'm not quite sure "sfp_quirk_disable_autoneg" is enough here, or
>> if it would be appropriate to use the full "sfp_quirk_oem_2_5g" quirk
>> due to the not really correct compliance code / nominal signaling rate.
> 
> I'm no SFP expert but just going by the naming I strongly suspect that
> the module is the same hardware as "SFP-2.5G-T" from "FS", so keeping
> quirks consistent makes sense?
Based on commit e27aca3760c0 ("net: sfp: enhance quirk for Fibrestore 
2.5G copper SFP module"), the FS module uses an RTL8221B PHY, so it is 
different hardware. And it also supports the Rollball protocol for PHY 
access, unlike this Zoerax module.

 From the existing quirks, the only valid alternative I see for the 
Zoerax module would be "sfp_quirk_oem_2_5g" (which also sets the 
additional bits for 2500Base-T link mode and explicitly enables 
2500Base-X interface mode). But as that is not strictly necessary for 
making this particular module work, I am unsure if using this quirk 
would be appropriate.

Thanks,
Jan

