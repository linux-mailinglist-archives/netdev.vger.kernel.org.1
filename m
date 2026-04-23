Return-Path: <netdev+bounces-280643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBK3D4vN6WkKkgIAu9opvQ
	(envelope-from <netdev+bounces-280643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:43:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B61CE44E158
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69F9F30711A9
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DAE30EF91;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGWo7CRs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8FE30BB8D;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930135; cv=none; b=jm6LMMO4T4zITkePPST6w28zltAQJOA7YGXCqMUoADS7nNs0asnAFgn/TXT1R/FwFuH8X9p6JU08iywibfSR5C4o1pRpCY7r6J5G9XXW9BObnyo3oKD9uwBxGR4lbwJGL5CKoI5z8srVLV4XXHEu2MZZh13Aqs4kZiacjK+LbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930135; c=relaxed/simple;
	bh=SHR2yJQ/Tjbh+rC55nFexgk7YhcMTx8ekAsEFlEHgTk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HZS3ZOsy84SiDwuaxihfl9/5JOZW0Gbb2ec7SgspwJw8TL6upjkqDTyMsWA28l1oHMeVNK0dHbLp0FONg0xhDFoCInbNMOWB8seM1Zeipxd40kULscJ16nVlEE6XZIeXZc/cW5L8YmoDZ3Oa80YVvoPalgfkDyYa6E0b893OEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGWo7CRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5481DC2BCB2;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776930135;
	bh=SHR2yJQ/Tjbh+rC55nFexgk7YhcMTx8ekAsEFlEHgTk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UGWo7CRsCA6pqq11blBN+ScpTkXePRKNdgtS478DBCdUNZ1VDTb6tIInf74G6BCuO
	 c8sU75Y9OauGMsaYLRhqaQ0anvpMRFSHux9u14S9DRRiyQBQTlFvGmfrFjRP8QeG8n
	 kY9ua+hNIIT7oHJ2AkkiBGPzMa/SIeacttKWB9qum3RSt7XtyfU//RGA6l0/Q7iurr
	 hewl+j7uOmghUVwuof2GRboRxayy0G395URFB+C6/Rn8d6rhHUiKmGdjuaBABwqtoB
	 O7INsm29tYgr/b2epW54YeOEwUWhYHvE6cXox21xx58tAg9ZJ7O7JK2BTGXVTfECD2
	 QuFV3buody28A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5E0F9934C;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
From: Corey Leavitt via B4 Relay <devnull+corey.leavitt.info@kernel.org>
Subject: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup
 from MDIO probe
Date: Thu, 23 Apr 2026 01:42:13 -0600
Message-Id: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBQFrxL+2g8xFCtuBQ/gtrhokxf9IklIU
 imU3t2oy2GYWakgCwqd1EoZbykSQ4P9TpF9jOEOFteYjDYH3RnDqYBDrOIFmR1snNMLDD8etet
 7302g1qYML8vvO9D1clYBlQOWSre/LfP0hK3fNW3bBzhMoZmHAAAA
X-Change-ID: 20260422-pse-notifier-decouple-efa80d77f4be
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Corey Leavitt <corey@leavitt.info>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776930134; l=5388;
 i=corey@leavitt.info; s=default; h=from:subject:message-id;
 bh=SHR2yJQ/Tjbh+rC55nFexgk7YhcMTx8ekAsEFlEHgTk=;
 b=BtV/BevWrW5hwYx+khyDHbDE7TKm3ukK8q2aMjCdsZMF22Qb4DO/rZ49yXtFKOlR3PVVhhVTf
 n177erRh+ePC94oDFIsSyGa34zybnTgA9T3r8000oCGk4Eon3iUzQHo
X-Developer-Key: i=corey@leavitt.info; a=ed25519;
 pk=Q3mmZT+4CRYT8qp8RWvab30X2v2JnLdhHuK7YIHKzpI=
X-Endpoint-Received: by B4 Relay for corey@leavitt.info/default with
 auth_id=748
X-Original-From: Corey Leavitt <corey@leavitt.info>
Reply-To: corey@leavitt.info
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280643-lists,netdev=lfdr.de,corey.leavitt.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[corey@leavitt.info];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leavitt.info:email,leavitt.info:replyto,leavitt.info:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B61CE44E158
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On systems where a PSE controller driver loads as a module and a
device-tree PHY node carries a `pses = <&pse_pi>` reference,
fwnode_mdiobus_register_phy() tries to resolve the PSE handle before
the controller driver has probed. of_pse_control_get() returns
-EPROBE_DEFER, the enclosing MDIO/DSA probe fails, and driver-core
re-queues the work. The retry loop spins until the PSE driver module
loads and its controller registers.

Commit fa2f0454174c ("net: pse-pd: Introduce attached_phydev to pse
control") made each retry expensive. It reordered
fwnode_mdiobus_register_phy() so the PHY is registered before the
PSE lookup. Every deferral now performs a full
phy_device_register() / phy_device_remove() cycle. On a board with a
sufficiently tight watchdog the retry loop can starve the watchdog
kthread. On the reporting hardware (MT7621 + gpio-wdt, 1-second
margin) the retry loop converts a slow probe phase into a reset
before userspace loads.

The affected population today looks small. OpenWrt, where PSE
actually ships, is still on 6.12 (pre-regression), and most
environments with CONFIG_PSE_*=m do not have boards whose DT
references a PSE controller from a PHY. Still, the mechanism is
general. Any modular PSE driver combined with the documented
`pses = <&...>` binding reproduces the retry loop. Whether it
reaches brick-grade or merely slow/flaky boot depends on local
watchdog timing. More exposure is expected as distribution and
embedded kernels move to 6.13 and later.

The narrow fix would be to partially revert the ordering in
fa2f0454174c so each defer is cheap again. That keeps the same
architecture (fwnode_mdio holding PSE knowledge, -EPROBE_DEFER
flowing across the subsystem boundary), and any future reorder
reintroduces the same class of bug. This series takes the larger
fix: decouple PSE controller lookup from MDIO registration entirely.
pse_core now publishes a BLOCKING_NOTIFIER chain with REGISTERED
and UNREGISTERED events. phy_device subscribes, owns phydev->psec
lifetime, and attaches PSE handles in response to controller
lifecycle rather than during probe. fwnode_mdio loses its PSE
awareness, and -EPROBE_DEFER no longer flows out of fwnode_mdio.

Patch breakdown:

  1. Scope the pse_control regulator handle to kref lifetime
     (Fixes: d83e13761d5b). A latent bug that patch 4 makes
     reachable.
  2. Add the notifier chain (enum, head, register/unregister
     helpers). Pure infrastructure. No subscribers yet, no
     observable change.
  3. Fire REGISTERED and UNREGISTERED events from the controller
     register/unregister paths. Still no subscribers, still no
     observable change.
  4. Subscribe from the PHY layer, take ownership of phydev->psec
     via the notifier, and remove fwnode_find_pse_control() from
     fwnode_mdio.

Patch 1 is bundled here per stable-kernel-rules section 4
reachability guidance. On mainline today, with no notifier
subscriber, no caller drives the dangling regulator-handle sequence.
Patches 2 and 3 are deliberately split to separate "add
infrastructure" from "wire it up". Happy to fold them if maintainers
prefer the combined form.

Validated on a Cudy C200P (MT7621 + IP804AR) running an OpenWrt
build of 6.18.21 with the series applied. A lockdep build
(CONFIG_PROVE_LOCKING + CONFIG_DEBUG_ATOMIC_SLEEP) shows no splats
from the series' code paths during boot, PHY attach, PHY detach, or
a full controller unbind/rebind cycle. ethtool --set-pse drives all
four PoE-capable LAN ports, and a Ruckus H510 class-4 PD plugged
into lan3 negotiates and receives 48 V.

The C200P has no SFP cage, so the SFP path change in sfp.c
(phy_device_register -> phy_device_register_locked) isn't exercised
on the bench. Verified by call-graph audit: every path reaching
sfp_sm_probe_phy() holds rtnl at entry, via sfp_timeout,
sfp_check_state, sfp_probe, sfp_remove, or
sfp_bus_{add,del}_upstream.

Not addressed by this series: ethtool --show-pse returns "No data
available" on DSA netdevs in 6.18, because dev->phydev is NULL for
DSA-frontend netdevs and ethnl_req_get_phydev() therefore returns
NULL. That's a DSA / ethtool integration quirk that predates this
work.

Sending as RFC because this is my first net-next series. I'd
appreciate maintainer guidance on whether patch 1 should go to net
rather than net-next, and whether the patch 2/3 split is preferred
to the combined form.

Signed-off-by: Corey Leavitt <corey@leavitt.info>
---
Corey Leavitt (4):
      net: pse-pd: scope pse_control regulator handle to kref lifetime
      net: pse-pd: add notifier chain for controller lifecycle events
      net: pse-pd: fire lifecycle events on controller register/unregister
      net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook

 drivers/net/mdio/fwnode_mdio.c |  34 ----------
 drivers/net/phy/phy_device.c   | 144 ++++++++++++++++++++++++++++++++++++++---
 drivers/net/phy/sfp.c          |   2 +-
 drivers/net/pse-pd/pse_core.c  |  60 ++++++++++++++++-
 include/linux/phy.h            |   2 +
 include/linux/pse-pd/pse.h     |  41 ++++++++++++
 6 files changed, 236 insertions(+), 47 deletions(-)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260422-pse-notifier-decouple-efa80d77f4be

Best regards,
--  
Corey Leavitt <corey@leavitt.info>



