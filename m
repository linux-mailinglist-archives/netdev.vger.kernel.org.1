Return-Path: <netdev+bounces-157764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD67A0B96D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FEA18881BA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AC922A4FD;
	Mon, 13 Jan 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eNsa+SII"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE58522CF01;
	Mon, 13 Jan 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778429; cv=none; b=THktTzWpJlPhuTmh+Tji+IU1m3YbIalTMyCS3532ldFkh1Dkf1/RXZh+RgBZN3zYHKV74FiLblCeR1BJetJgKt3sFkpoTkbPxaSB7EZ9aNEMhU/fOixQf6AHDGNsBwYK/M/ckluq2Acl6i8oYIINYwEO2ZYYrYUghQOQZ7yDkEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778429; c=relaxed/simple;
	bh=L5oYjLOGj7P+hW9teS8apQMGC4DtRjzNV+LFKafzGaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZN/vxXzh1WcWRBWU5cL9kqwBRwCO27EApmVNVJsdd5ullnQMCBDagNKgcsWVWICPvP+zPtFkWF/LMPPsMYkmL+WPHPhUYkRLyOQz3UMKC/WXT7fGKlfNAAklicIKmS3RmybgNi6dt4/oHuFfYG4Jd8/FLRGrfd7jGduEDwbhTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eNsa+SII; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DD4iCY019939;
	Mon, 13 Jan 2025 14:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Re1AWy
	nCh34gObTCxI5E9tYgcxtbbp4c3dsc92FesJk=; b=eNsa+SIIMnv4fh5Y37zDo2
	RJwSsnglnbxwhPcVcXoxP1ovUD87h+dcCwi2aiVGKBCmuENnNghJE/b6+z3qwl7i
	xmRdOwHadN7aDygj5IYGYUhBpELtckz9sMU594Ul2/YXm4KyQVE+CkiKtwb5ucUz
	pt1vCMJvh5E8lJXkEzgCA6O5zE1tDWDbgDIcEyae+0Cf/vvav7Jc5AbVMD9IrPjc
	DTqeZN6b7SYWoihopp3ACIIFZ6O+dH306Q6FS5cEgmx97wA6eqi/E4DJzowmUuI/
	er7FJymUQfIVsaHnOGDdtq4rlQzr3R6m7Fp9UwiM5yamd0ofge26P9ZooX4cTsig
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qvhk102-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 14:26:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DEKZWa015977;
	Mon, 13 Jan 2025 14:26:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qvhk100-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 14:26:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DCn0Qe016976;
	Mon, 13 Jan 2025 14:26:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fjxg2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 14:26:10 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DEQ90M46596426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 14:26:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A19B58064;
	Mon, 13 Jan 2025 14:26:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDC8658061;
	Mon, 13 Jan 2025 14:26:08 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 14:26:08 +0000 (GMT)
Message-ID: <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>
Date: Mon, 13 Jan 2025 08:26:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuimhjog5Zue6KaGOiDlm57opoY6IFtQQVRDSCB2MiAwNS8x?=
 =?UTF-8?Q?0=5D_ARM=3A_dts=3A_aspeed=3A_system1=3A_Add_RGMII_support?=
To: Jacky Chou <jacky_chou@aspeedtech.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "joel@jms.id.au"
 <joel@jms.id.au>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
        "robh@kernel.org" <robh@kernel.org>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
 <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PzMhasNMDNoKxdyKdAi2vxo5N7CWP4lG
X-Proofpoint-ORIG-GUID: LOmVa8asSR9IfG6trFhNTjMZnecHBQjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130118

Hi Jacky,

On 1/13/25 00:22, Jacky Chou wrote:
> Hi Ninad,
>
>> Thanks. When are you planning to push this change? I might need to hold on to
>> mac changes until then.
> Yes. We have a plan to push the patch about RGMII delay configuration.
> Currently, I try to align our SDK to kernel.

Thanks. What will be the "phy-mode" value after you make these changes?

Will it be "rgmii-id" for MAC1..4?

If that is the case then I can test it with current configuration which 
may add extra delays in the RX from PHY side.

Regards,

Ninad

>
> Thanks,
> Jacky

