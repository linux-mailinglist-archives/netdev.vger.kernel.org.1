Return-Path: <netdev+bounces-273972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO/iMdnTzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:14:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3023768DA
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1847C30CE04F
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A957348883;
	Wed,  1 Apr 2026 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svVPWyuY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB065364944
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775030013; cv=none; b=eSTQr2VAgzyDueT6qFDjpnRX78yfZlt6v50z/VXkZk9D9C1JCs/Vldy7CC9XktxEQ2+bqMVr24W1nWhUzsbbx2YNK9i+6+jYxqa/j3WleE0It3Kd+Kvkl1Z7hzWhluvrG2tZiJxTcfkTSUYD6EhKByBfRaZn/yiWdwWm9/nnfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775030013; c=relaxed/simple;
	bh=Iw8UWtcVlc0hciFLFi9H4GtBrzJdZOWJyX4eXzCH07o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZvYS9xHQQ+GLDc7o1SQ1pMbZhf6LMPNyQ+dMKxH7D/pzIHMJsKtoUgDdekSEaQcffwVmOBNX+Ti5JbXE+IMeiLRPWCzUkGjM3nvu2yuzF+6sai0Arpch6wxhdW8v67gzxZZToke54QP1U01vgIgcByiyqS+96+e5tUPLMqawjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svVPWyuY; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6b0500e06so8878300eec.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775030012; x=1775634812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYAA012nkWBP0515TOKa+rT4aCB7eVy71smoodsA2VY=;
        b=svVPWyuYSpuum/KP5FjKlYhoHLL8h4QQ7QUUltlQV/iB6zHUvxlosKFOTt+GfOgzUL
         wiwKAmTPq5zKmq3BP60mXRMR6ok7gnzzD5HkgiOHoCiHtnzdeAsCXZNC8I84h++GVjqg
         uU8cdz7Qusbd9Pi+1Tfh+DAbwmy1OTxL7yezLcGfM1iJ7fU+ollVEdhZgDKTuak2hSiE
         mXFys+zhYIOuTjxItFNJ6vCpDrF/qQga2/MmC5BW33nVdel0T1rocSppfvcja7GCML0y
         7PCtmRYYCbWVxAYKvwbXavNOmLscPtepOGc/dL395cQIXzIZEitHrkx3SxfjYknOYENV
         isUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775030012; x=1775634812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYAA012nkWBP0515TOKa+rT4aCB7eVy71smoodsA2VY=;
        b=D8/Xv4emDwDr8cTYwyyTwF4p7Utl9bn5jZ5YlfioWPkP7jgwbfWMP6ZXAnsScreLnz
         KLLDjocWekyn8Lmj/rTOOEuclXLzFo1SijG81rt/SCNVKICHEn1BxX1XRN0Y21QR+wV1
         DuoOmRKv43OoWIKd036IQm4st331YziF7FIT7hJarNZHBsBewMqiFKfrBUzoaquacex1
         5eOO9Xi6CKN++X8PEjlKh5cmkTxmgvCBic1ZyTFAc+QkWmYSoPZK7LgOgS+x8J+WblYe
         ttGPe5lhQGzgKOJVhs35RZh7CKQU1kZHeHavMR2aw265I2eAW60n4QUZ5Bvc1SJ7MrDx
         0zXg==
X-Forwarded-Encrypted: i=1; AJvYcCVxhN8/0xcI58wBnbgPObacxA5VVy2kLb4F28EWKwp7i800/vnQ3gy/nzB5X1F/UySpo3nJdMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaUH5XnQaigeqtNMFQy9uXRKDPUcmTYmh/uqXAiXlfuido1N81
	zu5atS8N6wjX92WyLp+fVYyEMrBpzStBFcxJIzpD8WH7/VcKwOWRCwFz
