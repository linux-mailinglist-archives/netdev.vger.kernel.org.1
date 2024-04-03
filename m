Return-Path: <netdev+bounces-84660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20456897CBB
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 01:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B564EB296C3
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 23:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB2692FC;
	Wed,  3 Apr 2024 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fRViuOU6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30317139D
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712188362; cv=none; b=tNhbakZzan2PZa8Keyc5Py6c9VzWvAJq0GPghgON5nSaUbE0i0Rjnw1E17QIrF/5YeFlay+dmJltR8zI58ih2JvJu4+gV4NyOnDZ2ZzIVNcuiwsyE2flcSsPHCKRXYvpzGR48JP+j8eU4C1YdSmdw0cLwi6d97JyfLa/91RCNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712188362; c=relaxed/simple;
	bh=FoUqiI2RR0q8tTF07/5/8tIFuOwtHFw/2zEiv97C79s=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=A8AcW02cN/lo4te1eJDBm73tpFwr1wiG6GS4NY5hqu24FZqXpUrLjh/vo2xoC54SGNm8hvEuF6eWghVJfuJkN1zH49YV3MrIUh/epk3UN+oaiNCuuM6ztZykQE+nGDpOiuo/oFBnkVxQY71fyDPRm6OcK7haVwUWWPemnToGvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fRViuOU6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433NUZvw014432
	for <netdev@vger.kernel.org>; Wed, 3 Apr 2024 23:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : subject : message-id : content-type :
 content-transfer-encoding; s=pp1;
 bh=fMUMskOcGBm42rXhl/8iawSLbfaWGmTvObwAts6Wkq8=;
 b=fRViuOU6g9adykUQiwDs86/hsh2WwAsZlO1/a2uP8ZlBP0kgeNyOFsuL6qEyvoPRRooX
 GZs2x0I2TCX1hAQEGkHCAC0lRdypDGweKXXZ0GKAe0KmjRthjt5EKzSueFFSSmPbQU+T
 0zdsVbEWmqzPW26dFV3rwFcVO8VphWFk8V1rRGVVXn4lWf6TMXKJ/tPo3DZ2/HzNXUsZ
 qzzdxkHliTV6r2LgMlk2kRecQrollSsdJDxzf5FSa9SQhVo6B8r0V0FMygJpBXAHN+ee
 2qrhWfVY1IV24X70wM5f5FWM4ACNNh0aCHP8FW7dvtr2KmU51sE0aHHPfJYlu1Mp2kEz mw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9gby028n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 23:52:38 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 433Nqb9l017643
	for <netdev@vger.kernel.org>; Wed, 3 Apr 2024 23:52:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9gby028m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 23:52:37 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433L42DG022270;
	Wed, 3 Apr 2024 23:52:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9eq08pkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 23:52:36 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433NqYev31654202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 23:52:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E0DB5804E;
	Wed,  3 Apr 2024 23:52:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C052F5803F;
	Wed,  3 Apr 2024 23:52:33 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 23:52:33 +0000 (GMT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 03 Apr 2024 16:52:33 -0700
From: dwilder <dwilder@us.ibm.com>
To: edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Warning from napi_get_frags_check()
Message-ID: <89b344be15b6dc0bf488c4ce8cfad046@us.ibm.com>
X-Sender: dwilder@us.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dUNtQZ7dIcy1DDYodb1rcNMpGIxGJNB0
X-Proofpoint-ORIG-GUID: wVs5apJcHR_RIu_vBGbqnE_7afoXSA0q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_25,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=704 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404030160

Hi-
When testing CONFIG_MAX_SKB_FRAGS=45 on ppc64le (pages size 64K), I
saw this warning.

[    0.072724] WARNING: CPU: 0 PID: 1 at net/core/skbuff.c:289 
napi_get_frags_check+0x50/0x90

However, when running the same test on x86_64 (page size 4k) I saw no 
warnings!

Printks from the x86_64 box show that warning should have been 
displayed.
[    2.852540] __napi_alloc_skb len=336 SKB_WITH_OVERHEAD(1024)=256 
SKB_WITH_OVERHEAD(PAGE_SIZE)=3328
[    2.852543] napi_get_frags_check skb=ffff936486b23b00 
NAPI_HAS_SMALL_PAGE_FRAG=1 skb->head_frag=1

The broken warning is due to this change from commit dbae2b062824 ("net: 
skb: introduce and use a single page frag cache").
-       WARN_ON_ONCE(skb && skb->head_frag);
+       WARN_ON_ONCE(!NAPI_HAS_SMALL_PAGE_FRAG && skb && 
skb->head_frag);

Since NAPI_HAS_SMALL_PAGE_FRAG is always 1 when page_size=4k the warning 
will never be displayed on x86_64. Also the "single page frag cache" 
will never be used in my test case.

1) Would changing __napi_alloc_skb() and __netdev_alloc_skb() to 
something like below accomplish the original goal?

    if ( (MAX_SKB_FRAGS == default-value) && (len <= 
SKB_WITH_OVERHEAD(1024)) || len > SKB_WITH_OVERHEAD(PAGE_SIZE)......
    else
    if ( (MAX_SKB_FRAGS > default-value )   && (len <= 
SKB_WITH_OVERHEAD(2048)) || len > SKB_WITH_OVERHEAD(PAGE_SIZE)......

2) The "page frag cache" would need a corresponding change to switch to 
a 2k cache with larger MAX_SKB_FRAGS values.
3) napi_get_frags_check() needs fixing.

Regards
David Wilder









