Return-Path: <netdev+bounces-122019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFE295F933
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CAB283A3C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA9192B91;
	Mon, 26 Aug 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ovq8kkpl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81333768FD;
	Mon, 26 Aug 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724698224; cv=none; b=CJKCtWwJYGQNb48YH/P9wdh8ELipvxIsuvAJDCzVBt6f7PemvXd8jcCYzqgzHRxs5Xw6PQ1coNqkMswFQY6swZD1eP+EWHTU3JCDltyW3AzZ3huPlJKmOgipwWoHEP4PzM2OA3FIhh1BWY8A3jwpGuiEDSNa3s1uPyHlcV0KDps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724698224; c=relaxed/simple;
	bh=yEEIA6c2sasZvcGNZ60DR0yvjicY+IHif1trSzVRZcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbtc0H8Q7WjZkviua/Pf2CfTLig6oQyB3OPg08cPdf/YdhG8oNDK74ktjrPPymPX5CkxC/YzravCHq/Nwn0m6p0sPpuOXoXMGz16WJwHBBQEI0e92Cnp/enqObGbb1+d+weQ7Yg7vi5z2PJvdrWreGWpfAKgi/dcq6t23J4+9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ovq8kkpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638A7C8B7B7;
	Mon, 26 Aug 2024 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724698224;
	bh=yEEIA6c2sasZvcGNZ60DR0yvjicY+IHif1trSzVRZcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ovq8kkplNzHAodA1v5wQNlYkyUk1OWgSYGtXeZY1oQ9tcaPzVEloWNhJeRKms4N2O
	 we4yzFVqoqBs85RH9wPmHczxMvEZP0VSzdRWp6MYEEgUXAB210pRcgS4SCW/Onw8CD
	 4p7Cp+LIGuFXABx5Tu3NqzRG2k4ReP6gkF/7rh/HnInFMHX/x6HVz+1yICIy8vLnQQ
	 nzqfoqqtCC0LBYqeQXrkH5V8k0zh6T8Y97jOp+DEWKBqc5KoE2Ck5zwnIMc9voxkxp
	 Mq4UoP312ILm87PDBOGHL89A1zPLJ3gLwhliBVoRExa0jSJqfNbJ8W8wRNugzK3LOr
	 AhwoR2JAk8GAw==
Date: Mon, 26 Aug 2024 11:50:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 net-next 06/11] net: hibmcge: Implement
 .ndo_start_xmit function
Message-ID: <20240826115022.75974fb6@kernel.org>
In-Reply-To: <20240826081258.1881385-7-shaojijie@huawei.com>
References: <20240826081258.1881385-1-shaojijie@huawei.com>
	<20240826081258.1881385-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 16:12:53 +0800 Jijie Shao wrote:
> +static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
> +{
> +	struct hbg_ring *ring = container_of(napi, struct hbg_ring, napi);
> +	struct hbg_priv *priv = ring->priv;
> +	/* This smp_load_acquire() pairs with smp_store_release() in
> +	 * hbg_start_xmit() called in xmit process.
> +	 */
> +	u32 ntu = smp_load_acquire(&ring->ntu);
> +	struct hbg_buffer *buffer;
> +	u32 ntc = ring->ntc;
> +	int packet_done = 0;
> +
> +	while (packet_done < budget) {
> +		if (unlikely(hbg_queue_is_empty(ntc, ntu)))
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
> +	};

unnecessary semicolon
-- 
pw-bot: cr

