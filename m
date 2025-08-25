Return-Path: <netdev+bounces-216679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF62B34ED6
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF7C1A86F0E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36132857C4;
	Mon, 25 Aug 2025 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXZu5YHD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B34C2367D3;
	Mon, 25 Aug 2025 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160114; cv=none; b=YCYFfMIoqVlTlwuxhOsUhLK5p/pR6yKqcIAqzZKZxSCYQ5mvpRWrX4yt0Ou3JTciKvI7GGRMCgX1iuDjZc1kFKJCU/DrE8jN0sBBbd9QdI6O5fvstvZLXsIseVTP1RNG+CpZpZErNXKv7BiIx7uFrEtHgmXB8qvvIvQohttQeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160114; c=relaxed/simple;
	bh=Rad/e4PTXYhlh7Ut55TnjCljnSCA8wdD9wjlA1P2gZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBZWveTuMtkt9Y2SwuQL/cuvLhiSC/xBd9ncfChgt0FVPfcMrzgEMIVLdmrWDeTlqjvAJxujlCjnwh2wmOYBC+dfhOt027/Pl6plqC9IYjZGS67j0tZIVEaKR4lHG8z2F6bBj7786SN/wRQKW2qwdV8tJXH9qjDkmgPlzR5wB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXZu5YHD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c46cde065so162673a12.3;
        Mon, 25 Aug 2025 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756160111; x=1756764911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHjrPuViBQcpN4HU6hGSA4Is0cF4NqRAnNfkTvcfEB8=;
        b=XXZu5YHDvT2jM5ys9HgNxD4t8bTzSCYtXMln/FxvhIg/jiVe7cFdE1KyDMTKHGon5x
         zArOfXkAmt2Jnp7D9ampk1jM6LQp6+iFCfeMUIZU/ieXMFbuzpDWMlFcwI/jfwHeOg7j
         uB7hYyJKVZuW+qx0blOhdW3IG6D9iBKAEZd97QU/3kMz+3fIX28m1ibOzqLBXa72u3W5
         dcQW9Hh463xAfwb/zOIDfMui9jFKGB8s+1cxMNPHkjj5u3lN60XWKyWr0yz6tiykkZLx
         D7f/jJHjwI/Ff2TflR/boi/HFACoJUk0rofaonJQ792O0M38gUWzMnAEtFN7cte3zYRU
         OwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756160111; x=1756764911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHjrPuViBQcpN4HU6hGSA4Is0cF4NqRAnNfkTvcfEB8=;
        b=tkTpoqte4xTohPEKJtMA9oLIPhPMZBkr+xJxAd/NeQJFlsKXAViyQh66rCcPDAkKbq
         yi5IK9XOmpxIDVowrbz2MhdJv9AWIdnbSSaOj8y8GRGMi0E87vcpUfXHdCIijl5GPjVS
         kEK+f5LEcyA0nmjZZ18CT8YGXP97IihiKg3vVXZjTIpCjpXdS8pRr++uLtJjfm/5LMPV
         iql/TiLmNwOJbPbApegVnl/tkcwafzZ6Kf6UB68lfTjTr5AaDZa3FTj3UAIV4s+maly9
         KS7qqsAIc/k9RoPU/etOhJ3up46bl7HV5atLJ02y4NUY+ShmFgci9YPeLlqeLKjFadUe
         RazA==
X-Forwarded-Encrypted: i=1; AJvYcCUwTxrgPVAp15PVsNSg3N+vGUOcGoTOmG7LrxWtS7VnzOElgI2xP5lKatl/COmNwXAwU7EB/ODZ5Izh@vger.kernel.org, AJvYcCXMDHcf3Nrqh2F/Qo3OSk10TyGMHYX0bNgNLQ1VUqlS3St3TYJNPeBi8SvntHtTajxRGxT4bnR8TYVqedVF@vger.kernel.org
X-Gm-Message-State: AOJu0YyvrQFoRUqMPTw/umO8oAJ5DZZ25H7n571OUyxI8bkrVrxz2mcR
	iUIt7mPXmNpHK6Ehc8hhDLSPP2iIp0XnWX2cP3N5p2ks+OoZ18Uz33PmYS+dLQ==
