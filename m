Return-Path: <netdev+bounces-257316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF6WAp0UhWkh8QMAu9opvQ
	(envelope-from <netdev+bounces-257316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:07:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F34F7F10
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1358E30115AC
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8F532FA17;
	Thu,  5 Feb 2026 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJwh4m7A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A943D28A3EF;
	Thu,  5 Feb 2026 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770329241; cv=none; b=KubIlUcXKC7zXAHs8drkP65OqMYNckPp7Aru/WvwjFckSYCUqtqZCsGn/xZ+cabUEYPAyXzMgLo7tnw1ADxJlYSOuhQKJaI5yX8959ZsSprqAVBank5+jmjV4mcxTzDLzcTNtFePg1AnCXuItTMyIpbLTWRLB7axpZcQcmROjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770329241; c=relaxed/simple;
	bh=eMJ2Nzro0JFUNNIfB+sTNQrje4HKqIjU6wTN/iWewC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YP6FvYu5ios4+dpNwgLNYrh/ISgA7podmPL7qEUHd+t2FkLDSCSN3MJFWbv7nP4r7Z+1PDdOJwW9SsQ8ViocafRTWaAa0liZeO128k4ve9zaNNt3EqPKR0tto9/8zN3VSW2ucgaQb+kkdxsPItJ0n1i5OCO9AZvlqosURNHV4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJwh4m7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C0EC4CEF7;
	Thu,  5 Feb 2026 22:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770329241;
	bh=eMJ2Nzro0JFUNNIfB+sTNQrje4HKqIjU6wTN/iWewC4=;
	h=From:To:Cc:Subject:Date:From;
	b=iJwh4m7AOE00qqTYbE5RcMqxMgjEe2znIpcmBrk/83LE70vg01nHmi7INZ5FPVKug
	 tplTU+1/BGwQPQyLQf4vue9MPUQ6x2F4a+sxh+ofE8qGkSTxwHQWG1m+ai88V3xnxs
	 BL8Xg8obo0gjVS2O/OL50WZ9Vw71wuN1QEU/Hvhoy62P0s+zo74lQmKanJgFD5FQKn
	 QhzYzzTInNv4lwAmA2Ea+op49l2hGQf8gfMLXXh2T/9N+NZQXz2VbJIvvzZG2R2jbN
	 mI7QVmwH985Bs9Qp2ipZN7BpQ6ceT07Ats2nqwoklHOt0tNrLBwIZQKXT3MrsXl8Wo
	 mGhgxs/wrzo+Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/9] net: stats, tools, driver tests for HW GRO
Date: Thu,  5 Feb 2026 14:05:32 -0800
Message-ID: <20260205220541.2992807-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257316-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61F34F7F10
X-Rspamd-Action: no action

Add miscellaneous pieces related to production use of HW-GRO:
 - report standard stats from drivers (bnxt included here,
   Gal recently posted patches for mlx5 which is great)
 - CLI tool for calculating HW GRO savings / effectiveness
 - tests for the stats, packet ordering and depth

Jakub Kicinski (9):
  eth: bnxt: gather and report HW-GRO stats
  tools: ynltool: factor out qstat dumping
  tools: ynltool: add qstats analysis for HW-GRO efficiency / savings
  selftests: net: move gro to lib for HW vs SW reuse
  selftests: drv-net: give HW stats sync time extra 25% of margin
  selftests: drv-net: gro: use SO_TXTIME to schedule packets together
  selftests: drv-net: gro: test GRO stats
  selftests: drv-net: gro: add test for packet ordering
  selftests: drv-net: gro: add a test for HW-GRO depth

 tools/testing/selftests/drivers/net/Makefile  |   1 -
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/net/lib/Makefile      |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  17 +-
 tools/net/ynl/ynltool/qstats.c                | 170 +++++---
 .../selftests/{drivers/net => net/lib}/gro.c  | 242 +++++++++++-
 .../testing/selftests/drivers/net/.gitignore  |   1 -
 tools/testing/selftests/drivers/net/gro.py    |   2 +-
 .../selftests/drivers/net/hw/gro_hw.py        | 374 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/env.py       |   4 +-
 tools/testing/selftests/net/lib/.gitignore    |   1 +
 12 files changed, 748 insertions(+), 70 deletions(-)
 rename tools/testing/selftests/{drivers/net => net/lib}/gro.c (87%)
 create mode 100755 tools/testing/selftests/drivers/net/hw/gro_hw.py

-- 
2.53.0


