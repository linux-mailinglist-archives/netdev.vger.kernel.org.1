Return-Path: <netdev+bounces-208987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4E2B0DF2C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0293A2BF5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405BA2EAB62;
	Tue, 22 Jul 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ccuwPdlH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6362EA739
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195030; cv=none; b=lm2vpqaLc9MwIKeQjL2S0cg/3mHVkVjrs3opjzr4xRgDB4N3caCAlhu3MhuQPaOkjgVGSpg4gntuWo03qy4ZfhEZsOexdylL8UU5mk44pwfu0rzHUlvB26TrxtjEVu60bq44fbu9FCTKr1iXhddZgbEKZ7ZHfw36Wt+kRz452a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195030; c=relaxed/simple;
	bh=5WVGe8wXO9JfYnQEr4Zex3JT4JXY+mBHCCJsU0+LFcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzN0sWNmf9s2W+ETCOkHOJdjgkjSmeACnShpfBrRymKLB4RfhiT/Sn2v3uVMpAKJ2F9OTWW/iT67BkJIyxBLs/3KgfUkgX/BTJ1XW5dGGql+6XdpBzxOyIZ8oJy45bGEk0sJxayQmjurGm/5WbDcn4wPnLfZlFTKMz7480krwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ccuwPdlH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MCY4If001048
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R8R1wAZwL02u+Cgf4TNMtyfaka474kDZXFvf2HapMfg=; b=ccuwPdlH3EwTqfPU
	N01lm3dbw8ct+OlY475e89Ce6UGQjn2mMBNWua8YiVUDGoP3zENJL3Jbbla/wyH0
	JmzPe19yYc3IR+LEl4nfNhs974Ha2YFAOimRLijgrJBJfywiWQ8Rv6066kqTCuW3
	1gOIbTZreTVLP2B3KvtREzrQ2MMjwv2l9AUd3+Hq+0mxy/TbtoNA9hiVzMXutuGO
	Z2YPdxVC4DFsHsW4XLcw+75Xdh34z2fkghkGDFIjRM31eO7A/2odiivsLOfNEEmm
	iO5AhW42Aw3MldZvc+r1ZRuUqhKL1nKUQiNg0NN8kzcoG+gT53iAeraViEBzAcBm
	5MU9TQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dhmhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:37:07 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74d15d90cdbso4764996b3a.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195026; x=1753799826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8R1wAZwL02u+Cgf4TNMtyfaka474kDZXFvf2HapMfg=;
        b=vvtoBKRMKdr7VOIffWyd3KRYHhw7eU51PAPGl09wfXT/oNlcEFej6siLRt8I/k7E5U
         6WDARNQ4uLfqmlPMP+sWFvyv6ZgvzKSlqKCVQkUxWr9h3oYxVELRWJ1GnuQCgk6eRHpb
         TMu+mIRz4edTUZYnEugINafNtDH+2nIPqai4oKRqyhbTGWN5Myo/VgpMSgJYuFz+mGvW
         n53J9vGewTrt4m9sO9dlvyzSYM5hpdfExS3/OeQsfSUe1QJ7+6VGXilrqyrQQoNbfjL+
         yjwdPfpavWl1/mrbHgxOeQhvTGC0ayvypjBuwaEjYXy5YqaDpy6qovSHOV5BiZL0RgLq
         W6KA==
X-Forwarded-Encrypted: i=1; AJvYcCW8lXN29eckoihKBCfEYRF6ZNV27an7C4iCt4TjzcBnCxjGMzCG2znioone+XOrCqY4ixOdF44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw3GMVeXXWbKu+vFJ7SPMXN86V7I8t0nS/MMIx/U8Zv46a9JJh
	/X3Vzm5SAiC1nQzPsCx64D2aQovfOgq5dJUhiLgdP/5mJpbK78ODxuCrBG9OIQ8gFT2AVTh7Ndl
	Juj86+jPklEs5hF+2GaiPfrXowNTpk8dSl7Jhod79ap48uLPIw1KhrwWfgbc=
X-Gm-Gg: ASbGncviZQJrEGaCMoAUDwAmhoHvp9WmGr1KNaVnHOc+NI8n+nQ8v+yVLOhbvBDIcyM
	Vz6g/UwOX58OpKr1VaMIwMOLdIrewOucXtNL2PMEhTKkqHEntkzNeRGaqhDs/Im5/454Y9qxAKq
	fXqHV8AQtsUNxQEyt9F0+AvhVF7XKeUikzUH6vzqyJw1SCMdByoT/bXQf9RlgOC5WQkbfJFd9Bs
	sl3KKe4I7TrmXW32yNjvX5+hVI5AIcTvV0Pd6Es74FS0Z8hr+JKbp4SmJvW2/FzTZd6hDqhxmTq
	tzA0SxbT1gtb0uRbi+bbeIQ4LqY5frLQ6BGDi89WgsjvTmR4S6iiJFQmIBBPyu2ildLJjhx81SC
	xFCfLtaRAiZFn5py7LiAU4mlYMcN/MRhe
