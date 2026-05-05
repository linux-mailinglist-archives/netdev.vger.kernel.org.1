Return-Path: <netdev+bounces-284539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L0GGLws+mlXKgMAu9opvQ
	(envelope-from <netdev+bounces-284539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:45:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EBA4D2457
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D556330048F2
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCB34A33F6;
	Tue,  5 May 2026 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nROiCBya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560FB4A33E3
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003064; cv=none; b=VJ+sYdSoBgPL1SXBHa0ZMTV7sQWDqscdlZuYdfICfVqNe6Mw7jw6DJqG5lwZ0hJNrNXmZ5uMRC7H/dk9h4rbMFmE6217QDRjTUPSaimF28d5UdugXYUYQxs2MCmdvXD0phZFFNdlx5+MZWL5pZ0bzqUdUO90e3hVhuK/R3NQANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003064; c=relaxed/simple;
	bh=y20cL5iZCiSFVhg8JJj9aG7733O1XsqG83retGM8OPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MV/EnsHt5Lhrj9vy/g9aZuY/+kH+MkI3hgS9J90ni5Rudq3FqTIB1KuEpfNPOr8s/wZXlMq9c+KbcFOm/+Q5yxD+n/YSt0knmscdK/08/GlQK4btc4MtfgMzNqzNNEz91PIJcT2Y6s8NwLOOncAwY6gbMv8gtp/BmswiL9glRJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nROiCBya; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso49269265e9.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003059; x=1778607859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VRVr8PiIFgnWbCMbwvqDK2cmVgiWGr+wh06H9kngd8w=;
        b=nROiCByawUbugqZAFMuSjqSLnmfgNq7GxPRgckX9lISKbhx7by3extcgQ5oaO1IxKT
         4H+66iu+cQfoM3mmqOIM0rzxh7NMxcYLacWbJ2rTfyszTm9/CXujymDVJXFVT/i8C1Rv
         gtMWxPJ3i/EaJkA8xJpyXNDpyTz98wAgglBJBPEimSatr1oS8yiU30S5pAo24judo0y+
         169dHJgoD4K/4MMY25yUIuQuHraFN+uSxRqN5VWl6wv6B7dbb6I34X94rU9lu0M6nXOq
         pFp6J4B1i/NQN+CqvQw8fnsG671m80ZEr+vOx5+yBRXaVSFy/8MTsMxwWhPldYwxiuwJ
         YHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003059; x=1778607859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRVr8PiIFgnWbCMbwvqDK2cmVgiWGr+wh06H9kngd8w=;
        b=LEhGh3N4X9iSuKwLW5Ne6KiW1bAjuFCt8P+HHYmh3lppGOf7TRY1/xsklHJ74efkSF
         ODHR4DwfgSUQfVYTrazJgHyTgKSwXTRmsg7ZTjWnQNUaMeEBQZ8d9STqwtN2Tmp86o2C
         XkHUeqCmqqZqrsroZTIa8T93YmT3nUquRspOBcYo8A1a4AvBCHFbIgbuRYtWc3eQMXhE
         e20OmohZ+Z1uYpkaJNCVd1kthRTCX/ithG2u7n5PX2n3M3NxaUjZeEqJCIuaAdgcvYbC
         P47KEBmVTmgEnbRtBi610UT+cmqjK4Jdh4Oi1e6R4hEqdHDR/u6oi60L8tBef4sEKnGZ
         UZdg==
X-Gm-Message-State: AOJu0Yz9eJqtMKtTYvRR6+NP5YDgKRKD+x3fpt13KdOOQsBmEHuh3r4o
	W+TPCoMZo7oEPjaxbdvWQVv3EBrfOAg6dvBT5ByICzL6UgM9ey/1KA/EFHmNZDEP
X-Gm-Gg: AeBDiesG3d+pgX+Uqq4trZxPBJZQM+9Y4Yj0tNOrMHYclBhlhup677aVPaQ56oQUmch
	2DpvCz2iZIWerwKOKJ6JVrZ+JOzm2E601AwBQsPboFl/MetJCoyVMug4zWIs0D/XUfUe5fFVZoR
	XuA9uB/MfDUey/MLhKTGFkq0BFIKwUqGElkrYO52CtnU4gKyiqqvGRbnYWKnel5LQMOAVglEGiM
	Etz04SzUKxlnit7Dz5qzzoMiqyZPuTPsOpTE5sIwI+mwKM5LcAlhW/COUgTgx3sRtsAejeuuNvp
	ZSXrk1Ry6m0hjrpThywQDVVbHVsSFEc4t+52ct3BS/ZXlIomr4JkOxfj55UEwCtXy2OXKssAv7G
	Fz+PYjAJ61sUUQVgKTYd8kqSPXUuWkUsPSUMYcaLF8XkWAoxdfzyq/170lJ8ol2SKx07rkFY0UD
	jF1hDpKS2tSGsKE4ku4DMtJ2AS23apVCo=
X-Received: by 2002:a05:600c:354b:b0:48a:554d:b9a2 with SMTP id 5b1f17b1804b1-48e51e0c7c9mr4062065e9.6.1778003058809;
        Tue, 05 May 2026 10:44:18 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1f::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69800sm359072365e9.2.2026.05.05.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:44:18 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kees@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	p@1g4.org,
	pabeni@redhat.com
Subject: [PATCH net] net: shaper: Reject reparenting of existing nodes
Date: Tue,  5 May 2026 10:43:21 -0700
Message-ID: <20260505174321.1794689-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C8EBA4D2457
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,1g4.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-284539-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,handle.id:url]

