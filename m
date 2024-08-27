Return-Path: <netdev+bounces-122141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83289600F1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AEF3B234A0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 05:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA522E414;
	Tue, 27 Aug 2024 05:14:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47D6EB64
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735650; cv=none; b=lmISLJ3RpaDTEk425HxgHQ4Fee/nb0eZodjHJ3DH94uH/8HKw0uquK86Et74d0uS0CykTY6Pq4N2HpHHqk/9xIx9wJDqo3XI9Bd+ox8EMmqxLmb77w03xyp6kh9qjLlK29CasLExQuT7qmskAVAB2AbcbnMYijoQRi21IVT8oxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735650; c=relaxed/simple;
	bh=2EXBC37oXf4DFL4CRV+nW7LMPJLWUfHZnU41+izyJro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S5+qF3FAdnjPkjrGMrZ6u0UZUplddxTuudwW6ixsHgAupYmBJPiesbv0P/ygrkfxzzruN0u9flMXkqibkEQT6lk1QgocTEIzms54Vr9jeeZEtdnOIfShh28NKaogUL7/92dgITwCdPvTEE+gAH6lIVeQJbpygnRggNpefFtOAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sioWk-0007Y0-7j; Tue, 27 Aug 2024 07:13:58 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sioWh-003Lre-QX; Tue, 27 Aug 2024 07:13:55 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sioWh-008otR-2F;
	Tue, 27 Aug 2024 07:13:55 +0200
Date: Tue, 27 Aug 2024 07:13:55 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com, jlu@pengutronix.de
Subject: Initial Thoughts on OSI Level 1 Diagnostic for 10BaseT1L Interface
Message-ID: <Zs1gk3gfU7EAPmPc@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi all,

I'd like to share my initial thoughts on how to approach network OSI
Layer 1 diagnostics for projects using the 10BaseT1L interface. I
believe this concept could be made more generic and eventually included
in the kernel documentation. The aim is to help developers like myself
prioritize tasks more effectively.

The primary focus of this concept is on embedded systems where human
interaction isn't feasible, meaning all interfaces should be
machine-readable. For instance, a flight-recorder application could
gather as much diagnostic data as possible for later analysis.

At this point, the concept is targeting existing diagnostic interfaces,
but it may also highlight the need for new ones.

Troubleshooting Checklist
=========================

**Symptom:** Interface is in admin UP state and link partner is attached, but
no Ethernet link is detected.

**How to Detect:**
------------------
**Diagnostic Tools:** ``iproute2``, ``ethtool``  
**Command:** ``ip link show dev t1l0``  
**Command Output:**

.. code-block::

    4: t1l0@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
       link/ether 88:14:2b:00:96:f2 brd ff:ff:ff:ff:ff:ff

**Command:** ``ethtool t1l0``  
**Command Output:**

.. code-block::

    Settings for t1l0:
       Supported ports: [  ]
       Supported link modes:   10baseT1L/Full
       Supported pause frame use: No
       Supports auto-negotiation: Yes
       Supported FEC modes: Not reported
       Advertised link modes:  10baseT1L/Full
       Advertised pause frame use: No
       Advertised auto-negotiation: Yes
       Advertised FEC modes: Not reported
       Speed: Unknown!
       Duplex: Unknown! (255)
       Auto-negotiation: on
       master-slave cfg: preferred slave
       master-slave status: unknown
       Port: Twisted Pair
       PHYAD: 6
       Transceiver: external
       MDI-X: Unknown
       Supports Wake-on: d
       Wake-on: d
       Link detected: no <----

Possible Reasons:
-----------------

1. **Link Partner (LP) is not powered on**
   - **Possibility:** High
   - **Probability:** Medium
   - **Description:** If LP is powered over PoDL or PoE, ensure that the PSE
     (Power Source Equipment) is enabled and functioning properly, e.g., current
     is within the consumption range of the link partner.
   - **Notes:** This can happen if the PSE is misconfigured, disabled, or if
     there is an issue with the power supply. In some cases, the LP may not
     request power correctly, leading to no power being delivered.
   - **Diagnostic Tools:** ``ethtool``
   - **Command:** ``ethtool --show-pse t1l1``
   - **Command Output:**

   .. code-block::

       PSE attributes for t1l1:
       PoDL PSE Admin State: enabled
       PoDL PSE Power Detection Status: delivering power

   - **Possible Limitations:** Not all PSE controllers provide current information.
   - **Command:** ``ethtool --cable-test t1l1``
   - **Command Output:**

   .. code-block::

       Cable test started for device t1l1.
       Cable test completed for device t1l1.
       Pair A, fault length: 25.00m
       Pair A code Open Circuit

