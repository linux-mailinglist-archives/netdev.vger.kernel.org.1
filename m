Return-Path: <netdev+bounces-113585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7F93F2AB
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F27F282547
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 10:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD00144307;
	Mon, 29 Jul 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XwFVssKS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F54144304
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248967; cv=none; b=WTP8ZFmWI3D/nyojCtAibXRk2KRB+t12memUQ2Y6qwxJ3+ENHwmzzLgH534O4z1w82szWSNGwaWSu1IgGrIfM0f/o1AVQ+Q4K+JWuxkWIN6+jux+HIk7tA2JuuMIHNiq+dIGRnBDeKnvEixL6GSLFiyga1O37yLjZygmqHitNBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248967; c=relaxed/simple;
	bh=O6otxQZDC1k5aNFt0JF4c6gkWn1tE2tulJLiFxwOJd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fj1Z5Qo+YvkPyKvyx7nOisuIr6gsRUOh4uPvEEejeqad3NGyfFaLbcp9x/8u5UVvQ+1U/5ZAuD2y4obH+EBk/OPy8Oe5rcvRxKnTRJtUJYCjxFwVCyaUeljPlGYQid1lSDTr0TbE0SnqpuEgdSct86ptVXl+gqLI96XAxFVnkKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XwFVssKS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-369cb9f086aso1437245f8f.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 03:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722248964; x=1722853764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZGIHdfwruuw8a2HZZzQzYeFhndOAkcBR+nn4eBl6c8=;
        b=XwFVssKSxMP1PSKFzmTFjgxO6XuLuccRGlkVZbvlID/I90CDNYEWNr7RoQ5/1eGIb6
         vFKYVpoiJEB6Jem/DU7aojuci31aYIfvm5aPrNe3FPOrj9bU1G1CevgoQ5kMPkEilmMx
         MwsO9CYqOixd9IXFJkw/yxtO8gH7WPeR9Fu7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722248964; x=1722853764;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZGIHdfwruuw8a2HZZzQzYeFhndOAkcBR+nn4eBl6c8=;
        b=b6H1u6qwU3aUGW8Rd0AzsVykgkTSXvqct6HrCBKRgXJ0PPcQNDgZ24qBFkGNPb5wuU
         yX/SYmcogaozfNgsFzyv5Aov0RZQ9TF9sFvsxiZ/I1OB8Gz+r4oZATNZTvxl4uLOSk0T
         vcOiD64NJe+NEuEmpLePLPzXXcOz3y39nsizVugeEyb52+SLQKRxacI50PXaOGIAl2Cv
         S1rd65hM+EvqBw/UEzm3WXnPjkyZqRLtv5FaU9SDxu9yFJRN1F4i7M6mWHojT5cDrlzo
         OFFcm/iDy3gW/02GnlCrsfhFvlRiP59EwQP8WC4dqvGEFveCbT1HSs8UVf3EY9GFobY5
         Dn1A==
X-Forwarded-Encrypted: i=1; AJvYcCXuUFc/CVQ2P0OSYA5rr9x9BVP9wuMjH6RceYsl9xuL4RW3enEKqAGUXNuIu1s3n7VsSp3ilvYF08XZ/9tWHVMxQMIk9OoB
X-Gm-Message-State: AOJu0YxB/TvntEmPeptP5oB7DH5cb/i0Pd3aP/s9/VCL2UjHD1h6tB+/
	hOXpMhyp+vK1ND1FRs1KL9Yf6kQ1dpIXXtIUjBj2P3ISxk2rlcjgHQGuMa6YioQ=
X-Google-Smtp-Source: AGHT+IH4R5QJ6J278MwWKDODDM8daysZcJnYsL7HDJR6U6jL6gBsYBeGTAAWFt/xysy8mm7bLkFzwQ==
X-Received: by 2002:a05:6000:2c4:b0:367:9522:5e6d with SMTP id ffacd0b85a97d-36b5d3694e1mr5786168f8f.52.1722248964322;
        Mon, 29 Jul 2024 03:29:24 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281fb6369esm12873365e9.48.2024.07.29.03.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 03:29:24 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:29:22 +0100
From: Joe Damato <jdamato@fastly.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	horms@kernel.org, rkannoth@marvell.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v25 08/13] rtase: Implement net_device_ops
Message-ID: <ZqdvAmRc3sBzDFYI@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, jiri@resnulli.us, horms@kernel.org,
	rkannoth@marvell.com, pkshih@realtek.com, larry.chiu@realtek.com
