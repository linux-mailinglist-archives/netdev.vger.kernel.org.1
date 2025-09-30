Return-Path: <netdev+bounces-227237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B8CBAAD41
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 02:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6471C3C5754
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 00:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38568194A44;
	Tue, 30 Sep 2025 00:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyD4BjY6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1813C8E8;
	Tue, 30 Sep 2025 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759193578; cv=none; b=iBaVEmw5urQqoU5EwjbzSQrS4epeEYF888XCx32ZcAySfW5DkdIX7GTp5bo6T40gvmeaa6u1N63X3at9pNfO8PX1GrKn4gnr1AwmeSXCjN6NMDtjnh7AFFuUqpS99x5/pHb4nlaj+2Ovbephxu0yQNlD7g4lgTrCzmdUdzeDiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759193578; c=relaxed/simple;
	bh=Yvps5hwFerLT6bd1RFgeCwnLtqFL1UGfC82LJio6fsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jbi4aeaEdxmAH7K8QR67dtpVO8dG9oQneBTJi9F/aAksn4DcOvjGvFSqUTb8Mw/l8uGLNNu7/2hvgDDXH6ThGzusr5drGGn7n0/5kybb+9GMfBGXVgRQPs7iDpStH/0dN58YZXKLxTwk+vRjvjD5YLoGCu/XEYgb6aTtMIEpLYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyD4BjY6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759193576; x=1790729576;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Yvps5hwFerLT6bd1RFgeCwnLtqFL1UGfC82LJio6fsk=;
  b=DyD4BjY6XqGBxs62jDKcC9uA+2iKhdMLFgu86cDMFK4Iv2tgLJyNXGCh
   oSE9T8Y4RAN/OeZX0ui0TMb9T5rc651q+Q6eYInCdXIo57eziFRhvws1I
   shsm6+SLRy6l3+3g+/zA/6v5kuUaLxzYvMz5aM51tzYO4BLWH7uEJuqwG
   xqIrGmWAlX3T/hA8EdUvF8THOZffl9dWlSXhoLZKyHjVNSJHlvFemvEOS
   PliLRNXh8SmZ4FhmJvjhRH8Nl+qPc+U+12A4tr6TPJ3qqkzNglkUyprCh
   lA5pEIIyALrrXQgc657zSTytMaBRdYjGSM8qYH/JtpikoAFhyp83ykP4N
   g==;
X-CSE-ConnectionGUID: z0/tDIc+Q86TbXkdMzG6rw==
X-CSE-MsgGUID: V6Cz3nQ9R4+7EsquZ3Rn7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65299536"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="65299536"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 17:52:55 -0700
X-CSE-ConnectionGUID: Sr/+ywcBT+6bBQy20LmCSg==
X-CSE-MsgGUID: Hwet3pKHQpOzILUkryFx0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="182662503"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.109.142]) ([10.125.109.142])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 17:52:55 -0700
Message-ID: <df18f0bb-0939-492a-8c5e-bc9e35260535@intel.com>
Date: Mon, 29 Sep 2025 17:52:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 16/20] cxl: Allow region creation by type2 drivers
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-17-alejandro.lucero-palau@amd.com>
 <a3138cd0-455c-4247-be4e-c8f4f2c71e33@intel.com>
 <1f0e2207-8d99-4eb8-880b-8ba859f8e86a@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <1f0e2207-8d99-4eb8-880b-8ba859f8e86a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/26/25 1:59 AM, Alejandro Lucero Palau wrote:
