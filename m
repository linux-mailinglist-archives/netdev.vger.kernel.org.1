Return-Path: <netdev+bounces-28814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEFD780C7A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4AC1C21622
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE5518AFB;
	Fri, 18 Aug 2023 13:25:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C0182B6
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:25:01 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B49712B
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 06:25:00 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IDMBSQ017294;
	Fri, 18 Aug 2023 13:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3oNrVwTrGOuYUgTXYB3rbrIujx7jduGFABTsgvbqr2Y=;
 b=YxG1YmdIcN/fgyorjCnHfmEXq6pRNqbtlE404+xx6LU8HPBO20E8AwwOp3SR0GvHdXZI
 M92jTo3rLMg9ogAFAC/RRvN9x2TZbEZNb5OQO4PjxKbUocqnTGvzy+7Cg1xEwY31Zv03
 wkM/a6rw7/MyALMPDLmCkzgFWb2lFQSmVxfDqC7URf2i1RE+lE1oxblaaOEZzbWRROW7
 Kike0aBqOPmXV3kT9e7F8VZf0w7pDbLc8IkvLLmyC6fhx6/k57BlxRitH/QEGWNujTag
 nzmIpP9qQil/Z+Z0X5ce9Om38BwK1OytlWIB2BCNOCs786dUsycfvhr5NGAD6HLFjbTJ Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj9ffr2vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 13:24:53 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IDMAlf017232;
	Fri, 18 Aug 2023 13:24:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj9ffr2vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 13:24:52 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37ICXxPp013223;
	Fri, 18 Aug 2023 13:24:52 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmkesbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 13:24:52 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IDOpj222348294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Aug 2023 13:24:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 148E758062;
	Fri, 18 Aug 2023 13:24:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4BD5805C;
	Fri, 18 Aug 2023 13:24:50 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Aug 2023 13:24:50 +0000 (GMT)
Message-ID: <ad5dd02a-f84d-0b7b-bd82-1e71141e06ef@linux.vnet.ibm.com>
Date: Fri, 18 Aug 2023 08:24:51 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [Patch v5 0/4] bnx2x: Fix error recovering in switch
 configuration
To: Jakub Kicinski <kuba@kernel.org>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com,
        Abdul Haleem <abdhalee@in.ibm.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
 <20230811201512.461657-1-thinhtr@linux.vnet.ibm.com>
 <20230811150947.18528aca@kernel.org>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Content-Language: en-US
In-Reply-To: <20230811150947.18528aca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LeTVMaPSpLiWSIbyXtVeGXUrALQWpowb
X-Proofpoint-ORIG-GUID: 3HlT1dCeW7xw3m4YRE-eamh4WBfXVilE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_16,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=436 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180120
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/2023 5:09 PM, Jakub Kicinski wrote:

> 
> It's looking fairly reasonable, thanks!
> 
> We do need commit messages describing motivations and impact
> of each individual commit, tho, and those commits which are
> not refactoring / improvements but prevent crashes need to
> have a Fixes tag pointing to the first commit in history where
> problem may occur (sometimes it's the first commit of the entire
> history).
Thanks the review. I'll make the correction and resubmit them shortly.
Thinh Tran

