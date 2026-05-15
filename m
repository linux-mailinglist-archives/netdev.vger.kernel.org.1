Return-Path: <netdev+bounces-288119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNjlLNxlBmrOjQIAu9opvQ
	(envelope-from <netdev+bounces-288119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:16:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A29AC547EE1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A99D73005141
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6017C78F26;
	Fri, 15 May 2026 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1xSwfVP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD841643B;
	Fri, 15 May 2026 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804183; cv=none; b=XRIu2zQL991+J3yShhayd53gMN4mehZabdw1Ahbquo5Ddtqvf36AkyoWzGODSGuUC4HItuqRBXT3/GawPcxOmfT1jHPU4rDSIwLhu54ikXaAI0ytY9qNV9eUHz5ybkzZ4qTEutnl+Awb9uUSbBrxzrRcw7SvDNxgLgMwT90VgsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804183; c=relaxed/simple;
	bh=wmbFTGinFmdf9wPe3EcJaPHMp1QQqd+kjDQsmtID9I4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UW5myYEHJDf6XXX3HtVyrQ2+8C0E1Swcs0D6UFvTY3u6p8m1Mi71ONMW1HBzuyQBMWJeYu7tIRxA4D5WSa4ZC76e+oL8ALlazxhny/Bgs0i1Sinyk3cTqZ8OFwS46Lqg9ZJYyeNPrxAJPSGlJ+hr/rBZ65+0cj64CQGhmEODCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1xSwfVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E327C2BCB3;
	Fri, 15 May 2026 00:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804183;
	bh=wmbFTGinFmdf9wPe3EcJaPHMp1QQqd+kjDQsmtID9I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a1xSwfVPZcpAeUOyORsXS4pob32xOyYjPujsjR0tMgsYxbzKXLE/iqGpDbVNy89PL
	 0C6acVHe9x4fcwg5IC/20a1Oc1ru/uPvCO33H4FGmDbdi6yA4Olo85z2n43Jx64sg6
	 B9NLA6JEOBlck6mlgrhAKHSmWUoDM8LBUeJViwTngXG7WBoNIgxa7s88uJBK9jEYhg
	 OiS6meTSh9OLWKxqOCvIxqgIDWeSAheUhpfSQNdfbUsNvT3thVDwmMZvjlRwYrTsuu
	 5ILsMkbgKWh0PKpMWObKJH6snviodhF4Y8V+FYxussps5mNiaKhkTmYCr9Ia8WsaQd
	 LQaLIdCl2JHQg==
Date: Thu, 14 May 2026 17:16:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
 <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: hibmcge: fix incorrect packets in the RX path
 issue
Message-ID: <20260514171621.02b2ffb1@kernel.org>
In-Reply-To: <20260512123456.3786635-1-shaojijie@huawei.com>
References: <20260512123456.3786635-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A29AC547EE1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288119-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Action: no action

On Tue, 12 May 2026 20:34:56 +0800 Jijie Shao wrote:
> Therefore, this patch disables the Relaxed Ordering to ensure the
> strict order of packets and descriptors.
> 
> Additionally, during the process of analyzing the issue,
> it was discovered that the position of dma_rmb() was incorrect.
> It should first execute dma_sync_single_for_cpu(), and then dma_rmb().
> This patch has also made the corresponding modifications.

Should be a separate patch.

> Fixes: f72e25594061 ("net: hibmcge: Implement rx_poll function to receive packets")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 4 +++-
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 6 +++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> index 068da2fd1fea..5b91b596349c 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> @@ -420,6 +420,8 @@ static int hbg_pci_init(struct pci_dev *pdev)
>  		return -ENOMEM;
>  
>  	pci_set_master(pdev);
> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
> +				   PCI_EXP_DEVCTL_RELAX_EN);
>  	return 0;
>  }
>  
> @@ -525,4 +527,4 @@ module_exit(hbg_module_exit);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
>  MODULE_DESCRIPTION("hibmcge driver");
> -MODULE_VERSION("1.0");
> +MODULE_VERSION("2.0");

Please don't change MODULE_VERSIONs they are meaningless for in-tree
modules.
-- 
pw-bot: cr

