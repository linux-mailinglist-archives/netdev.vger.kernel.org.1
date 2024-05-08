Return-Path: <netdev+bounces-94410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1838BF631
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A58FB23CEB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 06:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C7B1E532;
	Wed,  8 May 2024 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KlXjzmhV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353318028
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149469; cv=none; b=D2yGCWa1g055SG3w0GNw0T6ty711ADBrCdONk1vJrLepq+v5fwxp0mKm06PqjS9hztFMROHAvyYKr2vgiFr7h1HjNiqfYN+GKB/Fl/yFM3KtC+YW6GOITE/D4d8zm/Y41YAMHZXSXbkwNW4ykmkCb8HAe2OwRak5GDWNAWLpFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149469; c=relaxed/simple;
	bh=Wbp/AwpYX7upSdItvbQvzSbsVzx+kiC3OXh+8FAuSNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aro1JDDn7/dTVloef8nrgLC8AorB0krIxmtFlzhJ0a9ueLN5QYnYVkpkt8p6IB4GxEi93pLirwbJ9qyspLeLlWQP0EpAF/dyjhXHLeEzLOrjrBd7bXIpIXUN6xqecnSzAkBDOL1boeKRoQQGnexkukweHwnhZiWUvAsug6ovRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=KlXjzmhV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f4178aec15so3405210b3a.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 23:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1715149466; x=1715754266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AMnUX2YT8tVUEAbF8ZHvccX5Ts1C30c2UFvuj96f0g=;
        b=KlXjzmhVH/f4EvQU1AmSYj6bqYj5yH5RyxYbtmpPej0Cyt38+71380D8fxrr28d17g
         vaTN9hRmkFiF1SEPWy41KJmfagnYUII5n4beThlzBpJEahopJGfgisKNoiEefPGR4g+i
         wUJUg2K2GelFRJKGVlwx+eSdjd5HfVa6aadGQsaHdTduZxkNAzurKp9VwNodDo1tH70r
         9LYK0m0xZakBYXkIBb4hFK6Vmgea+5f6JnSAwe8ji1OhywgObLJs/gTWwYvqa5i/xcP4
         zK0Zzv6uPOvv0MNW8U8eGjBG2zjwvJS1V642r3zHm7rVsrKs/fM+s36+lW899J1sB2IZ
         4B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149466; x=1715754266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AMnUX2YT8tVUEAbF8ZHvccX5Ts1C30c2UFvuj96f0g=;
        b=IQ4NKKA42J6raC0mkUmQRm105fn+O1VNWytgnvQ7El0awJ06Nibca3fEZ62Nu4aJ7F
         CmkX7FN5hvehmiWqKymri4GbFOumiPO8jDP1+QXtRycNgfTmL0LqGLV6WeafBzsU3l4f
         YuNE9ht9B4836HlvZlNbaTQ2MSz9ybCsmkgmdc0Dqd2io1BoRCXOsZkqtRaCzEmS24ka
         p8aIMbplSGI7a/sEoOHwyOJ28BqcrrIbHh/1m93U0tkHmDiZIfF/PRK/KkZ+LTVpgoU3
         l94MVrw5DSUAV5lh+7EtDhM2Epndt5qN4+KVPi0PO/4NKLsVQNiFJ7/oqTypBeqK87n0
         wEkA==
X-Forwarded-Encrypted: i=1; AJvYcCVrrM0+5L104x2MFsShqKweFgTnE+AnthJFkyl1eOIM6LoPu0+0aI+PM8wlFDJKZ3QRaRYP6xuqwQZ8IV0hXSC9B+VssaNR
X-Gm-Message-State: AOJu0Yxv+B/8BUraOdVHl3fB7c3VYa5vAGx7EEa6h4G9r0/N2GWP/4ZJ
	vMG9GRg1aVqAr5W0LUDACVwTAlKHdSys9gTg6Z+YdWomO6rD4ImBcFUsDFlepc0=
X-Google-Smtp-Source: AGHT+IFKtuIy0MMo+ZTLC8DLfMyEyh3LVwYqAPgsF/g9T/sWdoau4q7NDRx6r5JXztoeP2WJOR7w4g==
X-Received: by 2002:a62:81c3:0:b0:6ed:973d:936 with SMTP id d2e1a72fcca58-6f49c20e816mr1717394b3a.9.1715149465878;
        Tue, 07 May 2024 23:24:25 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id u4-20020a056a00124400b006edceb4ea9dsm10448566pfi.166.2024.05.07.23.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 23:24:25 -0700 (PDT)
