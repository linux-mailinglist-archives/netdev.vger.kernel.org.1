Return-Path: <netdev+bounces-214947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D2EB2C429
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B77722B71
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3818F33A017;
	Tue, 19 Aug 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KeaDq9L2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33132BF50;
	Tue, 19 Aug 2025 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607723; cv=none; b=OfF4uMhIASRMCrG1GaOPSg5ggjt8flq+G0CIgYOulXB0fxQJhdGjcYbCODIQSh7uvlGkclG9wiXkty8LTde6pCJ0nHXpRdoEWJ7QMVFuCZkY5cIXI2K1jUg4Iu2wL28gJQ3TzlMSBsyedyhr4RNxNdfvB91dwaAn9/IT46hRD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607723; c=relaxed/simple;
	bh=QjRpBIr7c2O2cNL0Gcdda8NWuFGgy/5eWwpl9ucO4CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDdnOzNG8FKzcWfGFC29DGw0jjb/jmUFE17VHC/7NpiEuDiqaizL/YWA9vflefgvJ4Ef1LlBfvBSIWWoNN5uIaRSH5aJwWJ34EJ2NsT/j76y8hBngCMPR7Y9FRYzllePbdceyPGs6s/u8/kMqBMeHjw0wpoIXVxCeRB20Hs12Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KeaDq9L2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jLovAImo8mjSXVZtWgxNx5e1lXDqwk4ph1JlCCNTfU8=; b=KeaDq9L277bpa8rbAU8wtgoGsW
	f0fy/Yoo+8/o8mMchi/3/O+RByIk5bQX3UW3OBgBN0D9fSnfIDkEloJwFnCIrE9lwfp1gUqws9ZD0
	L6dQ9gRDnCNfBYtLLLPJVwS6x0KrzVuBaduiLH9q4rXqmUVzRKpumCO7RqM/RELXpiXo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoLlG-005BkU-DZ; Tue, 19 Aug 2025 14:48:22 +0200
Date: Tue, 19 Aug 2025 14:48:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Divya.Koppera@microchip.com
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: add detailed
 guide on Ethernet flow control configuration
Message-ID: <36bdd275-25bb-4b53-a14d-39677da468cc@lunn.ch>
References: <20250814075342.212732-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814075342.212732-1-o.rempel@pengutronix.de>

> +2. Half-Duplex: Collision-Based Flow Control
> +--------------------------------------------
> +On half-duplex links, a device cannot send and receive simultaneously, so PAUSE
> +frames are not used. Flow control is achieved by leveraging the CSMA/CD
> +(Carrier Sense Multiple Access with Collision Detection) protocol itself.
> +
> +* **How it works**: To inhibit incoming data, a receiving device can force a
> +    collision on the line. When the sending station detects this collision, it
> +    terminates its transmission, sends a "jam" signal, and then executes the
> +    "Collision backoff and retransmission" procedure as defined in IEEE 802.3,
> +    Section 4.2.3.2.5. This algorithm makes the sender wait for a random
> +    period before attempting to retransmit. By repeatedly forcing collisions,
> +    the receiver can effectively throttle the sender's transmission rate.
> +
> +.. note::
> +    While this mechanism is part of the IEEE standard, there is currently no
> +    generic kernel API to configure or control it. Drivers should not enable
> +    this feature until a standardized interface is available.

Interesting. I did not know about this.

I wounder if we want phylib and phylink to return -EOPNOTSUPP in the
general code, if the current link is 1/2 duplex?

It might be considered an ABI change. I guess the generic code
currently stores the settings and only puts them into effect when the
link changes to full duplex?

> +
> +Configuring Flow Control with `ethtool`
> +=======================================
> +
> +The standard tool for managing flow control is `ethtool`.
> +
> +Viewing the Current Settings
> +----------------------------
> +Use `ethtool -a <interface>` to see the current configuration.
> +
> +.. code-block:: text
> +
> +  $ ethtool -a eth0
> +  Pause parameters for eth0:
> +  Autonegotiate:  on
> +  RX:             on
> +  TX:             on
> +
> +* **Autonegotiate**: Shows if flow control settings are being negotiated with
> +    the link partner.
> +
> +* **RX**: Shows if we will *obey* PAUSE frames (pause our sending).
> +
> +* **TX**: Shows if we will *send* PAUSE frames (ask the peer to pause).
> +
> +If autonegotiation is on, `ethtool` will also show the active, negotiated result.
> +This result is calculated by `ethtool` itself based on the advertisement masks
> +from both link partners. It represents the expected outcome according to IEEE
> +802.3 rules, but the final decision on what is programmed into the MAC hardware
> +is made by the kernel driver.
> +
> +.. code-block:: text
> +
> +  RX negotiated: on
> +  TX negotiated: on

