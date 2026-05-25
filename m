Return-Path: <netdev+bounces-291431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a6IPLp+kFGqpPAcAu9opvQ
	(envelope-from <netdev+bounces-291431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:35:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D2E5CE097
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AEA13012E90
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1828358D27;
	Mon, 25 May 2026 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ipgSBdP9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50930EF90
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779737756; cv=none; b=j6q+HsSj4NIyBux1MCC1jZCWGOJNZHjZylGtPc+IpyoQ6llLlLcyD5bpJvNsUcD0Jz20KXiJCSO5KtSOReI71fmH7N+NXU8xEQAEhBnIvflxvEYwsmy27ll4lf/nUHFyUfaf6yd8pU2WzBgYVzlTbqMdtf426bKRyDV9jwkrT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779737756; c=relaxed/simple;
	bh=dMQv0abz2E1qOv1imkRy86gNBYaPAFFrHyRoR22L15s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwD3cq5XVCWfnVxqR32nV7kVnvrvpA8v18R1aMcmd5UocG1TozhaOdpPWwfMaLqIYy2HHO0hkHoUkmcv9B9LV+5bdIRLFqT9JDbtKrPNPIFzQ4GTjlGOGMU/1yJEpEUobct6lqiJgewJ64axdmqe1t/rlMRkk1lrbDXC5Es3csE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ipgSBdP9; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2DD48C79AA7;
	Mon, 25 May 2026 19:35:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F0B7D5FEFF;
	Mon, 25 May 2026 19:35:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1B3510888059;
	Mon, 25 May 2026 21:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779737750; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=vRkAeET5rv8Z8DTQNlN8D1MILGQswgQciWtn2IPNIxQ=;
	b=ipgSBdP9cOiYncW4sr4kQ8jZqd9KUKpT3G+Sg8bq4gMbotsFZq9S4Vy8tLh3q08rwuvsiB
	arNaiWup5zG2yyaTs0C6l0VKhtmKXDV7cx+WkSpvXSHiH0uSFXa80VyPk1kKn5bOCKK754
	6+vW2rA/069L+f/g+L1mURPdNKwI2vENcf/Bi21A/DbK2SskJLkTME4HoJ6aHaY21INXj/
	Iro/aOm9K06BYoiurj67AjdwpFgQrX0BJgoSaR+oux83S7sG3v6R0Zkgfummsc0+GgHCC5
	DswrLmpO6qE7EZzuk9VAf2WmxQeECDmqjOcjc8vKkffBfaqhwTqBngyucmxLHg==
Message-ID: <7f194a90-8bf6-4217-b5fa-c003b3dc85b3@bootlin.com>
Date: Mon, 25 May 2026 21:35:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: ti: icssg-prueth: Add ethtool ops
 for Frame Preemption MAC Merge
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
 <20260525182700.3135858-3-m-malladi@ti.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260525182700.3135858-3-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291431-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[ti.com,gmail.com,linux.dev,kernel.org,intel.com,arndb.de,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:url,bootlin.com:dkim,bootlin.com:mid,ti.com:email]
X-Rspamd-Queue-Id: 12D2E5CE097
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/25/26 20:27, Meghana Malladi wrote:
> From: MD Danish Anwar <danishanwar@ti.com>
> 
> Add driver support for viewing and changing the MAC Merge sublayer
> parameters via ethtool ops: .set_mm(), .get_mm() and .get_mm_stats().
> 
> The minimum size of non-final mPacket fragments supported by the firmware
> without leading errors is 64 Bytes (including FCS). Verify time bounded to
> 1-128 ms per 802.3-2018 clause 30.14.1.6. Add a check to ensure
> user passed tx_min_frag_size argument via ethtool, honors this.
> Add pa stats registers to check statistics for preemption, which can be
> dumped using ethtool ops.
> 
> Fix emac_get_stat_by_name() to return u64 instead of int and return 0 on
> error instead of -EINVAL. This prevents invalid stat lookups from corrupting
> output stats with signed error codes cast to u64. Error conditions are still
> logged via netdev_err().
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 
> v6-v5:
> - Initialize tx_min_frag_size and verify_time with valid values
>    to avoid returning corrupted values during get_mm()
> - Fix rx_min_frag_size to ETH_ZLEN excluding ETH_FCS_LEN
> - Fix return codes for emac_set_mm()
> All the above changes address the comments raised by sashiko
> 
>   drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 106 ++++++++++++++++++
>   drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   7 +-
>   drivers/net/ethernet/ti/icssg/icssg_qos.h     |  46 ++++++++
>   drivers/net/ethernet/ti/icssg/icssg_stats.c   |   4 +-
>   drivers/net/ethernet/ti/icssg/icssg_stats.h   |   7 +-
>   .../net/ethernet/ti/icssg/icssg_switch_map.h  |   5 +
>   6 files changed, 168 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index b715af21d23ac..ee940051644d6 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> @@ -294,6 +294,109 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
>   	return 0;
>   }
>   
> +static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	enum icssg_ietfpe_verify_states verify_status;
> +
> +	if (emac->is_sr1)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&iet->fpe_lock);
> +	state->tx_enabled = iet->fpe_enabled;
> +	state->tx_min_frag_size = iet->tx_min_frag_size;
> +	state->tx_active = iet->fpe_active;
> +	state->verify_enabled = iet->mac_verify_configure;
> +	state->verify_time = iet->verify_time_ms;
> +	verify_status = iet->verify_status;
> +	mutex_unlock(&iet->fpe_lock);
> +
> +	state->rx_min_frag_size = ETH_ZLEN;
> +	state->pmac_enabled = true;
> +
> +	switch (verify_status) {
> +	case ICSSG_IETFPE_STATE_DISABLED:
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +		break;
> +	case ICSSG_IETFPE_STATE_INITIAL:
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
> +		break;
> +	case ICSSG_IETFPE_STATE_VERIFYING:
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
> +		break;
> +	case ICSSG_IETFPE_STATE_SUCCEEDED:
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
> +		break;
> +	case ICSSG_IETFPE_STATE_FAILED:
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
> +		break;
> +	default:
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
> +		break;
> +	}
> +
> +	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
> +	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
> +	 */
> +	state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
> +
> +	return 0;
> +}
> +
> +static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
> +		       struct netlink_ext_ack *extack)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int err;
> +
> +	if (emac->is_sr1)
> +		return -EOPNOTSUPP;
> +
> +	if (!cfg->pmac_enabled) {
> +		NL_SET_ERR_MSG_MOD(extack, "preemptible MAC is always enabled");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = icssg_qos_validate_tx_min_frag_size(cfg->tx_min_frag_size, extack);
> +	if (err)
> +		return err;
> +
> +	err = icssg_qos_validate_verify_time(cfg->verify_time, extack);
> +	if (err)
> +		return err;

The ethnl code already validates the verify_time :

https://elixir.bootlin.com/linux/v7.0.9/source/net/ethtool/mm.c#L153

> +
> +	mutex_lock(&iet->fpe_lock);
> +	iet->verify_time_ms = cfg->verify_time;
> +	iet->tx_min_frag_size = cfg->tx_min_frag_size;
> +	iet->fpe_enabled = cfg->tx_enabled;
> +	iet->mac_verify_configure = cfg->verify_enabled;
> +	err = icssg_config_ietfpe(ndev, cfg->tx_enabled);
> +	mutex_unlock(&iet->fpe_lock);
> +
> +	return err;
> +}
> +
> +static void emac_get_mm_stats(struct net_device *ndev,
> +			      struct ethtool_mm_stats *s)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +
> +	if (emac->is_sr1)
> +		return;
> +
> +	if (!emac->prueth->pa_stats)
> +		return;
> +
> +	/* MACMergeHoldCount stats is not tracked by the firmware */
> +	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
> +	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
> +	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
> +	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
> +	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
> +}
> +
>   const struct ethtool_ops icssg_ethtool_ops = {
>   	.get_drvinfo = emac_get_drvinfo,
>   	.get_msglevel = emac_get_msglevel,
> @@ -317,5 +420,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
>   	.set_eee = emac_set_eee,
>   	.nway_reset = emac_nway_reset,
>   	.get_rmon_stats = emac_get_rmon_stats,
> +	.get_mm = emac_get_mm,
> +	.set_mm = emac_set_mm,
> +	.get_mm_stats = emac_get_mm_stats,
>   };
>   EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 85f7017d2c8e7..61320c252bec2 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -45,6 +45,7 @@
>   #include "icss_iep.h"
>   #include "icssg_switch_map.h"
>   #include "icssg_qos.h"
> +#include "icssg_stats.h"
>   
>   #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>   #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
> @@ -58,8 +59,8 @@
>   
>   #define ICSSG_MAX_RFLOWS	8	/* per slice */
>   
> -#define ICSSG_NUM_PA_STATS	32
> -#define ICSSG_NUM_MIIG_STATS	60
> +#define ICSSG_NUM_PA_STATS	ARRAY_SIZE(icssg_all_pa_stats)
> +#define ICSSG_NUM_MIIG_STATS	ARRAY_SIZE(icssg_all_miig_stats)
>   /* Number of ICSSG related stats */
>   #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
>   #define ICSSG_NUM_STANDARD_STATS 31
> @@ -460,7 +461,7 @@ int emac_fdb_flow_id_updated(struct prueth_emac *emac);
>   
>   void icssg_stats_work_handler(struct work_struct *work);
>   void emac_update_hardware_stats(struct prueth_emac *emac);
> -int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
> +u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
>   
>   /* Common functions */
>   void prueth_cleanup_rx_chns(struct prueth_emac *emac,
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
> index 9355e96bbcda8..87ca031afcaa4 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_qos.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
> @@ -13,6 +13,7 @@
>   #define ICSSG_EXPRESS_Q_MASK_ALL		0xFF
>   #define ICSSG_IET_MAX_VERIFY_TIME		128
>   #define ICSSG_IET_MIN_VERIFY_TIME		1
> +#define ICSSG_IET_MAX_TX_MIN_FRAG_SIZE		252
>   
>   /**
>    * enum icssg_ietfpe_verify_states - status of MAC Merge Verify returned by firmware
> @@ -63,4 +64,49 @@ void icssg_qos_link_state_update(struct net_device *ndev);
>   int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>   			   void *type_data);
>   int icssg_config_ietfpe(struct net_device *ndev, bool enable);
> +static inline int icssg_qos_validate_tx_min_frag_size(u32 min_frag_size,
> +						      struct netlink_ext_ack *extack)
> +{
> +	/* Firmware takes min_frag_size including FCS length.
> +	 * The firmware requires the fragment size (including FCS) to be
> +	 * a multiple of 64 bytes. Since 64 bytes = ETH_ZLEN + ETH_FCS_LEN,
> +	 * valid user-facing values are: 60, 124, 188, 252.
> +	 */
> +
> +	if (min_frag_size < ETH_ZLEN) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "tx_min_frag_size must be at least 60 bytes");
> +		return -EINVAL;
> +	}
> +
> +	if (min_frag_size > ICSSG_IET_MAX_TX_MIN_FRAG_SIZE) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "tx_min_frag_size must not exceed 252 bytes");
> +		return -EINVAL;
> +	}
> +
> +	if ((min_frag_size + ETH_FCS_LEN) % (ETH_ZLEN + ETH_FCS_LEN)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "tx_min_frag_size must be a multiple of 64 bytes minus 4");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

