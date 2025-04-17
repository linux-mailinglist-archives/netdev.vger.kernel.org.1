Return-Path: <netdev+bounces-183834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596FBA922D4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869C03AFDE1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C292550C4;
	Thu, 17 Apr 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UU3XN5/X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BED254850
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907825; cv=none; b=H0acSWfnVexMaNP9mxWfs11HsiyaRmFNF3otNZcuEG7WfLiqjV69LxV5sD3+3SS2MTNI5y6OLOQQHq/mHbowMXBhi8keY+kXB+WC3X4xQhpdM9su4SztuF82k6Su2B8+3arqMWAasVdQClNa7rBVrHfWLk4LbReAYwUE/JPNJNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907825; c=relaxed/simple;
	bh=ZB1x85E9TZSV27ACI1YbITPS8W7AaqTCmW3E93K4f0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qc790/Pje7gYk1+ZSt6LGZd6BWUmQCNVi7z2pHNw5+izffkLVJiYst7La78emag+SJivVKJvZ41erJNCfA4CljlmxvBnMvEDcJi7rnT1Sk63qPsZajM2eAsdjBqqP6BLIW0wNXSF8PpU9i7u5UQ7ZDFKe6Udbe/SIX3rU/nEXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UU3XN5/X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744907822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHtvPer+uhTnTZr30khXohx3R0vSZbxSNnylVoOnq58=;
	b=UU3XN5/X3jdSqu3Y2uA/QqGOcdyE+AItuWX6/gCWCCLbHQQFj7pstePci8sQjupfbfuoWw
	lJaneSakwhwnLQUxRVepRYIw4O7JUdXFPEU7/kQ9e4aXqB9EKnTa90r9wu4Vgzv1RSbF+/
	cyph1MttaEC2T/NAIfZWoh2JUD5Znq0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-t5j63oQ2PAmH5IVFq-QmPQ-1; Thu,
 17 Apr 2025 12:36:55 -0400
X-MC-Unique: t5j63oQ2PAmH5IVFq-QmPQ-1
X-Mimecast-MFC-AGG-ID: t5j63oQ2PAmH5IVFq-QmPQ_1744907812
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6668182FF46;
	Thu, 17 Apr 2025 16:35:57 +0000 (UTC)
Received: from [10.44.33.28] (unknown [10.44.33.28])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C28A21956095;
	Thu, 17 Apr 2025 16:35:52 +0000 (UTC)
Message-ID: <76f668a7-1cd6-445b-9e62-cb314bdeefa9@redhat.com>
Date: Thu, 17 Apr 2025 18:35:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-6-ivecera@redhat.com>
 <20250417161354.GF372032@google.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250417161354.GF372032@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On 17. 04. 25 6:13 odp., Lee Jones wrote:
> On Wed, 16 Apr 2025, Ivan Vecera wrote:
> 
>> Registers present in page 10 and higher are called mailbox type
>> registers. Each page represents a mailbox and is used to read and write
>> configuration of particular object (dpll, output, reference & synth).
>>
>> The mailbox page contains mask register that is used to select an index of
>> requested object to work with and semaphore register to indicate what
>> operation is requested.
>>
>> The rest of registers in the particular register page are latch
>> registers that are filled by the firmware during read operation or by
>> the driver prior write operation.
>>
>> For read operation the driver...
>> 1) ... updates the mailbox mask register with index of particular object
>> 2) ... sets the mailbox semaphore register read bit
>> 3) ... waits for the semaphore register read bit to be cleared by FW
>> 4) ... reads the configuration from latch registers
>>
>> For write operation the driver...
>> 1) ... writes the requested configuration to latch registers
>> 2) ... sets the mailbox mask register for the DPLL to be updated
>> 3) ... sets the mailbox semaphore register bit for the write operation
>> 4) ... waits for the semaphore register bit to be cleared by FW
>>
>> Add functions to read and write mailboxes for all supported object types.
>>
>> All these functions as well as functions accessing mailbox latch registers
>> (zl3073x_mb_* functions) have to be called with zl3073x_dev->mailbox_lock
>> held and a caller is responsible to take this lock.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> v1->v3:
>> * dropped ZL3073X_MB_OP macro usage
>> ---
>>   drivers/mfd/zl3073x-core.c       | 232 +++++++++++++++++++++++
>>   include/linux/mfd/zl3073x.h      |  12 ++
>>   include/linux/mfd/zl3073x_regs.h | 304 +++++++++++++++++++++++++++++++
>>   3 files changed, 548 insertions(+)
> 
>> +/*
>> + * Mailbox operations
>> + */
>> +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index);
> 
> Why aren't these being placed into drivers/mailbox?

I think the only common thing of this with drivers/mailbox is only the
name. Mailbox (this comes from datasheet) here is just an atomic way to
read or write some range of registers.

How can be that used here?

Ivan


