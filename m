Return-Path: <netdev+bounces-292877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I7vBtfNGGpjnggAu9opvQ
	(envelope-from <netdev+bounces-292877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:20:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E0C5FB5C7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6E813011A40
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E27B3672AC;
	Thu, 28 May 2026 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un1ABmln"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC430F924
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010209; cv=none; b=LNfqoFpkR+ETHtJms12jmsZ1APGgMTzhplilVYb8nKFVPkoJAtnMqAkcGBFfpp1Uw6/VJ+TRVlsINMzRr5olUt7tpkDWxXpsycM/u8yvztX/iTTp5YBogIvY268IPPgsv/dOSPCW9XqwXdZ3bYqMIIoPZ4bavx0zcbe/LZbBnW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010209; c=relaxed/simple;
	bh=vm9iqCYXRxPK4oodevKfo/7IcLZh38H68RRwdT6OpOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNBt4h2D76Mw1GBDczM+TlD2xJ9XbmKqgZYyLj9dynzFIUZPljrUjUP1TGiUKZ/E2bwTi9cTUDeNWEiyuN02b2Dgbkzh2YR/Kw4AEObJotbDOWNiKBEp2vwv7sSyTO68Wr3mx8by0sHm57LqXdvFft0le90VLr1cHA5Yp8SxkQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un1ABmln; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1711F000E9;
	Thu, 28 May 2026 23:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010208;
	bh=nrmBRjcqOdiI5LVFSKUbl/zVoo7nWhUsfW/6EE533kA=;
	h=From:To:Cc:Subject:Date;
	b=Un1ABmln/Gmzmj+XvkFod9K5xw1H5KPspmryns6UAnBI3iqvSNFCEwSvjeZ5XQh9A
	 BleX8JhRO73Oz5Lz09OlBj32Jmc2m6K0/CqyaaVLTScMa7wE66XjoPyEYKQ6EURyj2
	 j3h8kXRaBMPzMnzG97hYf3rKeTafYur+G5n3wvrg9o1+XJswTV/KpQiKM8aQiKQ5Fp
	 dgLTCNxDDcbRn6x3guIppshMQj4KLBJpqhI7CJmxl43R5d5KKUB9W/FfX000EZABLF
	 qKmgoZnT1mYRb0xPxZcHBNo76S8jFMKjbIuhUokMfGn22KCkR3/VhPBrbDY7xQVI2A
	 3VcDThavFvBBg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/14] net: ethtool: let ops locked drivers run without rtnl_lock
Date: Thu, 28 May 2026 16:16:23 -0700
Message-ID: <20260528231637.251822-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292877-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 89E0C5FB5C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We have been slowly moving towards removing the rtnl_lock dependency
in driver ops since the concept of "ops-locked" drivers have been
introduced last year. Since last year will take the netdev instance
lock before invoking any ndo or ethtool op of "ops-locked" drivers.

We dipped our toes into rtnl_lock-less ops with the queue binding API.
Queue stats, NAPI, and other netdev-netlink objects are also queried
without holding rtnl_lock already. It's time to take the next logical
step and lift the requirement from ethtool ops.

The direct motivation for this patchset is that ethtool ops often
involve communicating with device FW, and may take a long time
to complete. Aggressive polling of device state on machines
with 10+ NICs have been shown to significantly increase rtnl_lock
pressure.

There's a handful of areas which still need rtnl_lock (see below).
I decided to convert everything to rtnl_lock-less by default, and
add a set of flags which let the drivers request rtnl_lock to still
be taken. I don't love this, but I'm worried that opt-in would be
even more confusing.

Known issues / exclusions:
 - qdiscs - qdisc configuration currently assumes rtnl_lock, this
   is mostly impacting set_channels callback. qdisc config is probably
   the easiest one of the exclusions to tackle, it's fairly self-contained.
 - features - even tho feature changes are (correctly) plumbed to
   the driver thru ndos they are part of ethtool uAPI. ethtool itself
   calls netdev_features_change() if it spotted device changing features
   in response to the request. And some drivers call it themselves.
   Since features have to propagate to upper and lower devices anything
   that touches features is quite hard to take from under rtnl_lock.
 - phylink - phylink and SFP depend on rtnl_lock today, I suspect
   that this is purely for historic reasons. I started poking at
   it and don't really see a need for a global lock. But accessing
   the netdev instance lock from the SFP entry points will require
   some attention from the phylink folks.
 - phydev - similar to phylink, looks quite doable. But no ops-locked
   driver currently has a phydev (fbnic only uses phylink) so phydev
   related paths retain a ASSERT_RTNL() for now.

Tested on mlx5, bnxt and fbnic.

Jakub Kicinski (14):
  net: ethtool: cmis_cdb: hold instance lock for ops locked devices
  net: ethtool: make sure __ethtool_get_link_ksettings() is ops-locked
  net: ethtool: serialize broadcast notification sequence allocation
  net: ethtool: relax ethnl_req_get_phydev() locking assertion
  net: ethtool: make dev->hwprov ops-protected
  net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops
  net: ethtool: optionally skip rtnl_lock on Netlink path for SET ops
  net: ethtool: optionally skip rtnl_lock in cable test handlers
  net: ethtool: optionally skip rtnl_lock in ethnl_tsinfo_dumpit()
  net: ethtool: optionally skip rtnl_lock in ethnl_act_module_fw_flash()
  net: ethtool: optionally skip rtnl_lock in RSS context handlers
  net: ethtool: ioctl: concentrate the locking
  net: ethtool: optionally skip rtnl_lock on IOCTL path
  docs: net: ethtool: document ops-locked drivers and op_needs_rtnl

 Documentation/networking/netdev-features.rst  |   7 +
 Documentation/networking/netdevices.rst       |  17 ++-
 include/linux/ethtool.h                       |  38 ++++-
 include/linux/netdevice.h                     |   3 +
 include/linux/phy_link_topology.h             |   5 +
 include/net/netdev_lock.h                     |  17 +++
 net/ethtool/common.h                          |  76 ++++++++++
 net/ethtool/netlink.h                         |   1 -
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +
 drivers/net/ethernet/google/gve/gve_ethtool.c |   2 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   3 +
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   2 +
 .../mellanox/mlx5/core/ipoib/ethtool.c        |   2 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   5 +
 .../ethernet/microsoft/mana/mana_ethtool.c    |   2 +
 drivers/net/netdevsim/ethtool.c               |   1 +
 drivers/net/phy/phy_device.c                  |   3 +
 drivers/net/phy/phy_link_topology.c           |  10 ++
 net/core/dev_ioctl.c                          |   4 +-
 net/ethtool/cabletest.c                       |  12 +-
 net/ethtool/cmis_cdb.c                        |   3 +
 net/ethtool/cmis_fw_update.c                  |   8 +-
 net/ethtool/ioctl.c                           | 135 ++++++++++++++----
 net/ethtool/linkinfo.c                        |   4 +-
 net/ethtool/linkmodes.c                       |   4 +-
 net/ethtool/mm.c                              |   5 +-
 net/ethtool/module.c                          |   8 +-
 net/ethtool/netlink.c                         |  62 +++++---
 net/ethtool/phy.c                             |   1 -
 net/ethtool/rss.c                             |  21 +--
 net/ethtool/tsconfig.c                        |  10 +-
 net/ethtool/tsinfo.c                          |  32 ++---
 32 files changed, 385 insertions(+), 122 deletions(-)

-- 
2.54.0


