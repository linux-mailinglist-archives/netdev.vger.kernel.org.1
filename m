Return-Path: <netdev+bounces-221268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F1BB4FF71
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61197A81E4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8248135207F;
	Tue,  9 Sep 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dabVAen/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF17350D5B;
	Tue,  9 Sep 2025 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428214; cv=none; b=VIHPnKV/ibaZuFj8nGTUuCIRvsEmW/giZbtWL7PlvpkcpIN7mzEk+PPChDz4+3OubwB2+iMR5PsgcGZX3XzB0VpArGFtUmAN9+aM3jOOhzQ+qrrE3H3GdrEBzc7moYX6IUwsaYNoQYVw3iZ6ApToTQQ7dXHoqZGgZ0zAmSynoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428214; c=relaxed/simple;
	bh=c7SVtzoWzABlv/zMsiLMvKb42CmJ+eWIwn3h1VoDDZE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=DgjtrmsnVl/tLpQHcbIbR6d5KOmtOrOUX6IsVf0YD2XhsUe+UPlFxEXh+SOulDoplvzHf1/wX9/vO2ZlJHzYIgblV78yeLi0b/a9dKX5mFR2gRhAUA0XdM+aZxz5K0f8oluhryD++k+mwYpajNNSVW/7fVgUGXQ/hwwfbvuMusU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dabVAen/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45de1084868so14674625e9.2;
        Tue, 09 Sep 2025 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757428211; x=1758033011; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8I3hx8yBen1QoV+Bs9/tRQiMKM7cZp14Q89arW42jUU=;
        b=dabVAen/s2K6wVIQ26OHST9dBFPltHrtlMvHxDK3y+thSOo4lpLTMJiefli5ksY0aA
         hnuThdY+egE0DSpwC3vim5f4FWehL9LyK7YzFQh0Q5h1XLVsvGICsC9+/rKiFrTKH98y
         B3r8lQwV94vZRJgfAbg8TCUYKZcHKEZkijutz23o2Lq1B3UpprQMcMDgcY4m8+psN9Mb
         fKuhQ+ykYFq6iSfPpxVvnR4y3VrvByZVKAaBDpoKJ6u5TXgcpiyhea5CD1J8l1oW8LLq
         bnjsPHFQBzLnqreDnFi+SMkNWpwAr0dIAqyARX1HhI1nJ9wBpAyjSQHea73gNbUopTOL
         YTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428211; x=1758033011;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I3hx8yBen1QoV+Bs9/tRQiMKM7cZp14Q89arW42jUU=;
        b=lJmD9z3el0NjBB+vxOayPghWHBZCEN0pDdmJbDO3wlM9zG1xSImTThLKN9VAMtMFBm
         1sLagSQKpl985J3Zb5ZYjrhvw4L0BNBmXZ7nbSJIeR6Oj3DZPATx1awdIlXrdDkyLIfy
         s2EjccFbGecFZBsRCFypsHOz2i8X6tgXq/6huX+gjW+8PWTDoqn+F8wa+x8QzJCQSeNC
         JTDSsXX7UDMpHOlZP33jNVKnMzlBTONP6mC1AVnG73K5YJPph6sYm1steHqZvSTyLbKk
         Bgz+xodE0GQjZ7CgABgJzue9unjxmQy6+GmxnXYrXowUpLhDCdD3yl4qjwARt41npx2A
         8K8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7x3Oc4OR0Gx2dlafqX9D1Fp7WrAxAO6DyzJFFgwPtboUo9gxCBMD2ZB99OirjxMPKGXGoThlJ@vger.kernel.org, AJvYcCVq9JtLGlhVCJIk4k854aeMEZnlfqF8kyPw3Wsvia/WMjLzAwXVKIwfummJyQOUK9k+0GWV7rYQELw75C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywB+loS0Gl/0YwvBkFu1j1B+c+g0LrKeVL+nAIuP74F8ZfZWKu
	2DZnhfSw9E9Q81IfdiAJPsdgLVsfLUWGpaad5gTSE6dnPWvEwwvoy6NP
X-Gm-Gg: ASbGncvnA/LRyTURRbrqHG5P/iLkQyDHEq/goMWLEPSQTaJvELz3sBadnJkVKwNHdTl
	olzCU8WytYFLWtl9wk+DEkGZZm+DjoyH2fv5ntXFzBlcWXaAU66QvqOeP0hwHtEza+Vl5DdDag8
	E0hybi+FPFvMJrcoejA9gaz5u/UJrc4mZqznrjONsV47K/1DxwhPB5tpVKdecyG3hTYHxBKyQDw
	Mk/KGWzb55KWig6pa7glxRl5q2alUu5zpSIFUSaBdbet/63o2r2kD6C8jHLrsjes7OV3q3q59dK
	PxT1A6k32jtHEantrSYe8WArR9vo9zpurGZiwfwCRzdjNqWezfSN9u9I3pKXxze1pt9KQuE9c/Q
	ix7BdnSRikImDbX/s0sfSVdLidsfV6t6ERmMmom2V8cM9
