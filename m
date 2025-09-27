Return-Path: <netdev+bounces-226821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA23BBA568F
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 02:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657C66C0974
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273F418FDBE;
	Sat, 27 Sep 2025 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFHgR8ao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCE282E1;
	Sat, 27 Sep 2025 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758932364; cv=none; b=qoWFs9uL8o63AAwAEzGDt/mBVOuNFTYg/UnHAovGzflyMw4JXswISn9Zpi6UqdH4WOC9Z+3c4+e531Hkm0vuapS+fzRCeqP5/NulQM0dON2IjaB8VcwTJoSmxwLzo8XfyPCeG/YQYj96QBAvMu0P7T6sX/fnkVpDmaaMuh8mAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758932364; c=relaxed/simple;
	bh=xo08O522MhXZlHvp2m0GAnaYhho0L0iLrXTN+qE7XeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKDHxeGQ8Rd9Mywx3xqaU4pLJY/kML1+dNPbvv6UnfJ9cRDlSbGDPZpHkt4ogqpmH6HjrPbEZO1F93opFWXof2POY+q5FHuYQbBGzRRAs7aQvHRBSZbfG9ZS5LcOr0hfGc7rowouzjl4ixvwBnXGkkspo9FqTKmLndI6d5CYM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFHgR8ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EF3C4CEF4;
	Sat, 27 Sep 2025 00:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758932363;
	bh=xo08O522MhXZlHvp2m0GAnaYhho0L0iLrXTN+qE7XeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HFHgR8aoN0Wp4N2dJFIHWzffXiZzT8rlSf8SUZ2KBx0K02NaUJDpSUWTHu3R9kv1l
	 VaAJSe7rPKDw1jdZ1QihhrtTi3M2L3/dUJ+CSyYzcriqhpsfWwjswHHGRpFJh9+dQo
	 9XoR32pn4N4PMN1QywBQHmTlx4WBzHLpBkBNedrMzB3p1zIDL9XQ5F0iCWICzDYuiH
	 Pt7AfO8/C73P6owY2Ao57dEcbaDhHtGTm5XA2W/HAgif90ewb1PwbYqUuOMHHMBMD+
	 KxfnHtU2W0MzjojJ8igJtuAjNLubSXv10lHlUW3NIuZACn0Gv15RqgGT+6PXW9wUEY
	 +t/qNBRnUaSGQ==
Date: Fri, 26 Sep 2025 17:19:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Florian
 Fainelli <f.fainelli@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>, Donald
 Hunter <donald.hunter@gmail.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, Divya.Koppera@microchip.com, Sabrina Dubroca
 <sd@queasysnail.net>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v7 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20250926171921.7106b19b@kernel.org>
In-Reply-To: <20250924120241.724850-1-o.rempel@pengutronix.de>
References: <20250924120241.724850-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Sep 2025 14:02:41 +0200 Oleksij Rempel wrote:
>      name: pause-stat
> +    doc: Statistics counters for link-wide PAUSE frames (IEEE 802.3 Anne=
x 31B).
>      attr-cnt-name: __ethtool-a-pause-stat-cnt
> +    enum-name: ethtool-a-pause-stat

Naming attribute enums is relatively rare and kinda unnecessary TBH,
because the values are almost never held as state or passed around.
99.9% of the time we use the literals.

enums for actual enum attributes (the value is the enum) - sure,
enums for attr types - =F0=9F=A4=B7=EF=B8=8F

>          name: stats
> +        doc: |
> +          Contains the pause statistics counters. The source of these
> +          statistics is determined by stats-src.

I'd skip mentioning the source here TBH. Or we need to describe what
the MM is, shortly? I don't have recent embedded experience but I
thought MM is relatively rare. So mentioning it for a very common=20
attribute could confuse.

>          type: nest
>          nested-attributes: pause-stat
>        -
>          name: stats-src
> +        doc: |
> +          Selects the source of the MAC statistics, values from
> +          enum ethtool_mac_stats_src. This allows requesting statistics
> +          from the individual components of the MAC Merge layer.
>          type: u32
>    -
>      name: eee
> diff --git a/Documentation/networking/flow_control.rst b/Documentation/ne=
tworking/flow_control.rst
> new file mode 100644
> index 000000000000..48646d54513f
> --- /dev/null
> +++ b/Documentation/networking/flow_control.rst
> @@ -0,0 +1,373 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _ethernet-flow-control:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Ethernet Flow Control
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document is a practical guide to Ethernet Flow Control in Linux, co=
vering
> +what it is, how it works, and how to configure it.
> +
> +What is Flow Control?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Flow control is a mechanism to prevent a fast sender from overwhelming a
> +slow receiver with data, which would cause buffer overruns and dropped p=
ackets.
> +The receiver can signal the sender to temporarily stop transmitting, giv=
ing it
> +time to process its backlog.
> +
> +Standards references
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Ethernet flow control mechanisms are specified across consolidated IEEE =
base

