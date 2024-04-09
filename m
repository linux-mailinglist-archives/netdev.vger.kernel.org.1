Return-Path: <netdev+bounces-86095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE30C89D87C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C5328848D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124811272CA;
	Tue,  9 Apr 2024 11:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31DC80629
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663259; cv=none; b=PExEYLDOFNqDbA8bItEAOA/V2Dcsjv7TpzJsOPzWWBZqp/uGlqieIi9B8ArXTLlR/QyJ30AZfa3JywBXFzmX5cRzXdFclUiDRPfDsPidHnO/FAiHsv/VwO/CsemAxKzuxyUwyOslStusQwoNVtZ/NfLDAbZ1o6kBXXgXPDd8OrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663259; c=relaxed/simple;
	bh=nhIPRPdz5+MafAyjDvmSPmsnqy2nxzObKAKF/VArt4I=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pBBHk6+ecOruJazh0BadLjx0on55aMOiOv5WwrJ8knU5uMHpjBXWkTUzp5bUBMlYqjWn6pYIGs5LOrEc1aQnFkIgBvDBdGWATgogBMdZpUSLiVunCb2wq/yluDq4xGL0H/k3O03LiHW38MWp1gozIzmZoGNCSXkc/NHR0FBzFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VDPK62Yprz1ymf5;
	Tue,  9 Apr 2024 19:45:14 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 04DDB1402C7;
	Tue,  9 Apr 2024 19:47:29 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Apr
 2024 19:47:28 +0800
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: Alexander Duyck <alexanderduyck@fb.com>, <kuba@kernel.org>,
	<davem@davemloft.net>, <pabeni@redhat.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
Date: Tue, 9 Apr 2024 19:47:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/4 4:09, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>

...

> +
> +static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
> +			   struct fbnic_q_triad *qt, int budget)
> +{
> +	struct fbnic_ring *rcq = &qt->cmpl;
> +	struct fbnic_pkt_buff *pkt;
> +	s32 head0 = -1, head1 = -1;
> +	__le64 *raw_rcd, done;
> +	u32 head = rcq->head;
> +	u64 packets = 0;
> +
> +	done = (head & (rcq->size_mask + 1)) ? cpu_to_le64(FBNIC_RCD_DONE) : 0;
> +	raw_rcd = &rcq->desc[head & rcq->size_mask];
> +	pkt = rcq->pkt;
> +
> +	/* Walk the completion queue collecting the heads reported by NIC */
> +	while (likely(packets < budget)) {
> +		struct sk_buff *skb = ERR_PTR(-EINVAL);
> +		u64 rcd;
> +
> +		if ((*raw_rcd & cpu_to_le64(FBNIC_RCD_DONE)) == done)
> +			break;
> +
> +		dma_rmb();
> +
> +		rcd = le64_to_cpu(*raw_rcd);
> +
> +		switch (FIELD_GET(FBNIC_RCD_TYPE_MASK, rcd)) {
> +		case FBNIC_RCD_TYPE_HDR_AL:
> +			head0 = FIELD_GET(FBNIC_RCD_AL_BUFF_ID_MASK, rcd);
> +			fbnic_pkt_prepare(nv, rcd, pkt, qt);
> +
> +			break;
> +		case FBNIC_RCD_TYPE_PAY_AL:
> +			head1 = FIELD_GET(FBNIC_RCD_AL_BUFF_ID_MASK, rcd);
> +			fbnic_add_rx_frag(nv, rcd, pkt, qt);
> +
> +			break;
> +		case FBNIC_RCD_TYPE_OPT_META:
> +			/* Only type 0 is currently supported */
> +			if (FIELD_GET(FBNIC_RCD_OPT_META_TYPE_MASK, rcd))
> +				break;
> +
> +			/* We currently ignore the action table index */
> +			break;
> +		case FBNIC_RCD_TYPE_META:
> +			if (likely(!fbnic_rcd_metadata_err(rcd)))
> +				skb = fbnic_build_skb(nv, pkt);
> +
> +			/* populate skb and invalidate XDP */
> +			if (!IS_ERR_OR_NULL(skb)) {
> +				fbnic_populate_skb_fields(nv, rcd, skb, qt);
> +
> +				packets++;
> +
> +				napi_gro_receive(&nv->napi, skb);
> +			}
> +
> +			pkt->buff.data_hard_start = NULL;
> +
> +			break;
> +		}
> +
> +		raw_rcd++;
> +		head++;
> +		if (!(head & rcq->size_mask)) {
> +			done ^= cpu_to_le64(FBNIC_RCD_DONE);
> +			raw_rcd = &rcq->desc[0];
> +		}
> +	}
> +
> +	/* Unmap and free processed buffers */
> +	if (head0 >= 0)
> +		fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
> +	fbnic_fill_bdq(nv, &qt->sub0);
> +
> +	if (head1 >= 0)
> +		fbnic_clean_bdq(nv, budget, &qt->sub1, head1);
> +	fbnic_fill_bdq(nv, &qt->sub1);

I am not sure how complicated the rx handling will be for the advanced
feature. For the current code, for each entry/desc in both qt->sub0 and
qt->sub1 at least need one page, and the page seems to be only used once
no matter however small the page is used?

I am assuming you want to do 'tightly optimized' operation for this by
calling page_pool_fragment_page(), but manipulating page->pp_ref_count
directly does not seems to add any value for the current code, but seem
to waste a lot of memory by not using the frag API, especially PAGE_SIZE
> 4K?

> +
> +	/* Record the current head/tail of the queue */
> +	if (rcq->head != head) {
> +		rcq->head = head;
> +		writel(head & rcq->size_mask, rcq->doorbell);
> +	}
> +
> +	return packets;
> +}
>  
> 

