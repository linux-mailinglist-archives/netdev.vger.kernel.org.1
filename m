Return-Path: <netdev+bounces-93865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815CA8BD6CB
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB2928411A
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E215B0FC;
	Mon,  6 May 2024 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Biqv8Z78"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27646EBB
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030533; cv=none; b=OMHtn2I/RTEkSFcwRwhfnIfiwGee+X2/N4GaUUYL37deRvvZrAHYiSxb/1ba2ZBHGPH2VoM12ZbYgQ0/qc/eOs1DMYZYTOC0CtqD3hsKEjn80bJ9zW8iqECLU0BOEHsXgcgjMXOC4zDpB73orksaiRkGZEjoJstAIadicGjNTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030533; c=relaxed/simple;
	bh=FWstdOoXvuBlfzQuBoHRPfhJUQYW7T49sj5xChKO4Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0pKyzWcsYcewaLLfFRdB/Yqd/15dHewnGsbOwYuem/E8jNgDLuAv57PADc+zra6uQ8JFmexeqifYxXHBjkEkxteQwRiH1s5m3INJbsis9zLAKGWfyeKkCLLTkQ1q2ViQZtNWFsedNDnIyG0qSv5jawV57F/MeX8jmdstLXw9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Biqv8Z78; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446KfGIG028094;
	Mon, 6 May 2024 21:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KacUEaAphUgoxiPBCBuIolxkWOX4TQhv8gR3A0KZgug=;
 b=Biqv8Z78ImX81QBB03o8YEc4iMpUR6pHGCi8TL7m3kKXOEbuVSWheTuD8ue/WB8npguB
 1w3Y0UXB+aKiQuOoh8Gxjb815g9OpPi4ABjGOcXpunvzcUVayK2QOxbibzfy82yOP7FM
 gmkCtUgwGJI7Fa7jyJyw2aNs/NeGAKAfKGg/WOS8Eh380uWDL3HtasjBSYYCw5FiN6ID
 sIHjR64/X14W7LJU38iVct5614Dvx4E/80ayjWcTVzk13dumQvnccMb3N1BdJesftY84
 1wjjZG5gKM80pqCONEzGdtgTKHYZvRl/S9sAzvcRZudC+Pn0CuigHyBvaSYcwoNZkObA vg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xy6f3r2t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 21:22:04 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 446LM4L6022471;
	Mon, 6 May 2024 21:22:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xy6f3r2sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 21:22:04 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 446IeNJX010569;
	Mon, 6 May 2024 21:22:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xx0bp2a8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 21:22:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 446LM1rN33358424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 21:22:03 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01FE25805B;
	Mon,  6 May 2024 21:22:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 579E458059;
	Mon,  6 May 2024 21:22:00 +0000 (GMT)
Received: from [9.41.99.196] (unknown [9.41.99.196])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2024 21:22:00 +0000 (GMT)
Message-ID: <adba0c7b-bef4-4fff-9ff2-b56f8b122ab8@linux.ibm.com>
Date: Mon, 6 May 2024 16:22:04 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] i40e: Fix repeated EEH reports in MSI domain
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
        kuba@kernel.org, anthony.l.nguyen@intel.com,
        aleksandr.loktionov@intel.com
Cc: jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        Robert Thomas <rob.thomas@ibm.com>
References: <20240503152509.372-1-thinhtr@linux.ibm.com>
 <c47dc55f-9ef7-4a18-8419-fca4afb605b0@intel.com>
From: Thinh Tran <thinhtr@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <c47dc55f-9ef7-4a18-8419-fca4afb605b0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dIbbk6KdgsRqH-WRsiJQAHlyblJ9S74a
X-Proofpoint-GUID: r6YXv515ycE6RDm553GjivxYxPk1cBxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_15,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 spamscore=0
 mlxscore=0 mlxlogscore=897 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060154


On 5/6/2024 4:35 AM, Przemek Kitszel wrote:


> In general do not add a blank line after Fixes tag.
> Someone could complain that i40e driver had a bug prior to the cited
> core commit, but for more practical purposes I find it good as is.
> When you are a sender of the patch, it's good to place your Signed-off
> as a last tag.

> 
> I appreciate your effort to minimize changed lines to have a fix better
> visible, however we avoid forward declarations in .c files.
> I would split this into two commits - the first to just factor out/move
> functions w/o functional changes, then second one with a logic fix.
> 

Thanks for the review.
I'll correct the typos and resubmit with two separate commits .

Thinh Tran

