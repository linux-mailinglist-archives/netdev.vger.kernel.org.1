Return-Path: <netdev+bounces-232020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714D9C00225
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EB83A4BD4
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83452F9C37;
	Thu, 23 Oct 2025 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9ofd49v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5798C2F7453
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210663; cv=none; b=Uq8vM7mvs1lP7fl4IWqJD9WgtmVaSatpz7pfBA7Hqi2RaFwhDR1h56WDgJXpVrTwTYTyqjDSAPNThK9WzNqgQcwAkvl+0MA3lGI98Rxu0PTS4e8OhCJxdIMZS7rPGvAgjYLtXPMuQBE9XBuvWmifL8n/Ewm4IKH7hvoPyeTZVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210663; c=relaxed/simple;
	bh=h7L02NCKhj3xBvdbazThxW/UbNhBWG7mgjHOiZP/uQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ak+Pi3EKJpAOqtTG1XlOg843Rh/i82F4majbuSqvCtgkgL9Q66oYxt6tk9RPi65SxtjWA8I2heX8JefZ3dAyep5jkz9QZ6H0fHZjSOxk1z6/UqSFY1ONFKG07S3vgd6/0EdLNE3whpMbVDCgHNFPhCdH7paCjfvc5T1IszP27pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9ofd49v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761210660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROE/ccH79RMmy4MQqviUfOMK5DGP+wY6fsRipisWpWA=;
	b=V9ofd49vIDuODYvnUquoa+8c2wJHN3ENXVz+GYus08wkXkrFh7MU36BIF9PGA9in0yjXDc
	TRZEMJnH9CHfX9Zd5Uka/2hQYSOXIgNT/Waa9D0lNWXv88YWArSlgFC/4ICLNj0fQZa8V2
	aq8lVE+XXBXussqy12OTLEAOSr5tSQI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-bYRmVsgPO--_HQUgItSbrg-1; Thu, 23 Oct 2025 05:10:58 -0400
X-MC-Unique: bYRmVsgPO--_HQUgItSbrg-1
X-Mimecast-MFC-AGG-ID: bYRmVsgPO--_HQUgItSbrg_1761210657
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4256fae4b46so331243f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 02:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210657; x=1761815457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROE/ccH79RMmy4MQqviUfOMK5DGP+wY6fsRipisWpWA=;
        b=u3QMh6R/GQyvzSh7bVlyHlgvHuKVJVXjwXcKOLzuuLh8aNyy3BkL2oehMb7Pge43AH
         6k/LOMjdqlEXmhUrvxjub9tBovyu5nfOXBmNxnGl3tsMoCg0ar0JBBoWf7ZNAY6irdbr
         pdlCKWGr/AaHcCP5l6ahm+rmeKFW06tO1JzhEHDCMgnasWujzUEOWHQDN4KoJ18e1t75
         fW+bzHKVT4qWuCLaCwG3xutkTKNwJPlVM0FGJK3KboLzRGrzn/R+8hDp+zg1WbCbczZf
         zKCvUxRKhERuv2RF9PcBR6gxG6sS4JGcwrmsEtlgLtPbJYk4lKrhSv12om1JTJ2sgzd4
         tSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXan5hreYNrEUNXJSPghv9VF+s7taklt6wamZU58xITqoNbl39C88h1DDttEuEpwJOotbrz5eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/y191ZtbsH4oCLN51Xk5Ng8aPPLBI30vv2QiXODKIf7MgWv1
	8Uu6/nPug8rzw6A49kxR09KZ3tTd4cIKleVrQl80DD64y8rjQuWPsAcM6xoE3kcpFWae87+bOdx
	ZbchdPXAPApEUY1Y+9YKpN80bpj5D6DFXGUL71RD0A0AdqaHCIOFIp7pC+Q==
X-Gm-Gg: ASbGncvxhgUFciIYZ6LvrCElc/kfWwoZ3ZrdRr7gX4GahGfr5Fe/e0LsRUwo09C0D1R
	WOWctVo4YVf/X1MJYGFstSSbNL9VNk9pnyvkm2ydCPuqJNNbnh2ruVZD2T9hS2k9kUa9alkbplG
	B/52hyg5mB5sss42mhq1BoQdY1J6rL3m9myiFb45cHvauRBZUF0HVdCBQ597+/onlhHTjYPZQXA
	HJCFHjtl9cYMN40MG+vkAQNdC9dMdyw96v4zL+X6EgspTOqN9btMxyLEJ8poFopfxWOsq1HJY6v
	MEfJ7DXAXKsVfqBYnwFc4QXw3ZarEedjVEo22afbrGl57FZSMa8xEYPQHo4qaToFIB5oD/E8cdY
	fNGVlIUTj59qP5AJ90pE4us7El8N2AoRL8NbLM+KvbPLbB1w=