Is there any reason this helper is in a header file instead
of being directly in icssg_ethtool.c ?

> +
> +static inline int icssg_qos_validate_verify_time(u32 verify_time_ms,
> +						 struct netlink_ext_ack *extack)
> +{
> +	/* 802.3-2018 clause 30.14.1.6: aMACMergeVerifyTime must be
> +	 * between 1 and 128 ms inclusive
> +	 */
> +	if (verify_time_ms < ICSSG_IET_MIN_VERIFY_TIME ||
> +	    verify_time_ms > ICSSG_IET_MAX_VERIFY_TIME) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "verify_time must be between 1 and 128 ms");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

And this shouldn't be needed as the ethnl mm code already validates
these boundaries, as they are straight from the standard.

>   #endif /* __NET_TI_ICSSG_QOS_H */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> index 7159baa0155cf..cfdb6f5dc5da1 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> @@ -74,7 +74,7 @@ void icssg_stats_work_handler(struct work_struct *work)
>   }
>   EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
>   
> -int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
> +u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
>   {
>   	int i;
>   
> @@ -91,5 +91,5 @@ int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
>   	}
>   
>   	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
> -	return -EINVAL;
> +	return 0;
>   }
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> index 5ec0b38e0c67d..8073deac35c3e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> @@ -8,8 +8,6 @@
>   #ifndef __NET_TI_ICSSG_STATS_H
>   #define __NET_TI_ICSSG_STATS_H
>   
> -#include "icssg_prueth.h"
> -
>   #define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */
>   
>   struct miig_stats_regs {
> @@ -189,6 +187,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
>   	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
>   	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
>   	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
> +	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
>   	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
>   	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
>   	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
> index 7e053b8af3ece..855fd4ed0b3f6 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
> @@ -256,6 +256,11 @@
>   #define FW_INF_DROP_PRIOTAGGED		0x0148
>   #define FW_INF_DROP_NOTAG		0x0150
>   #define FW_INF_DROP_NOTMEMBER		0x0158
> +#define FW_PREEMPT_BAD_FRAG		0x0160
> +#define FW_PREEMPT_ASSEMBLY_ERR		0x0168
> +#define FW_PREEMPT_FRAG_CNT_TX		0x0170
> +#define FW_PREEMPT_ASSEMBLY_OK		0x0178
> +#define FW_PREEMPT_FRAG_CNT_RX		0x0180
>   #define FW_RX_EOF_SHORT_FRMERR		0x0188
>   #define FW_RX_B0_DROP_EARLY_EOF		0x0190
>   #define FW_TX_JUMBO_FRM_CUTOFF		0x0198

Maxime

