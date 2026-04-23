Return-Path: <netdev+bounces-280632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACmiEZ3J6WnAkAIAu9opvQ
	(envelope-from <netdev+bounces-280632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:26:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B824344DF44
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD9E6302925E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0412E7F2C;
	Thu, 23 Apr 2026 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b="a+qhvRdC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106105.protonmail.ch (mail-106105.protonmail.ch [79.135.106.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03552EA731
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928981; cv=none; b=PTOooGwcI6fDswjjYAQgh1QemrPFJWQGCulx3oTqrk65fH+wXIl+7uXYIHVDDHqHauP5c/wGhSPiJBnlncsEIWT8N8qBsST8hDkczJ/jUfGYN8u3wmBdhVisXzr+sX8t+4vb5wbulxHzBRhfRhIT1oSCmhQ/iJuHOfbVo+EBUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928981; c=relaxed/simple;
	bh=Zql6oEPLFC1zc2Fu3uWp2kNRrjfM5qIna8bRocrT064=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pj31RiGav/PUUcEqsPzjmaFBcLhwCUPHjUek6ciWhowU3witFlktM7mexK9MpKGD7D03XU7lO/SgaTTS8NEPFMWgckfNT8C4i7D3M5Al1g469gewnvQMNZd9RjIAmFtfssV7Cr8Igpzqh2nJD1MGEykNhUmWLnhXTq3vw9KTak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info; spf=pass smtp.mailfrom=leavitt.info; dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b=a+qhvRdC; arc=none smtp.client-ip=79.135.106.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leavitt.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leavitt.info;
	s=protonmail2; t=1776928966; x=1777188166;
	bh=70WfA9S6Jx/WAK1mUxKfr9qlNHrxRPcn/dEBSiQiGYY=;
	h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=a+qhvRdCY/3qAcO3lI6nlIRTJpoE9Nf4TFBUmXFn0vpZV5cyC1uwcbkyDu096WYk3
	 YxGAKlDBuxzRd0TcaTkQkBXkDpSbmuzm185A6yX2w2ZJMN4gB+nf8pKKWtTv7izt+Z
	 nOSuS3qWqjY18p+8ml1LkApq6JUdgkEH4Z6pzYkEj3abvn7i+PBog7e7iThYMRoVPx
	 KqfeaMNg/Wp2YGTdDASqIwyWlflAILJURezjjjglIdwJF80vAKU5BW6qLSTv+rj+Yc
	 SgIN6KPzpAlV3jDUIYsdsLgYb/oggE6T06Itkzb21cYmo2Rb3CBz+i98Ydz4ISy8rs
	 hl+f2I4GoWdxg==
Date: Thu, 23 Apr 2026 07:22:39 +0000
From: Corey Leavitt <corey@leavitt.info>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Corey Leavitt <corey@leavitt.info>
Subject: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup from MDIO probe
Message-ID: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
Feedback-ID: 22087991:user:proton
X-Pm-Message-ID: d0c546759d580ac714ef9e264c802e335e0152a3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[leavitt.info,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[leavitt.info:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280632-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@leavitt.info,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[leavitt.info:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leavitt.info:email,leavitt.info:dkim,leavitt.info:mid]
X-Rspamd-Queue-Id: B824344DF44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On systems where a PSE controller driver loads as a module and a
device-tree PHY node carries a `pses =3D <&pse_pi>` reference,
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
environments with CONFIG_PSE_*=3Dm do not have boards whose DT
references a PSE controller from a PHY. Still, the mechanism is
general. Any modular PSE driver combined with the documented
`pses =3D <&...>` binding reproduces the retry loop. Whether it
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
      net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio ho=
ok

 drivers/net/mdio/fwnode_mdio.c |  34 ----------
 drivers/net/phy/phy_device.c   | 144 +++++++++++++++++++++++++++++++++++++=
+---
 drivers/net/phy/sfp.c          |   2 +-
 drivers/net/pse-pd/pse_core.c  |  60 ++++++++++++++++-
 include/linux/phy.h            |   2 +
 include/linux/pse-pd/pse.h     |  41 ++++++++++++
 6 files changed, 236 insertions(+), 47 deletions(-)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260422-pse-notifier-decouple-efa80d77f4be

Best regards,
-- =20
Corey Leavitt <corey@leavitt.info>



