Return-Path: <netdev+bounces-208826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BD2B0D4C2
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 10:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25C41AA7D32
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB802D3EDA;
	Tue, 22 Jul 2025 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1lI7noR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873C2D3EDD
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173356; cv=none; b=Ohv2lP1PZIiOfXzQkFl1nmyUT+66mVyXF1H/eWfiVlUozmfdGp3Jn4j0q1rzkZiY2Sum1tPDejSfnAZBv7CWLA7PjVnhizXHvk+DMI9uUwxPQxHePIKQs+ktp7tPpRvTYnNRDba6myx5+mViguCgOd6DMKWCFMWs93Pl9rjaeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173356; c=relaxed/simple;
	bh=foXUIgStGDglp8soaKzHpgchVPakvD0gG4XkkGSqNIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjTgRbTcBvsJ/MK+TMjabG7SHLSSxshxLDjlj5hB0iSkdGAUKLJxGGxQ4m0ADeb9Oxn3HGe3L5pBkua4JB3l3meU6JB+Pq3pwgxt5exepf7/IKZrPAsft8gCDt6RdzVTFoXQmD2/eIY3eqf/wn9vVyMI32rdCJpZrJk+FjoyG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1lI7noR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7lXkW004629
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v1CPlPbwtTVjIc8HWeOwVxWexCvpUqlAqvq7jTFTfSM=; b=Q1lI7noRzvDFvPCU
	3M4pyUqyo1Z5L85dZNCwP2tRgZ6Ll7/0wsZObSzkJRJkYfPx8ot0nWCk5nZelo4p
	DjqwhWvqJPJGTxgy9USzzfvGnZh6HVCnvXJODTdwJy04RlOINBsym3ih2itgH/AT
	r8+1CTwFQkyV8GY8zDRNr+fF2jQt9u9qkXHGMaj4dp4EkJ7b8ewo9DhIvhuq640a
	P3cLJuTnmWC6BsEbfU2zGEfhmyFQGCZYc8Wrf9xe71fiBc0ezq31KnLIH/f2gMl6
	HXRy68e9hiGcHKXXWkCVBh38jy28J4dX6MXv+OO9o36TiZHWDqR999IcXvbr9rQ+
	amBX9g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v72rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:35:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b00e4358a34so3404643a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 01:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753173353; x=1753778153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1CPlPbwtTVjIc8HWeOwVxWexCvpUqlAqvq7jTFTfSM=;
        b=mf2iffLRF2yTwo9Q9hggcQLIyIN54YcWLML0XZme3cf34TElb8oMDKROTJd2LBH9cF
         6hNU4LGuhrIDZAk0AuvugO2SVTwX5TE4UYPiE3d3N/MiJo03BBcvF0C0emEvU2oTtm30
         k6u4wbXkVqZ7qMnYj4K0Vcj3F+GJxvlAyrWinn/+tQhUDR7mwFbjusaDwHUlqjNn7vA2
         Vvf+Kpxds5VL/zAbTIlE8xeLO8RmubDOReJH01jOnjOsiEUY2IkdmFXNp7daELONF8Um
         zFV1EBoFtlK7+kRIFCSqCt9JFYdAxI0JqBIov7cFDyZrABWeCFCKdWZPi84APFFF2SCw
         6+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWRGDa8xzSoXBqdwnCB6wG3uhChwU4E2b3IZWTVedaijkPo8ilEp4DLZoSgF7w+SfRgWAPCFow=@vger.kernel.org
X-Gm-Message-State: AOJu0YztAlMqVLEcbwhRu9Xqwm4t3AIKlzFQs5GO7DDF1yRgN5yvTnRk
	5fiEnbaZ0FJMRt70+XcYbbUbhU43uV4rrJystkjDiXsDYQt6QclEKBJ2dOqQSPSXwZijzgo68HD
	5O0gGty/et0IhuCHsIowHkzkhPomxIsydur2NJI/TCK8MjdqVVI7CbJl0G/M=
