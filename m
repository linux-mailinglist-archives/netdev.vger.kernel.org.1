Return-Path: <netdev+bounces-238696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E805C5E29D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D392154146A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99DB320CAF;
	Fri, 14 Nov 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKp5/jK5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877B023C8C7;
	Fri, 14 Nov 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133885; cv=none; b=btzCtc+7XCjwHno0Dz+SI0ghSS3v21kEFdOTiGFCGrzZPEPGXay0DIxc2N0qRV/RdUUVafvtSpIXYQ5BjVdBfdV5eiANIjF5lRe5u1TmC7gi4aod0Yy2tK0gcmRrn2MYqG0D71G1KKKhcMRmpgZTY9qQBd5gamjSBicrQ8F5Ckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133885; c=relaxed/simple;
	bh=BPIcm4BPS8JNbDaHuf77kx4MaMajI1d4wnZLXgFJ14o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk9hmpAd0Zv7CcQXzf2d+VrEa3v4D1WcHAVYJyNED0JTA+7SB+B4vQdA8o0wKNA7WlYKYEWo8xA64LSjm+GXRpZsDJ9p0MV6Yms8qDpWhQGkkBm2iy0i8Sd325/YE4piRCNzv+oCS3sQGQyNMgML3V9yvzdrpd+A5aOxiEfTDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKp5/jK5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763133884; x=1794669884;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BPIcm4BPS8JNbDaHuf77kx4MaMajI1d4wnZLXgFJ14o=;
  b=DKp5/jK5kJ4Xgf4GxoQqAvH/mz+Gk4AJ+ON3o2ukKnTCiqTepJMeuqEv
   7UVfjsCNg3kW5Az3TwBDgG+qgeAhn4ooL8PSccSWkXXl9HyLFiOiBg/lg
   7joQWPwkYNDxqUkoEiMUEV/17doGPx/zhpPuylSRgrz7vMRl7l4xWQjKj
   1ORIu7HGfsyO6VbIYrWF/r/AaYgFCMTEnyf9zS+2Lmb6lw4WzU8HN9AJ3
   vNm24+ths/NAkGE7b2uqnuhY2lHPJ29DakJqJ7CRYAtJp8TpLwTSn+40M
   s4HKQfejUVP6zw5LLCVNbF1J/wiEYeNUy5wHG7kPGCddfKpi73r9/+SWh
   w==;
X-CSE-ConnectionGUID: HShXmaY9QiK9JG/1AqEAcA==
X-CSE-MsgGUID: myeIAUGqSF+B8UCZEZxATA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65160988"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65160988"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 07:24:43 -0800
X-CSE-ConnectionGUID: K2Z8wWIJQ7iS0yDw6R4XTg==
X-CSE-MsgGUID: IfnXatAjQ0Sku25vLBP7KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="189094560"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 07:24:42 -0800
Message-ID: <688bd79c-91aa-4d67-8291-dd0b222bebbf@intel.com>
Date: Fri, 14 Nov 2025 08:24:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 01/22] cxl/mem: Arrange for always-synchronous memdev
 attach
To: Alejandro Lucero Palau <alucerop@amd.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-2-alejandro.lucero-palau@amd.com>
 <20251112145341.00005b4e@huawei.com>
 <374f8a2c-df06-4df9-8816-d91d3236cd58@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <374f8a2c-df06-4df9-8816-d91d3236cd58@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/14/25 4:10 AM, Alejandro Lucero Palau wrote:
> 
> On 11/12/25 14:53, Jonathan Cameron wrote:
>> On Mon, 10 Nov 2025 15:36:36 +0000
>> alejandro.lucero-palau@amd.com wrote:
>>
>>> From: Dan Williams <dan.j.williams@intel.com>
>>>
>>> In preparation for CXL accelerator drivers that have a hard dependency on
>>> CXL capability initialization, arrange for the endpoint probe result to be
>>> conveyed to the caller of devm_cxl_add_memdev().
>>>
>>> As it stands cxl_pci does not care about the attach state of the cxl_memdev
>>> because all generic memory expansion functionality can be handled by the
>>> cxl_core. For accelerators, that driver needs to know perform driver
>>> specific initialization if CXL is available, or exectute a fallback to PCIe
>>> only operation.
>>>
>>> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
>>> loading as one reason that a memdev may not be attached upon return from
>>> devm_cxl_add_memdev().
>>>
>>> The diff is busy as this moves cxl_memdev_alloc() down below the definition
>>> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
>>> preclude needing to export more symbols from the cxl_core.
>>>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Alejandro, read submitting patches again.  Whilst the first sign off should
>> indeed by Dan's this also needs one from you as a 'handler' of the patch.
>>
>> Be very careful checking these tag chains. If they are wrong no one can
>> merge the set and it just acts as a silly blocker.
> 
> 
> Hi Jonathan,
> 
> 
> I did the amend but it is true I did some work on it. Would it be enough to add my signed-off-by along with Dan's one?

