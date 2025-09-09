Return-Path: <netdev+bounces-221087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35588B4A36A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B06C4E2923
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65568303A11;
	Tue,  9 Sep 2025 07:22:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7A2FF64E
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402578; cv=none; b=MhI1NQHeZ0l3L4IXp6h/g/Dlkh2WV29srZJ400mhMP3dHGTEZrsSIonAH9BgYuRTnFSWuigbsUd8fegygl8RZ3+sQQ3M3XAu48slNFAWDZ4pMhDVQqGmPiStEWT/bdIe++vXKUV57Jzr5fv8Arir7IBmdZt8/gXHaPa1G0sKfvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402578; c=relaxed/simple;
	bh=bmDgtOGY5YycLdgZsnB7aHuvsPWcEckeSU9obPqsbXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBJcyptY7b2EV5uaA+Y9pLVDTcrZU5peLohyiZD4cCKVdcRMSW1Sbbwfjg3NWE5ljvWqg1Y8QoHXV5pKPVK7vi5o8unXoVHduE8w3R9wsVtzQYZVREzIGB5xyrfW+92zGHwykcnFc1rsFwMmhcp/uuZKIOfZSnG6FMU7+Uuqhik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsgF-0004gr-KN; Tue, 09 Sep 2025 09:22:19 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsgA-000NlS-0D;
	Tue, 09 Sep 2025 09:22:14 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsg9-0000000FZFr-3wIQ;
	Tue, 09 Sep 2025 09:22:13 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v4 3/3] Documentation: net: add flow control guide and document ethtool API
Date: Tue,  9 Sep 2025 09:22:12 +0200
Message-ID: <20250909072212.3710365-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909072212.3710365-1-o.rempel@pengutronix.de>
References: <20250909072212.3710365-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Introduce a new document, flow_control.rst, to provide a comprehensive
guide on Ethernet Flow Control in Linux. The guide explains how flow
control works, how autonegotiation resolves pause capabilities, and how
to configure it using ethtool and Netlink.

In parallel, document the pause and pause-stat attributes in the
ethtool.yaml netlink spec. This enables the ynl tool to generate
kernel-doc comments for the corresponding enums in the UAPI header,
making the C interface self-documenting.

Finally, replace the legacy flow control section in phy.rst with a
reference to the new document and add pointers in the relevant C source
files.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v4:
- Reworded pause stats-src doc: clarify that sources are MAC Merge layer
  components, not PHYs.
- Fixed non-ASCII dash in "Link-wide".
- Added explicit note that pause_time = 0 resumes transmission immediately.
- Corrected terminology: use "pause quantum" (singular) consistently.
- Dropped paragraph about user tuning of FIFO watermarks (no ABI support).
- Synced UAPI header comments with YAML wording (MAC Merge layer).
- Ran ASCII sweep to remove stray non-ASCII characters.
changes v3:
- add warning about half-duplex collision-based flow control on shared media
- clarify pause autoneg vs. generic autoneg and forced mode semantics
- document pause quanta defaults used by common MAC drivers, with time examples
- fix vague cross-reference, point to autonegotiation resolution section
- expand notes on PAUSE vs. PFC exclusivity
- include generated enums (pause / pause-stat) in UAPI with kernel-doc
changes v2:
- remove recommendations
- add note about autoneg resolution
---
 Documentation/netlink/specs/ethtool.yaml      |  27 ++
 Documentation/networking/flow_control.rst     | 373 ++++++++++++++++++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/phy.rst              |  12 +-
 include/linux/ethtool.h                       |  45 ++-
 .../uapi/linux/ethtool_netlink_generated.h    |  28 +-
 net/dcb/dcbnl.c                               |   2 +
 net/ethtool/pause.c                           |   4 +
 8 files changed, 477 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/networking/flow_control.rst

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 7a7594713f1f..c3f6a9af6f08 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -864,7 +864,9 @@ attribute-sets:
 
   -
     name: pause-stat
+    doc: Statistics counters for link-wide PAUSE frames (IEEE 802.3 Annex 31B).
     attr-cnt-name: __ethtool-a-pause-stat-cnt
+    enum-name: ethtool_a_pause_stat
     attributes:
       -
         name: unspec
