Return-Path: <netdev+bounces-192636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B84AC099E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26CD1BA4BCC
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D708288535;
	Thu, 22 May 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCNXRs3y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A23288C86
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747908923; cv=none; b=eE/1ahZ6rz08ejZsrFIboV+qFPurovQ3ElKv4aFCa96cVvuI+q0QDJ71Y8Z1Xj5STLpv03o9l2co/pTH8RqPHX8CbTzLnr1DxksfncLckxlAVRXg8VqxgyK+bzHhduFjCRmHT2nLHot5zRGRapvZ7hW2uLiYGNDmrPmxSBbaNxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747908923; c=relaxed/simple;
	bh=tK/AT0/ptSklMGY3ZXAhSm+TjwWxNhCiIVjH5W5f65g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAH15417q6hbKkArT/SVq+psoLLt9Q3Vx7tWlBAHfMdfZjLrA98eIFzxPVBJfEOrs9CcRiRkgkiNGXQvLRKG3zxLR6i4jWrL0wDv+UfiSXOibY4SgbZJrnQAqGi79zIfJMtQyvo5heW6kxmTSa562aTNd1uy+WiA+1QM3hm3tOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCNXRs3y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747908920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QN/1StSBeGN9tr1Hv85s0x/h0ylEI3nHrDwar8JZ+M=;
	b=HCNXRs3yAf9xuexJPSMXzXiEnwTTTMPi3HF4XniMpGva2PLw1XxgJ9WY8bHEsoH05DPOBa
	c99uItLu/Yz9esk1WcIAPIt5GzbeVHYN3MOwdkxxzCy5QghhQKeihOWLEZaA8tSzB7Seg6
	vDklKTM34FnMI8irmfE2jz8DKJVfzrM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-3jzYpmwdO2a5LvSaOQ5c3w-1; Thu, 22 May 2025 06:15:19 -0400
X-MC-Unique: 3jzYpmwdO2a5LvSaOQ5c3w-1
X-Mimecast-MFC-AGG-ID: 3jzYpmwdO2a5LvSaOQ5c3w_1747908918
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43eed325461so46077875e9.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 03:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747908918; x=1748513718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QN/1StSBeGN9tr1Hv85s0x/h0ylEI3nHrDwar8JZ+M=;
        b=i3mZtzaD4oLjTXPdM22jZAyAsePNZ+rrQOWnUFZihjhl2aJdTV+VJTp9Z5BcRuBmx8
         LOPMxrHzy5gWh6GGZX3GW673cTlBZPds131R6eDkawxkeUY30thwexzEo6ySL0C/Tt9t
         kORzIjkBPuwV9yy7Z7U7u8hd+5WkXSth7k2Gi3BjVLQLuox7Qc9C5bsqT6lRK6ciSoWM
         V7Hwpsuu9ugSQbicyWeQui08wxRzLMLaVUak+qoA8hP+0bGIeWnXK7XzU5zyyLM48JHR
         uNkLfST9ehPmcF7aaiiJtCusMPlZl67G+lvnknfacS+H5xAczXxlkQqDEymEQfru7EjJ
         ircA==
X-Gm-Message-State: AOJu0Yw/r4kPP9uKC8pQCOZZuSfDw6DuaPy9uRdtIGuOv6bwNIJFiHfR
	pUKdu01xaUZRMl5I+KRro11BeYWeQMJBBDxK6gAXPwhE7fYBQRbmwFfbVBrTSwYb32Izo2VGiuv
	/Unr/3/Vi2tAXTOYcH8qo0lAFw0/ZTxv6rFmLst7wKZtxkVcRqULRUDPUjw==
X-Gm-Gg: ASbGncvHfDTZexJVSPPtyvgQaH019LO7Ew8vqpaChCss00KEceUwU8Kfz+zwCcMuqY1
	cBZC1XAJdmKSdILb/nYHH/vZ/0VvZl1vyhpn79cO03QJMlfR6K2ZO+SOV1JMMBKOO/qMLjnNQmu
	LY9hLlXxONFAguFnz3aOl2AbQWu+x+1XugAV/hIG6KjbBLkVqcJHHSziEa9LlShQ5U9C/6I0a+d
	EA3iJSHQkWTXlJRKK+FwhyxCNxx8DHywIjxqIBvza+jLs+oITT13N4JnrIeaEIsMywoSw2lXTea
	WdJxWzzfDc/eZ3OFPu0=
X-Received: by 2002:a05:600c:a36a:b0:442:d9fb:d9f1 with SMTP id 5b1f17b1804b1-442fefdaba1mr250773495e9.4.1747908918131;
        Thu, 22 May 2025 03:15:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfzn/OwjBFHu0OW3zMj3JI9IlzzG1htGvDgUazuSuxk2ZnFD05IGB/yqpkkCM2dJtDcvfmdg==
X-Received: by 2002:a05:600c:a36a:b0:442:d9fb:d9f1 with SMTP id 5b1f17b1804b1-442fefdaba1mr250773225e9.4.1747908917676;
        Thu, 22 May 2025 03:15:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6ffaa6esm101611875e9.16.2025.05.22.03.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 03:15:17 -0700 (PDT)
Message-ID: <7a383c87-9c3d-4b61-b675-065d94f29a02@redhat.com>
Date: Thu, 22 May 2025 12:15:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 2/2] octeontx2-af: Fix APR entry mapping based on
 APR_LMT_CFG
To: Geethasowjanya Akula <gakula@marvell.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>
References: <20250521060834.19780-1-gakula@marvell.com>
 <20250521060834.19780-3-gakula@marvell.com>
 <aC2QdjlVJTNhfvV9@mev-dev.igk.intel.com>
 <CH0PR18MB43394C628856976D81897627CD9EA@CH0PR18MB4339.namprd18.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CH0PR18MB43394C628856976D81897627CD9EA@CH0PR18MB4339.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 2:07 PM, Geethasowjanya Akula wrote:
>> -----Original Message-----
>> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Sent: Wednesday, May 21, 2025 2:06 PM
>>> @@ -568,8 +569,12 @@ static ssize_t
>> rvu_dbg_lmtst_map_table_display(struct file *filp,
>>>  		return -ENOMEM;
>>>
>>>  	tbl_base = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_MAP_BASE);
>>> +	val  = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
>>> +	apr_vfs = 1 << (val & 0xF);
>>> +	apr_pfs = 1 << ((val >> 4) & 0x7);
>>>
>>> -	lmt_map_base = ioremap_wc(tbl_base, 128 * 1024);
>>> +	lmt_map_base = ioremap_wc(tbl_base, apr_pfs * apr_vfs *
>>> +				  LMT_MAPTBL_ENTRY_SIZE);
>>
>> As it is the same as in lmtst_map_table_ops() I think you can move whole to a
>> new function.
>>
>> rvu_ioremap_wc(rvu, base, size);
>>
>> or sth like that. It isn't strong opinion. Rest looks fine, thanks.
> Will address your suggestion in new patch along with other code enhancement.

FTR, I'm fine with a net-next follow-up.

Cheers,

Paolo


