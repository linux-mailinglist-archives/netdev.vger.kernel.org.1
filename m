Return-Path: <netdev+bounces-64237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEECA831DE5
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 17:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21431C233DE
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624D2C1B1;
	Thu, 18 Jan 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BGITM14f"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43CC2D021
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596823; cv=none; b=L+ta0rV2ghj9GI4DsFBpF61uboKjo2o6h7M7jxrBvfAo2q+TaRC1lKXLkmtzrUq4OuXHBfW5HUhEzg02qbumkHHB8A+MAEAHTZHwdpHWpqBKQU6QiZIbmwdsM6lprn4slqVEo+qtD3F3g7gBSk5wJe0eQpVrTt0iSBvRSWmNex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596823; c=relaxed/simple;
	bh=9B2fRhEu03vjcuy7sMB3oHOAvIqRvSBd45bkR5FwFNY=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=HYl1eYNVWRizFDoOSvng6i/bFSlTKA7b+QkrsA8RJfxluyxQHGWFhgETdi8iHup/r9juZYFCdKOas+Idm+QYI0n10IT7svNPADSplWfqcF9R67b678wiRXjqMSWM4ygRUG9Smfcx2jaIUN0wbP/NqiOo9kTkVhYqu7HyM+24M6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BGITM14f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40IGgMpE015238;
	Thu, 18 Jan 2024 16:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9B2fRhEu03vjcuy7sMB3oHOAvIqRvSBd45bkR5FwFNY=;
 b=BGITM14fjmfjexBpvyWLwQkRIic1HyELMDyxgCY2sz3panDJcw/ZQHc+4y4CJDgfne5F
 cvs0wuaJTiwtHyWkSe3dvJP4RtVnYmoB7CpvlUIBYnvK7zuzihaBz84/zPpHGSHaOEd1
 41f0UQEm8QPksRofJMwFjI03AgkZdIP/h0EUJJNbkiEZyDaCRtKZq4aF2iRQw+8kWonc
 PWlAzmn6IpvUDOBH/z9lDRI1yaTEGUdbITIiDyilab1wSNBfp3wPihsUdUTh4+I2cnxK
 FZIIFYI1paMKM/06y6S5UUvFfF2nl86ltjzVTFTiG5FOdhxLJ5VDTJST1wXb9M24JKF7 yA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq7r48ar2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:53:37 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40IGgpEs016095;
	Thu, 18 Jan 2024 16:53:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq7r48app-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:53:36 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40IE3axL030430;
	Thu, 18 Jan 2024 16:53:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72kc5ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:53:34 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40IGrUav63701494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 16:53:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A89695805C;
	Thu, 18 Jan 2024 16:53:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B28458059;
	Thu, 18 Jan 2024 16:53:30 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jan 2024 16:53:29 +0000 (GMT)
Message-ID: <35ccf649-60e9-4903-b066-a9d8f8785ea4@linux.vnet.ibm.com>
Date: Thu, 18 Jan 2024 10:53:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 <dd4d42ef-4c49-46fb-8e90-9b80c1315e92@linux.vnet.ibm.com>
 <20240117155544.225ae950@kernel.org>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Content-Language: en-US
In-Reply-To: <20240117155544.225ae950@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uy9iZRrzoTmiU3fvFXaoQtgJUyJb5Tqj
X-Proofpoint-ORIG-GUID: 9evmKUCf8w8GlVKH7Ir9NNxLmW5l0or4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=604
 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180123


On 1/17/2024 5:55 PM, Jakub Kicinski wrote:
> If there are any patches that got stuck in a limbo for a long time
> please repost them in a new thread. If I'm looking this up right in
> online archives the thread is 6 months old, I've deleted the old
> messages already :(

I will work on re-posting them in a new different thread.
Thank you.
Thinh Tran

