Return-Path: <netdev+bounces-181139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE59A83CAE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D880E1B63090
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF320B208;
	Thu, 10 Apr 2025 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Es0IANls"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E342046B5
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273275; cv=none; b=LxwLP5jA0CIA9odeIb1/xVptxJ6nFZ/SgWycE+PSpE7mKFuUy0xp14Ifz0Gv9TEsBqmajTHdZo6j9uocjMd62ArGJzu0A2ZsYTl68pz2SKtiEjJJv/tKuNrhrI4ZJiOZvNrcbwvp23ghXTlXk8HQZZyisW+vrdsm2C9fxFd++xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273275; c=relaxed/simple;
	bh=VekH1TtvA9ycbAEh3GkwYb3Y2hHvnuv9qkqAOyAANBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mvw4U92AA8zse8B5+Rr1QYPeFwfxbTikChMwLW+v/wIs4iK/VZErmcOTYYFIOiH/R9pePUFxTQNtvxSRjf1rlEVO1Y8B3uYTOGGrD65avTVCTKmd0r1ril/Ve5KBFNJc68KN0gbojGv2wNTERTWIXe85Es5AoJapgoWHHQTQUnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Es0IANls; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744273272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+979veQE+KclGLEtYrkcPeF+CuZm6IpwHOpzDxyU3C4=;
	b=Es0IANlsk+WvDNVXNQM5znPpnp9PWCy2OpfmRAVDqPNEHPWFdDR5/JJ3dHRiy4eraDS5Ps
	BPoYaYDaOHHGHtFBoXAL5J3S0rss+ZYWYVrhb4sNzH3fqDIL1WXDBQCFj65BIRK8qtmpR0
	Wg+0IAo5K4apOsMSUjwZ6MLFrR4D8Ro=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-SEnZhfAjOfi0dJpkj5e4Iw-1; Thu,
 10 Apr 2025 04:21:06 -0400
X-MC-Unique: SEnZhfAjOfi0dJpkj5e4Iw-1
X-Mimecast-MFC-AGG-ID: SEnZhfAjOfi0dJpkj5e4Iw_1744273264
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9902C1800A3E;
	Thu, 10 Apr 2025 08:21:02 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0F751955DCE;
	Thu, 10 Apr 2025 08:20:57 +0000 (UTC)
Message-ID: <b73e1103-a670-43da-8f1a-b9c99cd1a90d@redhat.com>
Date: Thu, 10 Apr 2025 10:20:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] mfd: zl3073x: Add macros for device registers
 access
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-7-ivecera@redhat.com>
 <3e12b213-db36-4a76-9a58-c62dc8b1b2ce@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <3e12b213-db36-4a76-9a58-c62dc8b1b2ce@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 10. 04. 25 9:17 dop., Krzysztof Kozlowski wrote:
> On 09/04/2025 16:42, Ivan Vecera wrote:
>> Add several macros to access device registers. These macros
>> defines a couple of static inline functions to ease an access
>> device registers. There are two types of registers, the 1st type
>> is a simple one that is defined by an address and size and the 2nd
>> type is indexed register that is defined by base address, type,
>> number of register instances and address stride between instances.
>>
>> Examples:
>> __ZL3073X_REG_DEF(reg1, 0x1234, 4, u32);
>> __ZL3073X_REG_IDX_DEF(idx_reg2, 0x1234, 2, u16, 4, 0x10);
> 
> Why can't you use standard FIELD_ macros? Why inventing the wheel again?

This is not about FIELD_* macros replacement. This is an abstraction to 
access device registers in safe manner. Generated inline functions 
ensures that proper value or pointer to value type is passed by caller.
Also in case of arbitrary zl3073x_{read,write_{,idx}_reg() the does not 
need to know what is the register address.

If the caller just need to read regX or indexed regY it will call just

zl3073x_read_regX(..., &value);
zl3073x_read_regX(..., idx, &value);

instead of

zl3073x_read_reg(..., ZL3073x_REGX_ADDR, &value);
zl3073x_read_reg(..., ZL3073x_REGY_ADDR + (idx * ZL3073X_REGY_STRIDE), 
&value)

The 1st variant is additionally type safe, the caller is warned if it is 
passing u8 * instead of u32 *.

I tried to take similar approach the mlxsw driver took to access device 
registers.

If you are only against such macro usage for static inline functions 
generation, I can avoid them and pre-create them in separate include 
file like zl3073x_regs.h

>> this defines the following functions:
>> int zl3073x_read_reg1(struct zl3073x_dev *dev, u32 *value);
>> int zl3073x_write_reg1(struct zl3073x_dev *dev, u32 value);
>> int zl3073x_read_idx_reg2(struct zl3073x_dev *dev, unsigned int idx,
>>                            u32 *value);
>> int zl3073x_write_idx_reg2(struct zl3073x_dev *dev, unsigned int idx,
>>                             u32 value);
> 
> Do not copy code into commit msg. I asked about this last time. Explain
> why do you need it, why existing API is not good.

Will drop... I wanted only show how the macros work and what is their output

>>
>> There are also several shortcut macros to define registers with
>> certain bit widths: 8, 16, 32 and 48 bits.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
> 
> 
> ...
> 
>> + *
>> + * Note that these functions have to be called with the device lock
>> + * taken.
>> + */
>> +#define __ZL3073X_REG_IDX_DEF(_name, _addr, _len, _type, _num, _stride)	\
>> +typedef _type zl3073x_##_name##_t;					\
>> +static inline __maybe_unused						\
>> +int zl3073x_read_##_name(struct zl3073x_dev *zldev, unsigned int idx,	\
>> +			 _type * value)					\
>> +{									\
>> +	WARN_ON(idx >= (_num));						\
> 
> No need to cause panic reboots. Either review your code so this does not
> happen or properly handle.

Ack, will replace by

if (idx >= (_num))
	return -EINVAL

Thanks,
Ivan