X-Gm-Gg: ATEYQzzMvpaSLIDOcNMW3VyRup4LhjQ5fGaZutjQgGIWNDe0tSS79WBYZq9HXqkG2qy
	rt1Q4XEsOH/N2FgIbu1jt+02W7QBerlwTHMU9qwmX103Bc+BL/huzIbRVzced+cnBUUXGlL1o5v
	+qV+EHBggbBm+3sEiJ5PLRYkR+yIHdZBPpcLxyB9YVxJ0Ix8NFJKlNFSSkqRZlv5ObA+SPEuG4F
	a9njF/P33xKoMUVXDFiVTuhVzEZbB+PN6XVj57YI+oYWR9Rlwc7G5KWTD+v2lXljE1dIjSB3C3J
	88XgeuYs3+oKwoKbs9OCAVQ/AfLPzTqzBqZhODb6lL+v3voRvIOfIgVxjOItts9B6qgk7QONph4
	Z7CrXZMCZKGVVBZSzJkp+LxP68G/10iQwxER2WPdZwgYb0DzRCYDGtk/SWyygrSJg1eiDNj6P5p
	YN/1w/I67mQCzMFn3uKRRra06g+ANlcYHWv2Q7jcE3O9zoFvjon8vNAred5xJb
X-Received: by 2002:a05:7300:6d1f:b0:2be:833c:149d with SMTP id 5a478bee46e88-2c9325b4835mr1497608eec.28.1775030011765;
        Wed, 01 Apr 2026 00:53:31 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::139a? ([2620:10d:c090:400::5:51bb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c4cbbc1fsm11662388eec.13.2026.04.01.00.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 00:53:31 -0700 (PDT)
Message-ID: <3b252b2b-6be7-4a8d-9782-39695e948635@gmail.com>
Date: Wed, 1 Apr 2026 00:53:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v03 4/6] hinic3: Add ethtool rss ops
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
 <a8347921a7ac11ca7e0db52381be70689b830005.1774940117.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <a8347921a7ac11ca7e0db52381be70689b830005.1774940117.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273972-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA3023768DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>   /* hilink mac group command */
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> index 25db74d8c7dd..1c8aea9d8887 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> @@ -155,7 +155,7 @@ static int hinic3_set_rss_type(struct hinic3_hwdev *hwdev,
>   				       L2NIC_CMD_SET_RSS_CTX_TBL, &msg_params);
>   
>   	if (ctx_tbl.msg_head.status == MGMT_STATUS_CMD_UNSUPPORTED) {
> -		return MGMT_STATUS_CMD_UNSUPPORTED;
> +		return -EOPNOTSUPP;

Looks like an unrelated change?

>   	} else if (err || ctx_tbl.msg_head.status) {
>   		dev_err(hwdev->dev, "mgmt Failed to set rss context offload, err: %d, status: 0x%x\n",
>   			err, ctx_tbl.msg_head.status);
> @@ -165,6 +165,39 @@ static int hinic3_set_rss_type(struct hinic3_hwdev *hwdev,
>   	return 0;
>   }
>   



> +static int hinic3_set_rss_hash_opts(struct net_device *netdev,
> +				    struct ethtool_rxnfc *cmd)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_rss_type *rss_type;
> +	int err;
> +
> +	rss_type = &nic_dev->rss_type;
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
> +	err = hinic3_get_rss_type(nic_dev->hwdev, rss_type);
> +	if (err) {
> +		netdev_err(netdev, "Failed to get rss type\n");
> +		return err;
> +	}
> +
> +	err = hinic3_update_rss_hash_opts(netdev, cmd, rss_type);
> +	if (err)
> +		return err;
> +
> +	err = hinic3_set_rss_type(nic_dev->hwdev, *rss_type);

So if we fail here, we have already modified the rss_type in-place. From 
this on-wards, the HW state would diverge from in-memory state. How 
about use a local copy and only update if no error?

> +	if (err) {
> +		netdev_err(netdev, "Failed to set rss type\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +

