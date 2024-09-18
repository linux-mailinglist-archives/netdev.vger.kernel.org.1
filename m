Return-Path: <netdev+bounces-128775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133D097BA37
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 11:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41D5280FCB
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E929178363;
	Wed, 18 Sep 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="nACpbfgo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC21304BA
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652432; cv=none; b=CSQ/vQcxkzDqUX+zA4CjAH7RNSc9UcIJusMCeQ534n3R+m3j/7p27eYPJSOKRfYkvi5yj/wucxX2hB4DlavuVf/C928aLVo6XQU3DxXaX8nsKeksldbVr4a4Kl0DRpxTbdzUuGr2faJKhGR3d6lmM8Hg1PAmPxLholIMMGLeAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652432; c=relaxed/simple;
	bh=sa/Z3gBxGkduZ21tgEojAUz0JuOfKH3xqjWZecw5e8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7SNavH5y/dHUW4KHwJGcipvxKWcefFXcaVrFUUthyI9kyvhldmwwAVIYfXzjL3xGBC1P7AALPxqO5N2tC5I6VZE8PaTf3DbCZs+l2cO+eU42JVVY8tHBr2EdTdHLgN7JcNJ+IihWAo9tD2cXU/r7/tRmETRkZEjMAOYlFnLAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=nACpbfgo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86e9db75b9so1023624166b.1
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726652429; x=1727257229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lecaVNcmA2JjtTGwgjFCKRgWjf3SejBL7F1D6E+FvJw=;
        b=nACpbfgoyN/D0eHZdEPaDPBpOMk5p5HbZsnX7ddI64OIh+bPGl4W13mpuSyFFNZzJx
         fq3XnxCghcqldsLkC+2hwj/iDOvxyQMgXVXqTJZLa6D4HOxQLnxuM8jzz9BmE4EvCkqJ
         0HbdE/Q+MtZaCcqbzxaVaWJzNNTTJENw2EZaq/+dY3MXKyijqgF7y9215tInT2z1nw+f
         yHaiCgikubbrDgKPlLlUWSGFKSCpAGLlERCmctjd4ONCXudWGR0Z7Vv/qfnA3ZJQjeIp
         WgE8RrjPai89DJVCbn6QmtOqXiorCAI8WooUiyR9kPlgJRlXFLi0HUdLS9GuztOoZBUD
         DQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726652429; x=1727257229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lecaVNcmA2JjtTGwgjFCKRgWjf3SejBL7F1D6E+FvJw=;
        b=wUDU2+sjgZOuSINiyG4tK0+Rvi2AQ0J8wJhqIyDDQ0viSdExfKLEpZth/eZOrEh+Kv
         LNxy95CEsXvcvQHvTC7FXEdCWKSM7LnAyQ+Df+BmJA1CMhyJzVOkRtQtnW0ZnLRHscxb
         FsFpsdBff9+d7XkGJTAugmgsmsxhVSz+r15WEc8kvcwIYCGOAyVdnqbR9Y/kIMNcQjCt
         A5F2Dxk2MR4sKxW8FiDqRfqtf0Vy1fEBKSGrGblplGuNhWJ0KHgTX+eY9DlpYAnAwI6b
         jSLPo0k7ICmD+rv81qCt3UlA2bnkjGXjUu+MwJ3F0WtEXTMKB7lCJikntfOC29pwxuKF
         CxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx8K/nSm2wx/D8HF8Ooq+c8AatkbCTgbM+B4n2Iuq2k1g93J6R6y6InwzuDpvNrCiPbubvgOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSyzQLk0eqsDc99rACuYXDP06l0E5cVX/Tm2fI5dM2kLRnq9/q
	wJ9S1bUTMDu3UqFvdxzSQl4ABEnPWQoOE4r/Px4eowGQWKaR18qWTkvSby3ILZY=
X-Google-Smtp-Source: AGHT+IEiDtpcBMns4eThOyjvY7vmtUnEvrsljknDy5RtOY/mIovMESzUzkgE3/KMjtr9ngXAVkLERA==
X-Received: by 2002:a17:906:cadc:b0:a8a:7501:de21 with SMTP id a640c23a62f3a-a90294ab552mr2114018966b.12.1726652428674;
        Wed, 18 Sep 2024 02:40:28 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e5675sm560870066b.169.2024.09.18.02.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 02:40:28 -0700 (PDT)
Message-ID: <a475dfac-3bd7-4877-bab4-3c08259501c2@blackwall.org>
Date: Wed, 18 Sep 2024 12:40:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Bonding: update bond device XFRM features based on
 current active slave
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jarod Wilson <jarod@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240918083533.21093-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240918083533.21093-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2024 11:35, Hangbin Liu wrote:
> XFRM offload is supported in active-backup mode. However, if the current
> active slave does not support it, we should disable it on bond device.
> Otherwise, ESP traffic may fail due to the downlink not supporting the
> feature.
> 
> Reproducer:
>   # ip link add bond0 type bond
>   # ip link add type veth
>   # ip link set bond0 type bond mode 1 miimon 100
>   # ip link set veth0 master bond0
>   # ethtool -k veth0 | grep esp
>   tx-esp-segmentation: off [fixed]
>   esp-hw-offload: off [fixed]
>   esp-tx-csum-hw-offload: off [fixed]
>   # ethtool -k bond0 | grep esp
>   tx-esp-segmentation: on
>   esp-hw-offload: on
>   esp-tx-csum-hw-offload: on
> 
> After fix:
>   # ethtool -k bond0 | grep esp
>   tx-esp-segmentation: off [requested on]
>   esp-hw-offload: off [requested on]
>   esp-tx-csum-hw-offload: off [requested on]
> 
> Fixes: a3b658cfb664 ("bonding: allow xfrm offload setup post-module-load")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index b560644ee1b1..33f7fde15c65 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1353,6 +1353,10 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
>  				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>  							 bond->dev);
>  			}
> +
> +#ifdef CONFIG_XFRM_OFFLOAD
> +			netdev_update_features(bond->dev);
> +#endif /* CONFIG_XFRM_OFFLOAD */
>  		}
>  	}
>  
> @@ -1524,6 +1528,11 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
>  		features = netdev_increment_features(features,
>  						     slave->dev->features,
>  						     mask);
> +#ifdef CONFIG_XFRM_OFFLOAD
> +		if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
> +		    slave == rtnl_dereference(bond->curr_active_slave))
> +			features &= slave->dev->features & BOND_XFRM_FEATURES;
> +#endif /* CONFIG_XFRM_OFFLOAD */
>  	}
>  	features = netdev_add_tso_features(features, mask);
>  

Nice catch,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