X-Received: by 2002:a05:6000:200f:b0:428:3e7f:88c3 with SMTP id ffacd0b85a97d-4283e7f8a82mr11983219f8f.50.1761210657368;
        Thu, 23 Oct 2025 02:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCfEx1b9tKlEZ2dKO/EQyajgSPLCPbsTOSl19bbcoR7pcI8e+0g2WjWPf6x42kquZpa9VKBw==
X-Received: by 2002:a05:6000:200f:b0:428:3e7f:88c3 with SMTP id ffacd0b85a97d-4283e7f8a82mr11983193f8f.50.1761210656910;
        Thu, 23 Oct 2025 02:10:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898eb609sm2920718f8f.40.2025.10.23.02.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 02:10:56 -0700 (PDT)
Message-ID: <ee3d9a4d-641b-413d-997b-3ce37aeb9279@redhat.com>
Date: Thu, 23 Oct 2025 11:10:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/5] ethtool: netlink: add ETHTOOL_MSG_MSE_GET
 and wire up PHY MSE access
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Kory Maincent <kory.maincent@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Nishanth Menon <nm@ti.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
 Roan van Dijk <roan@protonic.nl>
References: <20251020103147.2626645-1-o.rempel@pengutronix.de>
 <20251020103147.2626645-3-o.rempel@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020103147.2626645-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 12:31 PM, Oleksij Rempel wrote:
> diff --git a/net/ethtool/mse.c b/net/ethtool/mse.c
> new file mode 100644
> index 000000000000..89365bdb1109
> --- /dev/null
> +++ b/net/ethtool/mse.c
> @@ -0,0 +1,411 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/ethtool.h>
> +#include <linux/phy.h>
> +#include <linux/slab.h>
> +
> +#include "netlink.h"
> +#include "common.h"
> +#include "bitset.h"
> +
> +#define PHY_MSE_CHANNEL_COUNT 4
> +
> +struct mse_req_info {
> +	struct ethnl_req_info base;
> +};
> +
> +struct mse_snapshot_entry {
> +	struct phy_mse_snapshot snapshot;
> +	int channel;
> +};
> +
> +struct mse_reply_data {
> +	struct ethnl_reply_data base;
> +	struct phy_mse_capability capability;
> +	struct mse_snapshot_entry *snapshots;
> +	unsigned int num_snapshots;
> +};
> +
> +static inline struct mse_reply_data *
> +mse_repdata(const struct ethnl_reply_data *reply_base)

Please don't use inline in 'c' files, either move to an header or drop
the 'inline' keyword. A few more occurences below.