Message-ID: <a75ca51c-89b1-4f90-be52-e5fb71ca519a@davidwei.uk>
Date: Tue, 7 May 2024 23:24:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] gve: Add flow steering adminq commands
Content-Language: en-GB
To: Ziwei Xiao <ziweixiao@google.com>, netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, hramamurthy@google.com,
 rushilg@google.com, jfraker@google.com, linux-kernel@vger.kernel.org
References: <20240507225945.1408516-1-ziweixiao@google.com>
 <20240507225945.1408516-5-ziweixiao@google.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240507225945.1408516-5-ziweixiao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-07 15:59, Ziwei Xiao wrote:
> From: Jeroen de Borst <jeroendb@google.com>
> 
> Adding new adminq commands for the driver to configure and query flow
> rules that are stored in the device. Flow steering rules are assigned
> with a location that determines the relative order of the rules.
> 
> Flow rules can run up to an order of millions. In such cases, storing
> a full copy of the rules in the driver to prepare for the ethtool query
> is infeasible while querying them from the device is better. That needs
> to be optimized too so that we don't send a lot of adminq commands. The
> solution here is to store a limited number of rules/rule ids in the
> driver in a cache. This patch uses dma_pool to allocate 4k bytes which
> lets device write at most 46 flow rules(4k/88) or 1k rule ids(4096/4)
> at a time.
> 
> For configuring flow rules, there are 3 sub-commands:
> - ADD which adds a rule at the location supplied
> - DEL which deletes the rule at the location supplied
> - RESET which clears all currently active rules in the device
> 
> For querying flow rules, there are also 3 sub-commands:
> - QUERY_RULES corresponds to ETHTOOL_GRXCLSRULE. It fills the rules in
>   the allocated cache after querying the device
> - QUERY_RULES_IDS corresponds to ETHTOOL_GRXCLSRLALL. It fills the
>   rule_ids in the allocated cache after querying the device
> - QUERY_RULES_STATS corresponds to ETHTOOL_GRXCLSRLCNT. It queries the
>   device's current flow rule number and the supported max flow rule
>   limit
> 
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h         |  42 ++++++
>  drivers/net/ethernet/google/gve/gve_adminq.c  | 133 ++++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_adminq.h  |  75 ++++++++++
>  drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
>  drivers/net/ethernet/google/gve/gve_main.c    |  54 ++++++-
>  5 files changed, 307 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 58213c15e084..355ae797eacf 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -60,6 +60,10 @@
>  
>  #define GVE_DEFAULT_RX_BUFFER_OFFSET 2048
>  
> +#define GVE_FLOW_RULES_CACHE_SIZE (GVE_ADMINQ_BUFFER_SIZE / sizeof(struct gve_flow_rule))
> +#define GVE_FLOW_RULE_IDS_CACHE_SIZE \
> +	(GVE_ADMINQ_BUFFER_SIZE / sizeof(((struct gve_flow_rule *)0)->location))
> +
>  #define GVE_XDP_ACTIONS 5
>  
>  #define GVE_GQ_TX_MIN_PKT_DESC_BYTES 182
> @@ -678,6 +682,39 @@ enum gve_queue_format {
>  	GVE_DQO_QPL_FORMAT		= 0x4,
>  };
>  
> +struct gve_flow_spec {
> +	__be32 src_ip[4];
> +	__be32 dst_ip[4];
> +	union {
> +		struct {
> +			__be16 src_port;
> +			__be16 dst_port;
> +		};
> +		__be32 spi;
> +	};
> +	union {
> +		u8 tos;
> +		u8 tclass;
> +	};
> +};
> +
> +struct gve_flow_rule {
> +	u32 location;
> +	u16 flow_type;
> +	u16 action;
> +	struct gve_flow_spec key;
> +	struct gve_flow_spec mask;
> +};
> +
> +struct gve_flow_rules_cache {
> +	bool rules_cache_synced; /* False if the driver's rules_cache is outdated */
> +	struct gve_flow_rule *rules_cache;
> +	u32 *rule_ids_cache;
> +	/* The total number of queried rules that stored in the caches */
> +	u32 rules_cache_num;
> +	u32 rule_ids_cache_num;
> +};
> +
>  struct gve_priv {
>  	struct net_device *dev;
>  	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> @@ -744,6 +781,8 @@ struct gve_priv {
>  	u32 adminq_report_link_speed_cnt;
>  	u32 adminq_get_ptype_map_cnt;
>  	u32 adminq_verify_driver_compatibility_cnt;
> +	u32 adminq_query_flow_rules_cnt;
> +	u32 adminq_cfg_flow_rule_cnt;
>  
>  	/* Global stats */
>  	u32 interface_up_cnt; /* count of times interface turned up since last reset */
> @@ -788,6 +827,9 @@ struct gve_priv {
>  	bool header_split_enabled; /* True if the header split is enabled by the user */
>  
>  	u32 max_flow_rules;
> +	u32 num_flow_rules; /* Current number of flow rules registered in the device */
> +
> +	struct gve_flow_rules_cache flow_rules_cache;
>  };
>  
>  enum gve_service_task_flags_bit {
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 85d0d742ad21..7a929e20cf96 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -287,6 +287,8 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
>  	priv->adminq_report_stats_cnt = 0;
>  	priv->adminq_report_link_speed_cnt = 0;
>  	priv->adminq_get_ptype_map_cnt = 0;
> +	priv->adminq_query_flow_rules_cnt = 0;
> +	priv->adminq_cfg_flow_rule_cnt = 0;
>  
>  	/* Setup Admin queue with the device */
>  	if (priv->pdev->revision < 0x1) {
> @@ -526,6 +528,12 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
>  	case GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY:
>  		priv->adminq_verify_driver_compatibility_cnt++;
>  		break;
> +	case GVE_ADMINQ_QUERY_FLOW_RULES:
> +		priv->adminq_query_flow_rules_cnt++;
> +		break;
> +	case GVE_ADMINQ_CONFIGURE_FLOW_RULE:
> +		priv->adminq_cfg_flow_rule_cnt++;
> +		break;
>  	default:
>  		dev_err(&priv->pdev->dev, "unknown AQ command opcode %d\n", opcode);
>  	}
> @@ -1188,3 +1196,128 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
>  			  ptype_map_bus);
>  	return err;
>  }
> +
> +static int
> +gve_adminq_configure_flow_rule(struct gve_priv *priv,
> +			       struct gve_adminq_configure_flow_rule *flow_rule_cmd)
> +{
> +	int err = gve_adminq_execute_extended_cmd(priv,
> +			GVE_ADMINQ_CONFIGURE_FLOW_RULE,
> +			sizeof(struct gve_adminq_configure_flow_rule),
> +			flow_rule_cmd);
> +
> +	if (err) {
> +		dev_err(&priv->pdev->dev, "Timeout to configure the flow rule, trigger reset");
> +		gve_reset(priv, true);
> +	} else {
> +		priv->flow_rules_cache.rules_cache_synced = false;
> +	}
> +
> +	return err;
> +}
> +
> +int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_flow_rule *rule, u32 loc)
> +{
> +	struct gve_adminq_configure_flow_rule flow_rule_cmd = {
> +		.opcode = cpu_to_be16(GVE_RULE_ADD),
> +		.location = cpu_to_be32(loc),
> +		.rule = *rule,
> +	};
> +
> +	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
> +}
> +
> +int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc)
> +{
> +	struct gve_adminq_configure_flow_rule flow_rule_cmd = {
> +		.opcode = cpu_to_be16(GVE_RULE_DEL),
> +		.location = cpu_to_be32(loc),
> +	};
> +
> +	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
> +}
> +
> +int gve_adminq_reset_flow_rules(struct gve_priv *priv)
> +{
> +	struct gve_adminq_configure_flow_rule flow_rule_cmd = {
> +		.opcode = cpu_to_be16(GVE_RULE_RESET),
> +	};
> +
> +	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
> +}
> +
> +/* In the dma memory that the driver allocated for the device to query the flow rules, the device
> + * will first write it with a struct of gve_query_flow_rules_descriptor. Next to it, the device
> + * will write an array of rules or rule ids with the count that specified in the descriptor.
> + * For GVE_FLOW_RULE_QUERY_STATS, the device will only write the descriptor.
> + */
> +static int gve_adminq_process_flow_rules_query(struct gve_priv *priv, u16 query_opcode,
> +					       struct gve_query_flow_rules_descriptor *descriptor)
> +{
> +	struct gve_flow_rules_cache *flow_rules_cache = &priv->flow_rules_cache;
> +	u32 num_queried_rules, total_memory_len, rule_info_len;
> +	void *descriptor_end, *rule_info;
> +
> +	total_memory_len = be32_to_cpu(descriptor->total_length);
> +	if (total_memory_len > GVE_ADMINQ_BUFFER_SIZE) {
> +		dev_err(&priv->dev->dev, "flow rules query is out of memory.\n");

The error doesn't seem to match the inequality used. Also, how can the
HW write more than GVE_ADMINQ_BUFFER_SIZE?

> +		return -ENOMEM;
> +	}
> +
> +	num_queried_rules = be32_to_cpu(descriptor->num_queried_rules);
> +	descriptor_end = (void *)descriptor + total_memory_len;

This isn't being used.

> +	rule_info = (void *)(descriptor + 1);
> +
> +	switch (query_opcode) {
> +	case GVE_FLOW_RULE_QUERY_RULES:
> +		rule_info_len = num_queried_rules * sizeof(*flow_rules_cache->rules_cache);

Do you need to verify what the HW has written matches your expectations
i.e. is sizeof(*descriptor) + rule_info_len == total_memory_len?

> +
> +		memcpy(flow_rules_cache->rules_cache, rule_info, rule_info_len);
> +		flow_rules_cache->rules_cache_num = num_queried_rules;
> +		break;
> +	case GVE_FLOW_RULE_QUERY_IDS:
> +		rule_info_len = num_queried_rules * sizeof(*flow_rules_cache->rule_ids_cache);
> +
> +		memcpy(flow_rules_cache->rule_ids_cache, rule_info, rule_info_len);
> +		flow_rules_cache->rule_ids_cache_num = num_queried_rules;
> +		break;
> +	case GVE_FLOW_RULE_QUERY_STATS:
> +		priv->num_flow_rules = be32_to_cpu(descriptor->num_flow_rules);
> +		priv->max_flow_rules = be32_to_cpu(descriptor->max_flow_rules);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return  0;
> +}
> +
> +int gve_adminq_query_flow_rules(struct gve_priv *priv, u16 query_opcode, u32 starting_loc)
> +{
> +	struct gve_query_flow_rules_descriptor *descriptor;
> +	union gve_adminq_command cmd;
> +	dma_addr_t descriptor_bus;
> +	int err = 0;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	descriptor = dma_pool_alloc(priv->adminq_pool, GFP_KERNEL, &descriptor_bus);

Why is adminq_pool only used for 2 commands?

> +	if (!descriptor)
> +		return -ENOMEM;
> +
> +	cmd.opcode = cpu_to_be32(GVE_ADMINQ_QUERY_FLOW_RULES);
> +	cmd.query_flow_rules = (struct gve_adminq_query_flow_rules) {
> +		.opcode = cpu_to_be16(query_opcode),
> +		.starting_rule_id = cpu_to_be32(starting_loc),
> +		.available_length = cpu_to_be64(GVE_ADMINQ_BUFFER_SIZE),
> +		.rule_descriptor_addr = cpu_to_be64(descriptor_bus),
> +	};
> +	err = gve_adminq_execute_cmd(priv, &cmd);
> +	if (err)
> +		goto out;
> +
> +	err = gve_adminq_process_flow_rules_query(priv, query_opcode, descriptor);
> +
> +out:
> +	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
> +	return err;
> +}
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
> index e64a0e72e781..9ddb72f92197 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -25,11 +25,21 @@ enum gve_adminq_opcodes {
>  	GVE_ADMINQ_REPORT_LINK_SPEED		= 0xD,
>  	GVE_ADMINQ_GET_PTYPE_MAP		= 0xE,
>  	GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY	= 0xF,
> +	GVE_ADMINQ_QUERY_FLOW_RULES		= 0x10,
>  
>  	/* For commands that are larger than 56 bytes */
>  	GVE_ADMINQ_EXTENDED_COMMAND		= 0xFF,
>  };
>  
> +/* The normal adminq command is restricted to be 56 bytes at maximum. For the
> + * longer adminq command, it is wrapped by GVE_ADMINQ_EXTENDED_COMMAND with
> + * inner opcode of gve_adminq_extended_cmd_opcodes specified. The inner command
> + * is written in the dma memory allocated by GVE_ADMINQ_EXTENDED_COMMAND.
> + */
> +enum gve_adminq_extended_cmd_opcodes {
> +	GVE_ADMINQ_CONFIGURE_FLOW_RULE	= 0x101,
> +};
> +
>  /* Admin queue status codes */
>  enum gve_adminq_statuses {
>  	GVE_ADMINQ_COMMAND_UNSET			= 0x0,
> @@ -434,6 +444,66 @@ struct gve_adminq_get_ptype_map {
>  	__be64 ptype_map_addr;
>  };
>  
> +/* Flow-steering related definitions */
> +enum gve_adminq_flow_rule_cfg_opcode {
> +	GVE_RULE_ADD	= 0,
> +	GVE_RULE_DEL	= 1,
> +	GVE_RULE_RESET	= 2,
> +};

Could these be more descriptive?

> +
> +enum gve_adminq_flow_rule_query_opcode {
> +	GVE_FLOW_RULE_QUERY_RULES	= 0,
> +	GVE_FLOW_RULE_QUERY_IDS		= 1,
> +	GVE_FLOW_RULE_QUERY_STATS	= 2,
> +};
> +
> +enum gve_adminq_flow_type {
> +	GVE_FLOW_TYPE_TCPV4,
> +	GVE_FLOW_TYPE_UDPV4,
> +	GVE_FLOW_TYPE_SCTPV4,
> +	GVE_FLOW_TYPE_AHV4,
> +	GVE_FLOW_TYPE_ESPV4,
> +	GVE_FLOW_TYPE_TCPV6,
> +	GVE_FLOW_TYPE_UDPV6,
> +	GVE_FLOW_TYPE_SCTPV6,
> +	GVE_FLOW_TYPE_AHV6,
> +	GVE_FLOW_TYPE_ESPV6,
> +};
> +
> +/* Flow-steering command */
> +struct gve_adminq_flow_rule {
> +	__be16 flow_type;
> +	__be16 action; /* RX queue id */
> +	struct gve_flow_spec key;
> +	struct gve_flow_spec mask;
> +};
> +
> +struct gve_adminq_configure_flow_rule {
> +	__be16 opcode;
> +	u8 padding[2];
> +	struct gve_adminq_flow_rule rule;
> +	__be32 location;
> +};
> +
> +static_assert(sizeof(struct gve_adminq_configure_flow_rule) == 92);
> +
> +struct gve_query_flow_rules_descriptor {
> +	__be32 num_flow_rules; /* Current rule counts stored in the device */
> +	__be32 max_flow_rules;
> +	__be32 num_queried_rules;

nit: more comments here are appreciated.

> +	__be32 total_length; /* The memory length that the device writes */
> +};
> +
> +struct gve_adminq_query_flow_rules {
> +	__be16 opcode;
> +	u8 padding[2];
> +	__be32 starting_rule_id;
> +	__be64 available_length; /* The dma memory length that the driver allocated */
> +	__be64 rule_descriptor_addr; /* The dma memory address */
> +};
> +
> +static_assert(sizeof(struct gve_adminq_query_flow_rules) == 24);
> +
>  union gve_adminq_command {
>  	struct {
>  		__be32 opcode;
> @@ -454,6 +524,7 @@ union gve_adminq_command {
>  			struct gve_adminq_get_ptype_map get_ptype_map;
>  			struct gve_adminq_verify_driver_compatibility
>  						verify_driver_compatibility;
> +			struct gve_adminq_query_flow_rules query_flow_rules;
>  			struct gve_adminq_extended_command extended_command;
>  		};
>  	};
> @@ -488,6 +559,10 @@ int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
>  					   u64 driver_info_len,
>  					   dma_addr_t driver_info_addr);
>  int gve_adminq_report_link_speed(struct gve_priv *priv);
> +int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_flow_rule *rule, u32 loc);
> +int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
> +int gve_adminq_reset_flow_rules(struct gve_priv *priv);
> +int gve_adminq_query_flow_rules(struct gve_priv *priv, u16 query_opcode, u32 starting_loc);
>  
>  struct gve_ptype_lut;
>  int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> index 156b7e128b53..02cee7e0e229 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -74,7 +74,8 @@ static const char gve_gstrings_adminq_stats[][ETH_GSTRING_LEN] = {
>  	"adminq_create_tx_queue_cnt", "adminq_create_rx_queue_cnt",
>  	"adminq_destroy_tx_queue_cnt", "adminq_destroy_rx_queue_cnt",
>  	"adminq_dcfg_device_resources_cnt", "adminq_set_driver_parameter_cnt",
> -	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt", "adminq_get_ptype_map_cnt"
> +	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt", "adminq_get_ptype_map_cnt",
> +	"adminq_query_flow_rules", "adminq_cfg_flow_rule",
>  };
>  
>  static const char gve_gstrings_priv_flags[][ETH_GSTRING_LEN] = {
> @@ -458,6 +459,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  	data[i++] = priv->adminq_report_stats_cnt;
>  	data[i++] = priv->adminq_report_link_speed_cnt;
>  	data[i++] = priv->adminq_get_ptype_map_cnt;
> +	data[i++] = priv->adminq_query_flow_rules_cnt;
> +	data[i++] = priv->adminq_cfg_flow_rule_cnt;
>  }
>  
>  static void gve_get_channels(struct net_device *netdev,
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index cabf7d4bcecb..eb435ccbe98e 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -141,6 +141,52 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
>  	}
>  }
>  
> +static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
> +{
> +	struct gve_flow_rules_cache *flow_rules_cache = &priv->flow_rules_cache;
> +	int err = 0;
> +
> +	if (!priv->max_flow_rules)
> +		return 0;
> +
> +	flow_rules_cache->rules_cache =
> +		kvcalloc(GVE_FLOW_RULES_CACHE_SIZE, sizeof(*flow_rules_cache->rules_cache),
> +			 GFP_KERNEL);
> +	if (!flow_rules_cache->rules_cache) {
> +		dev_err(&priv->pdev->dev, "Cannot alloc flow rules cache\n");
> +		return -ENOMEM;
> +	}
> +
> +	flow_rules_cache->rule_ids_cache =
> +		kvcalloc(GVE_FLOW_RULE_IDS_CACHE_SIZE, sizeof(*flow_rules_cache->rule_ids_cache),
> +			 GFP_KERNEL);
> +	if (!flow_rules_cache->rule_ids_cache) {
> +		dev_err(&priv->pdev->dev, "Cannot alloc flow rule ids cache\n");
> +		err = -ENOMEM;
> +		goto free_rules_cache;
> +	}
> +
> +	return 0;
> +
> +free_rules_cache:
> +	kvfree(flow_rules_cache->rules_cache);
> +	flow_rules_cache->rules_cache = NULL;
> +	return err;
> +}
> +
> +static void gve_free_flow_rule_caches(struct gve_priv *priv)
> +{
> +	struct gve_flow_rules_cache *flow_rules_cache = &priv->flow_rules_cache;
> +
> +	if (!priv->max_flow_rules)
> +		return;

Is this needed? Is kernel style just kvfree() w/o checks?

> +
> +	kvfree(flow_rules_cache->rule_ids_cache);
> +	flow_rules_cache->rule_ids_cache = NULL;
> +	kvfree(flow_rules_cache->rules_cache);
> +	flow_rules_cache->rules_cache = NULL;
> +}
> +
>  static int gve_alloc_counter_array(struct gve_priv *priv)
>  {
>  	priv->counter_array =
> @@ -521,9 +567,12 @@ static int gve_setup_device_resources(struct gve_priv *priv)
>  {
>  	int err;
>  
> -	err = gve_alloc_counter_array(priv);
> +	err = gve_alloc_flow_rule_caches(priv);
>  	if (err)
>  		return err;
> +	err = gve_alloc_counter_array(priv);
> +	if (err)
> +		goto abort_with_flow_rule_caches;
>  	err = gve_alloc_notify_blocks(priv);
>  	if (err)
>  		goto abort_with_counter;
> @@ -575,6 +624,8 @@ static int gve_setup_device_resources(struct gve_priv *priv)
>  	gve_free_notify_blocks(priv);
>  abort_with_counter:
>  	gve_free_counter_array(priv);
> +abort_with_flow_rule_caches:
> +	gve_free_flow_rule_caches(priv);
>  
>  	return err;
>  }
> @@ -606,6 +657,7 @@ static void gve_teardown_device_resources(struct gve_priv *priv)
>  	kvfree(priv->ptype_lut_dqo);
>  	priv->ptype_lut_dqo = NULL;
>  
> +	gve_free_flow_rule_caches(priv);
>  	gve_free_counter_array(priv);
>  	gve_free_notify_blocks(priv);
>  	gve_free_stats_report(priv);

