Return-Path: <netdev+bounces-223869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F027AB7E867
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FEA1C01327
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3324327B34D;
	Wed, 17 Sep 2025 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gku9gMuz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABBF2737EA
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091953; cv=none; b=s7hPL1XNMXYmVLZSOv9x4avomGXHWLqS9UI+UvrGnkC4OVR+sX+oQrOyICWmIRTbRCQu2MEbNeS/zJrTuUpmDZqwdoRozQPYbOJqQ0psmrzcrZS8mFXR+EZYBkw8pef1EJag5YCRxi5X0c7IE+6nRgKIY4fP7n4HyincPgHaCL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091953; c=relaxed/simple;
	bh=AUFSGDO8+g1fHAxf49dG5u1EXTk4Q/TzUn7VuD1RL6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsRm26pesM1k39pjKDX2CRCYp4EaecNrXuDkxHxnx9h7V9mFps6Qli84HGLEwWqGGoQSquW/Wj3Im0KSiaXPeCpRFX/F9CbAR9BfDHdyAdJ548v7/RPsd76J1WiAwR3/pFjAdT4dHzbjJyYTgeKpxXjm33bT2McWIPur1s9FOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gku9gMuz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLlstb011456;
	Wed, 17 Sep 2025 06:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f+KZwU
	4tfTJdO3dQUeybErprLWCxm+hhGMqDL2hXDPo=; b=gku9gMuz8FFngyMyJnLWG9
	quL5soaurWJKUPJuDLpfLTrDVjzUZhXBmMILucl0X8OPXJnO8tKrYYfYMdM3RXA2
	tFSHr77LRA6plzGFTCAYO/TxQeRFArOXG8f29w/qM6ky5VmM5yA0IPSS7CCroXCZ
	ud07v6djWheL0opn0ybNT5rcCeQ0rA0hb72znZhIVcIQdAPunNXRvUWSNgIi7mLN
	+ll1Y+MjD1DlESw8P3yOqgXmPBbJVfPwAqU7ur59KD7UeTnE5Mt1MbPo2d2I+MVT
	6TzdtdRtejmqtc2O5LK17+TN4EuASMBtr2c8hfIwmEobHy2V12U4hDxJmyu/X2BA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j1xx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 06:52:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58H6cowR018262;
	Wed, 17 Sep 2025 06:52:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j1xwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 06:52:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58H5AcIT006360;
	Wed, 17 Sep 2025 06:52:23 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxu847k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 06:52:23 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58H6qMUa27918870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 06:52:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07B7C58065;
	Wed, 17 Sep 2025 06:52:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A926F58055;
	Wed, 17 Sep 2025 06:52:14 +0000 (GMT)
Received: from [9.109.249.37] (unknown [9.109.249.37])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Sep 2025 06:52:14 +0000 (GMT)
Message-ID: <980e87b7-64f8-4980-83b0-e386d48af310@linux.ibm.com>
Date: Wed, 17 Sep 2025 12:22:12 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/7] smc: Fix use-after-free in
 __pnet_find_base_ndev().
To: Kuniyuki Iwashima <kuniyu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
        netdev@vger.kernel.org,
        syzbot+ea28e9d85be2f327b6c6@syzkaller.appspotmail.com,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Hans Wippel <hwippel@linux.ibm.com>
References: <20250916214758.650211-1-kuniyu@google.com>
 <20250916214758.650211-2-kuniyu@google.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20250916214758.650211-2-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68ca5aa8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qcOnEbsG-MeFDvkMTDwA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: wJh2hg8BnFyGtithucHhKMsMCeRscyT0
X-Proofpoint-GUID: zFqc0ii07YGb1gUCOqhwiIcmU5UzTSOT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX1JvenECVYci6
 3M1jci7Cpp0E+6NyTFWafLPD7Cn68zdR/qTLZAtIh8x2OPprov6HIxaMTFKYuGnwl9sOK9/fVUU
 cKWHBzEJdUERhfiar0rsWAihfcb/1nkFxL/7RuvRRNtX/6EAdNadxvHJ30cVEI3AE1wU6S6t5yQ
 f+4c7oByUMh3qbpnJvltd23hIOJ6VCGcAUV6wenG207y4clHOTSQkAYkBGbWHbeGDaHBeQF1inq
 mp3caCSx60NF9KegG3hCN1eMQ0XJzBju2wQFRMRk+9hsmYu3OEMmsHO4zxgym0i4RuM9dNpAFbB
 TGWBxVTeZDHOVRPVyj+ZDo9lP6GqoZ8eT0f1qxmx/fX4faCyPym/UF6UvHT3026rMPCw56RVf57
 j7jSbpXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On 17/09/25 3:17 am, Kuniyuki Iwashima wrote:
> +	dst = __sk_dst_get(sk);
> +	dev = dst ? dst_dev_rcu(dst) : NULL;
> +	dev_hold(dev);

We should hold the reference to dev only if it's non-NULL(although
netdev_hold() has this sanity check), as we are doing the same while
releasing the reference to dev in below code:

if(dev) {
    smc_pnet_find_roce_by_pnetid(dev, ini);
    dev_put(dev);
}

Same applies to changes in smc_pnet_find_ism_resource().

