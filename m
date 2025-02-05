Return-Path: <netdev+bounces-163284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B088AA29D07
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0809D3A1CBC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8C421505E;
	Wed,  5 Feb 2025 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EpL72wEA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8C1519B4;
	Wed,  5 Feb 2025 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796439; cv=none; b=XnurpE2cjIRVovQ9Qjg05MPHhuqOGiXHmAI9CdEiIhWuRSDYeZXAn/n8WtPCL/4oO7MOOUfsGL6luwaGDLpiUEqql709lmTpoFH+zDxkaxlmA50zBhdjyaCNg7gc88U/uoX2fSiwfftZNsQf39cO3ZF1m1Wv8D1p8PjRYAWxGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796439; c=relaxed/simple;
	bh=LaTI9Ovfik3rTkSpQhtpIz4SEx0LeILc9RAC6ekVtHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFfdcashOUDahu6HlHK8AXpJNVO8ZXcsDPiN29Tp9k3qBfYtfIerh4Z8i6DQAbr8qtd3RC55x8aAKNSXAcv7HuI0edkpqLljaDfq8GiTNJvgnASz6FwzdbWDt747GMbwLIVodbZT/bgWLDitu7u4O+fnRGfso6OeDIKU8hzKZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EpL72wEA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515MWUX5011361;
	Wed, 5 Feb 2025 23:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Kyj4592/Vdaiqvqm+X1lwa8g7u23mB
	IpzdJ84G1p7Lc=; b=EpL72wEAV2RCdpHNpIUMY5FRwchEr9BO8bLwc6tWB4nLux
	n6Tqs7mdVK4NYBYvKJKRCkAEE7RSTjqtPB/6lzYOlaQykFg4T/WKZ5uWqvUvMLDA
	GIJmC1aJNJvjEf6WVTWEKuQtfebLNKqjKblE1R+pGtoZ4hejLSWF9NvMttagWlsJ
	KVGBhTdwGJa7sHREk/zFlVbGwv3WFfcuW0Vsu51M2bWzgv+3JbvbQF3OOkDT5ZbF
	efns7zVnoS/JreYpTzGFZTsnYcZ1gZ84V0CJj+4VddaF6kemECV4dqQyb4sb63pl
	RBKUJbGmUnWvivx4HZtQCXkkYHED1b+rl61v9YeQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kx29p39m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 23:00:25 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 515Mx37w032396;
	Wed, 5 Feb 2025 23:00:25 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kx29p39k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 23:00:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515KTrqk005251;
	Wed, 5 Feb 2025 23:00:24 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05k31te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 23:00:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515N0N8D16450056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 23:00:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DE705806A;
	Wed,  5 Feb 2025 23:00:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D93E58064;
	Wed,  5 Feb 2025 23:00:23 +0000 (GMT)
Received: from localhost (unknown [9.61.82.89])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 23:00:23 +0000 (GMT)
Date: Wed, 5 Feb 2025 17:00:23 -0600
From: Nick Child <nnac123@linux.ibm.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 02/13] virtio_net: simplify virtnet_set_affinity()
Message-ID: <Z6PthznH5Tp-ZdHw@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250128164646.4009-1-yury.norov@gmail.com>
 <20250128164646.4009-3-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128164646.4009-3-yury.norov@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K7D4TPrZFEYxpz2AL0sWv287fg2oxywf
X-Proofpoint-ORIG-GUID: eJfy_3KbPsJRzD60u06T4ivUF-ntf4ce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_08,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050176

On Tue, Jan 28, 2025 at 11:46:31AM -0500, Yury Norov wrote:
> The inner loop may be replaced with the dedicated for_each_online_cpu_wrap.
> It helps to avoid setting the same bits in the @mask more than once, in
> case of group_size is greater than number of online CPUs.

nit: Looking at the previous logic of how group_stride is calculated, I don't
think there is possibility of "setting the same bits in the @mask more
than once". group_stride = n_cpu / n_queues

nit: I see this more as 2 patches. The introduction of a new core
helper function is a bit buried.

> 
> CC: Nick Child <nnac123@linux.ibm.com>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Don't know if my comments alone merit a v3 and I think the patch
does simplify the codebase so:
Reviewed-by: Nick Child <nnac123@linux.ibm.com>

> ---
>  drivers/net/virtio_net.c | 12 +++++++-----
>  include/linux/cpumask.h  |  4 ++++
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7646ddd9bef7..9d7c37e968b5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3826,7 +3826,7 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
>  	cpumask_var_t mask;
>  	int stragglers;
>  	int group_size;
> -	int i, j, cpu;
> +	int i, start = 0, cpu;
>  	int num_cpu;
>  	int stride;
>  
> @@ -3840,16 +3840,18 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
>  	stragglers = num_cpu >= vi->curr_queue_pairs ?
>  			num_cpu % vi->curr_queue_pairs :
>  			0;
> -	cpu = cpumask_first(cpu_online_mask);
>  
>  	for (i = 0; i < vi->curr_queue_pairs; i++) {
>  		group_size = stride + (i < stragglers ? 1 : 0);
>  
> -		for (j = 0; j < group_size; j++) {
> +		for_each_online_cpu_wrap(cpu, start) {
> +			if (!group_size--) {
> +				start = cpu;
> +				break;
> +			}
>  			cpumask_set_cpu(cpu, mask);
> -			cpu = cpumask_next_wrap(cpu, cpu_online_mask,
> -						nr_cpu_ids, false);
>  		}
> +
>  		virtqueue_set_affinity(vi->rq[i].vq, mask);
>  		virtqueue_set_affinity(vi->sq[i].vq, mask);
>  		__netif_set_xps_queue(vi->dev, cpumask_bits(mask), i, XPS_CPUS);
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 5cf69a110c1c..30042351f15f 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -1036,6 +1036,8 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
>  
>  #define for_each_possible_cpu_wrap(cpu, start)	\
>  	for ((void)(start), (cpu) = 0; (cpu) < 1; (cpu)++)
> +#define for_each_online_cpu_wrap(cpu, start)	\
> +	for ((void)(start), (cpu) = 0; (cpu) < 1; (cpu)++)
>  #else
>  #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
>  #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
> @@ -1044,6 +1046,8 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
>  
>  #define for_each_possible_cpu_wrap(cpu, start)	\
>  	for_each_cpu_wrap((cpu), cpu_possible_mask, (start))
> +#define for_each_online_cpu_wrap(cpu, start)	\
> +	for_each_cpu_wrap((cpu), cpu_online_mask, (start))
>  #endif
>  
>  /* Wrappers for arch boot code to manipulate normally-constant masks */
> -- 
> 2.43.0
> 

