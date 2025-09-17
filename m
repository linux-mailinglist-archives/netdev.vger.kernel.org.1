Return-Path: <netdev+bounces-223914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA9EB7E840
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538B31C012B9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04482331AE0;
	Wed, 17 Sep 2025 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OrUUqbzo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0F330889
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100451; cv=none; b=DuDN283ABsYsujbjON0iv7AG4MxmF2Yq9+NxdTw34l+qSN7s80uESGq7AM5T+WP8MBZeh0uWGPK87MWNNZ8U5txlzcfQCKDVsIlrvYrZS3t5iCRO24TrjxBDGJKXN2cXtpe8JOvC0ZatKkiVOi8HY2tkldKReoEY8q0//36fQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100451; c=relaxed/simple;
	bh=UqYkRI92nLx2A/WxTx4QExRBvS4REgsh6YI9/5d7OFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAJAcJ8zrE5zwQVnll8uDIJJuz+FN6cxnzmhg0vNyFWldCL+nFoTxPbX/v8n6bzv3ncCNsUwAg7I9Koel2vFib0dvK0jf6tly6RoJ/lj3BSUqFKo2+dfSQ+7/ISCU1bbVNlnxiQe+I3j17qhejvfHjEEv5ZOBn0hxDS40HU3o+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OrUUqbzo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLluB8031273;
	Wed, 17 Sep 2025 09:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UqYkRI
	92nLx2A/WxTx4QExRBvS4REgsh6YI9/5d7OFY=; b=OrUUqbzojp5U54p+3VegcS
	mFZ7IcoWOEXtYgUM3xZUe9zjmnmSizX1LP7YCQy0klS5YXXNIk4356+dsvXI7y2M
	6HnDxsEsMR106PeSrwP4WEfS1No7tgxNFWf5Auc5chmEolpEbQxtfYL7IM26lZTx
	gMvMmsBQfsKk2xlOTDf45T8R/ejhCcctynVizXY2kNEQWXCTrHBmAm6yOJgAKDi8
	tOrBokADVB1nZmJn/XHFEYX5q41Yve3RHEhw5JQ/HbvETn7z7AWxqrsQwErzuppz
	40wqFAPh2/W/oqH0TmLMXInHuOk6vBM8Aayp5Vy+arkS4nL+cpfhlT82lSZiqMuQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hjkt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 09:14:04 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58H9Acin028396;
	Wed, 17 Sep 2025 09:14:03 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hjksw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 09:14:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58H7F3iV018629;
	Wed, 17 Sep 2025 09:14:02 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mg7jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 09:14:02 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58H9E1Vq7209664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 09:14:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F36445805D;
	Wed, 17 Sep 2025 09:14:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C94FB58043;
	Wed, 17 Sep 2025 09:13:54 +0000 (GMT)
Received: from [9.109.249.37] (unknown [9.109.249.37])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Sep 2025 09:13:54 +0000 (GMT)
Message-ID: <e1bae4d7-98f7-4fe6-96ba-c237330c5a64@linux.ibm.com>
Date: Wed, 17 Sep 2025 14:43:49 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 4/7] smc: Use __sk_dst_get() and dst_dev_rcu()
 in smc_vlan_by_tcpsk().
To: Kuniyuki Iwashima <kuniyu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
        netdev@vger.kernel.org, "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>
References: <20250916214758.650211-1-kuniyu@google.com>
 <20250916214758.650211-5-kuniyu@google.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20250916214758.650211-5-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DjEveQe4nSRi-HWBjWW9-gKmkVHHwTcV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX4TrOx47fDTli
 p2X3C39X4FkIux3xlVYLAvOKDa/WLOCK+RWgeHMOV4JkFKg0PBP8jGziXpENb2US4WZCJe0QmpT
 hcqV5DiaA815NlOcMYE+8yLhvnB0NYEipOdzsBpReIUBlvL0kGfDHpxMrg27UIwcd7WfdWCct8r
 Log/DSXEds9qtvWeyjRNsj3a3YnlEuU1OsYB4i3xHv05Ofkhh9nzPuZlubNBBufKA2wvQZUEgGl
 B0GsNleb+l6eoixLB4uk1cfqTdCT9yuJxt1QUwNAU8Gc/9AmSTqoy2UIEkwOt0XKEdY5wN3+Xzi
 BpXiL05/25zIRZbokCYMdH4Qia+1Q2Q4KYT0wuFJ58nJEMMva/+9Dj5VbSId9llrJFAcgYIHKZt
 doESj3FL
X-Proofpoint-GUID: rTSxitT6RiDr6brjroCLLMxvU5Wq8fN4
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68ca7bdc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=PdtfboZQ3bGRdCpD_AIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204



On 17/09/25 3:17 am, Kuniyuki Iwashima wrote:
> Note that the returned value of smc_vlan_by_tcpsk() is not used
> in the caller.

I see that smc_vlan_by_tcpsk() is called in net/smc/af_smc.c file & the
return value is used in if block to decide whether the ini->vlan_id is
set or not. In failure case, the return value has an impact on the CLC
handshake.

