Return-Path: <netdev+bounces-183328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57727A9062A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C7A8E27E7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469871FDE01;
	Wed, 16 Apr 2025 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EPtVOq3m"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D92F202F9C
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812839; cv=none; b=Y6DMd85ibYEl0BjyTzSpbGh6+7b5yAH6Y2axOJPJvggDNNUxkoWJZiSYRNIIjHvlEx9MGEsJ3G8SWsKtq5G5rvEqaR8aPVSYcwjL5ltbXWRUVzRqO7ancD57Qe3feXQf6GHyBV1ymCuFhSBGrm5nGLS+136xyyHb9UUbRRkMuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812839; c=relaxed/simple;
	bh=a1xxTOgAm0pgtvM15vDqQUGsarTNe0T8hAGONNBAsHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rwiSlBfIEKKU58RWNpnN/aWr0J1JWzz8NP2zoQn/4MrgYZKyWuEw7vuvRxdWSrttPwnQvwcJmfbQlKLBL8C2baPDfkih3wrPM/zMCDO3LEcFpkqkYVQk7Urr2vyZwrEEWRMLA5rTtkM2XGN1SZ5AH6FF0mqSp8P+Ct9ASPvL+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EPtVOq3m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GAea7i019797;
	Wed, 16 Apr 2025 14:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Kg7g99BYB8SaEZHORP0dZSRe0tlnjV
	tMmCUo1y3MJV4=; b=EPtVOq3mhLU1kvvzny31SiRZHfua7ot2YVzjgJcNJh+g8d
	uAt8nYFtCGgp4Ko9KxV/LCQ8sFdb4FsV6WKsnt0AWKy1eiA6dnvPaK6DaeyivjTI
	/iGzGD/0bZDhWXwzr7RayWIyYBxcuO7Vv7Paiw4DS1542VsuTsG2QtBii4MJ+fPy
	1CJSYzrslCT1KWWMkSYSVuBtYNZzX5PzsWHgfkTcEos5jKveJE25w8MlYBkXX5iI
	1PxuLY3CuLr0Mu1jRqQ+OVbxvfrmqqCrrt+Ed/iS1DXYwDdTsADEMoeyG6j+dsB9
	0BCdCDSVqReyGADTzBQtnyPiN/navqzrDDELXiXg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462b0q13fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 14:13:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GAQmTE030919;
	Wed, 16 Apr 2025 14:13:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnrqpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 14:13:43 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GEDg4F22741658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 14:13:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE8758061;
	Wed, 16 Apr 2025 14:13:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C01EA5805D;
	Wed, 16 Apr 2025 14:13:41 +0000 (GMT)
Received: from d.ibm.com (unknown [9.61.55.205])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Apr 2025 14:13:41 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 1/2] net: ibmveth: make ibmveth use WARN_ON
 instead of BUG_ON
In-Reply-To: <20250416123449.GQ395307@horms.kernel.org> (Simon Horman's
	message of "Wed, 16 Apr 2025 13:34:49 +0100")
References: <20250414194016.437838-1-davemarq@linux.ibm.com>
	<20250414194016.437838-2-davemarq@linux.ibm.com>
	<20250416123449.GQ395307@horms.kernel.org>
Date: Wed, 16 Apr 2025 09:13:40 -0500
Message-ID: <877c3kdwiz.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4HOrPrJVLIXs7Ie9wzPM09t9FYmVhU00
X-Proofpoint-GUID: 4HOrPrJVLIXs7Ie9wzPM09t9FYmVhU00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504160115

Simon Horman <horms@kernel.org> writes:

> On Mon, Apr 14, 2025 at 02:40:15PM -0500, Dave Marquardt wrote:
>> Replaced BUG_ON calls with WARN_ON calls with error handling, with
>> calls to a new ibmveth_reset routine, which resets the device. Removed
>> conflicting and unneeded forward declaration.
>
> To me the most important change here is adding the ibmveth_reset.
> So I would report that in the subject (rather than the WARN_ON) change.
> But perhaps that is just me.

Thanks, I'll consider that.

