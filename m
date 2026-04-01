Return-Path: <netdev+bounces-273971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OQtBnrQzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:59:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A24376699
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C657D3064142
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48DC386C3A;
	Wed,  1 Apr 2026 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbA51mQJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE32F7AC1
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029985; cv=none; b=uPCiULBtO1O15aMsAw3x8R5enfNE4mYVUxTxXxJFWDK35suOwaV7UpS5Rw/otTtFwozd7kylDgUDP7RLqid7lVaFJYVsZBHzoVIJflOjkw0WdA0Pme0/hcwqVt0PwoVlCkQCHt5nLYWH+lde3zpRHfw3S4cs0M27IZEG+gSEF4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029985; c=relaxed/simple;
	bh=zOZC2aKClSnAidR0vLOY85xgZZqHZ5x5vrQqdnyVDhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jydhz39iOAF/eegY4CoyI7J3VBLHwUUUgdkGK+1IZZZfbm/0U5dHH1ZWeicLWhkBgWzMBiDciSyh1P0xwXTss56CPl6l/lPqziTlUj/LbLundnhHVXjM9zVyM0YMsXJKfl8mWOkKvdJww0Hssu8uIc6cuveDyDTQ5N+RWuRK0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbA51mQJ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4b77adso9399520c88.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775029983; x=1775634783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gn7BFBkoPg/Mi40J2CvkBtL8T6I0G+ldprB7tkZkwBc=;
        b=lbA51mQJreoSSy6Zfm6ppyHazRemK9OOQ3Fx3MsQcU/h+bsd0C0/tnQKjG8ccLAfII
         mzDtVpCM9T1mhg5tEdeCuFqBK1hb55wJnPntJdBjSErneivH3bNTXjC7IeNTLEa8/a6T
         qDy1SwDfbLPkqUp3Sh/2ksJVlmfErlvnhvUijKMQ8V8iFmpcee09mU9DkeCjMjNhitVz
         rEN2ZcoXyt8GjYLQ3b/EE/ApjAG4xuhbbZPOWYXUo5c1qd4oEI9lyNbi/pZQILrGDeGX
         yqvuv3u28ITfjUrejXUhmHcWjtPDV9had3zaosZ3kJR23Jix7T1WR6bshnY4wy3oHswP
         2WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775029983; x=1775634783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gn7BFBkoPg/Mi40J2CvkBtL8T6I0G+ldprB7tkZkwBc=;
        b=IuyUYnMj3h0ZJkPc1UpT9b2XdcUBGbPJyjo2f4ib+Vfp4BzihLf1KEGp4TI0rStj5J
         P0iIcWLZam7gWASdW+ifnjx/ICCyOIpTw6er88uLv6SSPYgSZcWZN0HfG3ZL0SzGJBkV
         4JIsc4G/rSr3G1+cwRw982C4+B2eSdxSpYozylttI8iRl73vVDPGYExLjc/67TxJdvAx
         kB9Bs+YPvMjds40e5yPxuwuFjbLk4XxWIMyGXBC6authv8bShOJZScUc5AIzs3KCiyWr
         crP8pos5EzDzOXmonjazg2U9i33g0EcE4uR3ltrNCnIEQIgyvQSEAcETHbYW8zZxyVQP
         QMcw==
X-Forwarded-Encrypted: i=1; AJvYcCUnjIiEAkskuQNpjxk3/gX9qny1DFews2bFuop6KHTjvOvawXBeYM5DhtdX730g62r32A+p0rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfxs3ZPguv1NRAATrDh6wTM4x24r0pxGXn314pwo1w0i8eqM5D
	EnI1EA4Lx6vPUhyzD2TxlBhH6OZAVnr66f2bwQ/gtUM/IGe2LJwfqNcU
X-Gm-Gg: ATEYQzz5efyJKpCAqoXSXruNIzFjMxPRmWanH1x4tw9+Q/pBLJN2qUpymL+NlIjQMi8
	E2BL/g4Ttwbdo3RL2qkqHZ/YScWj1ahS4SGefOj4tGZXqtOwA0h35ayrNcurcdhE6rpVKEh9GuO
	Ih48BHhKe90w4t74JIxOXiaI9orR4rTs3YUHe1WlgcMvw42vu0r3Qj0jV2qPiPrTRcMRsI2XkWn
	l0p9eRyJuKFNO3V40UyeiCrWFxkus9Lk86VcKt9AZ65O4mYFt/VI4fE8iIFRJQfrn/5K1e1BFC3
	AlBjynOD5MWeBnuO1hrT9cNWw99TRYzYFNwCd+mgtROMA8AM1yev2XgAem3gjLtiLacy1eZD+MJ
	XOSMQcjQcEUG+7rJBJn8LO73oUZfSZwnR6qTcut48Tb3BbOUrLPZCYGK/MV9c399hQu4EQCpZlD
	hIxH4WISlTPVftbDNoCxOE2YXSg1ojV2vmrs87O+dpAYQE+7ABVf8oe51d1X+IbihNjkTroCU=
