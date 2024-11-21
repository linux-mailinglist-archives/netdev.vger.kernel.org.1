Return-Path: <netdev+bounces-146596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A359D4836
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A361F21F74
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4FC85C5E;
	Thu, 21 Nov 2024 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="UHNPw+Iq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBD4206E
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732174450; cv=none; b=QDdEfSoJzQbu8ifmA0kIHSNVX/7e9xJ1igrVGVO6w5DQ9HfnugdP+jAGnX5C8PdF7sEOh5+rKbLtqJBxiArsCRt1soUyq9G+uH9RVV/F51jXF754+P40n5SV8G3EZdsjEy9gjXU73MP+t0nn4xN7ZPIjpz+L28DweKBLje6iDfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732174450; c=relaxed/simple;
	bh=iIGHWaA8fwojM+mIuoeogy1CnNj3Eq3mzXL65Kk/7Zw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pF8b1JL/rtFV/fQVe/x0RpsvxhrUzyyMeXgdFkgzk2/h5TA/uaCjKo86iY4QrJEDyWE4eKcM2Ta65TwDTSzyTNFwq4GNn2jgdHyPOBmyqhPTMSjDFk7HLju9HcbsijYEU9vq5RGz6O4gTgIXqO39RFrGDOXNAtuRJJaVkqDvCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=UHNPw+Iq; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 4AL5sgI9001902;
	Thu, 21 Nov 2024 07:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=iIGHWaA8fwojM+mIuoeogy1CnNj3Eq3mzXL65Kk/7Zw=; b=UHNPw+Iq1ef4
	RdE41oKJGYtrjbofAtz4vqaIc4i+fjAY1IIIpAd+d58zuH0qnEAvMuE0TgZA6CJk
	2oCUjGIxYIay7IItBwJjG9VglJH5yMl/lQvV+m2hYu6jip+vQSZye/U22rAxt6UH
	jdvm4d9eN05Gc8o9SWEbfEQx9bRHXG1KTRa1ozq5bnwGzhO5c6bbbz/LaZEI6/2q
	3ol68KjPzGCYlTprJGn+Rdj9FjZvDNRFyUkZ1dBi7t/8Z7omgB6tHLXsOTcbt81M
	VHx4oJ0ZFqPJ4ufFVbeXFpX4C47UiMr7MB5WYWiyxx4IghOgrHSZPhjIfO2ilHCa
	rcAvNchuRA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 42xknjbh3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 07:22:52 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL0bfqo010271;
	Thu, 21 Nov 2024 02:22:51 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.207])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 42xqm19tpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 02:22:51 -0500
Received: from ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) by
 ustx2ex-dag4mb8.msg.corp.akamai.com (172.27.50.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Nov 2024 23:22:50 -0800
Received: from ustx2ex-dag4mb2.msg.corp.akamai.com ([172.27.50.201]) by
 ustx2ex-dag4mb2.msg.corp.akamai.com ([172.27.50.201]) with mapi id
 15.02.1544.011; Wed, 20 Nov 2024 23:22:50 -0800
From: "Mortensen, Christian" <cworm@akamai.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        Stefano Salsano
	<stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: Stackoverflow when using seg6 routes
Thread-Topic: Stackoverflow when using seg6 routes
Thread-Index: AQHbLHgGBbzTarS88E2nQjLK/Exe5LLBC8yAgABlMg8=
Date: Thu, 21 Nov 2024 07:22:50 +0000
Message-ID: <ed0a694674a54401af50f50b0f9f4dd5@akamai.com>
References: <2bc9e2079e864a9290561894d2a602d6@akamai.com>,<20241120181201.594aab6da28ec54d263c9177@uniroma2.it>
In-Reply-To: <20241120181201.594aab6da28ec54d263c9177@uniroma2.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_05,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=421 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210055
X-Proofpoint-GUID: 1WJHyKr_Wq3l-HGG-RTeZzBTOI8XATqT
X-Proofpoint-ORIG-GUID: 1WJHyKr_Wq3l-HGG-RTeZzBTOI8XATqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxlogscore=261 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411210056

Hi Andrea,

Thank you for your detailed reply.

I agree this is a=A0pathological example and it came up as a result of a bu=
g in some test code I made.

>=A0Perhaps the Linux kernel should be able to detect and protect itself fr=
om this=A0kind of misconfiguration

Yes, that was my point. As a user, I would not expect that adding routes to=
 the kernel could crash it. But I am not sure what the goal of the Linux ke=
rnel is regarding this.


Best

Christian

