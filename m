Return-Path: <netdev+bounces-177686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F453A71456
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F023A47C8
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3AC191461;
	Wed, 26 Mar 2025 10:01:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2678C1F
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983307; cv=none; b=Ut9PDxBri1imnvOFTLDWZwQgbqFrza3PtGJgW0wNNRBVzmyKkQNc9AckT0lUPvdsR5PeW+Q38jkfnU4aNUCbRsFQ19yVvW8FvUXIAvgu0DKpRlu/uJ27RCe2lFsxed1XPGnY24NBGyxBmbHn5anhfyAcI08eI9ObXuGLoKoTMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983307; c=relaxed/simple;
	bh=vmGfR78GgSmopo5iBksXNIf+knROMy3RNPpIVcy5r9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1ZO/DmShR+opfua9bSkJuVKipCwe3RVEytPvBh/N8mG8AOr2Sn0/IM6PgAqQ32GDQnHMVlgAR+uzEW5NP8OscwRtWj5mwfg58yblHv+hpKT8nHmIyzWSodiZPWwN73+752biAljijSQ1JiWyGuKeRB4R/v07UbLzMKL82ZkNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1txNZZ-0005En-T3; Wed, 26 Mar 2025 11:01:21 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1txNZW-001j6C-2Z;
	Wed, 26 Mar 2025 11:01:19 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1txNZX-0004dA-0G;
	Wed, 26 Mar 2025 11:01:19 +0100
Date: Wed, 26 Mar 2025 11:01:19 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Dent Project <dentproject@linuxfoundation.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <Z-PQbyKj1CBdqIQh@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
 <20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
 <Z9gYTRgH-b1fXJRQ@pengutronix.de>
 <20250320173535.75e6419e@kmaincent-XPS-13-7390>
 <20250324173907.3afa58d2@kmaincent-XPS-13-7390>
 <Z-GXROTptwg3jh4J@p620>
 <Z-JAWfL5U-hq79LZ@pengutronix.de>
 <20250325162534.313bc066@kmaincent-XPS-13-7390>
 <Z-MUzZ0v_ZjT1i1J@p620>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-MUzZ0v_ZjT1i1J@p620>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi folks,

On Tue, Mar 25, 2025 at 08:40:54PM +0000, Kyle Swenson wrote:
> Hello Kory,
> 
> On Tue, Mar 25, 2025 at 04:25:34PM +0100, Kory Maincent wrote:
> > On Tue, 25 Mar 2025 06:34:17 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > 
> > > Hi,
> > > 
> > > On Mon, Mar 24, 2025 at 05:33:18PM +0000, Kyle Swenson wrote:
> > > > Hello Kory,
> > > > 
> > > > On Mon, Mar 24, 2025 at 05:39:07PM +0100, Kory Maincent wrote:  
> > > > > Hello Kyle, Oleksij,  
> > > > ...  
> > > > > 
> > > > > Small question on PSE core behavior for PoE users.
> > > > > 
> > > > > If we want to enable a port but we can't due to over budget.
> > > > > Should we :
> > > > > - Report an error (or not) and save the enable action from userspace. On
> > > > > that case, if enough budget is available later due to priority change or
> > > > > port disconnected the PSE core will try automatically to re enable the
> > > > > PoE port. The port will then be enabled without any action from the user.
> > > > > - Report an error but do nothing. The user will need to rerun the enable
> > > > >   command later to try to enable the port again.
> > > > > 
> > > > > How is it currently managed in PoE poprietary userspace tools?  
> > > > 
> > > > So in our implementation, we're using the first option you've presented.
> > > > That is, we save the enable action from the user and if we can't power
> > > > the device due to insufficient budget remaining, we'll indicate that status
> > > > to the user.  If enough power budget becomes available later, we'll power up
> > > > the device automatically.  
> > > 
> > > It seems to be similar to administrative UP state - "ip link set dev lan1 up".
> > > I'm ok with this behavior.
> > 
> > Ack I will go for it then, thank you!
> > 
> > Other question to both of you:
> > If we configure manually the current limit for a port. Then we plug a Powered
> > Device and we detect (during the classification) a smaller current limit
> > supported. Should we change the current limit to the one detected. On that case
> > we should not let the user set a power limit greater than the one detected after
> > the PD has been plugged.
> 
> I don't know that we want to prevent the user from setting a higher
> current than a device's classification current because that would
> prevent the PD and PSE negotiating a higher current via LLDP.
> 
> That said, I'm struggling to think of a use-case where the user would be
> setting a current limit before a PD is connected, so maybe we can reset
> the current limit when the PD is classified to the classification
> result, but also allow it to be adjusted after a PD is powered for the
> LLDP negotiation case.
> 
> In our implementation, don't really let the user specify something like,
> "Only class 3 and lower devices on this port" because we've not seen
> customers need this.  We have, however, implemented the LLDP negotiation
> support after several requests from customers, but this only makes sense
> when a PD is powered at it's initial classification result.  The PD can
> then request more power (via LLDP) and then we adjust the current limit
> assuming the system has budget available for the request.
> 
> > 
> > What do you think? Could we let a user burn a PD?
> 
> This seems like a very rare case, and if the PD is designed such that
> it's reliant on the PSE's current limiting ability then seems like it's
> just an accident waiting to happen with any PSE.
> 
> Very rarely have we seen a device actually pull more current than it's
> classification result allows (except for LLDP negotiation). What's more
> likely is a dual-channel 802.3bt device is incorrectly classified as a
> single-channel 802.3at device; the device pulls more current than
> allocated and gets shut off promptly, but no magic smoke escaped.  

