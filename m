Return-Path: <netdev+bounces-37365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C898B7B502D
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7B48E2835C4
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E91D530;
	Mon,  2 Oct 2023 10:23:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62142C2E3
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:23:08 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F51D9B
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 03:23:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9adca291f99so2234233766b.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 03:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696242185; x=1696846985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSCPBmb5rAGnIKcNr1a66nlrBQ158XrBaGIn8DLnEIg=;
        b=M2smoocQ6wgz9AeJycDOBEWTqDkXiI/fq/GsEKaY8R24PeuoH9WsuZizLeKHjvMozb
         a0W8T3+w3NaYGtm42s7cfK5cje1e7wDSI93C1xQE5NNoBbs17lXVnZu78a1akNx50R5I
         0D3gY0eDGMC+nWpwdrW7FHN/msUqskNeqXqZyq0hYnLc9XZ6gVzXnRfMXwxEEL23X+No
         TYGOrax3pmWA9NayoAvErnvvnE481a1V+/K3/XtjbheOMLAFyzGhpdhVscTOrw/VvD9C
         J2imqGxzKwcL0owWSkBj3/3v/HA0k1FJszd1KPcskNKKYTgsx+3WVYo9RTAH3h9pftjX
         68Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696242185; x=1696846985;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSCPBmb5rAGnIKcNr1a66nlrBQ158XrBaGIn8DLnEIg=;
        b=n+MvmJKVr+RdJW5TnKiORluDJ4J36fjdNjqVWXUOr06EtG2ht3JkT458ZfQXC7ZGkz
         06md7rvbIRT8vGkxolocrYBuN8r0A5gvjBJGezj/Uac/OER5yoI4D9u16s4qYm0GmVbx
         uCCpt81r1YTQLptLV7sk81u4vbTR+hrOTTyNkQTzQCug5LEoTe7WqKtu4RMNEeFgJkLC
         oVnZJsb+D1dBtzEg0sSQX89UJyietL1BVWZeqJmpwCc39fQpM7CNVTFTTjs/zc4EyaaB
         mK7pw9f7jbrbiNwmb+QwLAxd1ZD3EGcfPTjUuv03TfRIdI2A+1reUdmYCmnzQrXi++/O
         Cn2w==
X-Gm-Message-State: AOJu0YwmXotfe2U6+lMAsaEaKjTCFnggGKsmWJQn69G4d53bTx4yFL+3
	5ZhId0U/5QTYoZ4OYaVypkY=
X-Google-Smtp-Source: AGHT+IGk8sFNXgbNOkosSWRHbrctxs7KDHFWlwLb3v9dNAjeFrUQf0G8Jc1fEwvZGlqkyt37uJbtjA==
X-Received: by 2002:a17:907:7804:b0:9b2:7657:879f with SMTP id la4-20020a170907780400b009b27657879fmr9524764ejc.32.1696242184466;
        Mon, 02 Oct 2023 03:23:04 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id y13-20020a05600c364d00b003fc0505be19sm6903039wmq.37.2023.10.02.03.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 03:23:03 -0700 (PDT)
Date: Mon, 2 Oct 2023 11:23:02 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	sudheer.mogilappagari@intel.com, jdamato@fastly.com, andrew@lunn.ch,
	mw@semihalf.com, linux@armlinux.org.uk, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	saeedm@nvidia.com, leon@kernel.org
Subject: Re: [PATCH v4 net-next 2/7] net: ethtool: attach an XArray of custom
 RSS contexts to a netdevice
