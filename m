Return-Path: <netdev+bounces-303775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rEIkEaVHRWrr9woAu9opvQ
	(envelope-from <netdev+bounces-303775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:00:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D3A6F015F
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:00:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=M35qcbyJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303775-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303775-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 936D3307BFCB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 17:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039F3806B8;
	Wed,  1 Jul 2026 17:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E729737EFE3
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:59:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925201; cv=none; b=Lcymw6eY+IUCTp5isONR+ah1XJ27MpTnYlU1a8fl7pyD98dM+y2PLQi4tAHxJUvc1QKYWHx2x/WkEbsHA0oVx59lIDDdLc8oVIvmz/cbYpU8jxxHwzLKODO0cvLnhsAPlUn6YjMt6WEap5TbJbEriI8SX4KPhm3x//T23+rXQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925201; c=relaxed/simple;
	bh=SlqAYF/R/nxbaLdun/T9sdzZCmGY9o3nhXCIf2spoTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4oodBapIK4GvJXsp2CDd6y+SSqUr8ePh+o0GG0fC8waIUCHeNprMkIisGzm8sFa2EMHZaiu75fSyaLHP7AYbldDRcz+m9h2Gk/Wx1m7tPwYH1dTjnTG7bdHTQ/e1EQtZ2SSLG240ZkZHv9QjeWXjI1milNPNpyThdbl1bx+sQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M35qcbyJ; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c4ce68fbso531845e9.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782925198; x=1783529998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaapEG/0w2F/ZCT3Yos1qIyYlCxFdKMOGlwcZerx/iQ=;
        b=M35qcbyJnkV1pZ25FOL78MBNI/DWv9H/oivYVHG2HSos9G8M6UchY4Dy7hrllt0TxZ
         yXfxuXDmDvhn++vCbalU4oWUl2YgQTnHDzQF2bmknznBkSmV4BiRWakrexsI4CQ/6zzv
         2pcC3VOfkdE3bevu40odc+jmhUBgJULgTJF9s2UmBvHJKEBS/glNDqNWc0pP9XYIOqY2
         MgqGHql1fBu7e1updDyrnYyBkJBFTu6DU6ZwrVZbisRtisjP9ID5lyEgDlqNBUVy3puz
         41rzaSLQ2n4L4fnRulBtfLddnBtrVZyR8APOPBkg2cyNwnzMKFLDLRPnesO22NqXrcxQ
         aA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925198; x=1783529998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaapEG/0w2F/ZCT3Yos1qIyYlCxFdKMOGlwcZerx/iQ=;
        b=aXEbyupTvnjUoVSKIPY70XgxhVp3yds9GWCZqclkP5YkwQr3sbjUmNUzPvcqTVujIS
         bAwDg/nxOGnKMhXo4yR/NaPhnYBHlhibbbMExIWD/5LO1OpgbRXxiygALCAlUqcuy7pW
         Eiw6qPEqMyeWoWbx9TsN2QeBWScN0945UBYnYqYbIdbxVwrid+BRWbz+wPyX0tAosDoe
         UzoWooQ/FqI3+WHedlpCz0R9b0mWOpR7ICNPichqOyP2hYHbxl+d4CubmeWmzjtPQpv6
         mewiJcFRASRPCBJws1W9IpsBTEzxaJX/ZYIqpx3z2g0hW0ozdo8Kuc8eoe84ik18V08R
         UtuA==
X-Forwarded-Encrypted: i=1; AFNElJ+Jslf6d0x25+AWsMWZMzn8WCtFE132Jy3f/wg91+IUdKzzDwuPOron0MKd2u5RQWz+Omstui4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRz/uDgm3Trk5uoBlM99doB/6tyibivdKiLrSH8AKNEQEDgVEa
	MgbA+WBn91tAP4GaYZ8obtFtdzebDIGPywWuyiVhmqw8QZpZfq5SfwX67i+JZw==
X-Gm-Gg: AfdE7clhHaEwvNZPoo4IWGYMw6dbP8A5ttRJNlKUGAKUbn6qQp7dRX2j/V46VQltP92
	IDhN8MdvcdYzDe3H6tD3p3OioJNrMpTC+FRKVYU9clhnVheFziAwdKVDy9uDAlFhGWhksMjalyZ
	WrXDAg0kUX47PtDd4qvm0xjuEljO1PtMLQpsvnPlCpd/G1GqotnzckttC1v3stw6vWXH1I/KIo6
	Be7NiDxGwd2OVo/j9FAqSFw5AEjTZp33nX6qf1QpO/4NYP1s9eohV4WFBRW+r0FwW5/e1kCXDSY
	+xVZXkrvQ79LlmP3NFdXRnc1X/UmoWOH3UwU4vDJtfuZluB4Kj9kFkhHmpcNbjL6MENLJJMUtP8
	mEvuV0+MzoWx9EghvXiHk7t798yoE/qo1FZ2MqN9k14wJAHo/ecIirtIoJrVvlJg4U3/JPEpljM
	LoNPEoTNPGiRPcgWtbFS6lIN72YJAOHhpKFer+M9WU1FAb9haeAmEEQr5dVaQyWx99uQaRo57y0
	TI=
X-Received: by 2002:a05:600c:8590:b0:492:6f9b:572e with SMTP id 5b1f17b1804b1-493c2baeeeamr29176415e9.37.1782925198152;
        Wed, 01 Jul 2026 09:59:58 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4c9f78sm92659965e9.5.2026.07.01.09.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 09:59:57 -0700 (PDT)
Message-ID: <df6a8720-fa5e-490b-bfb5-817ba53ff59b@gmail.com>
Date: Wed, 1 Jul 2026 17:59:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sfc: use kmalloc() to allocate logging buffer
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
 <20260701-b4-drivers-ethernet-v1-4-58776615db6e@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260701-b4-drivers-ethernet-v1-4-58776615db6e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303775-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:manishc@marvell.com,m:pabeni@redhat.com,m:przemyslaw.kitszel@intel.com,m:skalluru@marvell.com,m:anthony.l.nguyen@intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-net-drivers@amd.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: D2D3A6F015F

On 01/07/2026 14:57, Mike Rapoport (Microsoft) wrote:
> efx_mcdi_init() allocates a logging buffer for MCDI firmware
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

> ---
>  drivers/net/ethernet/sfc/mcdi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
> index e65db9b70724..b806d3d90c42 100644
> --- a/drivers/net/ethernet/sfc/mcdi.c
> +++ b/drivers/net/ethernet/sfc/mcdi.c
> @@ -7,6 +7,7 @@
>  #include <linux/delay.h>
>  #include <linux/moduleparam.h>
>  #include <linux/atomic.h>
> +#include <linux/slab.h>
>  #include "net_driver.h"
>  #include "nic.h"
>  #include "io.h"
> @@ -71,7 +72,7 @@ int efx_mcdi_init(struct efx_nic *efx)
>  	mcdi->efx = efx;
>  #ifdef CONFIG_SFC_MCDI_LOGGING
>  	/* consuming code assumes buffer is page-sized */
> -	mcdi->logging_buffer = (char *)__get_free_page(GFP_KERNEL);
> +	mcdi->logging_buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!mcdi->logging_buffer)
>  		goto fail1;
>  	mcdi->logging_enabled = mcdi_logging_default;
> @@ -112,7 +113,7 @@ int efx_mcdi_init(struct efx_nic *efx)
>  	return 0;
>  fail2:
>  #ifdef CONFIG_SFC_MCDI_LOGGING
> -	free_page((unsigned long)mcdi->logging_buffer);
> +	kfree(mcdi->logging_buffer);
>  fail1:
>  #endif
>  	kfree(efx->mcdi);
> @@ -138,7 +139,7 @@ void efx_mcdi_fini(struct efx_nic *efx)
>  		return;
>  
>  #ifdef CONFIG_SFC_MCDI_LOGGING
> -	free_page((unsigned long)efx->mcdi->iface.logging_buffer);
> +	kfree(efx->mcdi->iface.logging_buffer);
>  #endif
>  
>  	kfree(efx->mcdi);
> 


