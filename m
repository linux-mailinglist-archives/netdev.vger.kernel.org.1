Return-Path: <netdev+bounces-225596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A4EB95DBA
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444BD3A7F94
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E23161AC;
	Tue, 23 Sep 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ag6dmO9j"
X-Original-To: netdev@vger.kernel.org
Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5506A2AF00
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631135; cv=none; b=n8/wh48YKudPLt9NSF035K8MHM3CuLglnnnPolbeYMoAMeY9EtSApGfsiBj1RKlRQCzW+oqCGLNgiIaDufArTb07+FC6WGyiW0jOmExwsThtgFt0xfvewQWM2eUCsRsji85I5CPj5jlkX1RzZy//ST7bSm7J73Tp0X/P1jJKMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631135; c=relaxed/simple;
	bh=Yi0pYd13YexmNn8fJo6Hg0/b/+/uF5r76P1KpGNuu8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWerbJBc0WCDLzr1e2mAvZO7JB+2UBz3gahIqnI13wvFnGQ+68yzNkMcH7okHMZHsqeiJx+DQlXvvVy3V02hQGPLZZ4L6vEThcV6ykWZ1akCfVGrfe4N06AuLli0J1ok1XYLdLM+0FVfk2ACrn2VsstUTbFqEYCrqhLKJ1H2RZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ag6dmO9j; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id 605AC85FF7
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 15:33:11 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4f41:0:640:844:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 4A430C006A;
	Tue, 23 Sep 2025 15:33:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0XW0098L3Ko0-995CR1JH;
	Tue, 23 Sep 2025 15:33:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1758630782; bh=nbURxOa40Qcvi6mGF3Wp+FKD8urt/0sEWXtNGgtc0Y4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ag6dmO9jPdTLSzorX3lL+UsMRGQ+h6SNkG0ZDo3r83LyUE8C5jd663HeLLg2+b6SO
	 +QjP8Fi2CwNZnRdgGj/FRtiwyqLVzkMyFwXj542+vdBl2skr8xocXz45JN1Huq1lje
	 MwKEx89KePz2DO3jXOrTxmqtLjLspJ8kgeJTKZO0=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jon Maloy <jmaloy@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] net: tipc: adjust tipc_nodeid2string() to return string length
Date: Tue, 23 Sep 2025 15:31:48 +0300
Message-ID: <20250923123148.849753-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.51.0
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
 net/tipc/addr.c | 6 +++---
 net/tipc/addr.h | 2 +-
 net/tipc/link.c | 9 +++------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/tipc/addr.c b/net/tipc/addr.c
index fd0796269eed..a8fd119047e4 100644
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
+		return NODE_ID_LEN;
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
index 3ee44d731700..e61872b5b2b3 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -495,11 +495,9 @@ bool tipc_link_create(struct net *net, char *if_name, int bearer_id,
 
 	/* Set link name for unicast links only */
 	if (peer_id) {
-		tipc_nodeid2string(self_str, tipc_own_id(net));
-		if (strlen(self_str) > 16)
+		if (tipc_nodeid2string(self_str, tipc_own_id(net)) > 16)
 			sprintf(self_str, "%x", self);
-		tipc_nodeid2string(peer_str, peer_id);
-		if (strlen(peer_str) > 16)
+		if (tipc_nodeid2string(peer_str, peer_id) > 16)
 			sprintf(peer_str, "%x", peer);
 	}
 	/* Peer i/f name will be completed by reset/activate message */
@@ -570,8 +568,7 @@ bool tipc_link_bc_create(struct net *net, u32 ownnode, u32 peer, u8 *peer_id,
 	if (peer_id) {
 		char peer_str[NODE_ID_STR_LEN] = {0,};
 
-		tipc_nodeid2string(peer_str, peer_id);
-		if (strlen(peer_str) > 16)
+		if (tipc_nodeid2string(peer_str, peer_id) > 16)
 			sprintf(peer_str, "%x", peer);
 		/* Broadcast receiver link name: "broadcast-link:<peer>" */
 		snprintf(l->name, sizeof(l->name), "%s:%s", tipc_bclink_name,
-- 
2.51.0


