Return-Path: <netdev+bounces-116929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D3B94C1A3
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7154283689
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844418F2EE;
	Thu,  8 Aug 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="A/yL0syY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8C18F2EB
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131737; cv=none; b=OeDNwjM/vIi1u8unoFPVh8EAK1It5S2eO+ATX6ml69QXv8jrKUR8JSsWfXR1VWvFWxFj+9/qkfiKPyLsP20NTFksbXurk84O4EFUn39wRR2fy/RSUyV5jyaEgMX+sP9RUJIPfyIhHSM//Y1JNnBuTE22MxX4LDq3JLre6YGCJB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131737; c=relaxed/simple;
	bh=a/+6Tos8S7ICLzXlmEUgTB3DsaqXSOghBdCUwZtglOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbhBwBxueDQ7KkNg+nKkPrupm+OEhZmUv4gZoahN7SCkbFtHgP9TyxfFFlSC0PrZSqsPefSte29/+yWGNFBufMBvU+FDEc0d3TWyBQWpmzGs/1IwtKQULivS8vqbXJdNlFlo+6eYMK34Hk15FM+Ub8Wo8YTT5+cOFus4X9Sjga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=A/yL0syY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fed72d23a7so10423405ad.1
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1723131735; x=1723736535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcoE8Vm+b4KAFn+fyVtticOIj4/Y4kdiFjtGog1FQeU=;
        b=A/yL0syYzYA0trCVEilclNAhAO4vxb5TlR4YNIwmkz2HcTvHyh86ENgZCzxP7hHd8Z
         LSkixAya2YnWx43Fdl6dcOZNzEduVjufAAHRyvE6upogf9+5r0OtL+7rpm2DjM0pEQiz
         Y+XQnhSvVFWFRvtBhnd5RqCgFMEcqTqWkzzdrzoKFm5lEjgFH0L1jXSPw5TRUvYJ1tRJ
         vZ94Y9PXsrmvjsownQJlosltbwEql/e2VwxI1ITztQdKdlBxNkOMo7zKOyyiMfhAcNet
         ppWBs8vV5FhocJHUyYUYOGyj7v1pXJYv8sPMtu7/nce0s6UYzHIolDf/YiKSa7jEUJ6h
         /NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131735; x=1723736535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcoE8Vm+b4KAFn+fyVtticOIj4/Y4kdiFjtGog1FQeU=;
        b=BlYGzjbQyP26qDc6PtyEBwK69I9AsolOCHKgR7UmxoqJ74Sd2qmjckrF+imhrf47Co
         B4zlC8LdGEEovgNXPxSOSLanIVdYZ5gQQ6i3czHkimN14XohPIekkBR1tkPGRwntqp7g
         +K5QShbRbl11Uy2lHM4BtEZJYBBwGWURvBJA3dvKkaP1SPQHWthwnj6ZP7Wg9wowjniY
         JaMbinz1aHjFuNWQFRxW7WmKh7CcPU2q9gHH+FDS/mWbbBiL/272FosczQ1ImWWHPpKB
         dJKch1EEbPOhr32W/u62XRBXAmf8fWAexAHw3EcaLC3StDRPj1QqBL6YEXTEuxnv4mfg
         7+lw==
X-Gm-Message-State: AOJu0YxnLtf+RKEKk36y23bpwHnYPCPYxhPhldkVSmmU3cryCKinf8bE
	TIY50Fx04s+OwT2D++8n0eCizDjzVSWQzrqX6p2sGxQZSsZyZqexG1eiL/Z29/4=
X-Google-Smtp-Source: AGHT+IHbhG8YN6BTiZR5q95KrA/4521tkm0PsBJk+fcQYlI0l7eLDNE33CmFyYhqN8mQHxjIoIhfNg==
X-Received: by 2002:a17:902:ea08:b0:1fb:5574:7554 with SMTP id d9443c01a7336-20095263196mr28781845ad.28.1723131734957;
        Thu, 08 Aug 2024 08:42:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::7:bc6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905fecbsm126559435ad.172.2024.08.08.08.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 08:42:14 -0700 (PDT)
