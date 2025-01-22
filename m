Return-Path: <netdev+bounces-160361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AAEA19624
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD113A5196
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21201214A71;
	Wed, 22 Jan 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KPzIrcaQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B06D211475;
	Wed, 22 Jan 2025 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562148; cv=none; b=MUgvmgr2LDdMvLmhx/bhAg4kwfHR+8Wc+0thkYkjiY4Om2ewg3HksFJSi44JMvRvXywvw/V2pPbzRRJIuhpM+NCnS1ZSjCKhNTmE1m7o2ZFTI/stHG3ORaEvaTVDr6XrHUhRdyKelTEmvSb5kSxdUAMswLOXdusoHpOfs4ezbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562148; c=relaxed/simple;
	bh=DQI+eofE/10PAoicb+qngJMFOw1fW9ZV3LeW5Lua9A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BQcOowCCDsnz3vfbsrsyJ7O5IwwJ6+4/OeuSqgaEmM+Dem4S7qfpupr/SoSER6OKFGbUFoEVBWtdeJW/omA7EWdb3XwmGMMpnNPOBMLEh9fI3kShrBEoP3JwkTgVftXkAHVsbeqfST/gD54oUsB0j7IE685SYf/9K1o/uj9+ZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KPzIrcaQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MFP5lG016311;
	Wed, 22 Jan 2025 16:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XsIby4
	bR5GOqP/Cv+s8O43f+W/x09XgZSgPMR4bkM3k=; b=KPzIrcaQ47YkhM1NCI61wf
	x9Hwtl03TDPkEqIr6C26aKCcXrcA9bqbxqvWwRvGzmasGHLNweUxQ12J6sVbffNU
	uIfowNOi1yBdQuiaJrhW89cC2aR9RnqcwQTNhMYbg/oDfBxY70bjG5BL6p8NFWUY
	5VBhhgx/MlEJeEtYU5pNa8MYDw/6hPdSHjk/4d3ReobQm166GEa2Jq3KE0QkMjOA
	zYwqUWN4F+QEv8OaF9RkCLOHt62w+pkjQ4oI8p3kSEAVuh20yixYgYL4/Wl7t//m
	C/kSzbGagirBY0ysdrS8RZcwI13BSI3TsipuR7CC6f0SqEO5vHEaKvUcH7MgPRcw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44atg82wge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:08:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MFtTq4030173;
	Wed, 22 Jan 2025 16:08:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44atg82wgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:08:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDBQ4f019330;
	Wed, 22 Jan 2025 16:08:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmshc0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:08:32 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MG8W9q15991516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:08:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDD3058050;
	Wed, 22 Jan 2025 16:08:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13C3F58045;
	Wed, 22 Jan 2025 16:08:31 +0000 (GMT)
Received: from [9.61.66.14] (unknown [9.61.66.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 16:08:30 +0000 (GMT)
Message-ID: <7a6d9cea-ae87-46b2-b43c-daa6325bf75d@linux.ibm.com>
Date: Wed, 22 Jan 2025 10:08:28 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/10] ARM: dts: aspeed: system1: Mark GPIO line
 high/low
To: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-10-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-10-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M_fT9WcjVjZCTKLWWgVt48FEY6HcINkh
X-Proofpoint-ORIG-GUID: Ak-1TAAN3GOtGrtJE-O8TGhsb5b43imM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220118


On 1/16/25 14:35, Ninad Palsule wrote:
> - Mark following GPIO lines as input high:
>    - GPIOL4 (reset PCH registers)
>    - GPIOL5 (reset portition of intel ME)
> - Mark isolate errors from cpu1 gpio (GPIOO6) as active low output.
> - The fan controller reset line should be active high.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index 089a8315753a..9abbad07c751 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -383,6 +383,34 @@ &gpio0 {
>   	/*X0-X7*/	"fpga-pgood","power-chassis-good","pch-pgood","","","","","",
>   	/*Y0-Y7*/	"","","","","","","","",
>   	/*Z0-Z7*/	"","","","","","","","";
> +
> +	pin-gpio-hog-0 {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(L, 4) GPIO_ACTIVE_HIGH>;
> +		input;
> +		line-name = "RST_RTCRST_N";
> +	};
> +
> +	pin-gpio-hog-1 {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(L, 5) GPIO_ACTIVE_HIGH>;
> +		input;
> +		line-name = "RST_SRTCRST_N";
> +	};
> +
> +	pin-gpio-hog-2 {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(L, 6) GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "BMC_FAN_E3_SVC_PEX_INT_N";
> +	};
> +
> +	pin-gpio-hog-3 {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(O, 6) GPIO_ACTIVE_LOW>;
> +		output-low;
> +		line-name = "isolate_errs_cpu1";
> +	};
>   };
>   
>   &emmc_controller {

