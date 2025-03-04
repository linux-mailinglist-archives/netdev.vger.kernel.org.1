Return-Path: <netdev+bounces-171608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C29A4DCC9
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F76B1768C2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7BD1FF7D4;
	Tue,  4 Mar 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i96/pfft"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7DA1FDE27
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088392; cv=none; b=Y9WokqIb6vrT5zlaSVxPkYSsGqXF+iip3mDZag1P4a7LBPoncStu1l3T8DLEOpZpKjcEf9iYt/oZq0ahz8REGWUieRF6Q1JX8AOFFBJs8aTTGvRrPquHjdEujEt3y3JkcHLvjRC/RG8higPzeClKA1QW1fO1xuowGrBPpkkEnL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088392; c=relaxed/simple;
	bh=Pet6msmAnBNCWNPcprQAH+0FzVtjVOU/qcl3s7u8JWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fT9bIAJuSvxNz223HmgrKNiokAt5A1lG6xvl7/AFYgj5/cxeh8K+wMdyeZXjmKo0bBTrLD1kaLHtVTcC4w1wnLvS/yFUTNE896+3UZm95o5jW+UWnCDji6/BNW0EP6Q/nhyNbIpcNkKouZthxytgzJE65HUtueAsRMm7PSpbTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i96/pfft; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741088389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hntXZpQfa271EvBEp9eoZmK+pCjo6fsW/klFtftWSNM=;
	b=i96/pfftMtBCkDZxcoHkMygSJpIR964HRiIzfmBqsCqv2r7JB16/oa/8QLNmA/WmiaymCV
	oEBpBH0q2yVJRHt+MHRM2xtXpg72T2+5vTItG7k5IgquHoQxt+cL6v/8+/u4jxlxay9ReO
	jKxLdzLz77/ldTJxf+VAxLYDGK79MVs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-6IloJg40Pq2oZKH9l5Mhow-1; Tue, 04 Mar 2025 06:39:43 -0500
X-MC-Unique: 6IloJg40Pq2oZKH9l5Mhow-1
X-Mimecast-MFC-AGG-ID: 6IloJg40Pq2oZKH9l5Mhow_1741088382
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4398ed35b10so25468545e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 03:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741088382; x=1741693182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hntXZpQfa271EvBEp9eoZmK+pCjo6fsW/klFtftWSNM=;
        b=o75HBijuiKRB/nnPLyWX6kFlFgoMxnK+MmjPUhv2U9s0gfG3sMgICKypeNlt/NExSx
         lOLXsUkJUW0/Nqd1gmL2voy9kxewS8tZruXM29Pwo/Ko58vU2VOqtDjaWwZPduYjet9u
         qkHgkxA6DtxOhaeSkg7DaFaLQ2YB1dtDg4nFenbCtBTLggb8E/gVIL97GnsCR7YYRrTG
         5zuBt1gzED/fxdOQXoriSlQBc3qgDxOmF40soAjgtbpIkk7G3kzmU9oUHUgy9o6fNQPg
         3hCjg+XT4WtNXW+VnTsrXZpjdkcFTuuh0WVC3XcynfqJSZDAU5dm1MMli4iNuRgsCa4M
         4Bcw==
X-Gm-Message-State: AOJu0YxItZM0kOLeytrZnmZ9BHl46Qd0dK7YZD6b8fK+bT57/TIAZv9S
	0XZOeJO5OR4TZb8ccq6p0mtsLlzkO/9Hh2rKomVF5SeGwVKyGNajKIPW1BlrDJFiSddGCt+WAot
	YWChYOEGKp2glT742I4w6HomHxEGib+ssTb+DmF78OqrWxfFJ9g4RvQ==
X-Gm-Gg: ASbGnctHEvvDfKeIO01rIioJK3O6cdao/d0EDXaTZMDV85QZZFjxwzmMmVRxJLMl3qB
	g6AgI9YWvuLCJ1S4b0EAsn0MsxMsb1qaDYFcm9x/zaBhRLMnSKqyyTZxCUp8/qUaYd1LDReSxWc
	mwJW+20YNnYRfz4M6iIQvG4JdhsiJGWv9U8uoegUZ3pBm3y7u15gt8diSOgloB79XfshlqThYzi
	ouQdqsg63m2fD5U4+77xb24660q0qAmc+s74JnWjn2LxoWwU9HgvhFt7e3fpv1hhHhlSSE92FKX
	oX9EIdQgSKFDxflQf1vjrlxJAxa8eJCbx48UOsFE3ghdhQ==
X-Received: by 2002:a05:600c:1384:b0:439:9f42:8652 with SMTP id 5b1f17b1804b1-43ba6704748mr155318285e9.17.1741088382348;
        Tue, 04 Mar 2025 03:39:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvEFgiDy7ba5K1ePVI42ersngV+bgTh0BsGa2h1RJF6kOEPu7Gge8cE7SX90ZY6smvmrEHow==
X-Received: by 2002:a05:600c:1384:b0:439:9f42:8652 with SMTP id 5b1f17b1804b1-43ba6704748mr155318035e9.17.1741088382013;
        Tue, 04 Mar 2025 03:39:42 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6cd8sm17197430f8f.44.2025.03.04.03.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 03:39:41 -0800 (PST)
Message-ID: <5ec0a2cc-e5f6-42dd-992c-79b1a0c1b9f5@redhat.com>
Date: Tue, 4 Mar 2025 12:39:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
 <20250303172114.6004ef32@kernel.org> <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 11:56 AM, Andy Shevchenko wrote:
> On Mon, Mar 03, 2025 at 05:21:14PM -0800, Jakub Kicinski wrote:
>> On Fri, 28 Feb 2025 12:05:37 +0200 Andy Shevchenko wrote:
>>> In some configuration, compilation raises warnings related to unused
>>> data. Indeed, depending on configuration, those data can be unused.
>>>
>>> Mark those data as __maybe_unused to avoid compilation warnings.
>>
>> Will making dma_unmap_addr access the first argument instead of
>> pre-processing down to nothing not work?
> 
> I looked at the implementation of those macros and I have no clue
> how to do that in a least intrusive way. Otherwise it sounds to me
> quite far from the scope of the small compilation error fix that
> I presented here.

I *think* Jakub is suggesting something alike:

---
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b79925b1c433..927884f10b0f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -629,7 +629,7 @@ static inline int dma_mmap_wc(struct device *dev,
 #else
 #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
 #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
-#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
+#define dma_unmap_addr(PTR, ADDR_NAME)           (((PTR)->ADDR_NAME), 0)
 #define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
 #define dma_unmap_len(PTR, LEN_NAME)             (0)
 #define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
---

Would that work?

Thanks,

Paolo


