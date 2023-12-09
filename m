Return-Path: <netdev+bounces-55518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D9480B19B
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 02:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BE32818BB
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227D980F;
	Sat,  9 Dec 2023 01:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVF81oN5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07917F8;
	Sat,  9 Dec 2023 01:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21BCC433C8;
	Sat,  9 Dec 2023 01:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702087025;
	bh=kVKeeuFA6aLVpPCgtOqP/HqEH7kYw9itbYOfMzQSBwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tVF81oN5HLlxyCEIxrU+M3UU6WgIi5zsIZF2e4wRoTU+eHaoahVFLsB7mG0wRlfAh
	 X1cOwF7d0yzbueQofpI4n9M+QYMYLdcrWGqls1nykvGAniIs7ladiE5NTMecFXy2zy
	 cquOK5gr8MGV8fiBKco5nvDsPLkpTBjIcmqhqF6nvGNiXQoNcIvJc2itWq3olxe946
	 6pUlxm5vTg7Ba3zCGDe7LN0QWIswVaCzS/Cv94lZyCb6wimh6DOc/SSza/3Hj0MyFc
	 1dy2RREQ3LrucONKz2lsugoBxE0/vdFew6xzmKYB6RbmpKJWWzZPgB8W5bnFRbyt8c
	 3Hixw1MVY5EKA==
Date: Fri, 8 Dec 2023 17:57:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 corbet@lwn.net, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org,
 mkubecek@suse.cz, willemdebruijn.kernel@gmail.com, gal@nvidia.com,
 alexander.duyck@gmail.com, ecree.xilinx@gmail.com,
 linux-doc@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v8 1/8] net: ethtool: pass a pointer to
 parameters to get/set_rxfh ethtool ops
Message-ID: <20231208175703.3970d1de@kernel.org>
In-Reply-To: <20231206233642.447794-2-ahmed.zaki@intel.com>
References: <20231206233642.447794-1-ahmed.zaki@intel.com>
	<20231206233642.447794-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 16:36:35 -0700 Ahmed Zaki wrote:
> -	rxfh.indir_size = dev_indir_size;
> -	rxfh.key_size = dev_key_size;
> +	rxfh.indir_size = rxfh_dev.indir_size;
> +	rxfh.key_size = rxfh_dev.key_size;
>  	if (copy_to_user(useraddr, &rxfh, sizeof(rxfh)))
>  		return -EFAULT;
>  
> -	if ((user_indir_size && (user_indir_size != dev_indir_size)) ||
> -	    (user_key_size && (user_key_size != dev_key_size)))
> +	if ((user_indir_size && user_indir_size != rxfh_dev.indir_size) ||
> +	    (user_key_size && user_key_size != rxfh_dev.key_size))
>  		return -EINVAL;
>  
> -	indir_bytes = user_indir_size * sizeof(indir[0]);
> -	total_size = indir_bytes + user_key_size;
> -	rss_config = kzalloc(total_size, GFP_USER);
> -	if (!rss_config)
> -		return -ENOMEM;
> -
> -	if (user_indir_size)
> -		indir = (u32 *)rss_config;
> +	indir_bytes = user_indir_size * sizeof(*rxfh_dev.indir);
> +	if (indir_bytes) {
> +		rxfh_dev.indir = kzalloc(indir_bytes, GFP_KERNEL);
> +		if (!rxfh_dev.indir)
> +			return -ENOMEM;
> +	}
>  
> -	if (user_key_size)
> -		hkey = rss_config + indir_bytes;
> +	if (user_key_size) {
> +		rxfh_dev.key = kzalloc(user_key_size, GFP_KERNEL);
> +		if (!rxfh_dev.key) {
> +			kfree(rxfh_dev.indir);
> +			return -ENOMEM;
> +		}
> +	}

Splitting the allocation into two separate kzalloc()s should be 
a separate change.

> +struct ethtool_rxfh_param {
> +	__u8	hfunc;
> +	__u32   indir_size;
> +	__u32	*indir;
> +	__u32   key_size;
> +	__u8	*key;
> +};

no underscores needed on types, this is a kernel struct

