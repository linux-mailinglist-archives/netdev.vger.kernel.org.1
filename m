Return-Path: <netdev+bounces-286075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPuwHeqR/mnJswAAu9opvQ
	(envelope-from <netdev+bounces-286075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:46:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD64FD5FD
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C09EB300E02B
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 01:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD68D2741B5;
	Sat,  9 May 2026 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjVuPyO9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971A1F8691;
	Sat,  9 May 2026 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291173; cv=none; b=EIYLKsB9snADCNaa2CgNeq2eyejgID9BwWZwzznW05HZ28ZpuSp1QOktYXcAB9jyIZLL6FxVSEZR0sXS4NHYwIWxRoBNXqmxE5UIf3mmrhEqHah2YBA6fHhpVlKNz8nmp213lkBKBoMvI8NjCm8l4SvtX0xZzI6FSPURRJFl2UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291173; c=relaxed/simple;
	bh=mp2ZQVuKoI/GitBcxUoDpxVotzf5sy1ZjJulzPRcuwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/X/QW3NMZh6X7ZD4maxOXdInTYOk1Cl+t1aFdXLIBCWW04yT/TbqQ/Pz9Bat4GDW9f8RnDYEjptkqNQv7mPkeE9q7EWBenon3TLnEpkEwuNWSjb8i601p6PAmFQwZFOz92EeGWPmMl9Pv0iAEydmF5LkPghRQ4im9vxKSU08Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjVuPyO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2AAC2BCB0;
	Sat,  9 May 2026 01:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291173;
	bh=mp2ZQVuKoI/GitBcxUoDpxVotzf5sy1ZjJulzPRcuwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BjVuPyO9ncYs0l6zVPbbKV/DTduE3RsKesmJDF6T7SV/bfhLjE00B+jQwNVp1otva
	 i5sTt6KebQFf5Kr6vs5DDzlNic100P7oN9o/4JFT98h3lLD+JGdBupcKuK5x8i50vr
	 +UEGTakwnKCvd9aYhTinzu9V6/nZ5R2u3J27AfRAehbFn8wjfLqrc+ksi2h7iRUuki
	 lAWdYyFBbG/rmwHOjIta67gve1hcmuhEEk8G0oKn04vuJ26vQc/7Z/4O5dhkqobSne
	 M2/ug2+nSKZlg4FdzbtU1i4jB00h7BxYdxDBV26+En8cAq/Dst9AhIV+6mRFbb+Vg3
	 1OM7nrFNGldQw==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	madhur.agrawal@airoha.com
Subject: Re: [PATCH net-next v4 07/10] net: airoha: Support multiple net_devices for a single FE GDM port
Date: Fri,  8 May 2026 18:46:11 -0700
Message-ID: <20260509014611.3558060-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-7-af613b61ae02@kernel.org>
References: <20260507-airoha-eth-multi-serdes-v4-7-af613b61ae02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5FFD64FD5FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-286075-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: airoha: Support multiple net_devices for a single FE GDM port

This commit introduces support for multiple net_devices connected to the
same Frame Engine (FE) GDM port (GDM3 or GDM4) via an external hardware
arbiter on EN7581 or AN7583 SoCs, and adds a get_dev_from_sport callback
to differentiate between the net_devices attached to each port.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 786bc677af3c..0253919714e0 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[ ... ]

> @@ -3188,14 +3257,23 @@ static int airoha_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port = eth->ports[i];
> -		struct airoha_gdm_dev *dev;
> +		int j;
>  
>  		if (!port)
>  			continue;
>  
> -		dev = port->dev;
> -		if (dev && dev->dev->reg_state == NETREG_REGISTERED)
> -			unregister_netdev(dev->dev);
> +		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *dev = port->devs[j];
> +			struct net_device *netdev;
> +
> +			if (!dev)
> +				continue;
> +
> +			netdev = dev->dev;
> +			of_node_put(netdev->dev.of_node);
> +			if (netdev->reg_state == NETREG_REGISTERED)
> +				unregister_netdev(netdev);
> +		}
>  		airoha_metadata_dst_free(port);
>  	}
>  	airoha_hw_cleanup(eth);

[Medium]
Is the ordering of of_node_put() and unregister_netdev() here correct?

airoha_alloc_gdm_device() now does:

	netdev->dev.of_node = of_node_get(np);

so the netdev holds its own reference to the of_node for its entire
registered lifetime. In this error unwind the of_node_put() runs before
unregister_netdev(), and netdev->dev.of_node is not cleared, so any
subsequent access to netdev->dev.of_node during unregistration (netdev
notifiers, sysfs, overlay-aware code) would be looking at a node whose
reference count has already been dropped.

Other drivers (e.g., drivers/net/ethernet/hisilicon/hns/hns_enet.c in
hns_nic_dev_remove()) put the node only after unregister_netdev().

Would swapping the order to call unregister_netdev() first, then
of_node_put(), be more appropriate here?

> @@ -3216,14 +3294,22 @@ static void airoha_remove(struct platform_device *pdev)
>  
>  	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port = eth->ports[i];
> -		struct airoha_gdm_dev *dev;
> +		int j;
>  
>  		if (!port)
>  			continue;
>  
> -		dev = port->dev;
> -		if (dev)
> -			unregister_netdev(dev->dev);
> +		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *dev = port->devs[j];
> +			struct net_device *netdev;
> +
> +			if (!dev)
> +				continue;
> +
> +			netdev = dev->dev;
> +			of_node_put(netdev->dev.of_node);
> +			unregister_netdev(netdev);
> +		}
>  		airoha_metadata_dst_free(port);
>  	}
>  	airoha_hw_cleanup(eth);

[Medium]
Same question in airoha_remove(): the of_node_put() fires before
unregister_netdev(), while netdev->dev.of_node is still assigned. Would
this be safer with the unregister first and the put afterwards?

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index 3e93919a175c..207c75152fde 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h

[ ... ]

> @@ -542,14 +543,15 @@ struct airoha_qdma {
>  struct airoha_gdm_dev {
>  	struct airoha_gdm_port *port;
>  	struct airoha_qdma *qdma;
> -	struct net_device *dev;
>  	struct airoha_eth *eth;
> +	struct net_device *dev;
> +
> +	int nbq;
>  };
>  
>  struct airoha_gdm_port {
> -	struct airoha_gdm_dev *dev;
> +	struct airoha_gdm_dev *devs[AIROHA_MAX_NUM_GDM_DEVS];
>  	int id;
> -	int nbq;
>  
>  	struct airoha_hw_stats stats;

[Medium]
With multiple airoha_gdm_dev instances now sharing a single
airoha_gdm_port, do the per-netdev statistics need to become per-netdev
rather than per-port?

airoha_dev_get_stats64(), airoha_ethtool_get_mac_stats() and
airoha_ethtool_get_rmon_stats() all read from dev->port->stats, and the
underlying hardware counters at REG_FE_GDM_*_CNT(port->id) are per-GDM
port rather than per-netdev. When two netdevs share a port (for example
PCIE0/PCIE1 on EN7581 GDM3, or ETH/USB on GDM4), both netdevs would
report identical port-wide counters via rtnl_link_stats64 (ip -s link
show) and via the get_eth_mac_stats/get_rmon_stats ethtool callbacks,
and summing across the two netdevs would double-count.

Would it make sense to maintain per-netdev software counters in the
xmit/RX paths for the multi-dev case so each netdev reports its own
traffic through the standard uAPI?

