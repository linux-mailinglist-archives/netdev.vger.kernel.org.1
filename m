Return-Path: <netdev+bounces-44351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE887D7A0F
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 03:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E867B281DD6
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD773440B;
	Thu, 26 Oct 2023 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKJUM1mT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C415C3
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCB8C433C7;
	Thu, 26 Oct 2023 01:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698283221;
	bh=oEyNCBupUj8ri78oGoUDn8YLrYhM+n0Gcd6NXAx5dBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uKJUM1mTFDIbyiir6pzCrv/gXcL2IYSl8T5USQpgCRcwFDROKyyPwMl4n0dAXRr9h
	 Rrlcpg1YDeKAZRJqQbUVfTlfrfgakUcNgpRzmcWrAagRcDUVJA6uqcS6DcBF3yawuF
	 tINo3PwIa8z1bLmdL1y/tRegHYYBETyJbaduAJwa+Qys+h+37hDF0zvzf2gakyGGkC
	 G+kAKuynDKnC+ZEk2F3pNMQAcCpFBl/ZqPmk7ycT6BNN76bMZ3syWJm9o83zpO8lB/
	 piOVaN7Ov/ZQKl2kuewb6pXrjE/cPip74N3z8MF37GPAVNUTL9dVS84lN7d5pt2nJt
	 bma15X6qR+ekQ==
Date: Wed, 25 Oct 2023 18:20:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alce Lafranque <alce@lafranque.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, Vincent Bernat <vincent@bernat.ch>
Subject: Re: [PATCH net-next v7] vxlan: add support for flowlabel inherit
Message-ID: <20231025182019.1cf5ab0d@kernel.org>
In-Reply-To: <20231024165028.251294-1-alce@lafranque.net>
References: <20231024165028.251294-1-alce@lafranque.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 11:50:28 -0500 Alce Lafranque wrote:
> +	if (data[IFLA_VXLAN_LABEL_POLICY])
> +		conf->label_policy = nla_get_u8(data[IFLA_VXLAN_LABEL_POLICY]);
>  
>  	if (data[IFLA_VXLAN_LEARNING]) {
>  		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LEARNING,
> @@ -4398,6 +4417,7 @@ static size_t vxlan_get_size(const struct net_device *dev)
>  		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TOS */
>  		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_DF */
>  		nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
> +		nla_total_size(sizeof(__u8)) +  /* IFLA_VXLAN_LABEL_POLICY */
>  		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_LEARNING */
>  		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_PROXY */
>  		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_RSC */
> @@ -4470,6 +4490,7 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
>  	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
>  	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
> +	    nla_put_u8(skb, IFLA_VXLAN_LABEL_POLICY, vxlan->cfg.label_policy) ||
>  	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
>  		       !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
>  	    nla_put_u8(skb, IFLA_VXLAN_PROXY,

nit: please don't use u8 in netlink, unless it's a fixed-size protocol
field. Attr len is rounded up to 4, see NLA_ALIGN(). You can as well
make it u32.    

> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index 6a9f8a5f387c..33ba6fc151cf 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h
> @@ -210,22 +210,23 @@ struct vxlan_rdst {
>  };
>  
>  struct vxlan_config {
> -	union vxlan_addr	remote_ip;
> -	union vxlan_addr	saddr;
> -	__be32			vni;
> -	int			remote_ifindex;
> -	int			mtu;
> -	__be16			dst_port;
> -	u16			port_min;
> -	u16			port_max;
> -	u8			tos;
> -	u8			ttl;
> -	__be32			label;
> -	u32			flags;
> -	unsigned long		age_interval;
> -	unsigned int		addrmax;
> -	bool			no_share;
> -	enum ifla_vxlan_df	df;
> +	union vxlan_addr		remote_ip;
> +	union vxlan_addr		saddr;
> +	__be32				vni;
> +	int				remote_ifindex;
> +	int				mtu;
> +	__be16				dst_port;
> +	u16				port_min;
> +	u16				port_max;
> +	u8				tos;
> +	u8				ttl;
> +	__be32				label;
> +	enum ifla_vxlan_label_policy	label_policy;

Here, OTOH, you could save some space, by making it a u8.

> +	u32				flags;
> +	unsigned long			age_interval;
> +	unsigned int			addrmax;
> +	bool				no_share;
> +	enum ifla_vxlan_df		df;
>  };