nit:        Flow Control ?  we should be consistent

> +standards; some originated as amendments:
> +
> +- Collision-based flow control is part of CSMA/CD in **IEEE 802.3**
> +  (half-duplex).
> +- Link-wide PAUSE is defined in **IEEE 802.3 Annex 31B**
> +  (originally **802.3x**).
> +- Priority-based Flow Control (PFC) is defined in **IEEE 802.1Q Clause 3=
6**
> +  (originally **802.1Qbb**).
> +
> +In the remainder of this document, the consolidated clause numbers are u=
sed.
> +
> +How It Works: The Mechanisms
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +The method used for flow control depends on the link's duplex mode.
> +
> +.. note::
> +   The user-visible ``ethtool`` pause API described in this document con=
trols
> +   **link-wide PAUSE** (IEEE 802.3 Annex 31B) only. It does not control =
the
> +   collision-based behavior that exists on half-duplex links.

 ... or PFC ?

> +1. Half-Duplex: Collision-Based Flow Control
> +--------------------------------------------
> +On half-duplex links, a device cannot send and receive simultaneously, s=
o PAUSE
> +frames are not used. Flow control is achieved by leveraging the CSMA/CD
> +(Carrier Sense Multiple Access with Collision Detection) protocol itself.
> +
> +* **How it works**: To inhibit incoming data, a receiving device can for=
ce a
> +  collision on the line. When the sending station detects this collision=
, it
> +  terminates its transmission, sends a "jam" signal, and then executes t=
he
> +  "Collision backoff and retransmission" procedure as defined in IEEE 80=
2.3,
> +  Section 4.2.3.2.5. This algorithm makes the sender wait for a random
> +  period before attempting to retransmit. By repeatedly forcing collisio=
ns,
> +  the receiver can effectively throttle the sender's transmission rate.
> +
> +.. note::
> +    While this mechanism is part of the IEEE standard, there is currentl=
y no
> +    generic kernel API to configure or control it. Drivers should not en=
able
> +    this feature until a standardized interface is available.
> +
> +.. warning::
> +   On shared-medium networks (e.g. 10BASE2, or twisted-pair networks usi=
ng a
> +   hub rather than a switch) forcing collisions inhibits traffic **acros=
s the
> +   entire shared segment**, not just a single point-to-point link. Enabl=
ing
> +   such behavior is generally undesirable.
> +
> +2. Full-Duplex: Link-wide PAUSE (IEEE 802.3 Annex 31B)
> +------------------------------------------------------
> +On full-duplex links, devices can send and receive at the same time. Flow
> +control is achieved by sending a special **PAUSE frame**, defined by IEEE
> +802.3 Annex 31B. This mechanism pauses all traffic on the link and is th=
erefore
> +called *link-wide PAUSE*.
> +
> +* **What it is**: A standard Ethernet frame with a globally reserved
> +  destination MAC address (``01-80-C2-00-00-01``). This address is in a =
range
> +  that standard IEEE 802.1D-compliant bridges do not forward. However, s=
ome
> +  unmanaged or misconfigured bridges have been reported to forward these
> +  frames, which can disrupt flow control across a network.
> +
> +* **How it works**: The frame contains a MAC Control opcode for PAUSE
> +  (``0x0001``) and a ``pause_time`` value, telling the sender how long to
> +  wait before sending more data frames. This time is specified in units =
of
> +  "pause quantum", where one quantum is the time it takes to transmit 51=
2 bits.
> +  For example, one pause quantum is 51.2 microseconds on a 10 Mbit/s lin=
k,
> +  and 512 nanoseconds on a 1 Gbit/s link. A ``pause_time`` of zero indic=
ates
> +  that the transmitter can resume transmission, even if a previous non-z=
ero
> +  pause time has not yet elapsed.
> +
> +* **Who uses it**: Any full-duplex link, from 10 Mbit/s to multi-gigabit=
 speeds.
> +
> +3. Full-Duplex: Priority-based Flow Control (PFC) (IEEE 802.1Q Clause 36)
> +-------------------------------------------------------------------------
> +Priority-based Flow Control is an enhancement to the standard PAUSE mech=
anism
> +that allows flow control to be applied independently to different classe=
s of
> +traffic, identified by their priority level.

