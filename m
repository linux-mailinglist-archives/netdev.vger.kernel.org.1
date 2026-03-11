Return-Path: <netdev+bounces-266710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAAWGEWfsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:58:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 086C02679FE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D71F3012E6E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754713E1236;
	Wed, 11 Mar 2026 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mJc1Ccki"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9233E34B
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248321; cv=none; b=afyPWqTI8zXylNstglBY6XC67xIPm29DkrPap9lvtleOeN2739D9v2wsIPmEen8dBKOz/0FhBGzRfXtAnMKMVCzVJflGWJpjwOqIIySvvGUXGnCS6MxD7PGI4JYtHqf3Mlv0yOFNzWFCTzg+5Eb7SjMA36dRAbjnCZBMM4D9Q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248321; c=relaxed/simple;
	bh=ljHegwytkaV/FBDgBuS8TCRPpTwkqz4fZOs9t3/8E3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHITR740rTDHvHGTJY+7Fe350vUHRdogqN4+vSfrPSC3UVujogMFZleea47D+FaYHRl7/Q+UM8eOGyI5JG8QYPUB6HeITQkQsGhBOxjZDxvmwp7cg6o0qKMAaP00IFtronjXLWVOXuf4wfWxFEFpcnc9Rz4wwujjyUGKznsUUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mJc1Ccki; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3D4E7C41588;
	Wed, 11 Mar 2026 16:58:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CFAAE60004;
	Wed, 11 Mar 2026 16:58:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FC5A10369C69;
	Wed, 11 Mar 2026 17:58:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773248317; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=G0bVwI05x8FHTW4L9qcttDJh3j7jp3YQEaUFXuqkqSg=;
	b=mJc1CckiNFvfwpkGKRG06Lmv2PeH+QOqXYJ5m73SxPwcLWAn3GzrRAmj2xjBxpXwTc+kHc
	aQhMOjV1FXYV5Q4MQxEenikuiuUzXz7IUWxsSd7GwbJEXLddWE1v3bW/P0Pzy1hl4Ur1YA
	uDISEfPhL1WNczfWaNVzlR/OpxRFmdkk40voGnmkZBgomJW/IOjjc/vv/7syV+G9+Vw+kX
	1kxPBk+1ZhKSXNOu5ZM9uuIP0vuZeNleV8wffPylMKG5eLYsUykR3IqrKxeL30Bi+Gs/EE
	7TK2RACBy2USLYWZZx5fpWo6r6++xwWAFGt7bKoQyJ49XXufVjsfsCItec/EgQ==
Message-ID: <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
Date: Wed, 11 Mar 2026 17:58:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
 Tristram.Ha@microchip.com
References: <20260305095656.vlyaztv6nbdqrmil@skbuf>
 <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
 <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260311135610.oox5ahxcyvxkuegw@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266710-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 086C02679FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/11/26 2:56 PM, Vladimir Oltean wrote:
> On Wed, Mar 11, 2026 at 01:53:38PM +0100, Bastien Curutchet wrote:
>> On 3/11/26 12:53 PM, Vladimir Oltean wrote:
>>> On Wed, Mar 11, 2026 at 11:02:35AM +0100, Bastien Curutchet wrote:
>>>> I, more or less, managed to fit this PTP support in the current framework,
>>>> but the next series I prepared to add periodic output support is full of
>>>> is_ksz8463() branches. So I think that I'll go with what you suggested and
>>>> try to move the KSZ8463 support in the ksz8995.c driver. It will probably be
>>>> cleaner this way.
>>>>
>>>> TBH I'm a bit lost with all these KSZ variants but IIUC KSZ8463 and KSZ8995
>>>> both belong to the 'old generation' of the hardware. Maybe a good split
>>>> would be to have these old switches in the ksz8995.c driver and keep the
>>>> rest under ksz_common infra.
>>>
>>> Wait, to make sure I understand, you said you're going to rebase this
>>> series onto the ksz8995 driver?
>>
>> Well I'll first add basic support for the KSZ8463 in the ksz8995 driver and
>> then add interrupt and PTP support on top of it yes. Did I misunderstand
>> you're suggestion ?
> 
> If we're splitting drivers, I would like to see them grouped by actual similarity,
> so as to not repeat the same mistakes.
> 
> I took a random feature, user port separation, and I'm comparing how Linus
> implemented it in ksz8995:
> https://lore.kernel.org/netdev/20260219-ks8995-fixups-v3-5-a7fc63fe1916@kernel.org/
> vs the register map from KSZ8463:
> https://www.microchip.com/en-us/product/ksz8463#Documentation
> 

I took a look at the register maps from both datasheets. Registers 
aren't always at the same address and some bits differ here and there 
but following areas look very similar:
- global control
- port control
- TOS priority
- MAC address config
- Indirect access
- Data rate limit

> Apart from some funky naming differences (KS8995_REG_PC1 corresponds to
> "PORT 1 CONTROL REGISTER 2"), it should be pretty similar, right? Do you
> see some differences requiring major surgery in ks8995?
> 

The biggest difference I see is the way KSZ8463 accesses the registers 
through SPI. It uses byte enable bits in the command word that don't 
exist on the other switches.

> Apart from the obvious incompleteness, of course. That driver currently
> reports DSA_TAG_PROTO_NONE. It will have to return DSA_TAG_PROTO_KS8995
> for ks8995:
> https://lore.kernel.org/netdev/20260107-ks8995-dsa-tagging-v1-1-1a92832c1540@kernel.org/
> and DSA_TAG_PROTO_KSZ9893 for your KSZ8463. Right?

Yes.

In the end, it feels OK to me to migrate KSZ8463 into ksz8863.c but it's 
hard to know for sure before actually doing it.

