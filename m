Return-Path: <netdev+bounces-139936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 940849B4B90
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB821F22A1B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84FB206965;
	Tue, 29 Oct 2024 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCR6xciX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE5205132;
	Tue, 29 Oct 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210308; cv=none; b=U3K1xhG/cnAepwja+/AliKSCStGWfTi5Chrlqx4AhGcZ4UTQHh+1sR/gqhRAWK+jszJVOD/Z9tZQHuMeisc+HaOtW2QhNFtUsD8mM5vBGAj318v6sg+nN8zllxw5rNdB1lc9N/uTSc25Ia5ievxli6slAORbONABABpp1qBn8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210308; c=relaxed/simple;
	bh=vktD3GCLEQAMtQOzwOy/IRI7jk8/690oaYIIDrmfHZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmgDrNvA2UJMJUJtX6DUb3IXgRdOyQ+wp7dtZtgGz3muUeMW5sbH6at9KRpVPwfGZstc/cfJRkhxnmxWQHsTPrJhcN5HV9yEivfeSWrhSVg7gnPW0tIB3boYXRoY4+wuzexXZL0QXnBJhbvLyPS9LmS0KNzdpqaFwdBTPmh4PAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCR6xciX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9182CC4CECD;
	Tue, 29 Oct 2024 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730210306;
	bh=vktD3GCLEQAMtQOzwOy/IRI7jk8/690oaYIIDrmfHZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vCR6xciXAjtCf4uI69SdztBKpQ+3iTjlDKkNBe7eqBsFJgNXRVbqjHaGQnanWO+Q/
	 0SSfLWntmcwrWPl7cQo8VXJB9enIvRHSYz0WL0Uc5y67h0lcvN0guLgWDVeDqTuhCw
	 /uCcKXti/6kglCcwRCtuYPf0U1JSvwhSr9/9sqIbkSdN8Sc23gdfRFx1vCLLidPXmm
	 7ikFxKSyIV1Ir+u7KI4Ors9VA5Zx1zRCccTCGWL+zGMrvEQZJ6k74nOhwt6B9/W6TZ
	 eRjRBR5jnX25da9eDunnKGYUryq/g7ohz5cKc/ZlWABNBoLOY/1SJbck3RDCTMbVm7
	 wiFoTOcNH2ZVQ==
Date: Tue, 29 Oct 2024 06:58:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Potnuri
 Bharat Teja <bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Manish Chopra <manishc@marvell.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241029065824.670f14fc@kernel.org>
In-Reply-To: <f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
References: <cover.1729536776.git.gustavoars@kernel.org>
	<f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 13:02:27 -0600 Gustavo A. R. Silva wrote:
> @@ -3025,7 +3025,7 @@ static int bnxt_set_link_ksettings(struct net_device *dev,
>  {
>  	struct bnxt *bp = netdev_priv(dev);
>  	struct bnxt_link_info *link_info = &bp->link_info;
> -	const struct ethtool_link_settings *base = &lk_ksettings->base;
> +	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;

Please improve the variable ordering while at it. Longest list first,
so move the @base definition first.

>  	bool set_pause = false;
>  	u32 speed, lanes = 0;
>  	int rc = 0;
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> index 7f3f5afa864f..cc43294bdc96 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> @@ -663,7 +663,7 @@ static int get_link_ksettings(struct net_device *dev,
>  			      struct ethtool_link_ksettings *link_ksettings)
>  {
>  	struct port_info *pi = netdev_priv(dev);
> -	struct ethtool_link_settings *base = &link_ksettings->base;
> +	struct ethtool_link_settings_hdr *base = &link_ksettings->base;

ditto

>  	/* For the nonce, the Firmware doesn't send up Port State changes
>  	 * when the Virtual Interface attached to the Port is down.  So
> @@ -719,7 +719,7 @@ static int set_link_ksettings(struct net_device *dev,
>  {
>  	struct port_info *pi = netdev_priv(dev);
>  	struct link_config *lc = &pi->link_cfg;
> -	const struct ethtool_link_settings *base = &link_ksettings->base;
> +	const struct ethtool_link_settings_hdr *base = &link_ksettings->base;

and here

>  	struct link_config old_lc;
>  	unsigned int fw_caps;
>  	int ret = 0;
> diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
> index 2fbe0f059a0b..0d85ac342ac7 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
> @@ -1437,7 +1437,7 @@ static int cxgb4vf_get_link_ksettings(struct net_device *dev,
>  				  struct ethtool_link_ksettings *link_ksettings)
>  {
>  	struct port_info *pi = netdev_priv(dev);
> -	struct ethtool_link_settings *base = &link_ksettings->base;
> +	struct ethtool_link_settings_hdr *base = &link_ksettings->base;

and here

>  	/* For the nonce, the Firmware doesn't send up Port State changes
>  	 * when the Virtual Interface attached to the Port is down.  So
> diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
> index f7986f2b6a17..8670eb394fad 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
> @@ -130,7 +130,7 @@ static int enic_get_ksettings(struct net_device *netdev,
>  			      struct ethtool_link_ksettings *ecmd)
>  {
>  	struct enic *enic = netdev_priv(netdev);
> -	struct ethtool_link_settings *base = &ecmd->base;
> +	struct ethtool_link_settings_hdr *base = &ecmd->base;

and here

>  	ethtool_link_ksettings_add_link_mode(ecmd, supported,
>  					     10000baseT_Full);

> @@ -62,7 +62,7 @@ static int linkmodes_reply_size(const struct ethnl_req_info *req_base,
>  {
>  	const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
>  	const struct ethtool_link_ksettings *ksettings = &data->ksettings;
> -	const struct ethtool_link_settings *lsettings = &ksettings->base;
> +	const struct ethtool_link_settings_hdr *lsettings = &ksettings->base;

here it was correct and now its not

>  	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
>  	int len, ret;
>  
> @@ -103,7 +103,7 @@ static int linkmodes_fill_reply(struct sk_buff *skb,
>  {
>  	const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
>  	const struct ethtool_link_ksettings *ksettings = &data->ksettings;
> -	const struct ethtool_link_settings *lsettings = &ksettings->base;
> +	const struct ethtool_link_settings_hdr *lsettings = &ksettings->base;

same

>  	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
>  	int ret;

