Return-Path: <netdev+bounces-173806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC4A5BC0C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0B5172950
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B9822A4EC;
	Tue, 11 Mar 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpIfQsS8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63622425D
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685117; cv=none; b=CLhckEx54Rc+ZO42oAsNAg03soJgkZOB6uvspxk/p11e7WvKX6IsZ53AGZnqd8B4CTRF30ox6rdWOriCYAuaXvJlNIDblVC4BjD1u14S6sALMrcwSmdJ+ypmjpvRpCoEWVOyioCIvhku0rNCTDHJay2Z3Jj5QEN1sw8THaoSQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685117; c=relaxed/simple;
	bh=AqhQEZMgKAb1ifuwL1FBr3WdjgDEuno+K3aftA8cbus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKfr3xLaOzMC4OrsQ5JEL21sNEYmedrM5ZK7e07AMtEyxIfzdwqI55FZbxyP7VH4SKmv+zbVS+/VgoywPBq9/wTcOlymbVFM0RfIpHgqnSGXk2dPGbMYbkVKl93dG9B/BN2xK/Kq0gFsEml2ndSmLtjGkzJXazICsAEq4AhE7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpIfQsS8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741685114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/SZDq6Z6N3N3ep/tmjky/rB67JOIGO9Ha7z2u/VzHQ=;
	b=IpIfQsS8OT4HRyZ0BXLFyHZZ44F5pPl6nDBLvjdwzyLb8cqjabuNgf6DBEsCrFIplB/I5J
	IsUsXjuW0IovArhUC4And8GdD7g8P8mup2SZRTWwM1qPgBBKKzjl33kaN4wFXJR/4IJRdn
	kEA1IpTm+NI5TKCWIfLTMfcCcz97QTQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-AtqSzCk6PtuLO5c0UQKFLg-1; Tue, 11 Mar 2025 05:25:12 -0400
X-MC-Unique: AtqSzCk6PtuLO5c0UQKFLg-1
X-Mimecast-MFC-AGG-ID: AtqSzCk6PtuLO5c0UQKFLg_1741685111
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf1af74f7so11840075e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 02:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685111; x=1742289911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/SZDq6Z6N3N3ep/tmjky/rB67JOIGO9Ha7z2u/VzHQ=;
        b=KtNa3rz1mcpnsBfwMrhcNr3hIIBLkdbjwXQ7VcQBejVtCnZ7JnKdnXP4dQzuE0hWtr
         fWZIIXvbvr/2JC8ETXuM5vPPisM/YKiVBhnEzbWWs5LDNDAfNpLotcQw+36uh5cuNWdi
         vval8YTghwOhdqjL6qnB9Gw0/DE+o00JIaipFL/iMoT7+ARiA6+c6GWH2iKTpZhBahPa
         +CuaHUGLLQvkx+q//ls3u49njTQQy1OoTZvbiFGGhQ6wCvwdKB0N/O0DcmJLHBONsLLn
         MKKpOQLASsLj0a5M+FRFBZ/ZeY641ACtSBLyH3SN59p6ElZOHs7KUEWDJGy6fDIrPCOD
         KTkg==
X-Forwarded-Encrypted: i=1; AJvYcCU0m8a8N+DyRGPvlVOlP3oMM1W+I7XEdWi81APupt1xNbVGHgBmMBLlMHvO4jSOKmbjCYPOsyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+PvtVtRw0xHiR3YsCpLydR2z4wcJcmUrzT3N9uUjHN0Z+hpx
	lM5/+TGCjgTZgRwrGqBB5C1MTBg/EwlWWKF6GnuGPYNEn3EBEXT15jcJQdzew/ISXBSIwdl9T4K
	mgIxGHjgjJGMSNGLWLUxp5GmFCrbtzrtK9eqXV+o5gNBFa0vS2dxzXQ==
X-Gm-Gg: ASbGnct8JLmvH0lVFsPPL9hlfNvIJQoa7ZhLRWY2hYpQh/eUKuHx80LA/aGn6Ybwfl+
	oR+2kClJTOCBGqkhQSOO7wq+qUQsJWOKREBMLzyjy2U1xMJCzAd2UYrufXuN97hL2OcD3USUr9c
	1Z/nMeiAVZ+s1oqplnzTsOZFsimgmALOZ7bFjaw/j5iX4ZxirsgoxTwA5WNgczVfVC2KbwCc+jd
	3qHgNBHTds60du1gTa2aBPtT03FwIU+lFlZM0XeQZ5hhAW5DxeutCcmTDEJyY3h6e2pjxjxCjuu
	GVXcZxw7qgVtruhRXdYK4sRonDBNOoKiFrq7d+AIn1CetA==
X-Received: by 2002:a05:600c:510e:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-43d068397bemr9363265e9.15.1741685111358;
        Tue, 11 Mar 2025 02:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqZDh76W9UzPli/AM+ArV3FiA6G6KprrtJ2Fr44sE+79dvvLKGAWbiOxHsNDTPh/JHiULugQ==
X-Received: by 2002:a05:600c:510e:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-43d068397bemr9362935e9.15.1741685111020;
        Tue, 11 Mar 2025 02:25:11 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfb16sm17334070f8f.29.2025.03.11.02.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 02:25:10 -0700 (PDT)
Message-ID: <978a9d2c-b82c-4209-ba95-8674b149294a@redhat.com>
Date: Tue, 11 Mar 2025 10:25:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] enic:enable 32, 64 byte cqes and get max
 rx/tx ring size from hw
To: Simon Horman <horms@kernel.org>, satishkh@cisco.com
Cc: Christian Benvenuti <benve@cisco.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>
References: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
 <20250306145604.GB3666230@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250306145604.GB3666230@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 3:56 PM, Simon Horman wrote:
> On Tue, Mar 04, 2025 at 07:56:36PM -0500, Satish Kharat via B4 Relay wrote:
>> This series enables using the max rx and tx ring sizes read from hw.
>> For newer hw that can be up to 16k entries. This requires bigger
>> completion entries for rx queues. This series enables the use of the
>> 32 and 64 byte completion queues entries for enic rx queues on
>> supported hw versions. This is in addition to the exiting (default)
>> 16 byte rx cqes.
>>
>> Signed-off-by: Satish Kharat <satishkh@cisco.com>
>> ---
>> Changes in v2:
>> - Added net-next to the subject line.
>> - Removed inlines from function defs in .c file.
>> - Fixed function local variable style issues.
>> - Added couple of helper functions to common code.
>> - Fixed checkpatch errors and warnings.
>> - Link to v1: https://lore.kernel.org/r/20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com
>>
>> ---
>> Satish Kharat (8):
>>       enic: Move function from header file to c file
>>       enic: enic rq code reorg
>>       enic: enic rq extended cq defines
>>       enic: enable rq extended cq support
>>       enic : remove unused function cq_enet_wq_desc_dec
>>       enic : added enic_wq.c and enic_wq.h
>>       enic : cleanup of enic wq request completion path
>>       enic : get max rq & wq entries supported by hw, 16K queues
> 
> nit: please consistently use "enic: " as the subject prefix for
>      the cover-letter and all patches in this patch-set.

Since it looks otherwise good to me, I'll adjust the above while
applying the patches.

Thanks,

Paolo


