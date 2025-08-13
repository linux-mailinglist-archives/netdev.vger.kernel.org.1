Return-Path: <netdev+bounces-213329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF69B24968
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5402D8815FF
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9F1161302;
	Wed, 13 Aug 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTtS2iPI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF9194098
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087448; cv=none; b=MNZZsK4BIPVT75lJqR8n+sRkwx7wIJ2W4mkUsjvATLweDO4Gd4uLmNdDQ6YIvBwUMoTrkDax4qbBeidsYwmZZQRCYqy4Q80LNZswR8ieI8trpzSEN0x/quwWpUwFBPbFzFE5e8p38TtdLDl13vtcssgBFG9fpnE75ZbFt/iXriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087448; c=relaxed/simple;
	bh=AB3b/IJrnwByef2+fUJBem4P2v40DCn77/MIDvn5vAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXDDKzHfZOjYdVBwI3l0ZMafhp3sVp4uM75bOKzC4VAl4mmK2ASrbEAvSjyf3HzN+QSTCE7vuGlW4GsohHUtFqZB+OrPKgIBEjQsGM/ODkm5hDK133lvu+51OaYtw/JXFSPCdx6+NvWSocA2veX/+HNdrqjD6AuCEarxP2uEhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTtS2iPI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755087445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJo43ARqBGKCJmg/KNKcWAfUf5mkCGD/7g4cQgmBAnA=;
	b=gTtS2iPIKqnku7BZ+UiVGIJfM/n4orn47uoovU7E1qrgC6lqBfhC9/wwotU8EGEgpAumEe
	cDhy7D5i+WPjfoYpga2N0ffBjNUAGJvPkSibiNb4WrP7S/OkEqT0U5NOADtrIdqHOquQkh
	+sutOULC9Z7+kQ6BvLSx2TzIbM0Uz9k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-Ei8cfAujPIu5PSFZAcsHFA-1; Wed,
 13 Aug 2025 08:17:20 -0400
X-MC-Unique: Ei8cfAujPIu5PSFZAcsHFA-1
X-Mimecast-MFC-AGG-ID: Ei8cfAujPIu5PSFZAcsHFA_1755087438
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC0831956089;
	Wed, 13 Aug 2025 12:17:17 +0000 (UTC)
Received: from [10.45.224.146] (unknown [10.45.224.146])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 427BF1800280;
	Wed, 13 Aug 2025 12:17:13 +0000 (UTC)
Message-ID: <26fa02f7-c2e3-4890-887d-90aa2040d461@redhat.com>
Date: Wed, 13 Aug 2025 14:17:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/5] dpll: zl3073x: Add low-level flash
 functions
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>
References: <20250811144009.2408337-1-ivecera@redhat.com>
 <20250811144009.2408337-3-ivecera@redhat.com>
 <168315c3-48c2-40ca-be70-8967f65f1343@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <168315c3-48c2-40ca-be70-8967f65f1343@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 12. 08. 25 12:29 dop., Przemek Kitszel wrote:
