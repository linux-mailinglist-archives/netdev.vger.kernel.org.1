Return-Path: <netdev+bounces-278245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHCVHdGH3WkgfQkAu9opvQ
	(envelope-from <netdev+bounces-278245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:18:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E223F4651
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0B713017242
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDC050276;
	Tue, 14 Apr 2026 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeRmxS9+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFE8F49;
	Tue, 14 Apr 2026 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776125901; cv=none; b=bHRcc1DmBwedmB9ewDHFBBbNEaCry7zqUyHwVME7YB99o6glSx7ZDUbzl0S3VvOtgcALZeAfA4PBLQIFSdlGLsUCxmIQV8gedafLy6JSCKKWOXp022pibv6F1mlnDDRBEfdMa3rG2X6BIXgpdfG7fp7eVR8OdFKbyO46Zfnzk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776125901; c=relaxed/simple;
	bh=CRceZ72YMeCA7AV2JisCDBURFLUKBnYdwgooIReQp/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uv2Qnxy++DUovHHjNv7zOEE7xfGKFQaRzOqitiQoOgFZ4az4EeVAOqjxz0AbbszC1bnlpgjBqPVG99HX5o33SxSVjBp5vTEGyqAPHeWXFpgL0rXVv7oVS6IYXMj4m2Xs0ib4hx2LDb2fx2cdBpTr7F6Zlw90FhoY+PokXN9KLV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeRmxS9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60BFC2BCAF;
	Tue, 14 Apr 2026 00:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776125901;
	bh=CRceZ72YMeCA7AV2JisCDBURFLUKBnYdwgooIReQp/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HeRmxS9+EfkipokXLfupnR//80naGsv64ll4oaymDIGW0xFuumAu+SnyaP7ZpqDZb
	 3rlksjm0nynRK8jcbQeH0ff/Fw1KLqKSCdS54mrs8JXhPvCbp4ddKd1OaNCFoF2ExI
	 hoqVWvP2Vyw+QAO6/32ottuN0XDHU5h9AmerZtiAOZr0IEMsTM92J7AwQVWu8Fmptd
	 uMxYQfneULZrEbSvhQ98KVs6/3XrRoDYDUCOODw8sCdyMvLTWALnchp11TRseNU4hO
	 CMQ3GqSteS7JwuP3Pl1I14Y48Jyl6vCev20NhuXNGhlQbd/JNRj0VGM/ltZpGpSUSg
	 iwJ36jrjuk0Dg==
Date: Mon, 13 Apr 2026 17:18:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>, Mohsin
 Bashir <mohsin.bashr@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Zheng Jiezhen
 <zhengjiezhen@h-partners.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v05 1/6] hinic3: Add ethtool queue ops
