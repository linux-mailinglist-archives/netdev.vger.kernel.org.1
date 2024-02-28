Return-Path: <netdev+bounces-75872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB4D86B691
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 18:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A8D287905
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462F79B81;
	Wed, 28 Feb 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKZhhflH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1E3BBC6
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143095; cv=none; b=ajDXypFnAE5MxMTCRPlg4abFmwyTq5GLPrDyP9OgfBxdZtQ/A3pELIU85ppQ6fZ7EWC1cj0DjRdLnICmjoiU39wHPvVGdaBMfOqKFjP4BVgn5oY+VDUgYO66gXGKqjrx3Pb3TTHuesMbG8vP8FVIDUagpfsJ4k3LGrJrKJV6NpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143095; c=relaxed/simple;
	bh=cwZiV52W0Y4J4E8o/fpSdIpBIClZMIEQbiWW06NOSag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/BbBH87cz0zB84VnxFr+BQvF0Y9dXkUcI6PD+4x9b1IqDKcL98iyoEQ/vBjmxy3tBaC0BLHHMTJD2/YEc6zpnr3zHxUR/gMyE60cYMsFvz09MWfosdQ6y+46sJESeZED5IHNgvgb90D7VTCj3+GrsDx1tqSAffQ7ciqPaUC2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HKZhhflH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512aafb3ca8so5739684e87.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 09:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709143091; x=1709747891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jJWhDy/4v7p6ijvXOsuvAzvYiBXZd1/Rbd71b95v5s=;
        b=HKZhhflH8oebgM1wEmzKZCTJ10RlHHrhICV4QIzMsB4cxSowyjldig2JJG9bvwicQw
         PhzEAHNxM6jTSgMiNKqEbRKV0N0DdS/nzWgPmH+h4ZW5CEIsNMvgJuLVOn3KlxLeXBtV
         4x1o0ztGHAQWLX9bFzEgRSN9jBSWUoid5Q430C0SN3I2MFJ60TjDbE2h81QbCOUrDJjZ
         lCq54VZFvJCF9Z9j1U/eaVjK1cs0NNuSFSJTFfIRmQ9Qxf9WLGPuChNe+BfyvaRjot3h
         lt1dYi3T7YVhLTsY1XPBvHnwLWVEBs223CJsPKAfMSegPeV5gkQUThNVWmAd9cmSRSBG
         R4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143091; x=1709747891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jJWhDy/4v7p6ijvXOsuvAzvYiBXZd1/Rbd71b95v5s=;
        b=rlOS/ajrGeDIM5pYir7VWgAMxwAJmDedWviwvFo6PaDyJWg4hTNHTzqQVcj0ZLsCka
         /UBELxD2MQ24dbzPeAnKH6TmNsRZDpYf20ObwjL/fMO92UpuPoLH4Hf7morVaYP57iT2
         6+HQ9dXHxMtAEZDOmNRYShmisNE1ErIFtcl27wctCXbh0ikTJfJaM3ROZjZ087ARFLco
         LE8/XNHkMlizLbNSaydfySigPR+rKpM3bK1XsptWmI0tUv6VbfImU7ub+mbI/5p8j+Gs
         O+IjJwzCeD79NAM6QTn+o5CcuwwE61k2LgK5rp3NkLzrjIe6aC/Uf2ySRi/VOKXhTH3C
         0sdw==
X-Forwarded-Encrypted: i=1; AJvYcCWwg0H/c2fRMJHKsAVOrl9k1n7eKjcPYSW9ghohdOAsS6X9EIw2LbyXRrEYBH07Zv6W5xdVUXbi25rFIA6grm9kkeH7/rgh
X-Gm-Message-State: AOJu0Yy8Cw4pVSDuSgAE/kf2noHx/P0IBHbiG58tVV5t/CQxa21KCSG5
	X5ud9up8256s8WYyGXy7I5PfzAzsvpkrvcUZUwtgWGqpMp2bowDnKcuJE0Kh49g=