Maybe add a description of what happens if Pause Auto negotiation is
off?

Also, one of the common errors is mixing up Pause Autoneg and Autoneg
in general. Pause Autoneg can be off while generic Autoneg is on.

And if i remember correctly, with phylink, if generic Autoneg is off,
but pause Autoneg is on, the settings are saved until generic Autoneg
is enabled.

> +
> +Changing the Settings
> +---------------------
> +Use `ethtool -A <interface>` to change the settings.
> +
> +.. code-block:: bash
> +
> +  # Enable RX and TX pause, with autonegotiation
> +  ethtool -A eth0 autoneg on rx on tx on
> +
> +  # Force RX pause on, TX pause off, without autonegotiation
> +  ethtool -A eth0 autoneg off rx on tx off
> +
> +**Key Configuration Concepts**:
> +
> +* **Autonegotiation Mode**: The driver programs the PHY to *advertise* the
> +    `rx` and `tx` capabilities. The final active state is determined by what
> +    both sides of the link agree on.
> +
> +    .. note::
> +        The negotiated outcome may not match the requested configuration. For
> +        example, if you request asymmetric flow control (e.g., `rx on` `tx off`)
> +        but the link partner only supports symmetric pause, the result could be
> +        symmetric pause (`rx on` `tx on`). Conversely, if you request symmetric
> +        pause but the partner only supports asymmetric, flow control may be
> +        disabled entirely. Refer to the resolution table in the PHY section
> +        for the exact negotiation logic.

Maybe define symmetric and asymmetric pause earlier? At the moment the
definitions are buried in this text, so not easy to find.

> +
> +* **Forced Mode**: This mode is necessary when autonegotiation is not used or
> +    not possible. This includes links where one or both partners have
> +    autonegotiation disabled, or in setups without a PHY (e.g., direct
> +    MAC-to-MAC connections). The driver bypasses PHY advertisement and
> +    directly forces the MAC into the specified `rx`/`tx` state. The
> +    configuration on both sides of the link must be complementary. For
> +    example, if one side is set to `tx on` `rx off`, the link partner must be
> +    set to `tx off` `rx on` for flow control to function correctly.
> +
> +Component Roles in Flow Control
> +===============================
> +
> +The configuration of flow control involves several components, each with a
> +distinct role.
> +
> +The MAC (Media Access Controller)
> +---------------------------------
> +The MAC is the hardware component that actually sends and receives PAUSE
> +frames. Its capabilities define the upper limit of what the driver can support.
> +Known MAC implementation variations include:
> +
> +* **Flexible Full Flow Control**: Has separate enable/disable controls for the
> +    TX and RX paths. This is the most common and desirable implementation.
> +
> +* **Symmetric-Only Flow Control**: Provides a single control bit to
> +    enable/disable flow control in both directions simultaneously. It cannot
> +    support asymmetric configurations.

Since you talk about Symmetric in this bullet point, maybe mention
Asymmetric in the previous?

> +
> +* **Receive-Only Flow Control**: Can only process incoming PAUSE frames (to
> +    pause its own transmitter). It cannot generate PAUSE frames. If the system
> +    needs to send a PAUSE frame, it would have to be generated by software.
> +
> +* **Transmit-Only Flow Control**: Can only generate PAUSE frames when its own
> +    buffers are full. It ignores incoming PAUSE frames.
> +
> +* **Weak Overwrite Variant**: Often found in combined MAC+PHY chips. A single
> +    control bit determines whether the MAC uses the autonegotiated result or
> +    a forced, pre-defined setting.
> +
> +Additionally, some MACs provide a way to configure the `pause_time` value
> +(quanta) sent in PAUSE frames. This value's duration depends on the link
> +speed. As there is currently no generic kernel interface to configure this,
> +drivers often set it to a default or maximum value, which may not be optimal
> +for all use cases.

The Mellanox driver has something in this space. It is a long time ago
that i reviewed the patches. I don't remember if it is a pause_time
you can configure, or the maximum number of pause frames you can send
before giving up and just letting the buffers overflow. I also don't
remember what API is used, if it is something custom, or generic. It
is a bit of a niche thing, so maybe it is not worth researching and
mentioning.