X-Gm-Gg: ASbGncuUxCMp65wvEwA4+Hkc+G5aoYpPdxT1jdGIHFqIbE+itqg91MJSIoHgGDhrzd6
	+lzG3JULh7mk53NByvXawZraR6J61WoOOm05gKUpV0E7Sf+tp/1YG8A6/mUtdeduWtCDjDrDx/E
	g8/vkN5rmw71JsF1ngSwNAALvvUwLpgtTZ9NfSjqyQrtwRzdH8yGf8QyIjLuG0IIFGsKnC4S9Ad
	cttXZi6YhTYFT8sT6fmHHyGuxn/NaFIeJC7WaBn/V4hAk1DSlrGppdIecGSCz/8KHOPVAYTuchK
	NNIZqtaEuMGT9jj80UpAj4VJuWb1ThaSKzQThXhbTAGIzVgVkrnCoAKXjjp9/gfxHbusR2L4kiD
	yT1fvr0JMSWtnjw==
X-Google-Smtp-Source: AGHT+IHz/xfKlWbUIj2RNYnioKcPI4iArSQh2BAnpUiuCcjYVLEPcdNFJbKbCCViC/0lGU4ez24gzA==
X-Received: by 2002:a17:907:c28:b0:ae3:c5b3:37fa with SMTP id a640c23a62f3a-afe28ec7f4emr555859066b.1.1756160110745;
        Mon, 25 Aug 2025 15:15:10 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:63b:fbf0:5e17:81ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48e863d5sm635164866b.18.2025.08.25.15.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:15:10 -0700 (PDT)
Date: Tue, 26 Aug 2025 01:15:07 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/3] net: dsa: tag_yt921x: add support for
 Motorcomm YT921x tags
Message-ID: <20250825221507.vfvnuaxs7hh2jy7d@skbuf>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-3-mmyangfl@gmail.com>
 <20250824005116.2434998-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824005116.2434998-3-mmyangfl@gmail.com>
 <20250824005116.2434998-3-mmyangfl@gmail.com>

On Sun, Aug 24, 2025 at 08:51:10AM +0800, David Yang wrote:
> diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> index 555c07cfeb71..4b011a1d5c87 100644
> --- a/net/dsa/Makefile
> +++ b/net/dsa/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
>  obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
>  obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
>  obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
> +obj-$(CONFIG_NET_DSA_TAG_YT921X) += tag_yt921x.o
>  
>  # for tracing framework to find trace.h
>  CFLAGS_trace.o := -I$(src)
> diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
> new file mode 100644
> index 000000000000..ab7f97367e76
> --- /dev/null
> +++ b/net/dsa/tag_yt921x.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Motorcomm YT921x Switch Extended CPU Port Tagging
> + *
> + * Copyright (c) 2025 David Yang <mmyangfl@gmail.com>
> + *
> + * +----+----+-------+-----+----+---------
> + * | DA | SA | TagET | Tag | ET | Payload ...
> + * +----+----+-------+-----+----+---------
> + *   6    6      2      6    2       N
> + *
> + * Tag Ethertype: CPU_TAG_TPID_TPID (default: 0x9988)
> + * Tag:
> + *   2: Service VLAN Tag
> + *   2: Rx Port
> + *     15b: Rx Port Valid
> + *     14b-11b: Rx Port
> + *     10b-0b: Unknown value 0x80
> + *   2: Tx Port(s)
> + *     15b: Tx Port(s) Valid
> + *     10b-0b: Tx Port(s) Mask
> + */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>

Why include list.h and slab.h?

> +
> +#include "tag.h"
> +
> +#define YT921X_NAME	"yt921x"
> +
> +#define YT921X_TAG_LEN	8
> +
> +#define ETH_P_YT921X	0x9988

You can add a header in include/linux/dsa/ which is shared with the
switch driver, to avoid duplicate definitions.

