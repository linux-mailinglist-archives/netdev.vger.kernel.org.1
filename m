Return-Path: <netdev+bounces-144198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF62B9C5FED
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED5B1F276BB
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD7E215019;
	Tue, 12 Nov 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0FDdkQd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0D215014
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434972; cv=none; b=nrP8xp6H1QL50TjBJR0KbuVYjT+Bkj82AHM/LEfYRvQutcG61Aa0EHAKOoQ7RmKn7buTtAPcOwjpWPsfDq2/mYpoRq70oEH7njl8oCbHQqZqko6qBy0DV64OEp6U+8ngYLKfwnZn4AV5P8eYT5aI5+o40Tx82YecxbsCAYIdMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434972; c=relaxed/simple;
	bh=lLpVV5/7gacVZcEg3rxfsSJWITcpiNesgX6ohMJKft4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8uTgK9NUKydK/1LWStYFXoFz+NfuOcl6meha/hGP22uURooMJHAXF042B2biPylERC+a2PqmRoNMiKa09SgaKaY+G0WO6YGLEkd4/daicMVqSgbUuCmfjf5QO2mNPWzjUEhvZZbxTnIMFou7AnxuVQ1Oxuloevvd8CkkzYgZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0FDdkQd; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e9b4a5862fso3424593a91.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 10:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731434968; x=1732039768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpsApVqZ2HNX2z+hXbsamVe/qttrrLro4IsD4iwja/o=;
        b=B0FDdkQdWNtnab1XN+juT9V6npxr2ubqnb+GCMrKEhJReI2d34CCw/DNeYt+roZ7Q5
         3fTXLwMS/xyuFO8ARIhFtdlxR2Zqm8cgnMj/l7fVjQ2wZSdXOcbJ5Mk8DV67RGIRISjw
         Yv7FDk9XlMdPlhD5x2CDy/EN28yA9DwVJe5JcxlMUiNMzhh3U9b2SGuidRj98FQlRS83
         QinzGcTZ0Ve8ejjvkAAGdXsmLFyUUnwmMyUgrQqXZsH1ZBRkdKmgajXDYoLwmvb+Nbns
         F8V7s+MX8IFhHBHATxX/4nL8Uc8kW00fy/zUSkVCIAzmLRGL3gDIUheBfvafZaBYLGAo
         AW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434968; x=1732039768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpsApVqZ2HNX2z+hXbsamVe/qttrrLro4IsD4iwja/o=;
        b=uE9pq7Z6BxEWpfe5R5N7mhU4CZtGgU5CwSliJ0qImhIDI9Z3Y6Zg4TVZHCmeqBQvwg
         Pb8GhLMV4hq8ynr+y4GpofB4WMqpvrLo2QQA0MLYzCKVsVmnORwhhq0ZSl/aTVzZeBPg
         Y39EaRjzf2yiix83n2MUPcYvwIkKb3HLz/uls/kzL07m7P9ZX47GN9uu+jFDIlk+2a6l
         Zi8Fv6BB2cgtcaePtWy48xhDtjHOBSch48GgshZq6deG4QwynVoftPo3Z/+2oMh9ei8J
         H51q/ucTIEXT3Q/Ex0t7BlXsAeEtE3JKs6GNalaUh0MxCAjVg9euc2oggUCjJccrHFue
         7CQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxZYlmGrz580A7AOnZkLAhJyoTJxf1QiKbP60J2myEZG/Gk8N9XHfE+F2RjjcCzzq78xijoZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+mQqB3dX3TUVZno3tzJpZuq2VXc/BmoQn/b4qN9dP8oYOzRP
	qCPVM2+k8EpzcJ/JDzCc5zAT3cOenyJ2eRK9MS5G9nn0bkVFMJtB
X-Google-Smtp-Source: AGHT+IEKIAB4c4VUM+qSvX8mLTVHiO6qqPuP2OcCShU7nzFGPI6r+/AQf8PxbmKNId70atjiBaKMhQ==
X-Received: by 2002:a17:90b:3b43:b0:2e0:b5c8:9ca2 with SMTP id 98e67ed59e1d1-2e9e4ada73emr4721773a91.9.1731434968080;
        Tue, 12 Nov 2024 10:09:28 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:29:18e0:745e:eada:39b3? ([2620:10d:c090:500::6:487b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e58e4fsm94535685ad.203.2024.11.12.10.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 10:09:27 -0800 (PST)
Message-ID: <6f25d183-67e8-4704-b5a7-775fbf8d3d58@gmail.com>
Date: Tue, 12 Nov 2024 10:09:25 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: fbnic: Add support to dump registers
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew@lunn.ch,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kernel-team@meta.com, sanmanpradhan@meta.com, vadim.fedorenko@linux.dev,
 horms@kernel.org
References: <20241108013253.3934778-1-mohsin.bashr@gmail.com>
 <3248ec45-8168-47f2-84af-28a350261bf6@redhat.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <3248ec45-8168-47f2-84af-28a350261bf6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/24 4:17 AM, Paolo Abeni wrote:
> On 11/8/24 02:32, Mohsin Bashir wrote:
>> Add support for the 'ethtool -d <dev>' command to retrieve and print
>> a register dump for fbnic. The dump defaults to version 1 and consists
>> of two parts: all the register sections that can be dumped linearly, and
>> an RPC RAM section that is structured in an interleaved fashion and
>> requires special handling. For each register section, the dump also
>> contains the start and end boundary information which can simplify parsing.
>>
>> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
>> ---
>>   drivers/net/ethernet/meta/fbnic/Makefile      |   3 +-
>>   drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
>>   drivers/net/ethernet/meta/fbnic/fbnic_csr.c   | 145 ++++++++++++++++++
>>   drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  16 ++
>>   .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  17 ++
>>   5 files changed, 183 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_csr.c
>>
>> diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
>> index cadd4dac6620..425e8b801265 100644
>> --- a/drivers/net/ethernet/meta/fbnic/Makefile
>> +++ b/drivers/net/ethernet/meta/fbnic/Makefile
>> @@ -7,7 +7,8 @@
>>   
>>   obj-$(CONFIG_FBNIC) += fbnic.o
>>   
>> -fbnic-y := fbnic_devlink.o \
>> +fbnic-y := fbnic_csr.o \
>> +	   fbnic_devlink.o \
>>   	   fbnic_ethtool.o \
>>   	   fbnic_fw.o \
>>   	   fbnic_hw_stats.o \
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
>> index 9f9cb9b3e74e..98870cb2b689 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
>> @@ -156,6 +156,9 @@ int fbnic_alloc_irqs(struct fbnic_dev *fbd);
>>   void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
>>   				 const size_t str_sz);
>>   
>> +void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version);
>> +int fbnic_csr_regs_len(struct fbnic_dev *fbd);
>> +
>>   enum fbnic_boards {
>>   	fbnic_board_asic
>>   };
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
>> new file mode 100644
>> index 000000000000..e6018e54bc68
>> --- /dev/null
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
> 
> The code LGTM, but this newly created file lacks the SPDX licence
> identifier.
> 
> Please add it.
> 
> /P
> 
> Side note: a few other files are missing such info, it would be good if
> you could send patches to fix them, too.
> 
Hi Paolo,

Thank you for your response. I'll update this patch with SPDX license 
information in the newly added file. I will also send a separate patch 
to add the same in files which are currently missing this.

