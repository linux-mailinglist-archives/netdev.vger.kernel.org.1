Return-Path: <netdev+bounces-226836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F16BA57B6
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057971C021B0
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DCB1E7C12;
	Sat, 27 Sep 2025 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="cJy+nJaQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E71C7013
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935868; cv=none; b=jpigeMDcJMmpAbl953i6B0n9KtHkN+h2xa151DxX6ddqMGkfo4x/AbWXGrijDODlW5CpGmyBwwJZo/Q5hA6k43e82zXLgFpcVm2walq3d2aUmk8KtkHMIm2ARRAZ7BQxeUpir4GOkcN3AAO4IgkADT9sVi21srETddI8jTglF1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935868; c=relaxed/simple;
	bh=5H8iigtTkRnjUWhdaCUi7PgMbrrTXbvad8rvtH4bH9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ+dU68PYDOhXrWOxRavpBE7gEsuIAblPTnrcjFJbXIj7sCO2qd7MW1I2IJGTW2HTm8GKMoAJEfcstKRb2dsxyUbWwy5Q0A/5yaFhAD+WhV9Mvl/KQriqJnTMrdCOo+d1Vkfrto7Hi425pFrv4jHuZyDDGlXaCp8zUAom6BO30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=cJy+nJaQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26e81c17d60so5150635ad.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 18:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1758935866; x=1759540666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BFIzrSFllSLMKrfYWnZwU9FYy16cJgR0sTCe9xWmcOY=;
        b=cJy+nJaQvg0qNR+s0v9wyZaKn1Rd7iwCQESHMVLSRzaW+MLhdcjwEJIrTVmv1snH8a
         u/MudCbNmfOnp+V6AG02/pTDhNX3+Rq9/8vgIgix7hKI1VpHkTJ8c3pxbFgBoLbB+f2S
         SU5p+jARGyaDFNls/iSg56LQLnmirLKbOGD+w8a0mimaXbc5J1tnL9dXiT/pNr9Gm3YK
         ROEKm6MkfyIAdpl/CrEFDkGgriotlrq1k94UtdiL8xJUC8v4hjTMa4T/0AF+XkT6r590
         DDR7XDeeuD5pma+55tReVJoxucHWNbiuvpaDlWWPNQWaxWLMuCNrtRAC1yl9hUSjVNfP
         W05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758935866; x=1759540666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFIzrSFllSLMKrfYWnZwU9FYy16cJgR0sTCe9xWmcOY=;
        b=hnxCWcEkC6ROfLSKY2fW93iN4KwPHczsTXFzaCaaPrKsekSCHGg5xkcIBakrEGKede
         udNTwIvMXuchdSx4FS6Mi0fCusBrQ3dBuTzP/E3KCn40/Ubzl1CIQfcFjEeruUUhG9Kq
         GucHkuVWdf5nCPMSzZrfp/NU5lk79Mp5GUOH2flbp3Hxt4+SPuLHda3TlgtAPNC0Aesr
         kLK66ReB3/XqoJmJxXwu1ioQB26dKPfrdozX4NmFgeiqbwxWjJDy+riH5YOdBBFd9i4p
         SLzM0ZLQvLqXmq1qv6qrYzeo27RxRlJnJ9I39ZOM5JOfS63AvBiwMX3XdbSP1Si0z0ud
         NeqA==
X-Gm-Message-State: AOJu0Yyf6FU/m6mZld7/Z3tZysHbEZAKZoZ7x/j4e5forSqYuE0a2bz8
	DRj11VPC0LKdP9AN0LnaHnz7gkyNn/GAwkscewQ/Kdp7AgXwd1nkiHNr1OJ4cNIVkvY=
