Return-Path: <netdev+bounces-96802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD438C7E13
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 23:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CEA1F21D87
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 21:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACF61581EE;
	Thu, 16 May 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hSy7K40u"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93002156F2A
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715895322; cv=none; b=VDLIDuYRvkjKPkXbXyl7rqwS95pQoofVaje3GUZkko5/yU0sPnKAioLPJuZQqW5cuzy3/hikowFyXNFZAgmgsOD38mWtDY6osiqkycqhU2s/WLgZYXcAnVwaf9fpqBqL+w7rtT0IOYVB49kOuZRdzlr6ggsBr8ZIenOMMEpNEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715895322; c=relaxed/simple;
	bh=nrQe5Qvz+ZA0pbiQdzBF62ZQlbEXkxyonZCSxyTNLw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oShm112CYPtJ+fAYnxQmqE244xNBhwCorUELtbAI7gh3fELw1AObq/MSYyyOoZR2tfoVimVpCX8mgmso27jOwdjJr00VSM1vqNjzx9UzH6gOgQy1nzRm1u6x06JaLE24gTPqZt0dxTyHnWKcpEvY4gD9d2KInIO4VwrOJt0JqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hSy7K40u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GKa9BC000318;
	Thu, 16 May 2024 21:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fcqtIyEB3BiIJMAUYMBt7K5rV7edCiEALXc4C2a9GQQ=;
 b=hSy7K40uVvfaaXskNwN0oeK3CF31rIZam6cJEd7eCeosY0Fo+c9Iq69beYbQXvGZoUmv
 LihREvVPZKX7oZymIqWNt9632sj4aXFfbmpLTobMIbVk9QXF465kImm8AmLcBDfqoi/r
 u94ZWLYySiqiOgM/PmIJUcchAZ2f3RGM5DfLqyQHGdfl9IXSiT1/mZJaC0UkDlXzG/vp
 dbVGMGAGF5GJ5ivutx7jL35mAdkx+r+3WiTtBSJuQIM9hp6vQFJDmT/p4mUTtX+tvTK6
 UITZyExGYqXVoK+ohfg/DOOa31rP+jZTw5ERGuaiVgbnqmA7YE0eFvI3QnIrGoB1qawT iA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5qc9rcuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 21:34:54 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44GLYr3e021918;
	Thu, 16 May 2024 21:34:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5qc9rcuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 21:34:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44GKshlc002291;
	Thu, 16 May 2024 21:34:53 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0pmcmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 21:34:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44GLYo7l46531268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 21:34:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B6BC58058;
	Thu, 16 May 2024 21:34:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3339B58057;
	Thu, 16 May 2024 21:34:50 +0000 (GMT)
Received: from [9.41.99.196] (unknown [9.41.99.196])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 May 2024 21:34:50 +0000 (GMT)
Message-ID: <344f9687-118c-4423-aae1-929f75fead8e@linux.ibm.com>
Date: Thu, 16 May 2024 16:34:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net V4, 1/2] i40e: factoring out
 i40e_suspend/i40e_resume
To: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
        kuba@kernel.org, anthony.l.nguyen@intel.com,
        aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
        pmenzel@molgen.mpg.de
Cc: edumazet@google.com, rob.thomas@ibm.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, davem@davemloft.net
References: <20240515210705.620-1-thinhtr@linux.ibm.com>
 <20240515210705.620-2-thinhtr@linux.ibm.com>
 <9fcff111-bec5-4623-bc22-cb4792aba55e@intel.com>
From: Thinh Tran <thinhtr@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <9fcff111-bec5-4623-bc22-cb4792aba55e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SzgRhx6NkjJIZ8sGRdoUiYacDyUGASxD
X-Proofpoint-ORIG-GUID: WAcBvhVmQUBjpZfPcwjXnhU7RvI1dBqZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160158



On 5/16/2024 2:11 PM, Jacob Keller wrote:
> 
> I applied this to IWL net dev-queue, but I had some conflicts when
> applying which I resolved manually. I would appreciate review of the
> contents as committed:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/commit/?h=dev-queue&id=b0bdaaffc27a79460a8053c2808fc54e4cbdd576
> 
> Thanks,
> Jake
Hi Jake,
Your updated commit looks good.
Thank you for applying the patch to the IWL net dev-queue. I apologize 
for any conflicts that arose during the process. I appreciate your 
effort in manually resolving them. I noticed that my local repository, 
which was last pulled from the upstream kernel last week, did not 
include the commit ‘i40e: Add helper to access main VSI’.

Thank You,
Thinh Tran

