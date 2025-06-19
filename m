Return-Path: <netdev+bounces-199460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB37FAE0628
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC22D3B85D2
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178DA23B607;
	Thu, 19 Jun 2025 12:44:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E02459DA
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337077; cv=none; b=dBbWNdchmsCQWawe6+uPpp6Q3JDmtl9tO/ZyA6odzN9mzqEAxMFVBZ6BgSISIRr4Q3NPsB+2UiKr/lWb1ABl3eXCgeI3jdowI5qdbK/0LNjhlU3jzyNtGRl3o/k2h0H4483rpyvFSAxucoFHf8THG6fYdKdp59Epe1bjqFjfv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337077; c=relaxed/simple;
	bh=IKXF0/yurjqDNBiH0w68hFyg1wp0lDCtHbmscaE5SZ4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I6De+CQYaJKQ03oAZAEdKf9OHrb234YRO5oWzWkCmBnRixYnlS4ou01UydegOdtGiVytOtZeEZBZ0uaSX9/CeErg94YbBDMpBK1XJz6TN1eSWtY4UjnyPMjWRjSKt5h+KrRG9bM1siIOwhOni5XY2hEwgsabWGMOWi6WifmgH40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bNKxj3sKfzvZDD;
	Thu, 19 Jun 2025 20:42:17 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 90B0D14011F;
	Thu, 19 Jun 2025 20:44:30 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Jun 2025 20:44:29 +0800
Message-ID: <2ecff914-0e84-4d72-b6a1-3571908c9e2c@huawei.com>
Date: Thu, 19 Jun 2025 20:44:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<ajit.khaparde@broadcom.com>, <sriharsha.basavapatna@broadcom.com>,
	<somnath.kotur@broadcom.com>, <shenjian15@huawei.com>,
	<salil.mehta@huawei.com>, <cai.huoqing@linux.dev>, <saeedm@nvidia.com>,
	<tariqt@nvidia.com>, <louis.peens@corigine.com>, <mbloch@nvidia.com>,
	<manishc@marvell.com>, <ecree.xilinx@gmail.com>, <joe@dama.to>
Subject: Re: [PATCH net-next 09/10] eth: hns3: migrate to new RXFH callbacks
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
References: <20250618203823.1336156-1-kuba@kernel.org>
 <20250618203823.1336156-10-kuba@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250618203823.1336156-10-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/19 4:38, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").

Thanks,
Reviewed-by: Jijie Shao<shaojijie@huawei.com>

>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> This driver wins the award for most convoluted abstraction layers :/

HaHa, it is indeed a bit convoluted
But there's nothing wrong with the design.

