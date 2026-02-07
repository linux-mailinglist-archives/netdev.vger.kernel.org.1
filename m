Return-Path: <netdev+bounces-257663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBSeL4KGhmn7OQQAu9opvQ
	(envelope-from <netdev+bounces-257663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:25:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E756310448F
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA2B3029E4B
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 00:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE821E7C34;
	Sat,  7 Feb 2026 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x83.eu header.i=@0x83.eu header.b="M6I1luwg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IYD5cV0n"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9A1E5B9A;
	Sat,  7 Feb 2026 00:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770423935; cv=none; b=V08B5gKpK1qq8gaD8yoTRPzLR8htHn2wvNZTZw3mgcbmgd/v118T9QYoEU58yHYEYjDRrq4flLXteLuVv+6X6Szqq2JjeQ+TP03NsVItDmQIhc9QQ1paTch8rGNLxcXiaVryHX7Xvg63UzRcADnnU7utkNwnggnueLUdZuiAk9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770423935; c=relaxed/simple;
	bh=AiWDVCTnJDnUWM58huh18wrfLZVu2Zj4447x32q79vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1vhJesTokGyG3sZjqVEU6dryNqFXWHLmUgGF+tSUs2cntKM41tfSh2AA55QEW/YA7NuKl5XOfPThyQQUoU7TqQ9hT/WasQyN/RZU/GHDrXMo2rKYkim6j18dw+LgJWt/DQfT96gexuthLto10qhwFs9oC22FwiIHk9t1drRWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=0x83.eu; spf=pass smtp.mailfrom=0x83.eu; dkim=pass (2048-bit key) header.d=0x83.eu header.i=@0x83.eu header.b=M6I1luwg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IYD5cV0n; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=0x83.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x83.eu
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4683914000E6;
	Fri,  6 Feb 2026 19:25:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Feb 2026 19:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0x83.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1770423934;
	 x=1770510334; bh=HSTXJ0rDUjUw84F2DsZ8vRgVVkSmiYZI0wqBQFtYz/s=; b=
	M6I1luwg/ylnN/8YR3klTLTLAOKvGYbCbZLalin22LCU74sTk5RMEaYhiehq16k7
	gPxGWkqeH5ULsUuL4Q3XKaPaCSzJMFMd6klQ7nhbNub8Ayb3l48oxR5ndTB+P/GR
	P9F81bu6RCCokTV8IegVB4J6g+Lpy9pgpb0uVuGmvl8uIcSyOjI9oeyTc3pvZHZ1
	Oe1xP5NppMoJuN0rX0eMNalX9MK08geD8puxkaN6fa+vZGo0FcQ2IZ3H0KhwQOJE
	Xybc//yxswJTO+91tKiIvPYtdBKh91JenXjM3vcr3fETtl1IJHruCPb4z0iD7FeM
	KxFQJ75X+XzOdGMpP8xSkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770423934; x=
	1770510334; bh=HSTXJ0rDUjUw84F2DsZ8vRgVVkSmiYZI0wqBQFtYz/s=; b=I
	YD5cV0n0TynCU6PGHq4+8fqLrzxg1I/iOXmRER71ZzKYkBUcltlresUs7G8yTTLo
	KTNfgcUs6NSDD5aIAXEn2K9RBDhhTHKgfIG9vXGMVq49/yrwMAiWRrD/ssjlNay/
	0x6rTmc3JEW/LRVKdx/PwwUbhh7nh7BOnrZGfyd5ScbFVE6PRxzUNIKjuBtJcMjx
	znKGSXDFLsRaKRaaRZSZAjBT5D7xf+Fctsc3NrqtnfrP7qpbeA4VzUETIa5EdNTC
	oALJujilmGmjmqFcMJIcBFKxthnnU9pabnS0YgRHEHHX11n/5MHCwVwQ4zkeG5cC
	eT1I075tLU4V257AeSzJQ==
X-ME-Sender: <xms:fYaGaRKTj_xBp5uSFZNk7r_NvtnUaWg8snhCTu43LUPBgRuA8TcntQ>
    <xme:fYaGaXMqKQoLZUYBLjCb4q4nzNTUcwhrhwYatdV9VDLQzsYqA46FiQ77uQpG31Eby
    tOj1n2cJXPvtzHwvlTtXprfzODWUksgsBSTwpjkdPlMIZxkYi_T>
X-ME-Received: <xmr:fYaGaZnAiJ_CgeccPNTtZFJPbgvPf-VPrHabsvE8Gw0ojzbXzlRkvn8n4UXlmrbjl4Sv5yrWoNfpq0zQ5Zj93H-K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeliedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpedfnfhukhgr
    shcumfdrfdcuoehkvghrnhgvlhestdigkeefrdgvuheqnecuggftrfgrthhtvghrnhepud
    egvdffgefhvdfhffefvdeileetkeejveevkeeutdekjedvgfefueekhedvudeunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkvghrnhgvlhestdigkeefrdgvuhdpnhgspghrtghpthht
    ohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgvghhrvghsshhiohhnsh
    eslhgvvghmhhhuihhsrdhinhhfohdprhgtphhtthhopehkvghrnhgvlhestdigkeefrdgv
    uhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkrhiikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgv
    ghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnvg
    htuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghl
    rdhthhgrlhhmvghivghrsehhrghlvgdrrght
X-ME-Proxy: <xmx:fYaGaT5yuJMLl3GDk9EHF_0Nm35WQox0j5PBFAQ_IlmWGxqVcWtn8Q>
    <xmx:fYaGaV0W4UQKeqEolI3EdersYSi9uKx9PLyXbHUL_f2kY6sFoCAshQ>
    <xmx:fYaGaWExk0bNXLp47bZGGyHTLadLB0PSBBXohHsbUYbPxsJ1vEp7-w>
    <xmx:fYaGaci6sxZcLv3JlKiKIB7VlPP5xoH_P5MVbdYEl4w7L0FfRCADWw>
    <xmx:foaGaQHOHAgOrA-yL48BV8v5-YvbDGxhZVv57KhOr1KjiQOuGMFztgqk>
Feedback-ID: i83f146eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 19:25:31 -0500 (EST)
Message-ID: <d73ccfcf-507c-4c22-beeb-efc24f671626@0x83.eu>
Date: Sat, 7 Feb 2026 01:25:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] NFC broken on Thinkpad T14 Gen since 9c328f5
To: Thorsten Leemhuis <regressions@leemhuis.info>, "Lukas K."
 <kernel@0x83.eu>, linux-kernel@vger.kernel.org, krzk@kernel.org
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
 Michael Thalmeier <michael.thalmeier@hale.at>
