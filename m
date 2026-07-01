Return-Path: <netdev+bounces-303776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BDUUBDtKRWqW+AoAu9opvQ
	(envelope-from <netdev+bounces-303776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:11:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 336776F0322
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:11:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OOGb8xWw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303776-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303776-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1DEF300D6BC
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F36337C922;
	Wed,  1 Jul 2026 17:01:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA337BE6B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 17:01:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925301; cv=none; b=knZolGk2JFLlaergsGCT7zxKMm95NjUXQ+eWgMNaRJTKogv7+b6YaqRy9UjMMleGQSUSoVmZEk2eivUw8Z4xo00D7hmBWusxzrQb/CJQvWhwGAOGiTcTU0PtNIDtFsHcjiEa6M12K/2s8ptjsj1+0xELc4fCPsp1yR7XrzNdFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925301; c=relaxed/simple;
	bh=cXZvzRGh9+LC8x/UZFSBxmdI7wez4U+orwjoklAgSXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6TDscLpeBPZHWkZkEdX3xUou1HTDfQo01QN2Hxspmj+MXsT8LDmtHoU/Sgfi8UgsDs6HDBqOEqBmDsJEgljGK1Esu6whjRWATvaB5DsqPIRvS6mdYVy6dx2v63Srw2PjZiKLRF+w8UzHlmGOkjoGAUegiGDP5a22WxwV3qbdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOGb8xWw; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b27c7451so20719725e9.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782925297; x=1783530097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CayLh9sn6SyGJSkLYj3J5jM0EP4cWj8SDd1cZ9x18Y=;
        b=OOGb8xWwC4dT+eqE2W+82SR8+5YiBL6+gA+J3O9vPOIqYF8cNEW9CbKmpL1S4txGAL
         zjlsI8fpR4/u62hnbiyVPzSwdNSyTUyPtJ6SKlh57P0l12u7ktpL+UZEdx9ZZIkbHvGr
         PFrMl83B6G1ioFUPX1RGCqSCF8GFmA6W8NWnQ3Pk5UVP9w6+E2gIlz8WZJkK3UUxlfr0
         EdqZZEJGQj9hyQDw0KmItfSoN3JypGgVg80aHsRQpQNVosHmKHHhQgsoHOEHGRMfOwza
         DFC5Wv/zBgkflczP+yDpAWg37lXwU5IhicnU8d+Ya2ZM/x+WfMr6OistQX8NcbGUsEHw
         vW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925297; x=1783530097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CayLh9sn6SyGJSkLYj3J5jM0EP4cWj8SDd1cZ9x18Y=;
        b=S7O/7I0A6jI1B0CcAYk75JGz1AxYUya1NuMqARr6SfTu/JqUJJ2jLi9amXhKJtUwsz
         CTBpgdkd3/yynM3boWg4bSTuh/FNXw2p1OXqYz/b9Bfz7AOo7dQIYsCnnpuuYxXb4tZd
         tMLg4u+CsSznVWWXRnkQCoi8B1sU0RMdazLuBc4grGwZ4PLQSuXULV2h0P6J/gknd5U6
         EEhFzLaPEU/ugeqk33LGDdHh4DVmQ8TnZw7vswkglrWA1g/o6B69IrKb9ozbsWwhYkhB
         8wpyS44JRfN2Q1XR3b3cWpCa5rXJvMxUC40rUflqkzX4vgoIhtBzpyoZ/PlX4Saug0bt
         Pd6w==
X-Forwarded-Encrypted: i=1; AFNElJ9I8MmZhWl87BQD+V1z9pj6P4FzSNs+1cwfeYNBm6ewLRBxckE7/aUbiBAWGiNAWD4QfDaQOS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy01LV4rRkVR6YMBDJ7ZxsPuXkv9HNxZVXd1qvzi62ovwmcXMU2
	PPNL46z5/cntUlGpKUqhl2ruvN8HxefMbyVepnaZVgnh3ZnkKR8lyi5q
X-Gm-Gg: AfdE7clXGTSU1Q51tP0fDOedBmcsri5IykfFF41Co/clQpvj0OjR35Y+SCSGAW03sfB
	cVb8ot03MQDIzH+0zOWNUQTq9coJSVHX2Dln6V4R6pk+DHA1+fI4XkZ41+NORiSwyK6s7z3JgVe
	eGmGsbkttD2NQthJjSkkwK1bDdT2Hi0DeRMBMdTSc1hjDj/rbyBWJTrmtGGY6SUE+9CPRhME9NR
	mBejquVOSkJTjUeGrZ7ZKcplWPG89bGh8lvnxl+w2IupOHIeldottVEhRznmhnvlEWz4459xJq8
	RWiznCiYa81TqygAW7gtQxRahNqJcLvPScMm/dCz1dDt1ertNKqyzvonkalMz3RaGv5qorkC4l3
	l+XSpR2q3gUQc86vudpyjRuYCdt3uPez6Uibf4Q1uu6WYfDHSk4oLQr5q04QdRAHp6tUeUCQq7l
	fyK5QreBHFSAPwT1ZbYEd1Jg1RMAFoYoWkoro05jLkyZgmW068SXEy8BjcybM2gyg/ACGdqVmkx
	cQ=
X-Received: by 2002:a05:600c:4685:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-493c231f913mr37259535e9.7.1782925296780;
        Wed, 01 Jul 2026 10:01:36 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4bfd47sm122822645e9.2.2026.07.01.10.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 10:01:36 -0700 (PDT)
Message-ID: <d069d958-e069-45ea-87b6-95ad4a5fca29@gmail.com>
Date: Wed, 1 Jul 2026 18:01:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] sfc/siena: use kmalloc() to allocate logging buffer
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sudarsana Kalluru <skalluru@marvell.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-net-drivers@amd.com,
 netdev@vger.kernel.org
