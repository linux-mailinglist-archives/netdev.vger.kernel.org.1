Return-Path: <netdev+bounces-297838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2oB7O7/MKWordgMAu9opvQ
	(envelope-from <netdev+bounces-297838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:44:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8C666CE69
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:44:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=S9hoPaSz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297838-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297838-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E760305615B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC6C47F2F8;
	Wed, 10 Jun 2026 20:41:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E8A47ECD7
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 20:41:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124110; cv=none; b=dZ/WEBWKXtOikr5ZihBZQKAFjESq1MN9edDLd0TpJHIKwl+7Yzlhap3C0mGqisLKxDF/Kw9oxlUcY2pxem1qv1YkTZu6k97YsaV5Hsn+CO3nhzm5f0h0Tbc0CYe5+UAiwWQdr67bGtCusZBHDfxWCRkigs0xO1v3/TFb1qDAfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124110; c=relaxed/simple;
	bh=FfcK2VDr+cbkHmdERM3D0umRRUrcMG4Ez0z0VRc6AYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AB6ws86vu39vW4VaNl/6y6lN4Ir1WVaol81sqMrtmI7h25m7Vi8NHJ8CAou2jE9xOCgKfJr9MEYYKJQ6uDU+LtsVQ7F8cf+eM5ZgiXpoHj/Lpykd7apCHZzVvvtEKUBTJbFlRaG/3nbHdk3723F6xvR31nvFcQ/USxWoCCBr/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9hoPaSz; arc=none smtp.client-ip=74.125.82.46
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-138405b7bc5so778915c88.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781124106; x=1781728906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cafLBqBhQO6iXCnjNbbgZ31p/JjuxuAHoGm/KDHC2Q=;
        b=S9hoPaSzRDxvGFB3fQcWc+ayaZFZEl7PocztliSjsxHKRL+iDQzDwkTcOLXuIWwWcq
         5YIdMJK92YivXVfExZj4wqN3aBOCahlJ86nAyQAM0MaZXD/RZvvkbWYd1jJl7xsZ+teJ
         QP1ECz0T2CHAjwGl6RSgE44S+fRMMqXTvS3Q/Hvqd6Xy2N+NEQjFJ0zfDlvr4NRvvnjs
         lEOYwiwiFv00QIHaCdiAkaxnsJSADxZLuehL7XYhDsOpasI0lDfvebLY8sVwlgby4VTN
         nop7XIpU2wpcTf0uxCTE9aejxF3dZdrQgWQuFetJR5o9w3AkQLiOvG/okAn4+Kx5+N9Y
         3X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781124106; x=1781728906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cafLBqBhQO6iXCnjNbbgZ31p/JjuxuAHoGm/KDHC2Q=;
        b=lf66iJjp0YqdPoLwIpseBhFcWZMlVTvWXsaV0VvBFqYyEtSyLpB4XoXVy/H+cl9x5M
         Px80VXHa78IFaa+I0cwd9IDu8b+I1sEVNk9Yi4Y9AcPxA8shNtv8EuKfD5II9zwRvGdQ
         TVUsAM5qMBXbT3OBC/Fyk0jIal1oKo16k6CmCgEqZNnorMxkJARiCZa2XGJGLEIYp45H
         Efg2zQ49YS9Kl6oPHfibNVHqmnbYUD40zWlXIQjtPuprezI7VJQLQkQdiGURf4DyxYUy
         i+7WG1U/vOo9szwhVgJLIzYmtw58mYD9mNZkEsFLKVPPiywTIkWTFCuJbvK22UZQIGmT
         JruA==
X-Forwarded-Encrypted: i=1; AFNElJ+VnFrOPPCAzWE0dYzO4ESbPQlZy5iYaWpe2QMoXCAhPHx8zvJ5lO4MO0Qc9JvkA0hxo61bseY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2nSG2gHZo9tjyfDInMdHqxhqfGpc5LeqQjorbRxhQe/s1iyH
	BOrbMuUVy4VZ0rv9dfKHtOy4WQJ1NxWx+0IIMT08jH6kEy8AuCAb1PIf
X-Gm-Gg: Acq92OGoO5GYzF4v6omUd3+/7zUMNtW3N8WTxoPNM3/2UtOfNZCcqu1fi5oxc+HPeh4
	KXbp1HoZZ0/AcIM3n+rokg779dq7/FM/uJwVQqkI4WcSAPmr78V+S8zyg45fiBo7/F60OiXkQyA
	h6qsZNRy5MRNZC3smm3ET0dhR9AEvXefqdPrxXlMY4NPZF7/i4VecLrOePw1YZKFw/Arhvz4TgU
	Wa0rh5JSuUEyUIixy4fljZuM2Z3zfLIXzc7P8ro8PcVNPgfHyEvAQzqqgwhK2peVF6XI19moZ+G
	g9SKgj/+VaEpBl+0s7WD3+piag7SuUeT3NGU2gIgMwQ/4kTK4t5MCg1mmOUyGuHSGfY4/m1HAPb
	5UOUZ5uZTvY1PmNKCywnIboPjNoEFnVkPBFQUBgGw8WZekrBKHPpQFE4P9Zt+fy80i4eaxGItRI
	6eis0izWz38b4YLg9b2bkswxSQJ2ZZTM058/laOzBE+OThm8mTa5WQ8Hue13hTuFT4wf+i10TOS
	QRUZ44xciLX9h/UoUK+iw==
X-Received: by 2002:a05:7022:6ba1:b0:137:ec47:8fe1 with SMTP id a92af1059eb24-138067240b3mr15792916c88.29.1781124106438;
        Wed, 10 Jun 2026 13:41:46 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c24:4ad9:f660:1904? ([2620:10d:c090:500::f774])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539432sm23363367c88.9.2026.06.10.13.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 13:41:45 -0700 (PDT)
Message-ID: <6b019322-bb5c-4c35-ad51-efc2827041ef@gmail.com>
Date: Wed, 10 Jun 2026 13:41:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v09 4/5] hinic3: Add ethtool rss ops
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
 <7d1a4375fdf7c3e7a5a6162382cee4f48991d5da.1781062575.git.wudi234@huawei.com>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <7d1a4375fdf7c3e7a5a6162382cee4f48991d5da.1781062575.git.wudi234@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-297838-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 8B8C666CE69



