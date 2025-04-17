Return-Path: <netdev+bounces-183795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE801A92037
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771F87A5284
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9532522A7;
	Thu, 17 Apr 2025 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/i48xJu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B414A4C7
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901441; cv=none; b=ntOne2GSKvLz2NnVZ6PITw2QLOOpeBxR8E1OcSNO2P38vXxhmYyyXlx8RXpGjmYawyQzm1c9eObibWMcm/jLUppwTA1b+zSTZKOJPNzRTWwSI/yKdtev6ieE25cUXjYB3JOY4W+JUpfaRQm5FlMZbAVOUkLlUYXSIqFRs1h4Jxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901441; c=relaxed/simple;
	bh=lfFcddiYY0f2/ajdCn13Ssqz/6k7ckZ4gPrPUQzxMQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBjd9Xl1FILRmYIoBZOhCfel/ZRiWJ/17IEwuMI66k3ig4OWNE6HIQqxoL0eD8BskfoYDhETF1KQLJzeie39kYxbktMdadEDUrBUX5GbkT4Sw2URH/UHCTJpeMvdZeM0S/76WvZNWbcS0cYicxtaWToHnx9HjS3qQtL+Kum2EeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/i48xJu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744901439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n69F12b8gb5rkYnrsYjWLffA9DRH6Ubd/djGhMzPmIg=;
	b=g/i48xJu/5kR5TP4fExF+kjyCAe0jblT5JjCcwn7Y4g5+fxu30+d9HHOqnH8RPMtumG4p3
	3uCmJ8+GkxKdboDjQaf4xizJYXVZWzqO87X1Cj/tl0vISJ2y7NFa5ewQ73382zEt/9FEQI
	pWmCmcFyZEC9S3smG74j9wBTfn+Pb3E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-0BTaddYTPTi8ReVuyeNSuw-1; Thu,
 17 Apr 2025 10:50:35 -0400
X-MC-Unique: 0BTaddYTPTi8ReVuyeNSuw-1
X-Mimecast-MFC-AGG-ID: 0BTaddYTPTi8ReVuyeNSuw_1744901433
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C42B719560AD;
	Thu, 17 Apr 2025 14:50:32 +0000 (UTC)
Received: from [10.44.33.28] (unknown [10.44.33.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AE8E19560A3;
	Thu, 17 Apr 2025 14:50:27 +0000 (UTC)
Message-ID: <03afdbe9-8f55-4e87-bec4-a0e69b0e0d86@redhat.com>
Date: Thu, 17 Apr 2025 16:50:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 3/8] mfd: Add Microchip ZL3073x support
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
 <20250416162144.670760-4-ivecera@redhat.com>
 <8fc9856a-f2be-4e14-ac15-d2d42efa9d5d@lunn.ch>
 <CAAVpwAsw4-7n_iV=8aXp7=X82Mj7M-vGAc3f-fVbxxg0qgAQQA@mail.gmail.com>
 <894d4209-4933-49bf-ae4c-34d6a5b1c9f1@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <894d4209-4933-49bf-ae4c-34d6a5b1c9f1@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 17. 04. 25 3:13 odp., Andrew Lunn wrote:
> On Wed, Apr 16, 2025 at 08:19:25PM +0200, Ivan Vecera wrote:
>> On Wed, Apr 16, 2025 at 7:11 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>>      > +++ b/include/linux/mfd/zl3073x_regs.h
>>      > @@ -0,0 +1,105 @@
>>      > +/* SPDX-License-Identifier: GPL-2.0-only */
>>      > +
>>      > +#ifndef __LINUX_MFD_ZL3073X_REGS_H
>>      > +#define __LINUX_MFD_ZL3073X_REGS_H
>>      > +
>>      > +#include <asm/byteorder.h>
>>      > +#include <linux/lockdep.h>
>>
>>      lockdep?
>>
>>
>> lockdep_assert*() is used in later introduced helpers.
> 
> nitpicking, but you generally add headers as they are needed.

+1


>>      > +#include <linux/mfd/zl3073x.h>
>>      > +#include <linux/regmap.h>
>>      > +#include <linux/types.h>
>>      > +#include <linux/unaligned.h>
>>      > +
>>      > +/* Registers are mapped at offset 0x100 */
>>      > +#define ZL_RANGE_OFF        0x100
>>      > +#define ZL_PAGE_SIZE        0x80
>>      > +#define ZL_REG_ADDR(_pg, _off) (ZL_RANGE_OFF + (_pg) * ZL_PAGE_SIZE +
>>      (_off))
>>      > +
>>      > +/**************************
>>      > + * Register Page 0, General
>>      > + **************************/
>>      > +
>>      > +/*
>>      > + * Register 'id'
>>      > + * Page: 0, Offset: 0x01, Size: 16 bits
>>      > + */
>>      > +#define ZL_REG_ID ZL_REG_ADDR(0, 0x01)
>>      > +
>>      > +static inline __maybe_unused int
>>      > +zl3073x_read_id(struct zl3073x_dev *zldev, u16 *value)
>>      > +{
>>      > +     __be16 temp;
>>      > +     int rc;
>>      > +
>>      > +     rc = regmap_bulk_read(zldev->regmap, ZL_REG_ID, &temp, sizeof
>>      (temp));
>>      > +     if (rc)
>>      > +             return rc;
>>      > +
>>      > +     *value = be16_to_cpu(temp);
>>      > +     return rc;
>>      > +}
>>
>>      It seems odd these are inline functions in a header file.
>>
>>
>> There are going to be used by dpll_zl3073x sub-driver in series part 2.
> 
> The subdriver needs to know the ID, firmware version, etc?