> ---
>   drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  4 +--
>   .../hns3/hns3_common/hclge_comm_rss.h         |  4 +--
>   .../hns3/hns3_common/hclge_comm_rss.c         |  6 ++--
>   .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 ++++++++++++++-----
>   .../hisilicon/hns3/hns3pf/hclge_main.c        |  4 +--
>   .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  4 +--
>   6 files changed, 36 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> index 4e44f28288f9..8dc7d6fae224 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> @@ -690,9 +690,9 @@ struct hnae3_ae_ops {
>   	int (*set_rss)(struct hnae3_handle *handle, const u32 *indir,
>   		       const u8 *key, const u8 hfunc);
>   	int (*set_rss_tuple)(struct hnae3_handle *handle,
> -			     struct ethtool_rxnfc *cmd);
> +			     const struct ethtool_rxfh_fields *cmd);
>   	int (*get_rss_tuple)(struct hnae3_handle *handle,
> -			     struct ethtool_rxnfc *cmd);
> +			     struct ethtool_rxfh_fields *cmd);
>   
>   	int (*get_tc_size)(struct hnae3_handle *handle);
>   
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.h
> index cdafa63fe38b..cbc02b50c6e7 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.h
> @@ -108,7 +108,7 @@ void hclge_comm_get_rss_indir_tbl(struct hclge_comm_rss_cfg *rss_cfg,
>   int hclge_comm_set_rss_algo_key(struct hclge_comm_hw *hw, const u8 hfunc,
>   				const u8 *key);
>   int hclge_comm_init_rss_tuple_cmd(struct hclge_comm_rss_cfg *rss_cfg,
> -				  struct ethtool_rxnfc *nfc,
> +				  const struct ethtool_rxfh_fields *nfc,
>   				  struct hnae3_ae_dev *ae_dev,
>   				  struct hclge_comm_rss_input_tuple_cmd *req);
>   u64 hclge_comm_convert_rss_tuple(u8 tuple_sets);
> @@ -129,5 +129,5 @@ int hclge_comm_set_rss_hash_key(struct hclge_comm_rss_cfg *rss_cfg,
>   int hclge_comm_set_rss_tuple(struct hnae3_ae_dev *ae_dev,
>   			     struct hclge_comm_hw *hw,
>   			     struct hclge_comm_rss_cfg *rss_cfg,
> -			     struct ethtool_rxnfc *nfc);
> +			     const struct ethtool_rxfh_fields *nfc);
>   #endif
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c
> index 4e2bb6556b1c..1eca53aaf598 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c
> @@ -151,7 +151,7 @@ EXPORT_SYMBOL_GPL(hclge_comm_set_rss_hash_key);
>   int hclge_comm_set_rss_tuple(struct hnae3_ae_dev *ae_dev,
>   			     struct hclge_comm_hw *hw,
>   			     struct hclge_comm_rss_cfg *rss_cfg,
> -			     struct ethtool_rxnfc *nfc)
> +			     const struct ethtool_rxfh_fields *nfc)
>   {
>   	struct hclge_comm_rss_input_tuple_cmd *req;
>   	struct hclge_desc desc;
> @@ -422,7 +422,7 @@ int hclge_comm_set_rss_algo_key(struct hclge_comm_hw *hw, const u8 hfunc,
>   }
>   EXPORT_SYMBOL_GPL(hclge_comm_set_rss_algo_key);
>   
> -static u8 hclge_comm_get_rss_hash_bits(struct ethtool_rxnfc *nfc)
> +static u8 hclge_comm_get_rss_hash_bits(const struct ethtool_rxfh_fields *nfc)
>   {
>   	u8 hash_sets = nfc->data & RXH_L4_B_0_1 ? HCLGE_COMM_S_PORT_BIT : 0;
>   
> @@ -448,7 +448,7 @@ static u8 hclge_comm_get_rss_hash_bits(struct ethtool_rxnfc *nfc)
>   }
>   
>   int hclge_comm_init_rss_tuple_cmd(struct hclge_comm_rss_cfg *rss_cfg,
> -				  struct ethtool_rxnfc *nfc,
> +				  const struct ethtool_rxfh_fields *nfc,
>   				  struct hnae3_ae_dev *ae_dev,
>   				  struct hclge_comm_rss_input_tuple_cmd *req)
>   {
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index 6715222aeb66..3513293abda9 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -978,6 +978,16 @@ static int hns3_set_rss(struct net_device *netdev,
>   					rxfh->hfunc);
>   }
>   
> +static int hns3_get_rxfh_fields(struct net_device *netdev,
> +				struct ethtool_rxfh_fields *cmd)
> +{
> +	struct hnae3_handle *h = hns3_get_handle(netdev);
> +
> +	if (h->ae_algo->ops->get_rss_tuple)
> +		return h->ae_algo->ops->get_rss_tuple(h, cmd);
> +	return -EOPNOTSUPP;
> +}
> +
>   static int hns3_get_rxnfc(struct net_device *netdev,
>   			  struct ethtool_rxnfc *cmd,
>   			  u32 *rule_locs)
> @@ -988,10 +998,6 @@ static int hns3_get_rxnfc(struct net_device *netdev,
>   	case ETHTOOL_GRXRINGS:
>   		cmd->data = h->kinfo.num_tqps;
>   		return 0;
> -	case ETHTOOL_GRXFH:
> -		if (h->ae_algo->ops->get_rss_tuple)
> -			return h->ae_algo->ops->get_rss_tuple(h, cmd);
> -		return -EOPNOTSUPP;
>   	case ETHTOOL_GRXCLSRLCNT:
>   		if (h->ae_algo->ops->get_fd_rule_cnt)
>   			return h->ae_algo->ops->get_fd_rule_cnt(h, cmd);
> @@ -1275,15 +1281,22 @@ static int hns3_set_ringparam(struct net_device *ndev,
>   	return ret;
>   }
>   
> +static int hns3_set_rxfh_fields(struct net_device *netdev,
> +				const struct ethtool_rxfh_fields *cmd,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct hnae3_handle *h = hns3_get_handle(netdev);
> +
> +	if (h->ae_algo->ops->set_rss_tuple)
> +		return h->ae_algo->ops->set_rss_tuple(h, cmd);
> +	return -EOPNOTSUPP;
> +}
> +
>   static int hns3_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
>   {
>   	struct hnae3_handle *h = hns3_get_handle(netdev);
>   
>   	switch (cmd->cmd) {
> -	case ETHTOOL_SRXFH:
> -		if (h->ae_algo->ops->set_rss_tuple)
> -			return h->ae_algo->ops->set_rss_tuple(h, cmd);
> -		return -EOPNOTSUPP;
>   	case ETHTOOL_SRXCLSRLINS:
>   		if (h->ae_algo->ops->add_fd_entry)
>   			return h->ae_algo->ops->add_fd_entry(h, cmd);
> @@ -2105,6 +2118,8 @@ static const struct ethtool_ops hns3vf_ethtool_ops = {
>   	.get_rxfh_indir_size = hns3_get_rss_indir_size,
>   	.get_rxfh = hns3_get_rss,
>   	.set_rxfh = hns3_set_rss,
> +	.get_rxfh_fields = hns3_get_rxfh_fields,
> +	.set_rxfh_fields = hns3_set_rxfh_fields,
>   	.get_link_ksettings = hns3_get_link_ksettings,
>   	.get_channels = hns3_get_channels,
>   	.set_channels = hns3_set_channels,
> @@ -2142,6 +2157,8 @@ static const struct ethtool_ops hns3_ethtool_ops = {
>   	.get_rxfh_indir_size = hns3_get_rss_indir_size,
>   	.get_rxfh = hns3_get_rss,
>   	.set_rxfh = hns3_set_rss,
> +	.get_rxfh_fields = hns3_get_rxfh_fields,
> +	.set_rxfh_fields = hns3_set_rxfh_fields,
>   	.get_link_ksettings = hns3_get_link_ksettings,
>   	.set_link_ksettings = hns3_set_link_ksettings,
>   	.nway_reset = hns3_nway_reset,
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index a5b480d59fbf..5acefd57df45 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -4872,7 +4872,7 @@ static int hclge_set_rss(struct hnae3_handle *handle, const u32 *indir,
>   }
>   
>   static int hclge_set_rss_tuple(struct hnae3_handle *handle,
> -			       struct ethtool_rxnfc *nfc)
> +			       const struct ethtool_rxfh_fields *nfc)
>   {
>   	struct hclge_vport *vport = hclge_get_vport(handle);
>   	struct hclge_dev *hdev = vport->back;
> @@ -4890,7 +4890,7 @@ static int hclge_set_rss_tuple(struct hnae3_handle *handle,
>   }
>   
>   static int hclge_get_rss_tuple(struct hnae3_handle *handle,
> -			       struct ethtool_rxnfc *nfc)
> +			       struct ethtool_rxfh_fields *nfc)
>   {
>   	struct hclge_vport *vport = hclge_get_vport(handle);
>   	u8 tuple_sets;
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> index c4f35e8e2177..f1657f50cdda 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> @@ -606,7 +606,7 @@ static int hclgevf_set_rss(struct hnae3_handle *handle, const u32 *indir,
>   }
>   
>   static int hclgevf_set_rss_tuple(struct hnae3_handle *handle,
> -				 struct ethtool_rxnfc *nfc)
> +				 const struct ethtool_rxfh_fields *nfc)
>   {
>   	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
>   	int ret;
> @@ -624,7 +624,7 @@ static int hclgevf_set_rss_tuple(struct hnae3_handle *handle,
>   }
>   
>   static int hclgevf_get_rss_tuple(struct hnae3_handle *handle,
> -				 struct ethtool_rxnfc *nfc)
> +				 struct ethtool_rxfh_fields *nfc)
>   {
>   	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
>   	u8 tuple_sets;

