Return-Path: <netdev+bounces-213332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC89BB249AE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E2B7AEAD6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CE92E11AE;
	Wed, 13 Aug 2025 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEPW4mhv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3C2D6401
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089052; cv=none; b=b+h8QxROavxw3ZQEgU75N6x1Ng3a18EWSpJCZvrZMtfMdvRHWBgQIuckQcDrOuvlvbDePgEBiOACs5ZbGpOqxc12LXtnuKKam7+R0olfhQVb0NREdRQfyBk4WHyk5kml7g/1SNVl7a0/69RxYYf3DEiBFTntH9VxnjPXwJ0CDh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089052; c=relaxed/simple;
	bh=OQ9wDXAUkHJft+ZmwiIr5a/xqK19PnDlqBPLH5O0T3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gF+VlxwNslJzoBVI7XrxlK8lBLjnLSWYCy1+14zjOOzYUulx2GZalHvfxNGD0ncQK0bcnoN1gkcPM0Os2I73goJHj3kbjVXHIGM3J6nRslCGeEqwvi1yBJAy1fVz0tNa3F0CdVgPwShPvZ+nVb9XVCv/DQjLpHWO2CmTQCjsvto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEPW4mhv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755089049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SaZ60ktydNak/kEhmaAG3tvsj+JZQVwyqYrBS19jQgY=;
	b=MEPW4mhvuMHpBBe1ufdQ248uR0JE6ZXkR9mlMAbloJC+R25rFIqtBwM4ybaJLUT0WxVoGy
	VGTwk9Feg2znIbfLqsibnv5rmGs9qWfLvMVLaDM430Ts7fasY5UaroWEEFdBHCbrapw42a
	vuyYekCIgJXJe2xki1TPjaY9umfb1Zk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-cC0pAQdPPFKveY2cPj_fkQ-1; Wed,
 13 Aug 2025 08:44:06 -0400
X-MC-Unique: cC0pAQdPPFKveY2cPj_fkQ-1
X-Mimecast-MFC-AGG-ID: cC0pAQdPPFKveY2cPj_fkQ_1755089044
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4CAA180035F;
	Wed, 13 Aug 2025 12:44:03 +0000 (UTC)
Received: from [10.45.224.146] (unknown [10.45.224.146])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DF55195608F;
	Wed, 13 Aug 2025 12:43:59 +0000 (UTC)
Message-ID: <bad448ab-15dc-46de-983c-56fa6dfb758f@redhat.com>
Date: Wed, 13 Aug 2025 14:43:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] dpll: zl3073x: Add firmware loading
 functionality
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>
References: <20250811144009.2408337-1-ivecera@redhat.com>
 <20250811144009.2408337-4-ivecera@redhat.com>
 <17492545-4a71-4809-ad19-f7e54139415e@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <17492545-4a71-4809-ad19-f7e54139415e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 12. 08. 25 1:11 dop., Przemek Kitszel wrote:
