Return-Path: <netdev+bounces-71073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C02851ED8
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 21:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E676F2834FF
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 20:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD347A67;
	Mon, 12 Feb 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UI2uYxRX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F791EA78
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770862; cv=none; b=PD9G/3dKRpBR6TcIdcJJIU9MDOcpT3q+G7xwiEHQZwmKNU0cqGNSB4E+O2ZG6jUlXYzKugZ/saW+nPHsGY9mUS6ThQo9hlRgUJte/CdXDB/slm5gpnCYMr7FXjxVOUhdE3aRnBmsLorRHipjyHgRltPvow6Ec4vUg65jWBVkH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770862; c=relaxed/simple;
	bh=R1DEde+b9JaKYDSbMt3g46Ez62dW2i+6rLXKkTY3CM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5fnCuFDKwqPl3CEAnWWG4h1nVtbFQVJ1cKDX/y7nnmkq+P5dpAwDRMRFIfSWpuBD+xU6p9ROiqQMzcwQvxPa88IQH7y3gb6TKJSThqkMCyxmXN5LKAOiLjuo4J+8uzd1bhxxMwOizndmiOeGeI3OlsdVIC3ADqBSvrkQdnHfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UI2uYxRX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CKat7O017597;
	Mon, 12 Feb 2024 20:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=viv61tL2Z4cLZRXxnXH9vw9uRuzWXWiMbb3ngXK3Qkk=;
 b=UI2uYxRXccrRQ/lS7D6g1MxoAlPl30ZY9HdRyCOZdgDW+TAn3fTSX5lQkaH7s+orA3gD
 flIIVtS4g5p+Z4fy4gmom3ayKDJ2GuIWXcpBYBdFnZHn7ORaEZOwDdDjq2ycaUEWsmx5
 AZgQNgPvCL2WR36ZP8zYqNitvVd5xmXgRhOWlaQjlkEn5WRx1onv1c7SA3IA8UPa1eVy
 L7H+bW0kGFaR6RtszLoglOEGX+uznJTOT6f7Daxw2bXiFpqe1iFblwi7RPxI0IA8WhAv
 0BWvO5CwCq00HBtf46Gse1RNirdnTUNCUxPR9HQpuX6lkwSigQBL1KmT5KcDYCcLh28s ww== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7th583t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:47:35 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CKjOIX005708;
	Mon, 12 Feb 2024 20:47:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7th583sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:47:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CJf5uP016184;
	Mon, 12 Feb 2024 20:47:33 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymayr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:47:33 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CKlSjW6881794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 20:47:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D549A5805C;
	Mon, 12 Feb 2024 20:47:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32B9358051;
	Mon, 12 Feb 2024 20:47:27 +0000 (GMT)
Received: from [9.67.31.65] (unknown [9.67.31.65])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 20:47:27 +0000 (GMT)
Message-ID: <0df4d341-ed70-4db1-af7b-b2a585316819@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2024 14:47:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] net/bnx2x: Prevent access to a freed page in
 page_pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, aelior@marvell.com, davem@davemloft.net,
        manishc@marvell.com, pabeni@redhat.com, skalluru@marvell.com,
        simon.horman@corigine.com, edumazet@google.com,
        VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com
References: <cover.1707414045.git.thinhtr@linux.vnet.ibm.com>
 <90238577e00a7a996767b84769b5e03ef840b13a.1707414045.git.thinhtr@linux.vnet.ibm.com>
 <056b4e86-a894-4a4b-a8dd-81f440118106@linux.vnet.ibm.com>
 <20240208172936.7a8b7fb8@kernel.org>
Content-Language: en-US
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
In-Reply-To: <20240208172936.7a8b7fb8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TFYCkAsbnfl9wi2WJ5-dMbZDvECTHtTp
X-Proofpoint-ORIG-GUID: OMezVqEX4w4Gxy_WHiL0vQBX5j6JoFmE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxlogscore=621 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120161



On 2/8/2024 7:29 PM, Jakub Kicinski wrote:
> On Thu, 8 Feb 2024 13:18:14 -0600 Thinh Tran wrote:
>> Fixes: 4cace675d687 ("bnx2x: Alloc 4k fragment for each rx ring buffer
>> element")
> 
> The Fixes tag should be on one line, without wrapping.
> Please post a v9 with the tag included, as a new thread.
> Don't use --in-reply-to on netdev (sorry for so many rules..)

Will do. Thank you.