X-Google-Smtp-Source: AGHT+IHR5l979B79NbMe65A4mPM9Fviu9z/x55j0nzmfde8OhVabDkZArKfVnoUVBgHs1EYczL1keg==
X-Received: by 2002:a05:600c:1912:b0:456:1560:7c5f with SMTP id 5b1f17b1804b1-45de24704ccmr80018385e9.14.1757428210416;
        Tue, 09 Sep 2025 07:30:10 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:837:bf58:2f3c:aa2c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45ddf1765e8sm152400475e9.22.2025.09.09.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:30:10 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>,  Heiner Kallweit <hkallweit1@gmail.com>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Florian Fainelli <f.fainelli@gmail.com>,  Maxime
 Chevallier <maxime.chevallier@bootlin.com>,  Kory Maincent
 <kory.maincent@bootlin.com>,  Lukasz Majewski <lukma@denx.de>,  Jonathan
 Corbet <corbet@lwn.net>,  Vadim Fedorenko <vadim.fedorenko@linux.dev>,
  Jiri Pirko <jiri@resnulli.us>,  Vladimir Oltean
 <vladimir.oltean@nxp.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,
  kernel@pengutronix.de,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  Russell King <linux@armlinux.org.uk>,
  Divya.Koppera@microchip.com,  Sabrina Dubroca <sd@queasysnail.net>,
  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v4 3/3] Documentation: net: add flow control
 guide and document ethtool API
In-Reply-To: <20250909072212.3710365-4-o.rempel@pengutronix.de>
Date: Tue, 09 Sep 2025 15:29:53 +0100
Message-ID: <m2ikhrk8bi.fsf@gmail.com>
References: <20250909072212.3710365-1-o.rempel@pengutronix.de>
	<20250909072212.3710365-4-o.rempel@pengutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oleksij Rempel <o.rempel@pengutronix.de> writes:

> Introduce a new document, flow_control.rst, to provide a comprehensive
> guide on Ethernet Flow Control in Linux. The guide explains how flow
> control works, how autonegotiation resolves pause capabilities, and how
> to configure it using ethtool and Netlink.
>
> In parallel, document the pause and pause-stat attributes in the
> ethtool.yaml netlink spec. This enables the ynl tool to generate
> kernel-doc comments for the corresponding enums in the UAPI header,
> making the C interface self-documenting.
>
> Finally, replace the legacy flow control section in phy.rst with a
> reference to the new document and add pointers in the relevant C source
> files.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v4:
> - Reworded pause stats-src doc: clarify that sources are MAC Merge layer
>   components, not PHYs.
> - Fixed non-ASCII dash in "Link-wide".
> - Added explicit note that pause_time = 0 resumes transmission immediately.
> - Corrected terminology: use "pause quantum" (singular) consistently.
> - Dropped paragraph about user tuning of FIFO watermarks (no ABI support).
> - Synced UAPI header comments with YAML wording (MAC Merge layer).
> - Ran ASCII sweep to remove stray non-ASCII characters.
> changes v3:
> - add warning about half-duplex collision-based flow control on shared media
> - clarify pause autoneg vs. generic autoneg and forced mode semantics
> - document pause quanta defaults used by common MAC drivers, with time examples
> - fix vague cross-reference, point to autonegotiation resolution section
> - expand notes on PAUSE vs. PFC exclusivity
> - include generated enums (pause / pause-stat) in UAPI with kernel-doc
> changes v2:
> - remove recommendations
> - add note about autoneg resolution
> ---
>  Documentation/netlink/specs/ethtool.yaml      |  27 ++
>  Documentation/networking/flow_control.rst     | 373 ++++++++++++++++++
>  Documentation/networking/index.rst            |   1 +
>  Documentation/networking/phy.rst              |  12 +-
>  include/linux/ethtool.h                       |  45 ++-
>  .../uapi/linux/ethtool_netlink_generated.h    |  28 +-
>  net/dcb/dcbnl.c                               |   2 +
>  net/ethtool/pause.c                           |   4 +
>  8 files changed, 477 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/networking/flow_control.rst
>
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 7a7594713f1f..c3f6a9af6f08 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -864,7 +864,9 @@ attribute-sets:
>  
>    -
>      name: pause-stat
> +    doc: Statistics counters for link-wide PAUSE frames (IEEE 802.3 Annex 31B).
>      attr-cnt-name: __ethtool-a-pause-stat-cnt
> +    enum-name: ethtool_a_pause_stat

Please use - instead of _ in all names in ynl specs. See existing
enum-name: entries in ethtool.yaml

>      attributes:
>        -
>          name: unspec
> @@ -875,13 +877,17 @@ attribute-sets:
>          type: pad
>        -
>          name: tx-frames
> +        doc: Number of PAUSE frames transmitted.
>          type: u64
>        -
>          name: rx-frames
> +        doc: Number of PAUSE frames received.
>          type: u64
>    -
>      name: pause
> +    doc: Parameters for link-wide PAUSE (IEEE 802.3 Annex 31B).
>      attr-cnt-name: __ethtool-a-pause-cnt
> +    enum-name: ethtool_a_pause

Also here.


