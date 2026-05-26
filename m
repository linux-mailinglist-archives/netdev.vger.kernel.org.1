Return-Path: <netdev+bounces-291575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMicHA5TFWqmUQcAu9opvQ
	(envelope-from <netdev+bounces-291575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:00:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA995D22B1
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59948300BC82
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6223CC323;
	Tue, 26 May 2026 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgPyLX33";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VH9/Lbkk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AA93B4EA9
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782223; cv=none; b=UQeQaAFUbv8vytsuj9QOvT+cfA3iRcwjcjuoslR+UyEyDGMK7q7DM9Gh/gBANOwC4hdc7VN173azLG8OdIVJFltQ2JiTivQMymmNYRmw74GoMIpnNnh/TP0GlXrZ+HxRlvIvSVvBHgSXz0PuprleAn2QnfjBQxgrezrzqTouCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782223; c=relaxed/simple;
	bh=/PP9KzfPgPPYnf2CrAWDmtazkrFsrTswwQu774a4yhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBHC+qdQkBIt4NigBUMjGpKNXMOEr+3EM2CB/84Q4zt19wFSx4LFrSnU8yQKK9AgBy1qWKSxxo/2G16p+orxC7bMKHuwqargMmcd+VH/x3BcDpcvu6gw3F7TtCBq+zmkW6Yp9aeoG0u75S4kYDNqvuM5a4Hi9R0fDnvSP5ZcmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IgPyLX33; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VH9/Lbkk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779782220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xY7mocn0KmK7ngWOScBkr1Rtj5DdaTsx0/KZ/kJfr9c=;
	b=IgPyLX33s/b/IOUvARHD0oXqIfJNxDFT/QeiDUJ+pfGayc/0Du3wQKoe9qVOpnz3dfovaZ
	+YbAcM01chNX8nEkQbZ485jRlhPDYlPE0Cd/chW+ygSBfpjC93AVNi8hvFKfcPn6SDBqkr
	R5vPj5qFA/Vd0uIq8VRQrdRCYui0AgQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-xp6n5SIKO-SyKbb_HDE4wQ-1; Tue, 26 May 2026 03:56:58 -0400
X-MC-Unique: xp6n5SIKO-SyKbb_HDE4wQ-1
X-Mimecast-MFC-AGG-ID: xp6n5SIKO-SyKbb_HDE4wQ_1779782217
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so25836555e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779782217; x=1780387017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xY7mocn0KmK7ngWOScBkr1Rtj5DdaTsx0/KZ/kJfr9c=;
        b=VH9/LbkkwS0NbcLcsLN7YRwBlTeWuxFwtIaKrqB79eMwECjIdNus0UxxWUecS2QfrG
         6qsHfHvvlLq8YIaA94GjA0AG7pzaz9VS3RT6D8IuFT7D3XqN2qsSkn7t47HkKeyr8bPr
         LWqkRerrmpTh9Ltbi9L52Dce161lmnz0b///4udVT5xxGlfND8meHV6KeM3jT09feH0q
         mJu+ezHC6w/tPJny48v3Ej7WlrMMTVTOadmQXmBzOcFOzwkxrkbWjFwmiZ9OQNfV9qNs
         Eb2tcTX2jF6vZss7DD412m6GZAm6nJN5eIJKH0m5K5Fpun5S1acDVz6Ujr0XAm735mhA
         swnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779782217; x=1780387017;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY7mocn0KmK7ngWOScBkr1Rtj5DdaTsx0/KZ/kJfr9c=;
        b=U58YxJva90dsfl7/MN6s0F0J/5CcCvBuueyUnUzhA8rr99UpYTP8GryCArp8sC72pX
         2CrNobiAZoaljXuoDKU/Qd2bd7LLg7BOUIv8m8RyX492I2TbfPXLRK3sHfc3YY3ZEjvu
         qYk9gv5qf+s16kJeMcJ1tZdWaPKAX49TrBF09fwugMdI3tpn8Prmhr3qle51KheIHN5o
         XdpRzjvpb3WJkErDlLrjOvV0FFjVdva3TrVEJqay4uM/ff1YvfPrbgSe88u4JTKMrIvb
         4yghOIoAuYogBncPF+jWq8rXRg8lid47MNaestJOxhf9U4ECB6uk/R2T93HBcFool5Bd
         UAJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lH4p7T7TYhFpelfv88VFg3V7tbwltzFSRoXhEP8htb8RO7MDkmGWxVbpYO8qt97Tg2ROVBv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBoO5MAeQa1LDppxh6wMg8yneFduPRNovlSB/R4+KhS8ztVcql
	PobQPGObsxBtNW0hUXome+ACnuX0ZPnWwyGwWj27cP9VyH0nmGmSz5MUo9BFhmflI1GWgJTKslX
	j9bQjqBH1XkiaUVTvglXrkBGN//sYJiq3l7FDDZc8INh7ivwq7b/NTjwNmQ==
X-Gm-Gg: Acq92OHOzi3ty0vXs5YVMXBFBdegDp451FxV0oVBPyKPSa/ZC71581z4wEZLA0AFde8
	p6zixB13gpcmrW7a+9GV+7ekwdo0Mvc6AQl8SK9KLpGOXr51ewFkNtld4nwSEvOVmQoj1NcMbCj
	Bcub9o5nAK+PJ1qDOaR5kvs99kG7yiQ3NOKLqY98ElTHxtSYP9JKNRHuCPIe8tOVAVvBSSdKJ3w
	ahU0IMrET/xoRkdhf3jQ0tVxYnGnZFjjtwXjGEOkxrptTV3hGziNLKcTsQfn0Q7R8hLqNi+uEN9
	zdYkf+u4J1H3cLEsjXvGoRASmMh5G6DptMJV7QdMl0ndClgJ70mv/WkuJdDORYO35/+OV5k27kB
	RoYp+d81532hI3rgmdLslR8Y9iBPZFlGngeOs42w78xGjIr65V7EOhNWhNA==
X-Received: by 2002:a05:600d:8499:20b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-4904248ad4cmr214893725e9.4.1779782217136;
        Tue, 26 May 2026 00:56:57 -0700 (PDT)
X-Received: by 2002:a05:600d:8499:20b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-4904248ad4cmr214893345e9.4.1779782216746;
        Tue, 26 May 2026 00:56:56 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm322436755e9.9.2026.05.26.00.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 00:56:56 -0700 (PDT)
Message-ID: <caa33c6c-2864-47c1-a111-06422d3723c9@redhat.com>
Date: Tue, 26 May 2026 09:56:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx4: avoid GCC 10 __bad_copy_from() false
 positive
To: Tariq Toukan <tariqt@nvidia.com>, Yao Sang <sangyao@kylinos.cn>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260520102130.423044-1-sangyao@kylinos.cn>
 <31260e8f-15c3-4738-b5b6-67b0ea2d3b0e@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <31260e8f-15c3-4738-b5b6-67b0ea2d3b0e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291575-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CAA995D22B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/26 12:47 PM, Tariq Toukan wrote:
> On 20/05/2026 13:21, Yao Sang wrote:
>> mlx4_init_user_cqes() allocates a single PAGE_SIZE buffer and fills it
>> with the CQE initialization pattern. When entries_per_copy >= entries,
>> the function copies array_size(entries, cqe_size) bytes from that buffer
>> to userspace.
>>
>> That copy is actually bounded by PAGE_SIZE in the else branch because
>> entries_per_copy >= entries implies entries * cqe_size <= PAGE_SIZE.
>> However, GCC 10 does not derive that constraint and falsely triggers
>> __bad_copy_from() in mlx4_init_user_cqes().
>>
>> Cap the single copy_to_user() length to PAGE_SIZE to make that bound
>> explicit and avoid the GCC 10 false positive.
>>
>> Fixes: f69bf5dee7ef ("net/mlx4: Use array_size() helper in copy_to_user()")
>> Signed-off-by: Yao Sang <sangyao@kylinos.cn>
>> ---
>>   drivers/net/ethernet/mellanox/mlx4/cq.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
>> index e130e7259275..7b024a5e13c8 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
>> @@ -314,8 +314,11 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>>   			buf += PAGE_SIZE;
>>   		}
>>   	} else {
>> +		size_t copy_bytes = min_t(size_t, array_size(entries, cqe_size),
>> +					 PAGE_SIZE);
>> +
>>   		err = copy_to_user((void __user *)buf, init_ents,
>> -				   array_size(entries, cqe_size)) ?
>> +				   copy_bytes) ?
>>   			-EFAULT : 0;
>>   	}
>>   
> 
> Thanks for your patch.
> 
> This is a compiler issue.
> Did you try fixing it there first?

AFAICS gcc 10 is a supported version, the kernel should build correctly
with it, right?

Also AFAICS this is not fastpath so an additional check should not be
problematic? Perhaps a warn instead would be more palatable?

		if (WARN_ON_ONCE(array_size(entries, cqe_size) > PAGE_SIZE))
			// ...

/P


