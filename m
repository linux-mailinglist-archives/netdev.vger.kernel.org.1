Return-Path: <netdev+bounces-201700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D332AEAAC2
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 01:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A2D163917
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879621773F;
	Thu, 26 Jun 2025 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5z26mbK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C712DDA1
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750981170; cv=none; b=kKWOqVPONhmC3tRMKpBmYm1Lwr7jcOLRJMZhwFirsCFmZklES9CWGbdvLWcrZAqSC5PD06P4ufcEQNZCF4O9bVcJkSmYB6g9LA4uII7Ifzb35lx/2saWGlHSL3a5GFRPMp2B2ra+E+KTnv+dGGm5XDActY5k7r29VAOC5AExefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750981170; c=relaxed/simple;
	bh=kR7hO07nB1bT3lGkJlFL3a/HSTQhabE1OfV/fDx4LyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M8KFbGPPVV2o9Veg/ydO0rTRFJ0yOc9yi9kio4jiz+iHW6UJpA1ibOeGrMNK6wsHVQxgMdWz/p5fjNVeOvl8+O/jCws1EZJCGi5pibfsDor25D1DRGIjWHJIzaN2PGwz0vKRdFgHx9zvsFQo9oYXDvl2WbPJXox2yLjeok9Drs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5z26mbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972B1C4CEEB;
	Thu, 26 Jun 2025 23:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750981170;
	bh=kR7hO07nB1bT3lGkJlFL3a/HSTQhabE1OfV/fDx4LyY=;
	h=From:To:Cc:Subject:Date:From;
	b=m5z26mbKApOa2j/RxYYsvDX+yM9RGBjCxVv3wfS/u0+qBZIS3doyOtmAc2lSpMfkP
	 Tq6+R8IOT2uaYPnp2fs4zZmQfmh4ZTxx10xbNfB1nliFgl21jR9xM062RjKKB94Bgd
	 Fw1lLpAkF0n0vHvppEbctIJnn5tMJF7DNV6S9ZypXKnwR9i1zleC22V+VAIWTFK5zT
	 b209bsn/qw8qY/3oXgeu7JxlRYayNW5lOUWR1H32GyPIopm4fJgf/Prq3kDBN/lOtK
	 nTtVCGTYUVuEMWLxeFd+OUWGg9+ffRb5lzqLuJVaq27aIsEeL24h6LklOmEko4Gedg
	 Qg5Tm/oTatWOw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+430f9f76633641a62217@syzkaller.appspotmail.com,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Subject: [PATCH net-next] net: ethtool: avoid OOB accesses in PAUSE_SET
Date: Thu, 26 Jun 2025 16:39:26 -0700
Message-ID: <20250626233926.199801-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We now reuse .parse_request() from GET on SET, so we need to make sure
that the policies for both cover the attributes used for .parse_request().
genetlink will only allocate space in info->attrs for ARRAY_SIZE(policy).

Reported-by: syzbot+430f9f76633641a62217@syzkaller.appspotmail.com
Fixes: 963781bdfe20 ("net: ethtool: call .parse_request for SET handlers")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
---
 net/ethtool/netlink.h | 2 +-
 net/ethtool/pause.c   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 373a8d5e86ae..94a7eb402022 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -467,7 +467,7 @@ extern const struct nla_policy ethnl_channels_set_policy[ETHTOOL_A_CHANNELS_COMB
 extern const struct nla_policy ethnl_coalesce_get_policy[ETHTOOL_A_COALESCE_HEADER + 1];
 extern const struct nla_policy ethnl_coalesce_set_policy[ETHTOOL_A_COALESCE_MAX + 1];
 extern const struct nla_policy ethnl_pause_get_policy[ETHTOOL_A_PAUSE_STATS_SRC + 1];
-extern const struct nla_policy ethnl_pause_set_policy[ETHTOOL_A_PAUSE_TX + 1];
+extern const struct nla_policy ethnl_pause_set_policy[ETHTOOL_A_PAUSE_STATS_SRC + 1];
 extern const struct nla_policy ethnl_eee_get_policy[ETHTOOL_A_EEE_HEADER + 1];
 extern const struct nla_policy ethnl_eee_set_policy[ETHTOOL_A_EEE_TX_LPI_TIMER + 1];
 extern const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX + 1];
diff --git a/net/ethtool/pause.c b/net/ethtool/pause.c
index f7c847aeb1a2..0f9af1e66548 100644
--- a/net/ethtool/pause.c
+++ b/net/ethtool/pause.c
@@ -168,6 +168,7 @@ const struct nla_policy ethnl_pause_set_policy[] = {
 	[ETHTOOL_A_PAUSE_AUTONEG]		= { .type = NLA_U8 },
 	[ETHTOOL_A_PAUSE_RX]			= { .type = NLA_U8 },
 	[ETHTOOL_A_PAUSE_TX]			= { .type = NLA_U8 },
+	[ETHTOOL_A_PAUSE_STATS_SRC]		= { .type = NLA_REJECT },
 };
 
 static int
-- 
2.50.0


