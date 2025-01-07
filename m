Return-Path: <netdev+bounces-156057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEBBA04C80
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CE43A5600
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66C190664;
	Tue,  7 Jan 2025 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p9Ws3LF+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA791547D2;
	Tue,  7 Jan 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736289464; cv=none; b=c7ugBRYGez6jMczBvfRaeTRS6aI6zIKUFCPTowidgMrDeklopefydfY1chK984bapMy9rvMgIvkfGS+/2m303AapOnggmiCeHew2fiDKNKlN9Cgb/Fi7RdqOPJ+GUPqrBwY1J34cnHpnpM5+bokM2hMGQyMwdkQ6vPJKFL6Mgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736289464; c=relaxed/simple;
	bh=B8e+xEfOWI0aLh1SLfKwpFsxGLp+uW7m9Jxr6PXRQhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8rwyXW6Ppqye/5s9V70JZlFl13XWl0J1wd6TJcaohJ9MrDAyS6fYbXdSM7YKIVwT8HQJfkUDpn//Z3+T9w5XI6sBef/HSCXuznawBGPVs1PQgBntHV4e/2w/BIgvnkRuDKfa9C39XzA9Eu5QnVyJxYww5TDrFCEjQahvHQl+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p9Ws3LF+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507IpaPC017068;
	Tue, 7 Jan 2025 22:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=f3I3xNe5tf5PxRlQiIa/QdPJ2W7CT1
	4VEdt/v0XfjS4=; b=p9Ws3LF+GHwWepZWmCOh45tyZFUkZ58cWbtFf0ThKWbAwL
	R/wp5bK7Q97qcmrxvj4bbQf3AW0S3jk6IpuXVTCaeowTxEXZH4yN2beeF6/LfDx2
	ouRS8bpInJNjJh2sUGws5hv80iO1HQ7p+dvXaY6qlp1LANR60mddR8SpSI2Pll+I
	bG11zNReqlRBMrPImn93WgtXVxAix+UcaHJL2uhymSWlb9+0lqTOdHBtBO5wHaFY
	bALHGUC7eRA3qLzQ9ilSJroV91UtuPZc5ZP6/DX2KKFGb1a1/O+i1fg4E5XfS80l
	e6xYK5w/OtlUAkm1Ptu5sM+rz9iSAfHMYYsPgA4Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f3bsqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 22:37:20 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 507MZRjb018656;
	Tue, 7 Jan 2025 22:37:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f3bsqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 22:37:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507KxACM015903;
	Tue, 7 Jan 2025 22:37:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtkvnmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 22:37:19 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507MbHCp49676660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 22:37:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C36D45805C;
	Tue,  7 Jan 2025 22:37:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E5E45805A;
	Tue,  7 Jan 2025 22:37:17 +0000 (GMT)
Received: from localhost (unknown [9.61.96.42])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 22:37:17 +0000 (GMT)
Date: Tue, 7 Jan 2025 16:37:17 -0600
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
        Paolo Abeni <pabeni@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 03/14] ibmvnic: simplify ibmvnic_set_queue_affinity()
Message-ID: <Z32sncx9K4iFLsJN@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20241228184949.31582-4-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228184949.31582-4-yury.norov@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AxRovVz_4HNYWZW6641qBcGGq8aQ8ffV
X-Proofpoint-ORIG-GUID: dr50qABO6GMvF_Cx5R3v4q56nfrbvOux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070185

On Sat, Dec 28, 2024 at 10:49:35AM -0800, Yury Norov wrote:
> A loop based on cpumask_next_wrap() opencodes the dedicated macro
> for_each_online_cpu_wrap(). Using the macro allows to avoid setting
> bits affinity mask more than once when stride >= num_online_cpus.
> 
> This also helps to drop cpumask handling code in the caller function.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index e95ae0d39948..4cfd90fb206b 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -234,11 +234,16 @@ static int ibmvnic_set_queue_affinity(struct ibmvnic_sub_crq_queue *queue,
>  		(*stragglers)--;
>  	}
>  	/* atomic write is safer than writing bit by bit directly */
> -	for (i = 0; i < stride; i++) {
> -		cpumask_set_cpu(*cpu, mask);
> -		*cpu = cpumask_next_wrap(*cpu, cpu_online_mask,
> -					 nr_cpu_ids, false);
> +	for_each_online_cpu_wrap(i, *cpu) {
> +		if (!stride--)
> +			break;
> +		cpumask_set_cpu(i, mask);
>  	}
> +
> +	/* For the next queue we start from the first unused CPU in this queue */
> +	if (i < nr_cpu_ids)
> +		*cpu = i + 1;
> +
This should read '*cpu = i'. Since the loop breaks after incrementing i.
Thanks!

>  	/* set queue affinity mask */
>  	cpumask_copy(queue->affinity_mask, mask);
>  	rc = irq_set_affinity_and_hint(queue->irq, queue->affinity_mask);
> @@ -256,7 +261,7 @@ static void ibmvnic_set_affinity(struct ibmvnic_adapter *adapter)
>  	int num_rxqs = adapter->num_active_rx_scrqs, i_rxqs = 0;
>  	int num_txqs = adapter->num_active_tx_scrqs, i_txqs = 0;
>  	int total_queues, stride, stragglers, i;
> -	unsigned int num_cpu, cpu;
> +	unsigned int num_cpu, cpu = 0;
>  	bool is_rx_queue;
>  	int rc = 0;
>  
> @@ -274,8 +279,6 @@ static void ibmvnic_set_affinity(struct ibmvnic_adapter *adapter)
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

