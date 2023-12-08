Return-Path: <netdev+bounces-55285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D298A80A1B5
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 12:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCCB281990
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3358D14A89;
	Fri,  8 Dec 2023 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eeWfTSr9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C648123
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 03:01:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-333630e9e43so1944989f8f.2
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 03:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702033297; x=1702638097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRTkY6em9tszViqTo03tWAdVZrKNQ98z8rdht/eh/fo=;
        b=eeWfTSr998a0x7UX69WQqZp4WfvbZr5qyLs02TFdJmsLjOEmjpU6IoT0i+2lZCBAM6
         DvwwJYS3jl5LdktkBzZfeLiN6iyuGzdJh0p3+fo4ExDzZa/MTMCGyGQu89rstxqsM9lf
         2Nf+JjwwufPt6VsQxGBUHcqlKOL76cCU4zIm8AF3Q9TTlRJOGSwWpXrTnZaHxkLoim0/
         LlRBePZVQEB0LkVVxOfmzr1ZuqbzzISqyq1OrMTPIIxaEhiZpMWTZd4xFetfZVrI3fQ7
         EZumlUDImVGhI8ynEQFN5XcNl7UcVKwngRp2h83Sl5eU5FJzBkso4cSrln82yPOig/Il
         QCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033297; x=1702638097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRTkY6em9tszViqTo03tWAdVZrKNQ98z8rdht/eh/fo=;
        b=inhZ+sBcJZ6T/DKtWmKvIkw83hiBd4cjDN1sERlS3O+ZUmOLF82qFl+ybm7oIXnNcO
         I+lRasbkFU23UQI2+f0+w/56Iru7tLxx9sJWq2MN3JgMNr97ETDvs1AngFrhSGvo27Pd
         FZfizDrbRw+KJWdcdl9cmTEStTeyuehlBgMNVUNDf5/raoRfp361rr5iO/fh3v0R7wLG
         HE7ydLpxAIqC7FV2EqxZeAhzJOA8gNDHfEU4OEjqiVNsSWzIRE/WP8gfOZ7xCMt9ZEzt
         OeSaPQGRCNkh425ZaHSElCy6gaQYwWTAeANbRfEscvfIhykF1Yb+sGJEk5NnN5juNFHq
         BvoQ==
X-Gm-Message-State: AOJu0YzqTQOmVn848C8WmKJmyIQgLZANMHdDWQ+snbOrr40BTHOo5EN6
	hAoRZrBpnyz4kY/Hicc9FmQnsg==
X-Google-Smtp-Source: AGHT+IEyEQpZCtgCfWPcd9dh3eiu2fmENBf1fAvgepRWWq0XcSREUkmngsxdXggUFixEkbiq94bJmg==
X-Received: by 2002:adf:fe8e:0:b0:333:41e2:6221 with SMTP id l14-20020adffe8e000000b0033341e26221mr1540001wrr.102.1702033297528;
        Fri, 08 Dec 2023 03:01:37 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s18-20020adfea92000000b0033342d2bf02sm1768588wrm.25.2023.12.08.03.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 03:01:37 -0800 (PST)
Date: Fri, 8 Dec 2023 12:01:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] netdevsim: forward skbs from one connected
Message-ID: <ZXL3kL6EPLNa+c7Z@nanopsycho>
References: <20231207172117.3671183-1-dw@davidwei.uk>
 <20231207172117.3671183-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207172117.3671183-3-dw@davidwei.uk>

Thu, Dec 07, 2023 at 06:21:16PM CET, dw@davidwei.uk wrote:
>Forward skbs sent from one netdevsim port to its connected netdevsim
>port using dev_forward_skb, in a spirit similar to veth.
>
>Signed-off-by: David Wei <dw@davidwei.uk>
>---
> drivers/net/netdevsim/netdev.c | 20 +++++++++++++++-----
> 1 file changed, 15 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>index 1abdcd470f21..698819072c4f 100644
>--- a/drivers/net/netdevsim/netdev.c
>+++ b/drivers/net/netdevsim/netdev.c
>@@ -29,19 +29,30 @@
> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> {
> 	struct netdevsim *ns = netdev_priv(dev);
>+	struct netdevsim *peer_ns;
>+	int ret = NETDEV_TX_OK;
> 
> 	if (!nsim_ipsec_tx(ns, skb))
>-		goto out;
>+		goto err;
> 
> 	u64_stats_update_begin(&ns->syncp);
> 	ns->tx_packets++;
> 	ns->tx_bytes += skb->len;
> 	u64_stats_update_end(&ns->syncp);
> 
>-out:
>-	dev_kfree_skb(skb);
>+	peer_ns = ns->peer;

What is stopping the peer to be removed and freed right now?


>+	if (!peer_ns)
>+		goto err;
>+
>+	skb_tx_timestamp(skb);
>+	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>+		ret = NET_XMIT_DROP;
> 
>-	return NETDEV_TX_OK;
>+	return ret;
>+
>+err:
>+	dev_kfree_skb(skb);
>+	return ret;
> }
> 
> static void nsim_set_rx_mode(struct net_device *dev)
>@@ -302,7 +313,6 @@ static void nsim_setup(struct net_device *dev)
> 	eth_hw_addr_random(dev);
> 
> 	dev->tx_queue_len = 0;
>-	dev->flags |= IFF_NOARP;
> 	dev->flags &= ~IFF_MULTICAST;
> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
> 			   IFF_NO_QUEUE;
>-- 
>2.39.3
>
>