No

> Anyway, look around. How many other MFD, well actually, any sort of
> driver at all, have a bunch of low level helpers as inline functions
> in a header? You are aiming to write a plain boring driver which looks
> like every other driver in Linux....

Well, I took inline functions approach as this is safer than macro usage
and each register have own very simple implementation with type and
range control (in case of indexed registers).

It is safer to use:
zl3073x_read_ref_config(..., &v);
...
zl3073x_read_ref_config(..., &v);

than:
zl3073x_read_reg8(..., ZL_REG_REF_CONFIG, &v);
...
zl3073x_read_reg16(..., ZL_REG_REF_CONFIG, &v); /* wrong */

With inline function defined for each register the mistake in the 
example cannot happen and also compiler checks that 'v' has correct type.

> Think about your layering. What does the MFD need to offer to sub
> drivers so they can work? For lower registers, maybe just
> zl3073x_read_u8(), zl3073x_read_u16() & zl3073x_read_read_u32(). Write
> variants as well. Plus the API needed to safely access the mailbox.
> Export these using one of the EXPORT_SYMBOL_GPL() variants, so the sub
> drivers can access them. The #defines for the registers numbers can be
> placed into a shared header file.

Would it be acceptable for you something like this:

int zl3073x_read_reg{8,16,32,48}(..., unsigned int reg, u{8,16,32,64} *v);
int zl3073x_write_reg{8,16,32,48}(..., unsigned int reg, u{8,16,32,64} v);
int zl3073x_read_idx_reg{8,16,32,48}(..., unsigned int reg, unsigned int 
idx, unsigned int max_idx, unsigned int stride, u{8,16,32,64} *v);
int zl3073x_write_idx_reg{8,16,32,48}(..., unsigned int reg, unsigned 
int idx, unsigned int max_idx, unsigned int stride, u{8,16,32,64} v);

/* Simple non-indexed register */
#define ZL_REG_ID	ZL_REG_ADDR(0 /* page */, 0x01 /* offset */
#define ZL_REG_ID_BITS	8

/* Simple indexed register */
#define ZL_REG_REF_STATUS	ZL_REG_ADDR(2, 0x44)
#define ZL_REG_REF_STATUS_BITS	16
#define ZL_REG_REF_STATUS_ITEMS	10
#define ZL_REG_REF_STATUS_STRIDE 2

/* Read macro for non-indexed register */
#define ZL3073X_READ_REG(_zldev, _reg, _v)	\
	__PASTE(zl3073x_read_reg, _reg##_BITS)(_zldev, _reg, _v)

/* For indexed one */
#define ZL3073X_READ_IDX_REG(_zldev, _reg, _idx, _v)	\
	__PASTE(zl3073x_read_idx_reg, _reg##_BITS)(_zldev, _reg, _v,
						   _idx, \
						   _reg##_ITEMS, \
						   _reg##_STRIDE, _v)

This would allow to call simply
ZL3073X_READ_REG(zldev, ZL_REG_ID, &val);
or
ZL3073X_READ_IDX_REG(zldev, ZL_REG_REF_STATUS, 4);

and caller does not need to know register size and range constraints.

WDYT?

Thanks,
Ivan