X-Gm-Gg: ASbGnct271KpMf+oAKfiX7/2kpFIswzeG5iWooQSukNAiOBH7arjEr5xK5uNjLQ6Ium
	JJZEpo+rz/xFH44XBVpjo52v3nebHadjvAEq68LpyaT6gx+rzd31gbNifEm3UOiqufIMpk5wISp
	O4Tw635oO9VP0V42ol8b9FsSh8H4yoMN5fv9wgd7Ay8c/ITeWv7qruJJHZI2nDEzOJkKEBnqTd8
	1ZuJ6FgQ7ZCbZqRjG4iMLCsxW9GSJ68j+oRZ6ccjKYjE42CEabx1Q+9lFJdTWquoxPPE+gN7Av/
	0/pC0LfXV2KudNGypqwzlihpnYb5t81jmmm/vvUSoj3gge3+j0cZ6S2gZp4KY4ZEZLlydNuKFb9
	2EGa3i0GKHk+3/Aa53DjMzh2PrH3RTY8=
X-Received: by 2002:a05:6a20:2588:b0:220:1ca5:957c with SMTP id adf61e73a8af0-23814269fa7mr47543363637.31.1753173352921;
        Tue, 22 Jul 2025 01:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxQoVSL6iDytp5HaUmhxPmpFMPPetP7b0Xmv7yoM9vlNb9LHyBBh/GNPcPF++PFFEUqYTYnw==
X-Received: by 2002:a05:6a20:2588:b0:220:1ca5:957c with SMTP id adf61e73a8af0-23814269fa7mr47543312637.31.1753173352439;
        Tue, 22 Jul 2025 01:35:52 -0700 (PDT)
Received: from [10.133.33.45] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbd66eecsm7175486b3a.142.2025.07.22.01.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 01:35:52 -0700 (PDT)
Message-ID: <0b28bb5f-56b3-4be6-b4f4-89ca546a24d0@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 16:35:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k_pci: add a soft dependency on qrtr-mhi
To: Christoph Hellwig <hch@lst.de>, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
References: <20221202130600.883174-1-hch@lst.de>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20221202130600.883174-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yGzOUPHlXytlpUyIE6T7bSUL9Y1Mcm-a
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687f4d6a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=dBPL878wbgeN_2oxvkwA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA2OSBTYWx0ZWRfX9UkmAMdliLjX
 lEzisgWX3tSO1qMFhb5pIel1G9sy+bhPaAsJVjZbUZe6UxfB/wSwTuU7wHVqyIEWxFzQEeDug8Z
 oe4rbrOQ3ciftuwULfI/eQBIKWqRDxNU1JDo9RCRqI0Yqv3tjc73Fs8F24CKv7GKIAZKEzNEK8b
 B9D2WWyBrWwg7KrLq55dVtE4Scnx6n59ulRXOx665hvbQ/sVi7lWCrYlcGzK1MDO8e65QlLkn88
 8qGyfgBoQUUpoA7fvxW8S8TTSnq1Lp4Rw8BHXnidAEVVqxzSggpAIzyFHE0DmBuhF6B9CtcH9Ln
 LR24jWkfNqQfJ6SPcV/e03jdkahpNS6ma1B2rPociYCGh/3keE3UUVMsUlhXr4WP9o/Blhy+DJo
 d+05zinPI3P11ed/TtXwX9Jc/NqxcYIb07epgyae04sZuNEhDCVHrPpv8IfLMgBNkJu1hSll
X-Proofpoint-ORIG-GUID: yGzOUPHlXytlpUyIE6T7bSUL9Y1Mcm-a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220069



On 12/2/2022 9:06 PM, Christoph Hellwig wrote:
> While ath11k_pci can load without qrtr-mhi, probing the actual hardware
> will fail when qrtr and qrtr-mhi aren't loaded with
> 
>    failed to initialize qmi handle: -517
> 
> Add a MODULE_SOFTDEP statement to bring the module in (and as a hint
> for kernel packaging) for those cases where it isn't autoloaded already
> for some reason.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/net/wireless/ath/ath11k/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index 99cf3357c66e16..9d58856cbf8a94 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -1037,6 +1037,8 @@ module_exit(ath11k_pci_exit);
>  MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax WLAN PCIe devices");
>  MODULE_LICENSE("Dual BSD/GPL");
>  
> +MODULE_SOFTDEP("pre: qrtr-mhi");
> +
>  /* QCA639x 2.0 firmware files */
>  MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_BOARD_API2_FILE);
>  MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_AMSS_FILE);

Do we know why this patch is rejected?