> +
> +#define YT921X_TAG_PORT_EN		BIT(15)
> +#define YT921X_TAG_RX_PORT_M		GENMASK(14, 11)
> +#define YT921X_TAG_RX_CMD_M		GENMASK(10, 0)
> +#define  YT921X_TAG_RX_CMD(x)			FIELD_PREP(YT921X_TAG_RX_CMD_M, (x))
> +#define   YT921X_TAG_RX_CMD_UNK_NORMAL			0x80
> +#define YT921X_TAG_TX_PORTS_M		GENMASK(10, 0)
> +#define  YT921X_TAG_TX_PORTn(port)		BIT(port)
> +
> +static struct sk_buff *
> +yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(netdev);
> +	unsigned int port = dp->index;
> +	__be16 *tag;
> +	u16 tx;
> +
> +	skb_push(skb, YT921X_TAG_LEN);
> +	dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
> +
> +	tag = dsa_etype_header_pos_tx(skb);
> +
> +	/* We might use yt921x_priv::tag_eth_p, but
> +	 * 1. CPU_TAG_TPID could be configured anyway;
> +	 * 2. Are you using the right chip?

The tag format sort of becomes fixed ABI as soon as user space is able
to run "cat /sys/class/net/eth0/dsa/tagging", see "yt921x", and record
it to a pcap file. Unless the EtherType bears some other meaning rather
than being a fixed value, then if you change it later to some other
value than 0x9988, you'd better also change the protocol name to
distinguish it from "yt921x".

Also, you can _not_ use yt921x_priv :: tag_eth_p, because doing so would
assume that typeof(ds->priv) == struct yt921x_priv. In principle we
would like to be able to run the tagging protocols on the dsa_loop
driver as well, which can be attached to any network interface. Very
few, if any, tagging protocol drivers don't work on dsa_loop.

> +	 */
> +	tag[0] = htons(ETH_P_YT921X);
> +	/* Service VLAN tag not used */
> +	tag[1] = 0;
> +	tag[2] = 0;
> +	tx = YT921X_TAG_PORT_EN | YT921X_TAG_TX_PORTn(port);
> +	tag[3] = htons(tx);
> +
> +	/* Now tell the conduit network device about the desired output queue
> +	 * as well
> +	 */
> +	skb_set_queue_mapping(skb, port);

This is generally used for integrated DSA switches, for lossless
backpressure during CPU transmission, where the conduit interface driver
is known, and has set up its queues in a special way, as a result of the
fact that it is attached to a known DSA switch (made by the same vendor).
What do you need it for, in a discrete MDIO-controlled switch?

> +
> +	return skb;
> +}
> +
> +static struct sk_buff *
> +yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	unsigned int port;
> +	__be16 *tag;
> +	u16 rx;
> +
> +	if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
> +		return NULL;
> +
> +	tag = (__be16 *)skb->data;

Use dsa_etype_header_pos_rx() and validate the CPU_TAG_TPID_TPID as well.

> +
> +	/* Locate which port this is coming from */
> +	rx = ntohs(tag[1]);
> +	if (unlikely((rx & YT921X_TAG_PORT_EN) == 0)) {
> +		dev_warn_ratelimited(&netdev->dev,
> +				     "Unexpected rx tag 0x%04x\n", rx);
> +		return NULL;
> +	}
> +
> +	port = FIELD_GET(YT921X_TAG_RX_PORT_M, rx);
> +	skb->dev = dsa_conduit_find_user(netdev, 0, port);
> +	if (unlikely(!skb->dev)) {
> +		dev_warn_ratelimited(&netdev->dev,
> +				     "Couldn't decode source port %u\n", port);
> +		return NULL;
> +	}
> +
> +	/* Remove YT921x tag and update checksum */
> +	skb_pull_rcsum(skb, YT921X_TAG_LEN);
> +
> +	dsa_default_offload_fwd_mark(skb);
> +
> +	dsa_strip_etype_header(skb, YT921X_TAG_LEN);
> +
> +	return skb;
> +}
> +
> +static const struct dsa_device_ops yt921x_netdev_ops = {
> +	.name	= YT921X_NAME,
> +	.proto	= DSA_TAG_PROTO_YT921X,
> +	.xmit	= yt921x_tag_xmit,
> +	.rcv	= yt921x_tag_rcv,
> +	.needed_headroom = YT921X_TAG_LEN,
> +};
> +
> +MODULE_DESCRIPTION("DSA tag driver for Motorcomm YT921x switches");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_YT921X, YT921X_NAME);
> +
> +module_dsa_tag_driver(yt921x_netdev_ops);
> -- 
> 2.50.1
> 


