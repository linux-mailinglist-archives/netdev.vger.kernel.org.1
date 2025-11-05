Return-Path: <netdev+bounces-235968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFEFC37840
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E2418C824E
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0747B342148;
	Wed,  5 Nov 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aftX8lFz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhU5gOa3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23233FE2B
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371601; cv=none; b=rnMqhMJYrICrBsbD3o96cAvR2scW7dG+0jHNwGIQjVvkALr7JvWVD56Tw6b7Vf1lQfhiQbje9jcMZg2URLm+E/CIPW1G3BaUfaJKJOztvlkpd+c1ksCFPpUOEhGSPeJ2XakW6NaHEd4U3fSOTogo+VLZxCWB1KLw4hEEsmGdkQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371601; c=relaxed/simple;
	bh=+SOyxLJBOfbSw/MqBDPVxoL7LcgQEUyR14RhOCQVl6U=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rVhTdQH6ZtbpJrpdXUErfnL7BuH9KFU93ygb+W2B1RURo0L0ySZ6gR+k7Alb/vqr5IEfS1VbHyxDCOG6hOVEJrV7FsAylc+ucQ/1cRyMUv+6Xxgmxlu/G5LyGQUZSSj5qA7O0Xlm3N/DMZukSYYp0P41Z0n0qNFirdu4bkpnl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aftX8lFz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhU5gOa3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762371599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kizs9xJ2GRG/rLXAdsJnM3tvDx/8JZcjC0BTEZZ5WY=;
	b=aftX8lFz9UJpOrwvJjkImzXtLw0nRbORi73U1W28gadrOmYhjZxCVDWL7/TpmnWVy0I3W/
	1JnyXOrcR6tWtdvfNHqXcV2caDgvofqZPJu2B5iecJZrHY2RhnRFCzUOYZD7hactTz4xvL
	fTEAkfY6qbZVmNlk7W2v77t2gRGgDks=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-AtWsY_UROWqCyhbdHBGIkw-1; Wed, 05 Nov 2025 14:39:57 -0500
X-MC-Unique: AtWsY_UROWqCyhbdHBGIkw-1
X-Mimecast-MFC-AGG-ID: AtWsY_UROWqCyhbdHBGIkw_1762371597
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-892637a3736so48752785a.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 11:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762371597; x=1762976397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7kizs9xJ2GRG/rLXAdsJnM3tvDx/8JZcjC0BTEZZ5WY=;
        b=bhU5gOa352yz6IMZNQMetzfE9fawz8lYejcR/dsPOJRFkYjWHgw9vmAiwAPDrfVHNe
         1SkuKfO9+wuixdu8J62kqL1yuPNN4UxT85BcWZYpR0d5mcq0muQGq7GOs9hlUDoDamn9
         qDc8zCFQs2kW8KY1q+oIEKTtdFq2w/PfUdDP4pQKE2gJTBF9krK+GdbUpi3/mnhS0E9c
         4bG9g8VDvW0JJvR67KQxZ4wEoWwbQfPWMP6aIb76vC2J1+no6tS5u8gwhyanuQ7TQk41
         XtldFp/Mq83IHfqtsAD6FFGYQ6dLzZPs7AdY8DQItDo+idRaRcXQZmkTlx2fJPZR63dO
         eX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371597; x=1762976397;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kizs9xJ2GRG/rLXAdsJnM3tvDx/8JZcjC0BTEZZ5WY=;
        b=MTAnSkzpKxId5Z+2bm1qEjgPEiWCB5LJz4KzhEb+OQ43NckZ1aXDncyWLNikZpx2S+
         JAgzLRVgU9sCFXDjTd1e7RKYridiI/oehEfesLfha0j1Mw4harSTVL2qZZ/+uXPk6Q8h
         K83vJOoZugitU1lZEXi7wynV6TgrOLZoV5d32Nip4g0+TqXLwEfYi+hLPQpund+dIL7I
         ZyBCXm1deeQdkVOtgBj5PcwE3fB3LDGRgXyPE+JNo9x60qbSriVHCrSjoycC/6ly/tC3
         ZrefAXtw7NUpW3zJl3/wVTlNmpdpZi/K+GDIwOYtXs2fpOtExUcCPUq1sTZ8IYmLqfys
         VwbA==