X-Gm-Gg: ASbGncvxtFuP2vogyYlA403yzkckzWrVII8Jej5aPayba7S1txjx7bLK/CN1vj3fMXS
	7tpClEsVZ9yGyEG42O2hgsClx6VhAQpVYWTVJUexJhveucMSHptrtxFwWStF+/DBlveXtRjUIfV
	eFoy132r4LilEWTSJ/gqFcDEMjmire/pTGR3zEEemuaxxyikFMJPv5mSU52WM7zA8E/F67oxEBy
	5qRCIcoVJPz9qKxV8aXl1iHWdklasPXpzowEueFN1kbIi3fO/HmpK4GzZpQFETURj3T7pA/RU2b
	Ms05ZM3wb86yd0SLwBWPBzK0Xu6m8FEAMd3/kw+QWMxo59tELaQg7tCAOppGJrCEwIF1hloyAKO
	9tYd3C/t/2yEiY9X5qHiYpa6AryZHfcRX2sFnFRgo01+yg47V3l1hdbtKD3ps
X-Google-Smtp-Source: AGHT+IG1zJIOFx48QAoU6hWUKdfepzoYZ9zayKUuvh9YmBCsOklF1hmPiMOIGSCxqZ5Yt+Vaqa/Rbw==
X-Received: by 2002:a17:902:d2cf:b0:273:a653:bacf with SMTP id d9443c01a7336-27ed4942463mr59483475ad.0.1758935866246;
        Fri, 26 Sep 2025 18:17:46 -0700 (PDT)
