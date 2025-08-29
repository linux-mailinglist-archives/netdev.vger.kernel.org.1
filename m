Return-Path: <netdev+bounces-218181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B2B3B6A5
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274BA563395
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35EB2E62D1;
	Fri, 29 Aug 2025 09:04:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4982E339E;
	Fri, 29 Aug 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458292; cv=none; b=KQ9veVWdaOro7gJDgZTb2/O5igYBnhxU2rHdIE1O0rlirIUc2latw/s9ftdJDHr3XP2ERK+882Hg2wAukfGcSoQr4IYUOHHWGcFsjTDn2ZyMuAIqhST2FAjB6UymlfKFyinptCxiZ6JUtQ0xk4aeExWlsag9BFEz5hjo5Kna10o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458292; c=relaxed/simple;
	bh=fbBKMw9IBF47m/JGG1gdhqS6Y0eNHz+HO0O98UFQ5Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reZG/bje34e/iWUH0/PfnxVMLCT4QrJBvlfTemoj8o3ldlYA+VVm8I9xzIr/O7srZDc2MIkasAYVyh3wetbAunWVqTdLV6V+Q6WjD/kA2cQOSmGD7QEUWiNlNIu+Sb+gG/KEVA/JMAUkQd/eCrhodKjaSVWUH1dc9kGvEWvkNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D25054F683;
	Fri, 29 Aug 2025 10:57:35 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH 2/9] net: bridge: mcast: track active state, foreign IGMP/MLD querier disappearance
Date: Fri, 29 Aug 2025 10:53:43 +0200
Message-ID: <20250829085724.24230-3-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250829085724.24230-1-linus.luessing@c0d3.blue>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This change ensures that the new multicast active state variable is unset
again after a foreign IGMP/MLD querier has disappeared (default: 255
seconds). If no new, other IGMP/MLD querier took over then we can't
reliably receive IGMP/MLD reports anymore and in turn can't ensure the
completeness of our MDB anymore either.

No functional change for the fast/data path yet.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 5cc713adcf9b..2e5b5281e484 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1800,6 +1800,10 @@ static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
 	br_multicast_start_querier(brmctx, query);
 
 out:
+	/* another IGMP/MLD querier disappeared, set multicast state to inactive
+	 * if our own querier is disabled, too
+	 */
+	br_multicast_update_active(brmctx);
 	spin_unlock(&brmctx->br->multicast_lock);
 }
 
-- 
2.50.1