@@ -875,13 +877,17 @@ attribute-sets:
         type: pad
       -
         name: tx-frames
+        doc: Number of PAUSE frames transmitted.
         type: u64
       -
         name: rx-frames
+        doc: Number of PAUSE frames received.
         type: u64
   -
     name: pause
+    doc: Parameters for link-wide PAUSE (IEEE 802.3 Annex 31B).
     attr-cnt-name: __ethtool-a-pause-cnt
+    enum-name: ethtool_a_pause
     attributes:
       -
         name: unspec
@@ -893,19 +899,40 @@ attribute-sets:
         nested-attributes: header
       -
         name: autoneg
+        doc: |
+          Acts as a mode selector for the driver.
+          On GET: indicates the driver's behavior. If true, the driver will
+          respect the negotiated outcome; if false, the driver will use a
+          forced configuration.
+          On SET: if true, the driver configures the PHY's advertisement based
+          on the rx and tx attributes. If false, the driver forces the MAC
+          into the state defined by the rx and tx attributes.
         type: u8
       -
         name: rx
+        doc: |
+          Enable receiving PAUSE frames (pausing local TX).
+          On GET: reflects the currently preferred configuration state.
         type: u8
       -
         name: tx
+        doc: |
+          Enable transmitting PAUSE frames (pausing peer TX).
+          On GET: reflects the currently preferred configuration state.
         type: u8
       -
         name: stats
+        doc: |
+          Contains the pause statistics counters. The source of these
+          statistics is determined by stats-src.
         type: nest
         nested-attributes: pause-stat
       -
         name: stats-src
+        doc: |
+          Selects the source of the MAC statistics, values from
+          enum ethtool_mac_stats_src. This allows requesting statistics
+          from the individual components of the MAC Merge layer.
         type: u32
   -
     name: eee
