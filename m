Return-Path: <netdev+bounces-226461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D5ABA0B7D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4061716BD64
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823412727E6;
	Thu, 25 Sep 2025 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="k9kPDkkb"
X-Original-To: netdev@vger.kernel.org
Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659894C81
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819553; cv=none; b=qw/ApKw3TO4JrqrOU8NnnUAZjq4zIETSpglH0Nr0SNibO0BhwP9aXXKl2tFyFkvLLi4cCwqBR+79ZmRqMoSz/WqsT8MP/K/FedTziJ+6BL4dbwgSD4l8l/wZnbZJeSX7SgrQZz68Hscg/YrmrE2+g0TV9gbeps2j+MYvNE5HZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819553; c=relaxed/simple;
	bh=0lCscK2BUwlmCYeZ56ApcyvQzWJkaj6zoGHieFjSZt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCxJ8Poz0KaqfOEFNnI4NCDt13sXkqLpGOBLKdTkrZN7J1+R3Bqesdbqel2HpkkeI8koXpPovDChqkWpMBU9tD/C8SYSEpX+/DJEhoo75DJVAAD3SFTCs6bxUS5aCtEIW+El/euoriA3dCK36SGMHiYuRpqSoz4jp8zstOT4GKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=k9kPDkkb; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id C5BD4806CF
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 19:53:43 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:d7c6:0:640:5e67:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id B04D7C0031;
	Thu, 25 Sep 2025 19:53:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VrcflPGN0eA0-IOiyDkTQ;
	Thu, 25 Sep 2025 19:53:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1758819214; bh=lIBVZdVrbu4ylYsMG45LpvVbCXwF4ydETKjdIdX9mRA=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=k9kPDkkb1Snu8DCqDTSquKPedt/p6IgyveHJifHB1JHixYhDwXNNL1mrlwjdry6Lw
	 VMWbcP3aUxuxYtNJ1axADrk3buwhIhyWo6H6eCLEqm0AJ1DqzNkge2QIDBGihjIWfz
	 tspxKJtYdvDialtZ93xxYuKI9Z9ywM3qjt2lnEi0=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Simon Horman <horms@kernel.org>
Cc: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v3 net-next] tipc: adjust tipc_nodeid2string() to check the length of the result
Date: Thu, 25 Sep 2025 19:51:46 +0300
Message-ID: <20250925165146.457412-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925124707.GH836419@horms.kernel.org>
References: <20250925124707.GH836419@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the value returned by 'tipc_nodeid2string()' is not used, the
function may be adjusted to check the length of the result against
NODE_ID_LEN, which is helpful to drop a few calls to 'strlen()' and
simplify 'tipc_link_create()' and 'tipc_link_bc_create()'. Compile
tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: convert to check against NODE_ID_LEN (Simon Horman)
v2: adjusted to target net-next (Tung Quang Nguyen)
---
 net/tipc/addr.c | 6 +++---
 net/tipc/addr.h | 2 +-
 net/tipc/link.c | 9 +++------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/tipc/addr.c b/net/tipc/addr.c
index fd0796269eed..90e47add376e 100644
--- a/net/tipc/addr.c
+++ b/net/tipc/addr.c
@@ -79,7 +79,7 @@ void tipc_set_node_addr(struct net *net, u32 addr)
 	pr_info("Node number set to %u\n", addr);
 }
 
-char *tipc_nodeid2string(char *str, u8 *id)
+bool tipc_nodeid2string(char *str, u8 *id)
 {
 	int i;
 	u8 c;
@@ -109,7 +109,7 @@ char *tipc_nodeid2string(char *str, u8 *id)
 	if (i == NODE_ID_LEN) {
 		memcpy(str, id, NODE_ID_LEN);
 		str[NODE_ID_LEN] = 0;
-		return str;
+		return false;
 	}
 
 	/* Translate to hex string */
@@ -120,5 +120,5 @@ char *tipc_nodeid2string(char *str, u8 *id)
 	for (i = NODE_ID_STR_LEN - 2; str[i] == '0'; i--)
 		str[i] = 0;
 
-	return str;
+	return i + 1 > NODE_ID_LEN;
 }
diff --git a/net/tipc/addr.h b/net/tipc/addr.h
index 93f82398283d..5e4fc27fe329 100644
--- a/net/tipc/addr.h
+++ b/net/tipc/addr.h
@@ -130,6 +130,6 @@ static inline int in_own_node(struct net *net, u32 addr)
 bool tipc_in_scope(bool legacy_format, u32 domain, u32 addr);
 void tipc_set_node_id(struct net *net, u8 *id);
 void tipc_set_node_addr(struct net *net, u32 addr);
-char *tipc_nodeid2string(char *str, u8 *id);
+bool tipc_nodeid2string(char *str, u8 *id);
 
 #endif
diff --git a/net/tipc/link.c b/net/tipc/link.c
index 3ee44d731700..93181b1d8898 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -495,11 +495,9 @@ bool tipc_link_create(struct net *net, char *if_name, int bearer_id,
 
 	/* Set link name for unicast links only */
 	if (peer_id) {
-		tipc_nodeid2string(self_str, tipc_own_id(net));
-		if (strlen(self_str) > 16)
+		if (tipc_nodeid2string(self_str, tipc_own_id(net)))
 			sprintf(self_str, "%x", self);
-		tipc_nodeid2string(peer_str, peer_id);
-		if (strlen(peer_str) > 16)
+		if (tipc_nodeid2string(peer_str, peer_id))
 			sprintf(peer_str, "%x", peer);
 	}
 	/* Peer i/f name will be completed by reset/activate message */
@@ -570,8 +568,7 @@ bool tipc_link_bc_create(struct net *net, u32 ownnode, u32 peer, u8 *peer_id,
 	if (peer_id) {
 		char peer_str[NODE_ID_STR_LEN] = {0,};
 
-		tipc_nodeid2string(peer_str, peer_id);
-		if (strlen(peer_str) > 16)
+		if (tipc_nodeid2string(peer_str, peer_id))
 			sprintf(peer_str, "%x", peer);
 		/* Broadcast receiver link name: "broadcast-link:<peer>" */
 		snprintf(l->name, sizeof(l->name), "%s:%s", tipc_bclink_name,
-- 
2.51.0


