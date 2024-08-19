Return-Path: <netdev+bounces-119611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CF6956524
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB8AB22D4D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F67315AAD6;
	Mon, 19 Aug 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xwt0I/5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C715A87F
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054592; cv=none; b=YYCv184Mk+sdnY6hDMn0ALI/gvtzSUldATmc/pWdYtR/D0EdkopFSB3J+alXhAg/2R3576r0TOeLr7TnC2v5di9iw3AmyNihpqgy5e2mepVuSeBLUHX2KV3aMkt+Ze7IIW1LwrQmYIQRCMbDdUuuHcDR81wff2ZQf9pLFDx68sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054592; c=relaxed/simple;
	bh=E4r27UsZzDm9Hzitygz7nq57hxbz8ovxTHWnh3hFfBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrdJpoG7+z8cgrP5Fq84Y552kvHE1QVj5C9arPf6j4Tj3OS3TmSw7dlssfG6wezGeRvXH+7G0OX/k4cE3/OKXYfpfdAWXnJoUBQoT60z19L1VQGDQUzCCpWlbzhO/YQ0blUATzszHMun8mPGYISIgt/ojsU7lwV/KDXfs0ptnfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xwt0I/5Z; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso633377a12.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724054589; x=1724659389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwMwUOrBv5K6GrNlUlxIT6RSLW4MhY+pXgs511gqCTE=;
        b=xwt0I/5Z4vYhCrxZJVJy4JBo05TQKeDx9vYZyDAnpLxO9q2Q/s7bVH+YBCb6acktAP
         LDNRUWdU0CFbKqZoF4FOfxqZ+Oh+Ct7Upp1nIHAB3Ys7PRG3drP3dCO8DTa9KrSMzyjy
         fF0+aoCwWSgi20BcAg/Wmwqcxi9bg2124VtWf2o9hSxhUl1/mISr8vF7uyZeeT+pnC18
         K8XKunzI4X/zVfaAA7zSp1V5uNF0OUQaKg+PaMec9WYj0ncktvOIT7uQSwcD4FBEFJVs
         Z3V2aON+8fTw7d7McPlXuKnPevc0IjIYWkmTDQKzuxet8qH8dXm/oD6ghQ41lTnnMN94
         Ns1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054589; x=1724659389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwMwUOrBv5K6GrNlUlxIT6RSLW4MhY+pXgs511gqCTE=;
        b=Tko0GjfOnWIGDUyd/o63wq8MOG8ox3eS9Fp+kEMC3RuQd0B4TNR2FTqJPHLoHq/gXN
         REUHeAbzgI9WqU5rZDq8NJPfJ8Cb617MM0L6Yo018gDIGhX0p57rkNM2Fun6Psk5DEvJ
         QigFMg+L0vuO4MWEgmVOzClu8h7orD1KjA8pV0PVwM4C6nKqvUMRnHBU950Har4OMl66
         7ZD0wVgQa+XPl8VzdzbeY8IbAyEit+IZvzS7WVCZGtbtjTVrfWNVLGOzzpubyKAAel5F
         GaVdake2Mbc2VJRXux2OZLVdaa9mqWyVdVKiuCEHQMRpFFXm/w6QT455t3lBqu8EjV+6
         WFdg==
X-Forwarded-Encrypted: i=1; AJvYcCXu3ezyb6twkVDC1059YQtdHt4xjJr+7eSdFjEqNGqfjFIoeNLUYzk8c1Q0oa4mI1EwSpqcUCRKUlzPMpPWH4DCUF7fquk/
X-Gm-Message-State: AOJu0Yx0rHKYo/tfTXSsLpr+G2V0VXy5ve4UAkSFZGbAExF/336AEP4d
	5njrgtllNOMtECkcWbn4sE5s2wX1zXJs8NT1bMS1tws4mHLpHtQaKTMiHI0R2ls=
X-Google-Smtp-Source: AGHT+IGOKiO85TT8C6Cg3egA9Mu9yb+qfLgLJ7XGhliFCl4pJllxbHI6Ys7sM/+Kfajpsjm29cCP3Q==
X-Received: by 2002:a17:906:6a07:b0:a80:d64f:6734 with SMTP id a640c23a62f3a-a8392a417d5mr848440166b.60.1724054588393;
        Mon, 19 Aug 2024 01:03:08 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6777sm610318766b.10.2024.08.19.01.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 01:03:07 -0700 (PDT)
Message-ID: <67a0148b-73c4-483d-b754-c397401712ec@blackwall.org>
Date: Mon, 19 Aug 2024 11:03:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20240819075334.236334-1-liuhangbin@gmail.com>
 <20240819075334.236334-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240819075334.236334-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 10:53, Hangbin Liu wrote:
> Currently, users can see that bonding supports IPSec HW offload via ethtool.
> However, this functionality does not work with NICs like Mellanox cards when
> ESN (Extended Sequence Numbers) is enabled, as ESN functions are not yet
> supported. This patch adds ESN support to the bonding IPSec device offload,
> ensuring proper functionality with NICs that support ESN.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 250a2717b4e9..3c04bdba17d4 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -646,10 +646,35 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
>  	return err;
>  }
>  
> +/**
> + * bond_advance_esn_state - ESN support for IPSec HW offload
> + * @xs: pointer to transformer state struct
> + **/
> +static void bond_advance_esn_state(struct xfrm_state *xs)
> +{
> +	struct net_device *real_dev;
> +
> +	rcu_read_lock();
> +	real_dev = bond_ipsec_dev(xs);
> +	if (!real_dev)
> +		goto out;
> +
> +	if (!real_dev->xfrmdev_ops ||
> +	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> +		pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
> +		goto out;
> +	}
> +
> +	rhel_dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
> +out:
> +	rcu_read_unlock();
> +}
> +
>  static const struct xfrmdev_ops bond_xfrmdev_ops = {
>  	.xdo_dev_state_add = bond_ipsec_add_sa,
>  	.xdo_dev_state_delete = bond_ipsec_del_sa,
>  	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
> +	.xdo_dev_state_advance_esn = bond_advance_esn_state,
>  };
>  #endif /* CONFIG_XFRM_OFFLOAD */
>  

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


