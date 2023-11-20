Return-Path: <netdev+bounces-49154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4607F0F45
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C823B20EF5
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024C51173A;
	Mon, 20 Nov 2023 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo8sj5T0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897311724
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 09:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC75BC433C8;
	Mon, 20 Nov 2023 09:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700473405;
	bh=XdbbEndgrLLgoOL0YAb8kaKsEQaXmiCPqQaN1nt7NGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mo8sj5T08LBbZ4Od5m/q0gS5FThloO4jdDSxzCAacd0KQI3eBIkozMCXfZWqgapCk
	 OGikAOlXQPB+WoXc893g3DVm/HJBdu70seUwPpOmW8xkZP0LVFjq5s2E1pKepbhVNv
	 e67/dPTRWZqAcfnxHlRrjTE5VRebCEZJkDT/X9hRgZcvZ9ywFxtBpfgifQm4yzP1QA
	 DogsMfjgdeL71fMTc4a5hbcdMPuB2z/I9iMwNDYQHVsRdX5Pk+a6Xt6o1xJWVyaZqj
	 j/cYDefFEhlemu9NC0xSUHJIR6rYs2W74vKe5uF5T1BdY3UyOIWzKrGqjJkQHadr7L
	 ZOuOrVbXQ/9/A==
Date: Mon, 20 Nov 2023 09:43:21 +0000
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net-next 1/2] nfp: add ethtool flow steering callbacks
Message-ID: <20231120094321.GK186930@vergenet.net>
References: <20231117071114.10667-1-louis.peens@corigine.com>
 <20231117071114.10667-2-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117071114.10667-2-louis.peens@corigine.com>

On Fri, Nov 17, 2023 at 09:11:13AM +0200, Louis Peens wrote:
> From: Yinjun Zhang <yinjun.zhang@corigine.com>
> 
> This is the first part to implement flow steering. The communication
> between ethtool and driver is done. User can use following commands
> to display and set flows:
> 
> ethtool -n <netdev>
> ethtool -N <netdev> flow-type ...
> 
> Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Thanks Yinjun and Louis,

The minor suggestion provided inline not withstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> index e75cbb287625..d7896391b8ba 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> @@ -1317,6 +1317,116 @@ static int nfp_net_get_rss_hash_opts(struct nfp_net *nn,
>  	return 0;
>  }
>  
> +#define NFP_FS_MAX_ENTRY	1024
> +
> +static int nfp_net_fs_to_ethtool(struct nfp_fs_entry *entry, struct ethtool_rxnfc *cmd)
> +{
> +	struct ethtool_rx_flow_spec *fs = &cmd->fs;
> +	unsigned int i;
> +
> +	switch (entry->flow_type & ~FLOW_RSS) {
> +	case TCP_V4_FLOW:
> +	case UDP_V4_FLOW:
> +	case SCTP_V4_FLOW:
> +		fs->h_u.tcp_ip4_spec.ip4src = entry->key.sip4;
> +		fs->h_u.tcp_ip4_spec.ip4dst = entry->key.dip4;
> +		fs->h_u.tcp_ip4_spec.psrc   = entry->key.sport;
> +		fs->h_u.tcp_ip4_spec.pdst   = entry->key.dport;
> +		fs->m_u.tcp_ip4_spec.ip4src = entry->msk.sip4;
> +		fs->m_u.tcp_ip4_spec.ip4dst = entry->msk.dip4;
> +		fs->m_u.tcp_ip4_spec.psrc   = entry->msk.sport;
> +		fs->m_u.tcp_ip4_spec.pdst   = entry->msk.dport;
> +		break;
> +	case TCP_V6_FLOW:
> +	case UDP_V6_FLOW:
> +	case SCTP_V6_FLOW:
> +		for (i = 0; i < 4; i++) {
> +			fs->h_u.tcp_ip6_spec.ip6src[i] = entry->key.sip6[i];
> +			fs->h_u.tcp_ip6_spec.ip6dst[i] = entry->key.dip6[i];
> +			fs->m_u.tcp_ip6_spec.ip6src[i] = entry->msk.sip6[i];
> +			fs->m_u.tcp_ip6_spec.ip6dst[i] = entry->msk.dip6[i];
> +		}

I think the above loop can be more succinctly be expressed using a single
memcpy(). For which I do see precedence in Intel drivers. Likewise
elsewhere in this patch-set.

I don't feel strongly about this, so feel free to take this suggestion,
defer it to later, or dismiss it entirely.

> +		fs->h_u.tcp_ip6_spec.psrc = entry->key.sport;
> +		fs->h_u.tcp_ip6_spec.pdst = entry->key.dport;
> +		fs->m_u.tcp_ip6_spec.psrc = entry->msk.sport;
> +		fs->m_u.tcp_ip6_spec.pdst = entry->msk.dport;
> +		break;

...