diff --git a/Documentation/networking/flow_control.rst b/Documentation/networking/flow_control.rst
new file mode 100644
index 000000000000..e1aa132fcb98
--- /dev/null
+++ b/Documentation/networking/flow_control.rst
@@ -0,0 +1,373 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _ethernet-flow-control:
+
+=====================
+Ethernet Flow Control
+=====================
+
+This document is a practical guide to Ethernet Flow Control in Linux, covering
+what it is, how it works, and how to configure it.
+
+What is Flow Control?
+=====================
+
+Flow control is a mechanism to prevent a fast sender from overwhelming a
+slow receiver with data, which would cause buffer overruns and dropped packets.
+The receiver can signal the sender to temporarily stop transmitting, giving it
+time to process its backlog.
+
+Standards references
+====================
+
+Ethernet flow control mechanisms are specified across consolidated IEEE base
+standards; some originated as amendments:
+
+- Collision-based flow control is part of CSMA/CD in **IEEE 802.3**
+  (half-duplex).
+- Link-wide PAUSE is defined in **IEEE 802.3 Annex 31B**
+  (originally **802.3x**).
+- Priority-based Flow Control (PFC) is defined in **IEEE 802.1Q Clause 36**
+  (originally **802.1Qbb**).
+
+In the remainder of this document, the consolidated clause numbers are used.
+
+How It Works: The Mechanisms
+============================
+
+The method used for flow control depends on the link's duplex mode.
+
+.. note::
+   The user-visible ``ethtool`` pause API described in this document controls
+   **link-wide PAUSE** (IEEE 802.3 Annex 31B) only. It does not control the
+   collision-based behavior that exists on half-duplex links.
+
+1. Half-Duplex: Collision-Based Flow Control
+--------------------------------------------
+On half-duplex links, a device cannot send and receive simultaneously, so PAUSE
+frames are not used. Flow control is achieved by leveraging the CSMA/CD
+(Carrier Sense Multiple Access with Collision Detection) protocol itself.
+
+* **How it works**: To inhibit incoming data, a receiving device can force a
+    collision on the line. When the sending station detects this collision, it
+    terminates its transmission, sends a "jam" signal, and then executes the
+    "Collision backoff and retransmission" procedure as defined in IEEE 802.3,
+    Section 4.2.3.2.5. This algorithm makes the sender wait for a random
+    period before attempting to retransmit. By repeatedly forcing collisions,
+    the receiver can effectively throttle the sender's transmission rate.
+
+.. note::
+    While this mechanism is part of the IEEE standard, there is currently no
+    generic kernel API to configure or control it. Drivers should not enable
+    this feature until a standardized interface is available.
+
+.. warning::
+   On shared-medium networks (e.g. 10BASE2, or twisted-pair networks using a
+   hub rather than a switch) forcing collisions inhibits traffic **across the
+   entire shared segment**, not just a single point-to-point link. Enabling
+   such behavior is generally undesirable.
+
+2. Full-Duplex: Link-wide PAUSE (IEEE 802.3 Annex 31B)
+------------------------------------------------------
+On full-duplex links, devices can send and receive at the same time. Flow
+control is achieved by sending a special **PAUSE frame**, defined by IEEE
+802.3 Annex 31B. This mechanism pauses all traffic on the link and is therefore
+called *link-wide PAUSE*.
+
+* **What it is**: A standard Ethernet frame with a globally reserved
+    destination MAC address (``01-80-C2-00-00-01``). This address is in a range
+    that standard IEEE 802.1D-compliant bridges do not forward. However, some
+    unmanaged or misconfigured bridges have been reported to forward these
+    frames, which can disrupt flow control across a network.
+
+* **How it works**: The frame contains a MAC Control opcode for PAUSE
+    (``0x0001``) and a ``pause_time`` value, telling the sender how long to
+    wait before sending more data frames. This time is specified in units of
+    "pause quantum", where one quantum is the time it takes to transmit 512 bits.
+    For example, one pause quantum is 51.2 microseconds on a 10 Mbit/s link,
+    and 512 nanoseconds on a 1 Gbit/s link. A ``pause_time`` of zero indicates
+    that the transmitter can resume transmission, even if a previous non-zero
+    pause time has not yet elapsed.
+
+* **Who uses it**: Any full-duplex link, from 10 Mbit/s to multi-gigabit speeds.
+
+3. Full-Duplex: Priority-based Flow Control (PFC) (IEEE 802.1Q Clause 36)
+-------------------------------------------------------------------------
+Priority-based Flow Control is an enhancement to the standard PAUSE mechanism
+that allows flow control to be applied independently to different classes of
+traffic, identified by their priority level.
+
+* **What it is**: PFC allows a receiver to pause traffic for one or more of the
+    8 standard priority levels without stopping traffic for other priorities.
+    This is critical in data center environments for protocols that cannot
+    tolerate packet loss due to congestion (e.g., Fibre Channel over Ethernet
+    or RoCE).
+
+* **How it works**: PFC uses a specific PAUSE frame format. It shares the same
+    globally reserved destination MAC address (``01-80-C2-00-00-01``) as legacy
+    PAUSE frames but uses a unique opcode (``0x0101``). The frame payload
+    contains two key fields:
+
+    - **``priority_enable_vector``**: An 8-bit mask where each bit corresponds to
+      one of the 8 priorities. If a bit is set to 1, it means the pause time
+      for that priority is active.
+    - **``time_vector``**: A list of eight 2-octet fields, one for each priority.
+      Each field specifies the ``pause_time`` for its corresponding priority,
+      measured in units of ``pause_quanta`` (the time to transmit 512 bits).
+
+.. note::
+    When PFC is enabled for at least one priority on a port, the standard
+    **link-wide PAUSE** (IEEE 802.3 Annex 31B) must be disabled for that port.
+    The two mechanisms are mutually exclusive (IEEE 802.1Q Clause 36).
+
+Configuring Flow Control
+========================
+
+Link-wide PAUSE and Priority-based Flow Control are configured with different
+tools.
+
+Configuring Link-wide PAUSE with ``ethtool`` (IEEE 802.3 Annex 31B)
+-------------------------------------------------------------------
+Use ``ethtool -a <interface>`` to view and ``ethtool -A <interface>`` to change
+the link-wide PAUSE settings.
+
+.. code-block:: bash
+
+  # View current link-wide PAUSE settings
+  ethtool -a eth0
+
+  # Enable RX and TX pause, with autonegotiation
+  ethtool -A eth0 autoneg on rx on tx on
+
+**Key Configuration Concepts**:
+
+* **Pause Autoneg vs Generic Autoneg**: ``ethtool -A ... autoneg {on,off}``
+  controls **Pause Autoneg** (Annex 31B) only. It is independent from the
+  **Generic link autonegotiation** configured with ``ethtool -s``. A device can
+  have Generic autoneg **on** while Pause Autoneg is **off**, and vice versa.
+
+* **If Pause Autoneg is off** (``-A ... autoneg off``): the device will **not**
+  advertise pause in the PHY. The MAC PAUSE state is **forced** according to
+  ``rx``/``tx`` and does not depend on partner capabilities or resolution.
+  Ensure the peer is configured complementarily for PAUSE to be effective.
+
+* **If generic autoneg is off** but **Pause Autoneg is on**, the pause policy
+  is **remembered** by the kernel and applied later when Generic autoneg is
+  enabled again.
+
+* **Autonegotiation Mode**: The PHY will *advertise* the ``rx`` and ``tx``
+  capabilities. The final active state is determined by what both sides of the
+  link agree on. See the "PHY (Physical Layer Transceiver)" section below,
+  especially the *Resolution* subsection, for details of the negotiation rules.
+
+* **Forced Mode**: This mode is necessary when autonegotiation is not used or
+  not possible. This includes links where one or both partners have
+  autonegotiation disabled, or in setups without a PHY (e.g., direct
+  MAC-to-MAC connections). The driver bypasses PHY advertisement and
+  directly forces the MAC into the specified ``rx``/``tx`` state. The
+  configuration on both sides of the link must be complementary. For
+  example, if one side is set to ``tx on`` ``rx off``, the link partner must be
+  set to ``tx off`` ``rx on`` for flow control to function correctly.
+
+Configuring PFC with ``dcb`` (IEEE 802.1Q Clause 36)
+----------------------------------------------------
+PFC is part of the Data Center Bridging (DCB) subsystem and is managed with the
+``dcb`` tool (iproute2). Some deployments use ``dcbtool`` (lldpad) instead; this
+document shows ``dcb(8)`` examples.
+
+**Viewing PFC Settings**:
+
+.. code-block:: text
+
+  $ dcb pfc show dev eth0
+  pfc-cap 8 macsec-bypass off delay 4096
+  prio-pfc 0:off 1:off 2:off 3:off 4:off 5:off 6:on 7:on
+
+This shows the PFC state (on/off) for each priority (0-7).
+
+**Changing PFC Settings**:
+
+.. code-block:: bash
+
+  # Enable PFC on priorities 6 and 7, leaving others as they are
+  $ dcb pfc set dev eth0 prio-pfc 6:on 7:on
+
+  # Disable PFC for all priorities except 6 and 7
+  $ dcb pfc set dev eth0 prio-pfc all:off 6:on 7:on
+
+Monitoring Flow Control
+=======================
+
+The standard way to check if flow control is actively being used is to view the
+pause-related statistics.
+
+**Monitoring Link-wide PAUSE**:
+Use ``ethtool --include-statistics -a <interface>``.
+
+.. code-block:: text
+
+  $ ethtool --include-statistics -a eth0
+  Pause parameters for eth0:
+  ...
+  Statistics:
+    tx_pause_frames: 0
+    rx_pause_frames: 0
+
+**Monitoring PFC**:
+PFC statistics (sent and received frames per priority) are available
+through the ``dcb`` tool.
+
+.. code-block:: text
+
+  $ dcb pfc show dev eth0 requests indications
+  requests 0:0 1:0 2:0 3:1024 4:2048 5:0 6:0 7:0
+  indications 0:0 1:0 2:0 3:512 4:4096 5:0 6:0 7:0
+
+The ``requests`` counters track transmitted PFC frames (TX), and the
+``indications`` counters track received PFC frames (RX).
+
+Link-wide PAUSE Autonegotiation Details
+=======================================
+
+The autonegotiation process for link-wide PAUSE is managed by the PHY and
+involves advertising capabilities and resolving the outcome.
+
+* Terminology (link-wide PAUSE):
+
+    - **Symmetric pause**: both directions are paused when requested (TX+RX
+      enabled).
+    - **Asymmetric pause**: only one direction is paused (e.g., RX-only or
+      TX-only).
+
+    In IEEE 802.3 advertisement/resolution, symmetric/asymmetric are encoded
+    using two bits (Pause/Asym) and resolved per the standard truth tables
+    below.
+
+* **Advertisement**: The PHY advertises the MAC's flow control capabilities.
+  This is done using two bits in the advertisement register: "Symmetric
+  Pause" (Pause) and "Asymmetric Pause" (Asym). These bits should be
+  interpreted as a combined value, not as independent flags. The kernel
+  converts the user's ``rx`` and ``tx`` settings into this two-bit value as
+  follows:
+
+  .. code-block:: text
+
+    tx  rx | Pause  Asym
+    -------+-------------
+     0   0 |   0      0
+     0   1 |   1      1
+     1   0 |   0      1
+     1   1 |   1      0
+
+* **Resolution**: After negotiation, the PHY reports the link partner's
+  advertised Pause and Asym bits. The final flow control mode is determined
+  by the combination of the local and partner advertisements, according to
+  the IEEE 802.3 standard:
+
+  .. code-block:: text
+
+    Local Device       | Link Partner       | Result
+    Pause  Asym        | Pause   Asym       |
+    -------------------+--------------------+---------
+      0      X         |  0       X         | Disabled
+      0      1         |  1       0         | Disabled
+      0      1         |  1       1         | TX only
+      1      0         |  0       X         | Disabled
+      1      X         |  1       X         | TX + RX
+      1      1         |  0       1         | RX only
+
+  It is important to note that the advertised bits reflect the *current
+  configuration* of the MAC, which may not represent its full hardware
+  capabilities.
+
+Kernel Policy: "Set and Trust"
+==============================
+
+The ethtool pause API is defined as a **wish policy** for
+IEEE 802.3 link-wide PAUSE only. A user request is always accepted
+as the preferred configuration, but it may not be possible to apply
+it in all link states.
+
+Key constraints:
+
+- Link-wide PAUSE is not valid on half-duplex links.
+- Link-wide PAUSE cannot be used together with Priority-based Flow Control
+  (PFC, IEEE 802.1Q Clause 36).
+- If autonegotiation is active and the link is currently down, the future
+  mode is not yet known.
+
+Because of these constraints, the kernel stores the requested setting
+and applies it only when the link is in a compatible state.
+
+Implications for userspace:
+
+1. Set once (the "wish"): the requested Rx/Tx PAUSE policy is
+   remembered even if it cannot be applied immediately.
+2. Applied conditionally: when the link comes up, the kernel enables
+   PAUSE only if the active mode allows it.
+
+Component Roles in Flow Control
+===============================
+
+The configuration of flow control involves several components, each with a
+distinct role.
+
+The MAC (Media Access Controller)
+---------------------------------
+The MAC is the hardware component that actually sends and receives PAUSE
+frames. Its capabilities define the upper limit of what the driver can support.
+For link-wide PAUSE, MACs can vary in their support for symmetric (both
+directions) or asymmetric (independent TX/RX) flow control.
+
+For PFC, the MAC must be capable of generating and interpreting the
+priority-based PAUSE frames and managing separate pause states for each
+traffic class.
+
+Many MACs also implement automatic PAUSE frame transmission based on the fill
+level of their internal RX FIFO. This is typically configured with two
+thresholds:
+
+* **FLOW_ON (High Water Mark)**: When the RX FIFO usage reaches this
+  threshold, the MAC automatically transmits a PAUSE frame to stop the sender.
+
+* **FLOW_OFF (Low Water Mark)**: When the RX FIFO usage drops below this
+  threshold, the MAC transmits a PAUSE frame with a quantum of zero to tell
+  the sender it can resume transmission.
+
+The PHY (Physical Layer Transceiver)
+------------------------------------
+The PHY's role is distinct for each flow control mechanism:
+
+* **Link-wide PAUSE**: During the autonegotiation process, the PHY is
+  responsible for advertising the device's flow control capabilities. See the
+  "Link-wide PAUSE Autonegotiation Details" section for more information.
+
+* **Half-Duplex Collision-Based Flow Control**: The PHY is fundamental to the
+  CSMA/CD process. It performs carrier sensing (checking if the line is idle)
+  and collision detection, which is the mechanism leveraged to throttle the
+  sender.
+
+* **Priority-based Flow Control (PFC)**: The PHY is not directly involved in
+  negotiating PFC capabilities. Its role is to establish the physical link.
+  PFC negotiation happens at a higher layer via the Data Center Bridging
+  Capability Exchange Protocol (DCBX).
+
+User Space Interface
+====================
+The primary user space tools are ``ethtool`` for link-wide PAUSE and ``dcb`` for
+PFC. They communicate with the kernel to configure the network device driver
+and underlying hardware.
+
+**Link-wide PAUSE Netlink Interface (``ethtool``)**
+
+See the ethtool Netlink spec (``Documentation/netlink/specs/ethtool.yaml``)
+for the authoritative definition of the Pause control and Pause statistics
+attributes. The generated UAPI is in
+``include/uapi/linux/ethtool_netlink_generated.h``.
+
+**PFC Netlink Interface (``dcb``)**
+
+The authoritative definitions for DCB/PFC netlink attributes and commands are in
+``include/uapi/linux/dcbnl.h``. See also the ``dcb(8)`` manual page and the DCB
+subsystem documentation for userspace configuration details.
+
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index b7a4969e9bc9..243f4ceb4ab1 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -55,6 +55,7 @@ Contents:
    eql
    fib_trie
    filter
