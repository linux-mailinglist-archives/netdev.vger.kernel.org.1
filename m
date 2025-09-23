Return-Path: <netdev+bounces-225496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A495BB94C9B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EC01902D1B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04EB30F940;
	Tue, 23 Sep 2025 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg7SaUn4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65962E7F30;
	Tue, 23 Sep 2025 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612695; cv=none; b=rvyMEj7x9m4iy5i6eLuZsdL8EuQLCctPClJNJLHd/w4rrWJyCT35FIrrZBLPiPPXmISQ50Omp5wrIIwszJVgQrb0VW4XW2eANb0B5LW5JPI7hbi1cQzZiuqkTupfkGmwVHlOY+G7B3k7S55jqUtkznz36dINNZQQaPnHqIsUwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612695; c=relaxed/simple;
	bh=OZ3KgbdB+Q5onuycNUzgfOP/P+g//1x2G/mTz9EqRFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU+I1icU18NNPWYHqVwqHlHnYtRYdma+Y2Lg4875ePOIdFoPX4p/dCTfKjDDss9aH4y3+DL7tfQzCwHz7NhGHMoofNklhJoMPBQ/pzUYgXm4yuLPIOWYEG+VH9ImQPTWCN5pT+ctIQLLCdvHF0X/SAWOMJfwfVG8jeo6/OhlUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg7SaUn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1272C4CEF5;
	Tue, 23 Sep 2025 07:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758612695;
	bh=OZ3KgbdB+Q5onuycNUzgfOP/P+g//1x2G/mTz9EqRFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qg7SaUn4m6D4w+ipeevEIX8mDFrCY2bQc2Ep5qh6kvf73amNB/FWfsZxusjlbq6oG
	 T9MoycaE2i4jsuQ761wBggNlnGRG191a539dDOHvdf8qj5KkNvYyzdcoSZDC3vGBIv
	 He01kO4iEpx2lxVMNYjKX5ShqNGwhJsxUxvzwLvz5L//r4thSWhQ5A98/QEk+NWbNf
	 e1PGjwx0+Sh4oYXQL8sYohroQWTbhBLcPApyf0+biRspzFv39xv03Sfa3L6NPlDx7R
	 idkSlN415ZRipFZdk19O7Zv/5eKRynphO6Gpvoz6XkupITKvzx/mPZVzxJkWlmUlw5
	 99RpJ3HX7ehwQ==
Date: Tue, 23 Sep 2025 08:31:27 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v6 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20250923073127.GC836419@horms.kernel.org>
References: <20250922112123.3072398-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922112123.3072398-1-o.rempel@pengutronix.de>

On Mon, Sep 22, 2025 at 01:21:23PM +0200, Oleksij Rempel wrote:

...

> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 7a7594713f1f..7587a00af49d 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -864,7 +864,9 @@ attribute-sets:
>  
>    -
>      name: pause-stat
> +    doc: Statistics counters for link-wide PAUSE frames (IEEE 802.3 Annex 31B).
>      attr-cnt-name: __ethtool-a-pause-stat-cnt
> +    enum-name: ethtool-a-pause-stat
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
> +    enum-name: ethtool-a-pause
>      attributes:
>        -
>          name: unspec

Hi Oleksij,

I believe it is due to the enum-name changes above, but in any case
this patch alters the output produced by tools/net/ynl/ynl-regen.sh -f
and those changes need to be included in this commit (or the commit changes
so the out put of ynl-gregen.sh is unchanged).

In short, in it's current form, this commit seems to be missing:

diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index e3b881346..4a8eec944 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -375,7 +375,7 @@ enum {
 	ETHTOOL_A_COALESCE_MAX = (__ETHTOOL_A_COALESCE_CNT - 1)
 };

-enum {
+enum ethtool_a_pause_stat {
 	ETHTOOL_A_PAUSE_STAT_UNSPEC,
 	ETHTOOL_A_PAUSE_STAT_PAD,
 	ETHTOOL_A_PAUSE_STAT_TX_FRAMES,
@@ -385,7 +385,7 @@ enum {
 	ETHTOOL_A_PAUSE_STAT_MAX = (__ETHTOOL_A_PAUSE_STAT_CNT - 1)
 };

-enum {
+enum ethtool_a_pause {
 	ETHTOOL_A_PAUSE_UNSPEC,
 	ETHTOOL_A_PAUSE_HEADER,
 	ETHTOOL_A_PAUSE_AUTONEG,

-- 
pw-bot: changes-requested

