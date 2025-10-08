Return-Path: <netdev+bounces-228179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B40BC3DDA
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EFB94E272A
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3948B2F290A;
	Wed,  8 Oct 2025 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZUhogL6S"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3635E2ECEBB
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912667; cv=none; b=IhAxj3ZanyfqusqsEL07H71GPGqybWsmokrfmhcSv2eKJqs3DHU1qtfGuaQ8Riz9g7zCq4+ie+e1WePPeOvbvKZR1lSchvmhbjOZhG/YHodPVJsvxO0a952Evyd2ljZ5yls7EGpJXQWBwEM09Nysvr5LnMdRNQ9/xgasw7IDzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912667; c=relaxed/simple;
	bh=ShHijeWsGNvood5q77sTgoz5uBtyWGy3piePyGTcnwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MWFZya/aXBGwgL2bMTKzVh4x2IRUYnfbGnVh9X8gg5miHI+5k77zGOIr6hhNWumUT7NHAHQGueCp6NYPY9l8f28uTElnxusiMI1T3k8ImnilHRqMzOf01YJbmj07fsNHJ9guMX9jSlgEvPj2V8VR6ff4DTl+ZwD6wBTBImFsrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZUhogL6S; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59830PLI007974;
	Wed, 8 Oct 2025 08:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jakBv5
	yGt1pyxdDe50tQsxFeV1OpooahSFyyW6cAT6E=; b=ZUhogL6S7r0rzkdAoNmdAl
	y2REvjSHFJgleufEGQIvjsjNPoyCMtPouX/66Zz9YBKhheZ8+DNwS9GMUTPpcj4L
	zL/yE/dps7wFrP/DRm0wDlsANa2cPOfoZdLy+ojx8ufFB2LW1alpHvKXPnJpMa/k
	iheSaANkcAqgAAmlDY4VZLK4l6dnA3jFojRfSySG4Y7/zMrcfARaPNsWaFM4W+SN
	Gj60Q64jzHi+4iUBd31jefSz42D50eZ0QPHDx4Vih133WmZn2UwXYzg8sZgZ6UzF
	eaKrsWXV01ePIlKCnQq05JwlHwjaAUUZkT2uIc1FK7IFJOZvGVX6qwAy4a2yLXoQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0pkcmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 08:37:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5986b404013206;
	Wed, 8 Oct 2025 08:37:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kg4jqdt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 08:37:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5988bcqX34865902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 08:37:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D1CE2004E;
	Wed,  8 Oct 2025 08:37:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64D162004B;
	Wed,  8 Oct 2025 08:37:38 +0000 (GMT)
Received: from [9.111.198.139] (unknown [9.111.198.139])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Oct 2025 08:37:38 +0000 (GMT)
Message-ID: <f3d545b7-a77a-4bcc-9231-69dbb99c2199@linux.ibm.com>
Date: Wed, 8 Oct 2025 10:37:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] LPC 2025: Networking track CFP
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <537d0492-c2ad-4189-bb87-5d2d4b47bc29@redhat.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <537d0492-c2ad-4189-bb87-5d2d4b47bc29@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XvT3+FF9 c=1 sm=1 tr=0 ts=68e622d6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=OGjWj8McAAAA:8 a=gglSMJectvlZH8v_VHoA:9
 a=QEXdDO2ut3YA:10 a=UYjydHh6ynBBc6_pBLvz:22 a=HhbK4dLum7pmb74im6QT:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: S1c3m9xPi5IYij3DHtcisEQnkjfB-hDB
X-Proofpoint-GUID: S1c3m9xPi5IYij3DHtcisEQnkjfB-hDB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwOSBTYWx0ZWRfX+eA499O17FZg
 F3U06JKhQQTcBDhV0YrtA6OxJVirieo1TiliXgC2LVmfaf+cOHoq5iV3NYC1ZZemz+qtpx5zQyL
 lDZZr2qsvcmNeVoycXlKLpAzKQ4chKMWQnztfjc7cIzrXjAWpnqFZVdLgETqcVPYNChtKeBxN3n
 MbveBFBuYmzQobcF3bchrS2+eYd7tJuVEfwpiZoPV6g45I56C+ILQSQ9tgPArxn2ip9w7NPnZf8
 IZGr5odO5BJRi1o833B55OzJI7TeV37NavChyUO6OVcL40NDDywT8+RtmQxOARlDW19yvHxs7vG
 /OpVJ5I0IEzybPcJ8SsHQKvWaO3DklUy8Z86J9IYodl4UZmOIipCw6wDLcfJar1chZfaZqMUzxN
 zFFuofZjC5aTcsL/ltzqTCSYtGS7zQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040009



On 24.09.25 10:09, Paolo Abeni wrote:
> Hi,
> 
> We are pleased to announce the (belated) Call for Proposals (CFP) for
> the Networking track at the 2025 edition of the Linux Plumbers
> Conference (LPC) which is taking place in Tokyo, Japan,
> on December 11th - 13th, 2025.


It seems LPC 2025 is already sold out and has a waiting list:
https://lpc.events/blog/current/

Does anybody have insights wrt the Networking track?
Are there any reserved tickets?


