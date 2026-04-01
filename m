Return-Path: <netdev+bounces-273968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLWeF87OzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:52:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C583764D2
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C017C3061BCF
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA14384249;
	Wed,  1 Apr 2026 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBin9MS9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC936BCC2
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029946; cv=none; b=BjP2BXedBetRdFEM0yVtc5GytQ4ZjQhCwXe47GSlfpHMCTYpFrrV08n33WuQqGf0VzmsZvQ5xoIdDO1mbqbDZvbQkfkQbZzH9ZCLwL85os96pJsfoVeI299DZkcNY8FSDAU5LSUWTsODaj0v3luc8SQW1fYkAx8j/mfJx8+dLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029946; c=relaxed/simple;
	bh=/xKPjENbw+y9tVTlpGDDqxkzbi3Dsy4WscFa4T8jtsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpCxbvnSfC63GnartUs5G5EWB5UsGQHl459JmGJH3qjKGO7N39y5bQFQAfIL5rCYQFsoM0KH0Vz1z6fJUlnfNJrfq3iqVG2tCMZkOuO7L6C0y6nFryoHSvUtmzTYGR+U6tP8O90lt68VnJ07TO+FEiOmWkMXWoPBKOccYgZIp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBin9MS9; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-128b9b7e3edso4015553c88.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775029945; x=1775634745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbYMgx5b2U+ll1ogdXc2obIoQ1UDlBi3tYpZOOvXiXo=;
        b=TBin9MS9HwvQcidj7DxebJH6m1DYhgQPhWB1PWVTrLolVthDAQRBC/LRjX0qt7T2Ux
         Mmqj/OH7IlbjPrOxlOQRgYACFzWS4LqB0E8akFnYG71KSLFReGEbceVYCVKc8UHSErhN
         9MccYFvUHwkEd9ND+6YuT1oSimm4Wtfccw79Py/C8AiFjcziaaPT4SQYYSvy6os2mbOf
         jPlKIqo+iAJGKdMDEEszaz6HmoLQt9txhttDF/F0kk7+Y9Qi7RvvTh8wazCRKasVXcpE
         +31FqpXID4Js80W0gbyXEmc1HJ1F1ACjBw8KRszWQunnrbgT6Unou6LGlbhJaM4JbTmD
         VQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775029945; x=1775634745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbYMgx5b2U+ll1ogdXc2obIoQ1UDlBi3tYpZOOvXiXo=;
        b=T4Coz/JVQipvU9vMaJjvSQ5tiIR3uP/BsuPxXnNwkjN4vcTNcHXfBVp76gGAB2aTaN
         zveoAunNd344sm5u/VFdsRKdcMs/EjeqX836+B3fiuxXeF83XvbSV5G5SsNVofVDZ2CT
         G1AfL1q7hpVPYY0k7w4I2hYPmlXGlySjdDo/NQpRc/yl/k0UgKYQTUdcePNwh5hlDw/p
         4aqPt+pFkEe8K7fVxnZNfoWGG6B43ujy2cIL8B1b8kC5fdocB46dF6NgqVhgdGNacVof
         D/FpdFbPGIhC9ZjKscbgy+DL/yrQioQOYNiuh0F2KtZ8RHJEUr1i0FLp8xVHTWxmPBzM
         9klw==
X-Forwarded-Encrypted: i=1; AJvYcCXUCBxsERrarlS8A+fRJ0emM3t01NS/n81PfhTE7bCSeaG41gq8LVH9zSuge+rgeUbCWI9bgTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1stkPU1ue7gwrXpWhYp+uc53Ef+ygNJz+ujZH7FceDnCi+uQE
	xh2Kq5xQU6SnyhkST9NEgdUf6emk8qiKTdfEmEfiBwas4GIYuebA/RL90NYH4A==
X-Gm-Gg: ATEYQzw8zNMNTTL/so9luvSPc7F4QKHBP+4I3BUvr6kgq4AXFOYuXmrmq9Cri5Oitmt
	NvZqBAtL7F4D8iZ8Evexc/WI5ZznnsII4Haj/egW4vJdxq5m0KzY6ecMB9IznNd7q0MbId8DPYQ
	X+Rq/LjGECOoxcuaqWconGi+HVtY2R5ceLeZplWPeIWGgp0xOtN7DPbYJh8W7FtEyu/knH5y5tv
	28yZNk/RIpeemAbUdMpfmsXWGVc3pG5A3eR05okOg8y5/LYbo2hwNy58oaZtUIE0XE6WqshqrtN
	FoKKPCxZrj3+BAuF7r7IiLmWnXTHP8kfbE2tqhvlxGPS7GnfNr+Sbs5HX2DG+pXrK9ixy3ZecZ7
	Jxx9RkveoYQlkGZI05fADYXBvh2crmrCTiimnmGk/zQgCRwB4EpPCU0fxtZhhMlMOTIEiY3W7rc
	gZElxYBQXJIm7MJINoUGUyCIVWiZqx/HJqUovsKXEF3EERvEWvI9eaKW4Mkz2z
X-Received: by 2002:a05:7022:f10f:b0:119:e569:fbb4 with SMTP id a92af1059eb24-12be65579eemr1471488c88.35.1775029944651;
        Wed, 01 Apr 2026 00:52:24 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::139a? ([2620:10d:c090:400::5:51bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab9864810sm13149653c88.12.2026.04.01.00.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 00:52:23 -0700 (PDT)
Message-ID: <fb04ebf6-a20b-4570-83ee-f97049033c39@gmail.com>
Date: Wed, 1 Apr 2026 00:52:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v03 1/6] hinic3: Add ethtool queue ops
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Zheng Jiezhen
 <zhengjiezhen@h-partners.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <cover.1774940117.git.zhuyikai1@h-partners.com>
 <17b3bbb0c917ee09ddd7a164cdefca6eb63793ec.1774940117.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <17b3bbb0c917ee09ddd7a164cdefca6eb63793ec.1774940117.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273968-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5C583764D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


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

So non power of 2 values would trimmed to the nearest power of 2 even 
when the driver support these values. If such values are not supported, 
should these be rejected here? or if we want to force the nearest power 
of 2, should we use NL_SET_ERR_MSG to inform the user about rounding?

> +int
> +hinic3_change_channel_settings(struct net_device *netdev,
> +			       struct hinic3_dyna_txrxq_params *trxq_params)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
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
> +	nic_dev->q_params = *trxq_params;

[1] Here we are overwriting the old parameters
> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	hinic3_init_qps(nic_dev, &new_qp_params);
> +
> +	err = hinic3_open_channel(netdev);
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
> +	memset(&nic_dev->q_params, 0, sizeof(nic_dev->q_params));

Looks like we are asking for trouble here. The old parameters were 
already overwritten at [1] and now we are destroying the new ones?

> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	hinic3_uninit_qps(nic_dev, &new_qp_params);
> +	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
> +
> +	mutex_unlock(&nic_dev->channel_cfg_lock);
> +
> +	return err;
> +}
> +

