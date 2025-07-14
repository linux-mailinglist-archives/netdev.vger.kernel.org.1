Return-Path: <netdev+bounces-206496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7EB0349D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107DB3AAA38
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 02:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E2578F54;
	Mon, 14 Jul 2025 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pruja2CJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668EDDC5;
	Mon, 14 Jul 2025 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752461213; cv=none; b=dimXMv+TiGGcNfD8oJn1/hg61YecAVcyQikAjCbqy3Kc9Iw6mrl4X4JeI1WKyiucesSJKLCBYCLOX8dIOOL0bMqI9JBSPHOM8bH/7WIrgWO7vg8UVIgkv9PdIFsm5lbPQN6+rJ+/9b0aMVWW+AJFgf9SqMKQ858wP8WpPFJdozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752461213; c=relaxed/simple;
	bh=6jVlByuyw2bTejNgVlSpF2RAfEYJ8+KaVDGnkIsYty4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Un7+DXf0Rvmg5QCsOBSpLCZLFUuCY4Q4jUaawhNQONE6FiWX5g6Vw6yaK3C05W5DvTFaGbbc+xzHRxShLkpF/QYKijAEryOiZeXAdpEMPPCh+cKaLMdQjM0BJg7f90n/8DxArzfWOLnbzpg97TvYlEd8FL3vM68totNJXkqFDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pruja2CJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNHoVl026978;
	Mon, 14 Jul 2025 02:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JWfYSI
	G6I7rVkluKLLqWpmYdSnPexiUt7de1+X95vKU=; b=Pruja2CJxc0MnzqChhVvb/
	ZuA53oYN8peSUHjiCHeInFHueTQpDbHTSd7OQ3CYjsG8BHes8NMFh4s366qdCszp
	Nb1CD3FCCKOuOKL1okfjOMFlxFxgq+XXbJjB3WjEbbeZWdIka3bbak7Sb8S4UE3e
	zAADUvZo3c4Tm+GpsC69QMJs57gFMIDfoEtQTwnwdzBe+5n3hWLF/4MDMhHM63AB
	LKn5krCLIRNwz1tDHYvz7Q4Q4vM4rQ68xOnEalyOH3cOhxOUV6IkawIP9St61OjK
	hSx7USa+CGm3PP7boyyt0G3gT6sOkSPs4XIzkx+JLWVvaMk6u2tjbkhIgqJ+hrwQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7cq8dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 02:46:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56E2kcuA015642;
	Mon, 14 Jul 2025 02:46:38 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7cq8cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 02:46:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56DMcLsE031903;
	Mon, 14 Jul 2025 02:46:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v21tv6ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 02:46:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56E2k5aP12649174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 02:46:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 668A35805B;
	Mon, 14 Jul 2025 02:46:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48DF758055;
	Mon, 14 Jul 2025 02:46:00 +0000 (GMT)
Received: from [9.39.29.80] (unknown [9.39.29.80])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 02:45:59 +0000 (GMT)
Message-ID: <926d9ce3-04fc-4055-b5e5-fda8772e3da8@linux.ibm.com>
Date: Mon, 14 Jul 2025 08:15:58 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] ioctl numbers list cleanup for
 papr-physical-attestation.h
To: Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        Haren Myneni <haren@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>
References: <20250714015711.14525-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20250714015711.14525-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: txyLKlAusqD86jgsu6Jhws2pezSwcL-B
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=68746f8f cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=k9sf4av91IVL3TbTha8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ejVelwgNTWVw-bzXUfSzhnsqVssm4XJi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAxNCBTYWx0ZWRfX+49B4kjAte+2 bQC1hgd9dbASOcQGSUWS4i3BCc1CuWkDPqzZLX3g6bkS6joh/jI/tW7kIQpY5FkhHAPSEl5xZdV dolDM6K8gieG3MO7X97M7PFWAybp1Qe1mPpYRUBlW/7ninEmnYYQ8C0fBG9zo8aqmUZJHbXBo6W
 Ef+2nyugMp0AZ/BfylMX+50UiU+pIHWmNoEX2dzvWNYc5plpiVpQa2HrAvz1sYoK0j14/HHfEey ZiF+Po351nfTNx6KELqBCYCQUNl9AhBkPJUPxUEVpW3EaJuRIAGZC+OhPZ90ZUP7bw9vZLaZm3g 8jen2oe1g/fTktvOqVzN4nOSwMr+2vrRxpQiAnOtDw4Hknk308uMn9x5H3JpMvawNNBTASb5rRW
 pWQEm1lN7V7CDpFISPrKa1t/uq5KwmI/4AoaCY+qnH5QgJ3lbV2o1EHhPMPc3ObOD6phaHFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140014



On 7/14/25 7:27 AM, Bagas Sanjaya wrote:
> Hi,
> 
> This is the cleanup series following up from 03c9d1a5a30d93 ("Documentation:
> Fix description format for powerpc RTAS ioctls"). It is based on docs-next
> tree. The end result should be the same as my previous fixup patch [1].
> 
> Enjoy!
> 

for powerpc changes
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>


> Changes since v1 (RESEND) [2]:
> 
>   * Add Fixes: and Reviewed-by: trailers (Haren)
>   * Expand tabs for uapi/misc/amd-apml.h to match other entries
> 
> Jon: Would you like to apply this series on docs-next or should powerpc
> folks handle it?
> 
> [1]: https://lore.kernel.org/linuxppc-dev/20250429130524.33587-2-bagasdotme@gmail.com/
> [2]: https://lore.kernel.org/lkml/20250708004334.15861-1-bagasdotme@gmail.com/
> 
> Bagas Sanjaya (3):
>   Documentation: ioctl-number: Fix linuxppc-dev mailto link
>   Documentation: ioctl-number: Extend "Include File" column width
>   Documentation: ioctl-number: Correct full path to
>     papr-physical-attestation.h
> 
>  .../userspace-api/ioctl/ioctl-number.rst      | 516 +++++++++---------
>  1 file changed, 258 insertions(+), 258 deletions(-)
> 
> 
> base-commit: f55b3ca3cf1d1652c4b3481b671940461331d69f


