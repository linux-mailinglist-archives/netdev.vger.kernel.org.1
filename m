Return-Path: <netdev+bounces-95701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D18C31E7
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDCD28178E
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0733C54780;
	Sat, 11 May 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdFO2s9O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABB53373;
	Sat, 11 May 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715438738; cv=none; b=X5JQo56o7sO3JrJwZ0s6wMhqq0/k666cllZtaM/imrw2nf9uLVV+l4gDjDH2MQNO+6k1X5QZcntMXb8X7R6EG3wyfm6Wc7X9l5ImAzoiR7e4dnq1Q/L01lCfeIFYPud78z/SDAkiEuIzhPUeG0q3IydRvpYVaGOFbg0p53wQ1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715438738; c=relaxed/simple;
	bh=re8WX84sJdktyphDmEG+rKqOKuvK4zXzKzyYxGkYcss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTC9LMISVdrbQr0epFETeofFMMh3Gp1zAcKYghtAmWvEAZbPGvGM0bOUI8QwDIaJrrRjjzqV8U0z3tHEMVyJXe/LkvkLAtZWxu7l0HVdEDCBjjCN4yWtp5/5dDoC+YNAN3fvXwQWylGR3cIp9spfz4+f7ry/mXsOTeBFL7g+A10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdFO2s9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBADC2BBFC;
	Sat, 11 May 2024 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715438738;
	bh=re8WX84sJdktyphDmEG+rKqOKuvK4zXzKzyYxGkYcss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GdFO2s9OTZz43l68LypCO7Q3KeIL/rldzPjDqVbFA9LC7q9+R4LfW4NCDIK95WRRn
	 l177RT37BCSK+P+ztD7CfQe6EuAQl7LpU+sgBXQSp2Ke8ogxWJ3XAAcwQd8jmTsipR
	 lstmX7xAgcbouZnjPxY0CG2gcTvSGbaTQ/3qKpNaLONP1g2y+bhJM2z1ujnjxW4mBA
	 nrFzmcn3C6bOkWfbkNhAyzzhJUsczKEH5sy4q5X+RQ7CtW3iHBAdsOBOLkIbVSPKUJ
	 tCqeXGjRamXC0sagcZwGAobehUZd7xSb1PRD+EmTRqmPKH0Y7RbJlVOvikE7NjEiwO
	 M3gpvAbA7uogQ==
Date: Sat, 11 May 2024 15:45:32 +0100
From: Simon Horman <horms@kernel.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
	shailend@google.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
	hramamurthy@google.com, rushilg@google.com, jfraker@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] gve: Add flow steering ethtool support
Message-ID: <20240511144532.GJ2347895@kernel.org>
References: <20240507225945.1408516-1-ziweixiao@google.com>
 <20240507225945.1408516-6-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507225945.1408516-6-ziweixiao@google.com>

On Tue, May 07, 2024 at 10:59:45PM +0000, Ziwei Xiao wrote:
> From: Jeroen de Borst <jeroendb@google.com>
> 
> Implement the ethtool commands that can be used to configure and query
> flow-steering rules. For these ethtool commands, the driver will
> temporarily drop the rtnl lock to reduce the latency for the flow
> steering commands on separate NICs. It will then be protected by the new
> added adminq lock.
> 
> A large part of this change consists of translating the ethtool
> representation of 'ntuples' to our internal gve_flow_rule and vice-versa
> in the new created gve_flow_rule.c
> 
> Considering the possible large amount of flow rules, the driver doesn't
> store all the rules locally. When the user runs 'ethtool -n <nic>' to
> check the registered rules, the driver will send adminq command to
> query a limited amount of rules/rule ids(that filled in a 4096 bytes dma
> memory) at a time as a cache for the ethtool queries. The adminq query
> commands will be repeated for several times until the ethtool has
> queried all the needed rules.
> 
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

...

> diff --git a/drivers/net/ethernet/google/gve/gve_flow_rule.c b/drivers/net/ethernet/google/gve/gve_flow_rule.c
> new file mode 100644
> index 000000000000..1cafd520f2db
> --- /dev/null
> +++ b/drivers/net/ethernet/google/gve/gve_flow_rule.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Google virtual Ethernet (gve) driver
> + *
> + * Copyright (C) 2015-2024 Google LLC
> + */
> +
> +#include "gve.h"
> +#include "gve_adminq.h"
> +
> +static
> +int gve_fill_ethtool_flow_spec(struct ethtool_rx_flow_spec *fsp, struct gve_flow_rule *rule)
> +{
> +	static const u16 flow_type_lut[] = {
> +		[GVE_FLOW_TYPE_TCPV4]	= TCP_V4_FLOW,
> +		[GVE_FLOW_TYPE_UDPV4]	= UDP_V4_FLOW,
> +		[GVE_FLOW_TYPE_SCTPV4]	= SCTP_V4_FLOW,
> +		[GVE_FLOW_TYPE_AHV4]	= AH_V4_FLOW,
> +		[GVE_FLOW_TYPE_ESPV4]	= ESP_V4_FLOW,
> +		[GVE_FLOW_TYPE_TCPV6]	= TCP_V6_FLOW,
> +		[GVE_FLOW_TYPE_UDPV6]	= UDP_V6_FLOW,
> +		[GVE_FLOW_TYPE_SCTPV6]	= SCTP_V6_FLOW,
> +		[GVE_FLOW_TYPE_AHV6]	= AH_V6_FLOW,
> +		[GVE_FLOW_TYPE_ESPV6]	= ESP_V6_FLOW,
> +	};
> +
> +	if (be16_to_cpu(rule->flow_type) >= ARRAY_SIZE(flow_type_lut))

The type of rule->flow_type is u16.
But be16_to_cpu expects a 16-bit big endian value as it's argument.
This does not seem right.

This was flagged by Sparse along with several other problems in this patch.
Please make sure patches don't introduce new Sparse warnings.

Thanks!

...

> +int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
> +{
> +	struct ethtool_rx_flow_spec *fsp = &cmd->fs;
> +	struct gve_adminq_flow_rule *rule = NULL;
> +	int err;
> +
> +	if (!priv->max_flow_rules)
> +		return -EOPNOTSUPP;
> +
> +	rule = kvzalloc(sizeof(*rule), GFP_KERNEL);
> +	if (!rule)
> +		return -ENOMEM;
> +
> +	err = gve_generate_flow_rule(priv, fsp, rule);
> +	if (err)
> +		goto out;
> +
> +	err = gve_adminq_add_flow_rule(priv, rule, fsp->location);
> +
> +out:
> +	kfree(rule);

rule was allocated using kvmalloc(), so it should be freed using kvfree().

Flagged by Coccinelle.

> +	if (err)
> +		dev_err(&priv->pdev->dev, "Failed to add the flow rule: %u", fsp->location);
> +
> +	return err;
> +}

...