2. **Cable is damaged with a short between pairs**
   - **Possibility:** Medium
   - **Probability:** Medium
   - **Description:** In case LP is powered over PoDL or PoE, the PSE controller
     may disable power due to an overcurrent event.
   - **Notes:** This issue could arise if the cable has been physically damaged
     (e.g., pinched, cut, or exposed to excessive force), leading to a short
     circuit. It's also possible that the installation was done incorrectly,
     causing a short.
   - **Diagnostic Tools:** ``ethtool``
   - **Command:** ``ethtool --show-pse t1l1``
   - **Command Output:** 

   .. code-block::

       PoDL PSE Power Detection Status: over current

   - **Command:** ``ethtool --cable-test t1l1``
   - **Command Output:**

   .. code-block::

       Cable test started for device t1l1.
       Cable test completed for device t1l1.
       Pair A, fault length: 25.00m
       Pair A code Short within Pair

3. **Cable is damaged with an open state or device is not attached**
   - **Possibility:** High
   - **Probability:** High
   - **Description:** If the device is not attached or the cable is open, no
     link will be established.
   - **Notes:** This situation is common in environments where cables are
     frequently moved, reconnected, or exposed to mechanical stress. It can also
     happen if the cable is improperly terminated or if a connector is loose or
     damaged.
   - **Diagnostic Tools:** ``ethtool``
   - **Command:** ``ethtool --cable-test t1l1``
   - **Command Output:**

   .. code-block::

       Cable test started for device t1l1.
       Cable test completed for device t1l1.
       Pair A, fault length: 25.00m
       Pair A code Open Circuit

4. **LP PHY is not up or powered on**
   - **Possibility:** Medium
   - **Probability:** Medium
   - **Description:** The LP may not have powered on the PHY, may not have
     brought it out of reset, or the interface may be in admin down state.
   - **Notes:** This can occur if the LP's firmware or software fails to
     initialize the PHY correctly. It might also happen if the LP is in a
     low-power state or if there’s a software misconfiguration.
   - **Diagnostic Tools:** ``ethtool``
   - **Command:** ``ethtool --cable-test t1l1``
   - **Command Output:**

   .. code-block::

       Cable test started for device t1l1.
       Cable test completed for device t1l1.
       Pair A, fault length: 25.00m
       Pair A code Open Circuit

5. **LP PHY is not compatible with local PHY or misconfigured**
   - **Possibility:** Medium
   - **Probability:** Low
   - **Description:** If the LP PHY's capabilities do not match those of the
     local PHY or are misconfigured, the link will not be established.
   - **Notes:** Incompatibility issues might arise if the LP is from a different
     manufacturer or is an older model. Misconfiguration could occur due to
     incorrect software settings or faulty strap pin configurations.
   - **Diagnostic Tools:** ``ethtool``
   - **Command:** ``ethtool --cable-test t1l1``
   - **Command Output:**

   .. code-block::

       Cable test started for device t1l1.
       Cable test completed for device t1l1.
       Pair A code Unknown

6. **LP PHY is in forced master mode, autoneg is disabled**
   - **Possibility:** High
   - **Probability:** Medium
   - **Description:** If the LP PHY is in forced master mode with autoneg
     disabled, the link will not be established.
   - **Notes:** This issue can happen if the LP is manually configured to a
     fixed master mode and the local device is not configured accordingly.
     Such misconfigurations can occur due to user error or incorrect default
     settings.
   - **Diagnostic Tools:** ``ethtool``
   - **Command:** ``ethtool --cable-test t1l1``
   - **Command Output:**

   .. code-block::

       Cable test started for device t1l1.
       Cable test completed for device t1l1.
       Pair A code Unknown

