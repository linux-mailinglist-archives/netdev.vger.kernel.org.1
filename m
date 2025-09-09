Return-Path: <netdev+bounces-221166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BAAB4AAA9
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7154A3A3D7A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249872D23A9;
	Tue,  9 Sep 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYGsI7Qe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A1288C96
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413797; cv=none; b=YP+KWA8RsD09/dB3IFjUbkhuxK76TtX90PARMh7q86jkay7l3O57Z7jSnZwYO2PMxrpBIp+QV5u7tCIyZB61qN5RywcI0sm31dZbKd8nNibAO4GB1Zz6f5AOtmm2Fh8fAjwAaRRL27ip2TlLLwct4DletoDnMGfDfJItGfdjdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413797; c=relaxed/simple;
	bh=s0OejQYdKQNyH/Yt6kaxVGE1PCqvhOmGeszv+dWI55k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jB7QageNatj6IY0sPyRrnu8QC7MtiyuhHVFsUsSMG86Hu+TqebNWw3FAEpissdUM2uT+9GEJ1DRXdmxZDNwerk1v2S9qtsN7ClnQ+mOaANSXYQDI5ZR3vtoCMSAzt9zROwRzgiJW3iFgQ3BNJ58iiB8DIJGQ4DFA+tUEgau33fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYGsI7Qe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757413793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVE/nujTFy1bBg1Rtkn8WDLnbAicgDtiwRIzEX2j50c=;
	b=DYGsI7Qe9laDEnSf6wqjiRY/jkDaaA7f2wRK3AJYT5CxRKxX1HRJuuKzGtr97jVWE/FoMF
	7F0fH/62Opb+4Q7FqqIKQQ2UDaj/AyWtTrLignmvu6COejjj6Uz/9TadjyI7V7+Mfsz+Co
	Z6/QkLtfFHNRNQMXX3CeiJeaZAmggcU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-aSIxztMiNPKytx_La9fthQ-1; Tue, 09 Sep 2025 06:29:51 -0400
X-MC-Unique: aSIxztMiNPKytx_La9fthQ-1
X-Mimecast-MFC-AGG-ID: aSIxztMiNPKytx_La9fthQ_1757413789
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e50783dda8so1823902f8f.2
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 03:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413789; x=1758018589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVE/nujTFy1bBg1Rtkn8WDLnbAicgDtiwRIzEX2j50c=;
        b=QAa7klC9Ru9t4vtNqdo8Zim+caen4Vnvb6I1jNr7AfCJcBfQAGdvSMaQf6XHq/pPBp
         wDvCUfJ4SvYrqq/mmkK0l4pUUr0jSrMJlg5rlS1jWTTxigkb29WqznLpcnzSDO9JJWyK
         ej3QcxrC8AQP0S+IPLHnVFn8zKfYt+p55a8HjawuhVNkau5AO8PKRoMuDTjv8AQlHfVI
         uxkppXylPzsBoYiViwZKpEJhkCwanbQnwOVgi6WDkALj4KndBKDkNp27kn18V+kqdf7y
         /PkluQQ2daAtT37Z40/oOQQ0c13AO1xwqB2jo3OdCilL/xXQh9N4gVMGcxP+4EaB8Fx2
         qOZg==
X-Forwarded-Encrypted: i=1; AJvYcCV3hge0iiUpCJZQrluCql31dXzVyFdnhFNs0wgOGgUmsb1tQvmLYnp9WhxCGxNg2199jPNxTzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9EtnKoG4p5xzCjbz4fu7zk6R1P479m0GlmXLpJZrUjPq4G9L
	6IQZlfCTWUQB34M5F0BVh3rt89rnpO4OoCM9MDUNfKgWopBp0V3oYmuzxkghJgIgH/Jw9XPU7wB
	jOk0g4BTLIvSwvUhpZPSvmVf4ymHegXFjyrnEW3h4gEic5nVG3IrKhdXA1Q==
X-Gm-Gg: ASbGncs0TfitW3HNG7OGzvMoUePd847GC2tKd11bBqeOgGtSFa/px1hyn0m0NroBF6j
	Rixw51pEkD7ycNgg2H9SComf7xS8DmdxtJl79UkL7yAs7lzcaSDOaeACnl1xGBrRgJQwF5EmvOU
	qoOTuNDM7/4b9GfRNQMOT1zOU/lQGYZSREG80vuUqLV1wvlLDRrSga6txR4L1vTsHtXq3bUBHiA
	TcLuMxveKZEVqBGHP+R4nTNfWALq0JIQL8d69Qp1jqPDlyJxvVfORkEN9lZgnnLQfd7elvlJv5N
	BNuiWn9BeSB1NFhiFh3dgbxU0Q/08Jy/sKI/byHQDSzGSixoqBeyWAjDSrGJl7AeqzVVrDMvLME
	u3Xe3dLxQN6Y=
