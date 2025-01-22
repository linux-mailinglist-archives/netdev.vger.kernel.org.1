Return-Path: <netdev+bounces-160357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D5A19608
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329403A4AE2
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5367021480F;
	Wed, 22 Jan 2025 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cYTaAN1L"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2821211287;
	Wed, 22 Jan 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561923; cv=none; b=L8kkEo8EzwXpUpcK0bxnxWTaCMrdOQFgZMmolQ5KtTxaIPnl1CBA1I/e3BT/O5lEnQmCT1bJQiiG6m4tgbj3jre4EAO8Gpn84PhHwVTOSkmRu7ZGyonZNo1IIPMKYGp9rJQX4D5qC1KyqRt6nUemCeVAmPGHqEo0Z3YQf98bmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561923; c=relaxed/simple;
	bh=E0NWfKSrxm/Q6s2QOjOA13QMPomqOo7VyVsE3+y/PP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MI0P61yrUtkqNAdYwbDCnP6UDjVu0TCVLvoLFx2hpI/7u4DBAOjWEDpEP0IfjceTcrvXNk8GEx9xk89wI16LFuJ0h9HIk+1SVnd20abA9Corpe0PSvQHQfbWo4aj7PbWFAB46Xc7WalcAHJWUhZI2N67mbzGCxle2avsUyOqKUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cYTaAN1L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M7Wu3g012829;
	Wed, 22 Jan 2025 16:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q2ub9z
	L+dX4HfWghjeSU/uYyolAvvvvHUZ+3ezdkEbY=; b=cYTaAN1L5CwFBHJvu1UfeV
	N6QfMDZEfz8EaKRjftMqZeVbPDKlBkFQtTCe/YMUxAOr+nPMECnBbZjLMUuKANsR
	tknJ2X3cZ04wNr4+4a6tHrz6GZwKedT8VNkPoJxIo9gF2qykEHJq5gQUYJ6pxHCD
	kgUlgScH9DvUpYBMe6E+5BAxc7psQB2C5X0HqTJ7VglcyRvTr7FaoZJvafZwc6Km
	2JSOMoWpyjBoxBRG5iHE38YSXzbWh6QTukQmvwnE7eh8/O0UY/HClZP6yO0F3KGq
	/fLQ2JqphfgOyzmwjnLvfLvZYrW1HQWqd9T/nlKUDw9wzwp1sAJtAH8bGJF7dSaA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp2akx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:04:47 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MFTGTm008895;
	Wed, 22 Jan 2025 16:04:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp2aku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:04:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MD6dHd019252;
	Wed, 22 Jan 2025 16:04:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmshbhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:04:46 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MG4jNX27329040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:04:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B69B58045;
	Wed, 22 Jan 2025 16:04:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6708058050;
	Wed, 22 Jan 2025 16:04:44 +0000 (GMT)
Received: from [9.61.66.14] (unknown [9.61.66.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 16:04:44 +0000 (GMT)
Message-ID: <3628ffd5-e1bd-4092-9b19-ebb0bfdd5b33@linux.ibm.com>
Date: Wed, 22 Jan 2025 10:04:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/10] ARM: dts: aspeed: system1: Add GPIO line name
To: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-6-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-6-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hIuAdrje0LogGtfM8pFI2jTDgtcyHuq_
X-Proofpoint-GUID: t5XKzSrdBav_JmniWaN9kN9wQ3Vjm0NJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=849 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220118


On 1/16/25 14:35, Ninad Palsule wrote:
> Add following GPIO line name so that userspace can control them
>      - Flash write override
>      - pch-reset


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index 0d16987cfc80..973169679c8d 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -370,7 +370,7 @@ &gpio0 {
>   	/*K0-K7*/	"","","","","","","","",
>   	/*L0-L7*/	"","","","","","","","bmc-ready",
>   	/*M0-M7*/	"","","","","","","","",
> -	/*N0-N7*/	"fpga-debug-enable","","","","","","","",
> +	/*N0-N7*/	"pch-reset","","","","","flash-write-override","","",
>   	/*O0-O7*/	"","","","","","","","",
>   	/*P0-P7*/	"","","","","","","","bmc-hb",
>   	/*Q0-Q7*/	"","","","","","","pch-ready","",

