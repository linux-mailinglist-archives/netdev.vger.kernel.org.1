Return-Path: <netdev+bounces-271180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMRQBKLAwmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:49:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF03195FD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 785DB3048524
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF863FCB06;
	Tue, 24 Mar 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWKloWIu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793F3FBEA6;
	Tue, 24 Mar 2026 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370590; cv=none; b=UaUzVjcYdXMEPmrgwjJ2VKYlcLxInmnKwN4Xxh01WK9I1O6DumneYcFQoUviQjmSHRrdtcbSsEBb4V/T9NYWBD57wPXHF+UUfDtUZVwnGcqwbMr0svaqMGKWMQpK+sJXcbIC2JLSWEXQqpApyMdfdX4n5dgs5ORLzpzNL7T2tzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370590; c=relaxed/simple;
	bh=rPwXPqpxqGjwXWV5oKmXOPdHJyLJEDqfkcEG9hr97Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHNzJJBRdHG7kGXseMCH1S41TFGbQhGtCdLm5rfD9Gc9N14Q1MeqzvC8XEbYO7n05cYYk0EIJ4jH8Woe/Nxkm9EePsmqg6MSE9OuYdG15R/v1aRvxM1oY6PKG/LWagLxUQ6T0v44Z6mqmmO7dUiZIZjqaV0wVtIg2lRMeYe68qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWKloWIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D95C19424;
	Tue, 24 Mar 2026 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774370589;
	bh=rPwXPqpxqGjwXWV5oKmXOPdHJyLJEDqfkcEG9hr97Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWKloWIuyD2kQEflYjJHa+EVqWpu+DbR2qbrsnsRPeEsjLjwZ/dNK1v6Ct0YZ85z8
	 gXJiBzemJGHs4JP3u1R6Dn4JC6IisnUDUZmy1Tv8uqCT+ETnUkGza1ePayOi+P2mVr
	 zHbLHeVd/7LOpalcqEQt6jts/9elteBCEXCzvCehGbeR2ZNub4i9LEeClfygW/udeO
	 OuN/YmbWObxyv8jHvvGxoBQuThG4tpiZ+EdIlA6MAJ49ToCp/yQJeZgP1ICWQABKRB
	 ep0Rw/qBYFptH6rM1fUBTmOX8XS6oVLff4ICSg0LRO7+r/L24GO8J/SBWS3+YXDde/
	 ysOFzBMR2mllg==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	xiaoning.wang@nxp.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	edumazet@google.com,
	linux-arm-kernel@lists.infradead.org,
	frank.li@nxp.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	claudiu.manoil@nxp.com,
	f.fainelli@gmail.com,
	vladimir.oltean@nxp.com,
	linuxppc-dev@lists.ozlabs.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 13/14] net: dsa: netc: initialize buffer bool table and implement flow-control
Date: Tue, 24 Mar 2026 16:42:30 +0000
Message-ID: <20260324164234.238201-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323060752.1157031-14-wei.fang@nxp.com>
References: <20260323060752.1157031-14-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271180-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,vger.kernel.org,armlinux.org.uk,lunn.ch,google.com,lists.infradead.org,gmail.com,lists.ozlabs.org,redhat.com,davemloft.net,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EDF03195FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: netc: initialize buffer bool table and implement flow-control

The buffer pool is a quantity of memory available for buffering a group
of flows (e.g. frames having the same priority, frames received from the
same port), while waiting to be transmitted on a port. The buffer pool
tracks internal memory consumption with upper bound limits and optionally
a non-shared portion when associated with a shared buffer pool. Currently
the shared buffer pool is not supported, it will be added in the future.