X-Received: by 2002:a05:7022:b81:b0:127:3f2a:af21 with SMTP id a92af1059eb24-12be647ca0amr1320002c88.15.1775029982608;
        Wed, 01 Apr 2026 00:53:02 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::139a? ([2620:10d:c090:400::5:51bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab983f904sm17793034c88.9.2026.04.01.00.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 00:53:01 -0700 (PDT)
Message-ID: <18d5a9b7-9c8d-4fc4-9332-fab27449dc58@gmail.com>
Date: Wed, 1 Apr 2026 00:53:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v03 3/6] hinic3: Add ethtool coalesce ops
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
 <ffc357656b2412abf6e8de4200d289e761f3e6ea.1774940117.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <ffc357656b2412abf6e8de4200d289e761f3e6ea.1774940117.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273971-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2A24376699
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> +static int is_coalesce_exceed_limit(struct net_device *netdev,
> +				    const struct ethtool_coalesce *coal)
> +{
> +	const struct {
> +		const char *name;
> +		u32 value;
> +		u32 limit;
> +	} coalesce_limits[] = {
> +		{"rx_coalesce_usecs",
> +		 coal->rx_coalesce_usecs,
> +		 COALESCE_MAX_TIMER_CFG},
> +		{"rx_max_coalesced_frames",
> +		 coal->rx_max_coalesced_frames,
> +		 COALESCE_MAX_PENDING_LIMIT},
> +		{"rx_max_coalesced_frames_low",
> +		 coal->rx_max_coalesced_frames_low,
> +		 COALESCE_MAX_PENDING_LIMIT},
> +		{"rx_max_coalesced_frames_high",
> +		 coal->rx_max_coalesced_frames_high,
> +		 COALESCE_MAX_PENDING_LIMIT},
> +	};
> +
> +	for (int i = 0; i < ARRAY_SIZE(coalesce_limits); i++) {
> +		if (coalesce_limits[i].value > coalesce_limits[i].limit) {
> +			netdev_err(netdev, "%s out of range %d-%d\n",
> +				   coalesce_limits[i].name, 0,
> +				   coalesce_limits[i].limit);
> +			return -EOPNOTSUPP;

Since we are failing a range check, maybe -ERANGE or -EINVAL would be 
more appropriate here.

> +		}
> +	}
> +	return 0;
> +}
> +
> +static int is_coalesce_legal(struct net_device *netdev,
> +			     const struct ethtool_coalesce *coal)
> +{
> +	int err;
> +
> +	err = is_coalesce_exceed_limit(netdev, coal);
> +	if (err)
> +		return err;
> +
> +	if (coal->rx_max_coalesced_frames_low >=
> +	    coal->rx_max_coalesced_frames_high &&
> +	    coal->rx_max_coalesced_frames_high > 0) {

So this would allow non-zero low and zero high. For example, low = 10, 
high = 0. Is this expected?

> +		netdev_err(netdev, "invalid coalesce frame high %u, low %u, unit %d\n",
> +			   coal->rx_max_coalesced_frames_high,
> +			   coal->rx_max_coalesced_frames_low,
> +			   COALESCE_PENDING_LIMIT_UNIT);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static void check_coalesce_align(struct net_device *netdev,
> +				 u32 item, u32 unit, const char *str)
> +{
> +	if (item % unit)
> +		netdev_warn(netdev, "%s in %d units, change to %u\n",
> +			    str, unit, item - item % unit);
> +}
> +
> +#define CHECK_COALESCE_ALIGN(member, unit) \
> +	check_coalesce_align(netdev, member, unit, #member)
> +
> +static void check_coalesce_changed(struct net_device *netdev,
> +				   u32 item, u32 unit, u32 ori_val,
> +				   const char *obj_str, const char *str)
> +{
> +	if ((item / unit) != ori_val)
> +		netdev_dbg(netdev, "Change %s from %d to %u %s\n",
> +			   str, ori_val * unit, item - item % unit, obj_str);
> +}
> +
> +#define CHECK_COALESCE_CHANGED(member, unit, ori_val, obj_str) \
> +	check_coalesce_changed(netdev, member, unit, ori_val, obj_str, #member)
> +
> +static int hinic3_set_hw_coal_param(struct net_device *netdev,
> +				    struct hinic3_intr_coal_info *intr_coal)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	int err;
> +	u16 i;
> +
> +	for (i = 0; i < nic_dev->max_qps; i++) {
> +		err = hinic3_set_queue_coalesce(netdev, i, intr_coal);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hinic3_get_coalesce(struct net_device *netdev,
> +			       struct ethtool_coalesce *coal,
> +			       struct kernel_ethtool_coalesce *kernel_coal,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_intr_coal_info *interrupt_info;
> +
> +	interrupt_info = &nic_dev->intr_coalesce[0];
> +
> +	/* TX/RX uses the same interrupt.
> +	 * So we only declare RX ethtool_coalesce parameters.
> +	 */
> +	coal->rx_coalesce_usecs = interrupt_info->coalesce_timer_cfg *
> +				  COALESCE_TIMER_CFG_UNIT;
> +	coal->rx_max_coalesced_frames = interrupt_info->pending_limit *
> +					COALESCE_PENDING_LIMIT_UNIT;
> +
> +	coal->use_adaptive_rx_coalesce = nic_dev->adaptive_rx_coal;
> +
> +	coal->rx_max_coalesced_frames_high =
> +		interrupt_info->rx_pending_limit_high *
> +		COALESCE_PENDING_LIMIT_UNIT;
> +
> +	coal->rx_max_coalesced_frames_low =
> +		interrupt_info->rx_pending_limit_low *
> +		COALESCE_PENDING_LIMIT_UNIT;
> +
> +	return 0;
> +}
> +
> +static int hinic3_set_coalesce(struct net_device *netdev,
> +			       struct ethtool_coalesce *coal,
> +			       struct kernel_ethtool_coalesce *kernel_coal,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_intr_coal_info *ori_intr_coal;
> +	struct hinic3_intr_coal_info intr_coal = {};
> +	char obj_str[32];
> +	int err;
> +
> +	err = is_coalesce_legal(netdev, coal);
> +	if (err)
> +		return err;
> +
> +	CHECK_COALESCE_ALIGN(coal->rx_coalesce_usecs, COALESCE_TIMER_CFG_UNIT);
> +	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames,
> +			     COALESCE_PENDING_LIMIT_UNIT);
> +	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_high,
> +			     COALESCE_PENDING_LIMIT_UNIT);
> +	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_low,
> +			     COALESCE_PENDING_LIMIT_UNIT);
> +
> +	ori_intr_coal = &nic_dev->intr_coalesce[0];
> +	snprintf(obj_str, sizeof(obj_str), "for netdev");
> +
> +	CHECK_COALESCE_CHANGED(coal->rx_coalesce_usecs, COALESCE_TIMER_CFG_UNIT,
> +			       ori_intr_coal->coalesce_timer_cfg, obj_str);
> +	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames,
> +			       COALESCE_PENDING_LIMIT_UNIT,
> +			       ori_intr_coal->pending_limit, obj_str);
> +	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames_high,
> +			       COALESCE_PENDING_LIMIT_UNIT,
> +			       ori_intr_coal->rx_pending_limit_high, obj_str);
> +	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames_low,
> +			       COALESCE_PENDING_LIMIT_UNIT,
> +			       ori_intr_coal->rx_pending_limit_low, obj_str);
> +
> +	intr_coal.coalesce_timer_cfg =
> +		(u8)(coal->rx_coalesce_usecs / COALESCE_TIMER_CFG_UNIT);
> +	intr_coal.pending_limit = (u8)(coal->rx_max_coalesced_frames /
> +				      COALESCE_PENDING_LIMIT_UNIT);
> +
> +	nic_dev->adaptive_rx_coal = coal->use_adaptive_rx_coalesce;
> +
> +	intr_coal.rx_pending_limit_high =
> +		(u8)(coal->rx_max_coalesced_frames_high /
> +		     COALESCE_PENDING_LIMIT_UNIT);
> +
> +	intr_coal.rx_pending_limit_low =
> +		(u8)(coal->rx_max_coalesced_frames_low /
> +		     COALESCE_PENDING_LIMIT_UNIT);
> +
> +	/* coalesce timer or pending set to zero will disable coalesce */
> +	if (!nic_dev->adaptive_rx_coal &&
> +	    (!intr_coal.coalesce_timer_cfg || !intr_coal.pending_limit))
> +		netdev_warn(netdev, "Coalesce will be disabled\n");
> +
> +	return hinic3_set_hw_coal_param(netdev, &intr_coal);
> +}
> +
>   static const struct ethtool_ops hinic3_ethtool_ops = {
> -	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
> -					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
> +	.supported_coalesce_params      = ETHTOOL_COALESCE_RX_USECS |
> +					  ETHTOOL_COALESCE_RX_MAX_FRAMES |
> +					  ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
> +					  ETHTOOL_COALESCE_RX_MAX_FRAMES_LOW |
> +					  ETHTOOL_COALESCE_RX_MAX_FRAMES_HIGH,

Looks like ETHTOOL_COALESCE_TX_USECS support got dropped. is it intentional?

>   	.get_link_ksettings             = hinic3_get_link_ksettings,
>   	.get_drvinfo                    = hinic3_get_drvinfo,
>   	.get_msglevel                   = hinic3_get_msglevel,
> @@ -1004,6 +1231,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
>   	.get_eth_ctrl_stats             = hinic3_get_eth_ctrl_stats,
>   	.get_rmon_stats                 = hinic3_get_rmon_stats,
>   	.get_pause_stats                = hinic3_get_pause_stats,
> +	.get_coalesce                   = hinic3_get_coalesce,
> +	.set_coalesce                   = hinic3_set_coalesce,
>   };
>   
>   void hinic3_set_ethtool_ops(struct net_device *netdev)