X-Google-Smtp-Source: AGHT+IGeMb8GvdN1GKFJ44gE1Wrb49Q1GOwh8I5mdv3/2IvchNoaxUJcJdry4KzXQeujNBKsOdl3zw==
X-Received: by 2002:a19:ae05:0:b0:512:c9bc:f491 with SMTP id f5-20020a19ae05000000b00512c9bcf491mr269277lfc.47.1709143091336;
        Wed, 28 Feb 2024 09:58:11 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id eo8-20020a056000428800b0033dcac2a8dasm12637657wrb.68.2024.02.28.09.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:58:10 -0800 (PST)
Date: Wed, 28 Feb 2024 20:58:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: hsr: Provide RedBox support
Message-ID: <9ea38811-4297-424d-b82c-855ee75579f0@moroto.mountain>
References: <20240228150735.3647892-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228150735.3647892-1-lukma@denx.de>

On Wed, Feb 28, 2024 at 04:07:35PM +0100, Lukasz Majewski wrote:
>  void hsr_debugfs_rename(struct net_device *dev)
>  {
> @@ -95,6 +114,19 @@ void hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev)
>  		priv->node_tbl_root = NULL;
>  		return;
>  	}
> +
> +	if (!priv->redbox)
> +		return;
> +
> +	de = debugfs_create_file("proxy_node_table", S_IFREG | 0444,
> +				 priv->node_tbl_root, priv,
> +				 &hsr_proxy_node_table_fops);
> +	if (IS_ERR(de)) {
> +		pr_err("Cannot create hsr proxy node_table file\n");

Debugfs functions are not supposed to be checked.  This will print a
warning when CONFIG_DEBUGFS is disabled.  Just leave all the clean up
out.  If debugfs can't allocate enough memory then probably this one
debugfs_remove() is not going to save us.

> +		debugfs_remove(priv->node_tbl_root);
> +		priv->node_tbl_root = NULL;
> +		return;
> +	}
>  }
>  
>  /* hsr_debugfs_term - Tear down debugfs intrastructure

[ snip ]

> @@ -545,8 +558,8 @@ static const unsigned char def_multicast_addr[ETH_ALEN] __aligned(2) = {
>  };
>  
>  int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
> -		     unsigned char multicast_spec, u8 protocol_version,
> -		     struct netlink_ext_ack *extack)
> +		     struct net_device *interlink, unsigned char multicast_spec,
> +		     u8 protocol_version, struct netlink_ext_ack *extack)
>  {
>  	bool unregister = false;
>  	struct hsr_priv *hsr;
> @@ -555,6 +568,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>  	hsr = netdev_priv(hsr_dev);
>  	INIT_LIST_HEAD(&hsr->ports);
>  	INIT_LIST_HEAD(&hsr->node_db);
> +	INIT_LIST_HEAD(&hsr->proxy_node_db);
>  	spin_lock_init(&hsr->list_lock);
>  
>  	eth_hw_addr_set(hsr_dev, slave[0]->dev_addr);
> @@ -615,6 +629,18 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>  	if (res)
>  		goto err_unregister;
>  
> +	if (interlink) {
> +		res = hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
> +		if (res)
> +			goto err_unregister;

You need to add the iterlink port to hsr_del_ports() to avoid a leak in
the remove() function.

regards,
dan carpenter

> +
> +		hsr->redbox = true;
> +		ether_addr_copy(hsr->macaddress_redbox, interlink->dev_addr);
> +		timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
> +		mod_timer(&hsr->prune_proxy_timer,
> +			  jiffies + msecs_to_jiffies(PRUNE_PROXY_PERIOD));
> +	}
> +
>  	hsr_debugfs_init(hsr, hsr_dev);
>  	mod_timer(&hsr->prune_timer, jiffies + msecs_to_jiffies(PRUNE_PERIOD));
>  


