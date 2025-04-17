Return-Path: <netdev+bounces-183688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE5A9189E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66DEB7AF5AC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484422A4EC;
	Thu, 17 Apr 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zj0mc2Mz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A62229B1F
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884140; cv=none; b=pJhmtxvzSgHnrKeEw+krNS5E2KkAcAflD85GrKtKBM60DKFSPLMgFeCGMtzNAqbCiAuqJnDadq3kiLkgEFAVVvjxjNljcFjB6io9yKu6DSppOtJvNCBVeOQbA4/LHDjweRx+aGl0UIr3i936hrH2yJD4jhg/cjxRk8XA4AVa4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884140; c=relaxed/simple;
	bh=nXDID1eMf4+9FTefmpLhDygBj6jexx1U5/4QE4JA044=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GcUjfg0olDU5NueNsoUP3WKZU/wD1MjEmjUh84FDK9R2HKSD8wxJos7ZQr/2nXyt+pSb3K3ngWzltlmhK4VBaOwd1NihpPnoLT/QMu+dzVQKB266qM7E0ovXeJlhV3Zlru3todZKKl39h/CrEML0LAbfDgolRWt4sSe3EHoghnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zj0mc2Mz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744884137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yI0SZWzvsCLbIwOjEZSyeILvw7T7+gy7laNbgKsObFs=;
	b=Zj0mc2MzLgiUqQp86HgpSoIDDJfpLKFO9vp5eUiO+noDGXK/etdTMJiAJpLwVaS7wR2tLD
	Cyz3SrauYbPq4YvHqXeBnNEJnM3lzBFPNRV4xFDkSZnSdTISyrggbEgdFiuCJZA71slRIF
	mZ/Sb3jHTPWSYUv8IAH/8FmSC1wXwE4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-Kzb09-GOOyCBMq31B9DTKQ-1; Thu,
 17 Apr 2025 06:02:14 -0400
X-MC-Unique: Kzb09-GOOyCBMq31B9DTKQ-1
X-Mimecast-MFC-AGG-ID: Kzb09-GOOyCBMq31B9DTKQ_1744884132
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA2E019560AE;
	Thu, 17 Apr 2025 10:02:11 +0000 (UTC)
Received: from [10.44.33.28] (unknown [10.44.33.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6654B30002C2;
	Thu, 17 Apr 2025 10:02:05 +0000 (UTC)
Message-ID: <e22193d6-8d00-4dbc-99be-55a9d6429730@redhat.com>
Date: Thu, 17 Apr 2025 12:02:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
From: Ivan Vecera <ivecera@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-6-ivecera@redhat.com>
 <d286dec9-a544-409d-bf62-d2b84ef6ecd4@lunn.ch>
 <CAAVpwAvVO7RGLGMXCBxCD35kKCLmZEkeXuERG0C2GHP54kCGJw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAAVpwAvVO7RGLGMXCBxCD35kKCLmZEkeXuERG0C2GHP54kCGJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 16. 04. 25 8:27 odp., Ivan Vecera wrote:
> On Wed, Apr 16, 2025 at 7:32 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>>> +/**
>>> + * zl3073x_mb_dpll_read - read given DPLL configuration to mailbox
>>> + * @zldev: pointer to device structure
>>> + * @index: DPLL index
>>> + *
>>> + * Reads configuration of given DPLL into DPLL mailbox.
>>> + *
>>> + * Context: Process context. Expects zldev->regmap_lock to be held by caller.
>>> + * Return: 0 on success, <0 on error
>>> + */
>>> +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index)
>>> +{
>>> +     int rc;
>>
>> lockdep_assert_held(zldev->regmap_lock) is stronger than having a
>> comment. When talking about i2c and spi devices, it costs nothing, and
>> catches bugs early.
> 
> Makes sense to put the assert here...
> 
> Will add.
> 
>>
>>> +/*
>>> + * Mailbox operations
>>> + */
>>> +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index);
>>> +int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index);
>>> +int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index);
>>> +int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index);
>>> +int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index);
>>> +int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
>>> +int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index);
>>> +int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index);
>>
>> I assume these are the only valid ways to access a mailbox?
>>
>> If so:
>>
>>> +static inline __maybe_unused int
>>> +zl3073x_mb_read_ref_mb_mask(struct zl3073x_dev *zldev, u16 *value)
>>> +{
>>> +     __be16 temp;
>>> +     int rc;
>>> +
>>> +     lockdep_assert_held(&zldev->mailbox_lock);
>>> +     rc = regmap_bulk_read(zldev->regmap, ZL_REG_REF_MB_MASK, &temp,
>>> +                           sizeof(temp));
>>> +     if (rc)
>>> +             return rc;
>>> +
>>> +     *value = be16_to_cpu(temp);
>>> +     return rc;
>>> +}
>>
>> These helpers can be made local to the core. You can then drop the
>> lockdep_assert_held() from here, since the only way to access them is
>> via the API you defined above, and add the checks in those API
>> functions.
> 
> This cannot be done this way... the above API just simplifies the
> operation of read and write latch registers from/to mailbox.
> 
> Whole operation is described in the commit description.
> 
> E.g. read something about DPLL1
> 1. Call zl3073x_mb_dpll_read(..., 1)
>     This selects DPLL1 in the DPLL mailbox and performs read operation
> and waits for finish
> 2. Call zl3073x_mb_read_dpll_mode()
>     This reads dpll_mode latch register
> 
> write:
> 1. Call zl3073x_mb_write_dpll_mode(...)
>     This writes mode to dpll_mode latch register
> 2. Call zl3073x_mb_dpll_read(..., 1)
>     This writes all info from latch registers to DPLL1
> 
> The point is that between step 1 and 2 nobody else cannot touch
> latch_registers or mailbox select register and op semaphore.
> 