References: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
 <20260701-b4-drivers-ethernet-v1-3-58776615db6e@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260701-b4-drivers-ethernet-v1-3-58776615db6e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303776-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:manishc@marvell.com,m:pabeni@redhat.com,m:przemyslaw.kitszel@intel.com,m:skalluru@marvell.com,m:anthony.l.nguyen@intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-net-drivers@amd.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 336776F0322

On 01/07/2026 14:57, Mike Rapoport (Microsoft) wrote:
> efx_siena_mcdi_init() allocates a logging buffer for MCDI firmware
> communication diagnostics.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

(resending since I hit 'reply' instead of 'reply all' the first time)

> ---
>  drivers/net/ethernet/sfc/siena/mcdi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/siena/mcdi.c b/drivers/net/ethernet/sfc/siena/mcdi.c
> index 4d0d6bd5d3d1..048c1e6017c0 100644
> --- a/drivers/net/ethernet/sfc/siena/mcdi.c
> +++ b/drivers/net/ethernet/sfc/siena/mcdi.c
> @@ -7,6 +7,7 @@
>  #include <linux/delay.h>
>  #include <linux/moduleparam.h>
>  #include <linux/atomic.h>
> +#include <linux/slab.h>
>  #include "net_driver.h"
>  #include "nic.h"
>  #include "io.h"
> @@ -73,7 +74,7 @@ int efx_siena_mcdi_init(struct efx_nic *efx)
>  	mcdi->efx = efx;
>  #ifdef CONFIG_SFC_SIENA_MCDI_LOGGING
>  	/* consuming code assumes buffer is page-sized */
> -	mcdi->logging_buffer = (char *)__get_free_page(GFP_KERNEL);
> +	mcdi->logging_buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!mcdi->logging_buffer)
>  		goto fail1;
>  	mcdi->logging_enabled = efx_siena_mcdi_logging_default;
> @@ -116,7 +117,7 @@ int efx_siena_mcdi_init(struct efx_nic *efx)
>  	return 0;
>  fail2:
>  #ifdef CONFIG_SFC_SIENA_MCDI_LOGGING
> -	free_page((unsigned long)mcdi->logging_buffer);
> +	kfree(mcdi->logging_buffer);
>  fail1:
>  #endif
>  	kfree(efx->mcdi);
> @@ -142,7 +143,7 @@ void efx_siena_mcdi_fini(struct efx_nic *efx)
>  		return;
>  
>  #ifdef CONFIG_SFC_SIENA_MCDI_LOGGING
> -	free_page((unsigned long)efx->mcdi->iface.logging_buffer);
> +	kfree(efx->mcdi->iface.logging_buffer);
>  #endif
>  
>  	kfree(efx->mcdi);
> 