7. **LP PHY is in forced slave mode, autoneg is disabled**
   - **Possibility:** High
   - **Probability:** Medium
   - **Description:** If the LP PHY is in forced slave mode with autoneg
     disabled, sometimes the link can still be established, but there are cases
     where no link is detected.
   - **Notes:** Similar to the forced master mode, this can be caused by manual
     configuration or specific use cases where autoneg is intentionally
     disabled. However, this might lead to unpredictable behavior in
     establishing the link.
   - **Diagnostic Tools:** ``ethtool``
   - **Command:** ``ethtool --cable-test t1l1``
   - **Command Output:**

   .. code-block::

       Cable test started for device t1l1.
       Cable test completed for device t1l1.
       Pair A code OK

   - **Note:** ``ethtool --cable-test`` may need to be executed multiple times
     as it sometimes shows "Pair A code Unknown".

Reverse Troubleshooting Checklist
=================================

**Goal:** Systematically execute diagnostic commands to identify the root cause
when no Ethernet link is detected, despite the interface being in admin UP
state and the link partner being attached.

**Step 1: Verify Interface Status**
-----------------------------------
**Command:** ``ip link show dev t1l0``  
**Expected Output:** Interface should be in the ``UP`` state with ``NO-CARRIER`` flag.

.. code-block::

    4: t1l0@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
       link/ether 88:14:2b:00:96:f2 brd ff:ff:ff:ff:ff:ff

- **If Output:** Interface is down, then check administrative settings or bring
  the interface up using ``ip link set dev t1l0 up``.
- **If Output:** Interface is up but shows ``NO-CARRIER``, proceed to Step 2.

**Step 2: Check Link Detection and PHY Status**
-----------------------------------------------
**Command:** ``ethtool t1l0``  
**Expected Output:** Verify ``Link detected: no`` and review PHY status.

.. code-block::

    Settings for t1l0:
       Speed: Unknown!
       Duplex: Unknown! (255)
       Auto-negotiation: on
       master-slave cfg: preferred slave
       master-slave status: unknown
       Link detected: no

- **If Output:** ``Link detected: yes``, the issue might be intermittent or
  resolved. Monitor the connection.
- **If Output:** ``Link detected: no``, proceed to Step 3.

**Step 3: Check Power Over Data Line (PoDL) Status**
-----------------------------------------------------
**Command:** ``ethtool --show-pse t1l1``  
**Expected Output:** Power delivery status should show as ``delivering power``.

.. code-block::

    PSE attributes for t1l1:
    PoDL PSE Admin State: enabled
    PoDL PSE Power Detection Status: delivering power

- **If Output:** ``Power Detection Status: delivering power``, then power is
  likely not the issue. Proceed to Step 4.
- **If Output:** ``Power Detection Status: over current`` or ``disabled``, check
  PSE configuration or troubleshoot possible short circuits. Recheck after
  resolving the issue.

**Step 4: Perform Cable Diagnostics**
-------------------------------------
**Command:** ``ethtool --cable-test t1l1``  
**Expected Output:** Cable test results should indicate if the cable is intact.

.. code-block::

    Cable test started for device t1l1.
    Cable test completed for device t1l1.
    Pair A code Open Circuit

- **If Output:** ``Pair A code Open Circuit``, proceed to Step 5.
- **If Output:** ``Pair A code Short within Pair``, proceed to Step 7.
- **If Output:** ``Pair A code OK``, proceed to Step 6.
- **If Output:** ``Pair A code Unknown``, proceed to Step 8.

**Step 5: Investigate `Pair A code Open Circuit` Case**
-------------------------------------------------------
- **Description:** This indicates that the cable may be damaged or not
  connected. It can also suggest that the link partner is not powered up, its
  PHY is in reset, or the interface is in admin down state.

- **Action 1: Use Fault Distance Information**
  - **Explanation:** The `Pair A, fault length:` reported by the diagnostic
    tool can be used to identify where the cable might be disconnected or
    damaged.
  - **Example Output:**

    .. code-block::

        Pair A, fault length: 25.00m

  - **Diagnostic Strategy:**
    - If the reported fault length is around 13m (the minimal detection distance
      for the dp83td510 PHY and/or current driver), and the actual cable length
      is greater than 13m:
      - **Interpretation:** The cable is likely disconnected on the local side
        or damaged within the first 13m.
      - **Next Step:** Inspect and secure the connection on the local side or
        replace the damaged section of the cable.
    - If the actual cable length is less than or equal to 13m:
      - **Interpretation:** The fault could still be due to any of the potential
        failure options, including cable damage, PHY issues, or a disconnected
        link partner.

