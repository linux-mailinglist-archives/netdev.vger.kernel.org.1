Return-Path: <netdev+bounces-238338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7995CC57692
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B08D4211FA
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6004350280;
	Thu, 13 Nov 2025 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWVlvXxS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERdugJVE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B52F34DCFC
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036596; cv=none; b=H3EYfiJbi6shM+o31lhuNbU0h1maQtHR6QnUrMYVdD5oa/d6QE3FaQWxDCY7+sOZCcfYLYdXydwl8bEI29GKaifEW1IaSuaKPc0R9iI+nbaofUASuyWSUYSh3Jp0BrVVigia9ETFWN8rhGdHB6f+fU0iWkcvjFcz3leTJOx2/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036596; c=relaxed/simple;
	bh=GoW+s+Pl3Uf4fXwjyNNiYy2wtv5Xv1tAhIb1kYgR5PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2F+4ZCX/eETet2R2c8en6DfuxSupvwU4wKas6jlg8b03oogMQDth3oy10iurkDEpI1OPIyjtpagce2N/KTszJXRcGp2vJJnIv4SE8g4uvfs7hVVf15z3yTSEhHzoMQ+QprMUGZXo7uJhXHyalY8ooHxtB6WMm4vaSHIdSF63c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWVlvXxS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERdugJVE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763036594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CtbdsyBlrHgH6JeUid7rRvm+AqBj3Wf4b3xV5uFCJw=;
	b=WWVlvXxSxjVDTXvPbcXME8ccaYFTRrlFTFD7eM6g0Z4fCDBNThb4OAEcGnZdJdkpFoI5Q9
	WH9xdlGsd1QxYxG2sU/G05QG9ZXXEjxot5sH38B4RoLyXqWHuFBpB3OUhlbqVHV2uyGaTV
	r21vIPeTEpxSNu++c/gjJU/ez7HsHkM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-b8_wsueNOaaj_JYNBLMS8A-1; Thu, 13 Nov 2025 07:23:12 -0500
X-MC-Unique: b8_wsueNOaaj_JYNBLMS8A-1
X-Mimecast-MFC-AGG-ID: b8_wsueNOaaj_JYNBLMS8A_1763036592
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b3ed2c3e3so705976f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 04:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763036591; x=1763641391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CtbdsyBlrHgH6JeUid7rRvm+AqBj3Wf4b3xV5uFCJw=;
        b=ERdugJVEC3IIMMz75gxKVLUIg/QK8l4ZkEDJiQQtRVsDYhuZhupI/1FE8gXT0A11w7
         yqqcvFajva7kr/8Dvi7THEevivW2ALkoi8MJuLKi6S0UaGCtgF34VQsQ1F+To/2QmpGR
         +sP3i9HiB+H2f/GOg7w4Utuf71TBc434MVLWLLoF/c66IF2Re9CK8W3I7xrDceyjQHI3
         okW1EWhyxzKON7bQoQEGFTiyUoFKcfNSPBD5mUp9TotV9qfjnVFfzKiGLcgxtnUjJbkE
         Mbn4zS0tN8iPt8cyj75mr2vsjxZroRvUxYxPzgtg11cCHXiXm4VkDirTTVQxUVtxDiPK
         bnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763036591; x=1763641391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CtbdsyBlrHgH6JeUid7rRvm+AqBj3Wf4b3xV5uFCJw=;
        b=uOQ+L0TI2oOFZJwx1gZ/4S6oZqiI6wKsHT+/q4kkzYlkjNJ4upx/b/io4NcRDB5xBE
         dDRNr+57pdOYwCSwgjDTIBjHmT17NnwXP2fYaDH1nYJsHuCcxHPg9BmlgeGGz0he1+AO
         bb7L+r1ZqxCxnu6pfLv/yKm1eQJel53wa+0BCZberJyEwRzqpxHUOWWTTTarzBZMrPrr
         TXNpZAwbemoDMa+koOtIv/P3HbekZa3WjJUDCgDp/4HyWfafdBwt1mskYBAWS3J14EGX
         TCPo+ftDEMeZl3vagJhqkQBCeJAQJBT3VT5JKargYueTQN1DlloeiHbihAU5L34ISCnq
         QYDA==
X-Forwarded-Encrypted: i=1; AJvYcCWhl+Y5KY8WDVPkS7cx4T+DsZi65FmGvHcKXxHmTHr+/PdBIS6ArVxAKAU+wbkGN2YWsiJqGYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaTtoNdLJ74uAeantgKqUfPGe4F8+wT+UYpT+rbEEmEbx4d6Hu
	jnzYQb/i1CfKj57j27PYVyWHQeP28MoXWuhCIrIl5juT5w2iFy5NVJdzrjZBVKlXSBs0sFQediM
	I2+NIPTvsI9fA4sumSno29CQ+RMjStwm0epkvM/ym/s14+iKttznDJ4wNF5EuAmt06A==
