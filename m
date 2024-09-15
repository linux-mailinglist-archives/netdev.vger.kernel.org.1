Return-Path: <netdev+bounces-128410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC14697976C
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 17:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A92B214FC
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B11C463E;
	Sun, 15 Sep 2024 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBErMRyW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519FD1E481;
	Sun, 15 Sep 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726413390; cv=none; b=fuFSq7dJBTl3ZDt215aLRJViQLth+Xi5IqqMQ6OhHq6wwVcNiQEq147Gm038KtzJWw7msRCdHttWaM7qEyuq7si6tk7SoXBpiMBs0CY4Q4N3RdbpK2VdLjHHfhep7UEEmx+gxYgc6yQnyKNUmhAEPABwfihG7dtIlNGOszLB8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726413390; c=relaxed/simple;
	bh=FceSn3rmvE0R4UnpyAIvfZLdh7gW3qd+dDkyl0yogQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsJHkbug9Q9wUzWchdnuGp/8hoeI8WyXU+pPsFGZ8QnV+PRMDwtPHdVQ04/21MnnBUEvMgXGhSoZuX07VQFPMmfFiwhneg00foPtq6GR/zGjrGUJcc12dH7dkEk1Dlw55pRpA4h9zT6URgAaHl9HSw6CIcXoYhDRdLiXk3xySJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBErMRyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714F1C4CEC3;
	Sun, 15 Sep 2024 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726413389;
	bh=FceSn3rmvE0R4UnpyAIvfZLdh7gW3qd+dDkyl0yogQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XBErMRyWWPgcb5aW1hB9Ek+6jBq044NDSaISyQq+XLp9QNz3TJH4if2g3HICXAHsG
	 /CM32b1rLQt1QrrFAcDDYT7D3PzLDIRQtB53Z+8vuPE++aWOVIiVHISRmsIVqXtJJE
	 WfDYObxp16W7BHzSsGB98X9xxO7MjUHcoanmKookWaG1+oPH74N0g2WtpC3Znm7hHk
	 tD9QOUvhYvbZX7wyfwJKFom9Q8kSfOuPEL0r3wHj0W+2oBice6qoKAKz3ztQzoSUiE
	 C6tJ3IxntFzwt7HwhZMGX+PGOu9pl/0owIiosYh46V6ETiI65gVGCVfNdf4pXVFTrZ
	 Ei6+L+Cq6rlZQ==
Date: Sun, 15 Sep 2024 17:16:22 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>,
 <kalesh-anakkur.purayil@broadcom.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V10 net-next 06/10] net: hibmcge: Implement
 .ndo_start_xmit function
Message-ID: <20240915171622.3ef8ff0e@kernel.org>
In-Reply-To: <20240912025127.3912972-7-shaojijie@huawei.com>
References: <20240912025127.3912972-1-shaojijie@huawei.com>
	<20240912025127.3912972-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 10:51:23 +0800 Jijie Shao wrote:
> +static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
> +{
> +	struct hbg_ring *ring = container_of(napi, struct hbg_ring, napi);
> +	/* This smp_load_acquire() pairs with smp_store_release() in
> +	 * hbg_start_xmit() called in xmit process.
> +	 */
> +	u32 ntu = smp_load_acquire(&ring->ntu);
> +	struct hbg_priv *priv = ring->priv;
> +	struct hbg_buffer *buffer;
> +	u32 ntc = ring->ntc;
> +	int packet_done = 0;
> +
> +	while (packet_done < budget) {

you should so some cleanup even if budget is 0
in fact you can hardcode the amount of work Tx NAPI does to 128 and
don't look at the budget as a limit. Per NAPI documentation budget
is for Rx

> +		if (unlikely(hbg_queue_is_empty(ntc, ntu, ring)))
> +			break;
> +
> +		/* make sure HW write desc complete */
> +		dma_rmb();
> +
> +		buffer = &ring->queue[ntc];
> +		if (buffer->state != HBG_TX_STATE_COMPLETE)
> +			break;
> +
> +		hbg_buffer_free(buffer);
> +		ntc = hbg_queue_next_prt(ntc, ring);
> +		packet_done++;
> +	}
> +
> +	/* This smp_store_release() pairs with smp_load_acquire() in
> +	 * hbg_start_xmit() called in xmit process.
> +	 */
> +	smp_store_release(&ring->ntc, ntc);
> +	netif_wake_queue(priv->netdev);
> +
> +	if (likely(napi_complete_done(napi, packet_done)))

if packet_done >= budget you should not call napi_complete_done()
as you are not done

> +		hbg_hw_irq_enable(priv, HBG_INT_MSK_TX_B, true);

