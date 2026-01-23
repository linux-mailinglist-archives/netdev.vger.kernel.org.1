Return-Path: <netdev+bounces-252844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPx8IFN2c2kEwAAAu9opvQ
	(envelope-from <netdev+bounces-252844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:23:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA4762FE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02D63300939B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C0D2D5C83;
	Fri, 23 Jan 2026 13:23:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FD29AB02
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174600; cv=none; b=HuDafHNtcSEOoGcV3I51eZq9UpTr+uS5K8sMYGeOaepsxgzXlIeMkWyyXCV1al0CTUvbD60ZIf+rWDMcqU7favJdOnIbd7YHi0FajO4pg4ZKuq5XKMpsCE8dsm1fBEijYQ+yKyBw1dXwpaEwtWnGQ3PN5dzvZYnEZ4Qwm4EAEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174600; c=relaxed/simple;
	bh=Mnjch2h8IOIDPgw2Sa7qPUsMwxX7xbU89guS4nGasdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AITqqiMXzLgJC7yTYKg5fRwkekSLqWcg9hlYR/ZCqDM1IczhgSgTCuY+StQzQ+2edAKW81wWl3196yOjfKNY0Vj041RYjZTrVrlqnKVOUBZfgC9U1EYjN+VD2949TNiY3oCft7LHtwG7eQrZ2d0D2pvf5d4N2U1IKE7xxk0hAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjH7Z-0004Go-6k; Fri, 23 Jan 2026 14:22:41 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjH7V-0026CT-1u;
	Fri, 23 Jan 2026 14:22:36 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vjH7U-00000007kI6-3Q3F;
	Fri, 23 Jan 2026 14:22:36 +0100
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
Subject: [PATCH net-next v10 1/1] Documentation: net: add flow control guide and document ethtool API
Date: Fri, 23 Jan 2026 14:22:35 +0100
Message-ID: <20260123132235.1846216-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,denx.de,lwn.net,linux.dev,resnulli.us,nxp.com,iogearbox.net];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252844-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41EA4762FE
X-Rspamd-Action: no action

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
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
changes v10:
- update struct ethtool_pauseparam kernel-doc in UAPI to resolve
  contradictions with the new "User Intent" policy.
  Add reference flow_control.rst instead.
changes v9:
- Rewrote "Kernel Policy" section in Documentation/networking/flow_control.rst
  to explicitly distinguish between "Administrative State" (User Intent) and
  "Operational State".
- Added definitions for "Resolution Mode" and "Forced Mode", and
  disambiguated Pause Autonegotiation from Generic Link Autonegotiation.
- Updated include/linux/ethtool.h kernel-doc to define @autoneg as a
  selector for Resolution vs. Forced mode.
- Added "Constraint Checking" section to UAPI documentation: clarified that
  drivers should generally accept pause autoneg preferences even if link
  autoneg is currently disabled, while acknowledging strict hardware
  limitations.
- Added recommendation for new drivers to use
  phylink_ethtool_{get,set}_pauseparam().
changes v8:
- Drop enum-name for the pause and pause-stat attribute sets in
  Documentation/netlink/specs/ethtool.yaml and revert the generated
  pause enums in ethtool_netlink_generated.h back to anonymous enums.
- Simplify the pause stats "doc" string in ethtool.yaml so it only
  describes the counters and does not mention stats-src or MAC Merge.
- Make "Flow Control" capitalization consistent throughout
  Documentation/networking/flow_control.rst and clarify that the
  ethtool pause API does not control PFC.
- Extend the PFC description to reference the 3-bit PCP field in the
  802.1Q VLAN tag and spell out FCoE and RoCE explicitly.
- Reword the "Kernel Policy: Set and Trust" section to say that
  ethtool pause requests express the preferred configuration, but
  drivers may reject unsupported combinations and may require generic
  link autonegotiation before enabling Pause Autonegotiation. Clarify
  that the MAC configuration may differ from the user request depending
  on the active link mode.
- Update the get_pauseparam documentation in include/linux/ethtool.h
  so Pause Autonegotiation is described as part of the link
  autonegotiation process, and state that drivers should reject
  non-zero @autoneg when autonegotiation is disabled or not supported.
changes v7:
- regenerate ethtool_netlink_generated.h
changes v6:
- fix bullet list text parts
changes v5:
- do not render headers from yaml for now
- s/ethtool_a_pause_stat/ethtool-a-pause-stat
- s/ethtool_a_pause/ethtool-a-pause
- drop other yaml related patches
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
- add note about autoneg resolutio
---
 Documentation/netlink/specs/ethtool.yaml  |  24 ++
 Documentation/networking/flow_control.rst | 410 ++++++++++++++++++++++
 Documentation/networking/index.rst        |   1 +
 Documentation/networking/phy.rst          |  12 +-
 include/linux/ethtool.h                   |  42 ++-
 include/uapi/linux/ethtool.h              |  18 +-
 net/dcb/dcbnl.c                           |   2 +
 net/ethtool/pause.c                       |   4 +
 8 files changed, 485 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/networking/flow_control.rst

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 0a2d2343f79a..b4e742d53881 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -864,6 +864,7 @@ attribute-sets:

   -
     name: pause-stat
