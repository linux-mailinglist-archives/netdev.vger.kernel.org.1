Return-Path: <netdev+bounces-45811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C64C7DFB9B
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 21:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4531C20319
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 20:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41839E550;
	Thu,  2 Nov 2023 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GTq0rZua"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17C3D65
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 20:37:10 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8D7138
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 13:37:09 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2K7Mmr019084;
	Thu, 2 Nov 2023 20:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=v/cvZQZy8zKBXDlAQeSYsNAF0OocxXiLiv/KmlTPj68=;
 b=GTq0rZuaSrpQxzXNgDA0BphKkzc3SLCT9Nw0hJmLrskZnWa3+fz8mxESkAZNvrrgOsDt
 K97YTt2GPjFQtcrChzBMPynA0vbWQFhI0z/wfXu+gfSfH6WK0eDO22hp272i0IqhQ7Jj
 tIaRIhObD1hUJkDvnW/aBwoYwjW/fZfGhAx3PYxZc+bSA+kkmqnASUlVD5n48NQdE9fR
 BpvQsKwaeOTj99zxot85ySnlSc6zm4DB5BozYYQJQoU8vrlL61YqVP+Q5xFRamL7bAGx
 tWQUXraqmG3klJbw73MOoloYg4gvrChZBslKDlZlByW7UeecuoH3+xq53JcTiR9ZIwkN XQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4jhb8t3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Nov 2023 20:37:06 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2JX9PH000614;
	Thu, 2 Nov 2023 20:37:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmthmd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Nov 2023 20:37:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A2Kb5Rs41615774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Nov 2023 20:37:05 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3302D5805D;
	Thu,  2 Nov 2023 20:37:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9C1258053;
	Thu,  2 Nov 2023 20:37:04 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Nov 2023 20:37:04 +0000 (GMT)
Message-ID: <14584a37-2882-4cd8-9380-40a532d07731@linux.vnet.ibm.com>
Date: Thu, 2 Nov 2023 15:37:04 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/tg3: fix race condition in tg3_reset_task()
Content-Language: en-US
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, pavan.chebbi@broadcom.com, drc@linux.vnet.ibm.com,
        venkata.sai.duggi@ibm.com
References: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
 <20231102161219.220-1-thinhtr@linux.vnet.ibm.com>
 <CACKFLimX4Pjm89cneeTa36B519DN3mdXXo5FXfDFi6e0SBwUSA@mail.gmail.com>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
In-Reply-To: <CACKFLimX4Pjm89cneeTa36B519DN3mdXXo5FXfDFi6e0SBwUSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BK6J8qCYzTABgikkR3Hg094ixXyOEak1
X-Proofpoint-ORIG-GUID: BK6J8qCYzTABgikkR3Hg094ixXyOEak1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=620 malwarescore=0
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020168

Thanks for the review.

On 11/2/2023 12:27 PM, Michael Chan wrote:
> 
> This scenario can affect other drivers too, right?  Shouldn't this be
> handled in a higher layer before calling ->ndo_tx_timeout() so we
> don't have to add this logic to all the other drivers?  Thanks.

Yes, it does. We can add this into the dev_watchdog() function, but 
further investigations are required. This is because each driver may 
have a different approach to handling its own ->ndo_tx_timeout() function.

Thinh Tran