X-Gm-Gg: ASbGnctdt7pm5TrIVWoz7zk3rHBm5ECAFtEl6nkXyZtXvN3wETm8VQKJEFxpjuzi8Ow
	M2y4KVu8hn0s6ZvgoPsfdxQAQ5eTPsV9m9ONhqCCMIYZ8FPeUOYaYNnc8GhsFvGg1vCdCe/AZ4L
	Q/zr0+rv2/9RhKQnDOnRe02GjjwPnPknxkrSr6cmqPavVCGDWPwO331VR48NpWRZOsD+SGp54g6
	HoDsovPQANyTxl7Cqj+pahELBulnFiaWFxYAnXhfjh7qANSxTwnaPp8gtDI7JUEo11zzixCcqKa
	So1oKPBivtPOKRIaBJrIhzDmE9htMsLr0XVHd/cTQ5pnLyT7yJ/wxQ+7hbOZAvTN/pez2XGgUqc
	ag5/altzz/wZ8
X-Received: by 2002:a05:6000:4210:b0:42b:3ed2:c079 with SMTP id ffacd0b85a97d-42b4bdb3157mr6115975f8f.48.1763036591383;
        Thu, 13 Nov 2025 04:23:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVq7iANtHyN8nv9Ua59GO7TIiUEHyAgSmHl140R6Seh/Dx6uJ4VCzqGLc6QTeZnQg61eaX4A==
X-Received: by 2002:a05:6000:4210:b0:42b:3ed2:c079 with SMTP id ffacd0b85a97d-42b4bdb3157mr6115959f8f.48.1763036590987;
        Thu, 13 Nov 2025 04:23:10 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f2a7ddsm3789384f8f.47.2025.11.13.04.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 04:23:10 -0800 (PST)
Message-ID: <17d7f19c-5f43-4cb9-a76a-a55dd5966c43@redhat.com>
Date: Thu, 13 Nov 2025 13:23:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: clear RA flags when adding a static route
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, Garri Djavadyan <g.djavadyan@gmail.com>
References: <20251110230436.5625-1-fmancera@suse.de>
 <a4c8e0da-700d-4ebe-b5c9-ffc4b9eebc62@redhat.com>
 <60edfea6-7e33-4e95-a6ec-e768ec6f39fb@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <60edfea6-7e33-4e95-a6ec-e768ec6f39fb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 1:15 PM, Fernando Fernandez Mancera wrote:
> On 11/13/25 1:03 PM, Paolo Abeni wrote:
>> On 11/11/25 12:04 AM, Fernando Fernandez Mancera wrote:
>>> When an IPv6 Router Advertisement (RA) is received for a prefix, the
>>> kernel creates the corresponding on-link route with flags RTF_ADDRCONF
>>> and RTF_PREFIX_RT configured and RTF_EXPIRES if lifetime is set.
>>>
>>> If later a user configures a static IPv6 address on the same prefix the
>>> kernel clears the RTF_EXPIRES flag but it doesn't clear the RTF_ADDRCONF
>>> and RTF_PREFIX_RT. When the next RA for that prefix is received, the
>>> kernel sees the route as RA-learned and wrongly configures back the
>>> lifetime. This is problematic because if the route expires, the static
>>> address won't have the corresponding on-link route.
>>>
>>> This fix clears the RTF_ADDRCONF and RTF_PREFIX_RT flags preventing that
>>> the lifetime is configured when the next RA arrives. If the static
>>> address is deleted, the route becomes RA-learned again.
>>>
>>> Fixes: 14ef37b6d00e ("ipv6: fix route lookup in addrconf_prefix_rcv()")
>>> Reported-by: Garri Djavadyan <g.djavadyan@gmail.com>
>>> Closes: https://lore.kernel.org/netdev/ba807d39aca5b4dcf395cc11dca61a130a52cfd3.camel@gmail.com/
>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>> ---
>>> Note: this has been broken probably since forever but I belive the
>>> commit in the fixes tag was aiming to fix this too. Anyway, any
>>> recommendation for a fixes tag is welcomed.
>>> ---
>>>   net/ipv6/ip6_fib.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
>>> index 02c16909f618..2111af022d94 100644
>>> --- a/net/ipv6/ip6_fib.c
>>> +++ b/net/ipv6/ip6_fib.c
>>> @@ -1138,6 +1138,10 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>>>   					fib6_set_expires(iter, rt->expires);
>>>   					fib6_add_gc_list(iter);
>>>   				}
>>> +				if (!(rt->fib6_flags & (RTF_ADDRCONF | RTF_PREFIX_RT))) {
>>> +					iter->fib6_flags &= ~RTF_ADDRCONF;
>>> +					iter->fib6_flags &= ~RTF_PREFIX_RT;
>>> +				}
>>>   
>>>   				if (rt->fib6_pmtu)
>>>   					fib6_metric_set(iter, RTAX_MTU,
>>
>> The patch makes sense to me, but I don't want to rush it in the net PR
>> I'm going to send soon. Also it would be great to have self-test
>> covering this case, could you have a reasonable shot at it?
>>
> 
> Sure, I am fine with aiming this for net-next instead if you consider it 
> safer.

Yep, net-next would be better, I think.

Thanks,

Paolo


