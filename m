Return-Path: <netdev+bounces-293860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOiOHkHIHWpReQkAu9opvQ
	(envelope-from <netdev+bounces-293860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:58:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D833623995
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C60230867A6
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8C3E1683;
	Mon,  1 Jun 2026 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8F6f95b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A137374E47
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336482; cv=none; b=RJazrskjGKVsyjT7irKv5Crg0YCe4pdwJU2fTeUZEnAeF8RYhKuq1GrnH5h2wmTrPVuxPq0YKIHgIflEUhyRaWDeVsLRnX4coOOyBmZgCuCXj0Onrju6n7yTIYfQkFkozE+28eSYv8Y0fS+uF9tT7T8G7Up8w9PYwxOJoH5ySy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336482; c=relaxed/simple;
	bh=QuWfugOytXeO0b1wxF7bijlHGp2GMNN8F233BLpEMgg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6JYzGDZ+x/J017km7eU9BWc4kEDkb4pIMXgpGc+iqBpy6tQFPGrY4zEvIVqpU+m0HThEUgBA9V3yRnTHK0hGMXK1dMcYwkpmNBmNAAHihDVDNZ9n1C6Ibst4QobBi9bTbITCm9toYyQYpDM9rCUOloxc0JeTv/ej5qHUdOdJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8F6f95b; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84237a15547so1377958b3a.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336480; x=1780941280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWseiq4uumqZ00yU9HO4tB0QQ4Oyj0zXYc8zVlVyTfE=;
        b=P8F6f95b7KJdDMz7iffRimJstrr4lBRbF2McyRW3+7yQm+Mw9wmr3sjKng7fZmPFPi
         M6sZBZgLzhhq6r3STjl3BABjdjIMn/VCfyqIgQUsI5QZu1peGEPbpNuZmIiNsSG/XmuI
         +ROl6RPEQE70Hv3vHt/cyMZHk/eSrh0+Ik37q0Ff2M4gFrc37eMqjQeaYLycGflpG/6B
         aOqhXQGZMjMKv8fyKMFNCbMqt1j2nEMiM5fBq8XvPXY64qZwEfIlKcEDTd1ZN17OlZyT
         HmYHbSn+9WgZ5dlRxFvxjR3xSClbMnLx9ttTDxP33TQ1gmJ7lMRR4XzlQZ4qNkQFynBH
         CaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336480; x=1780941280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWseiq4uumqZ00yU9HO4tB0QQ4Oyj0zXYc8zVlVyTfE=;
        b=pIs/IjihI6XLHJt18wwEJPGfw6qmA2T+q54kBwtQIbR5uOX3RIgS5D1IO/RznX8Yzh
         Ot8q74BONzysICoP9pnawOWBXYHGCIlPRwzgzrOzcip67bgyWt9AcH3tALuS4EzY9xAw
         BgPEgrVta/YYIrUT32qeoTwP707onIuivpHFwqGqa91UPB14OjbDt/GHgHvuP1TXO1gJ
         f05EBMtVEY9wwvgCqxeJxdAYg/C394Z6apw+UxdxMflb1ZidlhDEfmPDyAutOGsUR1SJ
         WnwAHdiFR1xyLHQkRXT2j6gxfKhoPx7o72NYxjJl73XB/DTakMAOyLuKFmuLgDES7jng
         joYA==
X-Gm-Message-State: AOJu0YxQ4Zr2H2T/AFN54N1d07iDZGHS83jViq/CQy6I0r2LRhWnUjGO
	w/vL0gqj6C/qnerTxIg1GS/F0zePW4zgc7mypHElLgnb3d5uxy62vgXPbG2YbQXdJNZ4FHXDsL0
	iFDKvoJGlul6Mb3seK/gj9zwyJB7vKpZi1Kzzn/DkLRGkFa+DGluUmfLHf3MUNxoYquFdqwBIU/
	TLWCZTPN9QB0PHJLjGbeIPic+DvoUpC18ySdj/z214mnu1XUZS1aMJKWIuIqg9wDc=
X-Received: from pfbfs2.prod.google.com ([2002:a05:6a00:8182:b0:82f:6e26:770b])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1a90:b0:842:5719:455b with SMTP id d2e1a72fcca58-84257194b05mr4280757b3a.42.1780336480081;
 Mon, 01 Jun 2026 10:54:40 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:23 +0000
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-2-hramamurthy@google.com>
Subject: [PATCH net-next 01/15] gve: don't pass in unused parameter to gve_adminq_free
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293860-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1D833623995
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Clean up gve_adminq_free to not take in an unused parameter.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 2 +-
 drivers/net/ethernet/google/gve/gve_adminq.h | 2 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 0d5a67523cba..d8d47a0c19b4 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -385,7 +385,7 @@ void gve_adminq_release(struct gve_priv *priv)
 	gve_clear_admin_queue_ok(priv);
 }
 
-void gve_adminq_free(struct device *dev, struct gve_priv *priv)
+void gve_adminq_free(struct gve_priv *priv)
 {
 	if (!gve_get_admin_queue_ok(priv))
 		return;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index e6dcf6da9091..9fbea0cc6513 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -620,7 +620,7 @@ union gve_adminq_command {
 static_assert(sizeof(union gve_adminq_command) == 64);
 
 int gve_adminq_alloc(struct device *dev, struct gve_priv *priv);
-void gve_adminq_free(struct device *dev, struct gve_priv *priv);
+void gve_adminq_free(struct gve_priv *priv);
 void gve_adminq_release(struct gve_priv *priv);
 int gve_adminq_describe_device(struct gve_priv *priv);
 int gve_adminq_configure_device_resources(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e4d78ae52daf..30bf6df4ebc5 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2506,14 +2506,14 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	bitmap_free(priv->xsk_pools);
 	priv->xsk_pools = NULL;
 err:
-	gve_adminq_free(&priv->pdev->dev, priv);
+	gve_adminq_free(priv);
 	return err;
 }
 
 static void gve_teardown_priv_resources(struct gve_priv *priv)
 {
 	gve_teardown_device_resources(priv);
-	gve_adminq_free(&priv->pdev->dev, priv);
+	gve_adminq_free(priv);
 	bitmap_free(priv->xsk_pools);
 	priv->xsk_pools = NULL;
 }
-- 
2.54.0.669.g59709faab0-goog


