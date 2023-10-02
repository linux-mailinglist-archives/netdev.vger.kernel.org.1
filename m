Return-Path: <netdev+bounces-37382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E977B52C4
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 89F8CB20A82
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2090315EBC;
	Mon,  2 Oct 2023 12:13:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948DC10A0E
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:13:28 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ECA2712
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 05:11:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3215f19a13aso16366402f8f.3
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696248707; x=1696853507; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L5LdkWS0biIIZvELj2EpRuPnpaaDaxnemHE3/PgKWBM=;
        b=fnhfXZF3Cx357hbaIwJ48dOaZr8STuFEBTvTJGNL7bQ2alqkGRd7fN+ABc4G1xMltc
         QkLTrUYuTkJ9dnPYdtul99+8HGb5VAzNwQUej0d3cwgYSyR/CK7qCNkb8FBBVVj0mC1V
         EshkfH3045usvitGQDGU/dzhluYNBFEcMy/WTeRI4XAqPBRkyvCAP3w0NeqtQ6zQMX9t
         JkfKMWyq8nKExSJYwAfQCYnYCaEILdDBj839fROUwhH65EKhK7ZWkIE1CZ4nNaguutiN
         AeRpwSm8Aitc9ZR3MBgmkHRyCUdfbOaVD5MsMC9ZODSFgV/530SF6hJQ6GbrpS021EiS
         BSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696248707; x=1696853507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5LdkWS0biIIZvELj2EpRuPnpaaDaxnemHE3/PgKWBM=;
        b=k/ZLjnv2XiXpqPq46Yx8EjjSVxoYxfx+NEJ9FcC1B7F957jpYmzIgWWKdzvTJs1Owy
         NUECE8NjJIPuOwKhrys9fdZtmdNkm3zBtf+0Y+Bce0lXAd+74z+1q0oEng3twgCb/iPw
         30nvGeKVkpqK+iga2oARPGTuiHnyqIyx70yofGM+Jx4TpLRF1rwKZTVm4+Tw+4a8+eIP
         g9Fo2gvpAWqsPA5rC2GRvdF3PohUdl6kADaBe4+HUZlgTrC0vpsXpn0dC0z2BLzbGCz/
         Q9XFcpkTu3TZgAb+E0KMYZKsEwmgimIxkK9zxYdEzyz1QdJAPd6c4W5qwYKmnzbsto1H
         8VHA==
X-Gm-Message-State: AOJu0YyEaO4qBf/Rjgg/m99cbCxlZImqSHo0BbmIxVUkFRdXzYSAxAmt
	yx3QtySKyHOG62zLAmcpBcl8k//QTqY=
X-Google-Smtp-Source: AGHT+IGQy10hgw71Q836S7WNS1QP33zHBDM3xe5wiZDGRMiVp5zkUrtMTZ40MJ47576tW4lOysEcCQ==
X-Received: by 2002:a5d:6401:0:b0:320:938:300e with SMTP id z1-20020a5d6401000000b003200938300emr9204405wru.4.1696248707216;
        Mon, 02 Oct 2023 05:11:47 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id g16-20020adfa490000000b003232380ffd5sm20035808wrb.106.2023.10.02.05.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:11:46 -0700 (PDT)
Message-ID: <651ab382.df0a0220.e74df.fc51@mx.google.com>
X-Google-Original-Message-ID: <ZRqzf3VVMjq1ZFAG@Ansuel-xps.>
Date: Mon, 2 Oct 2023 14:11:43 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: qca8k: fix potential MDIO bus conflict
 when accessing internal PHYs via management frames
References: <20231002104612.21898-1-kabel@kernel.org>
 <20231002104612.21898-3-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002104612.21898-3-kabel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 12:46:12PM +0200, Marek Behún wrote:
> Besides the QCA8337 switch the Turris 1.x device has on it's MDIO bus
> also Micron ethernet PHY (dedicated to the WAN port).
> 
> We've been experiencing a strange behavior of the WAN ethernet
> interface, wherein the WAN PHY started timing out the MDIO accesses, for
> example when the interface was brought down and then back up.
> 
> Bisecting led to commit 2cd548566384 ("net: dsa: qca8k: add support for
> phy read/write with mgmt Ethernet"), which added support to access the
> QCA8337 switch's internal PHYs via management ethernet frames.
> 
> Connecting the MDIO bus pins onto an oscilloscope, I was able to see
> that the MDIO bus was active whenever a request to read/write an
> internal PHY register was done via an management ethernet frame.
> 
> My theory is that when the switch core always communicates with the
> internal PHYs via the MDIO bus, even when externally we request the
> access via ethernet. This MDIO bus is the same one via which the switch
> and internal PHYs are accessible to the board, and the board may have
> other devices connected on this bus. An ASCII illustration may give more
> insight:
> 
>            +---------+
>       +----|         |
>       |    | WAN PHY |
>       | +--|         |
>       | |  +---------+
>       | |
>       | |  +----------------------------------+
>       | |  | QCA8337                          |
> MDC   | |  |                        +-------+ |
> ------o-+--|--------o------------o--|       | |
> MDIO    |  |        |            |  | PHY 1 |-|--to RJ45
> --------o--|---o----+---------o--+--|       | |
>            |   |    |         |  |  +-------+ |
> 	   | +-------------+  |  o--|       | |
> 	   | | MDIO MDC    |  |  |  | PHY 2 |-|--to RJ45
> eth1	   | |             |  o--+--|       | |
> -----------|-|port0        |  |  |  +-------+ |
>            | |             |  |  o--|       | |
> 	   | | switch core |  |  |  | PHY 3 |-|--to RJ45
>            | +-------------+  o--+--|       | |
> 	   |                  |  |  +-------+ |
> 	   |                  |  o--|  ...  | |
> 	   +----------------------------------+
> 
> When we send a request to read an internal PHY register via an ethernet
> management frame via eth1, the switch core receives the ethernet frame
> on port 0 and then communicates with the internal PHY via MDIO. At this
> time, other potential devices, such as the WAN PHY on Turris 1.x, cannot
> use the MDIO bus, since it may cause a bus conflict.
> 
> Fix this issue by locking the MDIO bus even when we are accessing the
> PHY registers via ethernet management frames.
> 
> Fixes: 2cd548566384 ("net: dsa: qca8k: add support for phy read/write with mgmt Ethernet")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Just some comments (micro-optimization) and one question.

Wonder if the extra lock would result in a bit of overhead for simple
implementation where the switch is the only thing connected to the MDIO.

It's just an idea and probably not even something to consider (since
probably the overhead is so little that it's not worth it)

But we might consider to add some logic in the MDIO setup function to
check if the MDIO have other PHY connected and enable this lock (and
make this optional with an if and a bool like require_mdio_locking)

If we don't account for this, yes the lock should have been there from
the start and this is correct. (we can make it optional only in the case
where only the switch is connected as it would be the only user and
everything is already locked by the eth_mgmt lock)

> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index d2df30640269..4ce68e655a63 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -666,6 +666,15 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
>  		goto err_read_skb;
>  	}
>  
> +	/* It seems that accessing the switch's internal PHYs via management
> +	 * packets still uses the MDIO bus within the switch internally, and
> +	 * these accesses can conflict with external MDIO accesses to other
> +	 * devices on the MDIO bus.
> +	 * We therefore need to lock the MDIO bus onto which the switch is
> +	 * connected.
> +	 */
> +	mutex_lock(&priv->bus->mdio_lock);
> +

Please move this down before the first dev_queue_xmit. (we can save a
few cycle where locking is not needed)

Also should we use mutex_lock_nested?

>  	/* Actually start the request:
>  	 * 1. Send mdio master packet
>  	 * 2. Busy Wait for mdio master command
> @@ -678,6 +687,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
>  	mgmt_master = priv->mgmt_master;
>  	if (!mgmt_master) {
>  		mutex_unlock(&mgmt_eth_data->mutex);
> +		mutex_unlock(&priv->bus->mdio_lock);
>  		ret = -EINVAL;
>  		goto err_mgmt_master;
>  	}
> @@ -765,6 +775,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
>  				    QCA8K_ETHERNET_TIMEOUT);
>  
>  	mutex_unlock(&mgmt_eth_data->mutex);
> +	mutex_unlock(&priv->bus->mdio_lock);
>  
>  	return ret;
>  
> -- 
> 2.41.0
> 

-- 
	Ansuel

