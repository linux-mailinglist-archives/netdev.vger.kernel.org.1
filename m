Return-Path: <netdev+bounces-54189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43CC806360
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F058282166
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 00:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229B419F;
	Wed,  6 Dec 2023 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNuqpWKl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48F41A4
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 16:22:29 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54cc60f3613so3799081a12.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 16:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701822148; x=1702426948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CxVh4KjAZkwso8l+MJQRNq1axFZ2ic5CVdh+OzmZ6Y=;
        b=fNuqpWKlckUjD9w1mQ5KWI5F3/at3xNFSHlNI2F+7ZlTEvq9+yzDnVL999OS1pZxbM
         UGfbD88cGFwHO9VtuKLMZ3FhY8JEpyviwgTxfbWQMzC4GlqHtzFHdhxCwkhufG6jEqd7
         7r0LPSEkWpIPsxBxE9uHE2xdNxEKKL/l/5CEgJQVpd+ucZnUXCXcMOc16AlLT9Xzdu9T
         JuxYI1HPKzKqxYAmLPZhqnpz4/htzbgZ77B01fvk7cY8Ap21uZ8UGiPP1+Pms0KBcxtu
         BHZryXbH1Cz35/C4YWxwHF5kn6snLUEZFQs2KJ7Zw60dB/bfejC2lgWI9hBH370kzs07
         KqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701822148; x=1702426948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CxVh4KjAZkwso8l+MJQRNq1axFZ2ic5CVdh+OzmZ6Y=;
        b=NiHbCHnByceIKYRtBCIBo1nH0m++jEOf0khkN8Hc6Lpd0P+jcRUoF3SE0uJztYYySY
         ubiLk4vPNyYdQb7Xr1RM8ESACDa+qo5zcgKVob5lCiU2UgNF0TkrjfTQtMbSDujV5Tio
         KWP94Pr+I+bu6sd0tlJWaXBQcwNOcjE0oosEVCEM9Gs7lCgkLbCkpDUp6ZYJ6l44ytbr
         1AkL1xWFJ+Q+qQK6LbYAL+TzWzoSspYGrXMPQJz/eMmM/8H2EJwmUejsPel7UqjSV8JB
         2rQGPA4fmgH8x9TXy4zStrQCs3EwMbkiHxxGqrsswDgT/D/eSWUB6LTQAKZY1OMv26xl
         Hltg==
X-Gm-Message-State: AOJu0Yw8BZEWnArXIw6Vx9K7x0Rx4iQI8RPCNFs9FHdaKXDrJ8YGhUEZ
	s6wonB4oHeaakBLHnK1cKWo=
X-Google-Smtp-Source: AGHT+IFXZD74orANgkuah89H3q3Dwry2/HsMFK8O96sezP/dPN1cAX36tWoXX+L0viLJp1tj7KOUAg==
X-Received: by 2002:a05:6402:5147:b0:54c:4837:81e6 with SMTP id n7-20020a056402514700b0054c483781e6mr54010edd.55.1701822147950;
        Tue, 05 Dec 2023 16:22:27 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id e8-20020a50fb88000000b0054c6261d245sm1689399edq.37.2023.12.05.16.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 16:22:27 -0800 (PST)
Date: Wed, 6 Dec 2023 02:22:25 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 6/6] net: dsa: mv88e6xxx: Add "rmon" counter
 group support
Message-ID: <20231206002225.nehk4htc4mozcq5b@skbuf>
References: <20231205160418.3770042-1-tobias@waldekranz.com>
 <20231205160418.3770042-7-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205160418.3770042-7-tobias@waldekranz.com>

On Tue, Dec 05, 2023 at 05:04:18PM +0100, Tobias Waldekranz wrote:
> +static void mv88e6xxx_get_rmon_stats(struct dsa_switch *ds, int port,
> +				     struct ethtool_rmon_stats *rmon_stats,
> +				     const struct ethtool_rmon_hist_range **ranges)
> +{
> +	static const struct ethtool_rmon_hist_range rmon_ranges[] = {
> +		{   64,    64 },
> +		{   65,   127 },
> +		{  128,   255 },
> +		{  256,   511 },
> +		{  512,  1023 },
> +		{ 1024, 65535 },
> +		{}
> +	};
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +	int ret;
> +
> +	ret = mv88e6xxx_stats_snapshot(chip, port);
> +	if (ret < 0)
> +		return;
> +
> +#define MV88E6XXX_RMON_STAT_MAP(_id, _member)				\
> +	mv88e6xxx_stats_get_stat(chip, port,				\
> +				 &mv88e6xxx_hw_stats[MV88E6XXX_HW_STAT_ID_ ## _id], \
> +				 &rmon_stats->stats._member)
> +
> +	MV88E6XXX_RMON_STAT_MAP(in_undersize, undersize_pkts);
> +	MV88E6XXX_RMON_STAT_MAP(in_oversize, oversize_pkts);
> +	MV88E6XXX_RMON_STAT_MAP(in_fragments, fragments);
> +	MV88E6XXX_RMON_STAT_MAP(in_jabber, jabbers);
> +	MV88E6XXX_RMON_STAT_MAP(hist_64bytes, hist[0]);
> +	MV88E6XXX_RMON_STAT_MAP(hist_65_127bytes, hist[1]);
> +	MV88E6XXX_RMON_STAT_MAP(hist_128_255bytes, hist[2]);
> +	MV88E6XXX_RMON_STAT_MAP(hist_256_511bytes, hist[3]);
> +	MV88E6XXX_RMON_STAT_MAP(hist_512_1023bytes, hist[4]);
> +	MV88E6XXX_RMON_STAT_MAP(hist_1024_max_bytes, hist[5]);
> +
> +#undef MV88E6XXX_RMON_STAT_MAP
> +
> +	*ranges = rmon_ranges;
> +}

I just noticed that this doesn't populate the TX counters, just RX.

I haven't tried it, but I think the Histogram Mode bits (11:10) of the
Stats Operation Register might be able to control what gets reported for
the Set 4 of counters. Currently AFAICS, the driver always sets it to
MV88E6XXX_G1_STATS_OP_HIST_RX_TX, aka what gets reported to
"rx-rmon-etherStatsPkts64to64Octets" is actually an RX+TX counter.

What's the story behind this?

