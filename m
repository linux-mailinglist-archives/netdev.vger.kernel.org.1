Return-Path: <netdev+bounces-258074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P+GEUIji2lyQQAAu9opvQ
	(envelope-from <netdev+bounces-258074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:23:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B386311AB96
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB88A3034332
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDFA328B69;
	Tue, 10 Feb 2026 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXtNWcNz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOa+elGE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8977C2E8B94
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726207; cv=none; b=GDV0lysuYVXTA9gshCfKw9eUy8+kQL8LrIA/ialcUrfX0eZWdVBOzx5QoVudS4M6NkpAfy22DI2JY7cqTKP4JeZNPRHUGZsZm97krcGuejDzKsjy3fUVJlXVNyhm8CmPHRa2dUcg55SA3exQUgp2YxPsO/NvW0f3S8VtiY4CFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726207; c=relaxed/simple;
	bh=qhZYmuztZCySzZ6K/YtxVF4naRNuHY+/ofQjOToyLnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLQElv8xLSVpoHLbESSEbmiZHKl3W+sPA+lXu/bfB9H2eOSs7Z8WQiwU0QR4DLA8PtZAF1og+/nYaQnsExlM4MycR4eL2LeEYH+b9kITc2PXuBjENVjtg8XK2lwOkdJxzU/o75z961pa1MYX4NeC4B5nsaz0bBFDYsB5iQ5eTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXtNWcNz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOa+elGE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770726204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWvUhRqt1hN18rXGP932XQa3bmQweHVVpefpm4V28X0=;
	b=KXtNWcNzsDrsfErkM2NhzpjfKt4TQf1T6IoMos/IfCW+hiY+hO2tLbmNAGWVHSSjNX8nHj
	wUb1ScJXqpajIE1lgpibpX/Jfws+uE8T3p4nvfspZd1Dtca2xTgh4mCYaXAcuoYGpTNm5G
	HFZFe5nEdOjj+AeAft1Ekrgvq/Ur0V4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-BFgvJkpWN9m7hw0-a6v1Qg-1; Tue, 10 Feb 2026 07:23:21 -0500
X-MC-Unique: BFgvJkpWN9m7hw0-a6v1Qg-1
X-Mimecast-MFC-AGG-ID: BFgvJkpWN9m7hw0-a6v1Qg_1770726200
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so64398165e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 04:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770726200; x=1771331000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWvUhRqt1hN18rXGP932XQa3bmQweHVVpefpm4V28X0=;
        b=TOa+elGET3iz3bsgKmyUvyvtPk9J0a/Z1YYOqZpqz+nceW+iXg2QKKPSAHAASy9Ug/
         /7hTVtInyUUDGygGfgwxzvPkhn6Yy9jPPtb8SieJ/Kww1yWLoqJzyHEPJ2ZdWaR7Nxua
         PO2tASVOfXrcT5gYW/fnif8zDxN/pZnXae6AQFDEIc/FQpEmCWsFmyvsmc7uTKKFoREq
         dcbgtT/wr9dy4/rI4HN+nbG4I+QmVay5z4+brmNAQHeDNO4iIBCt2Q5h18ow/8XsqnaS
         lN2g5RlhiflHdA+g0gDf6E39tvDBNhexS22RjiXS/2LiQrgxawAubiO0eUMPuhCfmuis
         XjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770726200; x=1771331000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWvUhRqt1hN18rXGP932XQa3bmQweHVVpefpm4V28X0=;
        b=MNh5rpK+zDZXpbMI/mlh0Bt853rWruKToXkH+BQIqAZGNW249dNTZLp4arYvSUil9g
         3cQN8eCMlar3BmLBNS0D7fJrgwniRCGvvg3HAqjqw4mgDDjEZ+8SrjMZdnoN6s2lOcxP
         l/JRce6VoIFOlmG7dtp+Z/+x+oqDj6z9hkVzC17t5arsjkzbvVCdXGMdUCG8V1+FlzK6
         D1hlUFtAxkePNB2tWVYYAmSWcSmQyYiHFKTdhtXlXk3YDa3qbLKIylhpls7VIbhis+sG
         Xn2iRlNIZSgFL5ob5ldwo2mUfgC89TjqwU1JK0kqD7uS0HiaWdBT8zxme2IkDhnJQ/vl
         hGHA==
X-Forwarded-Encrypted: i=1; AJvYcCU22dSTJs1hSwkBsz25Q3WVQFHtGXrTBAQiJHD3QmLnFOf5z9KMfNN5WpKezRGDhQVhZqwx3nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAR9+re/C9TnTQogfGiwSCXDFRobm0waAtnLd1n/S0nxUZCCQ
	rXVnrR4W4UlzxbUxBtZLKwLyWpXzfpL5tvstpICdWTg7YUj5roTX09cMZZCUh+PggZNB1Pq3vbV
	ulmjzOCstelg0b8Z9j+QeRpGLl0ZGVifDuGpFN7H8bSKoa91+E8psfGnoOg==
X-Gm-Gg: AZuq6aLt7x32m10iPiPBIk6JmF9M8G50O0Yo9yr+Xr7fzQuXZ5LgYtk8inZHBUKGJgG
	h826hXoHMuYAbib/rZLpS7oePIEyQP+K9zYUgTLD39oRX7a6BSMUCO64HGOJIMN8HnPY52IbU5S
	/dyCEdQeJxholEmAUCwrXrl6Yngx1y8DwazHTZFEsVgrY4ZNzEfcIQA2Hm+llhxeczcliXPh6fK
	GQEj9RkFgoes6kkra0V0Kw3tHdkMf3LV+R0hDV1ChimUsidC1IJzmoWTduxglcFWYIjo+KO7zKj
	/caPhpDSNxpbeDJ6xjORavmNVEqQKAPIJgaLP5xKd6H7GKykOwOucKwSmmu3zM5o5clS2+FpLV9
	WKpiIdPbnhSxNvrou9xeT3Cw=
X-Received: by 2002:a05:600c:3487:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-483507cff88mr28917945e9.3.1770726199940;
        Tue, 10 Feb 2026 04:23:19 -0800 (PST)
X-Received: by 2002:a05:600c:3487:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-483507cff88mr28917395e9.3.1770726199404;
        Tue, 10 Feb 2026 04:23:19 -0800 (PST)
Received: from [192.168.88.32] ([150.228.25.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm120865445e9.11.2026.02.10.04.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 04:23:18 -0800 (PST)
Message-ID: <2b7263db-ac5e-4eda-a599-2535242be24a@redhat.com>
Date: Tue, 10 Feb 2026 13:23:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: ti: icssg-prueth: Add Frame
 Preemption MAC Merge support
To: Meghana Malladi <m-malladi@ti.com>, vadim.fedorenko@linux.dev,
 jacob.e.keller@intel.com, horms@kernel.org, basharath@couthit.com,
 parvathi@couthit.com, afd@ti.com, vladimir.oltean@nxp.com,
 rogerq@kernel.org, danishanwar@ti.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20260205184747.2451816-1-m-malladi@ti.com>
 <20260205184747.2451816-2-m-malladi@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260205184747.2451816-2-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258074-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,ti.com:url,ti.com:email]
X-Rspamd-Queue-Id: B386311AB96
X-Rspamd-Action: no action

On 2/5/26 7:47 PM, Meghana Malladi wrote:
> From: MD Danish Anwar <danishanwar@ti.com>
> 
> This patch introduces qos support for the icssg driver. This
> includes adding support to configure mqprio qdisc and IET FPE.
> By default all the queues are marked as express which can be
> overwritten by the mqprio tc mask passed by tc qdisc.
> 
> icssg_config_ietfpe() work thread takes care of configuring
> IET FPE in the firmware and triggering the verify state machine
> based on the MAC Merge sublayer parameters set by the ethtool.
> The firmware handles the cleanup after successful mac verification.
> And in case the remote peer fails to respond to verify command
> before the timeout (5secs), then FPE is disabled by firmware.
> 
> During link up/down, verify state machine gets triggered again
> based on the state of fpe_enabled and fpe_active.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 
> v3-v1:
> - Move icssg_qos_link_up/down() to if-statement right above as suggested by
> Vadim Fedorenko <vadim.fedorenko@linux.dev>
> - Fix p_mqprio dereference without initialization as flagged by Simon Horman <horms@kernel.org>
> - Following changes as suggested by Vladimir Oltean <vladimir.oltean@nxp.com>:
> * Provide more detailed commit message
> * Fix the ordering of the functions to avoid forward declarations
> * Fix the bug w.r.t scheduling work: fpe_config_task without initialising it
> * Fix the logic for icssg_iet_set_preempt_mask() - configure the queues based on user requests only.
> * Remove prueth_mqprio_validate() as this duplicates what "caps->validate_queue_counts = true" does.
> * Remove clearing PRE_EMPTION_ENABLE_TX on failure which is irrelevant - ACTIVE status never transitions to true.
> * Fix handling of these flags: iet->configured<->iet->fpe_enabled and iet->fpe_enabled<->iet->fpe_active
> * Schedule asynchronous work without waiting for any timeout
> * Remove cancel_fpe_config argument from prueth_qos_iet structure - no reader
> * Remove mentioning "priv flags" in the comments for prueth_qos_iet struct
> 
>  drivers/net/ethernet/ti/Makefile             |   2 +-
>  drivers/net/ethernet/ti/icssg/icssg_config.h |   9 -
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
>  drivers/net/ethernet/ti/icssg/icssg_qos.c    | 216 +++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_qos.h    |  58 +++++
>  6 files changed, 282 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
> 
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index 6da50f4b7c2e..6893baf47d46 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -35,7 +35,7 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
>  obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
>  
>  obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o icssg.o
> -icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o
> +icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o icssg/icssg_qos.o
>  
>  obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o icssg.o
>  icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
> index 60d69744ffae..1ac202f855ed 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
> @@ -323,13 +323,4 @@ struct prueth_fdb_slot {
>  	u8 fid;
>  	u8 fid_c2;
>  } __packed;
> -
> -enum icssg_ietfpe_verify_states {
> -	ICSSG_IETFPE_STATE_UNKNOWN = 0,
> -	ICSSG_IETFPE_STATE_INITIAL,
> -	ICSSG_IETFPE_STATE_VERIFYING,
> -	ICSSG_IETFPE_STATE_SUCCEEDED,
> -	ICSSG_IETFPE_STATE_FAILED,
> -	ICSSG_IETFPE_STATE_DISABLED
> -};
>  #endif /* __NET_TI_ICSSG_CONFIG_H */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index f65041662173..1e4bc5fd636e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -374,9 +374,11 @@ static void emac_adjust_link(struct net_device *ndev)
>  			spin_unlock_irqrestore(&emac->lock, flags);
>  			icssg_config_set_speed(emac);
>  			icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
> +			icssg_qos_link_up(ndev);
>  
>  		} else {
>  			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
> +			icssg_qos_link_down(ndev);
>  		}
>  	}
>  
> @@ -967,6 +969,8 @@ static int emac_ndo_open(struct net_device *ndev)
>  	if (ret)
>  		goto destroy_rxq;
>  
> +	icssg_qos_init(ndev);
> +
>  	/* start PHY */
>  	phy_start(ndev->phydev);
>  
> @@ -1421,6 +1425,7 @@ static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
>  	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
>  	.ndo_xsk_wakeup = prueth_xsk_wakeup,
> +	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
>  };
>  
>  static int prueth_netdev_init(struct prueth *prueth,
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 10eadd356650..7a586038adf8 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -44,6 +44,7 @@
>  #include "icssg_config.h"
>  #include "icss_iep.h"
>  #include "icssg_switch_map.h"
> +#include "icssg_qos.h"
>  
>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>  #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
> @@ -255,6 +256,7 @@ struct prueth_emac {
>  	struct bpf_prog *xdp_prog;
>  	struct xdp_attachment_info xdpi;
>  	int xsk_qid;
> +	struct prueth_qos qos;
>  };
>  
>  /* The buf includes headroom compatible with both skb and xdpf */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> new file mode 100644
> index 000000000000..8d17b28357f8
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Texas Instruments ICSSG PRUETH QoS submodule
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include "icssg_prueth.h"
> +#include "icssg_switch_map.h"
> +
> +static void icssg_iet_set_preempt_mask(struct prueth_emac *emac, u8 preemptible_tcs)
> +{
> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
> +	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
> +	int prempt_mask = 0, i;
> +	u8 tc;
> +
> +	/* Configure the queues based on the preemptible tc map set by the user */
> +	for (tc = 0; tc < p_mqprio->mqprio.qopt.num_tc; tc++) {
> +		/* check if the tc is preemptive or not */
> +		if (preemptible_tcs & BIT(tc)) {
> +			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
> +				/* Set all the queues in this tc as preemptive queues */
> +				writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +				prempt_mask &= ~BIT(i);
> +			}
> +		} else {
> +			/* Set all the queues in this tc as express queues */
> +			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
> +				writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +				prempt_mask |= BIT(i);
> +			}
> +		}
> +		writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
> +		netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
> +	}
> +}
> +
> +static void icssg_config_ietfpe(struct work_struct *work)
> +{
> +	struct prueth_qos_iet *iet =
> +		container_of(work, struct prueth_qos_iet, fpe_config_task);
> +	void __iomem *config = iet->emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_mqprio *p_mqprio =  &iet->emac->qos.mqprio;
> +	bool enable = !!atomic_read(&iet->enable_fpe_config);
> +	int ret;
> +	u8 val;
> +
> +	if (!netif_running(iet->emac->ndev))
> +		return;
> +
> +	/* Update FPE Tx enable bit (PRE_EMPTION_ACTIVE_TX) if
> +	 * fpe_enabled is set to enable MM in Tx direction
> +	 */
> +	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
> +
> +	/* If FPE is to be enabled, first configure MAC Verify state
> +	 * machine in firmware as firmware kicks the Verify process
> +	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
> +	 * received.
> +	 */
> +	if (enable && iet->mac_verify_configure) {
> +		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
> +		writew(iet->tx_min_frag_size, config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
> +		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
> +	}
> +
> +	/* Send command to enable FPE Tx side. Rx is always enabled */
> +	ret = icssg_set_port_state(iet->emac,
> +				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
> +					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
> +	if (ret) {
> +		netdev_err(iet->emac->ndev, "TX preempt %s command failed\n",
> +			   str_enable_disable(enable));
> +		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
> +		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
> +		return;
> +	}
> +
> +	if (enable && iet->mac_verify_configure) {
> +		ret = readb_poll_timeout(config + PRE_EMPTION_VERIFY_STATUS, iet->verify_status,
> +					 (iet->verify_status == ICSSG_IETFPE_STATE_SUCCEEDED),
> +					 USEC_PER_MSEC, 5 * USEC_PER_SEC);
> +		if (ret) {
> +			iet->verify_status = ICSSG_IETFPE_STATE_FAILED;
> +			netdev_err(iet->emac->ndev,
> +				   "timeout for MAC Verify: status %x\n",
> +				   iet->verify_status);
> +			return;
> +		}
> +	} else if (enable) {
> +		/* Give f/w some time to update PRE_EMPTION_ACTIVE_TX state */
> +		usleep_range(100, 200);
> +	}
> +
> +	if (enable) {
> +		val = readb(config + PRE_EMPTION_ACTIVE_TX);
> +		if (val != 1) {
> +			netdev_err(iet->emac->ndev,
> +				   "F/w fails to activate IET/FPE\n");
> +			return;
> +		}
> +		iet->fpe_active = true;
> +	} else {
> +		iet->fpe_active = false;
> +	}
> +
> +	netdev_info(iet->emac->ndev, "IET FPE %s successfully\n",
> +		    str_enable_disable(iet->fpe_active));
> +	icssg_iet_set_preempt_mask(iet->emac, p_mqprio->preemptible_tcs);
> +}
> +
> +void icssg_qos_init(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +
> +	/* Init work queue for IET MAC verify process */
> +	iet->emac = emac;
> +	INIT_WORK(&iet->fpe_config_task, icssg_config_ietfpe);
> +}
> +
> +static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
> +{
> +	struct tc_query_caps_base *base = type_data;
> +
> +	switch (base->type) {
> +	case TC_SETUP_QDISC_MQPRIO: {
> +		struct tc_mqprio_caps *caps = base->caps;
> +
> +		caps->validate_queue_counts = true;
> +		return 0;
> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
> +{
> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	struct prueth_qos_mqprio *p_mqprio;
> +	u8 num_tc = mqprio->qopt.num_tc;
> +	int tc, offset, count;
> +
> +	p_mqprio = &emac->qos.mqprio;
> +
> +	if (!num_tc) {
> +		netdev_reset_tc(ndev);
> +		p_mqprio->preemptible_tcs = 0;
> +		goto reset_tcs;
> +	}
> +
> +	memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
> +	p_mqprio->preemptible_tcs = mqprio->preemptible_tcs;
> +	netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
> +
> +	for (tc = 0; tc < num_tc; tc++) {
> +		count = qopt->count[tc];
> +		offset = qopt->offset[tc];
> +		netdev_set_tc_queue(ndev, tc, count, offset);
> +	}
> +
> +reset_tcs:
> +	icssg_iet_set_preempt_mask(emac, p_mqprio->preemptible_tcs);
> +
> +	return 0;
> +}
> +
> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
> +			   void *type_data)
> +{
> +	switch (type) {
> +	case TC_QUERY_CAPS:
> +		return emac_tc_query_caps(ndev, type_data);
> +	case TC_SETUP_QDISC_MQPRIO:
> +		return emac_tc_setup_mqprio(ndev, type_data);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);
> +
> +void icssg_qos_link_up(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +
> +	/* Enable FPE if not active but fpe_enabled is true
> +	 * and disable FPE if active but fpe_enabled is false
> +	 */
> +	if (!iet->fpe_active && iet->fpe_enabled) {
> +		/* Schedule IET FPE IET FPE enable */
> +		atomic_set(&iet->enable_fpe_config, 1);
> +	} else if (iet->fpe_active && !iet->fpe_enabled) {
> +		/* Schedule IET FPE IET FPE disable */
> +		atomic_set(&iet->enable_fpe_config, 0);
> +	} else {
> +		return;
> +	}
> +	schedule_work(&iet->fpe_config_task);

AFAICS the scheduled work could still be running at module removal time.
If so, you need to cancel it properly to avoid possible UaF.

/P


