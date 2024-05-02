Return-Path: <netdev+bounces-93127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2608BA303
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 00:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90A51F21B81
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 22:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C9D57C9F;
	Thu,  2 May 2024 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cPAR12Pi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434E57C94
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714687921; cv=none; b=Q+biPmFTPxg7++Px4PIT+HjG6G7Sh08sVBO4+liHMH90oZbI8OfG2a9zqJPzMRRbNupStFSNMcMTInBSC/NZxol7uwsP9+FQPgC1jH8zFeDx/Q1oS0Z7XpxpzXQWQ27/J0MIkS5fS6+6uGUJNn9bp+xoNjpKUZ1n6oFpp4IBm1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714687921; c=relaxed/simple;
	bh=ahpfJ+RvAAWt/09BqKNXnQ2/Xr8/fI5sEwaRBxyG8lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/OPcgSV8Ey65BMlAeAGkLpcRoHLu9jESlSUp6mkO9aJgHkkpAdOpexDW+DdBOEhug1zAgc0xj+Pggcmp3LmDcBsXnp+C0OwzGmV6sA5Q2KJwz9ptvnd4q6DJFAAEv9JmzJUs6xgBR15fGp1lmV32eD2CyNLahDgCItDyc3V8mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cPAR12Pi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442M1xQj029766;
	Thu, 2 May 2024 22:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UEIrm1OQqoa/Xb4yzGk46pIL7NPBOAnzMTdOCV1h+YA=;
 b=cPAR12PiwW+qZ1gC2ewU9V+SoVEWdl2rfSByWJz/GnF2I2duHeUdvGfzaiPTBI7aaPpg
 iCSlKEniQl2PZo0RaVL7XhVvzPirpYGOVvWm0cp60Ai4bJoXe/8JIJ9wUgM8tCpLfgGt
 cXJts6G8s6pZAQREDV8EFU+jXdxGgjt94031Dd1z+jlPniiE0pi+vpbfCuuZMIPwesfh
 sqiuAEJd6F0iLi3IioKV+DlaLkRfnVtIagzqIKfTcFOqSvO8s5U9p0slskoXoJvQPiOJ
 c/HwQrtBGwLxnaPCfBFhlz7+I2dbXLRx4/qQtmoIcbviS4T2cKcXinHNDs1CjYApkmNX UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvk8t80hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 22:11:43 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 442MBhRV011338;
	Thu, 2 May 2024 22:11:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvk8t80h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 22:11:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 442J4ijK022229;
	Thu, 2 May 2024 22:11:38 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsd6n294m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 22:11:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 442MBadj26542808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 22:11:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 802525805F;
	Thu,  2 May 2024 22:11:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0EBB58067;
	Thu,  2 May 2024 22:11:35 +0000 (GMT)
Received: from [9.41.99.196] (unknown [9.41.99.196])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 May 2024 22:11:35 +0000 (GMT)
Message-ID: <9c81943e-99bc-408a-bab4-478ab7886b0e@linux.ibm.com>
Date: Thu, 2 May 2024 17:11:35 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/i40e: Fix repeated EEH reports in MSI domain
To: Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
        kuba@kernel.org, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        Robert Thomas <rob.thomas@ibm.com>
References: <20240423033459.375-1-thinhtr@linux.ibm.com>
 <fc923f03-e3c4-da59-4f43-c1d585bef687@intel.com>
From: Thinh Tran <thinhtr@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <fc923f03-e3c4-da59-4f43-c1d585bef687@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jkAZrnpXe4LqYzuKJ0U8buiShMRlkeGV
X-Proofpoint-GUID: dO0rFwr8M1_xqUri8B_76-YLp_LzDoVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_14,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020149

Thanks for reviewing

On 4/29/2024 3:31 PM, Tony Nguyen wrote:
> + Alex
> 
>
>>
> 
> You don't mark a target tree, I believe you're sending this as a bug 
> fix? If so, can you mark it with '[Patch iwl-net]' and provide a Fixes: 
> tag.
> 
> Thanks,
> Tony

I will resend the patch.
Thanks,
Thinh Tran

