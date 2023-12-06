Return-Path: <netdev+bounces-54321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43254806993
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 09:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633C01C20941
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154D919449;
	Wed,  6 Dec 2023 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="WYuNgxEe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A6A98
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 00:27:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bfd8d5c77so3286981e87.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 00:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701851251; x=1702456051; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4AfVQ2zbTAHUj7f1jRzqOSD0uXgr0T0uDtU04QznLE=;
        b=WYuNgxEeLtmmDkR9gdt6ebGyOjZps1ZUaXNSQ2sZCCo+P5DNExteLWBGi5dzY4tSX0
         BaRHFYnQ0pEWOFyLTycLW2BijNqL/guusZOW8ESrLnaw+RwJ2ym/rW5LeHy9AwK7o+K8
         aBDHAp4Ixesp30zTKyQxmydBTojToDRt29DMU1xAzlVJIBwMM14/ocx4dJacRoE34p2H
         Ljnn4U6Dffh14YFq8CX+eoXI3HcxNO+4xjMfdPTOyYR2Se5VKJy4yk0OK1rgfu/EYkzQ
         dv4MQbNX51zn2WfM8f1NDbf2MNcTkzT0n3ZzJigtwYMC3RmeRSTg8+1ph5f0Bg7vY9RI
         bhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701851251; x=1702456051;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4AfVQ2zbTAHUj7f1jRzqOSD0uXgr0T0uDtU04QznLE=;
        b=YMZC58ho3qANJNpi/RgjDw4814BHOUqQNDsOxyJLUhx+f2k8WThoIfVbTFLOvxVxFm
         oBoyd0U6PQSbNnNAYtKypFWkTOcWmVx2NFAufFIqMZw15IoT1jYPyyYWzwKOM50Ky17m
         cWRj7pRC50SU3kziHld2yP2BFha9U1Qj2Xcpq9L9akTFMOa2qJ+p7T88PHmURjhhIvvv
         csjCUf/3U3eSTxwxECyfCoIxxcb5pKOrNFb5Ze+xLeP53GdSNuSiPz+qiusi4QILsgR+
         vZ4CaYYC4Z52Hc2P3TxtiboHOTOZXb5yj2UBJJIxQVOsGaIun9LGc9FwT/bjnm6k6Rqs
         czmw==
X-Gm-Message-State: AOJu0YxyD7XbldNC6RCytUbKmRatng2LGXsioZjPf2Zkxr+BguyuEZ6J
	fBTf/F45IU0hU1nt+o3SHI+Sxx65XbaPT+j9SKM=
X-Google-Smtp-Source: AGHT+IGBk8HKWGUlhcABWyJ+BdKxhq17cXA4/tzK6OZnHqB5IhgX+myD61TuvQ4CBom1F4cjaIA3pg==
X-Received: by 2002:a05:6512:5d6:b0:50b:fb07:dd15 with SMTP id o22-20020a05651205d600b0050bfb07dd15mr199249lfo.248.1701851250826;
        Wed, 06 Dec 2023 00:27:30 -0800 (PST)
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id bi38-20020a0565120ea600b0050bfd88075asm659588lfb.287.2023.12.06.00.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:27:30 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 6/6] net: dsa: mv88e6xxx: Add "rmon" counter
 group support
In-Reply-To: <20231206002225.nehk4htc4mozcq5b@skbuf>
References: <20231205160418.3770042-1-tobias@waldekranz.com>
 <20231205160418.3770042-7-tobias@waldekranz.com>
 <20231206002225.nehk4htc4mozcq5b@skbuf>