Message-ID: <20231002102302.GB21694@gmail.com>
Mail-Followup-To: edward.cree@amd.com, linux-net-drivers@amd.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, sudheer.mogilappagari@intel.com,
	jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com,
	linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com,
	leon@kernel.org
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 07:13:33PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Each context stores the RXFH settings (indir, key, and hfunc) as well
>  as optionally some driver private data.
> Delete any still-existing contexts at netdev unregister time.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  include/linux/ethtool.h | 43 ++++++++++++++++++++++++++++++++++++++++-
>  net/core/dev.c          | 25 ++++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 8aeefc0b4e10..bb11cb2f477d 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -157,6 +157,43 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
>  	return index % n_rx_rings;
>  }
>  
> +/**
> + * struct ethtool_rxfh_context - a custom RSS context configuration
> + * @indir_size: Number of u32 entries in indirection table
> + * @key_size: Size of hash key, in bytes
> + * @hfunc: RSS hash function identifier.  One of the %ETH_RSS_HASH_*
> + * @priv_size: Size of driver private data, in bytes
> + * @indir_no_change: indir was not specified at create time
> + * @key_no_change: hkey was not specified at create time
> + */
> +struct ethtool_rxfh_context {
> +	u32 indir_size;
> +	u32 key_size;
> +	u8 hfunc;
> +	u16 priv_size;
> +	u8 indir_no_change:1;
> +	u8 key_no_change:1;

On 32-bit architectures this has a hole after hfunc and 3 empty bytes here.
Move these 2 1-bit fields before priv_size to avoid that.

Martin

> +	/* private: driver private data, indirection table, and hash key are
> +	 * stored sequentially in @data area.  Use below helpers to access.
> +	 */
> +	u8 data[] __aligned(sizeof(void *));
> +};
> +
> +static inline void *ethtool_rxfh_context_priv(struct ethtool_rxfh_context *ctx)
> +{
> +	return ctx->data;
> +}
> +
> +static inline u32 *ethtool_rxfh_context_indir(struct ethtool_rxfh_context *ctx)
> +{
> +	return (u32 *)(ctx->data + ALIGN(ctx->priv_size, sizeof(u32)));
> +}
> +
> +static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
> +{
> +	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
> +}
> +
>  /* declare a link mode bitmap */
>  #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
>  	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
> @@ -937,10 +974,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
>  
>  /**
>   * struct ethtool_netdev_state - per-netdevice state for ethtool features
> + * @rss_ctx:		XArray of custom RSS contexts
> + * @rss_ctx_max_id:	maximum (exclusive) supported RSS context ID
>   * @wol_enabled:	Wake-on-LAN is enabled
>   */
>  struct ethtool_netdev_state {
> -	unsigned		wol_enabled:1;
> +	struct xarray		rss_ctx;
> +	u32			rss_ctx_max_id;
> +	u32			wol_enabled:1;
>  };
>  
>  struct phy_device;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9e85a71e33ed..05e95abdfd17 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10072,6 +10072,9 @@ int register_netdevice(struct net_device *dev)
>  	if (ret)
>  		return ret;
>  
> +	/* rss ctx ID 0 is reserved for the default context, start from 1 */
> +	xa_init_flags(&dev->ethtool->rss_ctx, XA_FLAGS_ALLOC1);
> +
>  	spin_lock_init(&dev->addr_list_lock);
>  	netdev_set_addr_lockdep_class(dev);
>  
> @@ -10874,6 +10877,26 @@ void synchronize_net(void)
>  }
>  EXPORT_SYMBOL(synchronize_net);
>  
> +static void netdev_rss_contexts_free(struct net_device *dev)
> +{
> +	struct ethtool_rxfh_context *ctx;
> +	unsigned long context;
> +
> +	if (dev->ethtool_ops->set_rxfh_context)
> +		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
> +			u32 *indir = ethtool_rxfh_context_indir(ctx);
> +			u8 *key = ethtool_rxfh_context_key(ctx);
> +			u32 concast = context;
> +
> +			xa_erase(&dev->ethtool->rss_ctx, context);
> +			dev->ethtool_ops->set_rxfh_context(dev, indir, key,
> +							   ctx->hfunc, &concast,
> +							   true);
> +			kfree(ctx);
> +		}
> +	xa_destroy(&dev->ethtool->rss_ctx);
> +}
> +
>  /**
>   *	unregister_netdevice_queue - remove device from the kernel
>   *	@dev: device
> @@ -10978,6 +11001,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
>  		netdev_name_node_alt_flush(dev);
>  		netdev_name_node_free(dev->name_node);
>  
> +		netdev_rss_contexts_free(dev);
> +
>  		call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
>  
>  		if (dev->netdev_ops->ndo_uninit)