should we add .. specified in the 802.1Q VLAN tag ?

> +
> +* **What it is**: PFC allows a receiver to pause traffic for one or more=
 of the
> +  8 standard priority levels without stopping traffic for other prioriti=
es.
> +  This is critical in data center environments for protocols that cannot
> +  tolerate packet loss due to congestion (e.g., Fibre Channel over Ether=
net
> +  or RoCE).

nit: either

 FCoE and RoCE=20
   or
 Fibre Channel .. and RDMA over Converged ..

?

> +* **How it works**: PFC uses a specific PAUSE frame format. It shares th=
e same
> +  globally reserved destination MAC address (``01-80-C2-00-00-01``) as l=
egacy
> +  PAUSE frames but uses a unique opcode (``0x0101``). The frame payload
> +  contains two key fields:


> +Kernel Policy: "Set and Trust"
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +The ethtool pause API is defined as a **wish policy** for
> +IEEE 802.3 link-wide PAUSE only. A user request is always accepted
> +as the preferred configuration, but it may not be possible to apply
> +it in all link states.
> +
> +Key constraints:
> +
> +- Link-wide PAUSE is not valid on half-duplex links.
> +- Link-wide PAUSE cannot be used together with Priority-based Flow Contr=
ol
> +  (PFC, IEEE 802.1Q Clause 36).
> +- If autonegotiation is active and the link is currently down, the future
> +  mode is not yet known.
> +
> +Because of these constraints, the kernel stores the requested setting
> +and applies it only when the link is in a compatible state.
> +
> +Implications for userspace:
> +
> +1. Set once (the "wish"): the requested Rx/Tx PAUSE policy is
> +   remembered even if it cannot be applied immediately.
> +2. Applied conditionally: when the link comes up, the kernel enables
> +   PAUSE only if the active mode allows it.

IDK about this section and also ...

>  Keeping Close Tabs on the PAL
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index c869b7f8bce8..1f121108f236 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -931,9 +931,48 @@ struct kernel_ethtool_ts_info {
>   * @get_pause_stats: Report pause frame statistics. Drivers must not zero
>   *	statistics which they don't report. The stats structure is initialized
>   *	to ETHTOOL_STAT_NOT_SET indicating driver does not report statistics.
> - * @get_pauseparam: Report pause parameters
> - * @set_pauseparam: Set pause parameters.  Returns a negative error code
> - *	or zero.
> + *
> + * @get_pauseparam: Report the configured policy for link-wide PAUSE
> + *      (IEEE 802.3 Annex 31B). Drivers must fill struct ethtool_pausepa=
ram
> + *      such that:
> + *      @autoneg:
> + *              This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) =
only
> + *              and is independent of generic link autonegotiation confi=
gured
> + *              via ethtool -s.
> + *              true  -> the device follows the negotiated result of pau=
se
> + *                       autonegotiation (Pause/Asym);
> + *              false -> the device uses a forced MAC state independent =
of
> + *                       negotiation.
> + *      @rx_pause/@tx_pause:
> + *              represent the desired policy (preferred configuration).
> + *              In autoneg mode they describe what is to be advertised;

... this. IDK what you guys do in the Linux-managed code but the
convention for integrated devices is spelled out here:

/**
 * struct ethtool_pauseparam - Ethernet pause (flow control) parameters
 * @cmd: Command number =3D %ETHTOOL_GPAUSEPARAM or %ETHTOOL_SPAUSEPARAM
 * @autoneg: Flag to enable autonegotiation of pause frame use
 * @rx_pause: Flag to enable reception of pause frames
 * @tx_pause: Flag to enable transmission of pause frames
 *
 * Drivers should reject a non-zero setting of @autoneg when             <<=
< [1]
 * autoneogotiation is disabled (or not supported) for the link.         <<<
 *
 * If the link is autonegotiated, drivers should use
 * mii_advertise_flowctrl() or similar code to set the advertised
 * pause frame capabilities based on the @rx_pause and @tx_pause flags,
 * even if @autoneg is zero.  They should also allow the advertised
 * pause frame capabilities to be controlled directly through the
 * advertising field of &struct ethtool_cmd.
 *
 * If @autoneg is non-zero, the MAC is configured to send and/or
 * receive pause frames according to the result of autonegotiation.
 * Otherwise, it is configured directly based on the @rx_pause and
 * @tx_pause flags.
 */

Doesn't [1] contradict your description of kernel "storing the config"?
Also you're not reflecting this in the help for the set op..

