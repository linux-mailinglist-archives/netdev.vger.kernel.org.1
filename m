Return-Path: <netdev+bounces-64067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E65830EED
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 22:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DD5B21850
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 21:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E3C25634;
	Wed, 17 Jan 2024 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dm7YOvbZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70025569
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528614; cv=none; b=NjzhuPUgUxsc6+lZ+G46S8qemzVznNzo/L/8HFiKNxUdB2HJF6VNL7MsoJKl27fnnOb98imWAZfLKQYBz/1LzAL50hUXbtGqnXrhlcgK/JjCFo1/QH5oKmeWQl21a6vufHRdICcGYVWZ1fAtvNNAKSK84/wgpfreX95xSy6bisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528614; c=relaxed/simple;
	bh=PA3Lx9dVsk8fYGzyNljC3QpZLQpaSbWDsEUCSvKZELc=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 In-Reply-To:Content-Type:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:Content-Transfer-Encoding:
	 X-Proofpoint-UnRewURL:MIME-Version:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=U70bZKxEEdz4YR7s5yPdABwFHM/dQIXDldWen52An7e9AqWKemolgu6WiDKra8I0U3AYZK85YLWtGbaPVjERSsw/wOwdzdbosajt1iDiW9KJSs7Ydpw0lY0YjHqyFrEfYdBveM686b3aUTGQF06TOBylBYnx06NcsyVz2nFFUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dm7YOvbZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJpKiN027137;
	Wed, 17 Jan 2024 21:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OooOu1pXd5FkcNuRvX5UfzCNwLThT1FRoaAzBxl3BLs=;
 b=dm7YOvbZUxr0YMKYfcxHMXQDrgYVDjpMBPahK/OpivBEIocPUzu0W+ugsX+vsQtYBFkk
 Qjw9aBn5hw3xxBlQEzqkw9TGDDc1WSLqBwc67tHyNWiECOXa6PHFyUW6/d0C6NRTiFUj
 5YFGy+LayPgcL9tw62W22c5kvqKqOFoOzyrvfRf/O4aILTn35gWwDGKJLnx4l7+V0vuH
 pCJy5jCf6trhNxvomMQ7t9aauHBdqZLgCdgJyZWagIP2gcBd4dinOiYymSX4hWlPNzqC
 q/Qgjy6OBGWi8Ymmv5sqd/kxaN0vYhbvXiGsPj/SPKFDcUR9aCyuymvV39YVFHYNf+hG mg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpmsd3wg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 21:56:26 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HKRosQ023954;
	Wed, 17 Jan 2024 21:56:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpmsd3wfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 21:56:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJXuc0011131;
	Wed, 17 Jan 2024 21:56:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm57yr19p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 21:56:24 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40HLuMMb20447844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 21:56:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0889F58053;
	Wed, 17 Jan 2024 21:56:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5259058043;
	Wed, 17 Jan 2024 21:56:21 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jan 2024 21:56:21 +0000 (GMT)
Message-ID: <dd4d42ef-4c49-46fb-8e90-9b80c1315e92@linux.vnet.ibm.com>
Date: Wed, 17 Jan 2024 15:56:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 0/4] bnx2x: Fix error recovering in switch
 configuration
To: Jakub Kicinski <kuba@kernel.org>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com,
        Abdul Haleem <abdhalee@in.ibm.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Simon Horman <simon.horman@corigine.com>
References: <4bc40774-eae9-4134-be51-af23ad0b6f84@linux.vnet.ibm.com>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Content-Language: en-US
In-Reply-To: <4bc40774-eae9-4134-be51-af23ad0b6f84@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BgqU5Cy2yfa2jUe-oOgSgJv9ZhlwQOHD
X-Proofpoint-ORIG-GUID: 7JroUt_6wqvX7izqO8dCMlxI7pU47ql3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170156

Hi all,

I hope this message finds you well. I'm reaching out to move forward 
with these patches.  If there are any remaining concerns or if 
additional information is needed from my side, please let me know.
Your guidance on the next steps would be greatly appreciated.

Best regards,
Thinh Tran

On 11/16/2023 10:08 AM, Thinh Tran wrote:
> Hi,
> 
> Could we proceed with advancing these patches? They've been in the 
> "Awaiting Upstream" state for a while now. Notably, one of them has 
> successfully made it to the mainline kernel:
>   [v6,1/4] bnx2x: new flag for tracking HW resource
> 
> https://github.com/torvalds/linux/commit/bf23ffc8a9a777dfdeb04232e0946b803adbb6a9
> 
> As testing the latest kernel, we are still encountering crashes due to 
> the absence of one of the patches:
>    [v6,3/4] bnx2x: Prevent access to a freed page in page_pool.
> 
> Is there anything specific I need to do to help moving these patches 
> forward?
> We would greatly appreciate if they could be incorporated into the 
> mainline kernel.
> 
> Thank you,
> Thinh Tran

