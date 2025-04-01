Return-Path: <netdev+bounces-178502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C01FA7758B
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588E1188AD7E
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 07:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476BC1E9B2F;
	Tue,  1 Apr 2025 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwMKzKWa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9191E9B1A
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743493517; cv=none; b=ehQev9SlpZHNffijqh20lzf2YYbHPl80AOSzFIizxBQsWKLbfphzmEgv5EmDg5W/3GyhECJaBSVJ2Uw15zHkbfj9sYwnxbiRIj+fS+cL5gITtUbVPksmmWVlaqaN9U/qUzT8x6z2ULfiuHvJU8j6K+4+M1ZGNN5GcH2pV4bJzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743493517; c=relaxed/simple;
	bh=NJg9loH5DPwUT9RIGGEOKSUIUmJpxXqcl7s9uyAryf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HE2yHRfUQSTvvUQYRqUJNWc3TscXC2Lac9VcjCFFF/1K+Qrzi390CEbZbK/SeXwUMPWyoSvmjVgvLzWhGEvSHqCW4NCZp7MtBObtbSA+2gx1Kmuu7aT5KGuFR8JRanabgtiHU/MmA3/jKcHRUAxWbh4fqoV4kljUiLTstaKunyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwMKzKWa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743493514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPVEmBMiCehllT7+kdVA6tb5Y19MZOZXc3+AWueTqfA=;
	b=MwMKzKWaTwMWMDOSrDwMytvj4aEHcCL4aHPIGyOp2iTmsN/x1tBaUymo4MVyqhU53gRT5N
	4xjIj9GLwcho2XWv6Atp+lbrEoG17Ya9zEws8w22yHTirilWrVVK+p7BVnFPjjanXqeAJf
	TI1Y+CURshlWrP/WIrMJNQwWix4sr7c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-xbSv1jGhNSqshsKgilQpoA-1; Tue, 01 Apr 2025 03:45:13 -0400
X-MC-Unique: xbSv1jGhNSqshsKgilQpoA-1
X-Mimecast-MFC-AGG-ID: xbSv1jGhNSqshsKgilQpoA_1743493512
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39135d31ca4so2718877f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 00:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743493512; x=1744098312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPVEmBMiCehllT7+kdVA6tb5Y19MZOZXc3+AWueTqfA=;
        b=h/AzF9kEoJ0T4B6u6NEpWe9ATLh37U8x5Y4ompZJnlcc/fGxoOee/beWV5R5Qs+bGD
         35ihuuyu7G4o3u2a0A3QIuPvlJFSjumgX804llybgLXS7bAcMcQBvieZro+zuQV+eIzS
         l+x12UrKzdPG2lLSwUnsJa/jSc77yT8Yi7MuxvQEU+xZhTAOIvNcPfkQ2n0YwGdJqC/I
         xWnuAwO7TPYDuQQyWhXJtkuD5CIxNPjJmxTSj5EzSKTJ+tTEYEUTaAev8fY9KV5M6+mN
         RUKAXn54QKnSnZZPZ6ENxcQj520b3JynE45tvR/hP5VLqxD0oqI1CGUkemg5bb2r8fkU
         tZuA==
X-Forwarded-Encrypted: i=1; AJvYcCU4VMYVaQKo/4bhKxxanKg0n3FEV0ZmkaPO+22THm8TwGN/ZZDnNEEPKtwcXRPSTj6H0LEz3sU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+KW919sXvb1yM/l0NWYsjeFWCfzYuqayXVTYdhxA119VvFZiT
	teKXnfAC/j4JkmV7Qe04HolIWpQkG2AInNemWJsd+VdKKiXz3tV/45EkLBCxcp7fysdzrHfX9DQ
	POHMA3jn+c6+P0fPBqMogi8z2fFYFaxedy1VGJjbBZzo/f6gRlGo7Tg==
