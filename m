Return-Path: <netdev+bounces-157883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0021CA0C221
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007353A6F68
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47911CDA01;
	Mon, 13 Jan 2025 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dwgh6B5c"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7F1C1F15;
	Mon, 13 Jan 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797944; cv=none; b=is3K+I404YkUv83ZJ/8GwQEKoiYEwe2dNsw40WdkUWogSDONz9tKGFdyuNHmNC4KMRg71jRRm9SNRJCDVhb1vfI/2+aeFZAUos6zI47EJ0YjPAXJn2m0Lc9La+McKBmp9e86pYN+AJ6l5fkqODcC4Za38fOK+PyIq62WcAJkJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797944; c=relaxed/simple;
	bh=j5nVsOcs60A1HwWY+PLlocYQ+rk05t7qvEN3u6JkXzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hl4vlGK4JASXNkVuAi4frAJ+7+GHyPSPIaTisTYcKBhQ+0/12pfRFkCgZ3nPu3IDpN+TuSFSlBqcm7aD9yOVusLW3gELcE1+t42JM0181VujIgJflqp++cWN0ZI8vNdOZaFU7Vopxm3ErkF7mahkeePFfXVRj6RQaN/sxZd+Ky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dwgh6B5c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DIwfZK000373;
	Mon, 13 Jan 2025 19:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iXtTp6
	05c1NPv9zxEPo1gzTrF5YWjXGwvW2aMensTlo=; b=dwgh6B5cwolkbwmsgi/y6i
	HHriX6AIsGJxmKWCiW39Ze5LV4u2p0eikMCUGktZveiP28wqHu5X3bYtqlTtVJCY
	WFt0UHiwMKmtEp4b3+Tg73NQ4/2lgOF4Y69BpuRCcejQog98Uupz4pXaOs9kl6+N
	L75xR6AcCgMiFsa3p9Vh31DAu+7YuI2TEWPvt5XeuxoCT53nSb3ZDXg0b+5qZroi
	BBFzxa1xsfi5ClVfD7tYYOxtpd+v4n18dHc12kXNz6R/pZENyXdy9BslQd2tifZb
	OceWzXFlOcZP0rSiDaau0r3sQTvaqVwH2oFmJfFjveHWvpjDf8BOQSMLoruP5nXg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444y12k1xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:51:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJoDaU024951;
	Mon, 13 Jan 2025 19:51:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444y12k1x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:51:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DHfI76016582;
	Mon, 13 Jan 2025 19:51:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1fgpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:51:31 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJpU1n24576736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:51:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EB2A5805A;
	Mon, 13 Jan 2025 19:51:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D19158051;
	Mon, 13 Jan 2025 19:51:28 +0000 (GMT)
Received: from [9.61.105.40] (unknown [9.61.105.40])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:51:28 +0000 (GMT)
Message-ID: <0ecf9e20-35d1-4069-8f51-47420311c4e7@linux.ibm.com>
Date: Mon, 13 Jan 2025 13:51:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] ARM: dts: aspeed: system1: Add RGMII support
To: Andrew Lunn <andrew@lunn.ch>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ratbert@faraday-tech.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-6-ninad@linux.ibm.com>
 <1dd0165b-22ff-4354-bfcb-85027e787830@lunn.ch>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <1dd0165b-22ff-4354-bfcb-85027e787830@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: amRHqMahE6Qd7k-Ku9FSBsdjNp8uQJBE
X-Proofpoint-GUID: nx04anhKqJ3HobtYO_WjH1Vyia_-aob0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=769 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130156

Hi Andrew,

On 1/8/25 11:03, Andrew Lunn wrote:
> On Wed, Jan 08, 2025 at 10:36:33AM -0600, Ninad Palsule wrote:
>> system1 has 2 transceiver connected through the RGMII interfaces. Added
>> device tree entry to enable RGMII support.
>>
>> ASPEED AST2600 documentation recommends using 'rgmii-rxid' as a
>> 'phy-mode' for mac0 and mac1 to enable the RX interface delay from the
>> PHY chip.
> You appear to if ignored my comment. Please don't do that. If you have
> no idea about RGMII delays, please say so, so i can help you debug
> what is wrong.
>
> NACK
>
> 	Andrew

Thanks for the review. I have dropped this patch from version 4 until 
Jacky fixes the driver.

Regards,

Ninad

>

