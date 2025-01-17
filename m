Return-Path: <netdev+bounces-159458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8F6A158C8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E5916900A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0931A8413;
	Fri, 17 Jan 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="to7wNFTD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD919993B;
	Fri, 17 Jan 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737147938; cv=none; b=CEIXlMgPs1qBatQH0GIrboSyza6HV7HOmQ+AUnjTmAdD1Un9SOcfPnzuFWdN6R9gxemKjGFQFJFNLe7ZN5o2dG6ar/cAQrmBw9QTMbP3/Fi4DJXGloGS+ra4H5VYP8JjktcorSlNc8CNSy4t3IZGgNB98e9g0udqXjuBCV08aw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737147938; c=relaxed/simple;
	bh=TQI1RsscdkTif6FH56HliVgy+d68lsLgnGgAPjT1VRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNzEMQI9IOJLVsONr4wIvH/5lEGsI1sFNK7e1e4a3bUo+W88j4mC7Q521eD4+lVL2+VLgL1HWnvO65cgJmPwyRywKo9pnS7mlwfi5LI3xfusri7QUbmq8KIlhxwaOUudisp/dXcDcT4liNyAzaVXh0jabljZzYZ/vQRi7sgzXO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=to7wNFTD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HEmJd5015119;
	Fri, 17 Jan 2025 21:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FcNMfP
	sXKW5do2sEOL3818ZBacxPAvlV+WbD78qlves=; b=to7wNFTDU6I9jBs55dcpc4
	BSA6VfV9Mp/m57EmXKpbReo1bPw0F2VxKq/5CacGpPzfVavfjHScRX4q8WF5C0G4
	AMasWFbX20Jd0FN/0l6i/gamC1sZMMd9FNCdN/F2eBKQLXg1pqywCfwjhLmtBWzN
	7fD9rFjMIOAc6pKHz8QXpdMnSg+x9q/4O+tKQNUWptGWZTBYYkB3gqVjVfSUQq7C
	kX5J2DJPjz79YtlD76Sd+Fj12ZoQSc0FJ6OPh7NuxEejJzrKOucGiHY4AsP7jgg4
	35xswmr0vnaBXAYBAuMtPb+hcix7DVQXqYc8l6UqaRKiqWFhdKrxg3jWxH7Eux3Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpuchqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 21:05:29 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HL5TXq025270;
	Fri, 17 Jan 2025 21:05:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpuchqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 21:05:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50HIWd2H007371;
	Fri, 17 Jan 2025 21:05:27 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynms7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 21:05:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HL5Rnw17695298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 21:05:27 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2713558056;
	Fri, 17 Jan 2025 21:05:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8A1858052;
	Fri, 17 Jan 2025 21:05:26 +0000 (GMT)
Received: from [9.61.10.175] (unknown [9.61.10.175])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jan 2025 21:05:26 +0000 (GMT)
Message-ID: <97ec8df6-0690-4158-be44-ef996746d734@linux.ibm.com>
Date: Fri, 17 Jan 2025 15:05:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ncsi: Fix NULL pointer derefence if CIS arrives
 before SP
To: Paul Fertser <fercerpav@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
        pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
        sam@mendozajonas.com, Ivan Mikhaylov <fr0st61te@gmail.com>
References: <20250110194133.948294-1-eajames@linux.ibm.com>
 <20250114144932.7d2ba3c9@kernel.org> <Z4g+LmRZC/BXqVbI@home.paul.comp>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <Z4g+LmRZC/BXqVbI@home.paul.comp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HmWfSBbTxZR5mWPPqTD6p3mXZwfwpcRj
X-Proofpoint-ORIG-GUID: 01P6Zx-eZ_Au6kpJES3CJzZOBJdu3uad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_07,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=990
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170163


On 1/15/25 17:01, Paul Fertser wrote:
> Hi Jakub,
>
> On Tue, Jan 14, 2025 at 02:49:32PM -0800, Jakub Kicinski wrote:
>> Any thoughts on this fix?
> This indeed looks related to what we discussed!
>
>> On Fri, 10 Jan 2025 13:41:33 -0600 Eddie James wrote:
>>> If a Clear Initial State response packet is received before the
>>> Select Package response, then the channel set up will dereference
>>> the NULL package pointer. Fix this by setting up the package
>>> in the CIS handler if it's not found.
> My current notion is that the responses can't normally be re-ordered
> (as we are supposed to send the next command only after receiving
> response for the previous one) and so any surprising event like that
> signifies that the FSM got out of sync (unfortunately it's written in
> such a way that it switches to the "next state" based on the quantity
> of responses the current state expected, not on the actual content of
> them; that's rather fragile).
>
> Sending the "Select Package" command is the first thing that is
> performed after package discovery is complete so problems in that area
> suggest that the reason might be lack of processing for the response
> to the last "Package Deselect" command: receiving it would advance the
> state machine prematurely. It's not quite clear to me how the SP
> response can be lost altogether or what else happens there in the
> failure case, unfortunately it's not reproducible on my system so I
> can't just add more debugging to see all responses and state
> transitions as they happen.
>
> Eddie, how easy is it to reproduce the issue in your setup? Can you
> please try if the change in [0] makes a difference?


I am able to reproduce the panic at will, and unfortunately your patch 
does not prevent the issue.

However I suspect this issue may be unique to my set up, so my patch may 
not be necessary. I found that I had some user space issues. Fixing 
userspace prevented this issue.


Thanks,

Eddie


>
> [0] https://lore.kernel.org/all/Z4ZewoBHkHyNuXT5@home.paul.comp/
>

