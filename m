Return-Path: <netdev+bounces-132037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD5F990361
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B871C21930
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3F720FA97;
	Fri,  4 Oct 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IL86bj9e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412729422;
	Fri,  4 Oct 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046681; cv=none; b=nSwBUSXR7XOr+3nb/KUGeD5Wq+d4Atvo2wIj59DO3DgXXva5OSF8kSD8KD32KLk4RvHxkHyspz0DSumweV6xM32YGKGNTJsHVqkGzSU7s5aHngsJqYmoqsdpqZCwFIXC9H6CTLBNt9kDWAdOdupfh+N08C4fpSqMyG77rk+IPaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046681; c=relaxed/simple;
	bh=IQWZQOqTYVCvQ41NIG4ctEVO5J5XfUuQxXugPiSaJew=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tQUD7MBsDvyG/8msdgWKoFTMAPwG7UYbX5i9M9ORjXUgMZgPcdAFYTsXIFXLWjJkHnIP0MVS5WluMgFkG32eBCOHqyxDs1tRgSv3iwOAY9EjzxR8UhhIzLtyptXYs5GgPDe4Qplemd3ZDlWzSf6nuRkoCzsyf+1W2E3bgpgNSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IL86bj9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E31C4CEC6;
	Fri,  4 Oct 2024 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046680;
	bh=IQWZQOqTYVCvQ41NIG4ctEVO5J5XfUuQxXugPiSaJew=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=IL86bj9eYEbSMI6f5JG4QqoQq6YWVR5oK10/4jMYG+hMKkaARADj0j5qWvTb1AxZ7
	 fgbxdyEa/wldb72pPjzIHB68xhDZ9zk5erFpGWldfjNHs/YbAW1blDHuyLzdje4nhj
	 uKMBP78Yr35AvASdtc8Kzb+8D5HlitSj4R4NmwxTQIgENolAlmF611H8f9/YDimETp
	 kDpNXb+TpGbuL+0amCBRDSoSrbSa6N2UZOixZPpkmEpM/P9LxT8dxUbjItkvwVN/MU
	 PmViY0bAySQhYpvxpXphefLwrR6Kn02MCVWfXipmPXxGkQUs6UN8EUSFtOm15j3Pmd
	 f74hKykhHgW2g==
Message-ID: <67c9ede4-9751-4255-b752-27dd60495ff3@kernel.org>
Date: Fri, 4 Oct 2024 15:57:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: ethernet: ti: am65-cpsw: avoid
 devm_alloc_etherdev, fix module removal
From: Roger Quadros <rogerq@kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Nicolas Pitre <npitre@baylibre.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Govindarajan, Sriramakrishnan" <srk@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Md Danish Anwar <danishanwar@ti.com>
References: <20241004041218.2809774-1-nico@fluxnic.net>
 <20241004041218.2809774-3-nico@fluxnic.net>
 <b055cea5-6f03-4c73-aae4-09b5d2290c29@kernel.org>
Content-Language: en-US
In-Reply-To: <b055cea5-6f03-4c73-aae4-09b5d2290c29@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Nicolas,

On 04/10/2024 12:09, Roger Quadros wrote:
> Hi Nicolas,
> 
> On 04/10/2024 07:10, Nicolas Pitre wrote:
>> From: Nicolas Pitre <npitre@baylibre.com>
>>
>> Usage of devm_alloc_etherdev_mqs() conflicts with
>> am65_cpsw_nuss_cleanup_ndev() as the same struct net_device instances
>> get unregistered twice. Switch to alloc_etherdev_mqs() and make sure
> 
> Do we know why the same net device gets unregistered twice?

On some boards there are 2 net devices per CPSW. so those those 2
getting unregistered?

On some investigation I found that the issue has to do with napi_list.
I don't exactly know why but it oopes in free_netdev() at napi_list
iterations
        list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
                netif_napi_del(p);

If we cleanup the napi list at remove then I don't see the oops anymore.

> 
>> am65_cpsw_nuss_cleanup_ndev() unregisters and frees those net_device
>> instances properly.
>>
>> With this, it is finally possible to rmmod the driver without oopsing
>> the kernel.
>>
>> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
>> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>> ---

Can you please try the below patch instead?

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index f6bc8a4dc687..e214547aeba7 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2206,14 +2206,11 @@ static void am65_cpsw_nuss_free_tx_chns(void *data)
 	}
 }
 
-static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
+static void am65_cpsw_nuss_cleanup_tx_napi(struct am65_cpsw_common *common)
 {
 	struct device *dev = common->dev;
 	int i;
 
-	devm_remove_action(dev, am65_cpsw_nuss_free_tx_chns, common);
-
-	common->tx_ch_rate_msk = 0;
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
 
@@ -2222,7 +2219,15 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 
 		netif_napi_del(&tx_chn->napi_tx);
 	}
+}
+
+static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
+{
+	struct device *dev = common->dev;
 
+	devm_remove_action(dev, am65_cpsw_nuss_free_tx_chns, common);
+	common->tx_ch_rate_msk = 0;
+	am65_cpsw_nuss_cleanup_tx_napi(common);
 	am65_cpsw_nuss_free_tx_chns(common);
 }
 
@@ -2355,25 +2360,27 @@ static void am65_cpsw_nuss_free_rx_chns(void *data)
 		k3_udma_glue_release_rx_chn(rx_chn->rx_chn);
 }
 
-static void am65_cpsw_nuss_remove_rx_chns(struct am65_cpsw_common *common)
+static void am65_cpsw_nuss_cleanup_rx_napi(struct am65_cpsw_common *common)
 {
 	struct device *dev = common->dev;
-	struct am65_cpsw_rx_chn *rx_chn;
 	struct am65_cpsw_rx_flow *flows;
 	int i;
 
-	rx_chn = &common->rx_chns;
-	flows = rx_chn->flows;
-	devm_remove_action(dev, am65_cpsw_nuss_free_rx_chns, common);
-
+	flows = common->rx_chns.flows;
 	for (i = 0; i < common->rx_ch_num_flows; i++) {
 		if (!(flows[i].irq < 0))
 			devm_free_irq(dev, flows[i].irq, &flows[i]);
 		netif_napi_del(&flows[i].napi_rx);
 	}
+}
 
-	am65_cpsw_nuss_free_rx_chns(common);
+static void am65_cpsw_nuss_remove_rx_chns(struct am65_cpsw_common *common)
+{
+	struct device *dev = common->dev;
 
+	devm_remove_action(dev, am65_cpsw_nuss_free_rx_chns, common);
+	am65_cpsw_nuss_cleanup_rx_napi(common);
+	am65_cpsw_nuss_free_rx_chns(common);
 	common->rx_flow_id_base = -1;
 }
 
@@ -2871,6 +2878,9 @@ static void am65_cpsw_nuss_cleanup_ndev(struct am65_cpsw_common *common)
 		if (port->ndev && port->ndev->reg_state == NETREG_REGISTERED)
 			unregister_netdev(port->ndev);
 	}
+
+	am65_cpsw_nuss_cleanup_rx_napi(common);
+	am65_cpsw_nuss_cleanup_tx_napi(common);
 }
 
 static void am65_cpsw_port_offload_fwd_mark_update(struct am65_cpsw_common *common)

