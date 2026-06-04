Return-Path: <netdev+bounces-295246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g3/LBzmCIWq3HgEAu9opvQ
	(envelope-from <netdev+bounces-295246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:48:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F6C64080B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BtVtGLyx;
	dkim=pass header.d=redhat.com header.s=google header.b="qgHP/Cyw";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295246-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295246-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84D063199852
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8399E47DF95;
	Thu,  4 Jun 2026 13:29:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA747AF5D
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 13:29:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579778; cv=none; b=YT6/00zxOEzqK8SU3bMmMrt1iQMss8v5O/X4m9EP+/x4G4MiO9NV0ZMvHuxsULzuEnpsZPfX0DYEDynAwX+yTKlzpOl8P92nWldH/5E2ksqpRjLDBbQD0lzgAFlC018i2J0HhAASalOTgb+rQ4jUJ1ZfFj4ooEUtBc6JlHbbCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579778; c=relaxed/simple;
	bh=SOjkTKU8HjHrQCGf3rqeeZAX5AmJtLyB4AKArzLDWQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZ4s3zN2KsuTPt8AijGWxkYzDZlpVs4pXw+NoJ65SSv2eQ5micyqB5iGKNI0cf/fEOM2rKs1njiKoaFYrT1BN0WdQOnN4MbK4JrItKSnPoSY/cXcTbs8L9q/2dKNaoUnVxh64RkcC4tugf3nUL/R9asOPn/pu6id3A6lu4Xzmp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BtVtGLyx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qgHP/Cyw; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780579776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hh45jgt8XeM3HJf2Mw4e+ZNnmvh+VjroN50R52BgCrA=;
	b=BtVtGLyxZGxuwD+7M3Hu6p6tdauhbnnM7DrdbOtVYizJefdr/5qsZoNAQyrod0Ds7VpWsl
	+Fko0Y7JNblLbKZJqcthBa8KEF82LIo06BxqskL234uBGPFJlfP3bXTSK8P/Mdr58A8yru
	mZWsAFnSaORe8Z1Qs5sxwSm1XBoDTBI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-VYHi-thvPoybyppBv5NA1g-1; Thu, 04 Jun 2026 09:29:30 -0400
X-MC-Unique: VYHi-thvPoybyppBv5NA1g-1
X-Mimecast-MFC-AGG-ID: VYHi-thvPoybyppBv5NA1g_1780579769
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4600c8cb13aso434994f8f.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780579769; x=1781184569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hh45jgt8XeM3HJf2Mw4e+ZNnmvh+VjroN50R52BgCrA=;
        b=qgHP/CywROo1mJ883Xfe0jyNjnrA1C0yxFtamqO6xb9rFnHZZWuEWbfeb0z2MFyg93
         SkE5nAvJVQuNUPIulOE5lPNRcJ+Qls8kTv/SVHowTi/sjPukXiHPrYBYgBsenrxPb0O3
         uY/YPilC2Xl8Boh5vT7QOBNl5tvRLhKGIc7Zy6l/guYPoqDmHLMqarD4v5is+KqvU2lS
         VYVMO/sgDaTNT79o4ymPUavJsnsAh1zX1qdoVDXIlCN/csF6pmq2Ym1DOXAVOGwp8wyN
         W2yIt9Np3SS+zNK7Pes2ozH9Fa4edDGIjzLQPJiu0/DXuODdLuRWyYVtqXxXlBj1n6xK
         z1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579769; x=1781184569;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hh45jgt8XeM3HJf2Mw4e+ZNnmvh+VjroN50R52BgCrA=;
        b=Ua4z6m4lMmpw8wc34Ug2KleJD+eSq2zkI0T0bdzMZjt/dMXtfG6TQMzVMSpCtryofI
         P30GhiBg8jejyJ5znQomBVAkNFSR3QHCsajWHF9S8qF7MLCD9lfiBzKDFQGvmP+4ItNN
         do3nwhnGpXKOqjJlhjjgJNZrExX4pWzW3b+0ISL2zdQ/67UZ2QiLH2Bz2mHCy1PS7Wf6
         uJB/21NWkfVKSlEU6b5VsuZ3p3peAkVRFpu4IqerKiQaij35Z8Wck7urkjtdgwCLbCdc
         7DqqeaZj2U4YPgA4osKzgpwFcZ4p+xroM2TpC6YYEdp72Wu6Tg9ohs1mGJRsUDEBslP+
         7usQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DmlEQMBudsE4aSVlsr/UsWMTSj3NvTRQMg+DT/P+px/pHj55i2MhTyXGneZCOrn3OjiIy7xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4o5K/neoqHHZE/Eb6rcumxQMF+LqQr3EulTIlrZHNfjrvPkbj
	5XjF/PCwFAtgZ5gx2ByJosFhY8Xm7QJ9rJlHk9iHeArVh7y63RpAVT087cI9FbwFjy337IAI0QO
	PO/CphSnYr327zUdwArzArhRjXnSqi84J71/7ONpLXwI5DLOsTyk24OZvPg==
X-Gm-Gg: Acq92OEUGJ6l7tp2jU/exHEAVlo+N0YrCUHIKEgCJqS/7c5ERfi1IHsuyzsRSdhAGbU
	uHM5e5x/X5FvISu0ET9vQyiIzMBrjWCtwdt7gVStpOmqhTIBgaqcEnI+tJjfJHXZYGqBc0Ka5jE
	wFSRfB3dNmzJhIj/JhG4XUQW3s5Ujd3ZzD1zqFSQiUeSSQ04e5Ko9b753v411hht+BwGQIBz8MW
	T21a4JTYAvP/zWdQ/hg6P524tWZPxuJllXLgxYDvpsJko7kwSjxgOkQiUp06geq7CtwH6/j7PX/
	xhNbMmIHJ5OkYmoJC/Ad8thh4PembVlC8/H0acmnf98GIgnQQAOX7HtsiN8IIkOdP8bXLPl7x+U
	7WqkgqfV8YbfwGv82475q39sLk4AFZzChXmR+rrdH9Okfwqbx6PDgoxhv8T+Arv5Ni8I=
X-Received: by 2002:adf:f906:0:b0:44b:5398:4e85 with SMTP id ffacd0b85a97d-46021827554mr9443166f8f.22.1780579769009;
        Thu, 04 Jun 2026 06:29:29 -0700 (PDT)
X-Received: by 2002:adf:f906:0:b0:44b:5398:4e85 with SMTP id ffacd0b85a97d-46021827554mr9443120f8f.22.1780579768538;
        Thu, 04 Jun 2026 06:29:28 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm16969498f8f.13.2026.06.04.06.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 06:29:27 -0700 (PDT)
Message-ID: <10985765-720f-443e-b5e8-01cca10cfa52@redhat.com>
Date: Thu, 4 Jun 2026 15:29:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net/stmmac: Check for STMMAC_DOWN flag in
 all XDP paths
To: Jakub Raczynski <j.raczynski@samsung.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-kernel@vger.kernel.org, k.domagalski@samsung.com,
 k.tegowski@samsung.com, cs0617.lee@samsung.com
References: <20260601163258.554300-1-j.raczynski@samsung.com>
 <CGME20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3@eucas1p2.samsung.com>
 <20260601163258.554300-2-j.raczynski@samsung.com>
 <aiAOthinXOZexBnw@AMDC4622.eu.corp.samsungelectronics.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <aiAOthinXOZexBnw@AMDC4622.eu.corp.samsungelectronics.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-295246-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:j.raczynski@samsung.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-kernel@vger.kernel.org,m:k.domagalski@samsung.com,m:k.tegowski@samsung.com,m:cs0617.lee@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,vger.kernel.org,samsung.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72F6C64080B

On 6/3/26 1:23 PM, Jakub Raczynski wrote:
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index 3591755ea30be..3a66f28425275 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -5267,6 +5267,9 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
>>>  	if (unlikely(!xdpf))
>>>  		return STMMAC_XDP_CONSUMED;
>>>  
>>> +	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
>>> +		return STMMAC_XDP_CONSUMED;
>> Does returning STMMAC_XDP_CONSUMED here cause a memory leak and a double-free
>> in the zero-copy path?
>> Since this check occurs after xdp_convert_buff_to_frame() is called earlier
>> in stmmac_xdp_xmit_back(), the conversion has already transferred ownership. 
>> In zero-copy mode, xdp_convert_buff_to_frame() allocates a new page and frees
>> the original buffer.
>> Returning STMMAC_XDP_CONSUMED at this point leaks the newly allocated page
>> because xdp_return_frame(xdpf) is not called.
>> Furthermore, the caller stmmac_rx_zc() handles STMMAC_XDP_CONSUMED by freeing
>> the buffer again:
>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx_zc() {
>> 	...
>> 	case STMMAC_XDP_CONSUMED:
>> 		xsk_buff_free(buf->xdp);
>> 		fallthrough;
>> 	...
>> }
>> Could this result in a double-free? Would it be safer to check the STMMAC_DOWN
>> flag before the buffer conversion takes place?
> 
> Gonna respond to Sashiko review.
> 
> Funny how in first version of the patch Sashiko wanted XDP_CONSUMED instead
> of error and now it considers it error, but thats beauty of AI. But 1st concern
> was valid.
> 
> As for this, same issue would be when if(unlikely(!xdpf)) triggers,
> or even worse, because it would free page that failed in stmmac_rx_zc().

AFAICS when xdp_convert_buff_to_frame() returns NULL, it did not free
the xdp_buff; there should be ownership nor double free issue there.

> Issue regarding ownership is valid though and this should be fixed -
> it is freed by xdp_convert_buff_to_frame() but is dangling so should either
> specifically free xdpf or xdp_return_frame().
> 
> "Would checking this before buffer conversion take place be safer?"
> Sure, why not, but it will make code bit more ugly.

There is also another suggestion: consolidate the return path with the
existing one for `res == STMMAC_XDP_CONSUMED && zc`.

/P


