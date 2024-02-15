Return-Path: <netdev+bounces-72113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E8E85695E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778F3290D79
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F036513399A;
	Thu, 15 Feb 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NvKocK5z"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27313398D
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013859; cv=none; b=kblzz1tY15Mg99vBljDYPyJYoVHesxGHmduBby57PKrZ6Hre9PBnmtM2KMJtPHDROYxT0VSsIVXdmKvEScjkvBEJfsIq8WQc1nOt8P3qo3uOWiebrT22zVeG4a/3BQ9Xv6o+nZN976WleUXLomgLHRuCeoBqMt1hkvyn7qTwQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013859; c=relaxed/simple;
	bh=qkAbv32n6/DUIn8mWg1JMKDCVgggcc6iBdlhA74rQsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fz8+eOsLA7iNckf2T/zecv+mMXpsUJHn1cYChHOCGsAu7y7aM8d1eScUxUWIvfy6VvAqppVlbEjiusmqcAuiqnqKefQequIPMI0y1qyDSo6I/yQeB6K2AmWYO8u1rKFITbYBG5hCtI/xnLZZ2m0C3Asrmftt4axbPbM9tHWOfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NvKocK5z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFuwrW001426;
	Thu, 15 Feb 2024 16:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dv+HDRP8auXZZ48v8XRAGJCSzDSunMnE4S+xnjALUU8=;
 b=NvKocK5zNGpJ2p1xDeYrWWDJuEdA9yS3yliuzoSfEDf6TBUvGDkH0GBcJLoyl6L3EXgW
 DvYu1Rj//3KOuYm87UgkpvP6zBBWOXzEXWunCZ6eciAI9a52kBhHZ9gIpEn2NgdxW9JN
 gBYnG4qR4j6+qcKg1mr9WqeaWIKqzC8Gd+Wzs5J/lVN+T9OjVXr6iFS79P43oU4a36s8
 3YIF73JhtS7iL0lggudeKtgDk7RIFmqnJ4bp3wCM+xRd4GWElHSPEuThoMzxlOshCdOo
 K0xKUu/jTBtpXVc7uPkwm2lxzSVcajNUWcu6sr/chbJy/eHj5M/VtIvXuaZQFZ8us1Vj LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9nq08psd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:17:28 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FFvFMi004249;
	Thu, 15 Feb 2024 16:17:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9nq08prr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:17:27 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FEROa2016203;
	Thu, 15 Feb 2024 16:17:26 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymwrd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:17:26 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FGHLA111993426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 16:17:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86B455805D;
	Thu, 15 Feb 2024 16:17:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5689758057;
	Thu, 15 Feb 2024 16:17:21 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 16:17:21 +0000 (GMT)
Message-ID: <35386fe5-dfbc-4698-a4a8-6c6a2df454cf@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2024 10:17:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] net/bnx2x: refactor common code to
 bnx2x_stop_nic()
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>, kuba@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, manishc@marvell.com,
        pabeni@redhat.com, skalluru@marvell.com, simon.horman@corigine.com,
        edumazet@google.com, VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com,
        abdhalee@in.ibm.com
References: <cover.1707848297.git.thinhtr@linux.vnet.ibm.com>
 <14a696d7a05fa0f738281db459d1862a756ea15c.1707848297.git.thinhtr@linux.vnet.ibm.com>
 <680bd25a-8bf1-4af6-b2bb-e5a11daf287d@intel.com>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
In-Reply-To: <680bd25a-8bf1-4af6-b2bb-e5a11daf287d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PGy8u8jjhOSk9NNjYi8ZEll6RrjIDK6L
X-Proofpoint-GUID: r9gzVD7siZ1V0NbmZqRRiMd-jfRoQNEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_15,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=424 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150132



On 2/14/2024 2:50 PM, Jacob Keller wrote:
> 
> Good cleanup.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>
Thank you for the review.

> 
> IMHO this could be an early return:
> 
> if (bp->nic_stopped)
>      return;
> 
> That is a bit of a nitpick and the existing code (by necessity of not
> being a function) used this style.

and thank you for the suggestion. I will update the code to utilize an 
early return as you proposed.

Thanks,
Thinh Tran

