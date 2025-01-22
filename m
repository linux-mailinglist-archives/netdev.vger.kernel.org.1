Return-Path: <netdev+bounces-160359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BFBA1961B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16ADF3A5D39
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F9214A89;
	Wed, 22 Jan 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WwlWWVTR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47035211475;
	Wed, 22 Jan 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562067; cv=none; b=W92oIPNCABluR3oyNQtnHti7VMZ+Q664EUYE/TfmgLy5+qT1ZIS26gzk9TJw46HNO8S1I/xG13JGHhcj+fC6p0vQyNS/CnqvvcrjyXRvg85DSFs6m6oFvPAKE3Ejodwi7dabNkbEMkcz88mnDEoxZe2Yj9U/bi4B8uDhLbgcDi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562067; c=relaxed/simple;
	bh=N8Lcwpv5iOKIgrLLyuCoKhjc1BtkjJkyjSyTYUtxe+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PbpX3hwg6+PftpJ32A7nX2iiW/chE1wwPQTSSQTH+vhpUerloJnFO+p8bFHtyr0id1+wniPsMukA8pfQ2Tc4ediKcmW7JuPxYbDccDHecQC2l1gJmyeaURzh2+dGnvax/lsVhhlvdns+i//vEAakg9iTjR8o1D8T8c+h7lwT10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WwlWWVTR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MCPHgu013713;
	Wed, 22 Jan 2025 16:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WYcu5q
	0LTw0tDsc/9X7nacRjTtioaM8Yp0plJ/Pa3nY=; b=WwlWWVTRWi4jVsHTfxYmNK
	4xiknLBbykkGFRW/SxM1034WzILDc0VyYq2KXFjcssuhuG1ngL6QvT5oegqnzRIg
	O/YLCspgTcptX+E5w3NRgSyxNs1nL9OWC6X14MYxdgiNuRIeJUZTMOJZtqU0Io8/
	1CS321CTDIyNSTEFKZZmjcLObFZfxqsBiM0IGbZCLYLAeYDwBycVxEAidXzjN/X9
	Yx0oqPeINcvg6oJHX0qbpuJ7aiJoZwJTeE4XRiTOKALXgQRxI537hRWnYLsQLO8Y
	dvfU2s9yUI9VLk309ghOcyfR0NfGakMuD7ClD4cKB8aPhgJXsWBaESRgAtOSvWDQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9bsx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:07:17 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MG7GSl011167;
	Wed, 22 Jan 2025 16:07:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9bswx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:07:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDlJpP024231;
	Wed, 22 Jan 2025 16:07:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0y9ah7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:07:15 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MG7F6J64815534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:07:15 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04BD158050;
	Wed, 22 Jan 2025 16:07:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57DF158045;
	Wed, 22 Jan 2025 16:07:12 +0000 (GMT)
Received: from [9.61.66.14] (unknown [9.61.66.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 16:07:12 +0000 (GMT)
Message-ID: <e8d21bad-1256-4164-8dca-58b0d46ab556@linux.ibm.com>
Date: Wed, 22 Jan 2025 10:07:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] ARM: dts: aspeed: system1: Update LED gpio name
To: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-8-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-8-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kTanEyNASlBwnHSHa15M-KkxFGz2YbhF
X-Proofpoint-ORIG-GUID: NJGChWaJwrPnO9pTmeEmh6gtygeB9ReJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1011 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=898 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501220115


On 1/16/25 14:35, Ninad Palsule wrote:
> Rename LEDs with meaningful names for easier identification.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 36 +++++++++----------
>   1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index ca55a4fb6dff..1e0b1111ea9a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -116,63 +116,63 @@ vga_memory: region@bf000000 {
>   	leds {
>   		compatible = "gpio-leds";
>   
> -		led-0 {
> +		led-bmc-ready {
>   			gpios = <&gpio0 ASPEED_GPIO(L, 7) GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-1 {
> +		led-bmc-hb {
>   			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-2 {
> +		led-rear-enc-fault0 {
>   			gpios = <&gpio0 ASPEED_GPIO(S, 6) GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-3 {
> +		led-rear-enc-id0 {
>   			gpios = <&gpio0 ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-4 {
> +		led-fan0-fault {
>   			gpios = <&pca3 5 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-5 {
> +		led-fan1-fault {
>   			gpios = <&pca3 6 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-6 {
> +		led-fan2-fault {
>   			gpios = <&pca3 7 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-7 {
> +		led-fan3-fault {
>   			gpios = <&pca3 8 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-8 {
> +		led-fan4-fault {
>   			gpios = <&pca3 9 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-9 {
> +		led-fan5-fault {
>   			gpios = <&pca3 10 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-a {
> +		led-fan6-fault {
>   			gpios = <&pca3 11 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-b {
> +		led-nvmed0-fault {
>   			gpios = <&pca4 4 GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-c {
> +		led-nvmed1-fault {
>   			gpios = <&pca4 5 GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-d {
> +		led-nvmed2-fault {
>   			gpios = <&pca4 6 GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-e {
> +		led-nvmed3-fault {
>   			gpios = <&pca4 7 GPIO_ACTIVE_HIGH>;
>   		};
>   	};
> @@ -368,14 +368,14 @@ &gpio0 {
>   	/*I0-I7*/	"","","","","","","","",
>   	/*J0-J7*/	"","","","","","","","",
>   	/*K0-K7*/	"","","","","","","","",
> -	/*L0-L7*/	"","","","","","","","bmc-ready",
> +	/*L0-L7*/	"","","","","","","","led-bmc-ready",
>   	/*M0-M7*/	"","","","","","","","",
>   	/*N0-N7*/	"pch-reset","","","","","flash-write-override","","",
>   	/*O0-O7*/	"","","","","","","","",
> -	/*P0-P7*/	"","","","","","","","bmc-hb",
> +	/*P0-P7*/	"","","","","","","","led-bmc-hb",
>   	/*Q0-Q7*/	"","","","","","","pch-ready","",
>   	/*R0-R7*/	"","","","","","","","",
> -	/*S0-S7*/	"","","","","","","rear-enc-fault0","rear-enc-id0",
> +	/*S0-S7*/	"","","","","","","led-rear-enc-fault0","led-rear-enc-id0",
>   	/*T0-T7*/	"","","","","","","","",
>   	/*U0-U7*/	"","","","","","","","",
>   	/*V0-V7*/	"","rtc-battery-voltage-read-enable","","power-chassis-control","","","","",

