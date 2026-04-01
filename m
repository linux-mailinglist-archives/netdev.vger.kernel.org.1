Return-Path: <netdev+bounces-273969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLdQAdTSzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:09:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCE737682A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D16131707BC
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4D36EA86;
	Wed,  1 Apr 2026 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8ZIa01F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703ED36495A
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029970; cv=none; b=Fq9p0H/DUhsUoYDVfKsyH4U3QgQ23AEeB4Yp1Nx8qE1CHxpRjXMNv9agl/OGf9lQI/+EnyD1U+nEtaPSzUp8U8a9MdqBgtp7RM85VXUwEqTXK5cRHik/gp/P9yeWK2RaP9s0OqtjJ891Z9pOoU+r1s/75vgV4AIxFEbYIcuC2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029970; c=relaxed/simple;
	bh=MCy1eat1Yj7/z8JAKeNn8agQhBiPTnEO0lLEsh8d608=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j247r6BDEH2+9tMw0TKZTHLK8x8QuKjycVkq7nYE2mvH7AKwPPHAlCDEn0icTzJ8AvKSGGQRggjNEc/Pjv3wyTGrE+OW/BL9vXTfxNcG7roJVuTua0hXB1tMRTbAGclaYDWwIdwlogT265+svgeZglRmy2eTDx2EHnQ/D8SDcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8ZIa01F; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7379527eec.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 00:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775029968; x=1775634768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cR1hXVaS01Di+TUyEuYwM6QysYHoAzLWu2PSOV8Pv68=;
        b=A8ZIa01FMl8OoUOXYZojhmsjNHj9KVxUVUU4cxYaCcK6jSEDR7H4Hf+/MHBy9xDSkG
         sY9GCSh0kA7NWz1tZ7VqFI3UV0F79v0YiydVO3yCxd/nIhE6Z3FZN2MUXc0o2zidqB7i
         4jlt+lRnNMiwmG+AYKkjNl7Jh067cIZgNyD2tANE5T9yrIIoByLI85maoSpL6wxakbuR
         M8G1yve3DET6GfPTxBqT639zRGiQSzFrRKa97KPjbrftzJ/P9f+Ina/fymW1PLMuePgZ
         fFtE9KKWKLYESKEV6Cy/qLAr8xEybcyM4IZrsp3JwCCJ9zj+2WZqSXdpT0BfqefmRIOS
         hBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775029968; x=1775634768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cR1hXVaS01Di+TUyEuYwM6QysYHoAzLWu2PSOV8Pv68=;
        b=Bx1M6hwLczziRBAVlNxHFM6fwnalQoatMlRcl+iIIu0udvI2UhOmsDWbOJD/lOO4iO
         8g7hv+D2AmuB2pKRW/ndGlzJzNwDSQNWpCctlqgyfWi977UFgPSOrj5T8csth+/TBDff
         rZPU/1rlit6sSw+smQSLvyr0EA8ggTgz3uFO049ZchBcKeVrplL0GKjhxq2wMCiG8RGK
         BVsn4G15mj/u9OmvC7UAbFHft7h+Ri5fCc5Y8tO8Re+jaVaEYBJpKW1ajFDBikzxHChk
         qlVgF3c0w/3oxCDdZ5A7TiKzAZTU653ESRj1IRP5keYANYa43f8TqNAfm7U9WJD9C2CB
         MG6w==
X-Forwarded-Encrypted: i=1; AJvYcCWRtlMjPbY36q33E7y1hzcvtBaL6GqY5yB9gAx9XtD105Wdkyab7fLaQ5Vb+7EPzKOmsbLPQ3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRG5ACUBSIh36uMmMRBG3k5/m9nzwJd9B419AzclqwRR4/XcQT
	F4pr8Yx+tKLwXAcmt+ZxDQYGKvl2txoLgLswvMouSwuHvqXOEufG9f0z
X-Gm-Gg: ATEYQzxo9QBY0CHNjH56l3sjLZopjZC9djXPhJf0SitvbpLKIIc6zlnyy93S/bDkZvh
	O/iRVUNbA9zbMXv3BL9aRTRZaR4MQWek1j7WG3bHmkEau1fr+6hQDv+sZ+BRcxijvF4kIi0Zcus
	ZkgzYecZVn+0INIeWzMDGyfLSsFv3qZ0xGyPM1/crF4/QdsaR2sE+gt0ird5qHMSfoMfFn0qQUQ
	T2pxvyU+Oc7VP4YdXPSgRWWTs8idoR7moFWIipyJXDAOPip8+vlH2t/6qj+DvFvMNGt66P89r7J
	IZ3zYN5vL7d9tn9Pwfjo/vP26xRbpNXupv5rLodP7no7GqwPjWAAXHHr0Y5c+YgailZrPujIfHB
	Bdy4F72GXDxyYTah2ZoYFGJzacqR2rkB5PMREdTvJlbSKMQQ4CMhiKDfKDRNXL+181Edyp61D96
	yWTrZXHaLhwb19r4euBwGeOs8XZShDrB7AKlM2rtHfvFCdIMLMePu2CRE/ylFiC93t0U5Ba24=
X-Received: by 2002:a05:7300:dc8c:b0:2c8:bf0d:74f4 with SMTP id 5a478bee46e88-2c930e6bd08mr1424462eec.5.1775029968395;
        Wed, 01 Apr 2026 00:52:48 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::139a? ([2620:10d:c090:400::5:51bb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b399bsm11813869eec.17.2026.04.01.00.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 00:52:48 -0700 (PDT)
Message-ID: <65447c62-fa65-456e-9f6c-11588b46d8ac@gmail.com>
Date: Wed, 1 Apr 2026 00:52:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v03 2/6] hinic3: Add ethtool statistic ops
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
 <d3256c3049445bfa9c6b98832d25eaa712422ae6.1774940117.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <d3256c3049445bfa9c6b98832d25eaa712422ae6.1774940117.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273969-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FCE737682A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> +
> +static void hinic3_get_qp_stats_strings(const struct net_device *netdev,

Any strong reason to add const here? netdev_priv() would just strip it 
anyway. No?

> +					char *p)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	u8 *data = p;
> +	u16 i, j;
> +
> +	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
> +		for (j = 0; j < ARRAY_SIZE(hinic3_tx_queue_stats); j++)
> +			ethtool_sprintf(&data,
> +					hinic3_tx_queue_stats[j].name, i);
> +	}
> +
> +	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
> +		for (j = 0; j < ARRAY_SIZE(hinic3_rx_queue_stats); j++)
> +			ethtool_sprintf(&data,
> +					hinic3_rx_queue_stats[j].name, i);
> +	}
> +}
> +