X-Received: by 2002:a5d:4e92:0:b0:3e6:6d09:d305 with SMTP id ffacd0b85a97d-3e66d09d4d2mr7014142f8f.11.1757413788912;
        Tue, 09 Sep 2025 03:29:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP5Q0kY8rtQ9ZF4fgFAKSU1R6H1Z7EJ9PBH7s0runEyy6esY/4vmV7z4kUvmtDCGD02YbYcg==
X-Received: by 2002:a5d:4e92:0:b0:3e6:6d09:d305 with SMTP id ffacd0b85a97d-3e66d09d4d2mr7014126f8f.11.1757413788448;
        Tue, 09 Sep 2025 03:29:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75224ee03sm2078736f8f.61.2025.09.09.03.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:29:47 -0700 (PDT)
Message-ID: <00b9012f-6bd5-47b7-a174-524f91ba944d@redhat.com>
Date: Tue, 9 Sep 2025 12:29:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250904011839.71183-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250904011839.71183-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 3:18 AM, Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.
> 
> This commit is indeed quite large, but further splitting it would not be
> meaningful. Historically, many similar drivers have been introduced with
> commits of similar size and scope, so we chose not to invest excessive
> effort into finer-grained splitting.
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  MAINTAINERS                                   |   8 +
>  drivers/net/ethernet/Kconfig                  |   1 +
>  drivers/net/ethernet/Makefile                 |   1 +
>  drivers/net/ethernet/alibaba/Kconfig          |  29 +
>  drivers/net/ethernet/alibaba/Makefile         |   5 +
>  drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
>  drivers/net/ethernet/alibaba/eea/eea_adminq.c | 452 ++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
>  drivers/net/ethernet/alibaba/eea/eea_desc.h   | 155 ++++
>  .../net/ethernet/alibaba/eea/eea_ethtool.c    | 310 +++++++
>  .../net/ethernet/alibaba/eea/eea_ethtool.h    |  51 ++
>  drivers/net/ethernet/alibaba/eea/eea_net.c    | 587 +++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_net.h    | 196 +++++
>  drivers/net/ethernet/alibaba/eea/eea_pci.c    | 574 +++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_pci.h    |  67 ++
>  drivers/net/ethernet/alibaba/eea/eea_ring.c   | 267 ++++++
>  drivers/net/ethernet/alibaba/eea/eea_ring.h   |  89 ++
>  drivers/net/ethernet/alibaba/eea/eea_rx.c     | 784 ++++++++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_tx.c     | 412 +++++++++
>  19 files changed, 4067 insertions(+)

This is way too much for a single patch, and makes reviews very hard.
Please split it in a patch series - i.e. basic infra, tx path, rx path,
ethtool.

[...]
> +int eea_adminq_destroy_q(struct eea_net *enet, u32 qidx, int num)
> +{
> +	struct device *dev = enet->edev->dma_dev;
> +	dma_addr_t dma_addr;
> +	__le16 *buf;
> +	u32 size;
> +	int i;
> +
> +	if (qidx == 0 && num == -1)
> +		return eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_ALL,
> +				       NULL, 0, NULL, 0);
> +
> +	size = sizeof(__le16) * num;
> +	buf = dma_alloc_coherent(dev, size, &dma_addr, GFP_KERNEL);

Destruction requiring allocation is problematic, i.e. it will fail under
memory pressure leaving the device in an inconsistent status, possibly
unrecoverable.

You could instead always allocate the memory needed here at create_q() time.

[...]
> +static int eea_set_ringparam(struct net_device *netdev,
> +			     struct ethtool_ringparam *ring,
> +			     struct kernel_ethtool_ringparam *kernel_ring,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	struct eea_net_tmp tmp = {};
> +	bool need_update = false;
> +	struct eea_net_cfg *cfg;
> +	bool sh;
> +
> +	enet_mk_tmp(enet, &tmp);

The above helper name and struct name are quite confusing. Does it copy
the current device status? possibly a more verbose name would help.

[...]
> +static int eea_set_channels(struct net_device *netdev,
> +			    struct ethtool_channels *channels)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	u16 queue_pairs = channels->combined_count;
> +	struct eea_net_tmp tmp = {};
> +	struct eea_net_cfg *cfg;
> +
> +	enet_mk_tmp(enet, &tmp);
> +
> +	cfg = &tmp.cfg;
> +
> +	if (channels->rx_count || channels->tx_count || channels->other_count)
> +		return -EINVAL;
> +
> +	if (queue_pairs > enet->cfg_hw.rx_ring_num || queue_pairs == 0)
> +		return -EINVAL;
> +
> +	if (queue_pairs == enet->cfg.rx_ring_num &&
> +	    queue_pairs == enet->cfg.tx_ring_num)
> +		return 0;
> +
> +	cfg->rx_ring_num = queue_pairs;
> +	cfg->tx_ring_num = queue_pairs;
> +
> +	return eea_reset_hw_resources(enet, &tmp);

The above implies that eea_reset_hw_resources() should/must not make any
change to the device when/if failing.

> +/* stop rx napi, stop tx queue. */
> +static int eea_stop_rxtx(struct net_device *netdev)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	int i;
> +
> +	netif_tx_disable(netdev);
> +
> +	for (i = 0; i < enet->cfg.rx_ring_num; i++)
> +		enet_rx_stop(enet->rx[i]);
> +
> +	netif_carrier_off(netdev);
> +
> +	return 0;

Never fails and the return code is apparently ignored. It should be a
void functon.

> +}
> +
> +static int eea_start_rxtx(struct net_device *netdev)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	int i, err;
> +
> +	err = netif_set_real_num_rx_queues(netdev, enet->cfg.rx_ring_num);
> +	if (err)
> +		return err;
> +
> +	err = netif_set_real_num_tx_queues(netdev, enet->cfg.tx_ring_num);
> +	if (err)
> +		return err;