References: <20240729062121.335080-1-justinlai0215@realtek.com>
 <20240729062121.335080-9-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729062121.335080-9-justinlai0215@realtek.com>

On Mon, Jul 29, 2024 at 02:21:16PM +0800, Justin Lai wrote:
> 1. Implement .ndo_set_rx_mode so that the device can change address
> list filtering.
> 2. Implement .ndo_set_mac_address so that mac address can be changed.
> 3. Implement .ndo_change_mtu so that mtu can be changed.
> 4. Implement .ndo_tx_timeout to perform related processing when the
> transmitter does not make any progress.
> 5. Implement .ndo_get_stats64 to provide statistics that are called
> when the user wants to get network device usage.
> 6. Implement .ndo_vlan_rx_add_vid to register VLAN ID when the device
> supports VLAN filtering.
> 7. Implement .ndo_vlan_rx_kill_vid to unregister VLAN ID when the device
> supports VLAN filtering.
> 8. Implement the .ndo_setup_tc to enable setting any "tc" scheduler,
> classifier or action on dev.
> 9. Implement .ndo_fix_features enables adjusting requested feature flags
> based on device-specific constraints.
> 10. Implement .ndo_set_features enables updating device configuration to
> new features.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 235 ++++++++++++++++++
>  1 file changed, 235 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 8fd69d96219f..80673fa1e9a3 100644

[...]

> +static void rtase_dump_state(const struct net_device *dev)
> +{

[...]

> +
> +	netdev_err(dev, "tx_packets %lld\n",
> +		   le64_to_cpu(counters->tx_packets));
> +	netdev_err(dev, "rx_packets %lld\n",
> +		   le64_to_cpu(counters->rx_packets));
> +	netdev_err(dev, "tx_errors %lld\n",
> +		   le64_to_cpu(counters->tx_errors));
> +	netdev_err(dev, "rx_errors %d\n",
> +		   le32_to_cpu(counters->rx_errors));
> +	netdev_err(dev, "rx_missed %d\n",
> +		   le16_to_cpu(counters->rx_missed));
> +	netdev_err(dev, "align_errors %d\n",
> +		   le16_to_cpu(counters->align_errors));
> +	netdev_err(dev, "tx_one_collision %d\n",
> +		   le32_to_cpu(counters->tx_one_collision));
> +	netdev_err(dev, "tx_multi_collision %d\n",
> +		   le32_to_cpu(counters->tx_multi_collision));
> +	netdev_err(dev, "rx_unicast %lld\n",
> +		   le64_to_cpu(counters->rx_unicast));
> +	netdev_err(dev, "rx_broadcast %lld\n",
> +		   le64_to_cpu(counters->rx_broadcast));
> +	netdev_err(dev, "rx_multicast %d\n",
> +		   le32_to_cpu(counters->rx_multicast));
> +	netdev_err(dev, "tx_aborted %d\n",
> +		   le16_to_cpu(counters->tx_aborted));
> +	netdev_err(dev, "tx_underun %d\n",
> +		   le16_to_cpu(counters->tx_underun));

You use le64/32/16_to_cpu here for all stats, but below in rtase_get_stats64, it
is only used for tx_errors.

The code should probably be consistent? Either you do or don't need
to use them?

> +}
> +
[...]
> +
> +static void rtase_get_stats64(struct net_device *dev,
> +			      struct rtnl_link_stats64 *stats)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	const struct rtase_counters *counters;
> +
> +	counters = tp->tally_vaddr;
> +
> +	dev_fetch_sw_netstats(stats, dev->tstats);
> +
> +	/* fetch additional counter values missing in stats collected by driver
> +	 * from tally counter
> +	 */
> +	rtase_dump_tally_counter(tp);
> +	stats->rx_errors = tp->stats.rx_errors;
> +	stats->tx_errors = le64_to_cpu(counters->tx_errors);
> +	stats->rx_dropped = tp->stats.rx_dropped;
> +	stats->tx_dropped = tp->stats.tx_dropped;
> +	stats->multicast = tp->stats.multicast;
> +	stats->rx_length_errors = tp->stats.rx_length_errors;

See above; le64_to_cpu for tx_errors, but not the rest of the stats. Why?