+   flow_control
    generic-hdlc
    generic_netlink
    ../netlink/specs/index
diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
index 7f159043ad5a..a900e18a93d3 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -343,16 +343,8 @@ Some of the interface modes are described below:
 Pause frames / flow control
 ===========================
 
-The PHY does not participate directly in flow control/pause frames except by
-making sure that the SUPPORTED_Pause and SUPPORTED_AsymPause bits are set in
-MII_ADVERTISE to indicate towards the link partner that the Ethernet MAC
-controller supports such a thing. Since flow control/pause frames generation
-involves the Ethernet MAC driver, it is recommended that this driver takes care
-of properly indicating advertisement and support for such features by setting
-the SUPPORTED_Pause and SUPPORTED_AsymPause bits accordingly. This can be done
-either before or after phy_connect() and/or as a result of implementing the
-ethtool::set_pauseparam feature.
-
+For detailed link-wide PAUSE and PFC behavior and configuration, see
+flow_control.rst.
 
 Keeping Close Tabs on the PAL
 =============================
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index de5bd76a400c..d921bd602064 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -931,9 +931,48 @@ struct kernel_ethtool_ts_info {
  * @get_pause_stats: Report pause frame statistics. Drivers must not zero
  *	statistics which they don't report. The stats structure is initialized
  *	to ETHTOOL_STAT_NOT_SET indicating driver does not report statistics.
- * @get_pauseparam: Report pause parameters
- * @set_pauseparam: Set pause parameters.  Returns a negative error code
- *	or zero.
+ *
+ * @get_pauseparam: Report the configured policy for link-wide PAUSE
+ *      (IEEE 802.3 Annex 31B). Drivers must fill struct ethtool_pauseparam
+ *      such that:
+ *      @autoneg:
+ *              This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only
+ *              and is independent of generic link autonegotiation configured
+ *              via ethtool -s.
+ *              true  -> the device follows the negotiated result of pause
+ *                       autonegotiation (Pause/Asym);
+ *              false -> the device uses a forced MAC state independent of
+ *                       negotiation.
+ *      @rx_pause/@tx_pause:
+ *              represent the desired policy (preferred configuration).
+ *              In autoneg mode they describe what is to be advertised;
+ *              in forced mode they describe the MAC state to apply.
+ *
+ *      Drivers (and/or frameworks) should persist this policy across link
+ *      changes and reapply appropriate MAC programming when link parameters
+ *      change.
+ *
+ * @set_pauseparam: Apply a policy for link-wide PAUSE (IEEE 802.3 Annex 31B).
+ *      If @autoneg is true:
+ *              Arrange for pause advertisement (Pause/Asym) based on
+ *              @rx_pause/@tx_pause and program the MAC to follow the
+ *              negotiated result (which may be symmetric, asymmetric, or off
+ *              depending on the link partner).
+ *      If @autoneg is false:
+ *              Do not rely on autonegotiation; force the MAC RX/TX pause
+ *              state directly per @rx_pause/@tx_pause.
+ *
+ *      Implementations that integrate with PHYLIB/PHYLINK should cooperate
+ *      with those frameworks for advertisement and resolution; MAC drivers are
+ *      still responsible for applying the required MAC state.
+ *
+ *      Return: 0 on success or a negative errno. Return -EOPNOTSUPP if
+ *      link-wide PAUSE is unsupported. If only symmetric pause is supported,
+ *      reject unsupported asymmetric requests with -EINVAL (or document any
+ *      coercion policy).
+ *
+ *      See also: Documentation/networking/flow_control.rst
+ *
  * @self_test: Run specified self-tests
  * @get_strings: Return a set of strings that describe the requested objects
  * @set_phys_id: Identify the physical devices, e.g. by flashing an LED
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 46de09954042..d0972eabf8ab 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -384,7 +384,13 @@ enum {
 	ETHTOOL_A_COALESCE_MAX = (__ETHTOOL_A_COALESCE_CNT - 1)
 };
 
-enum {
+/**
+ * enum ethtool_pause_stat - Statistics counters for link-wide PAUSE frames
+ *   (IEEE 802.3 Annex 31B).
+ * @ETHTOOL_A_PAUSE_STAT_TX_FRAMES: Number of PAUSE frames transmitted.
+ * @ETHTOOL_A_PAUSE_STAT_RX_FRAMES: Number of PAUSE frames received.
+ */
+enum ethtool_a_pause_stat {
 	ETHTOOL_A_PAUSE_STAT_UNSPEC,
 	ETHTOOL_A_PAUSE_STAT_PAD,
 	ETHTOOL_A_PAUSE_STAT_TX_FRAMES,
@@ -394,7 +400,25 @@ enum {
 	ETHTOOL_A_PAUSE_STAT_MAX = (__ETHTOOL_A_PAUSE_STAT_CNT - 1)
 };
 
-enum {
+/**
+ * enum ethtool_pause - Parameters for link-wide PAUSE (IEEE 802.3 Annex 31B).
+ * @ETHTOOL_A_PAUSE_AUTONEG: Acts as a mode selector for the driver. On GET:
+ *   indicates the driver's behavior. If true, the driver will respect the
+ *   negotiated outcome; if false, the driver will use a forced configuration.
+ *   On SET: if true, the driver configures the PHY's advertisement based on
+ *   the rx and tx attributes. If false, the driver forces the MAC into the
+ *   state defined by the rx and tx attributes.
+ * @ETHTOOL_A_PAUSE_RX: Enable receiving PAUSE frames (pausing local TX). On
+ *   GET: reflects the currently preferred configuration state.
+ * @ETHTOOL_A_PAUSE_TX: Enable transmitting PAUSE frames (pausing peer TX). On
+ *   GET: reflects the currently preferred configuration state.
+ * @ETHTOOL_A_PAUSE_STATS: Contains the pause statistics counters. The source
+ *   of these statistics is determined by stats-src.
+ * @ETHTOOL_A_PAUSE_STATS_SRC: Selects the source of the MAC statistics, values
+ *   from enum ethtool_mac_stats_src. This allows requesting statistics from
+ *   the individual components of the MAC Merge layer.
+ */
+enum ethtool_a_pause {
 	ETHTOOL_A_PAUSE_UNSPEC,
 	ETHTOOL_A_PAUSE_HEADER,
 	ETHTOOL_A_PAUSE_AUTONEG,
diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index 03eb1d941fca..91ee22f53774 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -27,6 +27,8 @@
  *
  * Priority-based Flow Control (PFC) - provides a flow control mechanism which
  *   can work independently for each 802.1p priority.
+ *   See Documentation/networking/flow_control.rst for a high level description
+ *   of the user space interface for Priority-based Flow Control (PFC).
  *
  * Congestion Notification - provides a mechanism for end-to-end congestion
  *   control for protocols which do not have built-in congestion management.
diff --git a/net/ethtool/pause.c b/net/ethtool/pause.c
index 0f9af1e66548..eacf6a4859bf 100644
--- a/net/ethtool/pause.c
+++ b/net/ethtool/pause.c
@@ -1,5 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+/* See Documentation/networking/flow_control.rst for a high level description of
+ * the userspace interface.
+ */
+
 #include "netlink.h"
 #include "common.h"
 
-- 
2.47.3


