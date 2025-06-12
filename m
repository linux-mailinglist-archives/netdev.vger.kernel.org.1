Return-Path: <netdev+bounces-196957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AEEAD7150
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5523A7CDF
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8FB23D280;
	Thu, 12 Jun 2025 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QIVNhocs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39B23D2B6
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733898; cv=none; b=F/8w4082sCwVmv5zt661nW9buJTTmTaEKxLvddM+4AmsZlw5Hl8FE6xEAsTMg5IBIWOpQl1K6mPf8UnoTdmYaMU9nMoBD7dVTfw9mjYCO7UIiGRy6TZPmo2ZOfy0TH64NTFv9FgRGLzLtzxsilqhM0JmTXIPVKlZvmTiX/jWAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733898; c=relaxed/simple;
	bh=8e68ZdYfwJ9SIKR0PaMNRZa4wm+7Yizsi1QedFXDS24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ap8qwkZldRlQS8YnWm/ooSNAVNbhWqzyPTm1EISAsofeVgMRTkYmFxITtaei8mKw11p9Hg0SSYApLQaW16v/u+Q8z8FJTF7lAl/mc9mp7meva0U58de9BiKUgJKES8xDENOkznFyCH5TPRioM/bDAodPdl5nv1CyUOcPDzwHU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QIVNhocs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C8pU2a022497;
	Thu, 12 Jun 2025 13:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JS9yila7sIuh0OPO3qFnPZnygKE37v
	wUKALwls3IPys=; b=QIVNhocsUejR31/o7PuwW74B6yQYWWtNZr1fmybu3ZKujZ
	mHkJO2ZPv7bTEQMhUAcj/b/CpIV0IkXHmwzpyW5PzynGSCJRfsXyRcikLlXiGUcO
	KpFop3C6RwJn4bjSJ1QZg0eEBVhxKHf1KAlxzCUs45TmXkdpMQLH+3TWiglwxh3F
	G9CZ2sAWg98tFmTprjOviGDYe6x8rMCvhYEWCI5d+6wjUUXEogGh47MHddTPLQNv
	hbSmAgtGWiSMzxPziAML2LbwRdJm1Alsh7FSd/I98/Y6ADe2YrQBhTM/HgKLrym6
	SI7v9hr1pwUTBukeUyedfoiHOjIkhGKq+qaQZpHg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7tt9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:11:25 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55CD7q5K026263;
	Thu, 12 Jun 2025 13:11:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7tt9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:11:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55CAqcDT027940;
	Thu, 12 Jun 2025 13:11:23 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mms99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:11:23 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55CDBNAe30868106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:11:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A84058055;
	Thu, 12 Jun 2025 13:11:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C03B5804B;
	Thu, 12 Jun 2025 13:11:22 +0000 (GMT)
Received: from d.ibm.com (unknown [9.61.33.169])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 13:11:22 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk
Subject: Re: [PATCH net] net: drv: netdevsim: don't napi_complete() from
 netpoll
In-Reply-To: <aEqIqDwHUGcblXjT@gmail.com> (Breno Leitao's message of "Thu, 12
	Jun 2025 00:58:32 -0700")
References: <20250611174643.2769263-1-kuba@kernel.org>
	<87a56dj4t6.fsf@linux.ibm.com> <aEqIqDwHUGcblXjT@gmail.com>
Date: Thu, 12 Jun 2025 08:11:21 -0500
Message-ID: <87tt4lm7eu.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aXgHlmoYMjYDNRHKvbaOyWHD4FLpqIrK
X-Proofpoint-GUID: oWlev-_i4-j5_4oZP3Z_dYJVkbPFPcR5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA5OCBTYWx0ZWRfXxO5TdjhlN+OO 6+GuGWY0kUJox0SoZwhBmRQnuR43JhZaXD90l7w1AQU/JncRogMs6+KYJKqBqJRZxrPOB2hhSJd ksJ4CpEoOxF3lnCKrZsIIoJaEg8kY6KcFcTje9jI+RC4UWxqrtCKV7SojnNVapbTIWCXsE+vpZn
 Of1P0SrfyXNFWXKUFSWEQ04/EQZwjFqmY+JncWt3P/xSc4BLqbBvIJBCy2enTaSUAkKJ1eknmgK WrZn+Jb8wd5p+RT874kW9khpohMLqFP9LeCIt8oA6twJYqdLHh3lJUdHg4MzwHpztrMOaSME+Wj QM9XsZWhJQ3HIKSQQGJx9UTKq9j0BSo0naKPPn0Fz8BD0H/ROKwbhbaDdwWXndEId5Wgzmux2fK
 zXsOq4a/o+6F0+GV3x3QS71EAWqHUw+S6V67AmDhYxEV7wlfwKrUB5XJj8sbVXv+avqsbVo+
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=684ad1fd cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=xNf9USuDAAAA:8 a=VwQbUJbxAAAA:8 a=SyieWsbd4_lZMvWE-1cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=537 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120098

Breno Leitao <leitao@debian.org> writes:

> Hello Dave,
>
> On Wed, Jun 11, 2025 at 05:23:33PM -0500, Dave Marquardt wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> 
>> > netdevsim supports netpoll. Make sure we don't call napi_complete()
>> > from it, since it may not be scheduled. Breno reports hitting a
>> > warning in napi_complete_done():
>> 
>> I decided to go learn a bit more about netdevsim, and ran across a typo
>> in Documentation/networking/devlink/netdevsim.rst:
>
> I acknowledge the bug exists in the latest netnext/main repo. Would you
> like to send a patch and fix it, or, should we?

I'll send in a patch. Thanks.

> Thanks for reporting it.

You're welcome!

-Dave

