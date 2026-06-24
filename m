Return-Path: <netdev+bounces-301671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WtuXFybmO2o2fAgAu9opvQ
	(envelope-from <netdev+bounces-301671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:13:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E56BEFF9
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:13:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=iM1eUJyr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301671-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301671-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD92D3022B6E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02A13BE65F;
	Wed, 24 Jun 2026 14:13:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC23BE16F;
	Wed, 24 Jun 2026 14:13:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310426; cv=none; b=oXp6kdtM/APs0LlODd8ES9v1CIPAt5jkgBFYemzzoxe98kPA9i6AYL7YWgkJGwZwLjNJC0JU2+L4069OFvAmZEk3lXk5zRpOQaG+XNtdTDzAKmspADPeCHcPFVL9Fgjntkbt2f1/NlYmS6GOjaaKmtjqQHBCi+z/STyRUgs0Y54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310426; c=relaxed/simple;
	bh=6yWkG9PW+032UiDeSgeMjm/fI49U2DAbsrsd18VgFMM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mumIt4cU7ce6Svm8oY90ATFIvCNj1Mntw9/ibHbQC9K7l/rdpYQXxDuK+5xGmVmASyKWSmZaZV7atDwCSD/hiKVlyYqaxFp9bt1Ro20kuAvOK22ScFlHjWKiMw2u296DTawuTlHqAI5Zas9SsMhKTnlAHp+Gp3Elt0hbFDtvpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iM1eUJyr; arc=none smtp.client-ip=113.46.200.227
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EuKBtsStI+IbD385S1gTKavPswm9jCgAZ91EbOUF964=;
	b=iM1eUJyrtVlKvFhHSeevM96mdbBaCE2sB0KtvBn6TFqIKEXYBFMp4PWvum3aOGUaGI8N12zRv
	PW0XQbRvr6HJ6i7OVI8HHCaNCwvqARjFW/mgbw0gZPaKsJtkjRR44fPZWdVXrkMJnrjM5fps12u
	48OM5lRDET0iYL4anCO1MM0=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4glkGH0dMXznTVF;
	Wed, 24 Jun 2026 22:04:55 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id DBB6540565;
	Wed, 24 Jun 2026 22:13:38 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 22:13:38 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net 0/4] net: hns3: fix configuration deadlocks and refactor link setup
Date: Wed, 24 Jun 2026 22:13:15 +0800
Message-ID: <20260624141319.271439-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301671-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shaojijie@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 329E56BEFF9

This patch series addresses a sequence of link configuration deadlocks
and parameter contamination issues in the hns3 network driver, which
typically occur during hardware resets or driver initialization under
specific user-configured scenarios.

The bugs root from asynchronous discrepancies between the MAC state
machine and cached user requests during sudden hardware resets, leading
to invalid parameter combos or frozen registers.

Changes in V2:
- Squashed the former patch 5 ("fix init failure caused by lane_num
  contamination") into patch 2, introducing the req_lane_num separation
  directly where the helper is created. This avoids a bisect-time
  regression where an intermediate commit could fail probe with an
  inconsistent (speed, lane_num) pair.
- Added a NULL phydev guard in patch 1 (hclge_set_phy_link_ksettings)
  to prevent a kernel panic when firmware reports PHY_INEXISTENT on a
  copper port. The previous netdev->phydev check was lost during the
  ethtool refactor.
- In patch 1, for copper ports where neither IMP firmware nor a kernel
  PHY is available (e.g. PHY_INEXISTENT), hclge_set_phy_link_ksettings()
  now returns -ENODEV, and hns3_set_link_ksettings() catches this error
  to proceed to the existing MAC-level path (check_ksettings_param
  -> cfg_mac_speed_dup_h), preserving compatibility with PHY-less copper
  deployments.
- Preserved the 1000BASE-T forced-mode rejection in the kernel PHY
  path inside the new hclge_set_phy_link_ksettings() wrapper, closing
  a gap identified in community review.
- Fixed a link-loss regression in patch 4 where fiber ports in forced
  mode would be configured with the static default_speed instead of the
  firmware-probed SFP speed, by synchronizing req_speed from mac.speed
  when req_autoneg is overridden to AUTONEG_DISABLE.
- Rewrote the commit message of patch 2 to accurately describe the
  init/reset path asymmetry and the req_lane_num rationale.

The series is organized as follows:
- Patch 1 refactors the ethtool link settings entry path to unify copper
  port handling (both native kernel PHY_LIB and firmware-controlled PHY)
  and ensures req_xxx configurations are uniformly saved across all modes.
  For PHY_INEXISTENT copper ports, -ENODEV is returned to allow fallthrough
  to MAC-level configuration.
- Patch 2 refactors the MAC initialization by extracting the autoneg and
  speed configuration logic out of hclge_mac_init() into a dedicated
  helper function, and introduces req_lane_num to isolate the user-
  requested lane count from firmware-overwritten mac.lane_num.
- Patch 3 fixes a permanent link-down deadlock after a reset by ensuring
  that the driver caches and uses the user's intended autoneg/speed
  settings (req_***) rather than unsynchronized runtime states or
  SPEED_UNKNOWN tokens.
- Patch 4 fixes a link loss issue on optical ports during initialization
  by differentiating autoneg default values between copper and fiber
  media types, and synchronizing req_speed with the firmware-probed
  SFP speed when forced mode is detected.

Shuaisong Yang (4):
  net: hns3: unify copper port ksettings configuration path
  net: hns3: refactor MAC autoneg and speed configuration
  net: hns3: fix permanent link down deadlock after reset
  net: hns3: differentiate autoneg default values between copper and
    fiber

 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  31 +++--
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 108 ++++++++++++++----
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   1 +
 3 files changed, 102 insertions(+), 38 deletions(-)


base-commit: d87363b0edfc7504ff2b144fe4cdd8154f90f42e
--
2.33.0

