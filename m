Return-Path: <netdev+bounces-72107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F685692E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066E31F2237E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E7F1384BA;
	Thu, 15 Feb 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kyWp4NF6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5C11384B0
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013319; cv=none; b=ZZ3CFqcPL3WCiHvUpKBGlB5o9rIRTKSeSW/MMO/2Syh1LB927mW83mg0wLqjW+gDm+BJl/H8G/RzpC423aA8tYCIcAmuKeDcZRyJROjLV8XF7ld+B3DSRjz8YA4OMMvkAtyL3a/rI9PUsZqRVqGU66trmPgPmp7ZHXVYXslRJN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013319; c=relaxed/simple;
	bh=Dzgvvm9LkwwD/VhnA2wGeNg15KmHL26IwK2u+A0cWJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjiEURsfTZUXTIG6L0pRaFB8ncdT9jJDAG+n6YwqTP2LBp/4WL2n1kLVDivxWhk0hESO9/+/mqyNFnX7JDzHyJmtX+DrfoaIGhXyUlX/fVdVHrSl5XWw5R+BLB+V2LzI6axB16ZCwFSG14UvlNG98M5ce15qrVvHXA5qukuDQyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kyWp4NF6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFlbVJ014555;
	Thu, 15 Feb 2024 16:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=le7cvRvnqlqDy7uUh4WFoHK/cytcCMTovdVoNZAOGGA=;
 b=kyWp4NF6ltDI5mads4hfCr01bRNA1XnoKlm5Xxq8U8H/wHQ/V/hmMyVXd9OaJ6i+05Zv
 44wMnfHq460Q6qxaV2M+CWqqbxdecuhs6SahOIV/8jD8wQGvFqSKW4yfSyxUISxr/rqS
 nKwrIGYChtjggqXrKAs4YvwXkWfUQfnEupUEAj/Bt5YNMN6QLGJ2a03xtT2aqwt1hxVD
 e23TOsjuBYH6QkjhJDq57UHUPIW2VkZr1StJ4pkuofoQlpdG/nsMf6VkQShaKWC1RAKQ
 iQuv03BVXTAZjLNJ36Iu5QUja+XAeEEi/qFTeAjnp+w0rqzOz/3CQMr69UjFRzqkmHe5 tg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9nje8h0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:08:23 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FFsHRR001572;
	Thu, 15 Feb 2024 16:08:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9nje8h00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:08:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FDa0I5004329;
	Thu, 15 Feb 2024 16:08:21 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0p03p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:08:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FG8HNr9241156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 16:08:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4970E5805D;
	Thu, 15 Feb 2024 16:08:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16E4458057;
	Thu, 15 Feb 2024 16:08:17 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 16:08:17 +0000 (GMT)
Message-ID: <19ebb8a4-fbb8-442e-9fae-95890355a110@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2024 10:08:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/2] bnx2x: Fix error recovering in switch
 configuration
To: Jacob Keller <jacob.e.keller@intel.com>, kuba@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, manishc@marvell.com,
        pabeni@redhat.com, skalluru@marvell.com, simon.horman@corigine.com,
        edumazet@google.com, VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com,
        abdhalee@in.ibm.com
References: <cover.1707848297.git.thinhtr@linux.vnet.ibm.com>
 <ceca2088-10c2-4a7e-ac4f-50a5338187ac@intel.com>
Content-Language: en-US
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
In-Reply-To: <ceca2088-10c2-4a7e-ac4f-50a5338187ac@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TaCBs_Xv6eBTL7DXGLsiYbC-5h_z5nt2
X-Proofpoint-GUID: r74nICWCLwTJbYt8itncqWlVhiyDl2B8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_15,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=856 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150130


Thank you for the feed back
On 2/14/2024 2:48 PM, Jacob Keller wrote:
> 
> The subject didn't clearly identify net-next or net... but the contents
> of the series seem to be one bug fix which would make sense to go to net
> (unless the bug itself isn't in net yet?) and one refactor that doesn't
> seem reasonable to go to net..

I agree that the refactor patch does not need to be included in the 
'net' tree.
Should the patches be resubmitted separately, with one targeted for 
'net' and the other for 'net-next'? Your advice on the best approach 
would be greatly appreciated.

Thanks
Thinh Tran

