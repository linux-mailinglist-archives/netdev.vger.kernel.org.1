Return-Path: <netdev+bounces-53543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDED9803A5C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912311F21226
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE28A250F3;
	Mon,  4 Dec 2023 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo2wA3Tk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7190D9B
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:34:55 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so4982130a12.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 08:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701707694; x=1702312494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=edBqw88YXJb27IR4+ojupd1HYcnJYWpxxPM3n6v+U4g=;
        b=Qo2wA3TkxLM5km3vxNFyh6O958rbGWHKh1OWbMuQgc7RFvH5I7w0RRRJnhmP7XEUv+
         2M5mK5NvAzFRVVX4swnyUzEUSUAfJElpYYHPKVX1PdxZBcwCanieXFOKLwBVvNozw/Od
         +VMFr8/1XYdN6Q0Fh/hiYRbR+4hdhXnY0Hk6JmkxZqX1xARal8mcp9Oils/o6A8/rZqb
         K+1f6K8NtD1IS4MZlqXBo4TUMZp+Fb6H1Iss1Gh6nVKijc+y/AP8nJPlDbxJc4+CU0Hj
         u86zgURF3KLNEbmMdCv8LDSSJaeR1sQ9IcoLnI2f/fxNF1/6R+8fN50Eri/d4d6Z9/Vc
         CkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707694; x=1702312494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edBqw88YXJb27IR4+ojupd1HYcnJYWpxxPM3n6v+U4g=;
        b=qob49Ugl8KYpr6AYa1pDUWWJI1e3DZOXqNtQdGao2GUjJzh5745gezqgVZ0Bmmn8QL
         qF9XmEIYViiBi7Td/mV9YtL0DjGcfQF9zGbfT4g3Ahxr2wbXbFllge+Sj6NXmjEkvgsH
         h1ECKMQz8Emr1226z+aQfzyhfxu9QN9Hq0y/CSPC12ERQ5jgkXPcmScTC0uyoYWf2RtS
         XdWzVcJaGpjwmaFC8DvPnhS+WAYDibWkAn6hhTue91oMyAVfI/S7wsEABdiaTnuvrZAB
         5Q/L98uVsNyDRQdalUlQe0w0Gwzb7ZbtiOvG/aNqEtaoHcEDPriYMKimUW8Dv3avlj2b
         /4jA==
X-Gm-Message-State: AOJu0Yz96IGyPPcP0b7kZOc61cfHkS/1PGOq47ZMDAW/cbfD/yH2GJYy
	IcmYoYm/RcTuTMhtWvCqR5inf3Qtc0wZXg==
X-Google-Smtp-Source: AGHT+IFWcbchsupA7NCxjSTVN6Hkd+hXEYI8UIft/OoPttoR96lFfz1BwalEGTZGB/C+LfrejROcWQ==
X-Received: by 2002:a50:a699:0:b0:54c:84e7:936b with SMTP id e25-20020a50a699000000b0054c84e7936bmr2166665edc.7.1701707693710;
        Mon, 04 Dec 2023 08:34:53 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7d544000000b0054b53aacd86sm4901977edr.65.2023.12.04.08.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:34:53 -0800 (PST)
Date: Mon, 4 Dec 2023 18:34:51 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: dsa: mv88e6xxx: Add "eth-mac" counter
 group support
Message-ID: <20231204163451.whx3llb7zvnne433@skbuf>
References: <20231201125812.1052078-1-tobias@waldekranz.com>
 <20231201125812.1052078-1-tobias@waldekranz.com>
 <20231201125812.1052078-4-tobias@waldekranz.com>
 <20231201125812.1052078-4-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201125812.1052078-4-tobias@waldekranz.com>
 <20231201125812.1052078-4-tobias@waldekranz.com>

