Return-Path: <netdev+bounces-115782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A470947C3B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C97B1C21B8A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A5E55893;
	Mon,  5 Aug 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oO08vMNQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AFD482FA
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865989; cv=none; b=UBDu4onxdY4hM7vlCG6SxflR6cKrHcF0XqHKQeUtQwsO638Sk0DNx9p3TiLfLinPwbzKESkv/g37RryTjihOBpyRUabRrO/TH0LYbAzpgxqJwZ6TDb9y0p2x7Py5AVjEWbgxR7OS9qnU8lRwW+pDfoL7CiCdy1qb+2adOBIcIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865989; c=relaxed/simple;
	bh=uM3t79bo05Yj5kPQ8aZvyGfdchO/J4UbDFlt++SpFjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jiw2fmr7lwpYpzGtqIipRflPtDx+o/Wr42tAGhJGyzzESkrHVsqX8BVxrECCVWTG1BglBvRaWNJUDSD+yVG6D8vS4RCsysbylXUhGwub4SyBeecWuCRnOacr1DWvTyzjDH0GD+MD7iOAG219Q+YnRAj2uKWoirhtQSgfmFtSgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oO08vMNQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475DJMBx031474;
	Mon, 5 Aug 2024 13:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=U
	edZVutNDmGCAe6BDZevSChAToeNeMVBnfusXcHrZPY=; b=oO08vMNQg+jGUlrUw
	T/R8NllLtYYgXhEV0W3ty9TUEuKX0AzA+7WTX7yX9A6FyB2c1r1ykApAIFn445WJ
	X81WkCiQCkmvIgVY+dZnlCVHqFat/5PzHUFhSe6bh7AXJ6RynwzjGTSCD/8nnChd
	gAfREQ487ga5Ingz/YnSpeaY+Enxa/zwQbyAsWJ7dRAQSKorh+DtX+jF+4SCvjwQ
	TaZ+pTtPjYEHyzuJ3v5k1Gsv4d3TD5JrPApxOHLrNSppfc79BuPT035JMFVW28WN
	rmUODNkArDxZqBlF72hIX7nDdYMowKW1Gnmrbg+CPOwcTHfSWCMPVQ+vh4tVekMk
	6YThA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40txs605rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 13:53:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 475Ahj95018818;
	Mon, 5 Aug 2024 13:53:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40sxvtxuv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 13:53:03 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 475DqwPw40895052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Aug 2024 13:53:00 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3A8558054;
	Mon,  5 Aug 2024 13:52:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7CC25804E;
	Mon,  5 Aug 2024 13:52:57 +0000 (GMT)
Received: from [9.61.149.27] (unknown [9.61.149.27])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Aug 2024 13:52:57 +0000 (GMT)
Message-ID: <2ee7dd51-c45a-494e-ae24-b47fa938d321@linux.ibm.com>
Date: Mon, 5 Aug 2024 08:52:57 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] ibmvnic: Perform tx CSO during send scrq
 direct
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@us.ibm.com
References: <20240801212340.132607-1-nnac123@linux.ibm.com>
 <20240801212340.132607-8-nnac123@linux.ibm.com>
 <20240802171531.101037f6@kernel.org>
Content-Language: en-US
From: Nick Child <nnac123@linux.ibm.com>
In-Reply-To: <20240802171531.101037f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E-g2Lu1qJ4zIaaGBXLxGIDnbGKM7MfK7
X-Proofpoint-GUID: E-g2Lu1qJ4zIaaGBXLxGIDnbGKM7MfK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_02,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=456 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050096



On 8/2/24 19:15, Jakub Kicinski wrote:
> On Thu,  1 Aug 2024 16:23:40 -0500 Nick Child wrote:
>> This extra
>> precaution (requesting header info when the backing device may not use
>> it) comes at the cost of performance (using direct vs indirect hcalls
>> has a 30% delta in small packet RR transaction rate).
> 
> What's "small" in this case? Non-GSO, or also less than MTU?

I suppose "non-GSO" is the proper term. If a packet is non-GSO
then we are able to use the direct hcall. On the other hand,
if a packet is GSO then indirect must be used, we do not have the option 
of direct vs indirect.