On 6/9/26 11:59 PM, Fan Gong wrote:
>   Implement following ethtool callback function:
> .get_rxnfc
> .set_rxnfc
> .get_channels
> .set_channels
> .get_rxfh_indir_size
> .get_rxfh_key_size
> .get_rxfh
> .set_rxfh
> 
>   These callbacks allow users to utilize ethtool for detailed
> RSS parameters configuration and monitoring.
> 
> Co-developed-by: Wu Di <wudi234@huawei.com>
> Signed-off-by: Wu Di <wudi234@huawei.com>
> Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>  .../ethernet/huawei/hinic3/hinic3_ethtool.c   |   9 +
>  .../huawei/hinic3/hinic3_mgmt_interface.h     |   2 +
>  .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 539 +++++++++++++++++-
>  .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  19 +
>  4 files changed, 567 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 11c8eb0f5d2a..78818de9a946 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> @@ -16,6 +16,7 @@
>  #include "hinic3_hw_comm.h"
>  #include "hinic3_nic_dev.h"
>  #include "hinic3_nic_cfg.h"
> +#include "hinic3_rss.h"
>  
>  #define HINIC3_MGMT_VERSION_MAX_LEN     32
>  /* Coalesce time properties in microseconds */
> @@ -1238,6 +1239,14 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
>  	.get_pause_stats                = hinic3_get_pause_stats,
>  	.get_coalesce                   = hinic3_get_coalesce,
>  	.set_coalesce                   = hinic3_set_coalesce,
> +	.get_rxnfc                      = hinic3_get_rxnfc,
> +	.set_rxnfc                      = hinic3_set_rxnfc,
> +	.get_channels                   = hinic3_get_channels,
> +	.set_channels                   = hinic3_set_channels,
> +	.get_rxfh_indir_size            = hinic3_get_rxfh_indir_size,
> +	.get_rxfh_key_size              = hinic3_get_rxfh_key_size,
> +	.get_rxfh                       = hinic3_get_rxfh,
> +	.set_rxfh                       = hinic3_set_rxfh,
>  };
>  
>  void hinic3_set_ethtool_ops(struct net_device *netdev)
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
> index 76c691f82703..3c1263ff99ff 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
> @@ -282,6 +282,7 @@ enum l2nic_cmd {
>  	L2NIC_CMD_SET_VLAN_FILTER_EN  = 26,
>  	L2NIC_CMD_SET_RX_VLAN_OFFLOAD = 27,
>  	L2NIC_CMD_CFG_RSS             = 60,
> +	L2NIC_CMD_GET_RSS_CTX_TBL     = 62,
>  	L2NIC_CMD_CFG_RSS_HASH_KEY    = 63,
>  	L2NIC_CMD_CFG_RSS_HASH_ENGINE = 64,
>  	L2NIC_CMD_SET_RSS_CTX_TBL     = 65,
> @@ -301,6 +302,7 @@ enum l2nic_ucode_cmd {
>  	L2NIC_UCODE_CMD_MODIFY_QUEUE_CTX  = 0,
>  	L2NIC_UCODE_CMD_CLEAN_QUEUE_CTX   = 1,
>  	L2NIC_UCODE_CMD_SET_RSS_INDIR_TBL = 4,
> +	L2NIC_UCODE_CMD_GET_RSS_INDIR_TBL = 6,
>  };
>  
>  /* hilink mac group command */
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> index 25db74d8c7dd..811a6b491e74 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> @@ -155,7 +155,7 @@ static int hinic3_set_rss_type(struct hinic3_hwdev *hwdev,
>  				       L2NIC_CMD_SET_RSS_CTX_TBL, &msg_params);
>  
>  	if (ctx_tbl.msg_head.status == MGMT_STATUS_CMD_UNSUPPORTED) {
> -		return MGMT_STATUS_CMD_UNSUPPORTED;
> +		return -EOPNOTSUPP;
>  	} else if (err || ctx_tbl.msg_head.status) {
>  		dev_err(hwdev->dev, "mgmt Failed to set rss context offload, err: %d, status: 0x%x\n",
>  			err, ctx_tbl.msg_head.status);
> @@ -165,6 +165,41 @@ static int hinic3_set_rss_type(struct hinic3_hwdev *hwdev,
>  	return 0;
>  }
>  
> +static int hinic3_get_rss_type(struct hinic3_hwdev *hwdev,
> +			       struct hinic3_rss_type *rss_type)
> +{
> +	struct l2nic_cmd_rss_ctx_tbl ctx_tbl = {};
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	ctx_tbl.func_id = hinic3_global_func_id(hwdev);
> +
> +	mgmt_msg_params_init_default(&msg_params, &ctx_tbl, sizeof(ctx_tbl));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
> +				       L2NIC_CMD_GET_RSS_CTX_TBL,
> +				       &msg_params);
> +	if (ctx_tbl.msg_head.status == MGMT_STATUS_CMD_UNSUPPORTED) {
> +		return -EOPNOTSUPP;
> +	} else if (err || ctx_tbl.msg_head.status) {
> +		dev_err(hwdev->dev, "Failed to get hash type, err: %d, status: 0x%x\n",
> +			err, ctx_tbl.msg_head.status);
> +		return -EINVAL;
> +	}
> +
> +	rss_type->ipv4         = L2NIC_RSS_TYPE_GET(ctx_tbl.context, IPV4);
> +	rss_type->ipv6         = L2NIC_RSS_TYPE_GET(ctx_tbl.context, IPV6);
> +	rss_type->ipv6_ext     = L2NIC_RSS_TYPE_GET(ctx_tbl.context, IPV6_EXT);
> +	rss_type->tcp_ipv4     = L2NIC_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV4);
> +	rss_type->tcp_ipv6     = L2NIC_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV6);
> +	rss_type->tcp_ipv6_ext = L2NIC_RSS_TYPE_GET(ctx_tbl.context,
> +						    TCP_IPV6_EXT);
> +	rss_type->udp_ipv4     = L2NIC_RSS_TYPE_GET(ctx_tbl.context, UDP_IPV4);
> +	rss_type->udp_ipv6     = L2NIC_RSS_TYPE_GET(ctx_tbl.context, UDP_IPV6);
> +
> +	return 0;
> +}
> +
>  static int hinic3_rss_cfg_hash_type(struct hinic3_hwdev *hwdev, u8 opcode,
>  				    enum hinic3_rss_hash_type *type)
>  {
> @@ -264,7 +299,8 @@ static int hinic3_set_hw_rss_parameters(struct net_device *netdev, u8 rss_en)
>  	if (err)
>  		return err;
>  
> -	hinic3_fillout_indir_tbl(netdev, nic_dev->rss_indir);
> +	if (!netif_is_rxfh_configured(netdev))
> +		hinic3_fillout_indir_tbl(netdev, nic_dev->rss_indir);
>  
>  	err = hinic3_config_rss_hw_resource(netdev, nic_dev->rss_indir);
>  	if (err)
> @@ -334,3 +370,502 @@ void hinic3_try_to_enable_rss(struct net_device *netdev)
>  	clear_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
>  	nic_dev->q_params.num_qps = nic_dev->max_qps;
>  }
> +
> +static int hinic3_set_l4_rss_hash_ops(const struct ethtool_rxnfc *cmd,
> +				      struct hinic3_rss_type *rss_type)
> +{
> +	u8 rss_l4_en;
> +
> +	switch (cmd->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
> +	case 0:
> +		rss_l4_en = 0;
> +		break;
> +	case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
> +		rss_l4_en = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (cmd->flow_type) {
> +	case TCP_V4_FLOW:
> +		rss_type->tcp_ipv4 = rss_l4_en;
> +		break;
> +	case TCP_V6_FLOW:
> +		rss_type->tcp_ipv6 = rss_l4_en;
> +		break;
> +	case UDP_V4_FLOW:
> +		rss_type->udp_ipv4 = rss_l4_en;
> +		break;
> +	case UDP_V6_FLOW:
> +		rss_type->udp_ipv6 = rss_l4_en;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hinic3_update_rss_hash_opts(struct net_device *netdev,
> +				       struct ethtool_rxnfc *cmd,
> +				       struct hinic3_rss_type *rss_type)
> +{
> +	int err;
> +
> +	switch (cmd->flow_type) {
> +	case TCP_V4_FLOW:
> +	case TCP_V6_FLOW:
> +	case UDP_V4_FLOW:
> +	case UDP_V6_FLOW:
> +		err = hinic3_set_l4_rss_hash_ops(cmd, rss_type);
> +		if (err)
> +			return err;
> +
> +		break;
> +	case IPV4_FLOW:
> +		rss_type->ipv4 = 1;
> +		break;
> +	case IPV6_FLOW:
> +		rss_type->ipv6 = 1;
> +		break;
> +	default:
> +		netdev_err(netdev, "Unsupported flow type\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hinic3_set_rss_hash_opts(struct net_device *netdev,
> +				    struct ethtool_rxnfc *cmd)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_rss_type rss_type;
> +	int err;
> +
> +	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
> +		cmd->data = 0;
> +		netdev_err(netdev, "RSS is disable, not support to set flow-hash\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* RSS only supports hashing of IP addresses and L4 ports */
> +	if (cmd->data & ~(RXH_IP_SRC | RXH_IP_DST |
> +			  RXH_L4_B_0_1 | RXH_L4_B_2_3))
> +		return -EINVAL;
> +
> +	/* Both IP addresses must be part of the hash tuple */
> +	if (!(cmd->data & RXH_IP_SRC) || !(cmd->data & RXH_IP_DST))
> +		return -EINVAL;
> +
> +	/* L4 hash bits are not valid for pure L3 flow types */
> +	if ((cmd->flow_type == IPV4_FLOW || cmd->flow_type == IPV6_FLOW) &&
> +	    (cmd->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)))
> +		return -EINVAL;
> +
> +	err = hinic3_get_rss_type(nic_dev->hwdev, &rss_type);
> +	if (err) {
> +		netdev_err(netdev, "Failed to get rss type\n");
> +		return err;
> +	}
> +
> +	err = hinic3_update_rss_hash_opts(netdev, cmd, &rss_type);
> +	if (err)
> +		return err;
> +
> +	err = hinic3_set_rss_type(nic_dev->hwdev, rss_type);
> +	if (err) {
> +		netdev_err(netdev, "Failed to set rss type\n");
> +		return err;
> +	}
> +
> +	nic_dev->rss_type = rss_type;
> +
> +	return 0;
> +}
> +
> +static void convert_rss_l3_type(u8 rss_opt, struct ethtool_rxnfc *cmd)
> +{
> +	if (!rss_opt)
> +		cmd->data &= ~(RXH_IP_SRC | RXH_IP_DST);
> +}
> +
> +static void convert_rss_l4_type(u8 rss_opt, struct ethtool_rxnfc *cmd)
> +{
> +	if (rss_opt)
> +		cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
> +}
> +
> +static int hinic3_convert_rss_type(struct net_device *netdev,
> +				   struct hinic3_rss_type *rss_type,
> +				   struct ethtool_rxnfc *cmd)
> +{
> +	cmd->data = RXH_IP_SRC | RXH_IP_DST;
> +	switch (cmd->flow_type) {
> +	case TCP_V4_FLOW:
> +		convert_rss_l4_type(rss_type->tcp_ipv4, cmd);
> +		break;
> +	case TCP_V6_FLOW:
> +		convert_rss_l4_type(rss_type->tcp_ipv6, cmd);
> +		break;
> +	case UDP_V4_FLOW:
> +		convert_rss_l4_type(rss_type->udp_ipv4, cmd);
> +		break;
> +	case UDP_V6_FLOW:
> +		convert_rss_l4_type(rss_type->udp_ipv6, cmd);
> +		break;
> +	case IPV4_FLOW:
> +		convert_rss_l3_type(rss_type->ipv4, cmd);
> +		break;
> +	case IPV6_FLOW:
> +		convert_rss_l3_type(rss_type->ipv6, cmd);
> +		break;
> +	default:
> +		netdev_err(netdev, "Unsupported flow type\n");
> +		cmd->data = 0;
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hinic3_get_rss_hash_opts(struct net_device *netdev,
> +				    struct ethtool_rxnfc *cmd)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_rss_type rss_type;
> +	int err;
> +
> +	cmd->data = 0;
> +
> +	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags))
> +		return 0;
> +
> +	err = hinic3_get_rss_type(nic_dev->hwdev, &rss_type);
> +	if (err) {
> +		netdev_err(netdev, "Failed to get rss type\n");
> +		return err;
> +	}
> +
> +	return hinic3_convert_rss_type(netdev, &rss_type, cmd);
> +}
> +
> +int hinic3_get_rxnfc(struct net_device *netdev,
> +		     struct ethtool_rxnfc *cmd, u32 *rule_locs)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	int err = 0;
> +
> +	switch (cmd->cmd) {
> +	case ETHTOOL_GRXRINGS:
> +		cmd->data = nic_dev->q_params.num_qps;
> +		break;

You should probably implement the get_rx_ring_count ethtool op instead.
See
https://lore.kernel.org/netdev/20260122-grxring_big_v4-v2-0-94dbe4dcaa10@debian.org/