Date: Wed, 06 Dec 2023 09:27:29 +0100
Message-ID: <87v89b91n2.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ons, dec 06, 2023 at 02:22, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, Dec 05, 2023 at 05:04:18PM +0100, Tobias Waldekranz wrote:
>> +static void mv88e6xxx_get_rmon_stats(struct dsa_switch *ds, int port,
>> +				     struct ethtool_rmon_stats *rmon_stats,
>> +				     const struct ethtool_rmon_hist_range **ranges)
>> +{
>> +	static const struct ethtool_rmon_hist_range rmon_ranges[] = {
>> +		{   64,    64 },
>> +		{   65,   127 },
>> +		{  128,   255 },
>> +		{  256,   511 },
>> +		{  512,  1023 },
>> +		{ 1024, 65535 },
>> +		{}
>> +	};
>> +	struct mv88e6xxx_chip *chip = ds->priv;
>> +	int ret;
>> +
>> +	ret = mv88e6xxx_stats_snapshot(chip, port);
>> +	if (ret < 0)
>> +		return;
>> +
>> +#define MV88E6XXX_RMON_STAT_MAP(_id, _member)				\
>> +	mv88e6xxx_stats_get_stat(chip, port,				\
>> +				 &mv88e6xxx_hw_stats[MV88E6XXX_HW_STAT_ID_ ## _id], \
>> +				 &rmon_stats->stats._member)
>> +
>> +	MV88E6XXX_RMON_STAT_MAP(in_undersize, undersize_pkts);
>> +	MV88E6XXX_RMON_STAT_MAP(in_oversize, oversize_pkts);
>> +	MV88E6XXX_RMON_STAT_MAP(in_fragments, fragments);
>> +	MV88E6XXX_RMON_STAT_MAP(in_jabber, jabbers);
>> +	MV88E6XXX_RMON_STAT_MAP(hist_64bytes, hist[0]);
>> +	MV88E6XXX_RMON_STAT_MAP(hist_65_127bytes, hist[1]);
>> +	MV88E6XXX_RMON_STAT_MAP(hist_128_255bytes, hist[2]);
>> +	MV88E6XXX_RMON_STAT_MAP(hist_256_511bytes, hist[3]);
>> +	MV88E6XXX_RMON_STAT_MAP(hist_512_1023bytes, hist[4]);
>> +	MV88E6XXX_RMON_STAT_MAP(hist_1024_max_bytes, hist[5]);
>> +
>> +#undef MV88E6XXX_RMON_STAT_MAP
>> +
>> +	*ranges = rmon_ranges;
>> +}
>
> I just noticed that this doesn't populate the TX counters, just RX.
>
> I haven't tried it, but I think the Histogram Mode bits (11:10) of the
> Stats Operation Register might be able to control what gets reported for
> the Set 4 of counters. Currently AFAICS, the driver always sets it to
> MV88E6XXX_G1_STATS_OP_HIST_RX_TX, aka what gets reported to
> "rx-rmon-etherStatsPkts64to64Octets" is actually an RX+TX counter.

You have a keen eye! Yes, that is what's happening.

> What's the story behind this?

I think the story starts, and ends, with this value being the hardware
default.

Seeing as the hardware only has a single set of histogram counters, it
seems to me like we have to prioritize between:

1. Keeping Rx+Tx: Backwards-compatible, but we can't export any histogram via
   the standard RMON group.

2. Move to Rx-only: We can export them via the RMON group, but we change
   the behavior of the "native" counters.

3. Move to Tx-only: We can export them via the RMON group, but we change
   the behavior of the "native" counters.

Looking at RFC2819, which lays out the original RMON MIB, we find this
description:

    etherStatsPkts64Octets OBJECT-TYPE
        SYNTAX     Counter32
        UNITS      "Packets"
        MAX-ACCESS read-only
        STATUS     current
        DESCRIPTION
            "The total number of packets (including bad
            packets) received that were 64 octets in length
            (excluding framing bits but including FCS octets)."
        ::= { etherStatsEntry 14 }

In my opinion, this gives (2) a clear edge over (3), so we're down to
choosing between (1) and (2). Personally, I lean towards (2), as I think
it is more useful because:

- Most people will tend to assume that the histogram counters refers to
  those defined in RFC2819 anyway

- It means we can deliver _something_ rather than nothing to someone
  building an operating system, who is looking for a hardware
  independent way of providing diagnostics

