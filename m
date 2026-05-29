Return-Path: <netdev+bounces-292985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ERNEFHAkGWotrAgAu9opvQ
	(envelope-from <netdev+bounces-292985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:30:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D80665FD5AD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F2BC3028AF3
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403D739F18F;
	Fri, 29 May 2026 05:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lflhx9Vn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E527380FC0
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032621; cv=none; b=HegSvtXcDdSTCrhyjiZ530imBx8Wz+UTdPAI3d6MtDQ7YBfbQi5x29wyEaarPY2twIG5l7HkYTnPT++aw00fXMJCJp4n2xrYRqzYF4oGkPRYCdA/Q3v9onoeDml4vjF0Qsx6VBUJP2cKSqhcz9HToIWwYZ+e0XaWBV6ro0nRVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032621; c=relaxed/simple;
	bh=jQRuadW4ipCNWKXC6bZwaj6vtlzEjMOxMjmPAtj9zUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXi2yT8Df4Wk6DFL3aabQ7UQl/ruWmm0O+u/AMfv7Ap2pqKHRLs0xF8+RgA8/IAU7UPvRD7Ox0HE6D22pL8AnwmeYWa9pmqE+llmpRDEHosMqK6toceXi3BHVNZbhPtiUmAkEiHhI2ZecD+2L8ukdGqDpmvurenaoZsrD/LlTZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lflhx9Vn; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1353c2f35cfso6300573c88.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780032619; x=1780637419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOhAPE7Hmb6u6mGyw2ElJiYEhXMYwY57RoxbsdcyxYg=;
        b=lflhx9VnYMR3FDgCDrvLS7zDxs2N8/swwMoIz76FjlXPPWneBLvcXtbOQvvL8LVooc
         J8yWYEWqO4G6pyWsed61FzBl30WdHmP0yHB0LX+eXXVxZ/nU7Y5SYWCZu7BmhlOt+/tZ
         NdcEDXiPK8YN3DaoeqP3Yh0dD49XpY3el5EKLWz+RiX8TtK7MIxjk+6gVMOLWamSCabk
         JWO/x+q5cAQ7qhM/GYaUqZUTnqC0J59X0e8rkbn3g1sidId122LK8Iz/O6xOympxi+LT
         Sv85ttDchkpnxw9RpPKDa1mpRRxlQbImsB9sk3F53tQeTR3bNz4B1ClwvZ3hnHhMm1p5
         NmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780032619; x=1780637419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOhAPE7Hmb6u6mGyw2ElJiYEhXMYwY57RoxbsdcyxYg=;
        b=AXuBJ+Ym9aMDUmQR1Zae0TqCtX8ofbnKpyff6enl1NyK9P1gV5y9mADD8Y4NT+JQtP
         ud3giSnjImyicwfkctUJaSm4UMhmwN/bdD08/detvcR4dlXvONtNbS5Pt3o4r5y/0y4a
         kGNAoIyFg46xfQzvqfEjv6KURvm+Btdkx2yFscuNf3ahHpe4lfdi83ThkeoXZAQpdb2L
         +VYMWSgY92XVksUxdddBymMiCWTYCcC5jkPD1LcrawDuv9DmZOFEoZTjflOIRUTI02jw
         PLujXK8ytZ62Fijj59pcntPhf+wJ4GxSnN63FHv2SeNfLKw5S9s0Y2X/80MU+pS/0hfF
         fO4g==
X-Forwarded-Encrypted: i=1; AFNElJ9pDerBfQox56/gBwVvBt0hccD2W/AR0lCFBmsT6nmYUjriovlOmLTr5V3B+UHIRmcSwqHcIWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy16bElKkfZoPlqdmDcYLAyXyX8zLXhVcF3pOKR39eTqJJNo6wI
	gK85q7BDPPoCH0SfFsZJcZTcAn8bWLuuOpWwZfSJCj6bQ/twg7DdKyNy
X-Gm-Gg: Acq92OHP4voPRs8c5UsH39odbukssfGrOYEQj6pkzNuodVEM/HD/Pn+7G1Dx5nKmllE
	uE/Bcmh9pam1r1PVjUBYzlR4O+3b2anG7eu2S9Kxnjm1FW68VP3EvJGWeW1z3SZSla81c6sewfN
	dn7g+87+IZq23aoE6lQij7hcRMG2p1z6gL+JdSNh0duSAG1TCtNa/BfFvKLJMMsJAlDMuvq106L
	geBNhC1xmFGdYrUBhXxGhc4n2+09NckJFWpHZ7kXoD9EBVFOv4M0PB2hwjmxeQSlpFSf97IYkC/
	g7uP9VxIyYm1PXkxLpNroMVsDtXYlWhPEvkDQEokvkYTThJMzV9FgTA5Duq2gJOkg6IqKyHHFs3
	j+8i9fpfVUic5mtRIKW24LuR7RjyYjSuz3hxpqzcaTTEGM5HkYxiWmuv069Aky6FCBu+YwC1qNb
	gB31FF5oiL0KiQqS+OJ+dxYKi2LHVeoxkAF9eC9VdZbazG4HOamxf05uLuHOGtWON4Yg==
X-Received: by 2002:a05:7022:f84:b0:137:699d:7b95 with SMTP id a92af1059eb24-137af647ee5mr582575c88.19.1780032618982;
        Thu, 28 May 2026 22:30:18 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c8::1024? ([2620:10d:c090:400::5:c891])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c7e4ebsm598300c88.12.2026.05.28.22.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 22:30:18 -0700 (PDT)
Message-ID: <e282d783-3d91-493d-99f6-09464df26c60@gmail.com>
Date: Fri, 29 May 2026 10:30:03 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v07 1/6] hinic3: Add ethtool queue ops
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
References: <cover.1779940072.git.zhuyikai1@h-partners.com>
 <1323cad7ba784efa29a3fd1475b744974e0a0cf5.1779940072.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <1323cad7ba784efa29a3fd1475b744974e0a0cf5.1779940072.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292985-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D80665FD5AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


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
> +	if (!test_and_set_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags)) {
> +		hinic3_vport_down(netdev);
> +		hinic3_close_channel(netdev);
> +		hinic3_get_cur_qps(nic_dev, &cur_qp_params);
> +	}
> +
> +	hinic3_init_qps(nic_dev, &new_qp_params);
> +
> +	err = hinic3_prepare_channel(netdev, trxq_params);
> +	if (err)
> +		goto err_uninit_qps;

It may just be me, but looks like a failure here is not restoring the 
old state. You are correctly getting the new resources and freeing them, 
but don't you think a call to hinic3_init_qps() is needed here with 
older config?

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
> +	clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags);
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
> +err_uninit_qps:
> +	hinic3_get_cur_qps(nic_dev, &new_qp_params);
> +	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
> +
> +	return err;
> +}
> +


