Return-Path: <netdev+bounces-218182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD837B3B6AD
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C5C984194
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64EE2E7185;
	Fri, 29 Aug 2025 09:04:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397B2E3AFE;
	Fri, 29 Aug 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458292; cv=none; b=inLKd2WM3zdurC/Dqgp5u/F0M2elQFi4WN8TTlPUXhqwMfEzcrnUnDjTmKpwqURSu41rtGnLRywen0lEUjxySnBxgLRmRiKFo69BVd+Vv5r5B9aI8cdJmwhg3UnOUrvUW6dG+wVmlVCkCAArwOQP53XC14pLOgqxZpRo7fFEHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458292; c=relaxed/simple;
	bh=r+3rfB+WbGku9OYPkoNsOw1s2NBUXdF0N5hjuZ+9264=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ti2cq9enrcGRk9/Tsz/jMsSUy2t3ToPD8hSWizd5ZbCvO6V9JtVrdjvNCc0lQE2aUD6av0jL8Xd75qS9WP30TQaj6RyCa4yUgelhudaUHz+nnXI0quqJWJyf4T5EIhM8JPAwuorGOZanjWX96dRpWawsmdv6j8I/RsS1tIl/mfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D18A054F6AB;
	Fri, 29 Aug 2025 10:57:39 +0200 (CEST)
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
Subject: [PATCH 4/9] net: bridge: mcast: track active state, own MLD querier disappearance
Date: Fri, 29 Aug 2025 10:53:45 +0200
Message-ID: <20250829085724.24230-5-linus.luessing@c0d3.blue>
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

This change ensures that the new multicast active state variable is
immediately unset if our internal IGMP/MLD querier was elected and
now disabled.

If no IGMP/MLD querier exists on the link then we can't reliably receive
IGMP/MLD reports and in turn can't ensure the completeness of our MDB
anymore either.

No functional change for the fast/data path yet. This is the last
necessary check before using the new multicast active state variable
in the fast/data path, too.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b689e62b9e74..13840f8f2e5f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4849,6 +4849,7 @@ int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val)
 #endif
 
 unlock:
+	br_multicast_update_active(brmctx);
 	spin_unlock_bh(&brmctx->br->multicast_lock);
 
 	return 0;
-- 
2.50.1


