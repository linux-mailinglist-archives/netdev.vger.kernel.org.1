Return-Path: <netdev+bounces-83996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5CB895347
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7011F25CBD
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E179B87;
	Tue,  2 Apr 2024 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ER3+BCEx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495AFBE5E
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061438; cv=none; b=V13B4w8uQ+fCxbbjTRei08L1kkuF27675K2yYmGbk9Qu6r1syjwGxhdaJ4q/yyCmQxtNYcLr3iFrBOzpp92XWGeA4jIZdGODJa088k2wtHBNuDeLf33E65SJtXu3L26Z84nIZDR6DhMJZznnMhrhhOqNAJQzF9kY1pxrLNZK4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061438; c=relaxed/simple;
	bh=Qu/thyLPHHn0dIsAazNLNFWOHhrh+WcA58vfrfbcEb0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlOGpW9frs4YXFKBhOBRVGUg1Uh5rdoogCyAMeRWrpKKFmgqi0nr1qxKfT3baj+h43YfK/Dub8QxO7zkzRhCqRkOrc2emMDOFrO/U2D9aLzPAHXXk3iwWqGpdHJhL4EoSKcNiMq6zB016JlBphQf6feObvp7Fgsytz/w3+UQG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ER3+BCEx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432C7EtV015490;
	Tue, 2 Apr 2024 05:37:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=nABfr2eZJWXLo6GDKTH3Bu
	LXVF4ty6pxtnkXaJYV12U=; b=ER3+BCExzywymsuWYLDX5oh5/ZJotsbFL8MJDW
	1BEn3XQ1DcZZ4EMaBieaikXLq0jF+8l/mepOSaHwKhEymfBbVel+z0+TeuqjRxXv
	lV6ttDLMj8YdJWEOxBNENbUHGuE8orA83pGvcLbeg7q+wBGGjDioi9hRM9+WRoSM
	Lytr6F/vZW1sjQIhiei0yAqUQal59b1HJQxUSVNQzTlRyRaWFDgJfA1TVywyO6QN
	7yjZaUxJPvThVmSukmugsPTj5iVALwH6zKCeY7jmsqvlY7DSccURpIp4aDap6E4H
	bZz6oWrsqMugNxJekxuWVFnnleHjfjHbeC8Bvx6xJBArsXgg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x8hr703gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 05:37:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 05:37:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 2 Apr 2024 05:37:00 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7E4D83F704E;
	Tue,  2 Apr 2024 05:36:57 -0700 (PDT)
Date: Tue, 2 Apr 2024 18:06:56 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Heng Qi <hengqi@linux.alibaba.com>
CC: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jason Wang
	<jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 2/3] virtio-net: refactor dim
 initialization/destruction
Message-ID: <20240402123656.GA1648445@maili.marvell.com>
References: <1712059988-7705-1-git-send-email-hengqi@linux.alibaba.com>
 <1712059988-7705-3-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1712059988-7705-3-git-send-email-hengqi@linux.alibaba.com>
X-Proofpoint-GUID: ryZxHkdfYVeGC0BLJT07fjvDFqP3-or9
X-Proofpoint-ORIG-GUID: ryZxHkdfYVeGC0BLJT07fjvDFqP3-or9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_06,2024-04-01_01,2023-05-22_02

On 2024-04-02 at 17:43:07, Heng Qi (hengqi@linux.alibaba.com) wrote:
> Extract the initialization and destruction actions
> of dim for use in the next patch.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e709d44..5c56fdc 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2278,6 +2278,13 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  	return err;
>  }
>
> +static void virtnet_dim_clean(struct virtnet_info *vi,
> +			      int start_qnum, int end_qnum)
> +{
> +	for (; start_qnum <= end_qnum; start_qnum++)
> +		cancel_work_sync(&vi->rq[start_qnum].dim.work);
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -2301,11 +2308,9 @@ static int virtnet_open(struct net_device *dev)
>  err_enable_qp:
>  	disable_delayed_refill(vi);
>  	cancel_delayed_work_sync(&vi->refill);
> -
> -	for (i--; i >= 0; i--) {
> +	virtnet_dim_clean(vi, 0, i);
> +	for (i--; i >= 0; i--)
>  		virtnet_disable_queue_pair(vi, i);
Now function argument is  "i", not "i - 1".
Is it intentional ? commit message did not indicate any fixes.

> -		cancel_work_sync(&vi->rq[i].dim.work);
> -	}
>
>  	return err;
>  }
> @@ -2470,7 +2475,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
>
>  	if (running) {
>  		napi_disable(&rq->napi);
> -		cancel_work_sync(&rq->dim.work);
> +		virtnet_dim_clean(vi, qindex, qindex);
>  	}
>
>  	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
> @@ -2720,10 +2725,9 @@ static int virtnet_close(struct net_device *dev)
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
>
> -	for (i = 0; i < vi->max_queue_pairs; i++) {
> +	virtnet_dim_clean(vi, 0, vi->max_queue_pairs - 1);
> +	for (i = 0; i < vi->max_queue_pairs; i++)
>  		virtnet_disable_queue_pair(vi, i);
> -		cancel_work_sync(&vi->rq[i].dim.work);
> -	}
>
>  	return 0;
>  }
> @@ -4422,6 +4426,19 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  	return ret;
>  }
>
> +static void virtnet_dim_init(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> +		return;
> +
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
> +		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
> +	}
> +}
> +
>  static int virtnet_alloc_queues(struct virtnet_info *vi)
>  {
>  	int i;
> @@ -4441,6 +4458,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>  		goto err_rq;
>
>  	INIT_DELAYED_WORK(&vi->refill, refill_work);
> +	virtnet_dim_init(vi);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		vi->rq[i].pages = NULL;
>  		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
> @@ -4449,9 +4467,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>  					 virtnet_poll_tx,
>  					 napi_tx ? napi_weight : 0);
>
> -		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
> -		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
> -
>  		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
>  		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
>  		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
> --
> 1.8.3.1
>

