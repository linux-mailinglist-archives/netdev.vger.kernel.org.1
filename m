Return-Path: <netdev+bounces-283399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VYKQOOjw9WmVQgIAu9opvQ
	(envelope-from <netdev+bounces-283399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:41:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BC4B1EC8
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C53273007CA7
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3C33DEF2;
	Sat,  2 May 2026 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8J9fLqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07036C9D2
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725667; cv=none; b=cmDthmnP1cWQngJt+0Qg+wYzW2OWIoRAM3Z95xz5ieSMWSVu8Qi8TzPNbWr0fHZl/kBOxFgB6LFU2BwUyRsUlYrn3Ru+Uf3TitpZ7q7M1HIKlbfThl8uu6goy1OduO58ljYPWRRMw6dxrttMhwR+hQqhnAl/LVbZDSNxgQQAdQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725667; c=relaxed/simple;
	bh=ApU1GU1C7yGW1LBRgXxwcA1qb+fao6bUE9J1PXZmSyQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F1PLJkupZa3tkknuynhUfy7R8YZKRtov0/pLSsISvq+iRMcOu8mgpIYpTlVj5NZSaHKBKYkUMi+QTKlKyiKdSvegf0JxM6qNW7sLAiZpbaUrTgijix57rTH3aHrmfv3l12JT3+bxl2vWR4+tLEskjVQYaNokXPuIYJGIiJ2yQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8J9fLqy; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50edf0245b0so62017041cf.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777725665; x=1778330465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3DsAenGuWvbfIA1LvHZ3248x/ZAvEuHcIa0tq4zus7M=;
        b=o8J9fLqyEJGOC6BzAZWKwDs8tPxXi1bhqDvGfYR418Vvsjm4en2FWZubCZf3IEwt76
         Y9VM9+F9nSZssMh65hm+PD48M6S4dEcvy89fSlsm3WqDQPx9aL7MZ0oWfQEoEJ40YDml
         /jTRFrv3C4FbIKW2mT+aCQUf7L3tm1uk5ou0aqY5cEToZLLHkEOs4ZT/eClkPqiL+GfQ
         4xlIGVyfa/41BMRUV+M2xFv1/sTwfXsqeS/9c3RZnt2O63XSA0JxsUzIY284L/HG89Wk
         PdmjXL2qDMja5W2iw0jlaUD0KHZn9jiZtYO5fQqKu/KKNvdCmF9qDGDheunUogG0FxLB
         S3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777725665; x=1778330465;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DsAenGuWvbfIA1LvHZ3248x/ZAvEuHcIa0tq4zus7M=;
        b=Pw/HEYtCyBEslheoePYwcZRE4AplTxnkGUdVp7sTI5cSKPYiBqArs5bobLOi96q8bP
         UaNku576IHV0jpXX5EbcZXpCxUMPbbjN+jS3VKwHxwlWFH6rWcGN5u+cdSVgu1lLM7vD
         JjGj+buyovp75Mtmc8fif3UIDL08ocqdgmQukKT+jD2JjR60nNBw8y4Le42eyLGftY0v
         cPjkcmVgBeCbEuWuexfYLtanrT18tqKZnoXPxxP9cqJhbGdzqkX2N+UJcDsVhqLelepN
         2bnXDiQ6WpkM5+jw0clI9fAj7OiGJpKRbpQoHaBsG3vZx4TWZ17vq/SKpxcS6ZYS3b5s
         b/jw==
X-Forwarded-Encrypted: i=1; AFNElJ+lxt7cBeaJqEL3D2pSjxIs5KzpCrqA4oZL6QRRRig5HPwk2h6YpTUn4rGb3FrWpA8E+SQX3uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUqYAcMBXQ63XkkQvE1hJrGJ7kdi+UHNIJv1MkT7Ds1a727Lqi
	FftoS2xq2qbHDDMAmlSpJEow5o0fIMXYS9VMX+r2XvzRZuWVpSKPD3/93ec7jv/mz6VTo3SWbY2
	ePI6DV1QrW8ycBA==
X-Received: from qthk7.prod.google.com ([2002:ac8:747:0:b0:50d:47cc:48f7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:148b:b0:50d:a301:2fc0 with SMTP id d75a77b69052e-5104be4ff24mr40948761cf.26.1777725664388;
 Sat, 02 May 2026 05:41:04 -0700 (PDT)
Date: Sat,  2 May 2026 12:41:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502124102.499204-1-edumazet@google.com>
Subject: [PATCH net] net: prevent possible UAF in rtnl_prop_list_size()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 288BC4B1EC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283399-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

I was mistaken by synchronize_rcu() [1] call in netdev_name_node_alt_destroy(),
giving a false sense of RCU safety at delete times.

We have to use list_del_rcu() to not confuse potential readers
in rtnl_prop_list_size().

[1] This synchronize_rcu() call was later removed in commit 723de3ebef03
("net: free altname using an RCU callback").

Fixes: 9f30831390ed ("net: add rcu safety to rtnl_prop_list_size()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 06c195906231a39ef58dfff299964a3419d87c88..8bfa8313ef62eda9fe6aa037c6a5408df54e91cf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -371,7 +371,7 @@ static void netdev_name_node_alt_free(struct rcu_head *head)
 static void __netdev_name_node_alt_destroy(struct netdev_name_node *name_node)
 {
 	netdev_name_node_del(name_node);
-	list_del(&name_node->list);
+	list_del_rcu(&name_node->list);
 	call_rcu(&name_node->rcu, netdev_name_node_alt_free);
 }
 
-- 
2.54.0.545.g6539524ca2-goog


