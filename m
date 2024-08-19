Return-Path: <netdev+bounces-119612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E548956525
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91C4B22E08
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A8315ADA1;
	Mon, 19 Aug 2024 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="mu6pireO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9BB15820F
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054608; cv=none; b=H4GDznI2Z0AwJ/r4Z18C7NLwzX8JillurBGFtlJr3KLEE9P2arrOFfLNN++aoMzy7NVMbce2jX6UG6Ofe19i91NdOqn3mn3k1icE/AXFoR1hWfo0L7/o7DDXejoNbwYpMyMxV49l98otQPrsLe7pY/nKg7lzDit2NXBJ9g3iOVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054608; c=relaxed/simple;
	bh=xD3ZwjdEWOBNwLTdjwPrAEQ3OzhoNUn3KXx7oxSix7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTGaGRXoz3zPP+fdSiT1wlTxVdl1LEDGz1sOJi4CgdoE3gkEABnDVIwdPqace2piru1H4lzFBertlB5tnjglIp858ceEEnX0aGKT81qWy+5/iDJhTHjFgIH2RrXEiIKbummRtbqkPsWidzkcYuVQ0PGaSEThRuWxpHNQ+/CzxHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=mu6pireO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bf0261f162so153868a12.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724054604; x=1724659404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyVG/a9sfmgTt3Pl3BNOj4zJy+4hdYRiXz6Waw7aZWE=;
        b=mu6pireOMsJaMQ/em20aXOKNIiRxOvMlIhT07AXNmEdRQ0R5wIY+o2ZnweyI5bknZr
         qLSQdnzsVuykeJ4BGO5Vr7apONOAoNEMVmJ5leJe9yn2A1tHt+/PRlL6Be4FMVEbDO2V
         pW6tg4aKbMZaxpGopX+612l4VgnWxQwb+W/yi47gqZBjp1u4KGvrQrh/YGZZdLNUpU9m
         uQk68Y4DB6CG3sUCacbhd3LD19SIA1orN1/cyl/rKTVd0rEoerBAD/a8l37Tocj8zJHC
         MDuPFH1JrmH5NqT0YbukCAxHeGFIxPTsDgWOmyHTuMWvpEEPKLF2GkkVBevol3nbPUFi
         V0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054604; x=1724659404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyVG/a9sfmgTt3Pl3BNOj4zJy+4hdYRiXz6Waw7aZWE=;
        b=tttbN1QiE87qdBZATJiXqmYRB69z4vfyJDe7A0vjuDkyvSUO3A+AvW3+SRc4maFNX/
         X+mgC7O7rF/+9bEN590+Yax7Pb/iAzte5i0s/xOpg1oEocnWC9FPB+R4UEZiM45QqV5W
         W4VMOEsqFIolDx8gQA7vtWuKBEeQ+8FW1Xuf+q08OzTowYo4Xx8iDxHTqrgus1H+5qBL
         G2mCS402dyW59Hh9/N2WuMZv3e98h7Ge4Wbzz51NrNjEXfAol9Gc7RuIqvRFTZgEv2o1
         YNNqHrAVjQJqNBU8l08bIdTvpbqZwB1siYwQRYXfUXXOzEf+g37z2mR5czx0R+6jz5vX
         4GPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoSKIpObyEpewdNwOEd9tBCqaffK2imde6ktXDq8PfUcFHnE/JLNKEOqMDVNrmlVqtKZUud6KjXGgEYX+osbGMAKjUXHmQ
X-Gm-Message-State: AOJu0YymzOCmY1QTLpt2nnE+FWMNLfrwSlsjHcDE3QEg/4cjK35dvoYZ
	1++ZU2PWbXQvK22KL0Yuo4pUhuSV85PgGxcAfsWy6HNO8EO3Smdo00+P05sM5GU=
X-Google-Smtp-Source: AGHT+IGzZABMRQffxHXK92IbM7Zwvl29zT2sbExnPR8hxWNt33ZFw+VnC0qpqfONmJpmJq48Iu4pqg==
X-Received: by 2002:a17:907:e61f:b0:a7a:9a78:4b4e with SMTP id a640c23a62f3a-a839295426emr792954066b.40.1724054604127;
        Mon, 19 Aug 2024 01:03:24 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d001fsm602783866b.84.2024.08.19.01.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 01:03:23 -0700 (PDT)
Message-ID: <8b6747d0-c94a-44fb-9914-cf6cfd04902c@blackwall.org>
Date: Mon, 19 Aug 2024 11:03:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 3/3] bonding: support xfrm state update
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20240819075334.236334-1-liuhangbin@gmail.com>
 <20240819075334.236334-4-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240819075334.236334-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 10:53, Hangbin Liu wrote:
> The patch add xfrm statistics update for bonding IPsec offload.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 3c04bdba17d4..9e41e34e9039 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -670,11 +670,36 @@ static void bond_advance_esn_state(struct xfrm_state *xs)
>  	rcu_read_unlock();
>  }
>  
> +/**
> + * bond_xfrm_update_stats - Update xfrm state
> + * @xs: pointer to transformer state struct
> + **/
> +static void bond_xfrm_update_stats(struct xfrm_state *xs)
> +{
> +	struct net_device *real_dev;
> +
> +	rcu_read_lock();
> +	real_dev = bond_ipsec_dev(xs);
> +	if (!real_dev)
> +		goto out;
> +
> +	if (!real_dev->xfrmdev_ops ||
> +	    !real_dev->xfrmdev_ops->xdo_dev_state_update_stats) {
> +		pr_warn("%s: %s doesn't support xdo_dev_state_update_stats\n", __func__, real_dev->name);
> +		goto out;
> +	}
> +
> +	real_dev->xfrmdev_ops->xdo_dev_state_update_stats(xs);
> +out:
> +	rcu_read_unlock();
> +}
> +
>  static const struct xfrmdev_ops bond_xfrmdev_ops = {
>  	.xdo_dev_state_add = bond_ipsec_add_sa,
>  	.xdo_dev_state_delete = bond_ipsec_del_sa,
>  	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
>  	.xdo_dev_state_advance_esn = bond_advance_esn_state,
> +	.xdo_dev_state_update_stats = bond_xfrm_update_stats,
>  };
>  #endif /* CONFIG_XFRM_OFFLOAD */
>  


Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


