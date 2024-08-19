Return-Path: <netdev+bounces-119610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5A395651B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A11F22CB9
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A291BDE6;
	Mon, 19 Aug 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="pl/DCeY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27473A41
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054540; cv=none; b=ldx9dWwSijH26DkHrai5tMQErbRTimejY+yQGDjh1YxY9PM30D2EERuci/TDbhd1rayh37RIBlcYMBSI3OZhwSMuzB1UQ/J9YOIBED3Rb3ftgHGklQbtcu9PYkC6mlJnfrOKQvEASTqu0K5UzgQedH31Ycol0aGh07pd2HG1HHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054540; c=relaxed/simple;
	bh=zSJWA9B/gruO7ttwjc2El2q0TFklISg/kCA4oMVjFOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcaqxhfM++0AtUdxCDdVPnwumDGqE3vYFtOXLmFAXc51vl/x6mduAcYa8C466emDx3c9iY6PI8gcWvapQTGqtDcEMgMknA94jLYgtzKxxrW4Wbp78Yqhx98BXvfy3aJKRgPC1VLlSjHG7+3hocaMvKceSRK2udlOpZuJW6o6e8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=pl/DCeY5; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-530e2287825so4202815e87.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724054537; x=1724659337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qm+JUmS3/o7K0YSFotlVuIUjfBqfyH4CgH/tEYcDJlk=;
        b=pl/DCeY54tAnUx64kR/46Q9jUeKCYAdp11Kb+ONzwH3ELKJJtq9eG6n0BUH+Iva7fo
         7uawI1LYW8VZGwwKIsX6As3yVkKnh9zYr3r20YipFFg+vKCrtNY36AyaUqWgWzKvMlML
         hwLYk2KQkVwziqd4QMWiDkPiCcgyopbKbxvncwVrRF24phRQgxWosVKigASFZX9Jzegl
         gwBaa/8p9GrFXOPYoS5M82Wz8pmldmkqsPqNPXbGyPLKm0+/SFKX0VOKAnWDC+J1yoe/
         +cS8LkaJPUMgGurJvw5OFSf/jY5MdWnfxwgOp+6/oJ+buT+DgiS//1aL0xUIkUhG1hpR
         ZtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054537; x=1724659337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qm+JUmS3/o7K0YSFotlVuIUjfBqfyH4CgH/tEYcDJlk=;
        b=t1LK/5MLtafLH5Dg3OlDOBsl+CEW7N+DCEFkLl19ijnz0efWU7/iMZA9rrsruXWpaV
         deHtmumTk3UCgdDaQDkxUkNvKt8j5r4pCE3OA4CyFe8L20yItniTHrRkPhpJE9/hkqjN
         FiDjwTbB41q9g2ktxYZeLWB2A2uGW8RlRzBXqlPIRBAn9IdXP0C708xL7zLlqVHbgyVy
         6l1oD6YMZ3kNfbCzPCEg0j47mgC5VWdxFelmaNsImfw8yx2Rl9FZ0SUgcg9f3UTofYKN
         oj1h0BM5SORmHgHfTEMBCRrQLJP581EdXjpcFyrSxlsFlsP3ukGJVX4FCi5O6ksexzbr
         xceA==
X-Forwarded-Encrypted: i=1; AJvYcCVF40t+r6R+gaoauKozB6jTMd+nAnetK3RWxIW1SUZU3y2obn7ZvULmwpZOFEnSRRT4oq5Fu+6nu5Kwi7cLYwrfjzi4qFoX
X-Gm-Message-State: AOJu0Yzk13WfRJj3+zW1hqTfD6WVg9r7hvSZdqIP9+Ci0r1DCTd8bpjs
	vxeKlj24O3vtOXBdgdhFsdNnI94knw6G6ggONsE11J8HS7mjAtCfQdsl+82b9Dw=
X-Google-Smtp-Source: AGHT+IHCk/UCx5qEeKxF6ijHMxu3ZnXDb8JC1Fx3y7IMwdliR7CtlAM21hKYBVIFqqu3JhLvdQR0OA==
X-Received: by 2002:a05:6512:138b:b0:52c:e3bd:c70b with SMTP id 2adb3069b0e04-5331c690c37mr6533160e87.1.1724054536472;
        Mon, 19 Aug 2024 01:02:16 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb18sm605014566b.60.2024.08.19.01.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 01:02:16 -0700 (PDT)
Message-ID: <a60116a2-bcbd-4d0f-9cfb-7717c188e26f@blackwall.org>
Date: Mon, 19 Aug 2024 11:02:14 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 1/3] bonding: add common function to check
 ipsec device
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20240819075334.236334-1-liuhangbin@gmail.com>
 <20240819075334.236334-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240819075334.236334-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 10:53, Hangbin Liu wrote:
> This patch adds a common function to check the status of IPSec devices.
> This function will be useful for future implementations, such as IPSec ESN
> and state offload callbacks.
> 
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 43 +++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index f9633a6f8571..250a2717b4e9 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -418,6 +418,34 @@ static int bond_vlan_rx_kill_vid(struct net_device *bond_dev,
>  /*---------------------------------- XFRM -----------------------------------*/
>  
>  #ifdef CONFIG_XFRM_OFFLOAD
> +/**
> + * bond_ipsec_dev - return the device for ipsec offload, or NULL if not exist
> + *                  caller must hold rcu_read_lock.
> + * @xs: pointer to transformer state struct
> + **/
> +static struct net_device bond_ipsec_dev(struct xfrm_state *xs)
> +{
> +	struct net_device *bond_dev = xs->xso.dev;
> +	struct net_device *real_dev;
> +	struct bonding *bond;
> +	struct slave *slave;
> +
> +	if (!bond_dev)
> +		return NULL;
> +
> +	bond = netdev_priv(bond_dev);
> +	slave = rcu_dereference(bond->curr_active_slave);
> +	real_dev = slave ? slave->dev : NULL;
> +
> +	if ((BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) ||
> +	    !slave || !real_dev || !xs->xso.real_dev)
> +		return NULL;

No need to check !slave again here.  !real_dev implies !slave and
vice-versa, if it is set then we must have had a slave.
I prefer the more obvious way - check slave after deref and
bail out, similar to my fix, I think it is easier to follow the
code and more obvious. Although I don't feel strong about that
it's just a preference. :)

> +
> +	WARN_ON(xs->xso.real_dev != slave->dev);
> +
> +	return real_dev;
> +}
> +
>  /**
>   * bond_ipsec_add_sa - program device with a security association
>   * @xs: pointer to transformer state struct
> @@ -595,23 +623,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>   **/
>  static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
>  {
> -	struct net_device *bond_dev = xs->xso.dev;
>  	struct net_device *real_dev;
> -	struct slave *curr_active;
> -	struct bonding *bond;
>  	int err;
>  
> -	bond = netdev_priv(bond_dev);
>  	rcu_read_lock();
> -	curr_active = rcu_dereference(bond->curr_active_slave);
> -	real_dev = curr_active->dev;
> -
> -	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
> -		err = false;
> -		goto out;
> -	}
> -
> -	if (!xs->xso.real_dev) {
> +	real_dev = bond_ipsec_dev(xs);
> +	if (!real_dev) {
>  		err = false;
>  		goto out;
>  	}


