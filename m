Return-Path: <netdev+bounces-86698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD6989FFEF
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 20:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0B81C2588A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECCD38DCC;
	Wed, 10 Apr 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V9DtGi4I"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065D63E
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774375; cv=none; b=AgkNv9R4lqBmFpllG1j2u7JqojYWb8TP6ZvQN3/kU/F50rNUnESm72lkE0c0JptPh6k4ABTj1Agj9G0uLUcWFoVHUeNwA57pouxQ8fW3leQuLWITf2jZYp4c7FznuVX5poVztfN7LTDtwu5DBV1+thvOkEssUgtZDZi5y45GO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774375; c=relaxed/simple;
	bh=Sfe5GMqaxptis3nA0tBRPzdKqkivUwlx4u4s3ESpY/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7VOiRdypUhq+yzxaHrFAutYN3CMJ5Fg5Iki2KL9EAYEHpWn+t+cDIROm8SDzkgVyUmz2fjXJYwqD1XbGPgBECirCiyyWAhdLm2HoMghQEkBgG3V9auDlKj/Kwd6cCCk5nq2LDFpS7q1psSFdwedcTE9ztAzlubPeWLWXtkWeOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V9DtGi4I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AIVNsG020832;
	Wed, 10 Apr 2024 18:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1g8qLSFDaRoHD+tgx2RPRGRGSlyFA9/OVNoNoq1R4f8=;
 b=V9DtGi4IKYDdFUKPOIiq2HBl1qTR8QNuTr/nOPmvnkaU2vZxuDnk4u/Avw3tzIx9W9pd
 iU/gV7WWLLrM/Bh8cA/gwDuDxKJOWmi73VlGOX8MwG7tDugrbUy0Y2dGm9XJvvmRMbWJ
 BAgDMm0q+ayIRZTJn6FZZjYuzF0SltUPssjd+eULzXkGKrK/ucz8nms+ApKZUxuhik/q
 CaW6aXVSFaQXrHhwP+/KlYa0hiLtNqxFMG5pDBQlCkEaE1ezqG2eb3NNXIv5rrvgp9Zw
 gbIovrorEtNWnFsVgGRKcJM0KGs5NW6W11UqWpOdqwjZJMeHyQa/RtKj9/PjbtyDRjQ4 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdy8g85ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 18:39:24 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43AIdNrl003137;
	Wed, 10 Apr 2024 18:39:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdy8g85j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 18:39:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43AGPEjm019089;
	Wed, 10 Apr 2024 18:39:22 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbh40ervp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 18:39:22 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43AIdKmB14156402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 18:39:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F1515804E;
	Wed, 10 Apr 2024 18:39:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42D005803F;
	Wed, 10 Apr 2024 18:39:17 +0000 (GMT)
Received: from [9.43.101.208] (unknown [9.43.101.208])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Apr 2024 18:39:16 +0000 (GMT)
Message-ID: <f3804927-5a66-4469-9b12-b11790db30c1@linux.vnet.ibm.com>
Date: Thu, 11 Apr 2024 00:09:15 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: add missing conditional compiling for call to
 r8169_remove_leds
To: Heiner Kallweit <hkallweit1@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d080038c-eb6b-45ac-9237-b8c1cdd7870f@gmail.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
In-Reply-To: <d080038c-eb6b-45ac-9237-b8c1cdd7870f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HS9aiVhfvcPLNu_teARObfXjRcTLKf-3
X-Proofpoint-GUID: TEB4W2TkK4HMO8Ap5esVYjqgBKNKLZLJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404100136

Applied the patch and verified the reported issue.

Kernel compilation is successful on PowerPC with this patch.


Tested-By: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>

On 10/04/24 6:41 pm, Heiner Kallweit wrote:
> Add missing dependency on CONFIG_R8169_LEDS. As-is a link error occurs
> if config option CONFIG_R8169_LEDS isn't enabled.
>
> Fixes: 19fa4f2a85d7 ("r8169: fix LED-related deadlock on module removal")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 06631a0d6..746ef4f34 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5046,7 +5046,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
>
>   	cancel_work_sync(&tp->wk.work);
>
> -	r8169_remove_leds(tp->leds);
> +	if (IS_ENABLED(CONFIG_R8169_LEDS))
> +		r8169_remove_leds(tp->leds);
>
>   	unregister_netdev(tp->dev);
>

