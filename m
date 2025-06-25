Return-Path: <netdev+bounces-201322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB45AE9020
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C7287AF69E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0930214204;
	Wed, 25 Jun 2025 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ITFiQpbE"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44E213E90;
	Wed, 25 Jun 2025 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886506; cv=none; b=e9x3gqaROI5eOKx5zdqNSF3FBkKYNfFySE4DxtfvA6kaGeie8D0CxtTs9lbBf0P6XcIHKqpllymhAylbip05NPhmaq2Z9rgcNOteLEOlzlrclDwJSQd9VhXEuM4p9kbjEtBjtubqQ7fvdmpZQBX7GZhIH/ZJHyBDMrI5ZLJB2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886506; c=relaxed/simple;
	bh=VUG4glMa2yPUT3E8r2AzoGC444rn3g4MusASwHFC7BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgY80RFMUb97q1J0HTxa7+4Oh/C0AXKTsa6ts9s0ufC1T9xPYwunxMXVqANwzgORLqMYlDP3mgE5jnTQJ4WmjsvULddK76cuhtsmjEUjL26mP/g8KttFyPFPxQePzbMNssZC/eueKxXtLkbzo7cTN7nyCu4trDw9kAJpE0RIAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ITFiQpbE; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff0691c5-fdea-425d-b5e3-ad8817bb9573@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750886499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnZUfSlZAMKQx8858YYoAdHr5E3EB2D9WreNUySXtFs=;
	b=ITFiQpbEn6YoVQC0HQ3ijeouzA2ytHW4V/LUIY4fgvtID4vkMRQG02f3xFljhuZN1S7sYT
	fuT3xCAG0RVH5vtrXxbkhM7niofwkcu3A54dO4313b9b4mI+Mmchy6Ft9DYf1Du2lM6W7n
	+xfHYFzFahozvzuwmTY/SBCI4RecDQQ=
Date: Wed, 25 Jun 2025 22:21:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v05 5/8] hinic3: TX & RX Queue coalesce
 interfaces
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1750821322.git.zhuyikai1@h-partners.com>
 <1a764f22845e52452d15e561b4e5803474999cfc.1750821322.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <1a764f22845e52452d15e561b4e5803474999cfc.1750821322.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/06/2025 04:41, Fan Gong wrote:
