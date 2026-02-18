Return-Path: <netdev+bounces-259251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK/qLdiPlWl7SQIAu9opvQ
	(envelope-from <netdev+bounces-259251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:09:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352BE1551EC
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98FC1305563E
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF50324B0C;
	Wed, 18 Feb 2026 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ta9SdMYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986252F3C26
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409227; cv=none; b=D/nuImVdCTC/SvyZbF+f3d6SR5Cov2BXwHPX9sosez9Q4U/2lpsXTsgTO/hHHvqjeWHSivZ1iCvrxOOou+3V/lyzkRBj1q8SyfGdqcodLbNFvyKgS70TpEptWCFCWLN7qSEwYIzEJyFiBgm2OkHhfCCOjA+nbnSz5Lz+2Du4m+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409227; c=relaxed/simple;
	bh=kkQsig29ZOpvE01BH7Ui2vmMsW1cPD+hnREl1zGGLHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVgIOevtvUhG9h7UYAU/SQMzwSMEkSBZ2IzqAfeS53bzAHmc1K7HN9ExAzw4GnvgYPr3mvhgCD5ec69bAX4w7lcCpHPbw31urustRRxAk+LLCKRzAqfRA89pH+tbDA2bmf7FakrcgIlReD8pRMKYBVENU/WUSbsoS0Q+Aw5xB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ta9SdMYW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-436356740e6so6021429f8f.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 02:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771409224; x=1772014024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrUwHW8A2rsiZ3hynw0qno5PdoBg25MP7dAqXpJTgZA=;
        b=Ta9SdMYWGXPaXzWHzvntu1PNgyd8R3OSFV9cuo8l68+PZ4lJXKZaziVbTICRgoI+Ok
         4JI3XKKatFO3T2gADZ6VZ8623fV+xRUIK4SN/O5A0EKHbFYVcBRXlkhN7YuwfXsRHRai
         TEuqaLLsaoHpt4ZSVJVLaXvC/HNYp+URYAsWQHWtOCunrymEyYxBjwlxiwqgYL3K2fOt
         yj48rBO5NHe1hmeO/pGta2/vVtw4gVWDRW5pRBn4hfiKb6z1EhVvIqh+CKg4p1g54ZW5
         dd3+wBH+RPjqb5v5JHGLmC355rKCTn0oHraEx5UNTlz3LhnPTQ311L23MKbw8jWuyWpW
         gS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771409224; x=1772014024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrUwHW8A2rsiZ3hynw0qno5PdoBg25MP7dAqXpJTgZA=;
        b=JKsPodveKWkeCXF4U1RaEkU32WEdZ+0/up6YalvYdGdeVtKmNJLxJnqTYyG73l6OXJ
         ZpGbS1Gh+iM6+EqSk0Y2gu/LerjqFwo2sbXezmmdPTzKHAGsd1tX1HDu6eWhSotoZ5Xm
         ATdbJGxWLbc0SmN4gF9Yw5sSzSwPljVjs4tcvpoZSsvGqo/0uZiDf3aOblceDX6iLJ8K
         LarCZfr8X5WQ7Qswx4ncBn448zeNb5m5u4rQbT7WjbD68tbhx8yfBA5JSN78ePt6tGWZ
         eL1zjNmwdmfJAJQXmgaZKsARjINDnp112r89C9tjgviA/pVJ7PrH6LcuHgqw33m5MUW6
         XnkQ==
X-Gm-Message-State: AOJu0YyL9RpZjxisA0L+Ht+/5lO9PbVDvAPz4V3cUgOBWR8Ea7pIbnKP
	Sc0Fk1TcbEqcZZdP+CLiojDaJYSKMZuXH4LhFFRs808KynHHAqr9ZwPE5+S4qKsxlOGKhkGU2+U
	0Y4iz
X-Gm-Gg: AZuq6aKNrTc46+yVGpVpVmzxDm4tk4PpKnIlb7p5es4g84L4he7izk0w30OJDOmx6GB
	ZCV4/nr939YYEYi30s2WtnMDbGGjOZlddgd5nJ44cnRBs+TT9uh3jC2Os6AqsIr0wr507pOMJlI
	iOGyJmmNCqk1Qon0ikP9GMNQR4uxBLRr8XvKw6IIs9sGT4aMAoY93fE4KTpOV8BmMCGbcNPqY4U
	sWBwMYsRaSMdGjont0nuRSZKH3o9NEdULk1oFZan9yltAuWIdDpG+5tpDJdDXBy2F/TNt8IC/P/
	YrkXDvztjOg6iYU7m1GaCYBuYJq42Q9v/rNtjMS+pPbC+iBr6lLiQwrgIkAM1mZR9vNLxbytz+p
	Uo8EWI73o/tuS8H/KOepjESKRC9tzirlRakJSGU0pg9/I0GhIHX8H0Im4QYXAKE5WonjGJTWLnu
	Kver+XIf/8un8AOwLHz/p9G/5C7uoWmss9lIBX0MzclyIqRpCRz7h5mw1k/ovdoTwTuSc=
X-Received: by 2002:a05:600c:1c25:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-48379c14606mr207914545e9.32.1771409223736;
        Wed, 18 Feb 2026 02:07:03 -0800 (PST)
Received: from ?IPV6:2001:a61:13d1:a401:31a6:f06b:8297:f001? ([2001:a61:13d1:a401:31a6:f06b:8297:f001])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483983cfb06sm16369275e9.12.2026.02.18.02.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 02:07:03 -0800 (PST)
Message-ID: <9256ed08-d7c9-491a-be37-afb4d245e4c0@suse.com>
Date: Wed, 18 Feb 2026 11:06:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 2/3] net: usb: usbnet: switch to dynamic allocation
 of private data
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hayeswang@realtek.com, bjorn@mork.no,
 o.rempel@pengutronix.de, Oliver Neukum <oneukum@suse.de>
