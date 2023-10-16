Return-Path: <netdev+bounces-41430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8EC7CAEC8
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA722813D0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159C30CF5;
	Mon, 16 Oct 2023 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4tNavs4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E446E28E24
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 16:17:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4830DEB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697473041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGdTnvlZodlt/7u+klzbTKy6aOlJRtW1cE9KGJh3RxE=;
	b=P4tNavs49d4aRhoyes1ijdKMCBFQmNnOkfFkPCpdNkxo4dBD7XjkTxhHD0dAIf8NSCrUlc
	ltz6aitRYlxhSpVreTOzhT33eHBjb1riBeZIQ5Pz+y2O9H7B38YuEhFDTaqm54WXFFfqqn
	AQE7OeKqeM8iMOKfvgzxAdQXMd060YA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-mcogQoBQPvmIJua3GQAOeg-1; Mon, 16 Oct 2023 12:17:17 -0400
X-MC-Unique: mcogQoBQPvmIJua3GQAOeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9015881D9E9;
	Mon, 16 Oct 2023 16:17:16 +0000 (UTC)
Received: from rhel-developer-toolbox (unknown [10.2.16.166])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 232852022781;
	Mon, 16 Oct 2023 16:17:15 +0000 (UTC)
Date: Mon, 16 Oct 2023 09:17:13 -0700
From: Chris Leech <cleech@redhat.com>
To: Manish Chopra <manishc@marvell.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, aelior@marvell.com,
	palok@marvell.com, njavali@marvell.com, skashyap@marvell.com,
	jmeneghi@redhat.com, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org, Yuval.Mintz@caviumnetworks.com,
	Ram.Amrani@caviumnetworks.com,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net] qed: fix LL2 RX buffer allocation
Message-ID: <ZS1iCRGbxERNbfjV@rhel-developer-toolbox>
References: <20231013131812.873331-1-manishc@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231013131812.873331-1-manishc@marvell.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 06:48:12PM +0530, Manish Chopra wrote:
> Driver allocates the LL2 rx buffers from kmalloc()
> area to construct the skb using slab_build_skb()
> 
> The required size allocation seems to have overlooked
> for accounting both skb_shared_info size and device
> placement padding bytes which results into the below
> panic when doing skb_put() for a standard MTU sized frame.
> 
> skbuff: skb_over_panic: text:ffffffffc0b0225f len:1514 put:1514
> head:ff3dabceaf39c000 data:ff3dabceaf39c042 tail:0x62c end:0x566
> dev:<NULL>
> …
> skb_panic+0x48/0x4a
> skb_put.cold+0x10/0x10
> qed_ll2b_complete_rx_packet+0x14f/0x260 [qed]
> qed_ll2_rxq_handle_completion.constprop.0+0x169/0x200 [qed]
> qed_ll2_rxq_completion+0xba/0x320 [qed]
> qed_int_sp_dpc+0x1a7/0x1e0 [qed]
> 
> This patch fixes this by accouting skb_shared_info and device
> placement padding size bytes when allocating the buffers.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Fixes: 0a7fb11c23c0 ("qed: Add Light L2 support")
> Signed-off-by: Manish Chopra <manishc@marvell.com>
> ---

Ack.  While normally build_skb will use the full slab object size
anyway, this skb_over_panic is seen when the buffer is allocated from a
kfence pool which changes the return value of ksize.

Reviewed-by: Chris Leech <cleech@redhat.com>

>  drivers/net/ethernet/qlogic/qed/qed_ll2.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
> index 717a0b3f89bd..ab5ef254a748 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
> @@ -113,7 +113,10 @@ static void qed_ll2b_complete_tx_packet(void *cxt,
>  static int qed_ll2_alloc_buffer(struct qed_dev *cdev,
>  				u8 **data, dma_addr_t *phys_addr)
>  {
> -	*data = kmalloc(cdev->ll2->rx_size, GFP_ATOMIC);
> +	size_t size = cdev->ll2->rx_size + NET_SKB_PAD +
> +		      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
> +	*data = kmalloc(size, GFP_ATOMIC);
>  	if (!(*data)) {
>  		DP_INFO(cdev, "Failed to allocate LL2 buffer data\n");
>  		return -ENOMEM;
> @@ -2589,7 +2592,7 @@ static int qed_ll2_start(struct qed_dev *cdev, struct qed_ll2_params *params)
>  	INIT_LIST_HEAD(&cdev->ll2->list);
>  	spin_lock_init(&cdev->ll2->lock);
>  
> -	cdev->ll2->rx_size = NET_SKB_PAD + ETH_HLEN +
> +	cdev->ll2->rx_size = PRM_DMA_PAD_BYTES_NUM + ETH_HLEN +
>  			     L1_CACHE_BYTES + params->mtu;
>  
>  	/* Allocate memory for LL2.
> -- 
> 2.27.0
> 