- **Action 2: Measure Current Drawn by the Link Partner (if PoDL/PoE is used)**
  - **Explanation:** If the local PSE controller provides this functionality,
    measuring the current drawn by the link partner can help diagnose the issue.
  - **Next Step:** Use the current measurement to determine if the link partner
    is receiving power. If the current is abnormally low or zero, it indicates
    that the link partner might not be powered on or that there is a power
    delivery issue.

**Step 6: Investigate `Pair A code OK` Case**
---------------------------------------------
- **Description:** This means the cable is likely fine, but the link partner's
  PHY might be in forced slave mode with autonegotiation disabled, which can
  prevent the link from being established.
- **Action:** Test if the link partner is in forced slave mode by configuring
  the local system to operate in forced master mode.
- **Command:** 

  .. code-block::

    ethtool -s t1l1 master-slave forced-master speed 10 duplex full autoneg off

- **Explanation:** If this command establishes the link, it confirms that the
  link partner is in forced slave mode with autonegotiation disabled. You may
  need to adjust the local configuration or re-enable autonegotiation on the
  link partner for a proper link setup.

**Step 7: Investigate `Pair A code Short within Pair` Case**
------------------------------------------------------------
- **Description:** This indicates that there is a short circuit within the
  cable pairs. The diagnostic tool provides a `Pair A, fault length:` that
  indicates the distance to the fault.

- **Example Output:**

  .. code-block::

      Pair A, fault length: 25.00m

- **Diagnostic Strategy:**
  - **Use Fault Distance Information:**
    - If the reported fault length is around 13m (the minimal detection distance
      for the dp83td510 PHY and/or current driver):
      - **Interpretation:** The short is likely within the first 13 meters of
        the cable, possibly close to the local side of the connection.
      - **Next Step:** Inspect the cable for damage or improper connections
        within the first 13 meters from the local port. If the issue is found,
        repair or replace the damaged section of the cable.
    - If the fault length is greater than 13m:
      - **Interpretation:** The short circuit is located at the specified
        distance along the cable. This could indicate physical damage or
        incorrect wiring at the identified location.
      - **Next Step:** Locate the specified distance along the cable, then
        inspect for any visible damage, bends, or improper connections at that
        point. Repair or replace the affected section as necessary.

**Step 8: Investigate `Pair A code Unknown` Case**
---------------------------------------------------
- **Description:** This result indicates that the cable test cannot provide
  usable results due to noise on the cable. Since the PHY seems to perform a
  variant of Spread Spectrum Time Domain Reflectometry (SSTDR), which is
  relatively immune to usual low-amplitude noise sources, this error typically
  suggests one of two scenarios:
  1. The link partner is constantly sending autonegotiation pulses, but the
       connection cannot be established.
  2. The link partner is in a fixed master mode without autonegotiation enabled.

- **Diagnostic Strategy:**
  - **Scenario 1: Fixed Master Mode without Autonegotiation**
    - **Action:** Verify if the link partner is in fixed master mode by
      configuring the local PHY to forced slave mode.
    - **Command:**

      .. code-block::

          ethtool -s t1l1 master-slave forced-slave speed 10 duplex full autoneg off

    - **Next Step:** If this configuration establishes a link, it confirms that
      the link partner is in fixed master mode with autonegotiation disabled.
      You may need to adjust the link partner’s configuration or leave the
      local PHY in forced slave mode.

  - **Scenario 2: Autonegotiation Pulse Issue (Not Verifiable Remotely)**
    - **Explanation:** If the link partner’s PHY is enabled and continuously
      sending autonegotiation pulses, but the link cannot be established,
      this may be due to incompatible PHY capabilities. This is currently not
      verifiable remotely.
    - **Potential Causes:**
      - The link partner’s PHY announces capabilities that do not match the
        local PHY, leading to a failure to establish the link.
      - In 10BaseT1L cases, if one device is certified for a dangerous
        environment (e.g., should operate only with a 1.8V signal) and the other
        device announces both 1.8V and 2V signal capabilities, the link may be
        discarded.

  - **Scenario 3: Noise or Interference**
    - **Explanation:** Although SSTDR is resilient to common noise, significant
      or unusual noise sources might still disrupt the test.
    - **Next Step:** Investigate the physical environment for potential sources
      of interference (e.g., strong electromagnetic fields) and mitigate them
      if possible.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

