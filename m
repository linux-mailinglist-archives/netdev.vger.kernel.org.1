Return-Path: <netdev+bounces-291429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJhsIbagFGo/PAcAu9opvQ
	(envelope-from <netdev+bounces-291429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:19:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EBB5CDFC5
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CF39300407A
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56812472A2;
	Mon, 25 May 2026 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tt50jXr8"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD933EF
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779736751; cv=none; b=L7EdzV2Z7S8tbRN/GjToZ1Bd0qyL06KpC3wD+T3YRskwB8lbFjVAWOeYm1duoUGSscwzNcjRmkbuD2qcPek5jONEfD70G1wnF9IVEzXtyhZlGw6Qsa6v139wAKYhYuabHKXF2fllQ8mvb+W3KCD7FRIeaUfLKz6yYmWIi3oOWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779736751; c=relaxed/simple;
	bh=odSu/YNWPbtaFcoe0wGTeL8pwuRyrYuhaoWEa2FTOgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOUdODLlmMXXLqKCGHK6XhthPdx0nI4+/Q3d9fGjLVejbBn+QkZi9vwSSO3AEYcRFcU+1llfbN0Wuav1Y6iFvZYBD25xA4UUYkwclDo5WxewAqMx9HMNdJKI+0wuJmiReT87xK3LJMStooOVHtFcgt3edbYFFBg1pZH0HFOgtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tt50jXr8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5BFF34E42D47;
	Mon, 25 May 2026 19:19:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 09E965FEFF;
	Mon, 25 May 2026 19:19:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED26A10888059;
	Mon, 25 May 2026 21:18:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779736744; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ObDGARjY7FQPDXSHRudLvXieCDCqP0ZMwD1vh2MeN/M=;
	b=tt50jXr8zuHfg5IwtMBrX84P7nUtAGwiXs3mDBcr1mg1MFR1gfzJm/ra3RWy8eaWDGaMRe
	yp86OfAS4ioxbkR822ZXWt2cX3d6nY+On2M9VA7S3ht0vdUZFFKGtjKwTRcuHpwWbHLBdY
	McpG3gyOg4xCl5NmaGyegb0w+vleSfiOd9ldMCm7dy6WANGvwl1RBUh6G6sY5coR0AS/iR
	yNRx/yWqkv/gp12Er0jcM6Hjr53Hy17yhmWfPcj+XXgBIUUte1nDRI6heyd/cOdPdEtrQX
	4Xghi39jzHdVX5g+7nlw1ySYb5F6G4VFfOA4Qao6osOGDSgADixAjT6UV5eFzg==
Message-ID: <de0255c8-d751-4220-b0ab-88aef3a15f9a@bootlin.com>
Date: Mon, 25 May 2026 21:18:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] net: ti: icssg-prueth: Add Frame
 Preemption MAC Merge support
To: Meghana Malladi <m-malladi@ti.com>, liuhangbin@gmail.com,
 h-mittal1@ti.com, haokexin@gmail.com, vadim.fedorenko@linux.dev,
 devnexen@gmail.com, horms@kernel.org, jacob.e.keller@intel.com,
 arnd@arndb.de, afd@ti.com, basharath@couthit.com, parvathi@couthit.com,
 vladimir.oltean@nxp.com, rogerq@kernel.org, danishanwar@ti.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20260525182700.3135858-1-m-malladi@ti.com>
 <20260525182700.3135858-2-m-malladi@ti.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260525182700.3135858-2-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291429-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[ti.com,gmail.com,linux.dev,kernel.org,intel.com,arndb.de,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,ti.com:email,bootlin.com:mid,bootlin.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 81EBB5CDFC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Meghana,

On 5/25/26 20:26, Meghana Malladi wrote:
> From: MD Danish Anwar <danishanwar@ti.com>
> 
> Introduce QoS infrastructure for Frame Preemption (FPE) support in
> the ICSSG Ethernet driver.
> 
> prueth_qos_iet tracks FPE enable/active state and verify state machine
> status via firmware-reported enum icssg_ietfpe_verify_states.
> icssg_config_ietfpe() configures IET FPE in firmware, triggers
> verify state machine based on ethtool MAC Merge parameters.
> Polls firmware verify status up to 3 times with verify_time_ms intervals
> and driver handles timeout by logging error and returning.
> In case of any failure during configuration for enable/disable,
> IET FPE falls back to disabled state.
> 
> For MQPRIO qdisc support all queues are express by default later
> gets override by user-provided preemptible_tcs bitmask via tc qdisc mask
> Preempt mask configuration: Maps traffic classes to queue express/preemptible
> state and applied only when FPE is active (Tx enabled)
> 
> Verify state machine re-triggers on link up/down events based on
> fpe_enabled and fpe_active flags, and for memory protection, fpe_lock
> serializes all FPE state mutations, preventing races between ethtool
> config, qdisc setup, and link events
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>

There's quite a lot of checkpatch output for this patch, I'll let you 
browse through it :)

