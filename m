Return-Path: <netdev+bounces-286878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGRjGIRwAmqZswEAu9opvQ
	(envelope-from <netdev+bounces-286878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:12:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D10A5517C8C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 615F5302333C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F7015E5BB;
	Tue, 12 May 2026 00:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5snHHLR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F71347C7;
	Tue, 12 May 2026 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544768; cv=none; b=eKd2T3P1MzR9o2J0SHx3N5+MYBTDJ6VrsBcLY6QEdzLjDJD9nRi85nET0JrFYJX5w5yR2NLi1FYXJhMlp626yCz0s3Y6uKiJWYMRDnGo9/9A/1tVrIc2DAcDWnqlkKlni1SdIKCu4y3ZdKdxAQu9eBsxwlVhh7jqugidzVSPSMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544768; c=relaxed/simple;
	bh=kFb6SPbEKyhMJcMUWH9F7JCwmkAxIHfi3kRMgYdFaTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRYLAy1eDPbxEBsfRJPwnW9Kyx1x17MbpfoEsMp0Qqe/2TdBngy3nlq3uZqkROCFzgxJHZ8MFE9BdoXT6ajnhg3QimXRIKeq6Zq5l0TN6IQAuzocMb2kLuBUo6F9zTjA9Lo2DRT4j98KN0JGVMdpeYJxpqtnZlFSP9LB0gfDk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5snHHLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D14C2BCB0;
	Tue, 12 May 2026 00:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778544767;
	bh=kFb6SPbEKyhMJcMUWH9F7JCwmkAxIHfi3kRMgYdFaTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q5snHHLRLm/bqZdEE/Kk0eTvidaU/KtvDNepk43XQUxKvy16+smGczpoGhyZJLB+G
	 WYw40VlKNNcEyQYL/zaNhmFPTesDsM+P1VZ0FAU/7DgT4jEKSKZWMwTgcCyq2Rxlth
	 tROTEoPyVi3uqyoYRjg+TF7lT7BA+EPcXMbEI/ENiUEZX/sD+s4RPpioONiDFDGyaV
	 ZpBCC/DnW7OvU8y4PtXltXtCRwX96ztFXPVBbCR6EEYZnbE/3TlC1zJd5pSt5jVv9e
	 GMerLLgkRF+vpBfr51+uNDwnqld25fGlDzZDS5tQajoJj3Ev1zqR9YD5F8R7Os9TLK
	 0dIKA7gBwgZRg==
Date: Mon, 11 May 2026 17:12:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anshumali Gaur <agaur@marvell.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] octeontx2-pf: persist netdev stats across
 routine operations
Message-ID: <20260511171246.12a0cd4f@kernel.org>
In-Reply-To: <20260511094205.1422268-1-agaur@marvell.com>
References: <20260511094205.1422268-1-agaur@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D10A5517C8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286878-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 15:12:05 +0530 Anshumali Gaur wrote:
> Currently netdev driver is not retaining ethtool stats during
> interface up and down, as per kernel driver standard netdev driver
> must keep stats constant to avoid race conditions with user space
> trying to read them. Stats must persist across routine
> operations like bringing the interface down and up.

I think you're confusing the value of the stats with the list of stats.
Retaining values thru down/up is probably the most common behavior but
that's not what the doc is likely talking about.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 971fcab1c248..0ffcc613a4b2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -139,19 +139,21 @@ void otx2_get_stats64(struct net_device *netdev,
>  		      struct rtnl_link_stats64 *stats)
>  {
>  	struct otx2_nic *pfvf = netdev_priv(netdev);
> -	struct otx2_dev_stats *dev_stats;
> +	struct otx2_dev_stats *dev_stats, *old_stats;
>  
>  	otx2_get_dev_stats(pfvf);
>  
>  	dev_stats = &pfvf->hw.dev_stats;
> -	stats->rx_bytes = dev_stats->rx_bytes;
> -	stats->rx_packets = dev_stats->rx_frames;
> -	stats->rx_dropped = dev_stats->rx_drops;
> -	stats->multicast = dev_stats->rx_mcast_frames;
> -
> -	stats->tx_bytes = dev_stats->tx_bytes;
> -	stats->tx_packets = dev_stats->tx_frames;
> -	stats->tx_dropped = dev_stats->tx_drops;
> +	old_stats = &pfvf->hw.old_stats;
> +
> +	stats->rx_bytes = old_stats->rx_bytes + dev_stats->rx_bytes;
> +	stats->rx_packets = old_stats->rx_frames + dev_stats->rx_frames;
> +	stats->rx_dropped = old_stats->rx_drops + dev_stats->rx_drops;
> +	stats->multicast = old_stats->rx_mcast_frames + dev_stats->rx_mcast_frames;
> +
> +	stats->tx_bytes = old_stats->tx_bytes + dev_stats->tx_bytes;
> +	stats->tx_packets = old_stats->tx_frames + dev_stats->tx_frames;
> +	stats->tx_dropped = old_stats->tx_drops + dev_stats->tx_drops;
>  }
>  EXPORT_SYMBOL(otx2_get_stats64);
>  
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index eecee612b7b2..ad65aa19b80d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -255,6 +255,7 @@ struct otx2_hw {
>  
>  	/* Stats */
>  	struct otx2_dev_stats	dev_stats;
> +	struct otx2_dev_stats	old_stats;
>  	struct otx2_drv_stats	drv_stats;
>  	u64			cgx_rx_stats[CGX_RX_STATS_COUNT];
>  	u64			cgx_tx_stats[CGX_TX_STATS_COUNT];
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index ee623476e5ff..9606c8cb8c82 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2158,10 +2158,28 @@ int otx2_stop(struct net_device *netdev)
>  	struct otx2_qset *qset = &pf->qset;
>  	int qidx, vec, wrk;
>  
> +	struct otx2_dev_stats *dev = &pf->hw.dev_stats;
> +	struct otx2_dev_stats *old_stats = &pf->hw.old_stats;

Please format your code according to kernel coding style.

>  	/* If the DOWN flag is set resources are already freed */
>  	if (pf->flags & OTX2_FLAG_INTF_DOWN)
>  		return 0;
>  
> +	/* Accumulate old stats */
> +	old_stats->rx_bytes     += dev->rx_bytes;
> +	old_stats->rx_drops     += dev->rx_drops;
> +	old_stats->rx_bcast_frames      += dev->rx_bcast_frames;
> +	old_stats->rx_mcast_frames      += dev->rx_mcast_frames;
> +	old_stats->rx_ucast_frames      += dev->rx_ucast_frames;
> +	old_stats->rx_frames            += dev->rx_frames;
> +
> +	old_stats->tx_bytes             += dev->tx_bytes;
> +	old_stats->tx_drops             += dev->tx_drops;
> +	old_stats->tx_bcast_frames      += dev->tx_bcast_frames;
> +	old_stats->tx_mcast_frames      += dev->tx_mcast_frames;
> +	old_stats->tx_ucast_frames      += dev->tx_ucast_frames;
> +	old_stats->tx_frames            += dev->tx_frames;
> +
>  	netif_carrier_off(netdev);
>  	netif_tx_stop_all_queues(netdev);
>  


