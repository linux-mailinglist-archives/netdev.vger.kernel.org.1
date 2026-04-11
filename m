Return-Path: <netdev+bounces-277699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLIfKPZR2mmz0AgAu9opvQ
	(envelope-from <netdev+bounces-277699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 15:51:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CB83E02B5
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 15:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD4E301ABB2
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE40285CB9;
	Sat, 11 Apr 2026 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UwoR2E+i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RKGmsWK6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53D248166
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775915446; cv=none; b=u/ayVvvub0YsqRJXQ8A7XhUf2mHkvHi/0YnC8+hf8Hib4LtIOg8ahlRxb1GFScL08SESwrqHkNM8sTZ+jk1CT33/2mLVgR2d/+Q9UMpOpmZuCO1BUnQQGfMD/9HBpRhTXWLn6eoj0LZ7d/Gn0fQUXU+oRR9j4XrejCtHQxG0WdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775915446; c=relaxed/simple;
	bh=jWTEtBSoUuYVX3uYmsPPbfkMn03+61vZqJRvH6Ym1pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fO4NCs3xUGOKd6kTJdi0dLIwO6zQCG+DcktNAJqgpiUZqm7Q0ikGvrOx2MYumqLGO1E5b6Pa7dfIAk7NaocPnEq/uF+5DhveJrhPAYCjz7rDm9QwuG7rFOC8lACU8/WvfLzJjQTIa5zc6EnyMWmRaLMBM0SfNNGv/JKYYCkJSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UwoR2E+i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RKGmsWK6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63B9wD0O324429
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 13:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TYB9dL+sZas18a3SOYDriqRYOhYW5fQ4urBIjpNFZ54=; b=UwoR2E+iBDY/3B3n
	GQbKX+vVChbmoUfY5++ArMGfqzXshl1tVyMAr1zYR1kwTwEXsIe5gRHtcolwVxKT
	TSrnVv7kkxICqLu27KHd0QnkF/NcTHV79jmBe0GijH4xzUxG6BvGqw947+hNNXaC
	5zOUrE1nNBqNTdBYpV6LyktaWE+ME4b6jDIH2OXbEaTM+1I6NWuCj3wdcpbb3onR
	7dXkMHRROpuc9gVWH6klUkEWPoAFphHg/jJ9HdHDBadFsm9SAGKStUWeiP3R/IFs
	U/ik4uHdIzaAQ8uehQzFVglheIYwIIYCSPo6tBftZRmVwbWcxfDo6DJyORVHUNCI
	WuXLSw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfffhrrct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 13:50:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b24308165dso62585535ad.1
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775915443; x=1776520243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYB9dL+sZas18a3SOYDriqRYOhYW5fQ4urBIjpNFZ54=;
        b=RKGmsWK6VyIh/LEnJMielX3qyVt6kEnIqECojPzW3rLPf1pEUwjppxPKweML2Dzfgm
         0Dhf/OyFVJrwkJiZt/a1xR5DUrxxicsIP9YXaUOyNXLeC5Jso6MMOL16QySCraryT/Xk
         jg2D2C7sHmTrmK0JSKg8cw5oTZhoIG5VOm5PVgB2tNE9rpzWkHfJEq91xwhALQIAkEdK
         s787I+o+tCez/3tPdDHB9K93LsdX4ppTRTwkezGOT8e4zSiT4gnqLZLGHH6IAoAHZrHt
         2S39Dah071l9ZMiF9hGBGFEjM9sG686kVRVGq95PqgN7rTgeUaRnlLn9Up+QdRZh8Lxm
         m1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775915443; x=1776520243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYB9dL+sZas18a3SOYDriqRYOhYW5fQ4urBIjpNFZ54=;
        b=kad3mdX/kgQpKE/BbVAmkIQXRuoD8mV++lWQmLtUrT0FobxcTIgeqPiH81VxstN1hL
         ns6DQb+G88fHB+Jgqzr6Eh/kdj8/1HUxBe8DHlegSu5VP6VZ31kp5P3pd1t+4qfm4IW4
         9VSWC0yG6DhDdWJhz9GzRzq6+fr0gOBvYAlJpsOrioLkoIAjb5K8Re+kM/lF+HUdGyIo
         cQXXVllbsdvGIGlHeSzCuj3AFkj1aOG+JFIlqYfFCN70CmSBnE0aJY83btuHzpdivA+Q
         uxXJ18t9zB1KMJR/P3hxp+tHnZiJAD10LsCCKsjXHGmDbKuar0SipQtOVTsDTKqQy5w1
         YNqw==
X-Forwarded-Encrypted: i=1; AJvYcCUzThD6Xn0Rl571lWY3Uez+GSU8qmLyphU62mEupW8noI4C8pwPOkEQVCWnEtc6PXrM1yVV1BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6S7ONOGd83zsQSnx0AkR9SfZB/7leob9S+1kb5blMzlzw7hlr
	jCMlomCuWgl7yWl5XqewH4oyi5GNuvEBWy015EWWhI+edDtLyV38tN7KLD5N/dWWx/NWJ+ZVouR
	XfpyjkFNSag+k3+eff+P24sL1Q+FiVJWNMsVscqOoCvIaai995fjkBDwbcFk=
X-Gm-Gg: AeBDietpzKf09g99gRxCYeRKdcqGaInAH9cFW3kHy42l8/SXxr78mSZvP/n8A5D52vC
	gMafoWu3kIzGTJD7MW/MtMv3cehMZlsNKjbqWH+f5e/Q7thga42I8DhVIBlMfZ0mxfLMixISH+c
	KLjYr9bC5Yi4bkcGCfjU0HynomKGhPQnrt7LnfrbABGp08H1zQeeNiYd656bEANJKWcaFsZ4+Gv
	8trTrxmMDe9BPHOBpzgiG3fE/9v4BCxgjwpmCZpF0+iS8P0i2E7PeIQl17kyd/373+/f8nguTbj
	Z/BJgyuwHxy78RITl6T2pWz9Xv36jikDjVftwlS0bzxiZcVURK+kE4vSkivQOz1wLjSQBwle2zP
	U/WjZkDrvQ4ruCgp+4uq9Rv+DwjZHg15pwLGHKT9sd2l+Vk+2XrNJfPewnfCK7kUt4NH3pVfVjy
	po1XJmbSNMyw==
X-Received: by 2002:a17:902:e193:b0:2b0:72c7:3ed8 with SMTP id d9443c01a7336-2b2d5a2c1d8mr54178865ad.25.1775915443324;
        Sat, 11 Apr 2026 06:50:43 -0700 (PDT)
X-Received: by 2002:a17:902:e193:b0:2b0:72c7:3ed8 with SMTP id d9443c01a7336-2b2d5a2c1d8mr54178635ad.25.1775915442781;
        Sat, 11 Apr 2026 06:50:42 -0700 (PDT)
Received: from [10.133.33.83] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0b284sm61643745ad.52.2026.04.11.06.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 06:50:42 -0700 (PDT)
Message-ID: <21f823b7-3140-4436-a4d4-6fb7b6cf8d5b@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 21:50:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] bus: mhi: host: mhi_phc: Add support for PHC over
 MHI
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
References: <20260411-tsc_timesync-v2-0-6f25f72987b3@oss.qualcomm.com>
 <20260411-tsc_timesync-v2-6-6f25f72987b3@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260411-tsc_timesync-v2-6-6f25f72987b3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDExOCBTYWx0ZWRfX6tBDOtLgSXz1
 AeGX/ObMm9++kv8upTLPmskvFKcIiCaG5ovAPS3hyel7NIxFPq3bn/HtqSI7otAzrVAyAJfV5t1
 gbM+jxBCkJX7Hi+iw8YPINPglXLRJHn7pXQUYp0kmNtND8ltCmVDuEs3gLXXn6czEP/NGdWP98z
 +iXdCRlu34jy1sMsJKB+BJE2+tzSXyJpayAclmojLWKJu1HHUDXlUwIhEUb3S+zy3conu4Ga/vJ
 N77LSNZetuRaDTh5ZSraRPTd6IbdLEZD3z0hDhkAPHfanZoDERhFVYtMcaQN6j+GX0tjySKRN54
 vXc8goYW/sY7A6ZbFuajM+f3PFhMzHNgpa/KG3JEtIP5M4CPE7sKj/7HWruExa81441ntpZIjRu
 nn+AO+LJUk3IMrONx7hSD/Nn5tlZOi/7hq8b309DTNrvpneDmDirt40sXfetcas1ie65VNsyMNB
 EDCm93F4vfbaJPQp4sw==