You could/should use: netif_set_real_num_queues()


> +
> +	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
> +		err = enet_rx_start(enet->rx[i]);

The above can never fail, you should avoid checking it's value and it
should return void

[...]
> +/* resources: ring, buffers, irq */
> +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_tmp *tmp)
> +{
> +	struct eea_net_tmp _tmp = {};
> +	int err;
> +
> +	if (!tmp) {
> +		enet_mk_tmp(enet, &_tmp);
> +		tmp = &_tmp;
> +	}
> +
> +	if (!netif_running(enet->netdev)) {
> +		enet->cfg = tmp->cfg;
> +		return 0;
> +	}
> +
> +	err = eea_alloc_rxtx_q_mem(tmp);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: alloc q failed. stop reset. err %d\n",
> +			    err);
> +		return err;
> +	}
> +
> +	eea_netdev_stop(enet->netdev);
> +
> +	enet_bind_new_q_and_cfg(enet, tmp);
> +
> +	err = eea_active_ring_and_irq(enet);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: active new ring and irq failed. err %d\n",
> +			    err);
> +		goto err;
> +	}
> +
> +	err = eea_start_rxtx(enet->netdev);
> +	if (err)
> +		netdev_warn(enet->netdev,
> +			    "eea reset: start queue failed. err %d\n", err);
> +

Here you should try harder to avoid any NIC changes in case of failure.
i.e. you could activate and start only the new queues, and destroy the
to-be-deleted one only after successful real queues update.

[...]
> +static int eea_netdev_init_features(struct net_device *netdev,
> +				    struct eea_net *enet,
> +				    struct eea_device *edev)
> +{
> +	struct eea_aq_cfg *cfg __free(kfree) = NULL;
> +	int err;
> +	u32 mtu;
> +
> +	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> +
> +	err = eea_adminq_query_cfg(enet, cfg);
> +
> +	if (err)
> +		return err;
> +
> +	eea_update_cfg(enet, edev, cfg);
> +
> +	netdev->priv_flags |= IFF_UNICAST_FLT;
> +	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> +
> +	netdev->hw_features |= NETIF_F_HW_CSUM;
> +	netdev->hw_features |= NETIF_F_GRO_HW;
> +	netdev->hw_features |= NETIF_F_SG;
> +	netdev->hw_features |= NETIF_F_TSO;
> +	netdev->hw_features |= NETIF_F_TSO_ECN;
> +	netdev->hw_features |= NETIF_F_TSO6;
> +
> +	netdev->features |= NETIF_F_HIGHDMA;
> +	netdev->features |= NETIF_F_HW_CSUM;
> +	netdev->features |= NETIF_F_SG;
> +	netdev->features |= NETIF_F_GSO_ROBUST;
> +	netdev->features |= netdev->hw_features & NETIF_F_ALL_TSO;
> +	netdev->features |= NETIF_F_RXCSUM;
> +	netdev->features |= NETIF_F_GRO_HW;

I guess you could also enable partial_features for some tunnels?

[...]
> +static int eea_fill_desc_from_skb(const struct sk_buff *skb,
> +				  struct ering *ering,
> +				  struct eea_tx_desc *desc)
> +{
> +	if (skb_is_gso(skb)) {
> +		struct skb_shared_info *sinfo = skb_shinfo(skb);
> +
> +		desc->gso_size = cpu_to_le16(sinfo->gso_size);
> +		if (sinfo->gso_type & SKB_GSO_TCPV4)
> +			desc->gso_type = EEA_TX_GSO_TCPV4;
> +
> +		else if (sinfo->gso_type & SKB_GSO_TCPV6)
> +			desc->gso_type = EEA_TX_GSO_TCPV6;
> +
> +		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> +			desc->gso_type = EEA_TX_GSO_UDP_L4;

The device does not expose NETIF_F_GSO_UDP_L4, this branch should never
be reached. Either expose the feature or drop this branch.

[...]
> +netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> +	struct eea_net *enet = netdev_priv(netdev);
> +	int qnum = skb_get_queue_mapping(skb);
> +	struct enet_tx *tx = &enet->tx[qnum];
> +	struct netdev_queue *txq;
> +	int err;
> +
> +	txq = netdev_get_tx_queue(netdev, qnum);
> +
> +	if (eea_tx_stop(tx, txq, shinfo->nr_frags + 1)) {

Any special reason to avoid using netif_txq_maybe_stop() here?

/P


