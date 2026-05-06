Return-Path: <netdev+bounces-284610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBBRAg6G+mlCPgMAu9opvQ
	(envelope-from <netdev+bounces-284610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:06:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C514D4E18
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 002F0301FF3E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4A13AF2;
	Wed,  6 May 2026 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ/WYYQr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0374C8EB;
	Wed,  6 May 2026 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025993; cv=none; b=Kp56kjaQoAIN6KxwdnjBvKftSkv0wngZUHN1l10+p8+tboh3Xbv/KdtZweoDBckmpx3DjDPM/roRwbNETzdG2mfkSr1kk8tlXtiF9Fcp8IrqH5xvxz++TTDtgxq1IqUTi0HKRfLCKxVyTgC9MhZ15tBt/g5jlwiJ2Upo9iu50ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025993; c=relaxed/simple;
	bh=ONwt/hlRuteP/FkMOQdRkcff0d/hObda8RQUYRWno7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPXdcgJ6rHWpc8PdDwcZnS9CquBePgUfbGm4nZy1txAEnjuVHEdMTuqaycrVzP1HiNLfIAjbRm0MRMi74b3Zq/pL47lw6lS+mfWh43wOM8wWqzqA4c9HdTurwqxJxRKwu55AfTX/M5FoOu/yuxyf/7D7jKl6XLSGiYuRCAS5dyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ/WYYQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BCDC2BCB4;
	Wed,  6 May 2026 00:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025993;
	bh=ONwt/hlRuteP/FkMOQdRkcff0d/hObda8RQUYRWno7w=;
	h=From:To:Cc:Subject:Date:From;
	b=UJ/WYYQr2x1iQ7ksU+iKro534IEeURnxyXy2gaCMX/a4zuoxsaKDaZwCq90duD+YP
	 LMfpcVRTh9Bkxi6qVDWQd5Cy2EAuI5R1PWZyaNydvw4X3GB9ZQzFZqU6n42tWj4G1Q
	 j+mGgkGYlymu5Mbl1+f9IBq776wGGiEKeMi8JtrZE1KqjC7uzjuYO1kYY62iTLFs6V
	 qj/1Gi/Qwu4jVYGt5v5rxOakvwj7XLh7xjA/GRCnIXc/w04NChT8FBHnN1lDnFDyLP
	 1r2ZJHHm07c59eENRuSzbjjGzOMxdkMFLC0R2g8dbZqVB7KJKXLyqY663NOG3+Zwph
	 6TrlWYf7M8Jpg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 00/12] net: shaper: fix various minor bugs
Date: Tue,  5 May 2026 17:06:16 -0700
Message-ID: <20260506000628.1501691-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A4C514D4E18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284610-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Fix various minor bugs in the net shaper API.

First 4 changes are a bit hairy. The readers are currently under
RCU so we need to be careful how we update and insert the nodes.
Patch 4 is a bit of a cop-out. Pre-allocating replacement nodes
is complex. If the workaround is not acceptable I'd seriously
consider making the readers take the instance lock.

Only other patch of note is patch 10. We want to add a Netlink
policy check on the handle ID. This necessitates patch 9.

The rest are simple and self-explanatory.

Jakub Kicinski (12):
  net: shaper: drop redundant xa_lock() bracketing
  net: shaper: flip the polarity of the valid flag
  net: shaper: fix trivial ordering issue in net_shaper_commit()
  net: shaper: try to avoid violating RCU
  net: shaper: reject duplicate leaves in GROUP request
  selftests: drv-net: add shaper test for duplicate leaves
  net: shaper: set ret to -ENOMEM when genlmsg_new() fails in group_doit
  net: shaper: fix undersized reply skb allocation in GROUP command
  tools: ynl: add scope qualifier for definitions
  net: shaper: reject handle IDs exceeding internal bit-width
  net: shaper: enforce singleton NETDEV scope with id 0
  net: shaper: reject QUEUE scope handle with missing id

 Documentation/netlink/genetlink-c.yaml        |   9 +
 Documentation/netlink/genetlink-legacy.yaml   |   9 +
 Documentation/netlink/genetlink.yaml          |   9 +
 Documentation/netlink/specs/net_shaper.yaml   |   7 +
 net/shaper/shaper_nl_gen.h                    |   2 +
 net/shaper/shaper.c                           | 171 +++++++++++++-----
 net/shaper/shaper_nl_gen.c                    |   7 +-
 tools/net/ynl/pyynl/ynl_gen_c.py              |  31 +++-
 tools/testing/selftests/drivers/net/shaper.py |  25 ++-
 9 files changed, 216 insertions(+), 54 deletions(-)

-- 
2.54.0