Message-ID: <20260413171817.1e1eca30@kernel.org>
In-Reply-To: <157d5cc6e757ffa77eee01dfdc3f2159dc97905f.1775711066.git.zhuyikai1@h-partners.com>
References: <cover.1775711066.git.zhuyikai1@h-partners.com>
	<157d5cc6e757ffa77eee01dfdc3f2159dc97905f.1775711066.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278245-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[h-partners.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,nxp.com,gmail.com,huawei.com,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E3E223F4651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 11 Apr 2026 11:36:59 +0800 Fan Gong wrote:
>   Implement following ethtool callback function:
> .get_ringparam
> .set_ringparam
> 
>   These callbacks allow users to utilize ethtool for detailed
> queue depth configuration and monitoring.

> +static int hinic3_check_ringparam_valid(struct net_device *netdev,
> +					const struct ethtool_ringparam *ring)
> +{
> +	if (ring->rx_jumbo_pending || ring->rx_mini_pending) {

Can driver actually be called with non-zero values if max is not set?

> +		netdev_err(netdev, "Unsupported rx_jumbo_pending/rx_mini_pending\n");
> +		return -EINVAL;
> +	}


> +	if (ring->tx_pending > HINIC3_MAX_TX_QUEUE_DEPTH ||
> +	    ring->tx_pending < HINIC3_MIN_QUEUE_DEPTH ||
> +	    ring->rx_pending > HINIC3_MAX_RX_QUEUE_DEPTH ||
> +	    ring->rx_pending < HINIC3_MIN_QUEUE_DEPTH) {

similar question - do you need to check the upper bound?
kernel should check the input against max returned by .get

> +		netdev_err(netdev,

please use extack for errors

> +			   "Queue depth out of range tx[%d-%d] rx[%d-%d]\n",
> +			   HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_TX_QUEUE_DEPTH,
> +			   HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_RX_QUEUE_DEPTH);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hinic3_set_ringparam(struct net_device *netdev,
> +				struct ethtool_ringparam *ring,
> +				struct kernel_ethtool_ringparam *kernel_ring,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_dyna_txrxq_params q_params = {};
> +	u32 new_sq_depth, new_rq_depth;
> +	int err;
> +
> +	err = hinic3_check_ringparam_valid(netdev, ring);
> +	if (err)
> +		return err;
> +
> +	new_sq_depth = 1U << ilog2(ring->tx_pending);
> +	new_rq_depth = 1U << ilog2(ring->rx_pending);
> +	if (new_sq_depth == nic_dev->q_params.sq_depth &&
> +	    new_rq_depth == nic_dev->q_params.rq_depth)
> +		return 0;
> +
> +	if (new_sq_depth != ring->tx_pending)
> +		netdev_info(netdev, "Requested Tx depth trimmed to %d\n",
> +			    new_sq_depth);

please use extack for warnings

> +	if (new_rq_depth != ring->rx_pending)
> +		netdev_info(netdev, "Requested Rx depth trimmed to %d\n",
> +			    new_rq_depth);
> +
> +	netdev_info(netdev, "Change Tx/Rx ring depth from %u/%u to %u/%u\n",
> +		    nic_dev->q_params.sq_depth, nic_dev->q_params.rq_depth,
> +		    new_sq_depth, new_rq_depth);
> +
> +	if (!netif_running(netdev)) {
> +		hinic3_update_qp_depth(netdev, new_sq_depth, new_rq_depth);
> +	} else {
> +		q_params = nic_dev->q_params;
> +		q_params.sq_depth = new_sq_depth;
> +		q_params.rq_depth = new_rq_depth;
> +
> +		err = hinic3_change_channel_settings(netdev, &q_params);
> +		if (err) {
> +			netdev_err(netdev, "Failed to change channel settings\n");
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct ethtool_ops hinic3_ethtool_ops = {
>  	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
>  					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
> @@ -417,6 +516,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
>  	.get_msglevel                   = hinic3_get_msglevel,
>  	.set_msglevel                   = hinic3_set_msglevel,
>  	.get_link                       = ethtool_op_get_link,
> +	.get_ringparam                  = hinic3_get_ringparam,
> +	.set_ringparam                  = hinic3_set_ringparam,
>  };

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index 0a888fe4c975..3b470978714a 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> @@ -179,6 +179,8 @@ static int hinic3_sw_init(struct net_device *netdev)
>  	int err;
>  
>  	mutex_init(&nic_dev->port_state_mutex);
> +	mutex_init(&nic_dev->channel_cfg_lock);

Why do you need this mutex?
Aren't all the places you take it under rtnl_lock anyway?

> +	spin_lock_init(&nic_dev->channel_res_lock);
>  
>  	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
>  	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
> @@ -314,6 +316,15 @@ static void hinic3_link_status_change(struct net_device *netdev,
>  				      bool link_status_up)
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	unsigned long flags;
> +	bool valid;
> +
> +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> +	valid = HINIC3_CHANNEL_RES_VALID(nic_dev);
> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	if (!valid)

Why are you checking valid here? What if the state changes immediately
after unlocking?

> +		return;
>  
>  	if (link_status_up) {
>  		if (netif_carrier_ok(netdev))
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index da73811641a9..d652a5ffdc2c 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> @@ -428,6 +428,85 @@ static void hinic3_vport_down(struct net_device *netdev)
>  	}
>  }
>  
> +int
> +hinic3_change_channel_settings(struct net_device *netdev,
> +			       struct hinic3_dyna_txrxq_params *trxq_params)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_dyna_txrxq_params old_qp_params = {};
> +	struct hinic3_dyna_qp_params new_qp_params = {};
> +	struct hinic3_dyna_qp_params cur_qp_params = {};
> +	bool need_teardown = false;
> +	unsigned long flags;
> +	int err;
> +
> +	mutex_lock(&nic_dev->channel_cfg_lock);
> +
> +	hinic3_config_num_qps(netdev, trxq_params);
> +
> +	err = hinic3_alloc_channel_resources(netdev, &new_qp_params,
> +					     trxq_params);
> +	if (err) {
> +		netdev_err(netdev, "Failed to alloc channel resources\n");
> +		mutex_unlock(&nic_dev->channel_cfg_lock);
> +		return err;
> +	}
> +
> +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> +	if (!test_and_set_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags))
> +		need_teardown = true;
> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	if (need_teardown) {
> +		hinic3_vport_down(netdev);
> +		hinic3_close_channel(netdev);
> +		hinic3_uninit_qps(nic_dev, &cur_qp_params);
> +		hinic3_free_channel_resources(netdev, &cur_qp_params,
> +					      &nic_dev->q_params);
> +	}
> +
> +	if (nic_dev->num_qp_irq > trxq_params->num_qps)
> +		hinic3_qp_irq_change(netdev, trxq_params->num_qps);
> +
> +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> +	old_qp_params = nic_dev->q_params;
> +	nic_dev->q_params = *trxq_params;
> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	hinic3_init_qps(nic_dev, &new_qp_params);
> +
> +	err = hinic3_open_channel(netdev);

This "open" function allocates Rx buffers, and fails if it couldn't get
even one. That's no good.

> +	if (err)
> +		goto err_uninit_qps;
> +
> +	err = hinic3_vport_up(netdev);
> +	if (err)
> +		goto err_close_channel;
> +
> +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> +	clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags);
> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	mutex_unlock(&nic_dev->channel_cfg_lock);
> +
> +	return 0;
> +
> +err_close_channel:
> +	hinic3_close_channel(netdev);
> +err_uninit_qps:
> +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> +	nic_dev->q_params = old_qp_params;
> +	clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags);
> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	hinic3_uninit_qps(nic_dev, &new_qp_params);
> +	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
> +
> +	mutex_unlock(&nic_dev->channel_cfg_lock);

AI says:

  Can this error path lead to memory corruption?
  If need_teardown was true, the old channel resources were freed earlier in
  the function. If hinic3_open_channel() or hinic3_vport_up() fails, the code
  jumps to err_uninit_qps and restores nic_dev->q_params = old_qp_params.
  However, it doesn't appear to re-allocate those old resources or mark the
  interface as down. Could a subsequent administrative teardown or network
  traffic dereference these freed pointers?

> +
>  static int hinic3_open(struct net_device *netdev)
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> @@ -487,16 +566,33 @@ static int hinic3_close(struct net_device *netdev)
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
>  	struct hinic3_dyna_qp_params qp_params;
> +	bool need_teardown = false;
> +	unsigned long flags;
>  
>  	if (!test_and_clear_bit(HINIC3_INTF_UP, &nic_dev->flags)) {
>  		netdev_dbg(netdev, "Netdev already close, do nothing\n");
>  		return 0;
>  	}
>  
> -	hinic3_vport_down(netdev);
> -	hinic3_close_channel(netdev);
> -	hinic3_uninit_qps(nic_dev, &qp_params);
> -	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
> +	mutex_lock(&nic_dev->channel_cfg_lock);
> +
> +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> +	if (!test_and_set_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags))
> +		need_teardown = true;
> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	if (need_teardown) {
> +		hinic3_vport_down(netdev);
> +		hinic3_close_channel(netdev);
> +		hinic3_uninit_qps(nic_dev, &qp_params);
> +		hinic3_free_channel_resources(netdev, &qp_params,
> +					      &nic_dev->q_params);
> +	}
> +
> +	hinic3_free_nicio_res(nic_dev);
> +	hinic3_destroy_num_qps(netdev);
> +
> +	mutex_unlock(&nic_dev->channel_cfg_lock);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> index 9502293ff710..55b280888ad8 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> @@ -10,6 +10,9 @@
>  #include "hinic3_hw_cfg.h"
>  #include "hinic3_hwdev.h"
>  #include "hinic3_mgmt_interface.h"
> +#include "hinic3_nic_io.h"
> +#include "hinic3_tx.h"
> +#include "hinic3_rx.h"
>  
>  #define HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev)  (sizeof(*(nic_dev)->vlan_bitmap))
>  #define HINIC3_VLAN_BITMAP_SIZE(nic_dev)  \
> @@ -20,8 +23,13 @@ enum hinic3_flags {
>  	HINIC3_MAC_FILTER_CHANGED,
>  	HINIC3_RSS_ENABLE,
>  	HINIC3_UPDATE_MAC_FILTER,
> +	HINIC3_CHANGE_RES_INVALID,
>  };
>  
> +#define HINIC3_CHANNEL_RES_VALID(nic_dev) \
> +	(test_bit(HINIC3_INTF_UP, &(nic_dev)->flags) && \
> +	 !test_bit(HINIC3_CHANGE_RES_INVALID, &(nic_dev)->flags))

I don't get why you need to check both of these bits.
Can't there be one bit for "resources valid" ?
And it will only be set while device is up (of course) so no need to
also check UP (this way checking can be atomic without the spin lock).

>  enum hinic3_event_work_flags {
>  	HINIC3_EVENT_WORK_TX_TIMEOUT,
>  };
> @@ -129,6 +137,10 @@ struct hinic3_nic_dev {
>  	struct work_struct              rx_mode_work;
>  	/* lock for enable/disable port */
>  	struct mutex                    port_state_mutex;
> +	/* lock for channel configuration */
> +	struct mutex                    channel_cfg_lock;
> +	/* lock for channel resources */
> +	spinlock_t                      channel_res_lock;
>  
>  	struct list_head                uc_filter_list;
>  	struct list_head                mc_filter_list;
> @@ -143,6 +155,10 @@ struct hinic3_nic_dev {
>  
>  void hinic3_set_netdev_ops(struct net_device *netdev);
>  int hinic3_set_hw_features(struct net_device *netdev);
> +int
> +hinic3_change_channel_settings(struct net_device *netdev,
> +			       struct hinic3_dyna_txrxq_params *trxq_params);
> +
>  int hinic3_qps_irq_init(struct net_device *netdev);
>  void hinic3_qps_irq_uninit(struct net_device *netdev);
>  
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> index 12eefabcf1db..3791b9bc865b 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> @@ -14,6 +14,10 @@ struct hinic3_nic_dev;
>  #define HINIC3_RQ_WQEBB_SHIFT      3
>  #define HINIC3_SQ_WQEBB_SIZE       BIT(HINIC3_SQ_WQEBB_SHIFT)
>  
> +#define HINIC3_MAX_TX_QUEUE_DEPTH  65536
> +#define HINIC3_MAX_RX_QUEUE_DEPTH  16384
> +#define HINIC3_MIN_QUEUE_DEPTH     128
> +
>  /* ******************** RQ_CTRL ******************** */
>  enum hinic3_rq_wqe_type {
>  	HINIC3_NORMAL_RQ_WQE = 1,


