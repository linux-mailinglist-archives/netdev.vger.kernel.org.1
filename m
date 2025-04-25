Return-Path: <netdev+bounces-185989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C0A9C9C3
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF79F1B83C9B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 13:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839A2528E0;
	Fri, 25 Apr 2025 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbdoBuzn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CAD24EABD
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586297; cv=none; b=CqFosHK9DrrOd1CNC3NtX5AyfOiuhNdboQCqKNpPBUHSF6gx/vbENuEh28MobvhOKNqcOkz+P3Tagk6xBY8LKH/WebMwYRkfkrrLIzqWf6+Dw8ahH4JfJqIBE0fdb3s1jUrqu1ft0dmHmu4yp0fuMSYtQSNIpK63/roaC8p4p54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586297; c=relaxed/simple;
	bh=rPaDqGzlo8kKc7078BfnnKIU+GVWwOACSGFFD9+ZYOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbGaNKdwKmSIqwBoDshzL0X8iAWlChbicnL/eYAjad79Ge14EMhA8SHqNCPbuNUyUC/i/IgDe8jDcU/LVZidWsFeVxhCdzoT3+HcKtLpwjKvFij5yPcVoNdfn/L6H9thoAv79JX0WNKi0WqVnXqqhonAf+ISneWitvZy9kNjCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbdoBuzn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745586295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRT3RKx4TZ+P54S/HXqOrC/ht/rfJMrgmNz4iAs0uEQ=;
	b=fbdoBuznY+gTnV0AEmml4LD7gjO2YuxxSEQ5KQRtpu/hPu76w6ECICVei9embEI5AuakgA
	mg4O4rLAQ8svP0YqeoY79p4fa6GbHcpS0i5F2ne0Gp8M6HwdBfGNnRb1uPDTlDKbhnhuHQ
	nkWKCj+LmIJiBOj/295M2uIY8DSiwqI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-_3s_6pwmPWC8mVY-6ElxbQ-1; Fri,
 25 Apr 2025 09:04:51 -0400
X-MC-Unique: _3s_6pwmPWC8mVY-6ElxbQ-1
X-Mimecast-MFC-AGG-ID: _3s_6pwmPWC8mVY-6ElxbQ_1745586289
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1CFA1800264;
	Fri, 25 Apr 2025 13:04:48 +0000 (UTC)
Received: from [10.44.33.33] (unknown [10.44.33.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B090918002AD;
	Fri, 25 Apr 2025 13:04:42 +0000 (UTC)
Message-ID: <1ba66392-f41d-4ffa-9952-900b6856e861@redhat.com>
Date: Fri, 25 Apr 2025 15:04:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
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
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-6-ivecera@redhat.com>
 <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
 <bd645425-b9cb-454d-8971-646501704697@redhat.com>
 <8082254c-01a6-4aca-84de-76083fdcbb3b@lunn.ch>
 <ea9cd028-3d74-4d46-b355-a74ad549269b@redhat.com>
 <34f29b17-dc68-4005-b2da-95fde34117a0@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <34f29b17-dc68-4005-b2da-95fde34117a0@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 24. 04. 25 9:57 odp., Andrew Lunn wrote:
> On Thu, Apr 24, 2025 at 09:53:39PM +0200, Ivan Vecera wrote:
>>
>>
>> On 24. 04. 25 9:18 odp., Andrew Lunn wrote:
>>>> During taking 613cbb91e9ce ("media: Add MIPI CCI register access helper
>>>> functions") approach I found they are using for these functions u64
>>>> regardless of register size... Just to accommodate the biggest
>>>> possible value. I know about weakness of 'void *' usage but u64 is not
>>>> also ideal as the caller is forced to pass always 8 bytes for reading
>>>> and forced to reserve 8 bytes for each read value on stack.
>>>
>>> In this device, how are the u48s used? Are they actually u48s, or are
>>> they just u8[6], for example a MAC address? The network stack has lots
>>> of functions like:
>>>
>>> eth_hw_addr_set(struct net_device *dev, const u8 *addr)
>>
>> u48 registers always represent 48bit integer... they read from device using
>> bulk read as big-endian 48bit int. The same is valid also for u16
>> and u32.
> 
> Then a u64 makes sense, plus on write to hardware a check the upper
> bits are 0. These u48s are going to be stored in a u64 anyway, since C
> does not have a u48 type.

Just note that some of 48bit registers uses signed values so the check
should be:

x is in <S48_MIN, U48_MAX>

this could be done using bit operations:

(!(GENMASK_ULL(63, 49) & ((u64)(x) + BIT_ULL(47))))

Ivan