>> 
>> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
>> ---
>>  drivers/net/ethernet/ibm/ibmveth.c | 116 ++++++++++++++++++++++++-----
>>  drivers/net/ethernet/ibm/ibmveth.h |  65 ++++++++--------
>>  2 files changed, 130 insertions(+), 51 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>
> ...
>
>> @@ -370,20 +372,36 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
>>  	}
>>  }
>>  
>> -/* remove a buffer from a pool */
>> -static void ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>> -					    u64 correlator, bool reuse)
>> +/**
>> + * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
>> + * @adapter: adapter instance
>> + * @correlator: identifies pool and index
>> + * @reuse: whether to reuse buffer
>
> The above is the correct way to document function parameters in a Kernel doc.
>
>> + *
>> + * Return:
>> + * * %0       - success
>> + * * %-EINVAL - correlator maps to pool or index out of range
>> + * * %-EFAULT - pool and index map to null skb
>> + */
>> +static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>> +					   u64 correlator, bool reuse)
>
> ...
>
>> +/**
>> + * ibmveth_rxq_harvest_buffer - Harvest buffer from pool
>> + *
>> + * @adapter - pointer to adapter
>> + * @reuse   - whether to reuse buffer
>
> But this is not correct. IOW, tooling expects
> f.e. @adapter: ...  rather than @adapter - ...
>
> Flagged by W=1 builds and ./scripts/kernel-doc -none

Thanks, I'll start using this in my work.

>> + *
>> + * Context: called from ibmveth_poll
>> + *
>> + * Return:
>> + * * %0    - success
>> + * * other - non-zero return from ibmveth_remove_buffer_from_pool
>> + */
>> +static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>> +				      bool reuse)
>
> ...
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
>> index 8468e2c59d7a..b0a2460ec9f9 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.h
>> +++ b/drivers/net/ethernet/ibm/ibmveth.h
>> @@ -134,38 +134,39 @@ struct ibmveth_rx_q {
>>  };
>>  
>>  struct ibmveth_adapter {
>> -    struct vio_dev *vdev;
>> -    struct net_device *netdev;
>> -    struct napi_struct napi;
>> -    unsigned int mcastFilterSize;
>> -    void * buffer_list_addr;
>> -    void * filter_list_addr;
>> -    void *tx_ltb_ptr[IBMVETH_MAX_QUEUES];
>> -    unsigned int tx_ltb_size;
>> -    dma_addr_t tx_ltb_dma[IBMVETH_MAX_QUEUES];
>> -    dma_addr_t buffer_list_dma;
>> -    dma_addr_t filter_list_dma;
>> -    struct ibmveth_buff_pool rx_buff_pool[IBMVETH_NUM_BUFF_POOLS];
>> -    struct ibmveth_rx_q rx_queue;
>> -    int rx_csum;
>> -    int large_send;
>> -    bool is_active_trunk;
>> -
>> -    u64 fw_ipv6_csum_support;
>> -    u64 fw_ipv4_csum_support;
>> -    u64 fw_large_send_support;
>> -    /* adapter specific stats */
>> -    u64 replenish_task_cycles;
>> -    u64 replenish_no_mem;
>> -    u64 replenish_add_buff_failure;
>> -    u64 replenish_add_buff_success;
>> -    u64 rx_invalid_buffer;
>> -    u64 rx_no_buffer;
>> -    u64 tx_map_failed;
>> -    u64 tx_send_failed;
>> -    u64 tx_large_packets;
>> -    u64 rx_large_packets;
>> -    /* Ethtool settings */
>> +	struct vio_dev *vdev;
>> +	struct net_device *netdev;
>> +	struct napi_struct napi;
>> +	struct work_struct work;
>> +	unsigned int mcastFilterSize;
>> +	void *buffer_list_addr;
>> +	void *filter_list_addr;
>> +	void *tx_ltb_ptr[IBMVETH_MAX_QUEUES];
>> +	unsigned int tx_ltb_size;
>> +	dma_addr_t tx_ltb_dma[IBMVETH_MAX_QUEUES];
>> +	dma_addr_t buffer_list_dma;
>> +	dma_addr_t filter_list_dma;
>> +	struct ibmveth_buff_pool rx_buff_pool[IBMVETH_NUM_BUFF_POOLS];
>> +	struct ibmveth_rx_q rx_queue;
>> +	int rx_csum;
>> +	int large_send;
>> +	bool is_active_trunk;
>> +
>> +	u64 fw_ipv6_csum_support;
>> +	u64 fw_ipv4_csum_support;
>> +	u64 fw_large_send_support;
>> +	/* adapter specific stats */
>> +	u64 replenish_task_cycles;
>> +	u64 replenish_no_mem;
>> +	u64 replenish_add_buff_failure;
>> +	u64 replenish_add_buff_success;
>> +	u64 rx_invalid_buffer;
>> +	u64 rx_no_buffer;
>> +	u64 tx_map_failed;
>> +	u64 tx_send_failed;
>> +	u64 tx_large_packets;
>> +	u64 rx_large_packets;
>> +	/* Ethtool settings */
>>  	u8 duplex;
>>  	u32 speed;
>>  };
>
> If you would like to update the indentation of this structure
> then please do so in a separate patch which precedes
> adding/removing/chainging fields of the structure.
>
> As it, it's very hard to see the non-formatting changes in this hunk.

I agree. Thanks for the suggestion.

-Dave

