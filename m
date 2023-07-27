Return-Path: <netdev+bounces-21928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044AF7654FC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B882811DA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBB8171C3;
	Thu, 27 Jul 2023 13:29:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72831171B5
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:29:46 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413E82D54
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:29:45 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RDI2io029816;
	Thu, 27 Jul 2023 13:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=k93+V2P2rr8eDBmTFe6/z6FXlnPHWPn5fE+rQrnUkgc=;
 b=I0N4QMBINAeXuW6jB1A4OcTRwOJDXgjqjpji2Dzn/LaVc/gYaZsd30BZt/2xeoa7pRFW
 Jy/uwFcyGlVTPHDp33nTzBXryM7op36rO2WP3vgxo9wJyX4pa+NflX0Z2XR88D4Kx6jz
 QBk2GEQp4i5pI49TtoaC2XeBGT97BGjGHXphbjwGW6gjoUz80C1qH0kIu5ocIqVqqG28
 UDEOeqpElZQRDH0dNa50l5N+zLQcyHXHr7FmHifegohF8O3RZ15ePjtSnICioHCTZcu+
 k9tvuwPC4YUFqIOMxPE8cr5vjUQCD60CBUrdNPwadTxfwuIbOPk1JsF+rh9LiZeWXM8c 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3sbj0c89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jul 2023 13:29:40 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36RDIWHC032041;
	Thu, 27 Jul 2023 13:29:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3sbj0c7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jul 2023 13:29:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36RCqGE5016588;
	Thu, 27 Jul 2023 13:29:38 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0v51n8nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jul 2023 13:29:38 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36RDTclX55640408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jul 2023 13:29:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3046E58052;
	Thu, 27 Jul 2023 13:29:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AA8958045;
	Thu, 27 Jul 2023 13:29:37 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jul 2023 13:29:37 +0000 (GMT)
Message-ID: <af0308e5-f6ad-3caa-07eb-0b89c0d65479@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2023 08:29:38 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch v3] bnx2x: Fix error recovering in switch configuration
To: Jakub Kicinski <kuba@kernel.org>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com
References: <20220916195114.2474829-1-thinhtr@linux.vnet.ibm.com>
 <20230719220200.2485377-1-thinhtr@linux.vnet.ibm.com>
 <20230724155013.442d566c@kernel.org>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Content-Language: en-US
In-Reply-To: <20230724155013.442d566c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W1HGzgFHsCFRTM4b52wTRHT5-dFQHcc-
X-Proofpoint-ORIG-GUID: F7xTCSO75BBVlz3a7diewIzzs8hgCLJH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 mlxlogscore=742 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/24/2023 5:50 PM, Jakub Kicinski wrote:
> 
> You're sprinkling this if around the same piece of code in multiple
> places. Please factor it out into a function, and add return early
> from it if needed. If possible please keep the code symmetric (i.e.
> also factor out the inverse of this code for starting the NIC).

Thank you for reviewing. I'll work for creating a separate function for 
it, and one for the inverse as well if it's possible.

Thinh Tran

