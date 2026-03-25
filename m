Return-Path: <netdev+bounces-271689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGaiCeMhxGmZwgQAu9opvQ
	(envelope-from <netdev+bounces-271689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:56:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F41932A2BF
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF06430439CA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C2540B6E4;
	Wed, 25 Mar 2026 17:54:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B9240B6F5;
	Wed, 25 Mar 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461252; cv=none; b=UE2AiGOZOTJjdSEHsB0VKX0M56m0V0Ne9OB4WU4iAZuu2FyI6tz7OKAiAJBM/CTPmy1IxfcFhfKip1shi3e56eGV5usRQsXT7G5VkSADrTB37iKVcGL8QfUHT6Ww/V6QTjW78a2hBkuJhnh2fJDxQJNsOdRf2Qr/KjZtbpXKwBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461252; c=relaxed/simple;
	bh=6eMkP510vgrrFkjdH0Sr1PLsUXpPn5XJxssWvSkhR50=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZXzR7WwFoEPuL096wYcJjb2FJHOP/LiBOEBchaHQVY+1R8EStwS/JndVgUAj4cM9/FBLUyC4aktFnq0ohSzhjKoqzOoB/tGD49Ozerm7Ab+x2oIIlDIq/NRjVqlloVvSMvDCYEItR27FfQpjsPcq871IqdcbnI78AvwrLAcPC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w5SQZ-000000002Yc-2ihI;
	Wed, 25 Mar 2026 17:53:59 +0000
Date: Wed, 25 Mar 2026 17:53:56 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Yang <mmyangfl@gmail.com>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v7 0/4] net: dsa: mxl862xx: add support for bridge
 offloading
Message-ID: <cover.1774459500.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-271689-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mxl862xx_mac_table_read.tci:url,bridge_vlan_aware.sh:url,makrotopia.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F41932A2BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As a next step to complete the mxl862xx DSA driver, add support for
offloading forwarding between bridged ports to the switch hardware.

This works pretty much without any big surprises, apart from two
subtleties:
 * per-port control over flooding behavior has to be implemented by
   (ab)using a 0-rate QoS meters as stopper in lack of any better
   option.
 * STP state transition unconditionally enables learning on a port
   even if it was previously explicitely disabled (a firmware bug)

Note that as the driver is still lacking all VLAN features (which
are going to be added next), at this point some of the
bridge_vlan_aware.sh tests are failing after applying this series.

This is expected and cannot be avoided without implementing
port_vlan_filtering + port_vlan_add/del. And adding both bridge and
VLAN offloading at the same time would be too much for anyone to
review, so VLAN support is going to be submitted in a follow-up
series immediately after this series has been accepted.

All other relevant selftests (including bridge_vlan_unaware.sh) are
still passing.

Inspired by the comments received from Paolo Abeni as reply to v5
the driver now no longer caches bridge port membership in the
driver, but instead imports an existing helper from yt921x.c to dsa.h
in order to allow the driver to easily iterate over bridge members.
The mapping between DSA bridge num and firmware bridge ID is done
using a simple fixed-size array in mxl862xx_priv.

Changes since v6:
 * drop wrong addition of 'priv' pointer to struct dsa_bridge
   -> use simple array to track firmware bridge to dsa bridge mapping
 * move existing dsa_bridge_ports() helper from yt921x.c to dsa.h
 * replace propesed dsa_bridge_for_each_member() by new
   dsa_switch_for_each_bridge_member() taking (struct net_device *)
   instead of (struct dsa_bridge *), aligned with the existing
   helpers
 * fix bridge allocation resource leak in case of
   mxl862xx_sync_bridge_members() failing for the first port to join a
   bridge
 * zero-initialize struct mxl862xx_cfg in mxl862xx_set_ageing_time
 * set initial=1 to always reset cursor at start when interating over
   FDB in .fdb_dump
 * hack zero-rate meter to truly always block
 * use asynchronous worker for port_set_host_flood which runs from
   atomic context and hence cannot sleep
 * reorder function to minimize diffstat of planned follow-up
   commits

Changes since v5:
 * add new DSA helpers to interate over bridge members
 * add driver-private pointer to struct dsa_bridge
 * eliminate struct mxl862xx_bridge and driver-private bridge list,
   store firmware bridge FID in new dsa_bridge->priv instead
 * rework sync_bridge_members() to use dsa_bridge_for_each_member()
   instead of for_each_set_bit() on driver-private portmap
 * rework port_bridge_join/leave to use dsa_bridge.priv for first-
   member detection and dsa_bridge_ports() for empty-bridge check
 * derive active FID from dp->bridge->priv in set_bridge_port()
 * simplify allocate_bridge()/free_bridge() to take struct dsa_bridge
   pointer directly, drop kzalloc/kfree/list management
 * simplify get_fid() to read db.bridge.priv directly
 * remove mxl862xx_find_bridge()
 * remove unnecessary default bridge config call in setup()

Changes since v4:
 * move link-local check before dsa_strip_etype_header()
 * introduce port_map helpers
 * properly implement port_mdb_{add,del} operations

Changes since v3:
 * add missing cpu_to_le32 in mxl862xx_bridge_config_fwd()
 * use little-endian 32-bit type for (unused) age_timer API field
 * better comment in port_set_host_flood() documenting architectural
   limitation
 * fix typo in comment "matche" should be "matches"
 * few whitespace fixes

Changes since v2:
 * refactor .port_bridge_join and .port_bridge_leave as requested
   by Vladimir Oltean
 * include linux/etherdevice.h which was missing and causing build
   to fail (it accidentally slipped into a follow-up patch)
 * remove left-over manual reset of learning state for port leaving
   bridge
 * remove unnecessary call to mxl862xx_port_fast_age() for port
   leaving bridge
 * add kernel-doc comments in mxl862xx.h instead of sporadic inline
   comments covering only some of the struct members
 * some other minor cosmetics (linebreaks, whitespace) here and there

Changes since v1:
 * don't set dsa_default_offload_fwd_mark() on link-local frames
 * fix kernel-doc comments in API header
 * use bitfield helpers for compound tci field in fdb API
 * add missing endian conversion for mxl862xx_stp_port_cfg.port_state
   as well as mxl862xx_mac_table_read.tci (spotted by AI review)
 * drop manually resetting port learning state on bridge<->standalone
   transitions, DSA framework takes care of that
 * don't abort updating bridge ports on error, return error at the end
 * report error in mxl862xx_port_bridge_leave()
 * create mxl862xx_get_fid() helper and use it in
   mxl862xx_port_fdb_add() and mxl862xx_port_fdb_del()
 * propagete error of callback function in mxl862xx_port_fdb_dump()
 * manually mxl862xx_port_fast_age() in mxl862xx_port_stp_state_set()
   to avoid FDB poisoning due to race condition

Daniel Golle (4):
  net: dsa: move dsa_bridge_ports() helper to dsa.h
  net: dsa: add bridge member iteration macro
  dsa: tag_mxl862xx: set dsa_default_offload_fwd_mark()
  net: dsa: mxl862xx: implement bridge offloading

 drivers/net/dsa/mxl862xx/mxl862xx-api.h | 225 ++++++-
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h |  20 +-
 drivers/net/dsa/mxl862xx/mxl862xx.c     | 752 ++++++++++++++++++++++--
 drivers/net/dsa/mxl862xx/mxl862xx.h     | 131 +++++
 drivers/net/dsa/yt921x.c                |  13 -
 include/net/dsa.h                       |  16 +
 net/dsa/tag_mxl862xx.c                  |   3 +
 7 files changed, 1104 insertions(+), 56 deletions(-)

-- 
2.53.0