Also keep in mind that we still recommend 80 chars on net.

Besides that, I have a few comments, see below :)

> ---
> 
> v6-v5:
> - Balance fpe_lock mutex lifecycle on all error paths
> - Remove deadcode inside icssg_iet_set_preempt_mask()
> - Add fallback label inside icssg_config_ietfpe() to fix
>    stale state machine handling.
> - Replace netdev_err with netdev_info and netdev_dbg wherever
>    applicable
> - Remove EXPORT_SYMBOL_GPL for icssg_config_ietfpe()
> - Remove redundant code inside icssg_qos_init()
> - qdisc deletion path clears per-queue map as well.
> - Protect all read/writes to p_mqprio with a mutex
> All the above changes address the comments raised by sashiko
> 
>   drivers/net/ethernet/ti/Makefile             |   3 +-
>   drivers/net/ethernet/ti/icssg/icssg_common.c |   1 +
>   drivers/net/ethernet/ti/icssg/icssg_config.h |   9 -
>   drivers/net/ethernet/ti/icssg/icssg_prueth.c |   6 +
>   drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
>   drivers/net/ethernet/ti/icssg/icssg_qos.c    | 269 +++++++++++++++++++
>   drivers/net/ethernet/ti/icssg/icssg_qos.h    |  66 +++++
>   7 files changed, 346 insertions(+), 10 deletions(-)
>   create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>   create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
> 
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index f4276c9a77620..d19bcd25c9d07 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -46,6 +46,7 @@ icssg-y := icssg/icssg_common.o \
>   	   icssg/icssg_config.o \
>   	   icssg/icssg_mii_cfg.o \
>   	   icssg/icssg_stats.o \
> -	   icssg/icssg_ethtool.o
> +	   icssg/icssg_ethtool.o \
> +	   icssg/icssg_qos.o
>   
>   obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index a28a608f9bf4b..c3ee97e96cd50 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -1724,6 +1724,7 @@ void prueth_netdev_exit(struct prueth *prueth,
>   
>   	netif_napi_del(&emac->napi_rx);
>   
> +	mutex_destroy(&emac->qos.iet.fpe_lock);
>   	pruss_release_mem_region(prueth->pruss, &emac->dram);
>   	free_netdev(emac->ndev);
>   	prueth->emac[mac] = NULL;
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
> index 60d69744ffae2..1ac202f855ed4 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
> @@ -323,13 +323,4 @@ struct prueth_fdb_slot {
>   	u8 fid;
>   	u8 fid_c2;
>   } __packed;
> -
> -enum icssg_ietfpe_verify_states {
> -	ICSSG_IETFPE_STATE_UNKNOWN = 0,
> -	ICSSG_IETFPE_STATE_INITIAL,
> -	ICSSG_IETFPE_STATE_VERIFYING,
> -	ICSSG_IETFPE_STATE_SUCCEEDED,
> -	ICSSG_IETFPE_STATE_FAILED,
> -	ICSSG_IETFPE_STATE_DISABLED
> -};
>   #endif /* __NET_TI_ICSSG_CONFIG_H */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 591be5c8056b4..39f379df923bf 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -392,6 +392,8 @@ static void emac_adjust_link(struct net_device *ndev)
>   		} else {
>   			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
>   		}
> +
> +		icssg_qos_link_state_update(ndev);
>   	}
>   
>   	if (emac->link) {
> @@ -1652,6 +1654,7 @@ static const struct net_device_ops emac_netdev_ops = {
>   	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
>   	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
>   	.ndo_xsk_wakeup = prueth_xsk_wakeup,
> +	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
>   };
>   
>   static int prueth_netdev_init(struct prueth *prueth,
> @@ -1686,6 +1689,8 @@ static int prueth_netdev_init(struct prueth *prueth,
>   
>   	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
>   
> +	icssg_qos_init(ndev);
> +
>   	ret = pruss_request_mem_region(prueth->pruss,
>   				       port == PRUETH_PORT_MII0 ?
>   				       PRUSS_MEM_DRAM0 : PRUSS_MEM_DRAM1,
> @@ -1793,6 +1798,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>   free:
>   	pruss_release_mem_region(prueth->pruss, &emac->dram);
>   free_ndev:
> +	mutex_destroy(&emac->qos.iet.fpe_lock);
>   	emac->ndev = NULL;
>   	prueth->emac[mac] = NULL;
>   	free_netdev(ndev);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index df93d15c5b786..85f7017d2c8e7 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -44,6 +44,7 @@
>   #include "icssg_config.h"
>   #include "icss_iep.h"
>   #include "icssg_switch_map.h"
> +#include "icssg_qos.h"
>   
>   #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>   #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
> @@ -254,6 +255,7 @@ struct prueth_emac {
>   	struct bpf_prog *xdp_prog;
>   	struct xdp_attachment_info xdpi;
>   	int xsk_qid;
> +	struct prueth_qos qos;
>   };
>   
>   /* The buf includes headroom compatible with both skb and xdpf */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> new file mode 100644
> index 0000000000000..2781abf39e9bb
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Texas Instruments ICSSG PRUETH QoS submodule
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include "icssg_prueth.h"
> +#include "icssg_switch_map.h"
> +
> +static void icssg_iet_set_preempt_mask(struct prueth_emac *emac)
> +{
> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
> +	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int prempt_mask = 0, i;
> +	u8 tc, num_tc;
> +
> +	if (!iet->preemptible_tcs)
> +		goto reset_hw;
> +
> +	if (iet->fpe_active) {
> +		/* Configure the queues based on the preemptible tc map set by the user */
> +		num_tc = p_mqprio->mqprio.qopt.num_tc;
> +		for (tc = 0; tc < num_tc; tc++) {
> +			/* check if the tc is preemptive or not */
> +			if (iet->preemptible_tcs & BIT(tc)) {
> +				for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
> +					/* Set all the queues in this tc as preemptive queues */
> +					writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +				}
> +			} else {
> +				/* Set all the queues in this tc as express queues */
> +				for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
> +					writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +					prempt_mask |= BIT(i);
> +				}
> +			}
> +			netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
> +		}
> +		writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
> +		return;
> +	}
> +
> +reset_hw:
> +	/* Reset to default: all queues as express */
> +	for (i = 0; i < ICSSG_MAX_TC_QUEUES; i++)
> +		writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +	writeb(ICSSG_EXPRESS_Q_MASK_ALL, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
> +}
> +
> +static int icssg_iet_verify_wait(struct prueth_emac *emac)
> +{
> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int try = 3;
> +
> +	do {
> +		msleep(iet->verify_time_ms);
> +		iet->verify_status = readb(config + PRE_EMPTION_VERIFY_STATUS);
> +		if (iet->verify_status == ICSSG_IETFPE_STATE_SUCCEEDED)
> +			return 0;
> +	} while (--try > 0);

You can replace that whole loop with a readb_poll_timeout, to avoid
open-coding it.

> +
> +	netdev_err(emac->ndev, "MAC Verify timeout\n");
> +	return -ETIMEDOUT;
> +}
> +
> +/* Direct synchronous configuration of IET FPE.
> + * Caller must hold iet->fpe_lock.
> + */
> +int icssg_config_ietfpe(struct net_device *ndev, bool enable)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int ret;
> +	u8 val;
> +
> +	lockdep_assert_held(&iet->fpe_lock);
> +
> +	if (!netif_running(ndev)) {
> +		netdev_dbg(ndev, "cannot change IET/FPE state when interface is down\n");
> +		return 0;
> +	}
> +
> +	/* Update FPE Tx enable bit (PRE_EMPTION_ENABLE_TX) if
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
> +		writew(iet->tx_min_frag_size + ETH_FCS_LEN,
> +		       config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
> +		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
> +	} else {
> +		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
> +		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
> +	}
> +
> +	/* Send command to enable FPE Tx side. Rx is always enabled */
> +	ret = icssg_set_port_state(emac,
> +				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
> +					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
> +	if (ret) {
> +		netdev_err(ndev, "TX preempt %s command failed\n",
> +			   str_enable_disable(enable));
> +		goto fallback;
> +	}
> +
> +	if (enable && iet->mac_verify_configure) {
> +		ret = icssg_iet_verify_wait(emac);
> +		if (ret) {
> +			netdev_err(ndev, "MAC Verification failed with timeout\n");
> +			goto disable_tx;
> +		}
> +	} else if (enable) {
> +		/* Give firmware some time to update PRE_EMPTION_ACTIVE_TX state */
> +		usleep_range(100, 200);
> +	}
> +
> +	if (enable) {
> +		val = readb(config + PRE_EMPTION_ACTIVE_TX);
> +		if (val != 1) {
> +			netdev_err(ndev,
> +				   "Firmware fails to activate IET/FPE\n");
> +			ret = -EIO;
> +			goto disable_tx;
> +		}
> +		iet->fpe_active = true;
> +	} else {
> +		iet->fpe_active = false;
> +	}
> +
> +	icssg_iet_set_preempt_mask(emac);
> +	netdev_info(ndev, "IET FPE %s successfully\n",
> +		   str_enable_disable(iet->fpe_active));
> +	return ret;
> +
> +disable_tx:
> +	icssg_set_port_state(emac, ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
> +fallback:
> +	writeb(0, config + PRE_EMPTION_ENABLE_TX);
> +	writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
> +	iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
> +	iet->fpe_active =  false;
> +	return ret;
> +}
> +
> +void icssg_qos_init(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +
> +	mutex_init(&iet->fpe_lock);
> +	/* Set default values to prevent garbage values during .get_mm() */
> +	mutex_lock(&iet->fpe_lock);
> +	iet->verify_time_ms = ICSSG_IET_MAX_VERIFY_TIME;
> +	iet->tx_min_frag_size = ETH_ZLEN;
> +	mutex_unlock(&iet->fpe_lock);
> +}
> +EXPORT_SYMBOL_GPL(icssg_qos_init);
> +
> +static int icssg_iet_change_preemptible_tcs(struct prueth_emac *emac)
> +{
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int ret;
> +
> +	mutex_lock(&iet->fpe_lock);
> +	ret = icssg_config_ietfpe(emac->ndev, iet->fpe_enabled);
> +	mutex_unlock(&iet->fpe_lock);
> +
> +	return ret;
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
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int ret;
> +
> +	/* Validate parameters */
> +	if (mqprio->qopt.num_tc > ICSSG_MAX_TC_QUEUES) {
> +		netdev_err(ndev, "Number of traffic classes (%u) exceeds hardware limit\n",
> +			   mqprio->qopt.num_tc);
> +		return -EINVAL;
> +	}
> +
> +	if (mqprio->flags & TC_MQPRIO_F_SHAPER) {
> +		netdev_err(ndev, "traffic shaping is not supported\n");
> +		return -EINVAL;

Maybe -EOPNOTSUPP ?

> +	}
> +
> +	if (mqprio->flags & (TC_MQPRIO_F_MIN_RATE | TC_MQPRIO_F_MAX_RATE)) {
> +		netdev_err(ndev, "per-queue rate limiting is not supported\n");
> +		return -EINVAL;

Same

> +	}
> +
> +	if (!mqprio->qopt.num_tc) {
> +		netdev_reset_tc(ndev);
> +	} else {
> +		netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
> +	}
> +
> +	mutex_lock(&iet->fpe_lock);
> +	if (!mqprio->qopt.num_tc) {
> +		iet->preemptible_tcs = 0;
> +	} else {
> +		memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
> +		iet->preemptible_tcs = mqprio->preemptible_tcs;
> +	}
> +	mutex_unlock(&iet->fpe_lock);
> +
> +	netdev_dbg(ndev, "dev->num_tc %u dev->real_num_tx_queues %u\n",
> +		   ndev->num_tc, ndev->real_num_tx_queues);
> +
> +	ret = icssg_iet_change_preemptible_tcs(emac);
> +	return ret;

Simplify this with :

	return icssg_iet_change_preemptible_tcs(emac);

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
> +void icssg_qos_link_state_update(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int ret;
> +
> +	ret = icssg_iet_change_preemptible_tcs(emac);
> +	if (ret)
> +		netdev_dbg(ndev, "IET FPE %s failed\n",
> +		   str_enable_disable(iet->fpe_active));
> +}
> +EXPORT_SYMBOL_GPL(icssg_qos_link_state_update);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
> new file mode 100644
> index 0000000000000..9355e96bbcda8
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#ifndef __NET_TI_ICSSG_QOS_H
> +#define __NET_TI_ICSSG_QOS_H
> +
> +#include <linux/atomic.h>
> +#include <linux/netdevice.h>
> +#include <net/pkt_sched.h>
> +
> +#define ICSSG_MAX_TC_QUEUES			8
> +#define ICSSG_EXPRESS_Q_MASK_ALL		0xFF
> +#define ICSSG_IET_MAX_VERIFY_TIME		128
> +#define ICSSG_IET_MIN_VERIFY_TIME		1
> +
> +/**
> + * enum icssg_ietfpe_verify_states - status of MAC Merge Verify returned by firmware
> + * @ICSSG_IETFPE_STATE_UNKNOWN:
> + *	verification status is unknown
> + * @ICSSG_IETFPE_STATE_INITIAL:
> + *	Firmware returns this if verify state diagram is idle
> + * @ICSSG_IETFPE_STATE_VERIFYING:
> + *	Firmware returns this if verification is ongoing
> + * @ICSSG_IETFPE_STATE_SUCCEEDED:
> + *	Firmware returns this if verify state diagram completes verification
> + * @ICSSG_IETFPE_STATE_FAILED:
> + *	Firmware returns this if verify state diagram fails during verification
> + * @ICSSG_IETFPE_STATE_DISABLED:
> + *	verification is disabled by the driver
> + */
> +enum icssg_ietfpe_verify_states {
> +	ICSSG_IETFPE_STATE_UNKNOWN = 0,
> +	ICSSG_IETFPE_STATE_INITIAL,
> +	ICSSG_IETFPE_STATE_VERIFYING,
> +	ICSSG_IETFPE_STATE_SUCCEEDED,
> +	ICSSG_IETFPE_STATE_FAILED,
> +	ICSSG_IETFPE_STATE_DISABLED
> +};
> +
> +struct prueth_qos_mqprio {
> +	struct tc_mqprio_qopt_offload mqprio;
> +};
> +
> +struct prueth_qos_iet {
> +	bool fpe_enabled;
> +	bool mac_verify_configure;
> +	u32 tx_min_frag_size;
> +	u32 verify_time_ms;
> +	bool fpe_active;
> +	enum icssg_ietfpe_verify_states verify_status;
> +	struct mutex fpe_lock;

Checkpatch already says it, but you need to document what this
mutex is protecting.

> +	u8 preemptible_tcs;
> +};
> +
> +struct prueth_qos {
> +	struct prueth_qos_iet iet;
> +	struct prueth_qos_mqprio mqprio;
> +};
> +
> +void icssg_qos_init(struct net_device *ndev);
> +void icssg_qos_link_state_update(struct net_device *ndev);
> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
> +			   void *type_data);
> +int icssg_config_ietfpe(struct net_device *ndev, bool enable);
> +#endif /* __NET_TI_ICSSG_QOS_H */

Thanks,

Maxime

