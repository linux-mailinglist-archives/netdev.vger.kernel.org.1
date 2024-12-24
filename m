Return-Path: <netdev+bounces-154143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB199FB9B1
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 07:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D518851B6
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 06:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4939D16F0E8;
	Tue, 24 Dec 2024 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FOiZMMV/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8CB1632DF
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735020765; cv=none; b=Y8ZPETuT8idAjEU5E6Wl87KqfoMbqrx3CkXhsEOMAtFv+Umv29fRkhvwhRW1aZvToiQ6nWL/WBE3gTszzl5AuY3+2KiFpi5oaxevQTWKlQ1K/OSRpyU4+hTgDepXy2kFg8DUw2kIxI0xsHM3AGAyJ8c9wTm7AvRv/nFuaYu9uXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735020765; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=ILg3C8iVzQGdqmNyBTvO7iM8CjecfQHaipv6xYG7WAeS/DxOgEsNIWCAtcnEkGzYrITwclcorUhzJ4KWlGnT+WdLzEbHEmD1gHvTfwSiuTMaKPhMAu4zL/WP4VIc/fVEXG0IWcen3GpxioB1r11myGlANHmIXuIVZkamiBb/GWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FOiZMMV/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNNw3eO024578
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 06:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:to; s=pp1; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZ
	G3hSuFU=; b=FOiZMMV/4Ha2Hq0ovzrHwG90ae/GAFuqmamwIsKOFhFAVowZoPFL
	ramdOGE/KwiI8Q0wHaYF4dcASBtUH8jKYYysXin8sVXvrPnvEMUtrOqrUlPKppBJ
	aJFT/xDHsCXQ4Lc7meBKGIqWo65svKZQylDam1PumNjLB2mSTSQPEMmdmOug+Kph
	nUdR6IKAm4RIbXxqZgs0hj1Ctan1A/QcZ22QQronbR40JwQmu1n+X3YP/2hf6qDr
	LdJVhyXj/zJJ3N+SaJBCohtzP6/n7gXDHRHzaLnrqecsYa61/BGxA6yfc/8g3SDo
	pFSaY64/fgi7BwNQrUSZRAo4opLwlJqOKw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43qj0h93db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 06:12:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO5CCYk020602
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 06:12:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43p8cy8yw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 06:12:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BO6CdJF43712848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 06:12:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 781AC20049
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 06:12:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED64F20040
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 06:12:38 +0000 (GMT)
Received: from [9.43.12.88] (unknown [9.43.12.88])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 06:12:38 +0000 (GMT)
Message-ID: <b8d92605-389c-4ff9-ab84-a348df7d67a6@linux.ibm.com>
Date: Tue, 24 Dec 2024 11:42:37 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GeDUIttbOfJQWy4qVu08KjYqMvI0aQPn
X-Proofpoint-GUID: GeDUIttbOfJQWy4qVu08KjYqMvI0aQPn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 priorityscore=1501
 spamscore=100 malwarescore=0 suspectscore=0 mlxscore=100
 lowpriorityscore=100 bulkscore=100 clxscore=1011 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=-999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412240047