Received: from m2 (192-184-204-241.fiber.dynamic.sonic.net. [192.184.204.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2353dsm10132237a91.21.2025.09.26.18.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 18:17:45 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:17:43 -0700
From: Jordan Rife <jordan@jrife.io>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com, willemb@google.com, 
	sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org, 
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 16/20] netkit: Implement rtnl_link_ops->alloc
Message-ID: <3yy7htlhsx2c2v7jkoh23iywiwacxdb3y7qpr2s5hwjw3zazhb@kivqcblixanb>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-17-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-17-daniel@iogearbox.net>

On Fri, Sep 19, 2025 at 11:31:49PM +0200, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Implement rtnl_link_ops->alloc that allows the number of rx queues to be
> set when netkit is created. By default, netkit has only a single rxq (and
> single txq). The number of queues is deliberately not allowed to be changed
> via ethtool -L and is fixed for the lifetime of a netkit instance.
> 
> For netkit device creation, numrxqueues with larger than one rxq can be
> specified. These rxqs are then mappable to real rxqs in physical netdevs:
> 
>   ip link add numrxqueues 2 type netkit
> 
> As a starting point, the limit of numrxqueues for netkit is currently set
> to 2, but future work is going to allow mapping multiple real rxqs from

Is the reason for the limit just because QEMU can't take advantage of
more today or is there some other technical limitation?

> physical netdevs, potentially at some point even from different physical
> netdevs.

What would be the use case for having proxied queues from multiple
physical netdevs to the same netkit device? Couldn't you just create
multiple netkit devices, one per physical device?

> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/netkit.c | 78 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 72 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 8f1285513d82..e5dfbf7ea351 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -9,11 +9,19 @@
>  #include <linux/bpf_mprog.h>
>  #include <linux/indirect_call_wrapper.h>
>  
> +#include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
>  #include <net/netkit.h>
>  #include <net/dst.h>
>  #include <net/tcx.h>
>  
> -#define DRV_NAME "netkit"
> +#define NETKIT_DRV_NAME	"netkit"
> +
> +#define NETKIT_NUM_TX_QUEUES_MAX  1
> +#define NETKIT_NUM_RX_QUEUES_MAX  2
> +
> +#define NETKIT_NUM_TX_QUEUES_REAL 1
> +#define NETKIT_NUM_RX_QUEUES_REAL 1
>  
>  struct netkit {
>  	__cacheline_group_begin(netkit_fastpath);
> @@ -37,6 +45,8 @@ struct netkit_link {
>  	struct net_device *dev;
>  };
>  
> +static struct rtnl_link_ops netkit_link_ops;
> +
>  static __always_inline int
>  netkit_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
>  	   enum netkit_action ret)
> @@ -243,13 +253,69 @@ static const struct net_device_ops netkit_netdev_ops = {
>  static void netkit_get_drvinfo(struct net_device *dev,
>  			       struct ethtool_drvinfo *info)
>  {
> -	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> +	strscpy(info->driver, NETKIT_DRV_NAME, sizeof(info->driver));
> +}
> +
> +static void netkit_get_channels(struct net_device *dev,
> +				struct ethtool_channels *channels)
> +{
> +	channels->max_rx = dev->num_rx_queues;
> +	channels->max_tx = dev->num_tx_queues;
> +	channels->max_other = 0;
> +	channels->max_combined = 1;
> +	channels->rx_count = dev->real_num_rx_queues;
> +	channels->tx_count = dev->real_num_tx_queues;
> +	channels->other_count = 0;
> +	channels->combined_count = 0;
>  }
>  
>  static const struct ethtool_ops netkit_ethtool_ops = {
>  	.get_drvinfo		= netkit_get_drvinfo,
> +	.get_channels		= netkit_get_channels,
>  };
>  
> +static struct net_device *netkit_alloc(struct nlattr *tb[],
> +				       const char *ifname,
> +				       unsigned char name_assign_type,
> +				       unsigned int num_tx_queues,
> +				       unsigned int num_rx_queues)
> +{
> +	const struct rtnl_link_ops *ops = &netkit_link_ops;
> +	struct net_device *dev;
> +
> +	if (num_tx_queues > NETKIT_NUM_TX_QUEUES_MAX ||
> +	    num_rx_queues > NETKIT_NUM_RX_QUEUES_MAX)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	dev = alloc_netdev_mqs(ops->priv_size, ifname,
> +			       name_assign_type, ops->setup,
> +			       num_tx_queues, num_rx_queues);
> +	if (dev) {
> +		dev->real_num_tx_queues = NETKIT_NUM_TX_QUEUES_REAL;
> +		dev->real_num_rx_queues = NETKIT_NUM_RX_QUEUES_REAL;
> +	}
> +	return dev;
> +}
> +
> +static void netkit_queue_unpeer(struct net_device *dev)
> +{
> +	struct netdev_rx_queue *src_rxq, *dst_rxq;
> +	struct net_device *src_dev;
> +	int i;
> +
> +	if (dev->real_num_rx_queues == 1)
> +		return;
> +	for (i = 1; i < dev->real_num_rx_queues; i++) {
> +		dst_rxq = __netif_get_rx_queue(dev, i);
> +		src_rxq = dst_rxq->peer;
> +		src_dev = src_rxq->dev;
> +
> +		netdev_lock(src_dev);
> +		netdev_rx_queue_unpeer(src_dev, src_rxq, dst_rxq);
> +		netdev_unlock(src_dev);
> +	}
> +}
> +
>  static void netkit_setup(struct net_device *dev)
>  {
>  	static const netdev_features_t netkit_features_hw_vlan =
> @@ -330,8 +396,6 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
>  	return 0;
>  }
>  
> -static struct rtnl_link_ops netkit_link_ops;
> -
>  static int netkit_new_link(struct net_device *dev,
>  			   struct rtnl_newlink_params *params,
>  			   struct netlink_ext_ack *extack)
> @@ -865,6 +929,7 @@ static void netkit_release_all(struct net_device *dev)
>  static void netkit_uninit(struct net_device *dev)
>  {
>  	netkit_release_all(dev);
> +	netkit_queue_unpeer(dev);
>  }
>  
>  static void netkit_del_link(struct net_device *dev, struct list_head *head)
> @@ -1005,8 +1070,9 @@ static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
>  };
>  
>  static struct rtnl_link_ops netkit_link_ops = {
> -	.kind		= DRV_NAME,
> +	.kind		= NETKIT_DRV_NAME,
>  	.priv_size	= sizeof(struct netkit),
> +	.alloc		= netkit_alloc,
>  	.setup		= netkit_setup,
>  	.newlink	= netkit_new_link,
>  	.dellink	= netkit_del_link,
> @@ -1042,4 +1108,4 @@ MODULE_DESCRIPTION("BPF-programmable network device");
>  MODULE_AUTHOR("Daniel Borkmann <daniel@iogearbox.net>");
>  MODULE_AUTHOR("Nikolay Aleksandrov <razor@blackwall.org>");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS_RTNL_LINK(DRV_NAME);
> +MODULE_ALIAS_RTNL_LINK(NETKIT_DRV_NAME);
> -- 
> 2.43.0
> 

Reviewed-by: Jordan Rife <jordan@jrife.io>