X-Gm-Gg: ASbGnctgmLBtxDTf7RBiGq2qgGgJKRfXLYEB2WQmcH+xNwEI/320jW/6opT5tjDvA+P
	SfBtd8tT7lryMkqW42tAZeN1TetWHHyMkLNAAgkTPYEXlb3KMnqkesL9hPjj3q6SLQFePfakQ0+
	rH7FuUuWRHRh7DRY5Rqko/RFhXKPESdnZhHSH7qfLDIz2dPazidobgIBR0qIVhcKKJSmIva77Sj
	p3AdYduMek0GQCNA5oJpusXGHb2oaBznYvJSiWOYQAKjVPC+woBY0Bx4QgjMpuQ5jodNPuDs4r3
	cntAPm/pmLSQN5SJBpDUg5yV5RKCe22hGJ6LsdaTcv9zyQ==
X-Received: by 2002:a05:6000:1448:b0:399:6d6a:90d9 with SMTP id ffacd0b85a97d-39c0c136bd4mr13298966f8f.18.1743493511675;
        Tue, 01 Apr 2025 00:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpGjDvgRuv3rPh+sZzuIo7a1UqtEX2dbLL0x3yl3Qc1zwqWs0cDqxIOuutwoJPuKYJIFAmdw==
X-Received: by 2002:a05:6000:1448:b0:399:6d6a:90d9 with SMTP id ffacd0b85a97d-39c0c136bd4mr13298938f8f.18.1743493511262;
        Tue, 01 Apr 2025 00:45:11 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6630a3sm13423505f8f.30.2025.04.01.00.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 00:45:10 -0700 (PDT)
Message-ID: <d9a7af40-84f9-446e-a708-d989b322a675@redhat.com>
Date: Tue, 1 Apr 2025 09:45:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concurrent slab-use-after-free in netdev_next_lower_dev
To: Dylan Wolff <wolffd@comp.nus.edu.sg>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jiacheng Xu <3170103308@zju.edu.cn>
References: <CAJeEPuJHMKo9T3GcAQH2+X3Rke3b4YH3_S6FmnBp4tQqLciYxA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAJeEPuJHMKo9T3GcAQH2+X3Rke3b4YH3_S6FmnBp4tQqLciYxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 3:00 PM, Dylan Wolff wrote:
> From the report, it looks like the net_device is freed at the end of an
> rtnl critical section in netdev_run_todo. At the time of the crash, the
> *use* thread has acquired rtnl_lock() in smc_vlan_by_tcpsk. The crash
> occurred at the line preceded by `>>>` below in 6.13 rc4 while iterating
> over devices with netdev_walk_all_lower_dev:
> 
> ```
> static struct net_device *netdev_next_lower_dev(struct net_device *dev,
> struct list_head **iter)
> {
> struct netdev_adjacent *lower;
> 
>>>> lower = list_entry((*iter)->next, struct netdev_adjacent, list);
> 
> if (&lower->list == &dev->adj_list.lower)
> return NULL;
> 
> *iter = &lower->list;
> 
> return lower->dev;
> }
> ```

Please share the decoded syzkaller/kasan splat in plaintext instead of
describing it in natural language, and please avoid attachments unless
explicitly asked for.

Also, can you reproduce the issue on top of the current net tree?

> This looks to me like it is an issue with reference counting; I see that
> netdev_refcnt_read is checked in netdev_run_todo before the device is
> freed, but I don't see anything in netdev_walk_all_lower_dev /
> netdev_next_lower_dev that is incrementing netdev_refcnt_read when it is
> iterating over the devices. I'm guessing the fix is to either add reference
> counting to netdev_walk_all_lower_dev or to use a different,
> concurrency-safe iterator over the devices in the caller (smc_vlan_by_tcpsk
> ).
> 
> Could someone confirm if I am on the right track here? If so I am happy to
> try to come up with the patch.

netdev_walk_all_lower_dev() should not need additional refcounting, as
it is traversing the list under rtnl lock, and device should be removed
from the adjacency list  before the actual device free under such lock, too.

Thanks,

Paolo


