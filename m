Return-Path: <netdev+bounces-298910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gV02N8YFLWrPZAQAu9opvQ
	(envelope-from <netdev+bounces-298910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:24:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF5B67DFB0
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:24:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CJYje5qq;
	dkim=pass header.d=redhat.com header.s=google header.b=cFw3Cafn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298910-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298910-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8372D300DEC5
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 07:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6842634E75A;
	Sat, 13 Jun 2026 07:24:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687B84039
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 07:24:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781335492; cv=none; b=Dxxx4XDoTbJBxuX39isQ/pHkl7/dBZNy10kBGPM34rpgkpFXTEggjn7MBvpk9+xhTiYQo4aJcKcUA1eEePHZxo6yvrgKcxx11fz+hjh91AxioLyYw0Q1LvfHrJdS/SDO7RmHOan+/re+MEkcvVL1GqJxDLMQ4aOv8C6frhqiDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781335492; c=relaxed/simple;
	bh=QWp2dUhBuaMQ3R+EWT4864ChcX9S8coMOypBNk9GlkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkrIDOcAI8MrjLCx2Y4Fjyl13P+OsfK9wB0WncLOZ129NgLq3gYgGRoW/20BRtbDb3MhaYaNab1EsktgKtRGd57+vKVMStzmhMRXB3kmTiMyH9zN9ANfVGsQLeJfHWm4GlrbSvPDUwoXAoiIPgzamGsm6J/fU+6CImAFqFdAulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJYje5qq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFw3Cafn; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781335489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bYQFKiJorSd2L8GlFyWe7Glm246Aic2GK4MBG3QZzg=;
	b=CJYje5qqB7xy9QzR3QAIcbTSCGEaw0aHxWhUvuPskrBFoX4MmLza9G6GKCG90E6/cPS42a
	vGPy8lsYaWb2vBazbncioBUeS4NR/r7d/CECaghMWlwjNqQRGAY7d3XVd4CiL96Jm6JHc8
	yYewOxGwDmSKkkqRoEfUsXv2KH0UKZw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-AWt2JWroOMOxwGj4tf1QAA-1; Sat, 13 Jun 2026 03:24:48 -0400
X-MC-Unique: AWt2JWroOMOxwGj4tf1QAA-1
X-Mimecast-MFC-AGG-ID: AWt2JWroOMOxwGj4tf1QAA_1781335488
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ccf9080db4so24564556d6.2
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781335488; x=1781940288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bYQFKiJorSd2L8GlFyWe7Glm246Aic2GK4MBG3QZzg=;
        b=cFw3CafnG6dsxBkUNGgVb/PHhIyITHyADeu+v/P2A9lkLBKko3VTePIPUGFckGjsmF
         GcSQ023xA8V9Tw2acwNDarb+rKoRGrOFKMX31i2mCOq/ZuPZUhIJZILv2zuQKOKgviex
         UBqYmHXUCVL5fz2rGX2dfxf8xmguMzSHJFbnfsDkF6qb7Lp1hGAqpVrnb8fhfKYGeZMn
         kceZVBNMD+MuPZA/dR4Pe9KUR+Mc+URaem8UsZwkXGTFNMbtlxNktSTSkevyc4H6A+2m
         ykJ0A2GiYuesaAqCoJG6Vm5RHzUJCYm5/sDxc+LGiK+3KfEJ7gWWAD7grPQT+9GLcgpr
         Qt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781335488; x=1781940288;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bYQFKiJorSd2L8GlFyWe7Glm246Aic2GK4MBG3QZzg=;
        b=TpYWGgvP/XCMIF5VsHY4+hkZhrwvBUqAa4fcQPiFt6UX7MZ08XJio6hQfOxp6+LJ5q
         9FaQaSPf2k1BgP+KvTDu9LM+6zegZUBuCELW1PxKZoxOMM+83qSqJGKVGKcoLq8aLYud
         dcafkJCVSBRraHtx/n8LYwKZiPvYGSAI73NxT7bVbsyvA9EKttD2dCRwSlww6HNtjCoC
         VbGuyVFl0kvrqF1DtIiGW0H9nh+ZQ/zLmOtdjCcDuWl4k0VkeOznF7H7xofcwMosnpHt
         brlPOnvcMSGZo9aRFrKktQjjvwclHCvIHpgqIjjGNmK4MLo/9iCqgghxqyI8MGH6YuvI
         O2KQ==
X-Gm-Message-State: AOJu0YyExhRAmYcT2G+z+3EwXoLiRWzu6owFYyFRYp9Mdqzn/pUltbaX
	il4bgmb4nVf0H/0R4+ILC+q8/dWdtX7x3jD9Tgxy/mtFbmQ/ccMScaiHN2TZQ/Mo2KDfCVvKOPJ
	o5nLZIFoYLitjPfw0ZnsTHVOZ8cZPMhigZJxL64/v+/epCFLBchNN+VpWbg==
X-Gm-Gg: Acq92OF4hgaJVFMQIyJeq/9zl3k6LikPTBMNq4DfW+rBGnFiYGjOZSK73cBtuiB26pn
	sOc/Mo2nsrMuv2D78xAP/6YZJp99c+kE8fb/GzH8ibiLM2q9vNcLVejNSBgsfTfMf74LOxMeDTq
	yCKWUnwvV2OyXEmw/0UCBO1ROxs2+qw/kASy2VSQMaI+bG4Dk6fvh77TzlGhLbF6meGFYhU6awn
	IK68r1q7nWDBcIneqd6d6Ype7pGLYJpEMxQL4qrOPKCF643710+kUSnSfYBj9dO4HBgYz3IAxC9
	75Yep14pQcjWYEeDQEHl/pePMW4VwIU9BF24MurJb8+WvceCzLjKH5c65fflY7w6O526YHfXJ7O
	nxRnLk35kg+7pvaLvusjBiMVKle+8xzEYzfxRwaAnw9I5HGXjATHkj7E=
X-Received: by 2002:a05:6214:2a87:b0:8ca:165c:1a3c with SMTP id 6a1803df08f44-8d32c4ec56fmr96850686d6.10.1781335487777;
        Sat, 13 Jun 2026 00:24:47 -0700 (PDT)
X-Received: by 2002:a05:6214:2a87:b0:8ca:165c:1a3c with SMTP id 6a1803df08f44-8d32c4ec56fmr96850496d6.10.1781335487287;
        Sat, 13 Jun 2026 00:24:47 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d304577d69sm44134626d6.29.2026.06.13.00.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 00:24:46 -0700 (PDT)
Message-ID: <232383a4-d035-4a36-8edd-f78206ae191b@redhat.com>
Date: Sat, 13 Jun 2026 09:24:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: lan743x: add support for RMII
 interface
To: Simon Horman <horms@kernel.org>, thangaraj.s@microchip.com
Cc: netdev@vger.kernel.org, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org
References: <20260608100435.11214-3-thangaraj.s@microchip.com>
 <20260610162603.470355-2-horms@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260610162603.470355-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298910-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:thangaraj.s@microchip.com,m:netdev@vger.kernel.org,m:bryan.whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FF5B67DFB0

On 6/10/26 6:26 PM, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: lan743x: add support for RMII interface
> 
> This commit adds RMII interface support to the lan743x driver, wiring
> up phy_interface selection, phylink supported_interfaces and MAC
> capabilities, and enabling the RMII front-end via a new RMII_CTL
> register write in lan743x_hardware_init().
> 
>> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
>> index 0798f3f1f435..ad3f833c8d86 100644
>> --- a/drivers/net/ethernet/microchip/lan743x_main.c
>> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> 
> [ ... ]
> 
>> @@ -3562,6 +3574,11 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
>>  			sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
>>  		}
>>  		lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
>> +		if (adapter->is_rmii_en) {
>> +			rmii_ctl = lan743x_csr_read(adapter, RMII_CTL);
>> +			rmii_ctl |= RMII_CTL_RMII_ENABLE_;
>> +			lan743x_csr_write(adapter, RMII_CTL, rmii_ctl);
>> +		}
> 
> [Medium]
> Should the RMII_CTL programming mirror the symmetric pattern used for
> SGMII_CTL just above it?
> 
> The SGMII block sets or clears the enable/power-down bits in both
> directions:
> 
> 	sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
> 	if (adapter->is_sgmii_en) {
> 		sgmii_ctl |= SGMII_CTL_SGMII_ENABLE_;
> 		sgmii_ctl &= ~SGMII_CTL_SGMII_POWER_DN_;
> 	} else {
> 		sgmii_ctl &= ~SGMII_CTL_SGMII_ENABLE_;
> 		sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
> 	}
> 	lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
> 
> The new RMII block only sets RMII_CTL_RMII_ENABLE_ when is_rmii_en is
> true and never clears it on the other paths.
> 
> If RMII_CTL_RMII_ENABLE_ is left set by a previous agent (for example,
> a prior driver instance with a different strap, board firmware, or
> state preserved across a warm reset where the driver itself sets
> HW_CFG_RST_PROTECT_ during PM suspend, and pci11x1x_strap_get_status()
> already accounts for cfg_load/HW_CFG_RST_PROTECT_), can the RMII
> front-end remain enabled while the driver is configured for RGMII or
> SGMII?
> 
> Would adding an explicit clear in the !is_rmii_en path, mirroring the
> SGMII handling, give the register a known state on every probe?

I think this one is worth addressing, as it's reported by both sashikos
and could break functionality in hard-to-debug scenarios.

/P


