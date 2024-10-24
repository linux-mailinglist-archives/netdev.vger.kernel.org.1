Return-Path: <netdev+bounces-138696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF629AE908
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C0FB21798
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4901E283E;
	Thu, 24 Oct 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5OcmQmm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D31D9A72
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780706; cv=none; b=HcYIe0lpKhgAXQnGx9pj4B4gGLreWaBWOO09cTRcCxnAGlmHn1edKxqoSPQ1N93vsDzYNWneSetXTXCtmo89xPwRnZkfrNIFElqL5HOyhvqmZQW7gXarP7CVtk6ZIe3aaK8J6r8D5dfjWJBOuQxAcQmAmZb9zGMhPWn6RTjPJAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780706; c=relaxed/simple;
	bh=VGq51NbjtrkGHL0P4GCk0DS1j7YOZJgVLdNTlhfQ8Yc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qKzmPHf1TE4I3WIS7vnU1rBm82Hx+I9lkDn0RYhWZabt6ITMfgnJEJwDFOeFxi65FpRNVeV/ATh+LjRRVXQb7o3aWCAbRvJhaNrGNVJKNIEd9DS7RdoBX2HBlkMrds16I/rd4BEvPdtqEMUXlMQGFOEwX0se72MawdHPErrVF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5OcmQmm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729780703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmRLcEPOgBlNHa74OohKvYIj1c8ltGNbfHoL/vZIev8=;
	b=K5OcmQmmOfGbPUZevS0mQ0L8fm72R+RlZ+G4Rp0ka7IuQ/Oo4CPmfBsI2TKIPx2YJj0/l/
	BbzPENc7lhj8IhPmtVaR6882TZFh8tVxueHxXQq/ItwLGFUnxe0yJREShfBPfAAJxCvvgy
	BxuB0l4IyBauRui59EC8O8c0ZOA+Ma4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-S3mce2GLPCW0Xm7bxf6VAg-1; Thu, 24 Oct 2024 10:38:20 -0400
X-MC-Unique: S3mce2GLPCW0Xm7bxf6VAg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d60f3e458so691814f8f.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 07:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780699; x=1730385499;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmRLcEPOgBlNHa74OohKvYIj1c8ltGNbfHoL/vZIev8=;
        b=P/ynw5crDKyNAFd7DOl0Ke8nPEMB3Qe9Pf853QWmFgnftT+2G4+nFw5htOZqloFvvu
         8CCtlrpZVvpEjzcBGK6I52fvtBNd4rwQCQGSZF9hTGHB7uYQ09mx2ONI7D9BxCtjh/H+
         brxy+l9klOKYQRmf5eZJSRz8eNO6WFO3qKoIRZzd0LmpDnFy5ah+/fyUtl2jso/Bro9o
         LpC7bVnlhoiLDJG930eo1e8uZGKPXwR+kcoRvh/9V9y0E6ZJTQOlUIrq7crlZdwcAae1
         gm7ZMRWFeJP/ij3Z+4E9VLMAzyt/bX7BqPTMg8FTZkYpXxMa8Hoz+nezIToUrW4OpkQh
         54Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVubRzRpapp3b32Wx76187Imca+ShJ+3YnqGvAwbL7YioBGE4mm5RaqO4WXjtbiE0VY7BkyL2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCMZA27Ak1PrxQETOwaFC5qRXfbFzCYSLT6ZZrHpiqJai/G174
	1TkusnKSjYaaVKQKZWvHpS20SbjqeRIpavutrcRUKvFckeSwzwcOx1QY1WuHR1Qo0U5qpCGTpAr
	gas6ljgTKyF2lhAReJDGc2MGZFjDrB6zGtv/lcLt7WYO/4Fio0YPOrw==
X-Received: by 2002:a5d:5051:0:b0:37d:4c40:699 with SMTP id ffacd0b85a97d-37efcee5a1cmr5354881f8f.5.1729780699317;
        Thu, 24 Oct 2024 07:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoGTa2pYNQczqU2Q3MTNZk1MGtsBjDiOP2Dll3M934odinWvR+fupYrebxC7KsJQY62poFBQ==
X-Received: by 2002:a5d:5051:0:b0:37d:4c40:699 with SMTP id ffacd0b85a97d-37efcee5a1cmr5354862f8f.5.1729780698987;
        Thu, 24 Oct 2024 07:38:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a587f4sm11546175f8f.52.2024.10.24.07.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:38:18 -0700 (PDT)
Message-ID: <ecacf1f2-48e0-4132-bbce-1be9fffc2798@redhat.com>
Date: Thu, 24 Oct 2024 16:38:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 1/3] net/udp: Add a new struct for hash2 slot
From: Paolo Abeni <pabeni@redhat.com>
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241018114535.35712-1-lulie@linux.alibaba.com>
 <20241018114535.35712-2-lulie@linux.alibaba.com>
 <0f2b58a6-7454-4579-9d20-be62de62573e@redhat.com>
Content-Language: en-US
In-Reply-To: <0f2b58a6-7454-4579-9d20-be62de62573e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/24/24 16:31, Paolo Abeni wrote:
> On 10/18/24 13:45, Philo Lu wrote:
>> @@ -3438,16 +3436,17 @@ void __init udp_table_init(struct udp_table *table, const char *name)
>>  					      UDP_HTABLE_SIZE_MIN,
>>  					      UDP_HTABLE_SIZE_MAX);
>>  
>> -	table->hash2 = table->hash + (table->mask + 1);
>> +	table->hash2 = (void *)(table->hash + (table->mask + 1));
>>  	for (i = 0; i <= table->mask; i++) {
>>  		INIT_HLIST_HEAD(&table->hash[i].head);
>>  		table->hash[i].count = 0;
>>  		spin_lock_init(&table->hash[i].lock);
>>  	}
>>  	for (i = 0; i <= table->mask; i++) {
>> -		INIT_HLIST_HEAD(&table->hash2[i].head);
>> -		table->hash2[i].count = 0;
>> -		spin_lock_init(&table->hash2[i].lock);
>> +		INIT_HLIST_HEAD(&table->hash2[i].hslot.head);
>> +		table->hash2[i].hslot.count = 0;
>> +		spin_lock_init(&table->hash2[i].hslot.lock);
>> +		table->hash2[i].hash4_cnt = 0;
> 
> Does not build for CONFIG_BASE_SMALL=y kernels. You need to put all the
> hash4_cnt access under compiler guards.

I see now it's fixed in the next patch, but it's not good enough: we
want to preserve bisectability. You should introduce
udp_table_hash4_init() in this patch.

Thanks,

Paolo