> +
> +Many MACs also implement automatic PAUSE frame transmission based on the fill
> +level of their internal RX FIFO. This is typically configured with two
> +thresholds:
> +
> +* **FLOW_ON (High Water Mark)**: When the RX FIFO usage reaches this
> +    threshold, the MAC automatically transmits a PAUSE frame to stop the sender.
> +
> +* **FLOW_OFF (Low Water Mark)**: When the RX FIFO usage drops below this
> +    threshold, the MAC transmits a PAUSE frame with a quanta of zero to tell
> +    the sender it can resume transmission.
> +
> +The optimal values for these thresholds often depend on the bandwidth of the
> +bus between the MAC and the system's CPU or RAM. Like the pause quanta, there
> +is currently no generic kernel interface for tuning these thresholds.
> +
> +The PHY (Physical Layer Transceiver)
> +------------------------------------
> +The PHY's role is to manage the autonegotiation process. It does not generate
> +or interpret PAUSE frames itself; it only communicates capabilities between
> +the two link partners.
> +
> +* **Advertisement**: The PHY advertises the MAC's flow control capabilities.
> +    This is done using two bits in the advertisement register: "Symmetric
> +    Pause" (Pause) and "Asymmetric Pause" (Asym). These bits should be
> +    interpreted as a combined value, not as independent flags. The kernel
> +    converts the user's `rx` and `tx` settings into this two-bit value as
> +    follows:
> +
> +    .. code-block:: text
> +
> +        tx rx  | Pause Asym
> +        -------+-----------
> +        0  0  |  0     0
> +        0  1  |  1     1
> +        1  0  |  0     1
> +        1  1  |  1     0

The divider | don't line up between the header and the body.

> +
> +* **Resolution**: After negotiation, the PHY reports the link partner's
> +    advertised Pause and Asym bits. The final flow control mode is determined
> +    by the combination of the local and partner advertisements, according to
> +    the IEEE 802.3 standard:
> +
> +    .. code-block:: text
> +
> +        Local Device | Link Partner |
> +        Pause Asym   | Pause Asym   | Result
> +        -------------+--------------+-----------
> +          0     X    |   0     X    | Disabled
> +          0     1    |   1     0    | Disabled
> +          0     1    |   1     1    | TX only
> +          1     0    |   0     X    | Disabled
> +          1     X    |   1     X    | TX + RX
> +          1     1    |   0     1    | RX only
> +
> +    It is important to note that the advertised bits reflect the *current
> +    configuration* of the MAC, which may not represent its full hardware
> +    capabilities.
> +
> +* **Limitations**: A PHY may have its own limitations and may not be able to
> +    advertise the full set of capabilities that the MAC supports.
> +
> +User Space Interface
> +--------------------
> +The primary user space tool for flow control configuration is `ethtool`. It
> +communicates with the kernel via netlink messages, specifically
> +`ETHTOOL_MSG_PAUSE_GET` and `ETHTOOL_MSG_PAUSE_SET`.
> +
> +These messages use a simple set of attributes that map to the members of the
> +`struct ethtool_pauseparam`:
> +
> +* `ETHTOOL_A_PAUSE_AUTONEG` -> `autoneg`
> +* `ETHTOOL_A_PAUSE_RX` -> `rx_pause`
> +* `ETHTOOL_A_PAUSE_TX` -> `tx_pause`
> +
> +The driver's implementation of the `.get_pauseparam` and `.set_pauseparam`
> +ethtool operations must correctly interpret these fields.
> +
> +* **On `get_pauseparam`**, the driver must report the user's configured flow
> +    control policy.
> +
> +    * The `autoneg` flag indicates the driver's behavior: if `on`, the driver
> +      will respect the negotiated outcome; if `off`, the driver will use a
> +      forced configuration.

Maybe add something that this reflects only Pause Autoneg. Generic
autoneg should not be considered when filling out this field.

> +
> +    * The `rx_pause` and `tx_pause` flags reflect the currently preferred
> +      configuration state, which depends on multiple factors.
> +
> +* **On `set_pauseparam`**, the driver must interpret the user's request:
> +
> +    * The `autoneg` flag acts as a mode selector. If `on`, the driver
> +      configures the PHY's advertisement based on `rx_pause` and `tx_pause`.
> +
> +    * If `off`, the driver forces the MAC into the state defined by
> +      `rx_pause` and `tx_pause`.
> +
> +Monitoring Flow Control
> +=======================
> +
> +The standard way to check if flow control is actively being used is to view the
> +pause-related statistics with the command:
> +``ethtool --include-statistics -a <interface>``
> +
> +.. code-block:: text
> +
> +  $ ethtool --include-statistics -a eth0
> +  Pause parameters for eth0:
> +  Autonegotiate:  on
> +  RX:             on
> +  TX:             on
> +  RX negotiated: on
> +  TX negotiated: on
> +  Statistics:
> +    tx_pause_frames: 0
> +    rx_pause_frames: 0
> +
> +The `tx_pause_frames` and `rx_pause_frames` counters show the number of PAUSE
> +frames sent and received. Non-zero or increasing values indicate that flow
> +control is active.
> +
> +If a driver does not support this standard statistics interface, it may expose
> +its own legacy counters via `ethtool -S <interface>`. The names of these
> +counters are driver-implementation specific.

Nice work, good to see some documentation on this, because so many
driver developers get this wrong.

	Andrew

