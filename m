Return-Path: <netdev+bounces-135444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C911599DF65
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028F7B219E8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36621189914;
	Tue, 15 Oct 2024 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thoeWDpU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC5B1741DC;
	Tue, 15 Oct 2024 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978031; cv=none; b=mzb9XlzLuLvFc3uLefkG7guLSfJ4F7zlDx1drcilXOxnFzielOosT4m+wuhql+//x00vsTFOhjo3ZriNfmcxhZc+0E0MO+zRIj9jxy2kUkwSxEKPSLne9AoXBZsibyEEKMxhh9F866zXbtGtZapeVLe+hPWauU0eDDEGntTLc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978031; c=relaxed/simple;
	bh=i0IgbTszex3b8pWJnGwsFMGwrh4Vucav33FzaKdJLfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjuyiYS6pGonirh1l7Rr1gVJ6oWV7wjycxbhWHv78Y2gcHw+QrqVEHAhEiJUWadTouwBuHH/75VRDqFIbrnvzbyHEJaI83ViTQm8YHF/wg1MJoo7hhgctDI/V6a2jRXQ51qcok1CPsLaactxvvkEU1Cg3oESqIGm88Nd/zttQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thoeWDpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1E3C4CEC7;
	Tue, 15 Oct 2024 07:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728978030;
	bh=i0IgbTszex3b8pWJnGwsFMGwrh4Vucav33FzaKdJLfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thoeWDpUGybvhwHFztq9gaIBl1dLULO+lpocWpH+WDszPO5Nj976qvKDg/o4bWtEe
	 qnrDkIUstKX+aMFSj9+/m0ZdQNgzkiaA6qQhRNjsDsOtxJdzm4z9vhwFresp33eUoa
	 GtnKJtUL10fXJWjuZ7L+C0M49qFNDLwrovrF8Q6YGYFcdXBt6veUMRTRYCzSXzs0fh
	 b33QTPkTShlHHAL13lODhLDsA4RIRXvwtilfGTRRYADeQGKbapCWLUG/Usp8G6ukU8
	 rBjQgnQXrSNUwdBxdFIJWmJK/n8PxSEJLAQjAKnT8qA7JtQpEy/9z1s5zZ/2uJYdun
	 EViPM3JTEXY2A==
Date: Tue, 15 Oct 2024 08:40:25 +0100
From: Simon Horman <horms@kernel.org>
To: Wang Hai <wanghai38@huawei.com>
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	VenkatKumar.Duvvuru@emulex.com, zhangxiaoxu5@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] be2net: fix potential memory leak in be_xmit()
Message-ID: <20241015074025.GB569285@kernel.org>
References: <20241014144758.42010-1-wanghai38@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014144758.42010-1-wanghai38@huawei.com>

On Mon, Oct 14, 2024 at 10:47:58PM +0800, Wang Hai wrote:
> The be_xmit() returns NETDEV_TX_OK without freeing skb
> in case of be_xmit_enqueue() fails, add dev_kfree_skb_any() to fix it.
> 
> Fixes: 760c295e0e8d ("be2net: Support for OS2BMC.")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Thanks,

I agree that this is correct an din keeping with other
drop handling within this function.

I do, however, wonder if this logic could be expressed both
more clearly and idiomatically like this (completely untested!):

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index a8596ebcdfd6..d171acb6544f 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1381,10 +1381,8 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 	be_get_wrb_params_from_skb(adapter, skb, &wrb_params);
 
 	wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
-	if (unlikely(!wrb_cnt)) {
-		dev_kfree_skb_any(skb);
-		goto drop;
-	}
+	if (unlikely(!wrb_cnt))
+		goto drop_skb;
 
 	/* if os2bmc is enabled and if the pkt is destined to bmc,
 	 * enqueue the pkt a 2nd time with mgmt bit set.
@@ -1393,7 +1391,7 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		BE_WRB_F_SET(wrb_params.features, OS2BMC, 1);
 		wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
 		if (unlikely(!wrb_cnt))
-			goto drop;
+			goto drop_skb;
 		else
 			skb_get(skb);
 	}
@@ -1407,6 +1405,9 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		be_xmit_flush(adapter, txo);
 
 	return NETDEV_TX_OK;
+
+drop_skb:
+	dev_kfree_skb_any(skb);
 drop:
 	tx_stats(txo)->tx_drv_drops++;
 	/* Flush the already enqueued tx requests */

