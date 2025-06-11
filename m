Return-Path: <netdev+bounces-196742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32723AD625A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D010D3A86A4
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4942248F7E;
	Wed, 11 Jun 2025 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kZZuf8Qj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40E248F40
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680635; cv=none; b=pZqEQKPMB2yb3kK2CuY72y031YAfCBUGkgK/9V0+BzqMYmmTfzf89ttczhyBVy+iNtYpwh3v0HsRskqiBCbq3ZA2C0deez01RAZFSh8ZCYphXnSXEzdVTawcfjhYorRpGxOITPAyTuOh+uqhUprxg05XYO3dCsjAO/bbCa6piI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680635; c=relaxed/simple;
	bh=YkPIXsVgqaEADWR3Di2XH/sr5j2JkGCMKdso6VcbzRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kjop62KhsHKnBF1JdMVDwb2b9Ey5g0tbJD4sMAD2cTIcBNqWPreTz+djzaUnWB8dGv5rZBi1j+w5ByECqIorEb60zfzsyyVaHy4ArcBZon2DQGoOFrm5LzLpkIbXl4nHnPnCvI8tv/fOHQWpC1pTaxAtHFHfX4tljbcy7Ym1yms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kZZuf8Qj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BImQgp032616;
	Wed, 11 Jun 2025 22:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AYWWfm+DgbyHxPrSCH1TCg3EsQ9kuc
	Dm5xhvxigRRmc=; b=kZZuf8QjfJ6jvLQy8KuUt63/maNt/qsSyuDF3RziNWDt+Q
	VHrXwdDP8tVjd//DZmmC0izc1YF1/8eTCRnmwzbWZky1oXunkysXNiZSlvHmk0BF
	hIiQxelG/VNPBmXuxtfghe5oYcy3ZVRS+xdTuEBvw+wsW8EkJCYN5z1gt2YU/OQ9
	A5Hz/mKzOUJLymQ66c4U1zUl6Tm2IQN8G4T8FuuGIzWoY0iKhSLXgiD0NvoCR4lu
	Y1Bz+P92n7JMxmHkyQY7AbcPpSpiwMfaaqyDyK/cz+/+iZfg48GQ4lyYtM/Piayc
	/3WuZJ8eqpzWx1+K/0W8O34NN75IXwU6v9XrAj/A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wyuxq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 22:23:38 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55BMJ4ac005208;
	Wed, 11 Jun 2025 22:23:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wyuxq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 22:23:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55BLRpVF015369;
	Wed, 11 Jun 2025 22:23:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rp9thc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 22:23:35 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55BMNZG226018318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 22:23:35 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECAF558054;
	Wed, 11 Jun 2025 22:23:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69F8B5805D;
	Wed, 11 Jun 2025 22:23:34 +0000 (GMT)
Received: from d.ibm.com (unknown [9.61.46.212])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Jun 2025 22:23:34 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
        Breno
 Leitao <leitao@debian.org>, dw@davidwei.uk
Subject: Re: [PATCH net] net: drv: netdevsim: don't napi_complete() from
 netpoll
In-Reply-To: <20250611174643.2769263-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 11 Jun 2025 10:46:43 -0700")
References: <20250611174643.2769263-1-kuba@kernel.org>
Date: Wed, 11 Jun 2025 17:23:33 -0500
Message-ID: <87a56dj4t6.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yqgl6lETvV0xT2cBF1Z_eRAuXtaKViMH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE4OSBTYWx0ZWRfX30xhhqIAIMer lel9goPbzVmlh6uOnPHBPWZTj9kN+EBewnsZXYdPcdUm3wNs94xpmkH4ikcVxcyzz7yXlxhvdpM Y9L4dLYaNEzayQCd+VFT8ZPJEiKzuvnskM9KOY5xwWBUMxthQmZYlPnQYhV0NtDbYQZLv1uK0RJ
 HdEMXSmWdQdkqxC5wUBTyyqVdu9t8TRgAe8y2hr/d5Qb0XkFMBMFM+lAETsf3XcXYVjU6F0OwuL ne9rVIMM5yV5sfVsfCldGGT2lEYpA+xeD8ENm9bYjvl9FhTGjE7iJiUPFoEH4cckegLLd2swYFy XeYfN0WGRSfedqsFc/RTqxq+9M/M+TTPToMIxymocW/PFLJSl/QYbdI/Xq4oNWKxdacjXLCovL9
 r1aeWU9f1WhaqqDmS6fQxtP4nd7+5nvui1OlchMsyQ5TXpL11UGQRONlYGzH02kxYQmgCWpA
X-Authority-Analysis: v=2.4 cv=YKGfyQGx c=1 sm=1 tr=0 ts=684a01ea cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=F_mWqpn8S2fbzUKNZgkA:9
X-Proofpoint-GUID: rX45Moq1d-B_dxqYAPRbar4Uj2o7YQbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=460
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110189

Jakub Kicinski <kuba@kernel.org> writes:

> netdevsim supports netpoll. Make sure we don't call napi_complete()
> from it, since it may not be scheduled. Breno reports hitting a
> warning in napi_complete_done():

I decided to go learn a bit more about netdevsim, and ran across a typo
in Documentation/networking/devlink/netdevsim.rst:

The ``netdevsim`` driver supports rate objects management, which includes:

- registerging/unregistering leaf rate objects per VF devlink port;
  ^^^^^^^^^^^^

-Dave