Anyway, I have a different idea... completely abstract mailboxes from 
the caller. The mailbox content can be large and the caller is barely 
interested in all registers from the mailbox but this could be resolved 
this way:

The proposed API e.g for Ref mailbox:

int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index,
                         struct zl3073x_mb_ref *mb);
int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index,
                          struct zl3073x_mb_ref *mb);

struct zl3073x_mb_ref {
	u32	flags;
	u16	freq_base;
	u16	freq_mult;
	u16	ratio_m;
	u16	ratio_n;
	u8	config;
	u64	phase_offset_compensation;
	u8	sync_ctrl;
	u32	esync_div;
}

#define ZL3073X_MB_REF_FREQ_BASE			BIT(0)
#define ZL3073X_MB_REF_FREQ_MULT			BIT(1)
#define ZL3073X_MB_REF_RATIO_M				BIT(2)
#define ZL3073X_MB_REF_RATIO_N			 	BIT(3)
#define ZL3073X_MB_REF_CONFIG			 	BIT(4)
#define ZL3073X_MB_REF_PHASE_OFFSET_COMPENSATION 	BIT(5)
#define ZL3073X_MB_REF_SYNC_CTRL			BIT(6)
#define ZL3073X_MB_REF_ESYNC_DIV			BIT(7)

Then a reader can read this way (read freq and ratio of 3rd ref):
{
	struct zl3073x_mb_ref mb;
	...
	mb.flags = ZL3073X_MB_REF_FREQ_BASE |
		   ZL3073X_MB_REF_FREQ_MULT |
		   ZL3073X_MB_REF_RATIO_M |
		   ZL3073X_MB_REF_RATIO_N;
	rc = zl3073x_mb_ref_read(zldev, 3, &mb);
	if (rc)
		return rc;
	/* at this point mb fields requested via flags are filled */
}
A writer similarly (write config of 5th ref):
{
	struct zl3073x_mb_ref mb;
	...
	mb.flags = ZL3073X_MB_REF_CONFIG;
	mb.config = FIELD_PREP(SOME_MASK, SOME_VALUE);
	rc = zl3073x_mb_ref_write(zldev, 5, &mb);
	...
	/* config of 5th ref was commited */
}

The advantages:
* no explicit locking required from the callers
* locking is done inside mailbox API
* each mailbox type can have different mutex so multiple calls for
   different mailbox types (e.g ref & output) can be done in parallel

WDYT about this approach?

Thanks,
Ivan


