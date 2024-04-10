Return-Path: <netdev+bounces-86546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E783589F278
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32EB1B25703
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7B015B979;
	Wed, 10 Apr 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Br9Qs7mP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87815B577
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752637; cv=none; b=hvFakRVtWjQ8ZUNEXsAnETA9GiS1BlL8ZnRxPycV5hGnbhQt/XmpOmuoNJnarhzKVFklrNV10KBMG7iQND4e/GNSoSTYBHaIAwch/JDX/nbOqibmNYEDyOCsyavsXv36GJjrVf0UesLlb3VHpDPZItaQWUMQ1069nwT5ZSy0KjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752637; c=relaxed/simple;
	bh=xRrHyW4X9SdDAi+dFNHUCGkbj81z5Sq4E+V0suXtta4=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=AjCRXCCJ4o46eL6FgH/1yfC8jvMfsLNx+PIL6l7j85b68fMvYDLzII/gxLHm0u3jS/QDni+0LxP3kGdD/TQ4OU+k5WXL8+QxHiX4Q/X3yjVA4UyZnQewikPFh6q3J2ZoW6qwSQZGoSoJVBXkdSJ403OzZ/UvJuFEzT7rG35Ty4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Br9Qs7mP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43ACavQG002215;
	Wed, 10 Apr 2024 12:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : cc : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=6lUBT9ZLl1zd6q9c5X1BlPbztVlwrFiCW8Y9wFzZfoU=;
 b=Br9Qs7mPRC8daLePgQi5ck3NkZ1+qRt2E4qL3woV3X3tP/pu4wllD8ep9yLYjaOVRROM
 wrg2B1ThPfWPOeD8hRRQqvXnl931Jr7LXVKIKD8Yj9odyJQ2g6zZ9TNfNXQXDYbDa+Pb
 VuUK7Kx7+KUGAmmt77M/JGn+sXM/KlHyQZ/DQm0wpdkT35OvZR1CKLxvFBTJWMnMpwyW
 Wpb8mdvoqMPxJFyntKeVd6WzViF7vXyWS9DfBxXXr0aU9kiYlMOUL0N/QO1y8stFnvvj
 +eU6SkB4omfnwvabMLSz7yBATEHq1c87PPXEt/1kg8cIKncC8wZK2RkSap0Z9RtjydWd IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdt5003hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 12:37:09 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43ACb9sF003511;
	Wed, 10 Apr 2024 12:37:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdt5003fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 12:37:09 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43AAN9uF022627;
	Wed, 10 Apr 2024 12:33:16 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbhqp4pw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 12:33:16 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43ACXDxO26542458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 12:33:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF22858062;
	Wed, 10 Apr 2024 12:33:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 609A95806B;
	Wed, 10 Apr 2024 12:33:10 +0000 (GMT)
Received: from [9.43.108.21] (unknown [9.43.108.21])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Apr 2024 12:33:09 +0000 (GMT)
Message-ID: <c02a14f9-670c-42be-bf27-7d788575e3c9@linux.vnet.ibm.com>
Date: Wed, 10 Apr 2024 18:03:08 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: hkallweit1@gmail.com, davem@davemloft.net, andrew@lunn.ch, lukas@wunner.de
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org, abdhalee@linux.vnet.ibm.com,
        mputtash@linux.vnet.com, sachinp@linux.vnet.com
Subject: [netdev/net]Kernel Compliation Fails on PowerPC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iTTd5vEY6Yhn7UC2VpkAyFKIrbLLAez3
X-Proofpoint-ORIG-GUID: UGxLhbb7hxhZnFeXITGEks3pvr_pj0vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxlogscore=562 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100091

Greetings!!!



I see kernel compliation fails with below error, on PowerPC.


ERROR: modpost: "r8169_remove_leds" 
[drivers/net/ethernet/realtek/r8169.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/home/linux_src/linux/Makefile:1871: modpost] Error 2
make: *** [Makefile:240: __sub-make] Error 2

After reverting the below patch, compilation is successful.

Commit ID: 19fa4f2a85d777a8052e869c1b892a2f7556569d

r8169: fix LED-related deadlock on module removal

Regards,

Venkat.


