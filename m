Return-Path: <netdev+bounces-54127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9788060A7
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8751F21794
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31856E594;
	Tue,  5 Dec 2023 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="ouEwpuIw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FCFD46
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 13:24:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bf32c0140so3568984e87.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 13:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701811481; x=1702416281; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDjB2+9d0q9+F4oO9wErWsIqLBdeODlH8UsFKkO9NRk=;
        b=ouEwpuIwF/prN1AtNpse+88UlhrjkoYTI/6pR/Lpn3HBBKBhnPu/SRloONvaKHobhJ
         mJsrvWoJVLIIfaXY61ZSamVw8Cppn8846WrauyuOlAA+zcY56tE66/XG31mn/JC021V1
         FXW0Or2N5xjE6eoOe6gz0HEphdH7JxGVtwWrI486Z3dunucBfZoH1Papw2uYqmDNl5CX
         tekg3n5gsyjHzh0v4b5ufNlYT9tWZZY5xjRkEOl9y8KcLYqhpJ4eNwIfWzj7H4Tefaub
         XmdbEgBdx5K/1CQNtvLnzjvf0PQxlZeHYQKQuCfK31DiZPGx8WjmwzbJXGsTagVxcKLI
         lVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701811481; x=1702416281;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDjB2+9d0q9+F4oO9wErWsIqLBdeODlH8UsFKkO9NRk=;
        b=sn6c4IvNfEnMi+vKkKeojRTvbB6gaEnLkAkhgbSqOSf1ZOVRjiCroyeBLyhak+TrR4
         iO/OswY+mrapu7lpA4Yd58vUQUpE7xky3PYrxIbQhF3gE9hYZMyzUbjk5C8inWyBztQD
         BrvQmHw0Rw15yxdNsGyZag1FaK6gSQH9UtwP+BnHG9IAUBttcVcZbwJCEcIWBdQMJro0
         uEzDK3HLg4RH3zotZdbdVu5Rh5xS+4ebcs6ZUXk1S7vaP33gDXABqmDnlCrF435ymZDU
         jnw+vAC4nL+WLU/1vMiZOc/DB/YbnSanJxognr4JGEXwsElI1lmGh+f1RWP/mEvhcy0E
         P2yw==
X-Gm-Message-State: AOJu0YxyeMWTFuvFU9U0+5FEWPQszgoTp/DZ7Zdxy0rSwiVgDykKEJqv
	3/RGC/OFW5swhsvaF/xIJCtthU/fqderGEWpbvw=
X-Google-Smtp-Source: AGHT+IG0uNSjwW0GH2/1Xl9elFsgq6HfvmQK4XtQKTQuFolA5Q104UFVGqeFXm+9rtDyrQ8OIYvTZg==
X-Received: by 2002:a05:6512:3d8e:b0:50b:e625:245c with SMTP id k14-20020a0565123d8e00b0050be625245cmr3336848lfv.47.1701811481065;
        Tue, 05 Dec 2023 13:24:41 -0800 (PST)
Received: from wkz-x13 (h-176-10-137-178.NA.cust.bahnhof.se. [176.10.137.178])
        by smtp.gmail.com with ESMTPSA id o12-20020ac2494c000000b0050bf0320718sm942068lfi.95.2023.12.05.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:24:40 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 5/6] net: dsa: mv88e6xxx: Add "eth-mac"
 counter group support