Message-ID: <45a6ddd7-886e-4d48-a57c-21d948390d56@davidwei.uk>
Date: Thu, 8 Aug 2024 08:42:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 6/6] bnxt_en: only set dev->queue_mgmt_ops if
 supported by FW
Content-Language: en-GB
To: Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Michael Chan <michael.chan@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>
References: <20240808051518.3580248-1-dw@davidwei.uk>
 <20240808051518.3580248-7-dw@davidwei.uk>
 <CAMArcTX_BDeFQv4OkOk6FLdaoEaS6VQyv6wijUPoQNPCy456zg@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAMArcTX_BDeFQv4OkOk6FLdaoEaS6VQyv6wijUPoQNPCy456zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-08-08 08:13, Taehee Yoo wrote:
> On Thu, Aug 8, 2024 at 2:16 PM David Wei <dw@davidwei.uk> wrote:
>>
> Hi David,
> Thank you so much for this work!
> 
>> The queue API calls bnxt_hwrm_vnic_update() to stop/start the flow of
>> packets, which can only properly flush the pipeline if FW indicates
>> support.
>>
>> Add a macro BNXT_SUPPORTS_QUEUE_API that checks for the required flags
>> and only set queue_mgmt_ops if true.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
>> drivers/net/ethernet/broadcom/bnxt/bnxt.h | 3 +++
>> 2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index 7762fa3b646a..85d4fa8c73ae 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -15717,7 +15717,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>> dev->stat_ops = &bnxt_stat_ops;
>> dev->watchdog_timeo = BNXT_TX_TIMEOUT;
>> dev->ethtool_ops = &bnxt_ethtool_ops;
>> - dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
>> pci_set_drvdata(pdev, dev);
>>
>> rc = bnxt_alloc_hwrm_resources(bp);
>> @@ -15898,6 +15897,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>
>> if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
>> bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
>> + if (BNXT_SUPPORTS_QUEUE_API(bp))
>> + dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
>>
>> rc = register_netdev(dev);
>> if (rc)
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> index a2233b2d9329..62e637c5be31 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> @@ -2451,6 +2451,9 @@ struct bnxt {
>> #define BNXT_SUPPORTS_MULTI_RSS_CTX(bp) \
>> (BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) && \
>> ((bp)->rss_cap & BNXT_RSS_CAP_MULTI_RSS_CTX))
>> +#define BNXT_SUPPORTS_QUEUE_API(bp) \
>> + (BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) && \
>> + ((bp)->fw_cap & BNXT_FW_CAP_VNIC_RE_FLUSH))
>>
>> u32 hwrm_spec_code;
>> u16 hwrm_cmd_seq;
>> --
>> 2.43.5
>>
>>
> 
> What Broadcom NICs support BNXT_SUPPORTS_QUEUE_API?
> 
> I have been testing the device memory TCP feature with bnxt_en driver
> and I'm using BCM57508, BCM57608, and BCM57412 NICs.
> (BCM57508's firmware is too old, but BCM57608's firmware is the
> latest, BCM57412 too).
> Currently, I can't test the device memory TCP feature because my NICs
> don't support BNXT_SUPPORTS_QUEUE_API.
> The BCM57608 only supports the BNXT_SUPPORTS_NTUPLE_VNIC, but does not
> support the BNXT_SUPPORTS_QUEUE_API.
> The BCM57412 doesn't support both of them.
> I think at least BCM57508 and BCM57608 should support this because
> it's the same or newer product line as BCM57504 as far as I know.
> Am I missing something?

The hardware is correct (Thor+) but there needs to be a new FW update
from Broadcom that returns VNIC_QCAPS_RESP_FLAGS_RE_FLUSH_CAP when
queried.

CC: Michael Chan <michael.chan@broadcom.com>

> 
> Thanks a lot!
> Taehee Yoo