X-Forwarded-Encrypted: i=1; AJvYcCVHVucnsSyrr2gFKOzq2hobwZ5qp5oUuf4H8iuONbJlVQmrWpXtDoBXH0BPlUnI74BomYKyYEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDC3j6MyuJ2/WdMgi038jFqoC4gdwN9MuVjhwZfDNHhWbh4rUA
	Bn5pZ2ueseBdNERdCVttiFiVxqJqWtccBU9dS+QC68BuU5r3Eu4AKlc2ITEFNLzHB26NI7PT5x0
	giHTCbtfb3l68zRJwc5VGp1vF+ux5oWJMAZs7zgdsMv+MG0GULTdo2sHEmA==
X-Gm-Gg: ASbGncssdCUKrR1WYAXKIH6i1ob7a9eqNdQaV4GBOPQKfTaugM8g7bpq1u9/5zzZizA
	HTEq4YCxxy2JNCjZ6oqvNm3k9fythCjL7nQM8qEVvGQ3fKZBKPhMJRH0dOu6xF7yNjpqum4aNOJ
	7Re/sBxOBLkWK7E8uva54BD3nonQfQ0kkl2bc9dP/YaBuQnjnbgQ0kBkxfYZuTl4V00ymjwYWj/
	btAMGbfhQQrOmXnyHQUeROfGuBLerk3fcdyjzbTTFjpUqzVDvG+WVuxSeR5it0Bsn0JqJtxRogF
	hES3PwRs0ovIvLJDUNPqM64czkInr0T/tIXk90OPPeWDJDO5IbEu4yshaMYvpfvvuPDrrDxwtwF
	NWb61ty3SKeR8FVEoGNHjCYSSUMxZZ5gU8wEIMXMjjcTQjQ==
X-Received: by 2002:a05:620a:460f:b0:89f:7109:185f with SMTP id af79cd13be357-8b220af7c8dmr589562185a.31.1762371597244;
        Wed, 05 Nov 2025 11:39:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd9eT2YzuyaD6xKA1zXzyy0WWTMe4/Y4jwbmI24djGe/tYf+EHmXjHRZnQzj3cSXaGnWo3FQ==
X-Received: by 2002:a05:620a:460f:b0:89f:7109:185f with SMTP id af79cd13be357-8b220af7c8dmr589555485a.31.1762371596761;
        Wed, 05 Nov 2025 11:39:56 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355c2797sm30330485a.10.2025.11.05.11.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:39:55 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <74c2751a-4de6-49fb-b675-dc3c7f6e0bef@redhat.com>
Date: Wed, 5 Nov 2025 14:39:53 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-14-frederic@kernel.org>
 <ea2d3e0e-b1ee-4b58-a93a-b9d127258e75@redhat.com>
 <aQtxMYmwzfg2NW1O@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aQtxMYmwzfg2NW1O@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 10:45 AM, Frederic Weisbecker wrote:
>>> +	if (!trial)
>>> +		return -ENOMEM;
>>> +
>>> +	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), mask);
>>> +	if (!cpumask_intersects(trial, cpu_online_mask)) {
>>> +		kfree(trial);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (!housekeeping.flags)
>>> +		static_branch_enable(&housekeeping_overridden);
>>> +
>>> +	if (!(housekeeping.flags & BIT(type)))
>>> +		old = housekeeping_cpumask_dereference(type);
>>> +	else
>>> +		WRITE_ONCE(housekeeping.flags, housekeeping.flags | BIT(type));
>>> +	rcu_assign_pointer(housekeeping.cpumasks[type], trial);
>>> +
>>> +	synchronize_rcu();
>>> +
>>> +	kfree(old);
>> If "isolcpus" boot command line option is set, old can be a pointer to the
>> boot time memblock area which isn't a pointer that can be handled by the
>> slab allocator AFAIU. I don't know the exact consequence, but it may not be
>> good. One possible solution I can think of is to make HK_TYPE_DOMAIN and
>> HK_TYPE_DOMAIN_ROOT point to the same memblock pointer and don't pass the
>> old HK_TYPE_DOMAIN pointer to kfree() if it matches HK_TYPE_DOMAIN_BOOT one.
>> Alternatively, we can just set the HK_TYPE_DOMAIN_BOOT pointer at boot and
>> make HK_TYPE_DOMAIN falls back to HK_TYPE_DOMAIN_BOOT if not set.
> Have a look at housekeeping_init() which reallocates the memblock
> allocated memory with kmalloc to avoid these troubles.

Ah your previous patch of this series did that. I was thinking about the 
existing kernel code at the time. So you can ignore that comment.

Thanks,
Longman


