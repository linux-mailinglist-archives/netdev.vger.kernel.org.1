Return-Path: <netdev+bounces-54597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9FE807909
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 20:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979761F211E0
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F73EA8C;
	Wed,  6 Dec 2023 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvxwc/UP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77877FA
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 11:55:54 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1db99cd1b2so15111966b.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 11:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701892553; x=1702497353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dPXi+93Om7L+gYopOTvvNn+uydy7bt1zEZ+wKRcAjLU=;
        b=mvxwc/UP+buY7IrHPbPSLwTVRUm/UWL4TUGo1W0LqDsb0lzsqgoc3dNvUd+kxZB1KZ
         AYtOLU1e4r0tmR3IpUA8F/EUu187rX9zM9SbiOoZAlJ4WrLX7Vh1tSFTqoK5amLvBLrB
         OMBfNI36AQOF9RJzAppvsWi5e+FAoyP3t/ZMNqCbIZmNFkSyxtekSGZUE2mjxpXT/zER
         9pL8SK9LczMFhVNKgRonHvFdcqacgmQGhCcDQM6r+omcpzfq3wsLr71mbhnQCfGz430M
         TF8mqRsFVZ0XvNFziWGWi7pCqrU4D56xGHUtjN0Nvaw76ctw1kuAiep9BVAFddImTMYE
         p3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892553; x=1702497353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPXi+93Om7L+gYopOTvvNn+uydy7bt1zEZ+wKRcAjLU=;
        b=i/RQJD+IY+SKmwaJE8enK6Qa8zboSbazb6Ofotng6dY0C7qjHJXSENostOReKqM4ae
         2zNTzPcNSxeku/WW8mbm51j4LZhzqO064IVXLtWB641e++03gVVVFLlvlz/hYu6EoiSf
         28BlW6H6kxYxPVDxQfZTL5tFAQdouRKo7DUQo2DPaQHaw/oJqqwzXoZAJ4UNb1FQYKBN
         rzMzm4NP50wILnaq1g8a1tGf/AB4n58ur5H/Uj6E52wL2wJu1jedS4tW/bnxi1CTsPZR
         uXZay+K/f98QGZWZcvnWT2ArCSjhgtArUXuDVAyqZ/GE+JQwYCBJ6+gO7P5XJ6T30LUt
         Lghg==
X-Gm-Message-State: AOJu0YxYmmnaqapUCoAAefKKY3WCtd6977wuP0Tip/R4UUIL+KYOX9Me
	EchF7nx0g0c05d8fYZ+qS/Q=
X-Google-Smtp-Source: AGHT+IHZUUqEM/dyFoIfS8LALMiEgnC7lvYn8qvBhSNvrRTI+gxkor9zAgxGR5zZUmn31HGYFv+LoQ==
X-Received: by 2002:a17:906:6b96:b0:a1d:9697:73a2 with SMTP id l22-20020a1709066b9600b00a1d969773a2mr512778ejr.93.1701892552689;
        Wed, 06 Dec 2023 11:55:52 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id gw16-20020a170906f15000b00a1e4558e450sm339289ejb.156.2023.12.06.11.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 11:55:52 -0800 (PST)
Date: Wed, 6 Dec 2023 21:55:50 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 6/6] net: dsa: mv88e6xxx: Add "rmon" counter
 group support
Message-ID: <20231206195550.4bf3qlybd3hoip5h@skbuf>
References: <20231205160418.3770042-1-tobias@waldekranz.com>
 <20231205160418.3770042-7-tobias@waldekranz.com>
 <20231206002225.nehk4htc4mozcq5b@skbuf>
 <87v89b91n2.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v89b91n2.fsf@waldekranz.com>

On Wed, Dec 06, 2023 at 09:27:29AM +0100, Tobias Waldekranz wrote:
> > I just noticed that this doesn't populate the TX counters, just RX.
> >
> > I haven't tried it, but I think the Histogram Mode bits (11:10) of the
> > Stats Operation Register might be able to control what gets reported for
> > the Set 4 of counters. Currently AFAICS, the driver always sets it to
> > MV88E6XXX_G1_STATS_OP_HIST_RX_TX, aka what gets reported to
> > "rx-rmon-etherStatsPkts64to64Octets" is actually an RX+TX counter.
> 
> You have a keen eye! Yes, that is what's happening.

It would be nice if my failure-prone keen eye had the safety net of a
selftest that catches this kind of stuff. After all, the ethtool
counters were standardized in order for us to be able to expect standard
behavior out of them, and for nonconformities to stand out easily.

Do you think (bearing in mind that the questions below might make the
rest irrelevant) that you could look into creating a minimal test in
tools/testing/selftests/net/forwarding and symlinking it to
tools/testing/selftests/drivers/net/dsa? You can start from
ethtool_std_stats_get() and take inspiration from the way in which it is
used by ethtool_mm.sh.

> > What's the story behind this?
> 
> I think the story starts, and ends, with this value being the hardware
> default.

I do hope that is where the story actually ends.

But the 88E6097 documentation I have suggests that the Histogram Mode
bits are reserved to the value of 3 (RX+TX), which suggests that this
cannot be written to any other value.

> Seeing as the hardware only has a single set of histogram counters,

"Seeing" means you tested this? calling chip->info->ops->stats_set_histogram()
at runtime, and seeing if the previously hidden histogram counters are
reset to zero, or if they show retroactively counted packets?

I searched through the git logs, but it's not exactly clear that this
was tried and doesn't work.

> it seems to me like we have to prioritize between:
> 
> 1. Keeping Rx+Tx: Backwards-compatible, but we can't export any histogram via
>    the standard RMON group.
> 
> 2. Move to Rx-only: We can export them via the RMON group, but we change
>    the behavior of the "native" counters.
> 
> 3. Move to Tx-only: We can export them via the RMON group, but we change
>    the behavior of the "native" counters.
> 
> Looking at RFC2819, which lays out the original RMON MIB, we find this
> description:
> 
>     etherStatsPkts64Octets OBJECT-TYPE
>         SYNTAX     Counter32
>         UNITS      "Packets"
>         MAX-ACCESS read-only
>         STATUS     current
>         DESCRIPTION
>             "The total number of packets (including bad
>             packets) received that were 64 octets in length
>             (excluding framing bits but including FCS octets)."
>         ::= { etherStatsEntry 14 }
> 
> In my opinion, this gives (2) a clear edge over (3), so we're down to
> choosing between (1) and (2). Personally, I lean towards (2), as I think
> it is more useful because:
> 
> - Most people will tend to assume that the histogram counters refers to
>   those defined in RFC2819 anyway
> 
> - It means we can deliver _something_ rather than nothing to someone
>   building an operating system, who is looking for a hardware
>   independent way of providing diagnostics

If the "reserved to 3" thing is true, then both (2) and (3) become
practically non-options, at least for 88E6097. The waters would be
further muddied if the driver were to make some chips use one
Histogram Mode, and other chips a different one. It implies that as
a user, you would need to know what switch family you have, before
you know what "ethtool -S lan0 | grep hist_64bytes" is counting!