On Fri, Dec 01, 2023 at 01:58:11PM +0100, Tobias Waldekranz wrote:
> Report the applicable subset of an mv88e6xxx port's counters using
> ethtool's standardized "eth-mac" counter group.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 52 ++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 71c60f229a2f..51e3744cb89b 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -1320,6 +1320,57 @@ static void mv88e6xxx_get_ethtool_stats(struct dsa_switch *ds, int port,
>  
>  }
>  
> +static void mv88e6xxx_get_eth_mac_stats(struct dsa_switch *ds, int port,
> +					struct ethtool_eth_mac_stats *mac_stats)
> +{
> +#define MV88E6XXX_ETH_MAC_STAT_MAPPING(_id, _member)			\
> +	[MV88E6XXX_HW_STAT_ID_ ## _id] =				\
> +		offsetof(struct ethtool_eth_mac_stats, stats._member)	\
> +
> +	static const size_t stat_map[MV88E6XXX_HW_STAT_ID_MAX] = {
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(out_unicast, FramesTransmittedOK),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(single, SingleCollisionFrames),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(multiple, MultipleCollisionFrames),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(in_unicast, FramesReceivedOK),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(in_fcs_error, FrameCheckSequenceErrors),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(out_octets, OctetsTransmittedOK),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(deferred, FramesWithDeferredXmissions),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(late, LateCollisions),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(in_good_octets, OctetsReceivedOK),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(out_multicasts, MulticastFramesXmittedOK),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(out_broadcasts, BroadcastFramesXmittedOK),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(excessive, FramesWithExcessiveDeferral),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(in_multicasts, MulticastFramesReceivedOK),
> +		MV88E6XXX_ETH_MAC_STAT_MAPPING(in_broadcasts, BroadcastFramesReceivedOK),
> +	};
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +	const struct mv88e6xxx_hw_stat *stat;
> +	enum mv88e6xxx_hw_stat_id id;
> +	u64 *member;
> +	int ret;
> +
> +	mv88e6xxx_reg_lock(chip);
> +	ret = mv88e6xxx_stats_snapshot(chip, port);
> +	mv88e6xxx_reg_unlock(chip);

Wouldn't it be more consistent with this driver's own convention if the
mv88e6xxx_reg_lock() was absorbed by mv88e6xxx_stats_snapshot()?

> +
> +	if (ret < 0)
> +		return;
> +
> +	stat = mv88e6xxx_hw_stats;
> +	for (id = 0; id < MV88E6XXX_HW_STAT_ID_MAX; id++, stat++) {
> +		if (!stat_map[id])
> +			continue;

Hmm, a bit fragile, this relies on offsetof(struct ethtool_eth_mac_stats, stats)
never being 0, which is not a documented requirement.

Would it be hard to make the stat_map[] array compressed rather than
sparse, and push the stat id inside the struct mv88e6xxx_hw_stat, and
only operate on ARRAY_SIZE() elements?

> +
> +		member = (u64 *)(((char *)mac_stats) + stat_map[id]);
> +		mv88e6xxx_stats_get_stat(chip, port, stat, member);
> +	}
> +
> +	mac_stats->stats.FramesTransmittedOK += mac_stats->stats.MulticastFramesXmittedOK;
> +	mac_stats->stats.FramesTransmittedOK += mac_stats->stats.BroadcastFramesXmittedOK;
> +	mac_stats->stats.FramesReceivedOK += mac_stats->stats.MulticastFramesReceivedOK;
> +	mac_stats->stats.FramesReceivedOK += mac_stats->stats.BroadcastFramesReceivedOK;
> +}
> +
>  static int mv88e6xxx_get_regs_len(struct dsa_switch *ds, int port)
>  {
>  	struct mv88e6xxx_chip *chip = ds->priv;
> @@ -6839,6 +6890,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
>  	.phylink_mac_link_up	= mv88e6xxx_mac_link_up,
>  	.get_strings		= mv88e6xxx_get_strings,
>  	.get_ethtool_stats	= mv88e6xxx_get_ethtool_stats,
> +	.get_eth_mac_stats	= mv88e6xxx_get_eth_mac_stats,
>  	.get_sset_count		= mv88e6xxx_get_sset_count,
>  	.port_max_mtu		= mv88e6xxx_get_max_mtu,
>  	.port_change_mtu	= mv88e6xxx_change_mtu,
> -- 
> 2.34.1
> 