> +static int mse_get_one_channel(struct phy_device *phydev,
> +			       struct mse_reply_data *data, int channel)
> +{
> +	u32 cap_bit = 0;
> +	int ret;
> +
> +	switch (channel) {
> +	case PHY_MSE_CHANNEL_A:
> +		cap_bit = PHY_MSE_CAP_CHANNEL_A;
> +		break;
> +	case PHY_MSE_CHANNEL_B:
> +		cap_bit = PHY_MSE_CAP_CHANNEL_B;
> +		break;
> +	case PHY_MSE_CHANNEL_C:
> +		cap_bit = PHY_MSE_CAP_CHANNEL_C;
> +		break;
> +	case PHY_MSE_CHANNEL_D:
> +		cap_bit = PHY_MSE_CAP_CHANNEL_D;
> +		break;
> +	case PHY_MSE_CHANNEL_WORST:
> +		cap_bit = PHY_MSE_CAP_WORST_CHANNEL;
> +		break;
> +	case PHY_MSE_CHANNEL_LINK:
> +		cap_bit = PHY_MSE_CAP_LINK;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (!(data->capability.supported_caps & cap_bit))
> +		return -EOPNOTSUPP;
> +
> +	data->snapshots = kzalloc(sizeof(*data->snapshots), GFP_KERNEL);
> +	if (!data->snapshots)
> +		return -ENOMEM;
> +
> +	ret = phydev->drv->get_mse_snapshot(phydev, channel,
> +					    &data->snapshots[0].snapshot);
> +	if (ret)
> +		return ret;
> +
> +	data->snapshots[0].channel = channel;

Minor nit: it looks like you could de-dup some code above reusing the
get_snapshot_if_supported() helper. I see the code could end-up
allocating the structure just to free it in case of unsupported channel,
but I think it still would be better.

[...]> +static int mse_fill_reply(struct sk_buff *skb,
> +			  const struct ethnl_req_info *req_base,
> +			  const struct ethnl_reply_data *reply_base)
> +{
> +	const struct mse_reply_data *data = mse_repdata(reply_base);
> +	struct nlattr *cap_nest, *snap_nest;
> +	unsigned int i;
> +	int ret;
> +
> +	cap_nest = nla_nest_start(skb, ETHTOOL_A_MSE_CAPABILITIES);
> +	if (!cap_nest)
> +		return -EMSGSIZE;
> +
> +	if (data->capability.supported_caps & PHY_MSE_CAP_AVG) {
> +		ret = nla_put_uint(skb,
> +				   ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE,
> +				   data->capability.max_average_mse);
> +		if (ret < 0)
> +			goto nla_put_cap_failure;
> +	}
> +
> +	if (data->capability.supported_caps & (PHY_MSE_CAP_PEAK |
> +					       PHY_MSE_CAP_WORST_PEAK)) {
> +		ret = nla_put_uint(skb, ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE,
> +				   data->capability.max_peak_mse);
> +		if (ret < 0)
> +			goto nla_put_cap_failure;
> +	}
> +
> +	ret = nla_put_uint(skb, ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS,
> +			   data->capability.refresh_rate_ps);
> +	if (ret < 0)
> +		goto nla_put_cap_failure;
> +
> +	ret = nla_put_uint(skb, ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS,
> +			   data->capability.num_symbols);
> +	if (ret < 0)
> +		goto nla_put_cap_failure;
> +
> +	ret = mse_caps_put(skb, ETHTOOL_A_MSE_CAPABILITIES_SUPPORTED_CAPS,
> +			   data->capability.supported_caps,
> +			   req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS);
> +	if (ret < 0)
> +		goto nla_put_cap_failure;
> +
> +	nla_nest_end(skb, cap_nest);
> +
> +	for (i = 0; i < data->num_snapshots; i++) {
> +		const struct mse_snapshot_entry *s = &data->snapshots[i];
> +		int chan_attr;
> +
> +		switch (s->channel) {
> +		case PHY_MSE_CHANNEL_A:
> +			chan_attr = ETHTOOL_A_MSE_CHANNEL_A;
> +			break;
> +		case PHY_MSE_CHANNEL_B:
> +			chan_attr = ETHTOOL_A_MSE_CHANNEL_B;
> +			break;
> +		case PHY_MSE_CHANNEL_C:
> +			chan_attr = ETHTOOL_A_MSE_CHANNEL_C;
> +			break;
> +		case PHY_MSE_CHANNEL_D:
> +			chan_attr = ETHTOOL_A_MSE_CHANNEL_D;
> +			break;
> +		case PHY_MSE_CHANNEL_WORST:
> +			chan_attr = ETHTOOL_A_MSE_WORST_CHANNEL;
> +			break;
> +		case PHY_MSE_CHANNEL_LINK:
> +			chan_attr = ETHTOOL_A_MSE_LINK;
> +			break;
> +		default:
> +			return -EINVAL;

It looks like the same largish switch is present in
mse_get_one_channel(), I think it would be better to factor it out in a
common helper.

> +		}
> +
> +		snap_nest = nla_nest_start(skb, chan_attr);
> +		if (!snap_nest)
> +			return -EMSGSIZE;
> +
> +		if (data->capability.supported_caps & PHY_MSE_CAP_AVG) {
> +			ret = nla_put_uint(skb,
> +					   ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE,
> +					   s->snapshot.average_mse);
> +			if (ret)
> +				goto nla_put_snap_failure;
> +		}
> +		if (data->capability.supported_caps & PHY_MSE_CAP_PEAK) {
> +			ret = nla_put_uint(skb, ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE,
> +					   s->snapshot.peak_mse);
> +			if (ret)
> +				goto nla_put_snap_failure;
> +		}
> +		if (data->capability.supported_caps & PHY_MSE_CAP_WORST_PEAK) {
> +			ret = nla_put_uint(skb,
> +					   ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE,
> +					   s->snapshot.worst_peak_mse);
> +			if (ret)
> +				goto nla_put_snap_failure;
> +		}
> +
> +		nla_nest_end(skb, snap_nest);
> +	}
> +
> +	return 0;
> +
> +nla_put_cap_failure:
> +	nla_nest_cancel(skb, cap_nest);
> +	return ret;
> +
> +nla_put_snap_failure:
> +	nla_nest_cancel(skb, snap_nest);
> +	return -EMSGSIZE;

Minor: possibly return 'ret' instead? Also you could possibly
consolidate the 2 error path using a single nest variable.

/P