X-Received: by 2002:a05:6a00:1252:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-7572427b8fdmr36738873b3a.19.1753195025756;
        Tue, 22 Jul 2025 07:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSPhGKEhB0JgMYruRFjOhVDxgydpK42cBLpYkOMPpgZ1BkxU5wACmfS4bw+XPwlWlvSmBTxg==
X-Received: by 2002:a05:6a00:1252:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-7572427b8fdmr36738827b3a.19.1753195025199;
        Tue, 22 Jul 2025 07:37:05 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89cfb3dsm7692085b3a.34.2025.07.22.07.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:37:04 -0700 (PDT)
Message-ID: <83c62cb2-7d85-4a9e-ba76-63faa27faedf@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 07:37:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k_pci: add a soft dependency on qrtr-mhi
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
References: <20221202130600.883174-1-hch@lst.de>
 <0b28bb5f-56b3-4be6-b4f4-89ca546a24d0@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0b28bb5f-56b3-4be6-b4f4-89ca546a24d0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687fa213 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Kj1WHezUp4T6SZPGUyIA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: eUo2tpKhngzhbz2wfKkhbFzNRz_Q1nbU
X-Proofpoint-ORIG-GUID: eUo2tpKhngzhbz2wfKkhbFzNRz_Q1nbU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEyMSBTYWx0ZWRfX/q9YaWWdSGPl
 GsRMAffJajTlHL6D9PMVxvvNjnnlAfxfwQ3HQRO71oXoKZgyKykPE6HtyrP+ap9QO6VMRRMzBnH
 YkkMrS6aBHzAIplmMGIAKkRJ3gXkSRUfjIT0dVZOae2/YD4lykW4cpoZi+0Y3ntvMqYDteRpO19
 4shgFKKqUFCh0DGoUjwkaYQJsFNMBpcnjIksfKGyYRpf1biMLoipRejefpSII6Fw4ejTFbF6YyT
 4TXlwnNjhBqylC5SJumfGcH2YxI4mt1mgPhB6/qF8XR9FyAH43rqgcQ5JXsrEvw3ijAuhhj+89H
 0H3hlN8iqDc4qFYs237j7e8ARVcR829piTd1f22ljYntv3NOjomdlP0Bk3gGWep+BX1SRi+h/30
 zbTPwX1Qn4F2W+ohUDfK10tIkkiP48grAYGI7Tgus1tOZZSLOu34M/0sKJwGbDibQ3Vodhrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220121

On 7/22/2025 1:35 AM, Baochen Qiang wrote:
> 
> 
> On 12/2/2022 9:06 PM, Christoph Hellwig wrote:
>> While ath11k_pci can load without qrtr-mhi, probing the actual hardware
>> will fail when qrtr and qrtr-mhi aren't loaded with
>>
>>    failed to initialize qmi handle: -517
>>
>> Add a MODULE_SOFTDEP statement to bring the module in (and as a hint
>> for kernel packaging) for those cases where it isn't autoloaded already
>> for some reason.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  drivers/net/wireless/ath/ath11k/pci.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
>> index 99cf3357c66e16..9d58856cbf8a94 100644
>> --- a/drivers/net/wireless/ath/ath11k/pci.c
>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
>> @@ -1037,6 +1037,8 @@ module_exit(ath11k_pci_exit);
>>  MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax WLAN PCIe devices");
>>  MODULE_LICENSE("Dual BSD/GPL");
>>  
>> +MODULE_SOFTDEP("pre: qrtr-mhi");
>> +
>>  /* QCA639x 2.0 firmware files */
>>  MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_BOARD_API2_FILE);
>>  MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_AMSS_FILE);
> 
> Do we know why this patch is rejected?

This predates me becoming a maintainer, and I don't see any comment from Kalle
to the patch, however he did have the following comment in a separate thread
where the issue was being discussed:
https://lore.kernel.org/all/87cz8v2xb2.fsf@kernel.org/

> Though I am happy to take your MODULE_SOFTDEP() patch, just wondering if
> there is a better way to solve this. For example net/mac80211 (the
> 802.11 stack) has a lot of crypto dependencies:
>
> 	select CRYPTO
> 	select CRYPTO_LIB_ARC4
> 	select CRYPTO_AES
> 	select CRYPTO_CCM
> 	select CRYPTO_GCM
> 	select CRYPTO_CMAC
> 	select CRC32
>
> And it's not using MODULE_SOFTDEP() at all.

So I'm guessing he considered this to be an issue that should be solved
external to the individual drivers.

/jeff

