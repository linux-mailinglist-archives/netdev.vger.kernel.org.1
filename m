Return-Path: <netdev+bounces-163290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B29FA29D33
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9035D16560A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B4B21A928;
	Wed,  5 Feb 2025 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CNwxz8qR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DFD1F473C;
	Wed,  5 Feb 2025 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738797046; cv=none; b=OwgMfZMooWj5zWZ9PdCfCF4Bx05v3ukwc5pO+cqGOji2oxlA0OjNbEPSv2QV64UBHw6p5EjtwLYZU1m8cGItSjdYvQFkuEunAWvKFaJz54qdOinFpd+4lBnkjCdHwTG2G1auRK7pZKaebsF7yqzdNp58sO0NanwK2dGxhb1AJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738797046; c=relaxed/simple;
	bh=YMj9qB7NEC7PNrJfxOw2lcGFPvJemO3tb29mJD8IcQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7PvSieXKTppBQQPeyrOD9NEcAoJOfFyZ3Qqk9OB0s0alTgdQN1DXEAUHFnVDM3Lfsk0rAzEetsYudu42Bi5HXVTEn2uvRzRQ1bcS/C7RXLh8a5miU1sctaHXBs0b4CT8wbD3oXtrnxQJfFC5VQv7IUvX/IkGcmvs+jsclGTFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CNwxz8qR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515LtvWF012355;
	Wed, 5 Feb 2025 23:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PGCd8ZwjBCrKo/Gcc9RNre0nXerVDb
	ALy9VUPGSTsi0=; b=CNwxz8qRtvz9+1HjK1cDL6UYWEYmP/gPma+uobQbomq8ax
	BPtg3ZposFnzwAt7ErThvDrEhCTPLIhhNKfMu9z03GXEVtK22Z3c6urs7Jd7Ruje
	ZWHZ0aF1NppPlXw+klE2zEJp08YSn7P/8Jjg/HlG0Hox7/pxVY+iTLShSBknjwAZ
	DqAQhda1RmvuEMz9kn+NirLFMPNGFu/z0QS3jvKv8TTr7lMWPYmTfvdgwtx9dzl+
	sTTNjT9551y6bzA3QCUCB0SUtGbHoYicSqtjtlOXXVM/ATt3XtOrBBiomV1WUrV2
	QM9IK2cw0QQyWRbpI01A025i6TUPlVjuDDuY1PLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kx29p47k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 23:10:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 515N9TCA019736;
	Wed, 5 Feb 2025 23:10:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kx29p47e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 23:10:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515MZIsv016271;
	Wed, 5 Feb 2025 23:10:22 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxskgy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 23:10:22 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515NALjo27329068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 23:10:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EACB58055;
	Wed,  5 Feb 2025 23:10:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76B7A58043;
	Wed,  5 Feb 2025 23:10:21 +0000 (GMT)
Received: from localhost (unknown [9.61.82.89])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 23:10:21 +0000 (GMT)
Date: Wed, 5 Feb 2025 17:10:21 -0600
From: Nick Child <nnac123@linux.ibm.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.ibm.com>,
        Rick Lindsley <ricklind@linux.ibm.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 03/13] ibmvnic: simplify ibmvnic_set_queue_affinity()
Message-ID: <Z6Pv3TpYa0E6VG8Q@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250128164646.4009-1-yury.norov@gmail.com>
 <20250128164646.4009-4-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128164646.4009-4-yury.norov@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FKFXu_VHEgRaKdgkfaaOLyXb1G-5BqUs
X-Proofpoint-ORIG-GUID: lBn3bs6SLZidv6fgDqxsEIlIJvED9bjp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_08,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050176

On Tue, Jan 28, 2025 at 11:46:32AM -0500, Yury Norov wrote:
> A loop based on cpumask_next_wrap() opencodes the dedicated macro
> for_each_online_cpu_wrap(). Using the macro allows to avoid setting
> bits affinity mask more than once when stride >= num_online_cpus.
>

nit: Same comment as left in patch 2. Don't think re-iterating over
cpu's was ever possible. But I do think the patch improves readability
and simplifies things.

> This also helps to drop cpumask handling code in the caller function.
> 
> CC: Nick Child <nnac123@linux.ibm.com>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Built/booted kernel (patch 10 is ill-formated), messed around with n
online cpu and n queues. All ibmvnic affinity values look correct.
Thanks!

Tested-by: Nick Child <nnac123@linux.ibm.com>

> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index e95ae0d39948..bef18ff69065 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -234,11 +234,17 @@ static int ibmvnic_set_queue_affinity(struct ibmvnic_sub_crq_queue *queue,
>  		(*stragglers)--;
>  	}
>  	/* atomic write is safer than writing bit by bit directly */
> -	for (i = 0; i < stride; i++) {
> -		cpumask_set_cpu(*cpu, mask);
> -		*cpu = cpumask_next_wrap(*cpu, cpu_online_mask,
> -					 nr_cpu_ids, false);
> +	for_each_online_cpu_wrap(i, *cpu) {
> +		if (!stride--) {
> +			/* For the next queue we start from the first
> +			 * unused CPU in this queue
> +			 */
> +			*cpu = i;
> +			break;
> +		}
> +		cpumask_set_cpu(i, mask);
>  	}
> +
>  	/* set queue affinity mask */
>  	cpumask_copy(queue->affinity_mask, mask);
>  	rc = irq_set_affinity_and_hint(queue->irq, queue->affinity_mask);
> @@ -256,7 +262,7 @@ static void ibmvnic_set_affinity(struct ibmvnic_adapter *adapter)
>  	int num_rxqs = adapter->num_active_rx_scrqs, i_rxqs = 0;
>  	int num_txqs = adapter->num_active_tx_scrqs, i_txqs = 0;
>  	int total_queues, stride, stragglers, i;
> -	unsigned int num_cpu, cpu;
> +	unsigned int num_cpu, cpu = 0;
>  	bool is_rx_queue;
>  	int rc = 0;
>  
> @@ -274,8 +280,6 @@ static void ibmvnic_set_affinity(struct ibmvnic_adapter *adapter)
>  	stride = max_t(int, num_cpu / total_queues, 1);
>  	/* number of leftover cpu's */
>  	stragglers = num_cpu >= total_queues ? num_cpu % total_queues : 0;
> -	/* next available cpu to assign irq to */
> -	cpu = cpumask_next(-1, cpu_online_mask);
>  
>  	for (i = 0; i < total_queues; i++) {
>  		is_rx_queue = false;
> -- 
> 2.43.0
> 