For i.MX94, the switch has 4 ports and 8 buffer pools, so each port is
allocated two buffer pools. For frames with priorities of 0 to 3, they
will be mapped to the first buffer pool; For frames with priorities of
4 to 7, they will be mapped to the second buffer pool. Each buffer pool
has a flow control on threshold and a flow control off threshold. By
setting these threshold, add the flow control support to each port.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 4b331971dd8c..2a7ad39f8bed 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -617,6 +628,80 @@ static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
>  				       bcast, NETC_STANDALONE_PVID);
>  }
>
> +static u32 netc_get_buffer_pool_num(struct netc_switch *priv)
> +{
> +	return netc_base_rd(&priv->regs, NETC_BPCAPR) & BPCAPR_NUM_BP;
> +}
> +
> +static void netc_port_set_pbpmcr(struct netc_port *np, u64 mapping)
> +{
> +	u32 pbpmcr0 = lower_32_bits(mapping);
> +	u32 pbpmcr1 = upper_32_bits(mapping);
> +
> +	netc_port_wr(np, NETC_PBPMCR0, pbpmcr0);
> +	netc_port_wr(np, NETC_PBPMCR1, pbpmcr1);
> +}
> +
> +static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
> +{
> +	int num_port_bp = priv->num_bp / priv->info->num_ports;
> +	int q = NETC_IPV_NUM / num_port_bp;
>                ^^^^

Can this cause a division by zero?  If netc_get_buffer_pool_num() reads
the hardware register NETC_BPCAPR and returns 0, then num_port_bp would be
0 and this division would crash the kernel.

The call chain is:

netc_setup()
  netc_switch_bpt_default_config()
    priv->num_bp = netc_get_buffer_pool_num()
    netc_ipv_to_buffer_pool_mapping()
      num_port_bp = priv->num_bp / priv->info->num_ports;
      q = NETC_IPV_NUM / num_port_bp;  <- division by zero

Should netc_switch_bpt_default_config() validate that priv->num_bp is
non-zero before proceeding?

> +	int r = NETC_IPV_NUM % num_port_bp;
> +	int num = q + r;
> +
> +	/* IPV-to–buffer-pool mapping per port:

[ ... ]

> +static int netc_switch_bpt_default_config(struct netc_switch *priv)
> +{
> +	priv->num_bp = netc_get_buffer_pool_num(priv);
> +	priv->bpt_list = devm_kcalloc(priv->dev, priv->num_bp,
> +				      sizeof(struct bpt_cfge_data),
> +				      GFP_KERNEL);
> +	if (!priv->bpt_list)
> +		return -ENOMEM;
> +
> +	/* Initialize the maximum threshold of each buffer pool entry */
> +	for (int i = 0; i < priv->num_bp; i++) {
> +		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
> +		int err;
> +
> +		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
> +		err = ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
> +		if (err)
> +			return err;
> +	}
> +
> +	netc_ipv_to_buffer_pool_mapping(priv);
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -1224,6 +1313,40 @@ static void netc_port_set_hd_flow_control(struct netc_port *np, bool en)
>  			  en ? PM_CMD_CFG_HD_FCEN : 0);
>  }
>
> +static void netc_port_set_tx_pause(struct netc_port *np, bool tx_pause)
> +{
> +	struct netc_switch *priv = np->switch_priv;
> +	int port = np->dp->index;
> +	int i, j, num_bp;
> +
> +	num_bp = priv->num_bp / priv->info->num_ports;
> +	for (i = 0, j = port * num_bp; i < num_bp; i++, j++) {
> +		struct bpt_cfge_data *cfge;
> +
> +		cfge = &priv->bpt_list[j];
> +		if (tx_pause) {
> +			cfge->fc_on_thresh = cpu_to_le16(NETC_FC_THRESH_ON);
> +			cfge->fc_off_thresh = cpu_to_le16(NETC_FC_THRESH_OFF);
> +			cfge->fccfg_sbpen = FIELD_PREP(BPT_FC_CFG,
> +						       BPT_FC_CFG_EN_BPFC);
> +			cfge->fc_ports = cpu_to_le32(BIT(port));
> +		} else {
> +			cfge->fc_on_thresh = cpu_to_le16(0);
> +			cfge->fc_off_thresh = cpu_to_le16(0);
> +			cfge->fccfg_sbpen = 0;
> +			cfge->fc_ports = cpu_to_le32(0);
> +		}
> +
> +		ntmp_bpt_update_entry(&priv->ntmp, j, cfge);
>                 ^^^^

Should the return value of ntmp_bpt_update_entry() be checked here?

Simon Horman noted in v1 review that other NTMP table operations in the
driver propagate errors from the update functions. While this was fixed
in netc_switch_bpt_default_config() in v2, the same issue remains here.

If the hardware update fails (for example, DMA allocation failure or
hardware timeout), the driver's bpt_list will have flow control values that
do not match the actual hardware state, potentially causing incorrect flow
control behavior.

https://lore.kernel.org/netdev/20260318145452.1898637-2-horms@kernel.org/

> +	}
> +}
> +

[ ... ]