> 
> On 9/19/25 21:59, Dave Jiang wrote:
>>
>> On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Creating a CXL region requires userspace intervention through the cxl
>>> sysfs files. Type2 support should allow accelerator drivers to create
>>> such cxl region from kernel code.
>>>
>>> Adding that functionality and integrating it with current support for
>>> memory expanders.
>>>
>>> Support an action by the type2 driver to be linked to the created region
>>> for unwinding the resources allocated properly.
>>>
>>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/region.c | 154 ++++++++++++++++++++++++++++++++++++--
>>>   drivers/cxl/port.c        |   5 +-
>>>   include/cxl/cxl.h         |   4 +
>>>   3 files changed, 154 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 7b05e41e8fad..20bd0c82806c 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -2379,6 +2379,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>>>       }
>>>       return 0;
>>>   }
>>> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
>>>     static int __attach_target(struct cxl_region *cxlr,
>>>                  struct cxl_endpoint_decoder *cxled, int pos,
>>> @@ -2864,6 +2865,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>>>       return to_cxl_region(region_dev);
>>>   }
>>>   +static void drop_region(struct cxl_region *cxlr)
>>> +{
>>> +    struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>> +    struct cxl_port *port = cxlrd_to_port(cxlrd);
>>> +
>>> +    devm_release_action(port->uport_dev, unregister_region, cxlr);
>>> +}
>>> +
>>>   static ssize_t delete_region_store(struct device *dev,
>>>                      struct device_attribute *attr,
>>>                      const char *buf, size_t len)
>>> @@ -3592,14 +3601,12 @@ static int __construct_region(struct cxl_region *cxlr,
>>>       return 0;
>>>   }
>>>   -/* Establish an empty region covering the given HPA range */
>>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>> -                       struct cxl_endpoint_decoder *cxled)
>>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>>> +                         struct cxl_endpoint_decoder *cxled)
>>>   {
>>>       struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>> -    struct cxl_port *port = cxlrd_to_port(cxlrd);
>>>       struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>> -    int rc, part = READ_ONCE(cxled->part);
>>> +    int part = READ_ONCE(cxled->part);
>>>       struct cxl_region *cxlr;
>>>         do {
>>> @@ -3608,13 +3615,24 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>                          cxled->cxld.target_type);
>>>       } while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>>   -    if (IS_ERR(cxlr)) {
>>> +    if (IS_ERR(cxlr))
>>>           dev_err(cxlmd->dev.parent,
>>>               "%s:%s: %s failed assign region: %ld\n",
>>>               dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>>               __func__, PTR_ERR(cxlr));
>>> -        return cxlr;
>>> -    }
>>> +
>>> +    return cxlr;
>>> +}
>>> +
>>> +/* Establish an empty region covering the given HPA range */
>>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>> +                       struct cxl_endpoint_decoder *cxled)
>>> +{
>>> +    struct cxl_port *port = cxlrd_to_port(cxlrd);
>>> +    struct cxl_region *cxlr;
>>> +    int rc;
>>> +
>>> +    cxlr = construct_region_begin(cxlrd, cxled);
>>>         rc = __construct_region(cxlr, cxlrd, cxled);
>>>       if (rc) {
>>> @@ -3625,6 +3643,126 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>       return cxlr;
>>>   }
>>>   +static struct cxl_region *
>>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>>> +               struct cxl_endpoint_decoder **cxled, int ways)
>>> +{
>>> +    struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
>>> +    struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>>> +    struct cxl_region_params *p;
>>> +    resource_size_t size = 0;
>>> +    struct cxl_region *cxlr;
>>> +    int rc, i;
>>> +
>>> +    cxlr = construct_region_begin(cxlrd, cxled[0]);
>>> +    if (IS_ERR(cxlr))
>>> +        return cxlr;
>>> +
>>> +    guard(rwsem_write)(&cxl_rwsem.region);
>>> +
>>> +    /*
>>> +     * Sanity check. This should not happen with an accel driver handling
>>> +     * the region creation.
>>> +     */
>>> +    p = &cxlr->params;
>>> +    if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>>> +        dev_err(cxlmd->dev.parent,
>>> +            "%s:%s: %s  unexpected region state\n",
>>> +            dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
>>> +            __func__);
>>> +        rc = -EBUSY;
>>> +        goto err;
>>> +    }
>>> +
>>> +    rc = set_interleave_ways(cxlr, ways);
>>> +    if (rc)
>>> +        goto err;
>>> +
>>> +    rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>>> +    if (rc)
>>> +        goto err;
>>> +
>>> +    scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>>> +        for (i = 0; i < ways; i++) {
>>> +            if (!cxled[i]->dpa_res)
>>> +                break;
>>> +            size += resource_size(cxled[i]->dpa_res);
>>> +        }
>>> +    }
>> Does the dpa read lock needs to be held from the first one to this one? Is there concern that the cxled may change during the time the lock is released and acquired again?
>>
>> DJ
> 
> 
> Not sure I understand the first question, but IMO, this is related to more complex setups than current Type2 expectations. I expect a single CXL Type2 device and without interleaving. This protection is needed for a cxl region backed by several CXL devices (interleaving) and where user space could try things in the middle of this setup.

