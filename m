Return-Path: <netdev+bounces-222446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6C1B5443E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE031C851F2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EBE2D374B;
	Fri, 12 Sep 2025 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mbSGpM4g"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE12D0C73
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663721; cv=none; b=NQcemH4eDhB+F9maPGrL8z1BIZm8YMvqghbJLkTY34hd++pEJXwfIZLW/JiM1gKj1oH9K5LvRTu3tUvugiI7n4Xjo/crXoKBmLGD3GM+mX8+aCzSwIAGh+yuLjWjN14P+I8IwQ8o96SEQmXNM/TZXLUbgAeokyHqKxc0xcUlu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663721; c=relaxed/simple;
	bh=DTqvsw4qXOEu+kqfyOV7016ZeUHhry0mNl6j+VJxWvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIEZxGE3Ktf6+tJd7JZF0uNFmBtHjMI81vVm9eOMtP0SJ/+7XiA5Y8I2Z64bfzVzynlL7Cu1pOb4jK4p+u/z6CKGO0rkybaeTff48lM/o6DqhYNV1Kg7PpQmlooJRg5tkSqke86DFtNICwUEVxmbqlqxHiwxlDP3v5Jlx2o9wl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mbSGpM4g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C0HLfk026794;
	Fri, 12 Sep 2025 07:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0H5Ye0
	HnmqsNE3KZxJLgnJF6e/eSe+Vo9T/tAuq5Tf0=; b=mbSGpM4gw3MvnJVAiY9bDj
	rTmHn/04G99EFTqhdZ0UJjSJkbI91HYB26DSlRhaQEIgfJOhigqca6IX8KGNgFig
	dHibIGbemdXXVx0jBWSkrdHub8Gu27nT0skvlgtJdNEBQojv5XDJ/ALscZ1dmyWw
	ld0hwNfV+0h4BaIIej+NYVXS1SwNVtvYmjUPLu2JP2k4YgxMaSWdYc4Y9L2UrtlN
	ztmFlOTHEPveEKCgdpZySgjIH/gO1ykpNngymogvNtHeoTytoUFS/HQXEEXmZdCV
	MgjSj+NSl37psNpGq9NaVoZy0bvQ3H2AyUJQqgbZyIOtYrc2AH++n/7oaEMmdsvA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct8tjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 07:55:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58C7sO47009409;
	Fri, 12 Sep 2025 07:55:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct8tjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 07:55:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C6O8Vj007895;
	Fri, 12 Sep 2025 07:55:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109q1v7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 07:55:05 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C7t37f24707740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 07:55:04 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93BCB58066;
	Fri, 12 Sep 2025 07:55:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0009C58055;
	Fri, 12 Sep 2025 07:54:56 +0000 (GMT)
Received: from [9.124.209.229] (unknown [9.124.209.229])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 07:54:56 +0000 (GMT)
Message-ID: <3ac0ee3d-c0bf-4768-8ccc-8f853762a8db@linux.ibm.com>
Date: Fri, 12 Sep 2025 13:24:54 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 2/8] smc: Fix use-after-free in
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
References: <20250911030620.1284754-1-kuniyu@google.com>
 <20250911030620.1284754-3-kuniyu@google.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20250911030620.1284754-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfXz23jPX82GwLE
 6LncM2CyZzGXmR8+eRECrzIu5QpMXsXlRcfU+yMLBCP7HDiqZ5fo8X9VQqib+WO0HqmavoS7nvB
 xnronIHK0ueIIlPHi/P4FHLa69q4+a9Ecq8DIpGZgHUNBDDo5+kZHypFWkViwg3vuu96/K9cP8C
 4LGOCijyOW3scGjEdS2vGcjNtg5NnXqL8DC0PfMWB8wv0eWGLrDXxF/tjqDVBLbEZJ6nheEBuqt
 QvzW1j1tZG0oYNHEUSsPOvCTYkIAPiACKw6/yKTe4EciFp4Hm8XJl5aZD3oYjYvqbLmr3/KuQh3
 VUJhQUju7knv3CXMofk0+NXFVMhSvNOvNMoAGePBjcxg7/zKPpIRj44QIBvlW4yGmJBr6+Lu2pH
 a7Iw24/0
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c3d1da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NDGw0OzkLI9679OIc1QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: q_o9NJviujAijhQw3TB_EJFxrqnIYhRu
X-Proofpoint-ORIG-GUID: Fxbj6bdBNbC5bKOYGIWNCrlhELwp6uZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

On 11/09/25 8:35 am, Kuniyuki Iwashima wrote:
> -	return;
> +	dev = sk_dst_dev_get(sk);
> +	if (dev) {
> +		smc_pnet_find_roce_by_pnetid(dev, ini);
> +		dev_put(dev);

Nit: Should we use netdev_put() along with netdev_hold() in
sk_dst_dev_get()? Same query for other places where we are using dev_put().