Yes. Essentially whenever you are posting someone else's patches as part of your series, you need to add your sign off after theirs for those patches. Similar to I sign off all the patches I ask Linus to pull even though I did not work on them.

DJ> 
> 
>> I would have split this up and made the changes to cxl_memdev_alloc in
>> a precursor patch (use of __free is obvious one) then could have stated
>> that that was simply moved in this patch.
> 
> 
> OK. I think I was fixing a bug in original Dan's patch regarding cxlmd release in case of error inside devm_cxl_add_memdev, but I think the bug is in the current code of that function as it is not properly released if error after a successful allocation. So splitting the patch could allow to make this clearer and adding the Fixes tag as well.
> 
> 
>> There are other changes in there that are really hard to spot though
>> and I think there are some bugs lurking in error paths.
> 
> 
> I did spot one after your comment, checking cxlmd pointer is not an error pointer inside __cxlmd_free. If you spotted something else, please tell me :-)
> 
> 
> Thank you!
> 
> 
>> Jonathan
>>
>>> ---
>>>   drivers/cxl/Kconfig       |   2 +-
>>>   drivers/cxl/core/memdev.c | 101 ++++++++++++++------------------------
>>>   drivers/cxl/mem.c         |  41 ++++++++++++++++
>>>   drivers/cxl/private.h     |  10 ++++
>>>   4 files changed, 90 insertions(+), 64 deletions(-)
>>>   create mode 100644 drivers/cxl/private.h
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index e370d733e440..14b4601faf66 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -8,6 +8,7 @@
>>>   #include <linux/idr.h>
>>>   #include <linux/pci.h>
>>>   #include <cxlmem.h>
>>> +#include "private.h"
>>>   #include "trace.h"
>>>   #include "core.h"
>>>   @@ -648,42 +649,25 @@ static void detach_memdev(struct work_struct *work)
>>>     static struct lock_class_key cxl_memdev_key;
>>>   -static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>> -                       const struct file_operations *fops)
>>> +int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd)
>>>   {
>>> -    struct cxl_memdev *cxlmd;
>>> -    struct device *dev;
>>> -    struct cdev *cdev;
>>> +    struct device *dev = &cxlmd->dev;
>>> +    struct cdev *cdev = &cxlmd->cdev;
>>>       int rc;
>>>   -    cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
>>> -    if (!cxlmd)
>>> -        return ERR_PTR(-ENOMEM);
>>> -
>>> -    rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
>>> -    if (rc < 0)
>>> -        goto err;
>>> -    cxlmd->id = rc;
>>> -    cxlmd->depth = -1;
>>> -
>>> -    dev = &cxlmd->dev;
>>> -    device_initialize(dev);
>>> -    lockdep_set_class(&dev->mutex, &cxl_memdev_key);
>>> -    dev->parent = cxlds->dev;
>>> -    dev->bus = &cxl_bus_type;
>>> -    dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>>> -    dev->type = &cxl_memdev_type;
>>> -    device_set_pm_not_required(dev);
>>> -    INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>> -
>>> -    cdev = &cxlmd->cdev;
>>> -    cdev_init(cdev, fops);
>>> -    return cxlmd;
>>> +    rc = cdev_device_add(cdev, dev);
>>> +    if (rc) {
>>> +        /*
>>> +         * The cdev was briefly live, shutdown any ioctl operations that
>>> +         * saw that state.
>>> +         */
>>> +        cxl_memdev_shutdown(dev);
>>> +        return rc;
>>> +    }
>>>   -err:
>>> -    kfree(cxlmd);
>>> -    return ERR_PTR(rc);
>>> +    return devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>>>   }
>>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
>>>     static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>>>                      unsigned long arg)
>>> @@ -1051,50 +1035,41 @@ static const struct file_operations cxl_memdev_fops = {
>>>       .llseek = noop_llseek,
>>>   };
>>>   -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>> -                       struct cxl_dev_state *cxlds)
>>> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
>>>   {
>>> -    struct cxl_memdev *cxlmd;
>>> +    struct cxl_memdev *cxlmd __free(kfree) =
>>> +        kzalloc(sizeof(*cxlmd), GFP_KERNEL);
>> Trivial and perhaps not worth the hassle.
>> I'd pull this out of the declarations block to have
>>
>>       struct device *dev;
>>       struct cdev *cdev;
>>       int rc;
>>
>>     struct cxl_memdev *cxlmd __free(kfree) =
>>         kzalloc(sizeof(*cxlmd), GFP_KERNEL);
>>     if (!cxlmd)
>>         return ERR_PTR(-ENOMEM);
>>
>> That is treat the __free() related statement as an inline declaration of
>> the type we only really allow for these.
>>
>>
>>>       struct device *dev;
>>>       struct cdev *cdev;
>>>       int rc;
>>>   -    cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>>> -    if (IS_ERR(cxlmd))
>>> -        return cxlmd;
>>>   -    dev = &cxlmd->dev;
>>> -    rc = dev_set_name(dev, "mem%d", cxlmd->id);
>>> -    if (rc)
>>> -        goto err;
>>> +    if (!cxlmd)
>>> +        return ERR_PTR(-ENOMEM);
>>>   -    /*
>>> -     * Activate ioctl operations, no cxl_memdev_rwsem manipulation
>>> -     * needed as this is ordered with cdev_add() publishing the device.
>>> -     */
>>> +    rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
>>> +    if (rc < 0)
>>> +        return ERR_PTR(rc);
>>> +    cxlmd->id = rc;
>>> +    cxlmd->depth = -1;
>>>       cxlmd->cxlds = cxlds;
>>>       cxlds->cxlmd = cxlmd;
>> These two lines weren't previously in cxl_memdev_alloc()
>> I'd like a statement in the commit message of why they are now. It seems
>> harmless because they are still ordered before the add and are
>> ultimately freed
>>
>> I'm not immediately spotting why they now are.  This whole code shift
>> and complex diff is enough of a pain I'd be tempted to do the move first
>> so that we can then see what is actually changed much more easily.
>>
>>
>>>   -    cdev = &cxlmd->cdev;
>>> -    rc = cdev_device_add(cdev, dev);
>>> -    if (rc)
>>> -        goto err;
>>> -
>>> -    rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>>> -    if (rc)
>>> -        return ERR_PTR(rc);
>>> -    return cxlmd;
>>> +    dev = &cxlmd->dev;
>>> +    device_initialize(dev);
>>> +    lockdep_set_class(&dev->mutex, &cxl_memdev_key);
>>> +    dev->parent = cxlds->dev;
>>> +    dev->bus = &cxl_bus_type;
>>> +    dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>>> +    dev->type = &cxl_memdev_type;
>>> +    device_set_pm_not_required(dev);
>>> +    INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>>   -err:
>>> -    /*
>>> -     * The cdev was briefly live, shutdown any ioctl operations that
>>> -     * saw that state.
>>> -     */
>>> -    cxl_memdev_shutdown(dev);
>>> -    put_device(dev);
>>> -    return ERR_PTR(rc);
>>> +    cdev = &cxlmd->cdev;
>>> +    cdev_init(cdev, &cxl_memdev_fops);
>>> +    return_ptr(cxlmd);
>>>   }
>>> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
>>>     static void sanitize_teardown_notifier(void *data)
>>>   {
>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>> index d2155f45240d..fa5d901ee817 100644
>>> --- a/drivers/cxl/mem.c
>>> +++ b/drivers/cxl/mem.c
>>> @@ -7,6 +7,7 @@
>>>     #include "cxlmem.h"
>>>   #include "cxlpci.h"
>>> +#include "private.h"
>>>     /**
>>>    * DOC: cxl mem
>>> @@ -202,6 +203,45 @@ static int cxl_mem_probe(struct device *dev)
>>>       return devm_add_action_or_reset(dev, enable_suspend, NULL);
>>>   }
>>>   +static void __cxlmd_free(struct cxl_memdev *cxlmd)
>>> +{
>>> +    cxlmd->cxlds->cxlmd = NULL;
>>> +    put_device(&cxlmd->dev);
>>> +    kfree(cxlmd);
>>> +}
>>> +
>>> +DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
>>> +
>>> +/**
>>> + * devm_cxl_add_memdev - Add a CXL memory device
>>> + * @host: devres alloc/release context and parent for the memdev
>>> + * @cxlds: CXL device state to associate with the memdev
>>> + *
>>> + * Upon return the device will have had a chance to attach to the
>>> + * cxl_mem driver, but may fail if the CXL topology is not ready
>>> + * (hardware CXL link down, or software platform CXL root not attached)
>>> + */
>>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>> +                       struct cxl_dev_state *cxlds)
>>> +{
>>> +    struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds);
>>> +    int rc;
>>> +
>>> +    if (IS_ERR(cxlmd))
>>> +        return cxlmd;
>>> +
>>> +    rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
>>> +    if (rc)
>>> +        return ERR_PTR(rc);
>>> +
>>> +    rc = devm_cxl_memdev_add_or_reset(host, cxlmd);
>>> +    if (rc)
>>> +        return ERR_PTR(rc);
>> Is the reference tracking right here?  If the above call fails
>> then it is possible cxl_memdev_unregister() has been called
>> or just cxl_memdev_shutdown().
>>
>> If nothing else (and I suspect there is worse but haven't
>> counted references) that will set
>> cxlmd->cxlds = NULL;
>> s part of cxl_memdev_shutdown()
>> The __cxlmd_free() then dereferences that and boom.
>>
>>
>>> +
>>> +    return no_free_ptr(cxlmd);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");