When an existing node-scope shaper is moved to a different parent
via the group operation, the framework fails to update the leaves
count on both the old and new parent shapers. Only newly created
nodes (handle.id == NET_SHAPER_ID_UNSPEC) trigger the parent
leaves increment at line 1039.

This causes the parent's leaves counter to diverge from the
actual number of children in the xarray. When the node is later
deleted, pre_del_node() allocates an array sized by the stale
leaves count, but the xarray iteration finds more children than
expected, hitting the WARN_ON_ONCE guard and returning -EINVAL.

Rather than adding reparenting support with complex leaves count
bookkeeping, reject group calls that attempt to change an existing
node's parent. Updates to an existing node's rate or leaves under
the same parent remain permitted. We expect that for any modification
of the topology user should always create new groups and let the
kernel garbage collect the leaf-less nodes.

Fixes: 5d5d4700e75d ("net-shapers: implement NL group operation")

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 net/shaper/shaper.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 94bc9c7382ea..81e32e91bade 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -966,13 +966,26 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 	if (node->handle.scope == NET_SHAPER_SCOPE_NODE) {
 		new_node = node->handle.id == NET_SHAPER_ID_UNSPEC;
 
-		if (!new_node && !net_shaper_lookup(binding, &node->handle)) {
-			/* The related attribute is not available when
-			 * reaching here from the delete() op.
-			 */
-			NL_SET_ERR_MSG_FMT(extack, "Node shaper %d:%d does not exists",
-					   node->handle.scope, node->handle.id);
-			return -ENOENT;
+		if (!new_node) {
+			struct net_shaper *cur;
+
+			cur = net_shaper_lookup(binding, &node->handle);
+			if (!cur) {
+				/* The related attribute is not available
+				 * when reaching here from the delete() op.
+				 */
+				NL_SET_ERR_MSG_FMT(extack, "Node shaper %d:%d does not exist",
+						   node->handle.scope,
+						   node->handle.id);
+				return -ENOENT;
+			}
+			if (net_shaper_handle_cmp(&cur->parent,
+						  &node->parent)) {
+				NL_SET_ERR_MSG_FMT(extack, "Cannot reparent node shaper %d:%d",
+						   node->handle.scope,
+						   node->handle.id);
+				return -EOPNOTSUPP;
+			}
 		}
 
 		/* When unspecified, the node parent scope is inherited from
-- 
2.52.0


