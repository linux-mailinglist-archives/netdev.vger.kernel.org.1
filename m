Return-Path: <netdev+bounces-96571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F678C6795
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6B41F23022
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA913E8AE;
	Wed, 15 May 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E40GfiaI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2608213E886
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780501; cv=none; b=orZTSa73h+PUA6K1G5LQWAFR4lFvbV7w+59WDqN3Ym99WOZaVYfkTK2Ds/9oQaWNUrkq7QtMrALJdasPuN8sdMyaxf4gkJs53wL7gui0sXSoNNvTYqs3bXZGsitd3qKg4+FZP7RqgLbM2DQ8tuN3aycoabkmKZLX7V7q12VvxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780501; c=relaxed/simple;
	bh=HfAP8ovPsbTv/i7b/iNRqyJRNbPqAoDd8h6LsgwGs2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/MiGb3QIeouOOlEDCFAF/Srk9OMG8v2P/5VQJJc2fk0wiNFbAJW+CGAc6kdLqn1J1OLRj/WfVX4K+Eq3P9Lr1hK0JOLLgf4mxCy61Ws77UU1i65cRZzviVtbSUSH1zcpN/ZM7pBE4fTKz5+XZzuilbLtTA8DpthLES5fJ4047Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E40GfiaI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FBQGn0009700;
	Wed, 15 May 2024 13:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dipip3cYoYCcSDrB3HQOGvfpZwDon85avyUbuqW95UE=;
 b=E40GfiaITM3tnID64pWELCfwUfIV5efWnMEdOYV097cOn7w8xrfgFSlMb8ZOz4FLPPrN
 j7DgKeDFbsRT45KT/TnFgy86GNaJTnMtYtlZoDNnQ+tn3Ur2GtGaoKXCJkSKRugYEaxZ
 FXCKw8lztZeyeVZGiOAtMIdo0QdoO/QMevWUve7VQS6ngHMNrkTK+nnQz2msY44KcbbC
 r35cTWW2QjQu88mH2VDHxc+gtNP7rqLqjCN3YE+9WzOvUR1JPIuCoNw1HAjSyRUt2jHV
 MsIodVFNuXIN41b2KAC+H1iDHA/jXylsIleP+Em8nyO28OZGZuxAVACsrl1mLHihM/sP 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4uyg8br2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 13:41:20 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FDfJXW024910;
	Wed, 15 May 2024 13:41:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4uyg8bqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 13:41:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44FCHjP1006769;
	Wed, 15 May 2024 13:41:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmksrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 13:41:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44FDfGPM24904366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 13:41:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0548658067;
	Wed, 15 May 2024 13:41:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B74CE58066;
	Wed, 15 May 2024 13:41:15 +0000 (GMT)
Received: from [9.41.99.196] (unknown [9.41.99.196])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 May 2024 13:41:15 +0000 (GMT)
Message-ID: <1f1a6485-a27a-46fc-bb57-d2600e93c95b@linux.ibm.com>
Date: Wed, 15 May 2024 08:41:15 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net V3, 1/2] i40e: fractoring out
 i40e_suspend/i40e_resume
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
        aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
        horms@kernel.org, edumazet@google.com, rob.thomas@ibm.com,
        intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
        davem@davemloft.net
References: <20240514202141.408-1-thinhtr@linux.ibm.com>
 <20240514202141.408-2-thinhtr@linux.ibm.com>
 <275f19df-f0c2-405c-9a99-7776a8565532@molgen.mpg.de>
From: Thinh Tran <thinhtr@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <275f19df-f0c2-405c-9a99-7776a8565532@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MQPm361PKxTKUgJaQDn1IXwAyPc-XHwl
X-Proofpoint-GUID: jVQmbZUjkwzz7UrEREEbd3jRRrFCPV7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=864 priorityscore=1501 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150096



On 5/15/2024 12:08 AM, Paul Menzel wrote:
> Please use imperative mood and fix a typo
I apologize for the oversight. Thank you for your feedback. I'll correct 
that.

Thinh Tran