> On 8/11/25 16:40, Ivan Vecera wrote:
>> To implement the devlink device flash functionality, the driver needs
>> to access both the device memory and the internal flash memory. The flash
>> memory is accessed using a device-specific program (called the flash
>> utility). This flash utility must be downloaded by the driver into
>> the device memory and then executed by the device CPU. Once running,
>> the flash utility provides a flash API to access the flash memory itself.
>>
>> During this operation, the normal functionality provided by the standard
>> firmware is not available. Therefore, the driver must ensure that DPLL
>> callbacks and monitoring functions are not executed during the flash
>> operation.
>>
>> Add all necessary functions for downloading the utility to device memory,
>> entering and exiting flash mode, and performing flash operations.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>> v2:
>> * extended 'comp_str' to 32 chars to avoid warnings related to snprintf
>> * added additional includes
>> ---
>>   drivers/dpll/zl3073x/Makefile  |   2 +-
>>   drivers/dpll/zl3073x/devlink.c |   9 +
>>   drivers/dpll/zl3073x/devlink.h |   3 +
>>   drivers/dpll/zl3073x/flash.c   | 684 +++++++++++++++++++++++++++++++++
>>   drivers/dpll/zl3073x/flash.h   |  29 ++
>>   drivers/dpll/zl3073x/regs.h    |  39 ++
>>   6 files changed, 765 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/dpll/zl3073x/flash.c
>>   create mode 100644 drivers/dpll/zl3073x/flash.h
> 
> 
>> +static int
>> +zl3073x_flash_download(struct zl3073x_dev *zldev, const char *component,
>> +               u32 addr, const void *data, size_t size,
>> +               struct netlink_ext_ack *extack)
>> +{
>> +#define CHECK_DELAY    5000 /* Check for interrupt each 5 seconds */
> 
> nit: please add ZL_ prefix

Ack, will fix.

>> +    unsigned long timeout;
>> +    const void *ptr, *end;
>> +    int rc = 0;
>> +
>> +    dev_dbg(zldev->dev, "Downloading %zu bytes to device memory at 
>> 0x%0x\n",
>> +        size, addr);
>> +
>> +    timeout = jiffies + msecs_to_jiffies(CHECK_DELAY);
>> +
>> +    for (ptr = data, end = data + size; ptr < end; ptr += 4, addr += 
>> 4) {
>> +        /* Write current word to HW memory */
>> +        rc = zl3073x_write_hwreg(zldev, addr, *(const u32 *)ptr);
>> +        if (rc) {
>> +            ZL_FLASH_ERR_MSG(zldev, extack,
>> +                     "failed to write to memory at 0x%0x",
>> +                     addr);
>> +            return rc;
>> +        }
>> +
>> +        /* Check for pending interrupt each 5 seconds */
> 
> nit: comment seems too trivial (and ~repeats the above one)

Ack, will remove

>> +        if (time_after(jiffies, timeout)) {
>> +            if (signal_pending(current)) {
>> +                ZL_FLASH_ERR_MSG(zldev, extack,
>> +                         "Flashing interrupted");
>> +                return -EINTR;
>> +            }
>> +
>> +            timeout = jiffies + msecs_to_jiffies(CHECK_DELAY);
>> +        }
>> +
>> +        /* Report status each 1 kB block */
>> +        if ((ptr - data) % 1024 == 0)
>> +            zl3073x_devlink_flash_notify(zldev, "Downloading image",
>> +                             component, ptr - data,
>> +                             size);
>> +    }
>> +
>> +    zl3073x_devlink_flash_notify(zldev, "Downloading image", component,
>> +                     ptr - data, size);
>> +
>> +    dev_dbg(zldev->dev, "%zu bytes downloaded to device memory\n", 
>> size);
>> +
>> +    return rc;
>> +}
>> +
> 
> 
>> +/**
>> + * zl3073x_flash_wait_ready - Check or wait for utility to be ready 
>> to flash
>> + * @zldev: zl3073x device structure
>> + * @timeout_ms: timeout for the waiting
>> + *
>> + * Return: 0 on success, <0 on error
>> + */
>> +static int
>> +zl3073x_flash_wait_ready(struct zl3073x_dev *zldev, unsigned int 
>> timeout_ms)
>> +{
>> +#define ZL_FLASH_POLL_DELAY_MS    100
>> +    unsigned long timeout;
>> +    int rc, i;
>> +
>> +    dev_dbg(zldev->dev, "Waiting for flashing to be ready\n");
>> +
>> +    timeout = jiffies + msecs_to_jiffies(timeout_ms);
> 
> this is duplicated in the loop init below

Ack, will remove this dup.

>> +
>> +    for (i = 0, timeout = jiffies + msecs_to_jiffies(timeout_ms);
>> +         time_before(jiffies, timeout);
>> +         i++) {
>> +        u8 value;
>> +
>> +        /* Check for interrupt each 1s */
>> +        if (i > 9) {
>> +            if (signal_pending(current))
>> +                return -EINTR;
>> +            i = 0;
>> +        }
>> +
>> +        /* Read write_flash register value */
>> +        rc = zl3073x_read_u8(zldev, ZL_REG_WRITE_FLASH, &value);
>> +        if (rc)
>> +            return rc;
>> +
>> +        value = FIELD_GET(ZL_WRITE_FLASH_OP, value);
>> +
>> +        /* Check if the current operation was done */
>> +        if (value == ZL_WRITE_FLASH_OP_DONE)
>> +            return 0; /* Operation was successfully done */
>> +
>> +        msleep(ZL_FLASH_POLL_DELAY_MS);
> 
> nit: needless sleep in the very last iteration step
> (a very minor issue with timeouts in range of minutes ;P)

Yes, I would not take care of 100ms delay in a minute timeout.

>> +    }
>> +
>> +    return -ETIMEDOUT;
>> +}
>> +
>> +/**
>> + * zl3073x_flash_cmd_wait - Perform flash operation and wait for finish
>> + * @zldev: zl3073x device structure
>> + * @operation: operation to perform
>> + * @extack: netlink extack pointer to report errors
>> + *
>> + * Return: 0 on success, <0 on error
>> + */
>> +static int
>> +zl3073x_flash_cmd_wait(struct zl3073x_dev *zldev, u32 operation,
>> +               struct netlink_ext_ack *extack)
>> +{
>> +#define FLASH_PHASE1_TIMEOUT_MS 60000    /* up to 1 minute */
>> +#define FLASH_PHASE2_TIMEOUT_MS 120000    /* up to 2 minutes */
> 
> nit: missing prefixes

Will fix

>> +    u8 value;
>> +    int rc;
>> +
>> +    dev_dbg(zldev->dev, "Sending flash command: 0x%x\n", operation);
>> +
>> +    /* Wait for access */
>> +    rc = zl3073x_flash_wait_ready(zldev, FLASH_PHASE1_TIMEOUT_MS);
>> +    if (rc)
>> +        return rc;
>> +
>> +    /* Issue the requested operation */
>> +    rc = zl3073x_read_u8(zldev, ZL_REG_WRITE_FLASH, &value);
>> +    if (rc)
>> +        return rc;
>> +
>> +    value &= ~ZL_WRITE_FLASH_OP;
>> +    value |= FIELD_PREP(ZL_WRITE_FLASH_OP, operation);
>> +
>> +    rc = zl3073x_write_u8(zldev, ZL_REG_WRITE_FLASH, value);
>> +    if (rc)
>> +        return rc;
>> +
>> +    /* Wait for command completion */
>> +    rc = zl3073x_flash_wait_ready(zldev, FLASH_PHASE2_TIMEOUT_MS);
>> +    if (rc)
>> +        return rc;
>> +
>> +    /* Check for utility errors */
>> +    return zl3073x_flash_error_check(zldev, extack);
>> +}
>> +
>> +/**
>> + * zl3073x_flash_get_sector_size - Get flash sector size
>> + * @zldev: zl3073x device structure
>> + * @sector_size: sector size returned by the function
>> + *
>> + * The function reads the flash sector size detected by flash utility 
>> and
>> + * stores it into @sector_size.
>> + *
>> + * Return: 0 on success, <0 on error
>> + */
>> +static int
>> +zl3073x_flash_get_sector_size(struct zl3073x_dev *zldev, size_t 
>> *sector_size)
>> +{
>> +    u8 flash_info;
>> +    int rc;
>> +
>> +    rc = zl3073x_read_u8(zldev, ZL_REG_FLASH_INFO, &flash_info);
>> +    if (rc)
>> +        return rc;
>> +
>> +    switch (FIELD_GET(ZL_FLASH_INFO_SECTOR_SIZE, flash_info)) {
>> +    case ZL_FLASH_INFO_SECTOR_4K:
>> +        *sector_size = 0x1000;
>> +        break;
>> +    case ZL_FLASH_INFO_SECTOR_64K:
>> +        *sector_size = 0x10000;
> 
> nit: up to you, but I would like to see SZ_64K instead
> (and don't count zeroes), if so, SZ_4K for the above too

Will fix.

>> +        break;
>> +    default:
>> +        rc = -EINVAL;
>> +        break;
>> +    }
>> +
>> +    return rc;
>> +}
>> +
>> +/**
>> + * zl3073x_flash_sectors - Flash sectors
>> + * @zldev: zl3073x device structure
>> + * @component: component name
>> + * @page: destination flash page
>> + * @addr: device memory address to load data
>> + * @data: pointer to data to be flashed
>> + * @size: size of data
>> + * @extack: netlink extack pointer to report errors
>> + *
>> + * The function flashes given @data with size of @size to the 
>> internal flash
>> + * memory block starting from page @page. The function uses sector flash
>> + * method and has to take into account the flash sector size reported by
>> + * flashing utility. Input data are spliced into blocks according this
>> + * sector size and each block is flashed separately.
>> + *
>> + * Return: 0 on success, <0 on error
>> + */
>> +int zl3073x_flash_sectors(struct zl3073x_dev *zldev, const char 
>> *component,
>> +              u32 page, u32 addr, const void *data, size_t size,
>> +              struct netlink_ext_ack *extack)
>> +{
>> +#define ZL_FLASH_MAX_BLOCK_SIZE    0x0001E000
>> +#define ZL_FLASH_PAGE_SIZE    256
>> +    size_t max_block_size, block_size, sector_size;
>> +    const void *ptr, *end;
>> +    int rc;
>> +
>> +    /* Get flash sector size */
>> +    rc = zl3073x_flash_get_sector_size(zldev, &sector_size);
>> +    if (rc) {
>> +        ZL_FLASH_ERR_MSG(zldev, extack,
>> +                 "Failed to get flash sector size");
>> +        return rc;
>> +    }
>> +
>> +    /* Determine max block size depending on sector size */
>> +    max_block_size = ALIGN_DOWN(ZL_FLASH_MAX_BLOCK_SIZE, sector_size);
>> +
>> +    for (ptr = data, end = data + size; ptr < end; ptr += block_size) {
> 
> block_size is uninitialized on the first loop iteration

The block_size here is used after 1st loop iteration...
> 
>> +        char comp_str[32];
>> +
>> +        block_size = min_t(size_t, max_block_size, end - ptr);

...and it is initialized here.

>> +
>> +        /* Add suffix '-partN' if the requested component size is
>> +         * greater than max_block_size.
>> +         */
>> +        if (max_block_size < size)
>> +            snprintf(comp_str, sizeof(comp_str), "%s-part%zu",
>> +                 component, (ptr - data) / max_block_size + 1);
>> +        else
>> +            strscpy(comp_str, component);
>> +
>> +        /* Download block to device memory */
>> +        rc = zl3073x_flash_download(zldev, comp_str, addr, ptr,
>> +                        block_size, extack);
>> +        if (rc)
>> +            goto finish;
>> +
>> +        /* Set address to flash from */
>> +        rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_START_ADDR, addr);
>> +        if (rc)
>> +            goto finish;
>> +
>> +        /* Set size of block to flash */
>> +        rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_SIZE, block_size);
>> +        if (rc)
>> +            goto finish;
>> +
>> +        /* Set destination page to flash */
>> +        rc = zl3073x_write_u32(zldev, ZL_REG_FLASH_INDEX_WRITE, page);
>> +        if (rc)
>> +            goto finish;
>> +
>> +        /* Set filling pattern */
>> +        rc = zl3073x_write_u32(zldev, ZL_REG_FILL_PATTERN, U32_MAX);
>> +        if (rc)
>> +            goto finish;
>> +
>> +        zl3073x_devlink_flash_notify(zldev, "Flashing image", comp_str,
>> +                         0, 0);
>> +
>> +        dev_dbg(zldev->dev, "Flashing %zu bytes to page %u\n",
>> +            block_size, page);
>> +
>> +        /* Execute sectors flash operation */
>> +        rc = zl3073x_flash_cmd_wait(zldev, ZL_WRITE_FLASH_OP_SECTORS,
>> +                        extack);
>> +        if (rc)
>> +            goto finish;
>> +
>> +        /* Move to next page */
>> +        page += block_size / ZL_FLASH_PAGE_SIZE;
>> +    }
>> +
>> +finish:
>> +    zl3073x_devlink_flash_notify(zldev,
>> +                     rc ?  "Flashing failed" : "Flashing done",
>> +                     component, 0, 0);
>> +
>> +    return rc;
>> +}
>> +
>> +/**
>> + * zl3073x_flash_page - Flash page
>> + * @zldev: zl3073x device structure
>> + * @component: component name
>> + * @page: destination flash page
>> + * @addr: device memory address to load data
>> + * @data: pointer to data to be flashed
>> + * @size: size of data
>> + * @extack: netlink extack pointer to report errors
>> + *
>> + * The function flashes given @data with size of @size to the 
>> internal flash
>> + * memory block starting with page @page.
>> + *
>> + * Return: 0 on success, <0 on error
>> + */
>> +int zl3073x_flash_page(struct zl3073x_dev *zldev, const char *component,
>> +               u32 page, u32 addr, const void *data, size_t size,
>> +               struct netlink_ext_ack *extack)
>> +{
> 
> looks like a canditate to use zl3073x_flash_sectors(), or make
> a higher-level helper that will do heavy-lifting for
> zl3073x_flash_sectors() and zl3073x_flash_page()
> (especially that you did such great job with low-level helpers)

Will refactor the common code to separate function that will be called
by both zl3073x_flash_page() and zl3073x_flash_sectors().

>> +    int rc;
>> +
>> +    /* Download component to device memory */
>> +    rc = zl3073x_flash_download(zldev, component, addr, data, size, 
>> extack);
>> +    if (rc)
>> +        goto finish;
>> +
>> +    /* Set address to flash from */
>> +    rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_START_ADDR, addr);
>> +    if (rc)
>> +        goto finish;
>> +
>> +    /* Set size of block to flash */
>> +    rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_SIZE, size);
>> +    if (rc)
>> +        goto finish;
>> +
>> +    /* Set destination page to flash */
>> +    rc = zl3073x_write_u32(zldev, ZL_REG_FLASH_INDEX_WRITE, page);
>> +    if (rc)
>> +        goto finish;
>> +
>> +    /* Set filling pattern */
>> +    rc = zl3073x_write_u32(zldev, ZL_REG_FILL_PATTERN, U32_MAX);
>> +    if (rc)
>> +        goto finish;
>> +
>> +    zl3073x_devlink_flash_notify(zldev, "Flashing image", component, 0,
>> +                     size);
>> +
>> +    /* Execute sectors flash operation */
>> +    rc = zl3073x_flash_cmd_wait(zldev, ZL_WRITE_FLASH_OP_PAGE, extack);
>> +    if (rc)
>> +        goto finish;
>> +
>> +    zl3073x_devlink_flash_notify(zldev, "Flashing image", component, 
>> size,
>> +                     size);
>> +
>> +finish:
>> +    zl3073x_devlink_flash_notify(zldev,
>> +                     rc ?  "Flashing failed" : "Flashing done",
>> +                     component, 0, 0);
>> +
>> +    return rc;
>> +}
> 
> 
>> +
>> +static int
>> +zl3073x_flash_host_ctrl_enable(struct zl3073x_dev *zldev)
>> +{
>> +    u8 host_ctrl;
>> +    int rc;
>> +
>> +    /* Read host control register */
>> +    rc = zl3073x_read_u8(zldev, ZL_REG_HOST_CONTROL, &host_ctrl);
>> +    if (rc)
>> +        return rc;
>> +
>> +    /* Enable host control */
>> +    host_ctrl &= ~ZL_HOST_CONTROL_ENABLE;
> 
> suspicious, as this line does nothing (in the context of the next one)

Will remove.

>> +    host_ctrl |= ZL_HOST_CONTROL_ENABLE;
>> +
>> +    /* Update host control register */
>> +    return zl3073x_write_u8(zldev, ZL_REG_HOST_CONTROL, host_ctrl);
>> +}
>> +
>> +/**
>> + * zl3073x_flash_mode_enter - Switch the device to flash mode
>> + * @zldev: zl3073x device structure
>> + * @util_ptr: buffer with flash utility
>> + * @util_size: size of buffer with flash utility
>> + * @extack: netlink extack pointer to report errors
>> + *
>> + * The function prepares and switches the device into flash mode.
>> + *
>> + * The procedure:
>> + * 1) Stop device CPU by specific HW register sequence
>> + * 2) Download flash utility to device memory
>> + * 3) Resume device CPU by specific HW register sequence
>> + * 4) Check communication with flash utility
>> + * 5) Enable host control necessary to access flash API
>> + * 6) Check for potential error detected by the utility
>> + *
>> + * The API provided by normal firmware is not available in flash mode
>> + * so the caller has to ensure that this API is not used in this mode.
>> + *
>> + * After performing flash operation the caller should call
>> + * @zl3073x_flash_mode_leave to return back to normal operation.
>> + *
>> + * Return: 0 on success, <0 on error.
>> + */
>> +int zl3073x_flash_mode_enter(struct zl3073x_dev *zldev, const void 
>> *util_ptr,
>> +                 size_t util_size, struct netlink_ext_ack *extack)
>> +{
>> +    /* Sequence to be written prior utility download */
>> +    static const struct zl3073x_hwreg_seq_item pre_seq[] = {
>> +        HWREG_SEQ_ITEM(0x80000400, 1, BIT(0), 0),
>> +        HWREG_SEQ_ITEM(0x80206340, 1, BIT(4), 0),
>> +        HWREG_SEQ_ITEM(0x10000000, 1, BIT(2), 0),
>> +        HWREG_SEQ_ITEM(0x10000024, 0x00000001, U32_MAX, 0),
>> +        HWREG_SEQ_ITEM(0x10000020, 0x00000001, U32_MAX, 0),
>> +        HWREG_SEQ_ITEM(0x10000000, 1, BIT(10), 1000),
>> +    };
>> +    /* Sequence to be written after utility download */
>> +    static const struct zl3073x_hwreg_seq_item post_seq[] = {
>> +        HWREG_SEQ_ITEM(0x10400004, 0x000000C0, U32_MAX, 0),
>> +        HWREG_SEQ_ITEM(0x10400008, 0x00000000, U32_MAX, 0),
>> +        HWREG_SEQ_ITEM(0x10400010, 0x20000000, U32_MAX, 0),
>> +        HWREG_SEQ_ITEM(0x10400014, 0x20000004, U32_MAX, 0),
>> +        HWREG_SEQ_ITEM(0x10000000, 1, GENMASK(10, 9), 0),
>> +        HWREG_SEQ_ITEM(0x10000020, 0x00000000, U32_MAX, 0),
>> +        HWREG_SEQ_ITEM(0x10000000, 0, BIT(0), 1000),
>> +    };
> very nice code
> 

Thanks for the review and advices.

Ivan


