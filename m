Return-Path: <netdev+bounces-278512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKBRIyBg3mn+CQAAu9opvQ
	(envelope-from <netdev+bounces-278512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:41:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA8A3FC09C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0812A3023D67
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858113D902A;
	Tue, 14 Apr 2026 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VCEU6llp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE92DA768
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181195; cv=none; b=dyXMuL0JlvRUXljh4rN0K+eswGgm8qmXn/wpPlJgNwnG7ewZZvigNTA9Vdo9P6Tv5e7mI6jiRm6JOmVA+SLfp6WZlX0UbIVuDu06ZZA2KEc3AIeBKfUlrLhcOBbgd/E0iQBHtJ0W97YiiNY5z845VheFuzAOu3xOdY68Or7VHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181195; c=relaxed/simple;
	bh=mxut1PkXQRo0l14ieYyl/5kLa9LofThSlO6BcIGNVpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVbp8zU9svNmto8mYBI/y37LpqDuQLPA/TVLjgAo7HS1f+5eqmHlK4jkFAHrdCDCFTimoGh0vKTwLyC/DS6endaV1ywvQSP+03nYSccUz0CjOBTysdGfEkWmCifWUcRiJpr6DVdWOgpwS5SzhprCwKsB/QSCCnyaulP2offl57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=VCEU6llp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436D0C2BCB5;
	Tue, 14 Apr 2026 15:39:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VCEU6llp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1776181193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNAQQQKcj7LooQ11Ru3wVQgPPA9e1wOhZxTzTxnMs0s=;
	b=VCEU6llp9poMiQEdmWdvxk6lcE83jdTcgYK5+AKaj1NsDEjQKBC3GPW7LbPLRo3pQtYvQL
	rbSekdbInzvfpMFzlyUH9mTqOl1XcfvDZaznm+DqrjVLuq8OWfj6oDRz9TNDDD1WUrLiwt
	orxba8wzCQlqEooPYeRqp9hIwwK0jbU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 24d2e3fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Apr 2026 15:39:52 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Fushuai Wang <wangfushuai@baidu.com>,
	Simon Horman <horms@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 1/4] wireguard: allowedips: Use kfree_rcu() instead of call_rcu()
Date: Tue, 14 Apr 2026 17:39:41 +0200
Message-ID: <20260414153944.2742252-2-Jason@zx2c4.com>
In-Reply-To: <20260414153944.2742252-1-Jason@zx2c4.com>
References: <20260414153944.2742252-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278512-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,zx2c4.com:email,zx2c4.com:dkim,zx2c4.com:mid]
X-Rspamd-Queue-Id: 8FA8A3FC09C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Fushuai Wang <wangfushuai@baidu.com>

Replace call_rcu() + kmem_cache_free() with kfree_rcu() to simplify
the code and reduce function size.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/allowedips.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 09f7fcd7da78b..5ece9acad64d8 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -48,11 +48,6 @@ static void push_rcu(struct allowedips_node **stack,
 	}
 }
 
-static void node_free_rcu(struct rcu_head *rcu)
-{
-	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
-}
-
 static void root_free_rcu(struct rcu_head *rcu)
 {
 	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = {
@@ -271,13 +266,13 @@ static void remove_node(struct allowedips_node *node, struct mutex *lock)
 	if (free_parent)
 		child = rcu_dereference_protected(parent->bit[!(node->parent_bit_packed & 1)],
 						  lockdep_is_held(lock));
-	call_rcu(&node->rcu, node_free_rcu);
+	kfree_rcu(node, rcu);
 	if (!free_parent)
 		return;
 	if (child)
 		child->parent_bit_packed = parent->parent_bit_packed;
 	*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
-	call_rcu(&parent->rcu, node_free_rcu);
+	kfree_rcu(parent, rcu);
 }
 
 static int remove(struct allowedips_node __rcu **trie, u8 bits, const u8 *key,
-- 
2.53.0


