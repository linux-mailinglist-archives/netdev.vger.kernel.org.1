Return-Path: <netdev+bounces-150428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C110E9EA36B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240691633D0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F38382;
	Tue, 10 Dec 2024 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SSq5orQO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8F1853
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789494; cv=none; b=DCHIcvjTMBgT6X4DmELK9BHY8MCLV1S+3JF6ARwysHZRHOS9wR+ZBuq0irgwlMNBittMvXRTpO+qijK00k1TEvgcbZ0GzsSTNPio98t/YwkF2oLJWKsmnoFwUTEHjSyoReT9rvSiK8KPc3GQsecqKLXjhrPp9etwNcYgC4LFRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789494; c=relaxed/simple;
	bh=VEtp0knia/Qap1WL6B6iCGybSe5jo49ooZBRr1l+R8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivaaAhSDYZmm4HFr18PPZQXqbs2XeCA2P6/HFMZvRPqKmtWwcevHJaSBKq7A/m7gknti/LrqrTLSGpq1YLnvzFPauoWuEdhYq3si5npBd2QG+fK9hkG9KVcXbLgXrj/Cw2Nzaa0BkWTwUirCMEUsQJMMGnOaoNjer+/P4zSalio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SSq5orQO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9KgFYQ002439
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VEtp0knia/Qap1WL6B6iCGybSe5jo49ooZBRr1l+R8k=; b=SSq5orQOYpOm4vgm
	q1iCclm0viPSKAkxC4C4fqCbC47wj5sulpWC7FzI5cg4Bx3THR8KrzlfhqULNSm2
	D49tYPOnlaLlXQvZSjx7lLY+oUyfRQyJSwwZGV8NKOhe4g3Iy1uXbUxLNnSLsbZA
	047893UdRTYT1XURXPO6E9IpsOaSpPFc2mhKEbkPU88uIXhFEAqt6V9hqPELV9NJ
	gNLwdrjeeLMQ1DPwvR8Tb/67QZ6rl7yB/9SYLzUPUrUbEPzGJVYo4kBQYFtcEHIy
	FTQ2OIcGGeiqTiOMrIQcwpADohQKecZ3TX/KZ1mis81++aPaPUG7NeYNPlpa5y6g
	rxR5Bw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cfhkebya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:11:31 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7250da8a2a5so4258879b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 16:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789490; x=1734394290;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEtp0knia/Qap1WL6B6iCGybSe5jo49ooZBRr1l+R8k=;
        b=L/li5qo6VrBtUZ6SSZYJDYJiCCXvPgkIiN4hewLBi/8RrYOwrRqQEeOoRRvmXkIpwD
         S9OMAmR6iqq344aO02wXnYxbwIIwCTvOfRzlMnegg+z/EMKrd/5FfKh6eoMdeSLBJL+I
         wZlnc3ASnmryPP+JzVaIasfxR3P9qxIBu8f1/jLbev50pRC6//DpPRflwqUDKkN9MXyN
         gPhGcd6boLkQUoH1A6M2um9Op7euOCx810Gpz1e1E24p64ykRTdAg7ZSf4zRTY41meyf
         H03WJb3ZZMFGYeSAgGaSTx2h+CIs2OBW9hGydHykjwfNzt4zmgSiJKwb6+W5KWwN/31+
         Ia9A==
X-Forwarded-Encrypted: i=1; AJvYcCX17M/rBn83keFb1GLK5XXS8XiyrHqsu+AIrwwRDwXfTASUQk8AOFxOV/ZIz9kRsUzd8VLjfpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSr3GLG4UvVFQrOdFu0OtaDbX54KbC7Zh7i2jrvxcnpi1i3TE
	1kUdsvol6heAPbZ8ujNX7ArfAsfSQpH+fIckjW02XmtBwkMZKHrDNzCaaG1ql5cP51HRcZbW4Xp
	nRrAHm3VKpcq9GXU+H9J7QOZ3acSLm2aGUeGVXhWI1Wvbw0LMTMf6IPs8KJ87qY4=
X-Gm-Gg: ASbGnct90QdvP1VnPc5MoXvYZcTrh7DvKnJJu9cMrtspJBhSl0IUiRcnGC6lGt6UJP0
	IPdRLp5Mx3qH0Q5I/cEq5Yb8G2Gp0D6VqY+OiKRsUsZuWXpGQtdWfXO9d3gQRDqPQtsEiE8VsZ1
	z4PY+kA3y+SXAnqVuL5g1i0P4C9K54/SoEQrsv+BOrNq2B9RCKEp8ueksX2HPd4reyCA8O5xFtR
	FzRO+GuyhJvOuZOJf8oEpvESrrjiRUevMaadnijmTG9f5Za+xDeIReFJqR4RdS/PVPv1c3QRslk
	EPq24/yce4OT/ig=
X-Received: by 2002:a05:6a20:7484:b0:1e1:a932:4a3f with SMTP id adf61e73a8af0-1e1b1a783a5mr3855839637.3.1733789490468;
        Mon, 09 Dec 2024 16:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjif/K64jvxybmSh3SBtO+hmuIEs0a16SLB2ogfaLGBmJItTEBItM2gtpooVd1TW5buJefkA==
X-Received: by 2002:a05:6a20:7484:b0:1e1:a932:4a3f with SMTP id adf61e73a8af0-1e1b1a783a5mr3855769637.3.1733789489445;
        Mon, 09 Dec 2024 16:11:29 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a8f5ddsm8137730b3a.130.2024.12.09.16.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 16:11:29 -0800 (PST)
Message-ID: <3039e155-4fe5-46bf-82f2-cc273ba19983@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 16:11:27 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] net-next/yunsilicon: Add yunsilicon xsc driver
 basic framework
To: Tian Xin <tianx@yunsilicon.com>, netdev@vger.kernel.org,
        davem@davemloft.net
Cc: weihg@yunsilicon.com
References: <20241209071101.3392590-2-tianx@yunsilicon.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241209071101.3392590-2-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IN_m1SeJXyiPN-Lw2thqz2kEdfeRNdx4
X-Proofpoint-GUID: IN_m1SeJXyiPN-Lw2thqz2kEdfeRNdx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=983 mlxscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090188

On 12/8/24 23:10, Tian Xin wrote:
...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> new file mode 100644
> index 000000000..1d26ffa8d
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> @@ -0,0 +1,278 @@
...
> +module_init(xsc_init);
> +module_exit(xsc_fini);
> +
> +MODULE_LICENSE("GPL");
> +

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning with make W=1. Please add a MODULE_DESCRIPTION()
to avoid this warning.

/jeff

