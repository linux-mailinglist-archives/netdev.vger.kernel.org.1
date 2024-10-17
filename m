Return-Path: <netdev+bounces-136410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CE89A1AC7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532121C20906
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE651922CF;
	Thu, 17 Oct 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5ze3oRr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF915FD16
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147187; cv=none; b=a6P9ITDfpV1T+ln4wTHOt5NgEc24DHB8Hru7raLspJtUrI/IMkoChHw4dUiJIFglzifpJErjZiE9PJBDGx6To4ChKIIMtKQauNmVXWoP3mpWyzu2pDniWusEyIMQxrqX1OffTDqh6ll3iuFKsDJ+sTT+nX8d1EHc3eAR2iGXIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147187; c=relaxed/simple;
	bh=Va96gHtvVTKiw1k/IJzspfpqnhhmabe7oI+NVSc809E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LemJL1gb2weLxM29Z4dxaBuRyxXzTd92qK0c0qXeffeLIwVMywwz5N34NQbLb3fjRpVRnzmh1cyhEv4R/ORaZWsqxW1zVncMqgPYDJGOWZWJpFH9zAsrJvfWdoaDNHhUvsLjh5FC8Opa8tFRUSJq2YquNrLhWqc59PwMNufuuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5ze3oRr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729147183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmS+YML6tDd5SKqiUBzlSgoUwTEs05dCLdlI8MnWiHA=;
	b=O5ze3oRrT+4+PvVbb5OlFc08NGaGb7Fd/B6FiYiFNcmX+4QJviZ/cjHLs7My7EegglFEti
	D5pvlASLKeRvZ7fYZTEsB3nyYOcLBq579C+LZx45of8+tvYzSGal/l/5mTkQA/WL0oJ97e
	25IulEb8mfi9T/7JyWtSxiXFDxRXLJw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-uAxt_XTsPW2QcS5jxXQk9w-1; Thu, 17 Oct 2024 02:39:42 -0400
X-MC-Unique: uAxt_XTsPW2QcS5jxXQk9w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315af466d9so1922885e9.3
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 23:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729147181; x=1729751981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmS+YML6tDd5SKqiUBzlSgoUwTEs05dCLdlI8MnWiHA=;
        b=bmBJbEUo8pEhlYxyw/Qx3sYMZ4k5R0YS6RZ2Uo+SoTd7Ikuv2idtdGOREjuJXTjyHj
         foPsnCc/9Jl5nE9QWxnKJ04aBfboLEPVuzx6XU6OhqnxKacUKhp25n9UJgPRdW2d8AZV
         x1oAkpuRF7aRtGZYrt18QgI3o7/oTD+XwD/IEFAQSCT9Hr7RIcclyfDKxvctTiNJWrG1
         4vT/nscOALxO4sxxBfwmSJ7m915/y7WW5spWbBd1/TknyUIEONaDVz8NfZbcmLyG45ow
         coF2r/VMgdNex4UnvE+pujPAaoP+nrqJICE+jFRJc3rHS35s1FmNsM2EPeGAM1ZFENdo
         29dg==
X-Forwarded-Encrypted: i=1; AJvYcCWRoUNjyflSdoYOD3Vw8/Jk2Ylc1/W28zXyobBGkg6TFnVIosi1U7HqZYfGeVNze5J1rgP3dPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHRotYlc/V05jiSF9CiJWs7RH0I2e5wXN43y38S4YWR6bl5B+
	+8O65FTz5L2R0W0n9eBaArBXlj3S+EtSqWt0Bsak5zhS8LT1yS/qKlEvHaeD4D+7OUP8kk7dgCV
	56r5IGlmyyNq44DC9pL8uXhMlWqE6qkV+GKOr703uM0cXur0taX/L+Q==
X-Received: by 2002:a05:600c:1c1b:b0:431:52f5:f497 with SMTP id 5b1f17b1804b1-43152f5f8cfmr27374075e9.9.1729147180692;
        Wed, 16 Oct 2024 23:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwrvEWX7N8ltQUpIkS2NLEQQgrE8KQhEh+hsVdum3NNNhiBWkoa0PoR7U1p6OjNMGdgVeKGQ==
X-Received: by 2002:a05:600c:1c1b:b0:431:52f5:f497 with SMTP id 5b1f17b1804b1-43152f5f8cfmr27373975e9.9.1729147180298;
        Wed, 16 Oct 2024 23:39:40 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c4e2edsm15468835e9.39.2024.10.16.23.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 23:39:39 -0700 (PDT)
Message-ID: <fee3fe99-14bf-486e-b12e-5088d17a095a@redhat.com>
Date: Thu, 17 Oct 2024 08:39:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] virtchnl: fix m68k build.
To: Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <e45d1c9f17356d431b03b419f60b8b763d2ff768.1729000481.git.pabeni@redhat.com>
 <98b5bef5-d5a8-45d5-8fe8-f9c34eb5ab84@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <98b5bef5-d5a8-45d5-8fe8-f9c34eb5ab84@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 00:49, Jacob Keller wrote:
> On 10/15/2024 6:56 AM, Paolo Abeni wrote:
>> The kernel test robot reported a build failure on m68k in the intel
>> driver due to the recent shapers-related changes.
>>
>> The mentioned arch has funny alignment properties, let's be explicit
>> about the binary layout expectation introducing a padding field.
>>
>> Fixes: 608a5c05c39b ("virtchnl: support queue rate limit and quanta size configuration")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202410131710.71Wt6LKO-lkp@intel.com/
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>   include/linux/avf/virtchnl.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
>> index 223e433c39fe..13a11f3c09b8 100644
>> --- a/include/linux/avf/virtchnl.h
>> +++ b/include/linux/avf/virtchnl.h
>> @@ -1499,6 +1499,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_queue_chunk);
>>   
>>   struct virtchnl_quanta_cfg {
>>   	u16 quanta_size;
>> +	u16 pad;
>>   	struct virtchnl_queue_chunk queue_select;
> 
> There's a hidden 2 byte padding because queue_select requires 4-byte
> alignment. We assume this, as the VIRTCHNL_CHECK_STRUCT_LEN for this
> structure is 12 bytes.
> 
> On mk68k, we must not be adding this padding, which results in a 10 byte
> structure, failing the size check for VIRTCHNL_CHECK_STRUCT_LEN,
> resulting in the compilation error?

Exactly!

> Adding the explicit size aligns with the actual expected layout and size
> for this structure, fixing mk68k without affecting the other architectures.
> 
> Ok.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,

Please LMK if you prefer/agree to have this one applied directly on 
net-next, to reduce build issues spawning around ASAP.

Paolo