In-Reply-To: <20231205180740.aenvbx6vxbx3d6o4@skbuf>
References: <20231205180740.aenvbx6vxbx3d6o4@skbuf>
Date: Tue, 05 Dec 2023 22:24:39 +0100
Message-ID: <87y1e88hrc.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tis, dec 05, 2023 at 20:07, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> On Tue, Dec 05, 2023 at 05:04:17PM +0100, Tobias Waldekranz wrote:
>> Report the applicable subset of an mv88e6xxx port's counters using
>> ethtool's standardized "eth-mac" counter group.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>>  drivers/net/dsa/mv88e6xxx/chip.c | 39 ++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>> 
>> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
>> index 473f31761b26..1a16698181fb 100644
>> --- a/drivers/net/dsa/mv88e6xxx/chip.c
>> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
>> @@ -1319,6 +1319,44 @@ static void mv88e6xxx_get_ethtool_stats(struct dsa_switch *ds, int port,
>>  	mv88e6xxx_get_stats(chip, port, data);
>>  }
>>  
>> +static void mv88e6xxx_get_eth_mac_stats(struct dsa_switch *ds, int port,
>> +					struct ethtool_eth_mac_stats *mac_stats)
>> +{
>> +	struct mv88e6xxx_chip *chip = ds->priv;
>> +	int ret;
>> +
>> +	ret = mv88e6xxx_stats_snapshot(chip, port);
>> +	if (ret < 0)
>> +		return;
>> +
>> +#define MV88E6XXX_ETH_MAC_STAT_MAP(_id, _member)			\
>> +	mv88e6xxx_stats_get_stat(chip, port,				\
>> +				 &mv88e6xxx_hw_stats[MV88E6XXX_HW_STAT_ID_ ## _id], \
>> +				 &mac_stats->stats._member)
>> +
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(out_unicast, FramesTransmittedOK);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(single, SingleCollisionFrames);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(multiple, MultipleCollisionFrames);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(in_unicast, FramesReceivedOK);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(in_fcs_error, FrameCheckSequenceErrors);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(out_octets, OctetsTransmittedOK);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(deferred, FramesWithDeferredXmissions);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(late, LateCollisions);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(in_good_octets, OctetsReceivedOK);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(out_multicasts, MulticastFramesXmittedOK);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(out_broadcasts, BroadcastFramesXmittedOK);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(excessive, FramesWithExcessiveDeferral);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(in_multicasts, MulticastFramesReceivedOK);
>> +	MV88E6XXX_ETH_MAC_STAT_MAP(in_broadcasts, BroadcastFramesReceivedOK);
>> +
>> +#undef MV88E6XXX_ETH_MAC_STAT_MAP
>
> I don't exactly enjoy this use (and placement) of the C preprocessor macro
> when spelling out code would have worked just fine, but to each his own.
> At least it is consistent in that we can jump to the other occurrences
> of the statistics counter.

Fair enough. I was trying to come up with something that would make it
easy to audit the chosen mapping between "native" and "standard" counter
names, since I imagine that is what future readers of this are going to
be interested in.

>> +
>> +	mac_stats->stats.FramesTransmittedOK += mac_stats->stats.MulticastFramesXmittedOK;
>> +	mac_stats->stats.FramesTransmittedOK += mac_stats->stats.BroadcastFramesXmittedOK;
>> +	mac_stats->stats.FramesReceivedOK += mac_stats->stats.MulticastFramesReceivedOK;
>> +	mac_stats->stats.FramesReceivedOK += mac_stats->stats.BroadcastFramesReceivedOK;
>> +}
>
> Not sure if there's a "best thing to do" in case a previous mv88e6xxx_stats_get_stat()
> call fails. In net/ethtool/stats.c we have ethtool_stats_sum(), and that's the
> core saying that U64_MAX means one of the sum terms was not reported by
> the driver, and it makes that transparent by simply returning the other.
>
> Here, "not reported by the driver" is due to a bus I/O error, and using
> ethtool_stats_sum() as-is would hide that error away completely, and
> report only the other sum term. Sounds like a failure that would be too
> silent. Whereas your proposal would just report a wildly incorrect
> number - but at high data rates (for offloaded traffic, too), maybe that
> wouldn't be exactly trivial to notice, either.
>
> Maybe we need a variant of ethtool_stats_sum() that requires both terms,
> otherwise returns ETHTOOL_STAT_NOT_SET?

That sounds like a good idea.

> Anyway, this is not a blocker for the current patch set, which is a bit
> too large to resend for trivial matters.
>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for the review!