So it takes the dpa rwsem above, and then it takes the rwsem again later below. Should the rwsem be held instead of given up and acquired again?

DJ

> 
> 
>>> +
>>> +    if (i < ways)
>>> +        goto err;
>>> +
>>> +    rc = alloc_hpa(cxlr, size);
>>> +    if (rc)
>>> +        goto err;
>>> +
>>> +    scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>>> +        for (i = 0; i < ways; i++) {
>>> +            rc = cxl_region_attach(cxlr, cxled[i], 0);
>>> +            if (rc)
>>> +                goto err;
>>> +        }
>>> +    }
>>> +
>>> +    if (rc)
>>> +        goto err;
>>> +
>>> +    rc = cxl_region_decode_commit(cxlr);
>>> +    if (rc)
>>> +        goto err;
>>> +
>>> +    p->state = CXL_CONFIG_COMMIT;
>>> +
>>> +    return cxlr;
>>> +err:
>>> +    drop_region(cxlr);
>>> +    return ERR_PTR(rc);
>>> +}
>>> +
>>> +/**
>>> + * cxl_create_region - Establish a region given an endpoint decoder
>>> + * @cxlrd: root decoder to allocate HPA
>>> + * @cxled: endpoint decoder with reserved DPA capacity
>>> + * @ways: interleave ways required
>>> + * @action: driver function to be called on region removal
>>> + * @data: pointer to data structure for the action execution
>>> + *
>>> + * Returns a fully formed region in the commit state and attached to the
>>> + * cxl_region driver.
>>> + */
>>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>> +                     struct cxl_endpoint_decoder **cxled,
>>> +                     int ways, void (*action)(void *),
>>> +                     void *data)
>>> +{
>>> +    struct cxl_region *cxlr;
>>> +    int rc;
>>> +
>>> +    mutex_lock(&cxlrd->range_lock);
>>> +    cxlr = __construct_new_region(cxlrd, cxled, ways);
>>> +    mutex_unlock(&cxlrd->range_lock);
>>> +    if (IS_ERR(cxlr))
>>> +        return cxlr;
>>> +
>>> +    if (device_attach(&cxlr->dev) <= 0) {
>>> +        dev_err(&cxlr->dev, "failed to create region\n");
>>> +        drop_region(cxlr);
>>> +        return ERR_PTR(-ENODEV);
>>> +    }
>>> +
>>> +    if (action) {
>>> +        rc = devm_add_action_or_reset(&cxlr->dev, action, data);
>>> +        if (rc) {
>>> +            drop_region(cxlr);
>>> +            return ERR_PTR(rc);
>>> +        }
>>> +    }
>>> +
>>> +    return cxlr;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
>>> +
>>>   static struct cxl_region *
>>>   cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>>>   {
>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>> index 83f5a09839ab..e6c0bd0fc9f9 100644
>>> --- a/drivers/cxl/port.c
>>> +++ b/drivers/cxl/port.c
>>> @@ -35,6 +35,7 @@ static void schedule_detach(void *cxlmd)
>>>   static int discover_region(struct device *dev, void *unused)
>>>   {
>>>       struct cxl_endpoint_decoder *cxled;
>>> +    struct cxl_memdev *cxlmd;
>>>       int rc;
>>>         if (!is_endpoint_decoder(dev))
>>> @@ -44,7 +45,9 @@ static int discover_region(struct device *dev, void *unused)
>>>       if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
>>>           return 0;
>>>   -    if (cxled->state != CXL_DECODER_STATE_AUTO)
>>> +    cxlmd = cxled_to_memdev(cxled);
>>> +    if (cxled->state != CXL_DECODER_STATE_AUTO ||
>>> +        cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
>>>           return 0;
>>>         /*
>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>> index 0a607710340d..dbacefff8d60 100644
>>> --- a/include/cxl/cxl.h
>>> +++ b/include/cxl/cxl.h
>>> @@ -278,4 +278,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>>>                            enum cxl_partition_mode mode,
>>>                            resource_size_t alloc);
>>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>> +                     struct cxl_endpoint_decoder **cxled,
>>> +                     int ways, void (*action)(void *),
>>> +                     void *data);
>>>   #endif /* __CXL_CXL_H__ */