Here’s my understanding of the use cases described so far, and a proposal for
how we could handle them in the kernel to avoid conflicts between different
actors.

We have multiple components that may affect power delivery:
- The kernel, which reacts to detection and classification
- The admin, who might want to override or restrict power for policy or safety reasons
- The LLDP daemon, which may request more power dynamically based on what the PD asks for

To avoid races and make things more predictable, I think it's best if each
actor has its own dedicated input.

## Use Cases

### Use Case 1: Classification-based power (default behavior)  
- Kernel detects PD and performs classification
- Power is applied according to classification and hardware limits
- No override used

Steps:
1. Detection runs
2. Classification result obtained (e.g. Class 2 → 7W)
3. Kernel computes:

   effective_limit = min(
       classification_result,
       controller_capability,
       board_limit,
       dynamic_budget
   )

4. Power applied up to `effective_limit`

### Use Case 2: Admin-configured upper bound (non-override)  
- Admin sets a policy limit that restricts all power delivery
- Does not override classification, only bounds it

Steps:
1. Admin sets `ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT = 15000`
2. Detection + classification run normally
3. Kernel computes:

   effective_limit = min(
       classification_result,
       AVAIL_PWR_LIMIT,
       controller_capability,
       board_limit,
       dynamic_budget
   )

4. Classification is respected, but never exceeds admin limit

This value is always included in power computation — even if classification
or LLDP overrides are active.

### Use Case 3: Persistent classification override (admin)  
- Admin sets a persistent limit that overrides classification
- Power is always based on this override

Steps:
1. Admin sets `CLASS_OVERRIDE_PERSISTENT = 25000` (mW)
2. Detection/classification may run, but classification result is ignored
3. Kernel computes:

   effective_limit = min(
       CLASS_OVERRIDE_PERSISTENT,
       AVAIL_PWR_LIMIT,
       controller_capability,
       board_limit,
       dynamic_budget
   )

4. Power applied accordingly
5. Override persists until cleared

### Use Case 4: Temporary classification override (LLDP)  
- LLDP daemon overrides classification for current PD session only
- Cleared automatically on PD disconnect

