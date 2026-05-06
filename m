Return-Path: <netdev+bounces-285079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDmOAQDR+2lNFAAAu9opvQ
	(envelope-from <netdev+bounces-285079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:38:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B944E181A
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AA513000FF1
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 23:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E6A3D34A5;
	Wed,  6 May 2026 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsCCk5ON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E217A309
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778110709; cv=none; b=U3c44PYoNT1IUMt+xL0sKBFiVETv7yX7dw4LA+j7sxIXJHk/MvqG57SfC4lgaa8f32Dda69kI3P1jwzBCI+XlwBAQe0358ygIz8AQOKuX+oP9BGd7/cNEr0EBn8Sw7inXBXgtZMgXA+0EsZvoAksHyn18qw9RPoY3tScLALWvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778110709; c=relaxed/simple;
	bh=OGeVY8CJ5Bv/jYDhk7jrcFCuOc+3AvMlB/RvGmxAHD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZ12m1mlf/IBTbEDaF/m7YwJDyLM5iCd/H90HuT9pNdkyI5dvYqHivYfjAQ/5XJhVJM87io6tD43vsygd+IOeRFD0grp48azfJ84EiKptd83m/T+/NSPeoEnp/Ia0Z8CL4cOOZbKKeQJOkZSTsa6Eiq91UCFkCzYJ+cOKSdo7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsCCk5ON; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-441209fb77eso121883f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 16:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778110706; x=1778715506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi27xuT2qEFLgbH9MIgPb6PwKVxA2NXtK/AwQ2Ynx0Y=;
        b=CsCCk5ONnYBSf4QudVMvrR7vv3k/GHkE//D99y+znygQD58+a77KKQi49PhUdsZAaZ
         lA5NfIqR9a1HmKITFmn37oenlAGiubmkhltnYyZQrHz+947NPd8btnY34vJTn1qrz3Iz
         xGUb8SLaOtQoUnpWMifgU13Ly49nfemwKKopLYGs9JIw4lOHIPcqnin9rLvcA1/DxTAh
         iCWl9hx9nnWPvif4pcA47ab1jl+DKjJWCw0H5Pq/6kV2TKyu7od7qc0J4rGw7sX5krBh
         MgWGDesJ5KFg+yNZfCEjljQGwVjL6Le3rsJ7pUybcJ6sDIXBxHnCiIqWgtsiGFcgTVu7
         WOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778110706; x=1778715506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi27xuT2qEFLgbH9MIgPb6PwKVxA2NXtK/AwQ2Ynx0Y=;
        b=cxGRJMhwa4Bhxgb5FeOTIZcTRZt7286TYA8kamHVlRvq+yow0P05q/m8eAzKMYcVXQ
         iUCl9hc+Dj0/lxO1E/oAsGI5mGVPhE2Xyu391gs8Nl9NyMrvrt1z14K7q01ZmrTknlQV
         +81deC094Q7t/IhjMMPrw+99r4P5/EFC+26A4MA+NZCfZVvbIyJKz9+7hx3/dSIjGvEa
         TE8sKj8iDq7RM164QrjPrHhFT98CRmmULIBexeANH9OM3aD01YHnjXS90lXKBvYCAZOh
         hMFr8SZ4yKJcDJ3rMJELXPQqptDX+VQ75HMdQTR0V0PocbAaPOLojlz40kWa466qTo9K
         l70g==
X-Gm-Message-State: AOJu0YyFqao5UyRnXMZ86fEXvV9yFu55PTNPVDuhJ8vupQQ96qRRExUY
	Q+DdGuuiT05xdXuMVCD7pUci/mlivlH6lfAoyoegkcOwzfsWf8jWwk6g+xj6RZtN
X-Gm-Gg: AeBDiev9u6uiA2fzMmB1uXa/gENGXKB1gii67dAET2nmkCF28A/UOwkoBp+89D4n1Wg
	kMfd7PpyTITzMomQNQyUEhMambm7sJvr2Et2SxUIMpeOPsIxvZm9DhHXV4cDritmEXM+34rymSx
	ve++trJIvNlF6LFIpmpqSKgRkLpy1ONmgSQTbXB+6xr8QVlr/N0ImXltU27LfRy0GiKwSw1oEO5
	CL21dIvU08IZFW4+uuuj779WPphBar+kXSInxr3LvJs58ndSKbwav1gdzLMuJQnS7O7b2txSI7I
	e9tZEPQaD8aWvoZlEdrlg2gMu/xHtlM1ixyqjQD0Ar9EbAK1ZIjUF9acm7zzO2g+dtGnoySO80O
	vBJ4NFHTk4MGqxh7nKnYPWMvoePpDuShfs1T8HZF9zCp/pFwI7ZOiyxP10xgUoS35BKsA+t6FqB
	18tmhgFqgXYVhD1UnhB1KIDKf/A1qnFn4=
X-Received: by 2002:a05:6000:40df:b0:444:2db8:d07a with SMTP id ffacd0b85a97d-452e78b3cf2mr845609f8f.3.1778110705749;
        Wed, 06 May 2026 16:38:25 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f249bbsm13948970f8f.36.2026.05.06.16.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 16:38:25 -0700 (PDT)
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
	pabeni@redhat.com,
	jiri@resnulli.us
Subject: [PATCH net V2] net: shaper: Reject reparenting of existing nodes
Date: Wed,  6 May 2026 16:37:45 -0700
Message-ID: <20260506233745.111895-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 55B944E181A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,1g4.org,redhat.com,resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285079-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

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
Changelog:

V2:
- Add missing maintainer
- Nit: Remove null at the end of fixes tag
- Move reparenting check after parent resolution so updates
  that omit the parent argument are not incorrectly rejected

V1: https://lore.kernel.org/netdev/20260505174321.1794689-1-mohsin.bashr@gmail.com/
---
 net/shaper/shaper.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 94bc9c7382ea..1069fa4eb9f6 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -964,15 +964,22 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 	int i, ret;
 
 	if (node->handle.scope == NET_SHAPER_SCOPE_NODE) {
+		struct net_shaper *cur = NULL;
+
 		new_node = node->handle.id == NET_SHAPER_ID_UNSPEC;
 
-		if (!new_node && !net_shaper_lookup(binding, &node->handle)) {
-			/* The related attribute is not available when
-			 * reaching here from the delete() op.
-			 */
-			NL_SET_ERR_MSG_FMT(extack, "Node shaper %d:%d does not exists",
-					   node->handle.scope, node->handle.id);
-			return -ENOENT;
+		if (!new_node) {
+			cur = net_shaper_lookup(binding, &node->handle);
+			if (!cur) {
+				/* The related attribute is not available
+				 * when reaching here from the delete() op.
+				 */
+				NL_SET_ERR_MSG_FMT(extack,
+						   "Node shaper %d:%d does not exist",
+						   node->handle.scope,
+						   node->handle.id);
+				return -ENOENT;
+			}
 		}
 
 		/* When unspecified, the node parent scope is inherited from
@@ -986,6 +993,15 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 				return ret;
 		}
 
+		if (cur && net_shaper_handle_cmp(&cur->parent,
+						 &node->parent)) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Cannot reparent node shaper %d:%d",
+					   node->handle.scope,
+					   node->handle.id);
+			return -EOPNOTSUPP;
+		}
+
 	} else {
 		net_shaper_default_parent(&node->handle, &node->parent);
 	}
-- 
2.52.0


