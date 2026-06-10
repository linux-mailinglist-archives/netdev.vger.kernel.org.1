Return-Path: <netdev+bounces-297833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 79SROTPHKWqtdAMAu9opvQ
	(envelope-from <netdev+bounces-297833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:21:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA7466CBE6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:21:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DG98uEZF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297833-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297833-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59384304B6B0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DEA399351;
	Wed, 10 Jun 2026 20:21:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71FF40BCAC
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 20:21:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122865; cv=none; b=MNRbMwpv6bHN9E+s6QlaKAlpIC+19ay30/4T3ddJ9cPiPzPqgY0qOnT94hgZ3cTbke0oN5qKMmqiPzdiA9yl0FzRGb9dKuiJWwakgESkCl5QzDxStKdP/Qgqwgfqit36ulq9MNYEo+QBX15klmnyqXm58ZH4zWG3n91oDVJyX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122865; c=relaxed/simple;
	bh=54Q9BiumGXtgqWjburOJYtkQO02M+DtdSWq6OcHCfZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5DIeHvwehLmht6Y5WKASfVer4PQZmh/vc97c1QEaZr72o1qYuJFaLUTqiC/1AwUpXF4SQDydsUG053W79g/LnZJhO79c8vNoatuKVkYekHELVHZXEnpG6Sp4aPQGxuBUNMPe4Ux5o0thQhd2SBlIdFxceRZluHlcHa/lbZO8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG98uEZF; arc=none smtp.client-ip=74.125.82.46
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1363fe80fe8so10472930c88.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781122863; x=1781727663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+CsfbERQCzxUEhRNgzJDaQwWVwOuXtF/8wRmRsz0ISs=;
        b=DG98uEZFTu2qVu8WUjWM1AqQiFOKtbelMjoTS8OIM91SW2oWwctIFRLwmlT7vKMqe9
         7/fHhyX5teJv3Uc6yAgGcIuOvDyL/JpjYGBI6xDzhwm9ZYCo+lZ3Yr2+JBhfIseOXEn5
         YGp7iq+MpMTXyqSs8CN+tUo63XpkHCj5j9rnevGruYCO+NoVNbeF+gNd3Uh2J1E7XP5J
         /eXbgvmh4T/bNfg50rJWA+y4N3bCheAHp1U3EMFzuA1Yzw0YYHskb7vL541xgSzDqL+x
         eyNkOfMa8CUtTHz9J5D0LRyYBcDxMQd3vjPapS6n72pl/I1/7vzjJSK9f1/fM0Y7KTbC
         lSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781122863; x=1781727663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CsfbERQCzxUEhRNgzJDaQwWVwOuXtF/8wRmRsz0ISs=;
        b=ehBy0A3y6dKiiwHjvXD4jH6h6ntFMfK0TEr1S3HKYZUSpbmKdJ5I3Cu4rKwJR1/ouE
         rx8R9w5qmlnjGRmt3R24jE6F71rt5T7WaqWOXt+7l46lRBuZ+iNEyY3pZXVkNEivGsPR
         oOLV7nO26rYKYNiy++dgJjuMWjEPWDCzr3DRT7ECRlHPL9pbMjKLci2EXQfZlT6gBeXX
         gLfa5QNJOs1fmY/4KzbOrMrqiJxCM+bVszBpM1U/CMEElP8Bqup9kw0Afchmm+8f0rVZ
         yrOk7gNBTOvRpfzkp3lB94YS6B7mcz2UYXZFdj88Mpk6hR+ItOQKXolOlr1TyX3Ej4jM
         i/ww==
X-Forwarded-Encrypted: i=1; AFNElJ/RCZXwQfZ4UYH8bQrZ9eSiqAmpVa4ZKdeY/+XTf6wdYwyJSbQ5uRfn+1sHOAwXul2khwNpvO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSuK3Ezi5RWH/A/tlkKdqYTccrSRo1JkdFXHf678GO52cd/p4
	zCto9fYC8HGwCHNSBQb/de3ioOpR2LrCb+dnqaUDOV9hh8iUDUSVG1l7OaKt+w==
X-Gm-Gg: Acq92OH6U3poI2P2blKory7CRj1o0Td1dGwuxZ9ZXDX9f4Vx4OiqW4EleiTQfGcA5so
	HkgKdofQEWhTsKFvpwIfAQT9t23zK0BqXuuFmIr1vCzF8Aw7qkmfatuqSD53AE8bzWgloMIvfZ0
	TTs6g4O/zsAey287zlpYrV1heI6k9rpDWJjhgUg6N+LA1FNSFN616qM05W10QIIXiQbYdhgVwtq
	RNqzT6T4HMrpXOM5ZLY5apRqKAmdKz0w7/r7r49xa+x/zBku/vGfWYG67mnbFFWp8jdll8OfJST
	APU5YzY6/HKO9hPsdtYLBOWjlWxUbpYEiXIVymDWuyhJbXtWai3J38RulRPcJDzfjc+wD4hzE5K
	k8oYFJA8P0hvvN7LWmDIsSEfSy5ssXiK6HJKBbt0lewRmEUtlHXxTOHoSJLljbCjTkqcX3kegrj
	LfyNMo6tQBHwvMGTKgjL77CcMhRfNxBRT3uFvhszNkm2FkzH/CV39ECRCZaAXriAKkIxXkTP6tY
	UXzQDJL8ieSSE6E7T2p5G5x17o5LG7x
X-Received: by 2002:a05:7022:fb04:b0:138:51c:c5bf with SMTP id a92af1059eb24-138066c6ab3mr15555239c88.15.1781122862748;
        Wed, 10 Jun 2026 13:21:02 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c24:4ad9:f660:1904? ([2620:10d:c090:500::f774])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54caef7sm20195643c88.7.2026.06.10.13.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 13:21:02 -0700 (PDT)
Message-ID: <62972626-ec5d-4b9f-b745-6a8060d116e8@gmail.com>
Date: Wed, 10 Jun 2026 13:21:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v09 1/5] hinic3: Add ethtool queue ops
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>,
 Teng Peisen <tengpeisen@huawei.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Zheng Jiezhen
 <zhengjiezhen@h-partners.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <cover.1781062575.git.wudi234@huawei.com>
 <02e87952a65aa268526ade2f03de6c76fbc1fe9d.1781062575.git.wudi234@huawei.com>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <02e87952a65aa268526ade2f03de6c76fbc1fe9d.1781062575.git.wudi234@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297833-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:wudi234@huawei.com,m:tengpeisen@huawei.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[huawei.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BA7466CBE6



On 6/9/26 11:59 PM, Fan Gong wrote:
>   Implement following ethtool callback function:
> .get_ringparam
> .set_ringparam
> 
>   These callbacks allow users to utilize ethtool for detailed
> queue depth configuration and monitoring.
> 
> Co-developed-by: Wu Di <wudi234@huawei.com>
> Signed-off-by: Wu Di <wudi234@huawei.com>
> Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>  .../ethernet/huawei/hinic3/hinic3_ethtool.c   |  93 ++++++++++++++++
>  .../net/ethernet/huawei/hinic3/hinic3_irq.c   |   5 +-
>  .../net/ethernet/huawei/hinic3/hinic3_main.c  |   6 +
>  .../huawei/hinic3/hinic3_netdev_ops.c         | 104 ++++++++++++++++--
>  .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   9 ++
>  .../ethernet/huawei/hinic3/hinic3_nic_io.c    |   4 +-
>  .../ethernet/huawei/hinic3/hinic3_nic_io.h    |   8 +-
>  .../net/ethernet/huawei/hinic3/hinic3_rx.c    |   2 +-
>  8 files changed, 217 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 90fc16288de9..be9992a235f7 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> @@ -9,6 +9,7 @@
>  #include <linux/errno.h>
>  #include <linux/etherdevice.h>
>  #include <linux/netdevice.h>
> +#include <linux/netlink.h>
>  #include <linux/ethtool.h>
>  
>  #include "hinic3_lld.h"
> @@ -409,6 +410,96 @@ hinic3_get_link_ksettings(struct net_device *netdev,
>  	return 0;
>  }
>  
> +static void hinic3_get_ringparam(struct net_device *netdev,
> +				 struct ethtool_ringparam *ring,
> +				 struct kernel_ethtool_ringparam *kernel_ring,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +
> +	ring->rx_max_pending = HINIC3_MAX_RX_QUEUE_DEPTH;
> +	ring->tx_max_pending = HINIC3_MAX_TX_QUEUE_DEPTH;
> +	ring->rx_pending = nic_dev->q_params.rq_depth;
> +	ring->rx_pending = nic_dev->q_params.sq_depth;
> +}
> +
> +static void hinic3_update_qp_depth(struct net_device *netdev,
> +				   u32 sq_depth, u32 rq_depth)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	u16 i;
> +
> +	nic_dev->q_params.sq_depth = sq_depth;
> +	nic_dev->q_params.rq_depth = rq_depth;
> +	for (i = 0; i < nic_dev->max_qps; i++) {
> +		nic_dev->txqs[i].q_depth = sq_depth;
> +		nic_dev->txqs[i].q_mask = sq_depth - 1;
> +		nic_dev->rxqs[i].q_depth = rq_depth;
> +		nic_dev->rxqs[i].q_mask = rq_depth - 1;
> +	}
> +}
> +
> +static int hinic3_check_ringparam_valid(struct net_device *netdev,
> +					const struct ethtool_ringparam *ring,
> +					struct netlink_ext_ack *extack)
> +{
> +	if (ring->tx_pending < HINIC3_MIN_QUEUE_DEPTH ||
> +	    ring->rx_pending < HINIC3_MIN_QUEUE_DEPTH) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Queue depth out of range tx[%d-%d] rx[%d-%d]",
> +				       HINIC3_MIN_QUEUE_DEPTH,
> +				       HINIC3_MAX_TX_QUEUE_DEPTH,
> +				       HINIC3_MIN_QUEUE_DEPTH,
> +				       HINIC3_MAX_RX_QUEUE_DEPTH);
> +
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
> +	err = hinic3_check_ringparam_valid(netdev, ring, extack);
> +	if (err)
> +		return err;
> +
> +	new_sq_depth = 1U << ilog2(ring->tx_pending);
> +	new_rq_depth = 1U << ilog2(ring->rx_pending);
> +	if (new_sq_depth == nic_dev->q_params.sq_depth &&
> +	    new_rq_depth == nic_dev->q_params.rq_depth)
> +		return 0;
> +
> +	if (new_sq_depth != ring->tx_pending ||
> +	    new_rq_depth != ring->rx_pending)
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Requested Tx/Rx ring depth %u/%u trimmed to %u/%u",
> +				       ring->tx_pending, ring->rx_pending,
> +				       new_sq_depth, new_rq_depth);
> +
> +	if (!netif_running(netdev)) {
> +		hinic3_update_qp_depth(netdev, new_sq_depth, new_rq_depth);
> +	} else {
> +		q_params = nic_dev->q_params;
> +		q_params.sq_depth = new_sq_depth;
> +		q_params.rq_depth = new_rq_depth;
> +
> +		err = hinic3_change_channel_settings(netdev, &q_params);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct ethtool_ops hinic3_ethtool_ops = {
>  	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
>  					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
> @@ -417,6 +508,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
>  	.get_msglevel                   = hinic3_get_msglevel,
>  	.set_msglevel                   = hinic3_set_msglevel,
>  	.get_link                       = ethtool_op_get_link,
> +	.get_ringparam                  = hinic3_get_ringparam,
> +	.set_ringparam                  = hinic3_set_ringparam,
>  };
>  
>  void hinic3_set_ethtool_ops(struct net_device *netdev)
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> index e7d6c2033b45..bc4d879f9be4 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> @@ -137,7 +137,8 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
>  	struct hinic3_interrupt_info info = {};
>  	int err;
>  
> -	if (q_id >= nic_dev->q_params.num_qps)
> +	if (q_id >= nic_dev->q_params.num_qps ||
> +	    !mutex_trylock(&nic_dev->change_res_mutex))
>  		return 0;
>  
>  	info.interrupt_coalesc_set = 1;
> @@ -156,6 +157,8 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
>  		nic_dev->rxqs[q_id].last_pending_limit = pending_limit;
>  	}
>  
> +	mutex_unlock(&nic_dev->change_res_mutex);
> +
>  	return err;
>  }
>  
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index 0a888fe4c975..c87624a5e5dc 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> @@ -179,6 +179,7 @@ static int hinic3_sw_init(struct net_device *netdev)
>  	int err;
>  
>  	mutex_init(&nic_dev->port_state_mutex);
> +	mutex_init(&nic_dev->change_res_mutex);
>  
>  	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
>  	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
> @@ -315,6 +316,9 @@ static void hinic3_link_status_change(struct net_device *netdev,
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
>  
> +	if (!mutex_trylock(&nic_dev->change_res_mutex))
> +		return;
> +
>  	if (link_status_up) {
>  		if (netif_carrier_ok(netdev))
>  			return;

There's a couple returns in this function that will cause the lock to
never be released. Probably need a goto unlock.

> @@ -330,6 +334,8 @@ static void hinic3_link_status_change(struct net_device *netdev,
>  		netif_carrier_off(netdev);
>  		netdev_dbg(netdev, "Link is down\n");
>  	}
> +
> +	mutex_unlock(&nic_dev->change_res_mutex);
>  }
>  
>  static void hinic3_port_module_event_handler(struct net_device *netdev,
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index da73811641a9..047214cfc753 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> @@ -288,7 +288,8 @@ static void hinic3_free_channel_resources(struct net_device *netdev,
>  	hinic3_free_qps(nic_dev, qp_params);
>  }
>  
> -static int hinic3_open_channel(struct net_device *netdev)
> +static int hinic3_prepare_channel(struct net_device *netdev,
> +				  struct hinic3_dyna_txrxq_params *qp_params)
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
>  	int err;
> @@ -299,16 +300,28 @@ static int hinic3_open_channel(struct net_device *netdev)
>  		return err;
>  	}
>  
> -	err = hinic3_configure_txrxqs(netdev, &nic_dev->q_params);
> +	err = hinic3_configure_txrxqs(netdev, qp_params);
>  	if (err) {
>  		netdev_err(netdev, "Failed to configure txrxqs\n");
>  		goto err_free_qp_ctxts;
>  	}
>  
> +	return 0;
> +
> +err_free_qp_ctxts:
> +	hinic3_free_qp_ctxts(nic_dev);
> +
> +	return err;
> +}
> +
> +static int hinic3_open_channel(struct net_device *netdev)
> +{
> +	int err;
> +
>  	err = hinic3_qps_irq_init(netdev);
>  	if (err) {
>  		netdev_err(netdev, "Failed to init txrxq irq\n");
> -		goto err_free_qp_ctxts;
> +		return err;
>  	}
>  
>  	err = hinic3_configure(netdev);
> @@ -321,8 +334,6 @@ static int hinic3_open_channel(struct net_device *netdev)
>  
>  err_uninit_qps_irq:
>  	hinic3_qps_irq_uninit(netdev);
> -err_free_qp_ctxts:
> -	hinic3_free_qp_ctxts(nic_dev);
>  
>  	return err;
>  }
> @@ -428,6 +439,74 @@ static void hinic3_vport_down(struct net_device *netdev)
>  	}
>  }
>  
> +int
> +hinic3_change_channel_settings(struct net_device *netdev,
> +			       struct hinic3_dyna_txrxq_params *trxq_params)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_dyna_txrxq_params cur_trxq_params = {};
> +	struct hinic3_dyna_qp_params new_qp_params = {};
> +	struct hinic3_dyna_qp_params cur_qp_params = {};
> +	int err;
> +
> +	cur_trxq_params = nic_dev->q_params;
> +
> +	hinic3_config_num_qps(netdev, trxq_params);
> +
> +	err = hinic3_alloc_channel_resources(netdev, &new_qp_params,
> +					     trxq_params);
> +	if (err) {
> +		netdev_err(netdev, "Failed to alloc channel resources\n");
> +		return err;
> +	}
> +
> +	mutex_lock(&nic_dev->change_res_mutex);
> +	hinic3_vport_down(netdev);
> +	hinic3_close_channel(netdev);
> +	hinic3_get_cur_qps(nic_dev, &cur_qp_params);
> +
> +	hinic3_init_qps(nic_dev, &new_qp_params);
> +
> +	err = hinic3_prepare_channel(netdev, trxq_params);
> +	if (err)
> +		goto err_uninit_qps;
> +
> +	if (nic_dev->num_qp_irq > trxq_params->num_qps)
> +		hinic3_qp_irq_change(netdev, trxq_params->num_qps);
> +
> +	nic_dev->q_params = *trxq_params;
> +
> +	err = hinic3_open_channel(netdev);
> +	if (err)
> +		goto err_qp_irq_reset;
> +
> +	err = hinic3_vport_up(netdev);
> +	if (err)
> +		goto err_close_channel;
> +
> +	hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_params);
> +
> +	mutex_unlock(&nic_dev->change_res_mutex);
> +
> +	return 0;
> +
> +err_close_channel:
> +	hinic3_close_channel(netdev);
> +err_qp_irq_reset:
> +	nic_dev->q_params = cur_trxq_params;
> +
> +	if (trxq_params->num_qps > cur_trxq_params.num_qps)
> +		hinic3_qp_irq_change(netdev, cur_trxq_params.num_qps);
> +	hinic3_free_qp_ctxts(nic_dev);
> +err_uninit_qps:
> +	hinic3_get_cur_qps(nic_dev, &new_qp_params);
> +	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
> +	hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_params);
> +	mutex_unlock(&nic_dev->change_res_mutex);
> +
> +	return err;
> +}
> +
>  static int hinic3_open(struct net_device *netdev)
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> @@ -458,6 +537,10 @@ static int hinic3_open(struct net_device *netdev)
>  
>  	hinic3_init_qps(nic_dev, &qp_params);
>  
> +	err = hinic3_prepare_channel(netdev, &nic_dev->q_params);
> +	if (err)
> +		goto err_uninit_qps;
> +
>  	err = hinic3_open_channel(netdev);
>  	if (err)
>  		goto err_uninit_qps;
> @@ -473,7 +556,7 @@ static int hinic3_open(struct net_device *netdev)
>  err_close_channel:
>  	hinic3_close_channel(netdev);
>  err_uninit_qps:
> -	hinic3_uninit_qps(nic_dev, &qp_params);
> +	hinic3_get_cur_qps(nic_dev, &qp_params);
>  	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
>  err_destroy_num_qps:
>  	hinic3_destroy_num_qps(netdev);
> @@ -493,10 +576,15 @@ static int hinic3_close(struct net_device *netdev)
>  		return 0;
>  	}
>  
> +	mutex_lock(&nic_dev->change_res_mutex);
>  	hinic3_vport_down(netdev);
>  	hinic3_close_channel(netdev);
> -	hinic3_uninit_qps(nic_dev, &qp_params);
> -	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
> +	hinic3_get_cur_qps(nic_dev, &qp_params);
> +	hinic3_free_channel_resources(netdev, &qp_params,
> +				      &nic_dev->q_params);
> +	hinic3_free_nicio_res(nic_dev);
> +	hinic3_destroy_num_qps(netdev);
> +	mutex_unlock(&nic_dev->change_res_mutex);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> index 9502293ff710..005b2c01a988 100644
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
> @@ -129,6 +132,8 @@ struct hinic3_nic_dev {
>  	struct work_struct              rx_mode_work;
>  	/* lock for enable/disable port */
>  	struct mutex                    port_state_mutex;
> +	/* mutex to serialize channel/resource changes */
> +	struct mutex                    change_res_mutex;
>  
>  	struct list_head                uc_filter_list;
>  	struct list_head                mc_filter_list;
> @@ -143,6 +148,10 @@ struct hinic3_nic_dev {
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
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
> index 87e736adba02..0e7a0ccfba98 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
> @@ -484,8 +484,8 @@ void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
>  	}
>  }
>  
> -void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
> -		       struct hinic3_dyna_qp_params *qp_params)
> +void hinic3_get_cur_qps(struct hinic3_nic_dev *nic_dev,
> +			struct hinic3_dyna_qp_params *qp_params)
>  {
>  	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
>  
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> index 12eefabcf1db..571b34d63950 100644
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
> @@ -136,8 +140,8 @@ void hinic3_free_qps(struct hinic3_nic_dev *nic_dev,
>  		     struct hinic3_dyna_qp_params *qp_params);
>  void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
>  		     struct hinic3_dyna_qp_params *qp_params);
> -void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
> -		       struct hinic3_dyna_qp_params *qp_params);
> +void hinic3_get_cur_qps(struct hinic3_nic_dev *nic_dev,
> +			struct hinic3_dyna_qp_params *qp_params);
>  
>  int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev);
>  void hinic3_free_qp_ctxts(struct hinic3_nic_dev *nic_dev);
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> index 309ab5901379..b5b601469517 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> @@ -541,7 +541,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
>  		rq_associate_cqes(rxq);
>  
>  		pkts = hinic3_rx_fill_buffers(rxq);
> -		if (!pkts) {
> +		if (pkts < rxq->q_depth - 1) {

nit: just use rxq->q_mask?

>  			netdev_err(netdev, "Failed to fill Rx buffer\n");
>  			return -ENOMEM;
>  		}