X-Proofpoint-ORIG-GUID: n_2DFxoka-IxszGOyVXP5bUR_Pfkbxe4
X-Authority-Analysis: v=2.4 cv=FOkrAeos c=1 sm=1 tr=0 ts=69da51b4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=TlgILChHWuASUgA4TAAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: n_2DFxoka-IxszGOyVXP5bUR_Pfkbxe4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110118
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-277699-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jie.gan@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F1CB83E02B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/11/2026 4:12 PM, Krishna Chaitanya Chundru wrote:
> From: Imran Shaik <imran.shaik@oss.qualcomm.com>
> 
> This patch introduces the MHI PHC (PTP Hardware Clock) driver, which
> registers a PTP (Precision Time Protocol) clock and communicates with
> the MHI core to get the device side timestamps. These timestamps are
> then exposed to the PTP subsystem, enabling precise time synchronization
> between the host and the device.
> 
> The following diagram illustrates the architecture and data flow:
> 
>   +-------------+    +--------------------+    +--------------+
>   |Userspace App|<-->|Kernel PTP framework|<-->|MHI PHC Driver|
>   +-------------+    +--------------------+    +--------------+
>                                                       |
>                                                       v
>   +-------------------------------+         +-----------------+
>   | MHI Device (Timestamp source) |<------->| MHI Core Driver |
>   +-------------------------------+         +-----------------+
> 
> - User space applications use the standard Linux PTP interface.
> - The PTP subsystem routes IOCTLs to the MHI PHC driver.
> - The MHI PHC driver communicates with the MHI core to fetch timestamps.
> - The MHI core interacts with the device to retrieve accurate time data.
> 
> Co-developed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>   drivers/bus/mhi/host/Kconfig       |   8 ++
>   drivers/bus/mhi/host/Makefile      |   1 +
>   drivers/bus/mhi/host/mhi_phc.c     | 150 +++++++++++++++++++++++++++++++++++++
>   drivers/bus/mhi/host/mhi_phc.h     |  28 +++++++
>   drivers/bus/mhi/host/pci_generic.c |  23 ++++++
>   5 files changed, 210 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/Kconfig b/drivers/bus/mhi/host/Kconfig
> index da5cd0c9fc620ab595e742c422f1a22a2a84c7b9..b4eabf3e5c56907de93232f02962040e979c3110 100644
> --- a/drivers/bus/mhi/host/Kconfig
> +++ b/drivers/bus/mhi/host/Kconfig
> @@ -29,3 +29,11 @@ config MHI_BUS_PCI_GENERIC
>   	  This driver provides MHI PCI controller driver for devices such as
>   	  Qualcomm SDX55 based PCIe modems.
>   
> +config MHI_BUS_PHC
> +	bool "MHI PHC driver"
> +	depends on MHI_BUS_PCI_GENERIC
> +	help
> +	  This driver provides Precision Time Protocol (PTP) clock and
> +	  communicates with MHI PCI driver to get the device side timestamp,
> +	  which enables precise time synchronization between the host and
> +	  the device.
> diff --git a/drivers/bus/mhi/host/Makefile b/drivers/bus/mhi/host/Makefile
> index 859c2f38451c669b3d3014c374b2b957c99a1cfe..5ba244fe7d596834ea535797efd3428963ba0ed0 100644
> --- a/drivers/bus/mhi/host/Makefile
> +++ b/drivers/bus/mhi/host/Makefile
> @@ -4,3 +4,4 @@ mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
>   
>   obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
>   mhi_pci_generic-y += pci_generic.o
> +mhi_pci_generic-$(CONFIG_MHI_BUS_PHC) += mhi_phc.o
> diff --git a/drivers/bus/mhi/host/mhi_phc.c b/drivers/bus/mhi/host/mhi_phc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..fa04eb7f6025fa281d86c0a45b5f7d3e61f5ce12
> --- /dev/null
> +++ b/drivers/bus/mhi/host/mhi_phc.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025, Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mhi.h>
> +#include <linux/ptp_clock_kernel.h>
> +#include "mhi_phc.h"
> +
> +#define NSEC 1000000000ULL
> +
> +/**
> + * struct mhi_phc_dev - MHI PHC device
> + * @ptp_clock: associated PTP clock
> + * @ptp_clock_info: PTP clock information
> + * @mhi_dev: associated mhi device object
> + * @lock: spinlock
> + * @enabled: Flag to track the state of the MHI device
> + */
> +struct mhi_phc_dev {
> +	struct ptp_clock *ptp_clock;
> +	struct ptp_clock_info  ptp_clock_info;
> +	struct mhi_device *mhi_dev;
> +	spinlock_t lock;
> +	bool enabled;
> +};
> +
> +static int qcom_ptp_gettimex64(struct ptp_clock_info *ptp, struct timespec64 *ts,
> +			       struct ptp_system_timestamp *sts)
> +{
> +	struct mhi_phc_dev *phc_dev = container_of(ptp, struct mhi_phc_dev, ptp_clock_info);
> +	struct mhi_timesync_info time;
> +	ktime_t ktime_cur;
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&phc_dev->lock, flags);
> +	if (!phc_dev->enabled) {
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	ret = mhi_get_remote_tsc_time_sync(phc_dev->mhi_dev, &time);

mhi_get_remote_tsc_time_sync -> mhi_device_get_sync -> 
__mhi_device_get_sync -> wait_event_timeout (can sleep with spinlock)

Be careful to use the spinlock here.

Thanks,
Jie

> +	if (ret)
> +		goto err;
> +
> +	ktime_cur = time.t_dev_hi * NSEC + time.t_dev_lo;
> +	*ts = ktime_to_timespec64(ktime_cur);
> +
> +	dev_dbg(&phc_dev->mhi_dev->dev, "TSC time stamps sec:%u nsec:%u current:%lld\n",
> +		time.t_dev_hi, time.t_dev_lo, ktime_cur);
> +
> +	/* Update pre and post timestamps for PTP_SYS_OFFSET_EXTENDED*/
> +	if (sts != NULL) {
> +		sts->pre_ts = ktime_to_timespec64(time.t_host_pre);
> +		sts->post_ts = ktime_to_timespec64(time.t_host_post);
> +		dev_dbg(&phc_dev->mhi_dev->dev, "pre:%lld post:%lld\n",
> +			time.t_host_pre, time.t_host_post);
> +	}
> +
> +err:
> +	spin_unlock_irqrestore(&phc_dev->lock, flags);
> +
> +	return ret;
> +}
> +
> +int mhi_phc_start(struct mhi_controller *mhi_cntrl)
> +{
> +	struct mhi_phc_dev *phc_dev = dev_get_drvdata(&mhi_cntrl->mhi_dev->dev);
> +	unsigned long flags;
> +
> +	if (!phc_dev) {
> +		dev_err(&mhi_cntrl->mhi_dev->dev, "Driver data is NULL\n");
> +		return -ENODEV;
> +	}
> +
> +	spin_lock_irqsave(&phc_dev->lock, flags);
> +	phc_dev->enabled = true;
> +	spin_unlock_irqrestore(&phc_dev->lock, flags);
> +
> +	return 0;
> +}
> +
> +int mhi_phc_stop(struct mhi_controller *mhi_cntrl)
> +{
> +	struct mhi_phc_dev *phc_dev = dev_get_drvdata(&mhi_cntrl->mhi_dev->dev);
> +	unsigned long flags;
> +
> +	if (!phc_dev) {
> +		dev_err(&mhi_cntrl->mhi_dev->dev, "Driver data is NULL\n");
> +		return -ENODEV;
> +	}
> +
> +	spin_lock_irqsave(&phc_dev->lock, flags);
> +	phc_dev->enabled = false;
> +	spin_unlock_irqrestore(&phc_dev->lock, flags);
> +
> +	return 0;
> +}
> +
> +static struct ptp_clock_info qcom_ptp_clock_info = {
> +	.owner    = THIS_MODULE,
> +	.gettimex64 =  qcom_ptp_gettimex64,
> +};
> +
> +int mhi_phc_init(struct mhi_controller *mhi_cntrl)
> +{
> +	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
> +	struct mhi_phc_dev *phc_dev;
> +	int ret;
> +
> +	phc_dev = devm_kzalloc(&mhi_dev->dev, sizeof(*phc_dev), GFP_KERNEL);
> +	if (!phc_dev)
> +		return -ENOMEM;
> +
> +	phc_dev->mhi_dev = mhi_dev;
> +
> +	phc_dev->ptp_clock_info = qcom_ptp_clock_info;
> +	strscpy(phc_dev->ptp_clock_info.name, mhi_dev->name, PTP_CLOCK_NAME_LEN);
> +
> +	spin_lock_init(&phc_dev->lock);
> +
> +	phc_dev->ptp_clock = ptp_clock_register(&phc_dev->ptp_clock_info, &mhi_dev->dev);
> +	if (IS_ERR(phc_dev->ptp_clock)) {
> +		ret = PTR_ERR(phc_dev->ptp_clock);
> +		dev_err(&mhi_dev->dev, "Failed to register PTP clock\n");
> +		phc_dev->ptp_clock = NULL;
> +		return ret;
> +	}
> +
> +	dev_set_drvdata(&mhi_dev->dev, phc_dev);
> +
> +	dev_dbg(&mhi_dev->dev, "probed MHI PHC dev: %s\n", mhi_dev->name);
> +	return 0;
> +};
> +
> +void mhi_phc_exit(struct mhi_controller *mhi_cntrl)
> +{
> +	struct mhi_phc_dev *phc_dev = dev_get_drvdata(&mhi_cntrl->mhi_dev->dev);
> +
> +	if (!phc_dev)
> +		return;
> +
> +	/* disable the node */
> +	ptp_clock_unregister(phc_dev->ptp_clock);
> +	phc_dev->enabled = false;
> +}
> diff --git a/drivers/bus/mhi/host/mhi_phc.h b/drivers/bus/mhi/host/mhi_phc.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..e6b0866bc768ba5a8ac3e4c40a99aa2050db1389
> --- /dev/null
> +++ b/drivers/bus/mhi/host/mhi_phc.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2025, Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifdef CONFIG_MHI_BUS_PHC
> +int mhi_phc_init(struct mhi_controller *mhi_cntrl);
> +int mhi_phc_start(struct mhi_controller *mhi_cntrl);
> +int mhi_phc_stop(struct mhi_controller *mhi_cntrl);
> +void mhi_phc_exit(struct mhi_controller *mhi_cntrl);
> +#else
> +static inline int mhi_phc_init(struct mhi_controller *mhi_cntrl)
> +{
> +	return 0;
> +}
> +
> +static inline int mhi_phc_start(struct mhi_controller *mhi_cntrl)
> +{
> +	return 0;
> +}
> +
> +static inline int mhi_phc_stop(struct mhi_controller *mhi_cntrl)
> +{
> +	return 0;
> +}
> +
> +static inline void mhi_phc_exit(struct mhi_controller *mhi_cntrl) {}
> +#endif
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index b1122c7224bdd469406d96af6d3df342040e1002..6cba5cecd1adb40396bba30c9b2a551898dce871 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -16,6 +16,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/timer.h>
>   #include <linux/workqueue.h>
> +#include "mhi_phc.h"
>   
>   #define MHI_PCI_DEFAULT_BAR_NUM 0
>   
> @@ -1044,6 +1045,7 @@ struct mhi_pci_device {
>   	struct timer_list health_check_timer;
>   	unsigned long status;
>   	bool reset_on_remove;
> +	bool mhi_phc_init_done;
>   };
>   
>   #ifdef readq
> @@ -1084,6 +1086,7 @@ static void mhi_pci_status_cb(struct mhi_controller *mhi_cntrl,
>   			      enum mhi_callback cb)
>   {
>   	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
> +	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
>   
>   	/* Nothing to do for now */
>   	switch (cb) {
> @@ -1091,9 +1094,21 @@ static void mhi_pci_status_cb(struct mhi_controller *mhi_cntrl,
>   	case MHI_CB_SYS_ERROR:
>   		dev_warn(&pdev->dev, "firmware crashed (%u)\n", cb);
>   		pm_runtime_forbid(&pdev->dev);
> +		/* Stop PHC */
> +		if (mhi_cntrl->tsc_timesync)
> +			mhi_phc_stop(mhi_cntrl);
>   		break;
>   	case MHI_CB_EE_MISSION_MODE:
>   		pm_runtime_allow(&pdev->dev);
> +		/* Start PHC */
> +		if (mhi_cntrl->tsc_timesync) {
> +			if (!mhi_pdev->mhi_phc_init_done) {
> +				mhi_phc_init(mhi_cntrl);
> +				mhi_pdev->mhi_phc_init_done = true;
> +			}
> +
> +			mhi_phc_start(mhi_cntrl);
> +		}
>   		break;
>   	default:
>   		break;
> @@ -1236,6 +1251,10 @@ static void mhi_pci_recovery_work(struct work_struct *work)
>   
>   	pm_runtime_forbid(&pdev->dev);
>   
> +	/* Stop PHC */
> +	if (mhi_cntrl->tsc_timesync)
> +		mhi_phc_stop(mhi_cntrl);
> +
>   	/* Clean up MHI state */
>   	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
>   		mhi_power_down(mhi_cntrl, false);
> @@ -1457,6 +1476,10 @@ static void mhi_pci_remove(struct pci_dev *pdev)
>   		timer_delete_sync(&mhi_pdev->health_check_timer);
>   	cancel_work_sync(&mhi_pdev->recovery_work);
>   
> +	/* Remove PHC */
> +	if (mhi_cntrl->tsc_timesync)
> +		mhi_phc_exit(mhi_cntrl);
> +
>   	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
>   		mhi_power_down(mhi_cntrl, true);
>   		mhi_unprepare_after_power_down(mhi_cntrl);
> 


