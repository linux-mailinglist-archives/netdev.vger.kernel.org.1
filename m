Return-Path: <netdev+bounces-205456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45402AFECCF
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07D91C80714
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5867F2E5B3E;
	Wed,  9 Jul 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sL9AKewi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44B2E5439;
	Wed,  9 Jul 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072855; cv=none; b=D/IMoMdmn9FgCaK0q4ITf+i3qdQLTcJ35bFKQ1Hg6m9XHiHi2ya+8w+gbt7q5gdIH/ya3PuDOAOXS6LRA9vs8DUFC+7qUgxYvy7NAak2092epTwQCmlYQ6XTfbsdfChs2qik7p4KapD5N4njtBHVvTF2USw2LniecGJqw83PmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072855; c=relaxed/simple;
	bh=dNLzjC5cbAtc+WGHoz2N9GM8DGnG4GAdrFbTM0MLisk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=N6dP1CxXLkDNWT0prVutTsVku2HMEK623mF630SLnXLTm12YTqHwcKysXkIOg5pWIEXYMEVCgwjGGbSkD9klFNSBz4QSjdx60OOztimv09lX74oAz4oBF4PnFgbDgx04gHPIzQuZ8t9CeS2WduvMBB1sPqkREf97NONBubMoGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sL9AKewi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569EibIG002270;
	Wed, 9 Jul 2025 14:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=prlAiOpLaURH0Js5JeA28ZU+M2LH
	gadfDLjNoT5X4Iw=; b=sL9AKewi7GvexNKYRtU8mynQ8lRMcNUsw4hBgkAUkZtw
	XQZayr5WaSMJG63vem7J9G+ozQ0AaDaQGHzg6ODOaiHZTKYV/bnNr9896Rvj/OAk
	T9XAXhZhYKofixWn7OqMdE/9hPMypuOIjgFDaCjLXK7LwwRbdkchYND1jPo/K0Uj
	qa+sBx0LBX24vTpeDMw0QZ6XiF5eXTrL1UKcR2mFPxYHICTKaEZpBbBkX+YBR8Mn
	OIQVT0oD9lzZ8W9BptvxAOO5sYrz0hZqXS9l8mDCTRF7QEdHNcOnLnRI1dL1+1rW
	jWSMmNfXr/wsiXFuIprShDqQ12hDpohBYc/rkWBgZQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur76xad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 14:54:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569C50fc024353;
	Wed, 9 Jul 2025 14:54:04 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32gcj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 14:54:04 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569Es3wX23528096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 14:54:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCDDF58058;
	Wed,  9 Jul 2025 14:54:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0B3058057;
	Wed,  9 Jul 2025 14:54:03 +0000 (GMT)
Received: from [9.41.105.251] (unknown [9.41.105.251])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 14:54:03 +0000 (GMT)
Message-ID: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
Date: Wed, 9 Jul 2025 09:54:03 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: RE: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
To: mhal@rbox.co, sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, v4bel@theori.io, leonardi@redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEzMyBTYWx0ZWRfX53N/PUiiBrFU MaQgG2KYArLUO/pTwJVwCcpcxwFX40XiQkl5qcyc54T1nPARhzyQlL6XPtMOdF9BC2NY7iXJWUJ euYTfsfufS4/JT6464Ws5ppuUjIqlvx20vkjA+SOwvHc944xh3oIEWkOxVWL4d8sVBCtQ6bFrjb
 hWVtaIK1QCk7ZiV/4pIuepwDYnyqDR7XdYZ8JA76jzSP2AGQXg0ImXkbDXijKJHgYC012O3ksHX SYjFMGrVAYR9uoD3lAcHFAuHJZssiCyuKwdy1vX0UEDrlNABePoeoxG+bKIlTO0a+5fVh8z7MTb fydCQzgq+7jBEGw8VeN6a6Qt0++LL4CjHGEviV6JBuJ9rMC6OaZEJtOxW5npf47uj2uCbedVPxi
 2U4OZSsowXe3kxp7pj2jFdcqQ4yuoOybvI3x9174e2u12S4k7HwvPkW/nghQIbhGBY8qFHp5
X-Proofpoint-GUID: kpQOMYYazyKyewxIir8QAhgrx-roNt3U
X-Proofpoint-ORIG-GUID: kpQOMYYazyKyewxIir8QAhgrx-roNt3U
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686e828d cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=hBMHHm5UMeqtWk0fnh8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=754 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090133

I'm seeing a problem on s390 with the new "SOCK_STREAM transport change 
null-ptr-deref" test. Here is how it appears to happen:

test_stream_transport_change_client() spins for 2s and sends 70K+ 
CONTROL_CONTINUE messages to the "control" socket.

test_stream_transport_change_server() spins calling accept() because it 
keeps receiving CONTROL_CONTINUE.

When the client exits, the server has received just under 1K of those 
70K CONTROL_CONTINUE, so it calls accept() again but the client has 
exited, so accept() never returns and the server never exits.


