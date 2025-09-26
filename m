Return-Path: <netdev+bounces-226608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE1FBA2D9F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 790084E20A8
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 07:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1505283FC8;
	Fri, 26 Sep 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="q6feCbA/"
X-Original-To: netdev@vger.kernel.org
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387F1EC01B
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872868; cv=none; b=S+7S0fA92F/PLyvahxrE+NJDKzqA/quNqh1HAq+Dh0rKrKaVSh0S/62pfg0ZbvUmCBJ7/hL5wGh7QSNCxTo+a8hOsasBzRsCdariSyvxiJPXXtzUaiZY1oxLDV8MtPejyXv76dwMjkeyLxQIgOHZw2Wgt7wo4L1MQ67+DP4qJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872868; c=relaxed/simple;
	bh=hXbS6OwSmlO7g3gQCtjy8ueIBwjk+CHQSMmGBuA0gMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XP2JJveYBYyktVsQQugOZnJ7veZca01l8xvMmNVisSbXgkmnGb6zBLWLXckT+jD3lHYBDfXinauCuZPdI6yG22o7NugI5KPWfQNGQV80fBB6yZMTy05w36Tp0ncpaQjK5hWs6kH2dEkjNPed1atV/IH9RJ12M3vqJWitZqe2NI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=q6feCbA/; arc=none smtp.client-ip=178.154.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward201a.mail.yandex.net (Yandex) with ESMTPS id 369EB86A93
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 10:41:25 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:6148:0:640:ada2:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id E0637C005E;
	Fri, 26 Sep 2025 10:41:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id DfUVYVjMpiE0-z5KRxTFQ;
	Fri, 26 Sep 2025 10:41:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1758872476; bh=Rs5Tkx7qdNN3cfm2N8nRTi0IUtnglLhN1K4uIT0ExqI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=q6feCbA/YGbTB7TZzoG+Baj6mNI/i9bSJyXGY4fO3Y7rAl2WPuiVQnUmNk8GAV0Sf
	 Mrxl5FB5jm0UgDgZT6RmwJauTGkefokzLPKjpmjQXMlG+TH6Kz6aBf318/sWEVoxEh
	 gif+iyjWVHdQzkWUmnfCb2cDCw4nyVcHj72j+h8Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Simon Horman <horms@kernel.org>,
	Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v4 net-next] tipc: adjust tipc_nodeid2string() to return string length
Date: Fri, 26 Sep 2025 10:41:13 +0300
Message-ID: <20250926074113.914399-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <GV1P189MB1988AF3D7C3BC2F0F8DE2491C61EA@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <GV1P189MB1988AF3D7C3BC2F0F8DE2491C61EA@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the value returned by 'tipc_nodeid2string()' is not used, the
function may be adjusted to return the length of the result, which
is helpful to drop a few calls to 'strlen()' in 'tipc_link_create()'
and 'tipc_link_bc_create()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: revert to v2's behavior and prefer NODE_ID_LEN over
    explicit constant (Tung Quang Nguyen)
v3: convert to check against NODE_ID_LEN (Simon Horman)
v2: adjusted to target net-next (Tung Quang Nguyen)
---
 net/tipc/addr.c | 6 +++---
 net/tipc/addr.h | 2 +-
 net/tipc/link.c | 9 +++------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/tipc/addr.c b/net/tipc/addr.c
index fd0796269eed..6f5c54cbf8d9 100644
--- a/net/tipc/addr.c
+++ b/net/tipc/addr.c
@@ -79,7 +79,7 @@ void tipc_set_node_addr(struct net *net, u32 addr)
 	pr_info("Node number set to %u\n", addr);
 }
 
-char *tipc_nodeid2string(char *str, u8 *id)
+int tipc_nodeid2string(char *str, u8 *id)
 {
 	int i;
 	u8 c;
@@ -109,7 +109,7 @@ char *tipc_nodeid2string(char *str, u8 *id)
 	if (i == NODE_ID_LEN) {
 		memcpy(str, id, NODE_ID_LEN);
 		str[NODE_ID_LEN] = 0;
-		return str;
+		return i;
 	}
 
 	/* Translate to hex string */
@@ -120,5 +120,5 @@ char *tipc_nodeid2string(char *str, u8 *id)
 	for (i = NODE_ID_STR_LEN - 2; str[i] == '0'; i--)
 		str[i] = 0;
 
-	return str;
+	return i + 1;
 }
diff --git a/net/tipc/addr.h b/net/tipc/addr.h
index 93f82398283d..a113cf7e1f89 100644
--- a/net/tipc/addr.h
+++ b/net/tipc/addr.h
@@ -130,6 +130,6 @@ static inline int in_own_node(struct net *net, u32 addr)
 bool tipc_in_scope(bool legacy_format, u32 domain, u32 addr);
 void tipc_set_node_id(struct net *net, u8 *id);
 void tipc_set_node_addr(struct net *net, u32 addr);
-char *tipc_nodeid2string(char *str, u8 *id);
+int tipc_nodeid2string(char *str, u8 *id);
 
 #endif
diff --git a/net/tipc/link.c b/net/tipc/link.c
index 3ee44d731700..931f55f781a1 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -495,11 +495,9 @@ bool tipc_link_create(struct net *net, char *if_name, int bearer_id,
 
 	/* Set link name for unicast links only */
 	if (peer_id) {
-		tipc_nodeid2string(self_str, tipc_own_id(net));
-		if (strlen(self_str) > 16)
+		if (tipc_nodeid2string(self_str, tipc_own_id(net)) > NODE_ID_LEN)
 			sprintf(self_str, "%x", self);
-		tipc_nodeid2string(peer_str, peer_id);
-		if (strlen(peer_str) > 16)
+		if (tipc_nodeid2string(peer_str, peer_id) > NODE_ID_LEN)
 			sprintf(peer_str, "%x", peer);
 	}
 	/* Peer i/f name will be completed by reset/activate message */
@@ -570,8 +568,7 @@ bool tipc_link_bc_create(struct net *net, u32 ownnode, u32 peer, u8 *peer_id,
 	if (peer_id) {
 		char peer_str[NODE_ID_STR_LEN] = {0,};
 
-		tipc_nodeid2string(peer_str, peer_id);
-		if (strlen(peer_str) > 16)
+		if (tipc_nodeid2string(peer_str, peer_id) > NODE_ID_LEN)
 			sprintf(peer_str, "%x", peer);
 		/* Broadcast receiver link name: "broadcast-link:<peer>" */
 		snprintf(l->name, sizeof(l->name), "%s:%s", tipc_bclink_name,
-- 
2.51.0


