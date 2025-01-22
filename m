Return-Path: <netdev+bounces-160363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 825AFA1962C
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552713A5DDF
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0DF214A7C;
	Wed, 22 Jan 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y5UbnKq0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A8F211475;
	Wed, 22 Jan 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562299; cv=none; b=NXTLhTgW4HtRP1yhvX/+BidvfFp7REpMS9J1UnD6I/Z41C49bg2iysUO4DLjMMgPj25CmxCLkuaV2w0M31Wy4KriGsms/a0aBmXLWPLVGzvGV4wHdRCZorEqFFk2AxTbxixhw2VBSNntlVusMcScoydZ31e5fX5DaIEc/PLvHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562299; c=relaxed/simple;
	bh=1h5CvTCnATVeGrnRRSKC+cqlhkQiPlNOQ2MnV9wzQj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=unkOsMmyO2fHIF0uMFDVhcWxr7TaewZZnrOTtORa1pn476ZHaJJZxK/7UAWP8Pqc7oNU2fDFz1IJTYOO/6vWso7jV+Aa7bsUUz89SnZoN4ppX6AZKdNjGWJuYTHw0h24lS9XE//g8SgG/GDhVWasdsKIH56XTZ5p/0rYHJYfkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y5UbnKq0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M7XQCM013738;
	Wed, 22 Jan 2025 16:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PztkFg
	57upQfl9uFVIH43wRTzPCQzZPmgJS1hWIsUPw=; b=Y5UbnKq09lf5xMnyzODXzE
	F1VGboZ3m+Y7XTJqgIt5Lef6SVz+4J4hYOZ1HJHoObXAUT8CVL4idNdr4L5HCE7P
	9yDTlPs+4v/UEFcU1T3v1XXzv1+MVcxN4KJ0rx/IKxl3IqM/GGbYvZYP9yb4coU+
	ZYdnyKel7B2V42WHsyOFMOglrXpAABUjxK+NWR0XLxcZ2Qf6Mbr+FMuTbNJ1PuEz
	88FTiZJCKdYrOr6ZePMe2CfJXJU2xwRLsUWF1FZXzbZgCV8PMhhztlsXfTYjSZFe
	BXm7nZIJ5dwXDlQ78EjI469vVF2Raq8CGuNWYk7AHvkSpUQ+fSH/ZJDaH9XD0G/A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp2bjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:11:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MFqPue027924;
	Wed, 22 Jan 2025 16:11:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp2bjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:11:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MD2vpu024241;
	Wed, 22 Jan 2025 16:11:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0y9awu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:11:05 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MGB5IV9634130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:11:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66C1158045;
	Wed, 22 Jan 2025 16:11:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 804CE58050;
	Wed, 22 Jan 2025 16:11:04 +0000 (GMT)
Received: from [9.61.66.14] (unknown [9.61.66.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 16:11:04 +0000 (GMT)
Message-ID: <804bffdf-a029-4bed-a6f1-42cf4c129f2a@linux.ibm.com>
Date: Wed, 22 Jan 2025 10:11:02 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] ARM: dts: aspeed: system1: Remove VRs max8952
To: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-9-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-9-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZcgzZU75w_qF0eNW3_16-1LnugWQ9ohb
X-Proofpoint-GUID: Rx_zD-AK266kWu98eA7hPXtTKYAqCPtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220118


On 1/16/25 14:35, Ninad Palsule wrote:
> Removing voltage regulators max8952 from device tree. Those are fully
> controlled by hardware and firmware should not touch them.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 34 -------------------
>   1 file changed, 34 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index 1e0b1111ea9a..089a8315753a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -486,23 +486,6 @@ eeprom@50 {
>   		compatible = "atmel,24c64";
>   		reg = <0x50>;
>   	};
> -
> -	regulator@60 {
> -		compatible = "maxim,max8952";
> -		reg = <0x60>;
> -
> -		max8952,default-mode = <0>;
> -		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
> -						<1050000>, <950000>;
> -		max8952,sync-freq = <0>;
> -		max8952,ramp-speed = <0>;
> -
> -		regulator-name = "VR_v77_1v4";
> -		regulator-min-microvolt = <770000>;
> -		regulator-max-microvolt = <1400000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
>   };
>   
>   &i2c1 {
> @@ -1198,23 +1181,6 @@ eeprom@50 {
>   		compatible = "atmel,24c64";
>   		reg = <0x50>;
>   	};
> -
> -	regulator@60 {
> -		compatible = "maxim,max8952";
> -		reg = <0x60>;
> -
> -		max8952,default-mode = <0>;
> -		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
> -						<1050000>, <950000>;
> -		max8952,sync-freq = <0>;
> -		max8952,ramp-speed = <0>;
> -
> -		regulator-name = "VR_v77_1v4";
> -		regulator-min-microvolt = <770000>;
> -		regulator-max-microvolt = <1400000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
>   };
>   
>   &i2c11 {

