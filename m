Return-Path: <netdev+bounces-96428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FFB8C5BD8
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 21:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA851F203F8
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 19:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F2D18131A;
	Tue, 14 May 2024 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TPFhOO2X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF7180A9C
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716355; cv=none; b=JLCtIQRb2zQFLKTwjalywt9jutxWxd/tZPzK86XgpyeJyHz4Bv1maBmETg2FYyT2Trd5VEmKpAQvMBcloqzQ0FlshOsXj5pDF2adYJ4sak6Z+1av09mw5FP9kTTSt2n2TdMO04234nJ7VXXmyqlcK8FgxuS2OT+ca5cHalKP1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716355; c=relaxed/simple;
	bh=4RvcsYnGXmvB/cjNqqgtDhAfVvMpaoRkTmBYCznG1jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jt6cfsIbY/AH1IUxo3eeXylY8QXd5kKj7RyBBH6Iwg15E5zM6aH+UpkO9Zv1rHcNSd8Gs2QWE9DzfZd+gDsAyPPqrn0WS7aeazvrKb7QuGcQXFFkwS5Hg9ACSR7UbeuciDuu2YaRnRomdNad2AwX0HSazmijQy3u74uhJPPRpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TPFhOO2X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EJ2UZ4009999;
	Tue, 14 May 2024 19:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/4qCNJt7pLH5LsohuFlyeWrk7/MVDZVLIok3qxgN+gQ=;
 b=TPFhOO2XMXxQT4k9z8tFRLU3i1HWuhHjriBLhvg4RL9cP9f0ZjwpLsUuMINkd/AeqaCn
 72xinCPUhd/mps6VvS9jY1ZZSsqRaEVqbq5oxuPUG63gewJDVitylWd6P+Usufjm2X3F
 xSrRRdZMpJNe0qH65GfSFzPBZiKsJt1qo2iBgSWQDJaDFzg7gk25W01CyqBv/pMHgmOL
 7DwEP+VlSvYA5I9xXjkVonhEPxQ07KxAaaz+DhXy+nPT+EkbXpq5agTqvNw1iJ6emoId
 IMuCb2LaJZjDDAEPJ+eJvTAg/Rhjtgrzk0pbUFBJGLW8UFNHK/TMzv11+SKtTF+VBvVY Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4c2rgc9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:52:27 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44EJqQL4029272;
	Tue, 14 May 2024 19:52:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4c2rgc8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:52:26 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EIWcva002291;
	Tue, 14 May 2024 19:52:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0p7ac9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:52:03 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EJq0D620120160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 19:52:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAF9058057;
	Tue, 14 May 2024 19:52:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8442958058;
	Tue, 14 May 2024 19:52:00 +0000 (GMT)
Received: from [9.41.99.196] (unknown [9.41.99.196])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 19:52:00 +0000 (GMT)
Message-ID: <efd7ca37-df1f-4d71-a2d1-fbdb8f5b8458@linux.ibm.com>
Date: Tue, 14 May 2024 14:52:00 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net V2,0/2] Fix repeated EEH reports in MSI domain
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
        aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
        jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        rob.thomas@ibm.com
References: <20240513175549.609-1-thinhtr@linux.ibm.com>
 <20240514095505.GZ2787@kernel.org>
From: Thinh Tran <thinhtr@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240514095505.GZ2787@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eQ6ZQuhnKCLk2uIAxId74gVnfFvrSjoT
X-Proofpoint-ORIG-GUID: wuKImK4b9lmRP4Y6gwEWLXJVye9E2dje
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_12,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=857 clxscore=1011 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140142


Thanks for reviewing.

On 5/14/2024 4:55 AM, Simon Horman wrote:
> On Mon, May 13, 2024 at 12:55:47PM -0500, Thinh Tran wrote:
>> The patch fixes an issue where repeated EEH reports with a single error
>> on the bus of Intel X710 4-port 10G Base-T adapter in the MSI domain
>> causes the device to be permanently disabled.  It fully resets and
>> restarts the device when handling the PCI EEH error.
>>
>> Two new functions, i40e_io_suspend() and i40e_io_resume(), have been
>> introduced.  These functions were factored out from the existing
>> i40e_suspend() and i40e_resume() respectively.  This factoring was
>> done due to concerns about the logic of the I40E_SUSPENSED state, which
>> caused the device not able to recover.  The functions are now used in the
>> EEH handling for device suspend/resume callbacks.
>>
>> - In the PCI error detected callback, replaced i40e_prep_for_reset()
>>    with i40e_io_suspend(). The change is to fully suspend all I/O
>>    operations
>> - In the PCI error slot reset callback, replaced pci_enable_device_mem()
>>    with pci_enable_device(). This change enables both I/O and memory of
>>    the device.
>> - In the PCI error resume callback, replaced i40e_handle_reset_warning()
>>    with i40e_io_resume(). This change allows the system to resume I/O
>>    operations
>>
>> v2: fixed typos and split into two commits
> 
> Hi,
> 
> These patches look good to me, but I think it would be worth adding parts
> of the text above to the commit messages of each patch. This will make the
> information easier to find in git logs in future.
> 

I'll move the text to patches' commit messages.
Thanks
Thinh Tran

