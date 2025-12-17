Return-Path: <netdev+bounces-245222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ECDCC92D7
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2559A3006FDA
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E52264A7;
	Wed, 17 Dec 2025 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LjoJGj2l"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CC221F15;
	Wed, 17 Dec 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994598; cv=none; b=P2astcdnloZInqBuM7gq/0A9QobtnPUZfkafeIvBmzV8v690VsVhkkGqaUltXhF21rI/lJDQbtNVazNgGr6FGv5xCAFl4vtS2VpX04s/PfTlq0zMYjopDKciKsgB+vtRm4ZLoCeAcQ4dACcOFbasALv2hPJuQcZKcgY53+vJjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994598; c=relaxed/simple;
	bh=uSceWFaMRv/vLMPCIs0E55jB2q/opgZHsOR3k2RQotQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bralHANW0UOWCEJdl+krewqikHtzGDEhLJXnb5OXZmo+Xbx6oCHdKhcokJgcCPkR6SgTLX8oKcX5qUbkeShfi3gV4ZlA348j01i6DcbpiR18YhM5nXP82BP19uYlucMgdyBHgilc8QYDxW/JVCauJrEQrN5a+T0lRQmO/ytKcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LjoJGj2l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHBKDBo029270;
	Wed, 17 Dec 2025 18:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XG2ZaD
	P/0AFoPQxBvishTBzsRDMVjKNentwRDxaL4vw=; b=LjoJGj2lFq8zdtZO9fMctl
	FraF6ARa5T28kg3oJj4h2q8uxZJek962cc6a4ZiDBhNJ5JBFb8U1iBCwvtGWHXd9
	ezb5PBo2m7GOsgrSjmaZGxQjS3In52l58CgAAhQqJpAc1PNjaI6KtfzmUx9vezi4
	j+r8RdJ2vLV2EGhjI+BElUND4FCBsPEH2HMPMTAWV7BWU5MfVrKKDZWXks10/Was
	cH4CMkYlheJ9qvGQLox6BXo5W0kLwr417+KRhJlv55p0RqyP6RD8yTFsEA/zDyMg
	vMpTjt6NJ5NWQccmiRwccNIQxAacFxDEKPzPHkvic/M2jkMsKI0yBUZHZjODO+yg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvegdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 18:03:11 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BHHvItn021490;
	Wed, 17 Dec 2025 18:03:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvegdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 18:03:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHFXdp6005762;
	Wed, 17 Dec 2025 18:03:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgp2fcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 18:03:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BHI38uU9437558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:03:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 059DA2004B;
	Wed, 17 Dec 2025 18:03:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51B5420040;
	Wed, 17 Dec 2025 18:03:06 +0000 (GMT)
Received: from [9.124.209.67] (unknown [9.124.209.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Dec 2025 18:03:05 +0000 (GMT)
Message-ID: <e9f4abee-b132-440f-a50e-bced0868b5a7@linux.ibm.com>
Date: Wed, 17 Dec 2025 23:33:04 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REPORT] Null pointer deref in net/core/dev.c on PowerPC
To: Eric Dumazet <edumazet@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <q3j7p3zkhipxleesykpfrfhznasqnn6mnfqlcphponzvsyavxf@a6ko6obdpso3>
 <CANn89i+8hX9SjbhR2GOe+RfEkeksKCtPbkz-6pQhCA=pjnr5zg@mail.gmail.com>
 <CANn89iKUQXmR6uaxVJDi=c3iTgtHbVaTQfRZ_w-YsPywS-fHaw@mail.gmail.com>
 <CANn89iJj_Vyt2g6QewwaNAXAZ+0iso=4yj0t3U11V_nuUk4ThQ@mail.gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <CANn89iJj_Vyt2g6QewwaNAXAZ+0iso=4yj0t3U11V_nuUk4ThQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX38k9md9b5tOx
 4rqYENnyq5njkddUEFOOkHgtXoHcQ12NYcP4sjeIPA2qKLSXg750fLZ+9bh4Wju5/mpAh/pusNZ
 e3GKeJ3GsWPpSGdhcWJaol0qSU44FxMip+nWIeLHUJ5DMxPOLri0ibxumHd2vi0nVS2H7sYTJZ6
 iCOkybDQ7wnQ/7iUHWYgTSk79LvkCFjjylW3/asbYBCmQBfwlO8ruFDvHnSs9IQEA07TOdPmLxJ
 R/Fa+g1tJE7Wg185HjaioYcg9WAtDzZadWVTNpTzDWPxVNn6bucvligkvM36JmM1X0GsVJe+BiX
 KbTFI090QDwljWZWbxNzD+Ynr9liL1+er7I2p7OWQyMP/rAIm6/3Ee3ID9NnwrT4fnZbsyDX+Qd
 3DDyOR60isfjulQ7GO1A1hYOFU9o1w==
X-Proofpoint-ORIG-GUID: 7ZmvwSR6rZJDkQ5BBXspCaRkehw7umBt
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=6942f05f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VtXhkl1E8SHrIERY0sQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Pj43X6vaWNCRcmx2CqDTyZ3JHc3RgHm4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

On 17/12/25 20:11, Eric Dumazet wrote:

> <...snip...>
>
> I will send the following fix, thanks.
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9094c0fb8c68..36dc5199037e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4241,9 +4241,11 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>                  int count = 0;
>
>                  llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
> -                       prefetch(next);
> -                       prefetch(&next->priority);
> -                       skb_mark_not_on_list(skb);
> +                       if (next) {
> +                               prefetch(next);
> +                               prefetch(&next->priority);
> +                               skb_mark_not_on_list(skb);
> +                       }
>                          rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
>                          count++;
>                  }

Thanks for the quick fix Eric !

- Aditya G