References: <11b7567e-b9a4-4546-9b1c-bb9820bead0c@0x83.eu>
 <b82d8cc1-2124-417d-95f8-5fed429e2d0e@leemhuis.info>
Content-Language: en-GB
From: "Lukas K." <kernel@0x83.eu>
In-Reply-To: <b82d8cc1-2124-417d-95f8-5fed429e2d0e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0x83.eu,none];
	R_DKIM_ALLOW(-0.20)[0x83.eu:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257663-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[0x83.eu:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@0x83.eu,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E756310448F
X-Rspamd-Action: no action

On 06.02.26 17:24, Thorsten Leemhuis wrote:
> On 2/6/26 16:15, Lukas K. wrote:
>>
>> from 6.17.2 to 6.17.3, the integrated NFC reader (driver: nxp-nci_i2c)
>> in the Thinkpad T14 Gen 4 (AMD) stopped detecting tags. This can be
>> tested by running
>>
>> sudo nfctool -1 -p -d nfc0
>>
>> Looking at the commits between 6.17.2 and 6.17.3, 9c328f5 (net: nfc:
>> nci: Add parameter validation for packet data) was the only one related
>> to NFC.
>>
>> To see if that commit indeed was the culprit, I reverted it on 6.18.7
>> and nfctool is detecting tags again.
>>
>> Since the offending commit merely adds some bounds checks, the root
>> cause may very well be in another driver in the NFC stack.
> 
> Thx for the report. Seems Michael (now CCed) also ran into problems and
> tried to fix them, but looks like that effort stalled; but might be good
> to know if this fixes your problem, too:
> 
> https://lore.kernel.org/all/20260112124819.171028-1-michael.thalmeier@hale.at/

Hi Thorsten,

thanks for the pointer. Tried the patch you linked to and it works for me.

Don't know how to reply to the linked mail as I'm new to LKML, but one 
thing caught my eye:

 > static const __u8 *
 > nci_extract_rf_params_nfca_passive_poll(struct nci_dev *ndev,
 >                                        struct 
rf_tech_specific_params_nfca_poll *nfca_poll,
 >-                                       const __u8 *data)
 >+                                       const __u8 *data, size_t data_len)
 > {
 >+       /* Check if we have enough data for sens_res (2 bytes) */
 >+       if (data_len < 2)
 >+               return ERR_PTR(-EINVAL);
 >+
 >        nfca_poll->sens_res = __le16_to_cpu(*((__le16 *)data));
 >        data += 2;
 >+       data_len -= 2;
 >+
 >+       /* Check if we have enough data for nfcid1_len (1 byte) */
 >+       if (data_len < 1)
 >+               return ERR_PTR(-EINVAL);

If data_len underflows at any point it'll wrap to some large value and 
the less than comparisons will yield an incorrect result. Using ssize_t 
should fix that.

Best Regards,

Lukas

