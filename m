Return-Path: <netdev+bounces-13401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9D273B717
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CA3281B25
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A592311E;
	Fri, 23 Jun 2023 12:24:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9037499
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:24:15 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEF71FDF
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 05:24:13 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NCFjdJ028392
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NOthYVz4QmmXRe6+Ax0ZeJ9YbOuOfueJcWRNsNfmjPQ=;
 b=tma6K2lqoXWh49sxyO5I/cYkLgQhgpbYow/GmZTBEyfMuvef1YFh5ezlKZ8dTYHW2svx
 MBRkwQaJF3hxjnLHdF3imN/hgHEzIakTaCT2exSGTBNaCZZB/WMew3kz7ro7llzwZ72z
 0f6lsoOhBQrQVwagH0am5RcOlk2NUzGtDFtosX/FG8NSYPRzQxWNV3KEKnKXAAUlLU79
 YLwvUPuYn9q7hvR5eCk3YO+UHuCJzGvbXPEJ/26fNWisZir+adAcYcPw2YNebviV7lfY
 z6/ea3BApi2M6cti15gat2jBIn31mhV10Mu49IwkOOduGU82SgKeXogkS2WcH0BA+hEM Ww== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rdb86g77f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:24:12 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35NBcuu7009586
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:24:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
	by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3r94f77pqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:24:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35NCOAsm38208012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jun 2023 12:24:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDC295805F;
	Fri, 23 Jun 2023 12:24:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6447158062;
	Fri, 23 Jun 2023 12:24:09 +0000 (GMT)
Received: from [9.61.91.250] (unknown [9.61.91.250])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jun 2023 12:24:09 +0000 (GMT)
Message-ID: <62d15d4c-af64-5535-c843-95e379981cad@linux.vnet.ibm.com>
Date: Fri, 23 Jun 2023 05:24:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH net] ibmvnic: Do not reset dql stats on NON_FATAL err
Content-Language: en-US
To: Nick Child <nnac123@linux.ibm.com>, netdev@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com
References: <20230622190332.29223-1-nnac123@linux.ibm.com>
From: Rick Lindsley <ricklind@linux.vnet.ibm.com>
In-Reply-To: <20230622190332.29223-1-nnac123@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lt_I4JM1m-RxWXLmxx50qeskfkPGInCE
X-Proofpoint-ORIG-GUID: Lt_I4JM1m-RxWXLmxx50qeskfkPGInCE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_06,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=890 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/22/23 12:03, Nick Child wrote:

> Signed-off-by: Nick Child <nnac123@linux.ibm.com>

Reviewed-by: ricklind@us.ibm.com


