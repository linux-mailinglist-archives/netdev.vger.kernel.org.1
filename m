Return-Path: <netdev+bounces-290943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPvVHq/jEGqOfAYAu9opvQ
	(envelope-from <netdev+bounces-290943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:15:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1A5BB698
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3704630087AF
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC47C368941;
	Fri, 22 May 2026 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpCYcNTK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC22222CC
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491604; cv=none; b=PTC1Vi2v/iSu7TC31viUYL6l/WbfywTgjWOEdY7EizQLZkenb1f8R6FrKukVjCXyt09JWE0oR84f21jkf76yz3yOaEpw1XitU3mWCrPrdZxsWLegC90IV+s7vg3WV2HLHDCTNcxOd5Q7CULeUmKb0r69moCC/ZV3lEGGBtl+XX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491604; c=relaxed/simple;
	bh=040Ejc4FUvNnpzZsHJnlKEb/EZclA8AdlmcFM2ADZVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQG2o4LHb579QdB13evvjGVm5N09uHUMe9GozXJGKcRzE5duinebg3wBuMvSuGKIKdR9ybGX8H9BSDvNMwVSKqFpTCTYEUiHAaiBZPXgzomoPb3CKlSYFsXd+PE1DakD4gGIBevMgLDgOiB2oOjYShcFmLQVU0oZcQziIPZIf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpCYcNTK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7E61F000E9;
	Fri, 22 May 2026 23:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491603;
	bh=vIF2EbefxDJPm+EDgW5WEQyB8VRovxZpg+xTLYEruaU=;
	h=From:To:Cc:Subject:Date;
	b=QpCYcNTKCWvyR7OwSw82c/Uav6ShuQ8XkKmcEwuQ5ZBrIusGiI4nfNhUBzcLNtHCT
	 vWkM+GwIS0FmGDkLsSAN7ZGOT1cOCztwAv0uqICjFQ41A80zjs+L/W5uk9sQSdxkUQ
	 E3q9wz9jbe+jbVeI4Z9llK/zHcgs8FQxYD/wDZUbrjD6cxNii77h9E/xN2QjiO6r6G
	 Tm8OzVritKlsJ/MbA3Do8ufqbVS6fkJ18bioqqH4WzQFAYP18LyYeCdrbmhSENLphI
	 TqFmMNCi9YoDBDB9KlcVc8LgRlBPCcyyqF0miCo+w595TpqdbyXiDz/Ce0bWD++MFj
	 ejkE/m+l7iD7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	petrm@nvidia.com,
	o.rempel@pengutronix.de,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/9] ethtool: module: fix a handful of small bugs
Date: Fri, 22 May 2026 16:13:03 -0700
Message-ID: <20260522231312.1710836-1-kuba@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-290943-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0EE1A5BB698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I've been poking at the locking in ethtool and it appears
that the FW flashing is not currently taking the ops lock.
Existing drivers which implement module FW flashing seem
to have their own locking, so this series doesn't actually
add the ops lock (I'll add it in net-next). But a number
of other errors have been surfaced in the process.

Jakub Kicinski (9):
  ethtool: module: call ethnl_ops_complete() on module flash errors
  ethtool: module: avoid leaking a netdev ref on module flash errors
  ethtool: module: avoid racy updates to dev->ethtool bitfield
  ethtool: module: check fw_flash_in_progress under rtnl_lock
  ethtool: module: fix cleanup if socket used for flashing multiple
    devices
  ethtool: cmis: require exact CDB reply length
  ethtool: cmis: fix u16-to-u8 truncation of msleep_pre_rpl
  ethtool: cmis: validate start_cmd_payload_size from module
  ethtool: cmis: validate fw->size against start_cmd_payload_size

 net/ethtool/cmis.h           |  4 ++--
 net/ethtool/netlink.h        |  4 ++--
 net/ethtool/cmis_cdb.c       |  9 ++++++--
 net/ethtool/cmis_fw_update.c | 44 ++++++++++++++++++++++++------------
 net/ethtool/module.c         | 41 ++++++++++++++++++++-------------
 net/ethtool/netlink.c        |  4 ++--
 6 files changed, 68 insertions(+), 38 deletions(-)

-- 
2.54.0


