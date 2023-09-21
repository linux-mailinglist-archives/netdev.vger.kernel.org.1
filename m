Return-Path: <netdev+bounces-35587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F187A9D62
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80ADB2826DB
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1018036;
	Thu, 21 Sep 2023 19:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38FC121
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:32:47 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4431EA5EF;
	Thu, 21 Sep 2023 12:32:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-532c3b4b55eso1589240a12.0;
        Thu, 21 Sep 2023 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695324748; x=1695929548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMH7PzSWp067dWiOIVcukRVxS+yuwr0XHpd8PRZA1eY=;
        b=DrGcmFYBh4mqwecXAUrqpBEW0qxvQ/9w+D/UPM0vX7y8Zlvq6N8DZrlAmB56kFffJk
         u5Cxa4vXKQOGj1yVYusoEwRb3QZ/z0SqiEpmFfqwepTSsQaMhz2QsmDpA+TD+8yQZcWq
         a3ZS82xWFfxXOYlXs5hR4gN9ck4Pm/iqzRBU/1mREom1NPw6q8H7rYiBAtd4TbtXOWt5
         CZNxhsRnobU0pp8B249GJ1Hz7kDBgp48GiDb7dhd943q2n2Jc3K7E4ijJ+RtrlGBnU47
         TFFpwziOrmAOx/YAjFxvOaX6ToeMEfqH43kYNnMW17iNTHFI2lg6ys4OqknUaBxIkXp4
         LBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324748; x=1695929548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMH7PzSWp067dWiOIVcukRVxS+yuwr0XHpd8PRZA1eY=;
        b=XUj+o134A78aObRzhKC0KzxU3ksBHkOVHvkCRmXHGAwms0TzzVDepL1ouGZMj45eEZ
         eVoILpVhwtR6268TCYtVx+F2AsabusQcxrZUrwzddJydrAbQKFs0LO7ehYXCiD7YmNme
         3qxq9iIES9Y+OYBwH3CQ5kZ5UBY0hTScsmxe0QbHQZKqtxNRoEzDvk9vjYkaKMFG5Nla
         B1+IG5MUUThPTlzigPk2tlaHnYvf0CjC+IDtBZWUTRL/ZNI7DfcZtv3GMs3/OkTlLcOA
         ylAruOQCoQzYdGl3AITx3MFUQMOMZHFQgghITFXc6nDzGnkDXUjC3m8JVgEtweLJGDY+
         dHXg==
X-Gm-Message-State: AOJu0YwH+cywups3KWMMXbSozYTIbrZBxeqC09chMR/e6OVRjMzOoj3n
	pYkkS5K4UOmlIjcWZyX4Gs8=
X-Google-Smtp-Source: AGHT+IFaJjMwxqUspqdGpDF4+anZwF2MRDqKbVbExauR1ACuPIrZ8rxk8EEzQhBvjBJkf/3BeyooDA==
X-Received: by 2002:aa7:d792:0:b0:532:b974:671e with SMTP id s18-20020aa7d792000000b00532b974671emr5718460edq.41.1695324747878;
        Thu, 21 Sep 2023 12:32:27 -0700 (PDT)
Received: from skbuf ([188.25.255.147])
        by smtp.gmail.com with ESMTPSA id f15-20020a50ee8f000000b0052a19a75372sm1213490edr.90.2023.09.21.12.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:32:27 -0700 (PDT)
Date: Thu, 21 Sep 2023 22:32:24 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
	Woojung Huh <woojung.huh@microchip.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v5 net-next 5/5] net: dsa: microchip: Enable HSR
 offloading for KSZ9477
Message-ID: <20230921193224.l3ojpdcsb4bpfl7d@skbuf>
References: <20230920114343.1979843-1-lukma@denx.de>
 <20230920114343.1979843-1-lukma@denx.de>
 <20230920114343.1979843-6-lukma@denx.de>
 <20230920114343.1979843-6-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920114343.1979843-6-lukma@denx.de>
 <20230920114343.1979843-6-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 01:43:43PM +0200, Lukasz Majewski wrote:
> +void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	struct net_device *slave;
> +	u8 data;
> +
> +	/* Program which port(s) shall support HSR */
> +	ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));
> +
> +	/* Forward frames between HSR ports (i.e. bridge together HSR ports) */
> +	ksz9477_cfg_port_member(dev, port,
> +				BIT(dsa_upstream_port(ds, port)) | BIT(port));

Isn't this supposed to be

	ksz9477_cfg_port_member(dev, port,
				BIT(dsa_upstream_port(ds, port)) | BIT(pair));

where "pair" is not even passed as an argument to ksz9477_hsr_join(),
but represents the *other* port in the HSR ring, not this one?

> +
> +	if (!dev->hsr_ports) {
> +		/* Enable discarding of received HSR frames */
> +		ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
> +		data |= HSR_DUPLICATE_DISCARD;
> +		data &= ~HSR_NODE_UNICAST;
> +		ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
> +	}
> +
> +	/* Enable per port self-address filtering.
> +	 * The global self-address filtering has already been enabled in the
> +	 * ksz9477_reset_switch() function.
> +	 */
> +	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, true);
> +
> +	/* Setup HW supported features for lan HSR ports */
> +	slave = dsa_to_port(ds, port)->slave;
> +	slave->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
> +}
> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index 1f3fb6c23f36..1f447a34f555 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -101,6 +101,11 @@ struct ksz_ptp_irq {
>  	int num;
>  };
>  
> +struct ksz_switch_macaddr {
> +	unsigned char addr[ETH_ALEN];
> +	refcount_t refcount;
> +};
> +
>  struct ksz_port {
>  	bool remove_tag;		/* Remove Tag flag set, for ksz8795 only */
>  	bool learning;
> @@ -169,6 +174,10 @@ struct ksz_device {
>  	struct mutex lock_irq;		/* IRQ Access */
>  	struct ksz_irq girq;
>  	struct ksz_ptp_data ptp_data;
> +
> +	struct ksz_switch_macaddr *switch_macaddr;
> +	struct net_device *hsr_dev;     /* HSR */

Please be consistent with the lines above, and use tabs to align the "/* HSR */"
comment.

> +	u8 hsr_ports;
>  };
>  
>  /* List of supported models */
> -- 
> 2.20.1
> 