Steps:
1. PD connects, detection + classification runs (e.g. 7W)
2. LLDP daemon receives PD request for 25000 mW
3. LLDP daemon sets `CLASS_OVERRIDE_TEMPORARY = 25000`
4. Kernel computes:

   effective_limit = min(
       CLASS_OVERRIDE_TEMPORARY,
       AVAIL_PWR_LIMIT,
       controller_capability,
       board_limit,
       dynamic_budget
   )

5. Power is increased for this session
6. On PD disconnect, override is cleared automatically

---

### Use Case 5: Ignore detection and classification (force-on)  
- Admin forces the port on, ignoring detection
- Useful for passive/non-802.3 devices or bring-up

Steps:
1. Admin sets:
   - `DETECTION_IGNORE = true`
   - `CLASS_OVERRIDE_PERSISTENT = 5000`
2. Kernel skips detection and classification
3. Kernel computes:

   effective_limit = min(
       CLASS_OVERRIDE_PERSISTENT,
       AVAIL_PWR_LIMIT,
       controller_capability,
       board_limit,
       dynamic_budget
   )

4. Power is applied immediately

## Proposed kernel UAPI

### SET attributes (configuration input)

| Attribute                                 | Type     | Lifetime              | Owner           | Description |
|-------------------------------------------|----------|------------------------|------------------|-------------|
| `ETHTOOL_A_PSE_CLASS_OVERRIDE_PERSISTENT` | u32 (mW) | Until cleared          | Admin            | Persistent classification override |
| `ETHTOOL_A_PSE_CLASS_OVERRIDE_TEMPORARY`  | u32 (mW) | Cleared on detection failure / PD replug | LLDP daemon / test tool | Temporary override of classification |
| `ETHTOOL_A_PSE_DETECTION_IGNORE`          | bool     | Until cleared          | Admin            | Ignore detection phase |
| `ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT`       | u32 (mW) | Until changed          | Admin            | Static admin-defined max power cap (non-override) |

### GET attributes (status and diagnostics)

| Attribute                                  | Type     | Description |
|--------------------------------------------|----------|-------------|
| `ETHTOOL_A_PSE_EFFECTIVE_PWR_LIMIT`        | u32 (mW) | Final power limit applied by kernel |
| `ETHTOOL_A_PSE_CLASS_OVERRIDE_PERSISTENT`  | u32 (mW) | Current persistent override (if set) |
| `ETHTOOL_A_PSE_CLASS_OVERRIDE_TEMPORARY`   | u32 (mW) | Current temporary override (if active) |
| `ETHTOOL_A_PSE_DETECTION_IGNORE`           | bool     | Current detection ignore state |

### Power Limit Priority

Since we now have multiple sources that can influence how much power is
delivered to a PD, we need to define a clear and deterministic priority
order for all these values. This avoids confusion and ensures that the kernel
behaves consistently, even when different actors (e.g. admin, LLDP daemon,
hardware limits) are active at the same time.

Below is the proposed priority list — values higher in the list take precedence
over those below:

| Priority | Source / Field                          | Description |
|----------|------------------------------------------|-------------|
| 1        | Hardware/board-specific limit         | Maximum allowed by controller or board design (e.g. via device tree or driver constraints) |
| 2        | Dynamic power budget                  | Current system-level or PSE-level power availability (shared with other ports) |
| 3        | `ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT`       | Admin-configured upper bound — applies even when classification or override is used |
| 4        | `ETHTOOL_A_PSE_CLASS_OVERRIDE_TEMPORARY`  | Temporary override, e.g. set by LLDP daemon, cleared on PD disconnect or detection loss |
| 5        | `ETHTOOL_A_PSE_CLASS_OVERRIDE_PERSISTENT` | Admin override that persists until cleared |
| 6        | `ETHTOOL_A_PSE_CLASSIFICATION_RESULT`     | Result of PD classification, used when no override is present |

The effective power limit used by the kernel will always be the minimum of the
values above.

This way, even if the LLDP daemon requests more power, or classification result
is high, power delivery will still be constrained by admin policies, hardware
limits, and current budget.

Best regards,  
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

