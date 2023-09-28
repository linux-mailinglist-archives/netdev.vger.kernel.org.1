Return-Path: <netdev+bounces-36719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143947B16B4
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 332321C208B5
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9008B3399E;
	Thu, 28 Sep 2023 08:57:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415C3399A
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:57:08 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBD01721;
	Thu, 28 Sep 2023 01:57:03 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8eieG001387;
	Thu, 28 Sep 2023 08:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+ADnxpkM7TAKCoPJthsbqz4OgNVoOWCyY4HXjRSWMFU=;
 b=T2/O+yfyrBeONtNEf4JzWpq58wdhXBFm9MBlciOU3l2GwrFI34yTX+3uL6K6l5QOBfVP
 /qSwI3TfNyfX1FwblQE0DdmXiC1IGvAytSxa1Cxgt6ILwUnT/h00QLahG4pyn/Exq+oZ
 yHmhoQekYWl+GRRKJRMgTTtBZhvK2EDKivmR+ZhT6zNGH0OiIGEbdjnEqRaKNUoPFXQq
 eCmxeHhW9slSY51EWfvVMtlOAjQfgTZ2wSAmt79dAzY6mmtnr31p1zNybZ6pqtDuBDev
 NVqXfMkrJoqGIW4nDLs4/R6LqMhwOCQ+Lm44IGUcW0fo3Ix5TiCP3y7plraCwuW//ixd tA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td5cjskfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 08:56:52 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38S8g44D007494;
	Thu, 28 Sep 2023 08:56:51 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td5cjskfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 08:56:51 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38S7cvQj030732;
	Thu, 28 Sep 2023 08:56:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjkac6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 08:56:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38S8ukTI14811760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Sep 2023 08:56:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F2032004B;
	Thu, 28 Sep 2023 08:56:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28C8820043;
	Thu, 28 Sep 2023 08:56:46 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Sep 2023 08:56:46 +0000 (GMT)
Message-ID: <1fc9a6aa-019d-f3f5-7cac-3b78388c2730@linux.ibm.com>
Date: Thu, 28 Sep 2023 10:56:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
From: Alexandra Winter <wintera@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <2e4bb42a-1a6c-476e-c982-c4d6cfdac63b@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <2e4bb42a-1a6c-476e-c982-c4d6cfdac63b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3u0mE6isZQEWaMZr66BtMn3nV5SCHNz_
X-Proofpoint-ORIG-GUID: P9AZLsMBMclMYv_-x57oqCKi10nuGGfa
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_06,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=782 mlxscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280073
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 27.09.23 17:16, Alexandra Winter wrote:
> Hello Wen Gu,
> 
> I applied and built your patches and noticed some things that you may want to consider in the next version:


FYI, patchwork basically complains about many the same issues:
https://patchwork.kernel.org/project/netdevbpf/list/?series=787037&state=*

In general you should run those check BEFORE you send the patches and not rely on patchwork.