References: <20260210151416.42254-1-oneukum@suse.com>
 <20260210151416.42254-3-oneukum@suse.com>
 <8d1bf5ab-f154-4e64-84a2-929d06fb4e6e@lunn.ch>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <8d1bf5ab-f154-4e64-84a2-929d06fb4e6e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259251-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 352BE1551EC
X-Rspamd-Action: no action

Hi,

thank you for these reviews.

On 17.02.26 19:47, Andrew Lunn wrote:
> On Tue, Feb 10, 2026 at 04:11:13PM +0100, Oliver Neukum wrote:

> 
>> @@ -107,7 +107,7 @@ static void cdc_ncm_get_ethtool_stats(struct net_device *netdev,
>>   				    u64 *data)
>>   {
>>   	struct usbnet *dev = netdev_priv(netdev);
>> -	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
>> +	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
> 
> But it is not clear why changes like this belong on this patch. Can
> they be moved into another patch with a good commit message?

I don't think so. dev->private[0] is an unsigned long
dev->private is unsigned long *

This driver uses the provided scratchpad to store a pointer.
If you want me to leave these lines unchanged I'd need to add
a required_room member of "sizeof(void *)" to the driver_info
of this driver, which really makes no sense.

>>   static void cdc_ncm_free(struct cdc_ncm_ctx *ctx)
>>   {
>> -	if (ctx == NULL)
>> -		return;
>> -
> 
> Maybe a patch of its own?

Roger
  
>>   	if (ctx->tx_rem_skb != NULL) {
>>   		dev_kfree_skb_any(ctx->tx_rem_skb);
>>   		ctx->tx_rem_skb = NULL;
>> @@ -782,12 +779,13 @@ static void cdc_ncm_free(struct cdc_ncm_ctx *ctx)
>>   		ctx->tx_curr_skb = NULL;
>>   	}
>>   
>> -	if (ctx->is_ndp16)
>> +	if (ctx->is_ndp16) {
>>   		kfree(ctx->delayed_ndp16);
>> -	else
>> +		ctx->delayed_ndp16 = NULL;
>> +	} else {
>>   		kfree(ctx->delayed_ndp32);
>> -
>> -	kfree(ctx);
>> +		ctx->delayed_ndp32 = NULL;
>> +	}
> 
> Another patch, with an commit message explaining why this is needed.

This removes a kfree freeing what is now a part of another data structure.

>> -	/* Initialize sierra private data */
>> -	priv = kzalloc(sizeof *priv, GFP_KERNEL);
>> -	if (!priv)
>> -		return -ENOMEM;
> 
> Removing the sierra drivers own memory management should be a separate
> patch.

Roger
  
>> @@ -1511,7 +1511,7 @@ static void smsc75xx_unbind(struct usbnet *dev, struct usb_interface *intf)
>>   		cancel_work_sync(&pdata->set_multicast);
>>   		netif_dbg(dev, ifdown, dev->net, "free pdata\n");
>>   		kfree(pdata);
>> -		memset(dev->private, 0, sizeof(dev->private));
>> +		memset(dev->private, 0, sizeof(struct smsc75xx_priv *));
> 
> These also might need investigating. Why is it necessary to memset
> this memory? Has the life cycle of the memory changed? Can these be
> removed? Again, a separate patch, with a good commit message
> explaining why?

Well, now I need you to kind of make up your mind.
Should I limit this patch to necessary changes or do a big change?

The current code does a memset. I agree that this should be looked at.
But I cannot just leave it. "sizeof(dev->private)" takes the size
of a flexarray.

> I think the general idea is good, it just needs breaking up into
> smaller patches with good commit messages, and you should try to make
> it look more normal, void *, little wrappers, no casts, etc.

I shall try.

	Regards
		Oliver


