Return-Path: <netdev+bounces-40376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CDD7C6F80
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761431C20E0F
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29129436;
	Thu, 12 Oct 2023 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A0zQdqWJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B330D10
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 13:43:30 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA9DD8;
	Thu, 12 Oct 2023 06:43:29 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CDgKFP003264;
	Thu, 12 Oct 2023 13:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lzXaihcDEmMlytJEnr77pMDykkIJtsqA5QqL0d4jvq4=;
 b=A0zQdqWJMX76xz0QXocqZ5I0DxcXrs3m/AtDxNaFkCP1MsIM5XWjwg/1Agj6omviNoX9
 snf2gFoqjPWF6v1RKhdkKPUwh3MdwKpK3Bvs+V3zYNWgpJD0cdLDJVDoASj8ny+fGLaQ
 kD7GFZXFWUFTrizY0dD924dCquLr3CQETRJ776Rg1aPTijbZhBXzwyGgD3HHYt3xXeF0
 PjB2V4aq2DLCIY8l266+QGdUdLx64M9RFriSMBC8jcRHCmaXP/GM/w8TKOjFg25NoJ+h
 oZQ9kJjGm3qR/ez77cP2tMh+uTtKl8PSeR2ASCJqBU0cpErdXe1UY3Yv1ZAsmCLhTo3U Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tphws80v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:43:26 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CDgccx004425;
	Thu, 12 Oct 2023 13:43:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tphws80tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:43:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CDdKRd000643;
	Thu, 12 Oct 2023 13:43:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5kyk7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:43:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CDhKRN15663654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 13:43:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8A5A20049;
	Thu, 12 Oct 2023 13:43:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A3A820040;
	Thu, 12 Oct 2023 13:43:20 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Oct 2023 13:43:20 +0000 (GMT)
Message-ID: <4a1b965e-b026-45d7-bd09-7b23b797ee90@linux.ibm.com>
Date: Thu, 12 Oct 2023 15:43:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/5] net/smc: bugfixs for smc-r
Content-Language: en-US
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cqme9AwFc-FQEQByXQWS7amK014YhBiB
X-Proofpoint-ORIG-GUID: JjI_kfomKUBgQqxDEsLmN6kpYTIGtTQg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=523 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The subject of the thread says 'smc-r', but some of the changes affect smc-d alike,
don't they?


On 11.10.23 09:33, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patches contains bugfix following:
> 
> 1. hung state
> 2. sock leak
> 3. potential panic 
> 

I may be helpful for the reviewers, when you point out, which patch fixes which problem.

Were they all found by code reviews?
Or did some occur in real life? If so, then what were the symptoms?
A description of the symptoms is helpful for somebody who is debugging and wants to check
whether the issue was already fixed upstream.