> Add TX RX queue coalesce interfaces initialization.
> It configures the parameters of tx & tx msix coalesce.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   .../net/ethernet/huawei/hinic3/hinic3_main.c  | 65 +++++++++++++++++--
>   .../ethernet/huawei/hinic3/hinic3_nic_dev.h   | 10 +++
>   2 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index 497f2a36f35d..8d1c7a388762 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> @@ -17,12 +17,57 @@
>   
>   #define HINIC3_NIC_DRV_DESC  "Intelligent Network Interface Card Driver"
>   
> -#define HINIC3_RX_BUF_LEN            2048
> -#define HINIC3_LRO_REPLENISH_THLD    256
> -#define HINIC3_NIC_DEV_WQ_NAME       "hinic3_nic_dev_wq"
> +#define HINIC3_RX_BUF_LEN          2048
> +#define HINIC3_LRO_REPLENISH_THLD  256
> +#define HINIC3_NIC_DEV_WQ_NAME     "hinic3_nic_dev_wq"
>   
> -#define HINIC3_SQ_DEPTH              1024
> -#define HINIC3_RQ_DEPTH              1024
> +#define HINIC3_SQ_DEPTH            1024
> +#define HINIC3_RQ_DEPTH            1024
> +
> +#define HINIC3_DEFAULT_TXRX_MSIX_PENDING_LIMIT      2
> +#define HINIC3_DEFAULT_TXRX_MSIX_COALESC_TIMER_CFG  25
> +#define HINIC3_DEFAULT_TXRX_MSIX_RESEND_TIMER_CFG   7
> +
> +static void init_intr_coal_param(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_intr_coal_info *info;
> +	u16 i;
> +
> +	for (i = 0; i < nic_dev->max_qps; i++) {
> +		info = &nic_dev->intr_coalesce[i];
> +		info->pending_limit = HINIC3_DEFAULT_TXRX_MSIX_PENDING_LIMIT;
> +		info->coalesce_timer_cfg = HINIC3_DEFAULT_TXRX_MSIX_COALESC_TIMER_CFG;
> +		info->resend_timer_cfg = HINIC3_DEFAULT_TXRX_MSIX_RESEND_TIMER_CFG;
> +	}
> +}
> +
> +static int hinic3_init_intr_coalesce(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	u64 size;
> +
> +	size = sizeof(*nic_dev->intr_coalesce) * nic_dev->max_qps;
> +	if (!size) {
> +		dev_err(hwdev->dev, "Cannot allocate zero size intr coalesce\n");
> +		return -EINVAL;
> +	}

I don't see how that can happen. max_qps is checked to be positive value
in nic_dev_init and is never changed to less than 1. It's way too
defensive coding here.

> +	nic_dev->intr_coalesce = kzalloc(size, GFP_KERNEL);

kcalloc(nic_dev->max_qps, sizeof(*nic_dev->intr_coalesce), GFP_KERNEL)
will make it, no need for local variable

> +	if (!nic_dev->intr_coalesce)
> +		return -ENOMEM;
> +
> +	init_intr_coal_param(netdev);
> +
> +	return 0;
> +}
> +
> +static void hinic3_free_intr_coalesce(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +
> +	kfree(nic_dev->intr_coalesce);
> +}
>   
>   static int hinic3_alloc_txrxqs(struct net_device *netdev)
>   {
> @@ -42,8 +87,17 @@ static int hinic3_alloc_txrxqs(struct net_device *netdev)
>   		goto err_free_txqs;
>   	}
>   
> +	err = hinic3_init_intr_coalesce(netdev);
> +	if (err) {
> +		dev_err(hwdev->dev, "Failed to init_intr_coalesce\n");
> +		goto err_free_rxqs;
> +	}
> +
>   	return 0;
>   
> +err_free_rxqs:
> +	hinic3_free_rxqs(netdev);
> +
>   err_free_txqs:
>   	hinic3_free_txqs(netdev);
>   
> @@ -52,6 +106,7 @@ static int hinic3_alloc_txrxqs(struct net_device *netdev)
>   
>   static void hinic3_free_txrxqs(struct net_device *netdev)
>   {
> +	hinic3_free_intr_coalesce(netdev);
>   	hinic3_free_rxqs(netdev);
>   	hinic3_free_txqs(netdev);
>   }
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> index c994fc9b6ee0..9577cc673257 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> @@ -51,6 +51,12 @@ struct hinic3_dyna_txrxq_params {
>   	struct hinic3_irq_cfg      *irq_cfg;
>   };
>   
> +struct hinic3_intr_coal_info {
> +	u8 pending_limit;
> +	u8 coalesce_timer_cfg;
> +	u8 resend_timer_cfg;
> +};
> +
>   struct hinic3_nic_dev {
>   	struct pci_dev                  *pdev;
>   	struct net_device               *netdev;
> @@ -70,10 +76,14 @@ struct hinic3_nic_dev {
>   	u16                             num_qp_irq;
>   	struct msix_entry               *qps_msix_entries;
>   
> +	struct hinic3_intr_coal_info    *intr_coalesce;
> +
>   	bool                            link_status_up;
>   };
>   
>   void hinic3_set_netdev_ops(struct net_device *netdev);
> +int hinic3_qps_irq_init(struct net_device *netdev);
> +void hinic3_qps_irq_uninit(struct net_device *netdev);
>   
>   /* Temporary prototypes. Functions become static in later submission. */
>   void qp_add_napi(struct hinic3_irq_cfg *irq_cfg);