> On 8/11/25 16:40, Ivan Vecera wrote:
>> Add functionality for loading firmware files provided by the vendor
>> to be flashed into the device's internal flash memory. The firmware
>> consists of several components, such as the firmware executable itself,
>> chip-specific customizations, and configuration files.
>>
>> The firmware file contains at least a flash utility, which is executed
>> on the device side, and one or more flashable components. Each component
>> has its own specific properties, such as the address where it should be
>> loaded during flashing, one or more destination flash pages, and
>> the flashing method that should be used.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>> v2:
>> * added additional includes
>> * removed empty line
>> * '*(dst+len)' -> '*(dst + len)'
>> * 'Santity' -> 'Sanity'
>> * fixed smatch warning about uninitialized 'rc'
>> ---
>>   drivers/dpll/zl3073x/Makefile |   2 +-
>>   drivers/dpll/zl3073x/fw.c     | 498 ++++++++++++++++++++++++++++++++++
>>   drivers/dpll/zl3073x/fw.h     |  52 ++++
>>   3 files changed, 551 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/dpll/zl3073x/fw.c
>>   create mode 100644 drivers/dpll/zl3073x/fw.h
>>
> 
> overview:
> I don't like zl3073x_fw_readline() and it's usage - sscanf will do IMO
> 
> please find other feedback inline
> 
>> +/* Sanity check */
>> +static_assert(ARRAY_SIZE(component_info) == ZL_FW_NUM_COMPONENTS);
>> +
>> +/**
>> + * zl3073x_fw_readline - Read next line from firmware
>> + * @dst: destination buffer
>> + * @dst_sz: destination buffer size
>> + * @psrc: source buffer
>> + * @psrc_sz: source buffer size
>> + *
>> + * The function read next line from the firmware buffer specified by 
>> @psrc
>> + * and @psrc_sz and stores it into buffer specified by @dst and @dst_sz.
>> + * The pointer @psrc and remaining bytes in @psrc_sz are updated 
>> accordingly.
>> + *
>> + * Return: number of characters read on success, -EINVAL on error
>> + */
>> +static ssize_t
>> +zl3073x_fw_readline(char *dst, size_t dst_sz, const char **psrc,
>> +            size_t *psrc_sz)
>> +{
>> +    const char *ptr = *psrc;
>> +    size_t len;
>> +
>> +    /* Skip any existing new-lines at the beginning */
>> +    ptr = memchr_inv(*psrc, '\n', *psrc_sz);
>> +    if (ptr) {
>> +        *psrc_sz -= ptr - *psrc;
>> +        *psrc = ptr;
>> +    }
>> +
>> +    /* Now look for the next new-line in the source */
>> +    ptr = memscan((void *)*psrc, '\n', *psrc_sz);
>> +    len = ptr - *psrc;
>> +
>> +    /* Return error if the source line is too long for destination */
>> +    if (len >= dst_sz)
>> +        return -EINVAL;
>> +
>> +    /* Copy the line from source and append NUL char  */
>> +    memcpy(dst, *psrc, len);
>> +    *(dst + len) = '\0';
>> +
>> +    *psrc = ptr;
>> +    *psrc_sz -= len;
>> +
>> +    /* Return number of read chars */
>> +    return len;
>> +}
>> +
>> +/**
>> + * zl3073x_fw_component_alloc - Alloc structure to hold firmware 
>> component
>> + * @size: size of buffer to store data
>> + *
>> + * Return: pointer to allocated component structure or NULL on error.
>> + */
>> +static struct zl3073x_fw_component *
>> +zl3073x_fw_component_alloc(size_t size)
>> +{
>> +    struct zl3073x_fw_component *comp;
>> +
>> +    comp = kzalloc(sizeof(*comp), GFP_KERNEL);
>> +    if (!comp)
>> +        return NULL;
>> +
>> +    comp->size = size;
>> +    comp->data = kzalloc(size, GFP_KERNEL);
>> +    if (!comp->data) {
>> +        kfree(comp);
>> +        return NULL;
>> +    }
>> +
>> +    return comp;
>> +}
>> +
>> +/**
>> + * zl3073x_fw_component_free - Free allocated component structure
>> + * @comp: pointer to allocated component
>> + */
>> +static void
>> +zl3073x_fw_component_free(struct zl3073x_fw_component *comp)
>> +{
>> +    if (comp)
>> +        kfree(comp->data);
>> +
>> +    kfree(comp);
>> +}
>> +
>> +/**
>> + * zl3073x_fw_component_id_get - Get ID for firmware component name
>> + * @name: input firmware component name
>> + *
>> + * Return:
>> + * - ZL3073X_FW_COMPONENT_* ID for known component name
>> + * - ZL3073X_FW_COMPONENT_INVALID if the given name is unknown
>> + */
>> +static enum zl3073x_fw_component_id
>> +zl3073x_fw_component_id_get(const char *name)
>> +{
>> +    enum zl3073x_fw_component_id id;
>> +
>> +    for (id = ZL_FW_COMPONENT_UTIL; id < ZL_FW_NUM_COMPONENTS; id++)
> 
> I would type the start as "id = 0"
> (as you did in other functions, eg zl3073x_fw_free())

Will change.

>> +        if (!strcasecmp(name, component_info[id].name))
>> +            return id;
>> +
>> +    return ZL_FW_COMPONENT_INVALID;
>> +}
>> +
>> +/**
>> + * zl3073x_fw_component_load - Load component from firmware source
>> + * @zldev: zl3073x device structure
>> + * @pcomp: pointer to loaded component
>> + * @psrc: data pointer to load component from
>> + * @psize: remaining bytes in buffer
>> + * @extack: netlink extack pointer to report errors
>> + *
>> + * The function allocates single firmware component and loads the 
>> data from
>> + * the buffer specified by @psrc and @psize. Pointer to allocated 
>> component
>> + * is stored in output @pcomp. Source data pointer @psrc and 
>> remaining bytes
>> + * @psize are updated accordingly.
>> + *
>> + * Return: 0 on success, <0 on error
> 
> document return of 1

Will fix.

>> + */
>> +static ssize_t
>> +zl3073x_fw_component_load(struct zl3073x_dev *zldev,
>> +              struct zl3073x_fw_component **pcomp,
>> +              const char **psrc, size_t *psize,
>> +              struct netlink_ext_ack *extack)
>> +{
>> +    const struct zl3073x_fw_component_info *info;
>> +    struct zl3073x_fw_component *comp = NULL;
>> +    struct device *dev = zldev->dev;
>> +    enum zl3073x_fw_component_id id;
>> +    ssize_t len, count;
>> +    u32 comp_size;
>> +    char line[32];
>> +    int rc;
>> +
>> +    /* Fetch image name from input */
>> +    len = zl3073x_fw_readline(line, sizeof(line), psrc, psize);
>> +    if (len < 0) {
>> +        rc = len;
>> +        goto err_unexpected;
>> +    } else if (!len) {
>> +        /* No more data */
>> +        return 0;
>> +    }
>> +
>> +    dev_dbg(dev, "Firmware component '%s' found\n", line);
>> +
>> +    id = zl3073x_fw_component_id_get(line);
>> +    if (id == ZL_FW_COMPONENT_INVALID) {
>> +        ZL3073X_FW_ERR_MSG(zldev, extack, "[%s] unknown component type",
>> +                   line);
>> +        return -EINVAL;
>> +    }
>> +
>> +    info = &component_info[id];
>> +
>> +    /* Fetch image size from input */
>> +    len = zl3073x_fw_readline(line, sizeof(line), psrc, psize);
>> +    if (len < 0) {
>> +        rc = len;
>> +        goto err_unexpected;
>> +    } else if (!len) {
>> +        ZL3073X_FW_ERR_MSG(zldev, extack, "[%s] missing size",
>> +                   info->name);
>> +        return -ENODATA;
>> +    }
>> +
>> +    rc = kstrtou32(line, 10, &comp_size);
>> +    if (rc) {
>> +        ZL3073X_FW_ERR_MSG(zldev, extack,
>> +                   "[%s] invalid size value '%s'", info->name,
>> +                   line);
>> +        return rc;
>> +    }
> 
> why not sscanf()? it would greatly simplify the above, and likely you
> could entriely remove zl3073x_fw_readline() too

I cannot use sscanf here because the input buffer is passed by devlink
as 'struct firmware' buffer and this buffer is not null-terminated.
In this case the driver would have to make a copy of the input buffer
and place null char at the end. The firmware can have up to 256kB and
IMO it is better to process original firmware buffer instead of extra
copy.

>> +
>> +    comp_size *= sizeof(u32); /* convert num of dwords to bytes */
>> +
>> +    /* Check image size validity */
>> +    if (comp_size > component_info[id].max_size) {
>> +        ZL3073X_FW_ERR_MSG(zldev, extack,
>> +                   "[%s] component is too big (%u bytes)\n",
>> +                   info->name, comp_size);
>> +        return -EINVAL;
>> +    }
>> +
>> +    dev_dbg(dev, "Indicated component image size: %u bytes\n", 
>> comp_size);
>> +
>> +    /* Alloc component */
>> +    comp = zl3073x_fw_component_alloc(comp_size);
>> +    if (!comp) {
>> +        ZL3073X_FW_ERR_MSG(zldev, extack, "failed to alloc memory");
>> +        return -ENOMEM;
>> +    }
>> +    comp->id = id;
>> +
>> +    /* Load component data from firmware source */
>> +    for (count = 0; count < comp_size; count += 4) {
>> +        len = zl3073x_fw_readline(line, sizeof(line), psrc, psize);
>> +        if (len < 0) {
>> +            rc = len;
>> +            goto err_unexpected;
>> +        } else if (!len) {
>> +            ZL3073X_FW_ERR_MSG(zldev, extack, "[%s] missing data",
>> +                       info->name);
>> +            rc = -ENODATA;
>> +            goto err;
>> +        }
>> +
>> +        rc = kstrtou32(line, 16, comp->data + count);
>> +        if (rc) {
>> +            ZL3073X_FW_ERR_MSG(zldev, extack,
>> +                       "[%s] invalid data: '%s'",
>> +                       info->name, line);
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    *pcomp = comp;
>> +
>> +    return 1;> +
>> +err_unexpected:
>> +    ZL3073X_FW_ERR_MSG(zldev, extack, "unexpected input");
>> +err:
>> +    zl3073x_fw_component_free(comp);
>> +
>> +    return rc;
>> +}
>> +
>> +/**
>> + * zl3073x_fw_free - Free allocated firmware
>> + * @fw: firmware pointer
>> + *
>> + * The function frees existing firmware allocated by @zl3073x_fw_load.
>> + */
>> +void zl3073x_fw_free(struct zl3073x_fw *fw)
>> +{
>> +    size_t i;
>> +
>> +    if (!fw)
>> +        return;
>> +
>> +    for (i = 0; i < ZL_FW_NUM_COMPONENTS; i++)
>> +        zl3073x_fw_component_free(fw->component[i]);
>> +
>> +    kfree(fw);
>> +}
>> +
>> +/**
>> + * zl3073x_fw_load - Load all components from source
>> + * @zldev: zl3073x device structure
>> + * @data: source buffer pointer
>> + * @size: size of source buffer
>> + * @extack: netlink extack pointer to report errors
>> + *
>> + * The functions allocate firmware structure and loads all components 
>> from
>> + * the given buffer specified by @data and @size.
>> + *
>> + * Return: pointer to firmware on success, error pointer on error
>> + */
>> +struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev *zldev, const 
>> char *data,
>> +                   size_t size, struct netlink_ext_ack *extack)
>> +{
>> +    struct zl3073x_fw_component *comp;
>> +    enum zl3073x_fw_component_id id;
>> +    struct zl3073x_fw *fw;
>> +    ssize_t rc;
>> +
>> +    /* Allocate firmware structure */
>> +    fw = kzalloc(sizeof(*fw), GFP_KERNEL);
>> +    if (!fw)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    do {
>> +        /* Load single component */
>> +        rc = zl3073x_fw_component_load(zldev, &comp, &data, &size,
>> +                           extack);
>> +        if (rc <= 0)
>> +            /* Everything was read or error occurred */
>> +            break;
>> +
>> +        id = comp->id;
>> +
>> +        /* Report error if the given component is present twice
>> +         * or more.
>> +         */
>> +        if (fw->component[id]) {
>> +            ZL3073X_FW_ERR_MSG(zldev, extack,
>> +                       "duplicate component '%s' detected",
>> +                       component_info[id].name);
>> +            zl3073x_fw_component_free(comp);
>> +            rc = -EINVAL;
>> +            break;
>> +        }
>> +
>> +        fw->component[id] = comp;
>> +    } while (1);
> 
> s/1/true/

Will fix.

>> +
>> +    if (rc) {
>> +        /* Free allocated firmware in case of error */
>> +        zl3073x_fw_free(fw);
> 
> I found no call to it on success.

The caller will deallocate it using zl3073x_fw_free()

> 
>> +        return ERR_PTR(rc);
>> +    }
>> +
>> +    return fw;
>> +}
> 
> 
>> +++ b/drivers/dpll/zl3073x/fw.h
>> @@ -0,0 +1,52 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef _ZL3073X_FW_H
>> +#define _ZL3073X_FW_H
>> +
>> +/*
>> + * enum zl3073x_fw_component_id - Identifiers for possible flash 
>> components
>> + */
>> +enum zl3073x_fw_component_id {
>> +    ZL_FW_COMPONENT_INVALID = -1,
>> +    ZL_FW_COMPONENT_UTIL = 0,
>> +    ZL_FW_COMPONENT_FW1,
>> +    ZL_FW_COMPONENT_FW2,
>> +    ZL_FW_COMPONENT_FW3,
>> +    ZL_FW_COMPONENT_CFG0,
>> +    ZL_FW_COMPONENT_CFG1,
>> +    ZL_FW_COMPONENT_CFG2,
>> +    ZL_FW_COMPONENT_CFG3,
>> +    ZL_FW_COMPONENT_CFG4,
>> +    ZL_FW_COMPONENT_CFG5,
>> +    ZL_FW_COMPONENT_CFG6,
>> +    ZL_FW_NUM_COMPONENTS,
> 
> no comma after enum that will be last forever (guard/size/max/num/cnt)

Will fix.

>> +};
> 

Thanks,
Ivan