+    doc: Statistics counters for link-wide PAUSE frames (IEEE 802.3 Annex 31B).
     attr-cnt-name: __ethtool-a-pause-stat-cnt
     attributes:
       -
@@ -875,12 +876,15 @@ attribute-sets:
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
     attributes:
       -
@@ -893,19 +897,39 @@ attribute-sets:
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
+          Contains the pause statistics counters.
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
index 000000000000..458bbe553544
--- /dev/null
+++ b/Documentation/networking/flow_control.rst
@@ -0,0 +1,410 @@
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
+Flow Control is a mechanism to prevent a fast sender from overwhelming a
+slow receiver with data, which would cause buffer overruns and dropped packets.
+The receiver can signal the sender to temporarily stop transmitting, giving it
+time to process its backlog.
+
+Standards references
+====================
+
+Ethernet Flow Control mechanisms are specified across consolidated IEEE base
+standards; some originated as amendments:
+
+- Collision-based Flow Control is part of CSMA/CD in **IEEE 802.3**
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
+The method used for Flow Control depends on the link's duplex mode.
+
+.. note::
+   The user-visible ``ethtool`` pause API described in this document controls
+   **link-wide PAUSE** (IEEE 802.3 Annex 31B) only. It does not control the
+   collision-based behavior on half-duplex links, nor Priority-based Flow
+   Control (PFC).
+
+1. Half-Duplex: Collision-Based Flow Control
+--------------------------------------------
+On half-duplex links, a device cannot send and receive simultaneously, so PAUSE
+frames are not used. Flow Control is achieved by leveraging the CSMA/CD
+(Carrier Sense Multiple Access with Collision Detection) protocol itself.
+
+* **How it works**: To inhibit incoming data, a receiving device can force a
+  collision on the line. When the sending station detects this collision, it
+  terminates its transmission, sends a "jam" signal, and then executes the
+  "Collision backoff and retransmission" procedure as defined in IEEE 802.3,
+  Section 4.2.3.2.5. This algorithm makes the sender wait for a random
+  period before attempting to retransmit. By repeatedly forcing collisions,
+  the receiver can effectively throttle the sender's transmission rate.
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
+  destination MAC address (``01-80-C2-00-00-01``). This address is in a range
+  that standard IEEE 802.1D-compliant bridges do not forward. However, some
+  unmanaged or misconfigured bridges have been reported to forward these
+  frames, which can disrupt Flow Control across a network.
+
+* **How it works**: The frame contains a MAC Control opcode for PAUSE
+  (``0x0001``) and a ``pause_time`` value, telling the sender how long to
+  wait before sending more data frames. This time is specified in units of
+  "pause quantum", where one quantum is the time it takes to transmit 512 bits.
+  For example, one pause quantum is 51.2 microseconds on a 10 Mbit/s link,
+  and 512 nanoseconds on a 1 Gbit/s link. A ``pause_time`` of zero indicates
+  that the transmitter can resume transmission, even if a previous non-zero
+  pause time has not yet elapsed.
+
+* **Who uses it**: Any full-duplex link, from 10 Mbit/s to multi-gigabit speeds.
+
+3. Full-Duplex: Priority-based Flow Control (PFC) (IEEE 802.1Q Clause 36)
+-------------------------------------------------------------------------
+Priority-based Flow Control is an enhancement to the standard PAUSE mechanism
+that allows Flow Control to be applied independently to different classes of
+traffic, identified by their priority level (mapped from the 3-bit PCP field in
+the 802.1Q VLAN tag).
+
+* **What it is**: PFC allows a receiver to pause traffic for one or more of the
+  8 standard priority levels without stopping traffic for other priorities.
+  This is critical in data center environments for protocols that cannot
+  tolerate packet loss due to congestion (e.g., Fibre Channel over Ethernet
+  (FCoE) or RDMA over Converged Ethernet (RoCE)).
+
+* **How it works**: PFC uses a specific PAUSE frame format. It shares the same
+  globally reserved destination MAC address (``01-80-C2-00-00-01``) as legacy
+  PAUSE frames but uses a unique opcode (``0x0101``). The frame payload
+  contains two key fields:
+
+  - **``priority_enable_vector``**: An 8-bit mask where each bit corresponds to
+    one of the 8 priorities. If a bit is set to 1, it means the pause time
+    for that priority is active.
+  - **``time_vector``**: A list of eight 2-octet fields, one for each priority.
+    Each field specifies the ``pause_time`` for its corresponding priority,
+    measured in units of ``pause_quanta`` (the time to transmit 512 bits).
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
+  set to ``tx off`` ``rx on`` for Flow Control to function correctly.
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
+The standard way to check if Flow Control is actively being used is to view the
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
+  - **Symmetric pause**: both directions are paused when requested (TX+RX
+    enabled).
+  - **Asymmetric pause**: only one direction is paused (e.g., RX-only or
+    TX-only).
+
+  In IEEE 802.3 advertisement/resolution, symmetric/asymmetric are encoded
+  using two bits (Pause/Asym) and resolved per the standard truth tables
+  below.
+
+* **Advertisement**: The PHY advertises the MAC's Flow Control capabilities.
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
+  advertised Pause and Asym bits. The final Flow Control mode is determined
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
+Kernel Policy: User Intent & Resolution
+=======================================
+
+The ethtool pause API ('ethtool -A' or '--pause') configures the **User
+Intent** for **Link-wide PAUSE** (IEEE 802.3 Annex 31B). The
+**Operational State** (what actually happens on the wire) is derived
+from this intent, the active link mode, and the link partner.
+
+**Disambiguation: Pause Autoneg vs. Link Autoneg**
+In this section, "autonegotiation" refers exclusively to the **Pause
+Autonegotiation** parameter ('ethtool -A / --pause ... autoneg <on|off>').
+This is distinct from, but interacts with, **Generic Link
+Autonegotiation** ('ethtool -s / --change ... autoneg <on|off>').
+
+The semantics of the Pause API depend on the 'autoneg' parameter:
+
+1. **Resolution Mode** ('ethtool -A ... autoneg on')
+   The user intends for the device to **respect the negotiated result**.
+
+   - **Hardware Capability Check:** The driver must verify that the hardware
+     is capable of Autonegotiation. If the hardware is fixed-link or
+     lacks AN logic entirely, this request must be rejected (``-EOPNOTSUPP``).
+   - **Advertisement:** The system updates the PHY advertisement
+     (Symmetric/Asymmetric pause bits) to match the ``rx`` and ``tx`` parameters.
+   - **Resolution:** The system configures the MAC to follow the standard
+     IEEE 802.3 Resolution Truth Table based on the Local Advertisement
+     vs. Link Partner Advertisement.
+   - **Interaction with Link Autoneg:** If Generic Link Autonegotiation is
+     currently disabled, resolution cannot occur. The Operational State
+     effectively becomes **Disabled**.
+
+     **Note on Implementation Variation:** Provided the hardware supports AN
+     in principle, the system **SHOULD** accept this configuration as a valid
+     stored intent for when Link Autonegotiation is re-enabled. However,
+     legacy or strict-hardware drivers **MAY** reject this request if Link
+     Autonegotiation is disabled, enforcing a strict dependency.
+
+2. **Forced Mode** ('ethtool -A ... autoneg off')
+   The user intends to **override negotiation** and force a specific
+   state.
+
+   - **Hardware Capability Check:** The driver must verify that the hardware
+     supports forced manual configuration. If the hardware is tightly coupled
+     to AN logic and cannot be forced, this request must be rejected.
+   - **Advertisement:** The system should update the PHY advertisement
+     to match the ``rx`` and ``tx`` parameters, ensuring the link partner
+     is aware of the forced configuration.
+   - **Resolution:** The system configures the MAC according to the
+     specified ``rx`` and ``tx`` parameters, ignoring the link partner's
+     advertisement.
+
+**Global Constraint: Full-Duplex Only**
+Link-wide PAUSE (Annex 31B) is strictly defined for **Full-Duplex** links.
+If the link mode is **Half-Duplex** (whether forced or negotiated),
+Link-wide PAUSE is operationally **disabled** regardless of the
+parameters set above.
+
+**Summary of "autoneg" Flag Meaning:**
+- true  -> **Delegate decision:** "Use the IEEE 802.3 logic to decide."
+- false -> **Force decision:** "Do exactly what I say (if the network device
+  supports it)."
+
+Component Roles in Flow Control
+===============================
+
+The configuration of Flow Control involves several components, each with a
+distinct role.
+
+The MAC (Media Access Controller)
+---------------------------------
+The MAC is the hardware component that actually sends and receives PAUSE
+frames. Its capabilities define the upper limit of what the driver can support.
+For link-wide PAUSE, MACs can vary in their support for symmetric (both
+directions) or asymmetric (independent TX/RX) Flow Control.
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
+The PHY's role is distinct for each Flow Control mechanism:
+
+* **Link-wide PAUSE**: During the autonegotiation process, the PHY is
+  responsible for advertising the device's Flow Control capabilities. See the
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
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 49fcfa577711..35b0548050a0 100644
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
index 0170c9d4dc5e..45a280ae4616 100644
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
index 798abec67a1b..5662c990c41d 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -983,9 +983,45 @@ struct kernel_ethtool_ts_info {
  * @get_pause_stats: Report pause frame statistics. Drivers must not zero
  *	statistics which they don't report. The stats structure is initialized
  *	to ETHTOOL_STAT_NOT_SET indicating driver does not report statistics.
- * @get_pauseparam: Report pause parameters
- * @set_pauseparam: Set pause parameters.  Returns a negative error code
- *	or zero.
+ * @get_pauseparam: Report the configured administrative policy for
+ *	link-wide PAUSE (IEEE 802.3 Annex 31B). Drivers must fill struct
+ *	ethtool_pauseparam such that:
+ *	@autoneg:
+ *		This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only.
+ *		true  -> the device follows the result of pause autonegotiation
+ *			 when the link allows it;
+ *		false -> the device uses a forced configuration.
+ *	@rx_pause/@tx_pause:
+ *		Represent the desired policy (Administrative State).
+ *		In autoneg mode they describe what is to be advertised;
+ *		in forced mode they describe the MAC configuration to be forced.
+ * @set_pauseparam: Apply a policy for link-wide PAUSE (IEEE 802.3 Annex 31B).
+ *	@rx_pause/@tx_pause:
+ *		Desired state. If @autoneg is true, these define the
+ *		advertisement. If @autoneg is false, these define the
+ *		forced MAC configuration (and preferably the advertisement too).
+ *	@autoneg:
+ *		Select Resolution Mode (true) or Forced Mode (false).
+ *
+ *	**Constraint Checking:**
+ *	Drivers MUST validate that the hardware capabilities support the
+ *	requested mode.
+ *	- If the hardware does not support Autonegotiation (e.g. fixed link),
+ *	  drivers MUST reject @autoneg=1 with -EOPNOTSUPP.
+ *	- If the hardware does not support Forced configuration (e.g. strict AN),
+ *	  drivers MUST reject @autoneg=0 with -EOPNOTSUPP.
+ *
+ *	Provided the hardware capability exists, drivers SHOULD accept a setting
+ *	of @autoneg=1 even if generic link autonegotiation ('ethtool -s') is
+ *	currently disabled. This allows the user to pre-configure the desired
+ *	policy for future link modes. Users should be aware that some drivers
+ *	may strictly enforce the dependency and reject this configuration.
+ *
+ *	New drivers are strongly encouraged to use phylink_ethtool_get_pauseparam()
+ *	and phylink_ethtool_set_pauseparam() which implement this logic
+ *	correctly.
+ *
+ *	See also: Documentation/networking/flow_control.rst
  * @self_test: Run specified self-tests
  * @get_strings: Return a set of strings that describe the requested objects
  * @set_phys_id: Identify the physical devices, e.g. by flashing an LED
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b74b80508553..14983870cdf7 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -561,24 +561,12 @@ struct ethtool_channels {
 /**
  * struct ethtool_pauseparam - Ethernet pause (flow control) parameters
  * @cmd: Command number = %ETHTOOL_GPAUSEPARAM or %ETHTOOL_SPAUSEPARAM
- * @autoneg: Flag to enable autonegotiation of pause frame use
+ * @autoneg: Pause Autonegotiation Mode selector (0 = Forced; 1 = Resolution)
  * @rx_pause: Flag to enable reception of pause frames
  * @tx_pause: Flag to enable transmission of pause frames
  *
- * Drivers should reject a non-zero setting of @autoneg when
- * autoneogotiation is disabled (or not supported) for the link.
- *
- * If the link is autonegotiated, drivers should use
- * mii_advertise_flowctrl() or similar code to set the advertised
- * pause frame capabilities based on the @rx_pause and @tx_pause flags,
- * even if @autoneg is zero.  They should also allow the advertised
- * pause frame capabilities to be controlled directly through the
- * advertising field of &struct ethtool_cmd.
- *
- * If @autoneg is non-zero, the MAC is configured to send and/or
- * receive pause frames according to the result of autonegotiation.
- * Otherwise, it is configured directly based on the @rx_pause and
- * @tx_pause flags.
+ * Refer to Documentation/networking/flow_control.rst for the detailed
+ * semantics of these flags and the expected driver behavior.
  */
 struct ethtool_pauseparam {
 	__u32	cmd;
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


