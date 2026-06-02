Return-Path: <netdev+bounces-294468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ewF3EaxvH2rJlwAAu9opvQ
	(envelope-from <netdev+bounces-294468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:05:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4614633142
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:04:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=husRwNDD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294468-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294468-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B04530EDAC0
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 23:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2C3CF692;
	Tue,  2 Jun 2026 23:59:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984B43CAE6C
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 23:59:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444747; cv=none; b=WbT/zaXu75gVWEHNXD58qrucWVjfeTO9xaX+9o9OLSj84KBQgeWeXvI53OH3wXwJIh6m3WQbotnzrvjOS9xqgkV+flqIT38DYI7u3CTDI+NYyBD8EkZq4wKHzq6Cknb8kTFoE4VDS4g+UOmZuKGDBxGGqH9d4n/4tWZN2inH4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444747; c=relaxed/simple;
	bh=Z8zc+t9FysG/A3238K7QuL+tz/0ZsCr4c3rTv316V70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XCXRcciBuxtzxkfGM853YLjtvW34VkRqqoTuGl0Ql/PVIYSI9QT7/W/c/RmeiRk41vcPH8uwQSZ8LhH5rKateMWuiKEncB6en3fym3Frb5RTE3H4sBdFN8HMOAwxUbA5LLq6Jml0fzqnev4M2w8lMtJbMVYoaA3jNKLDmNkwBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=husRwNDD; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c857fa2706aso2084957a12.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 16:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444743; x=1781049543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0hfnKBitry7RLyqz55UndF/vQw9Tta7wZyRyA2fbEyo=;
        b=husRwNDDwL6ig0MoCxA7CRrosjjFEPir7xzRBrhYaNTxtTwPASLKGr2FmdejP9TcRi
         fbdQvz1NzhMgVcYi0Nx4Gy2/aRYFM24qTObdN1OMmROqzSeZCEOKczMiy7oWZu1hCEjD
         WF9xn8sRjI0OO5c+lh39IOdhgzIND/a6lWtswLgThc4JuyAEx/axz1AkspVTVWjHnXiI
         BJtx0dmOxAbC69hztd+Zpl9MJ5oM7K4ZPvWhcEXV7swJumRaflX0SY2i3knpXo54G2ti
         KEm30bpWZUNE2ZsUmzWU1JyrX35Z23X4He7KnYm6idIDBddASwbG+CJIxQX4BJ6keMlu
         ofWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444743; x=1781049543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hfnKBitry7RLyqz55UndF/vQw9Tta7wZyRyA2fbEyo=;
        b=rX7iE78OZuKM4R+3Gwz84bz0mvFxHIXGgt5JApP6gZIIpqxiis9b0mIwYI4FEl1sog
         BI1wmbPZUxS+h6dtBC/xbdD10XF+F0DH4BTfntpGyjOp2qyLtx5lMLXzgVxAGP7z6Aei
         /+IXSZzWyhVwCRlhGcn36yki/td2BGABwbvc/jVRLsVHpi7IBcdw1yV/1IAL6JIgJLuq
         EbJlIYsSehg7LHCfX1/JrKTK8YgqG+kvzb4V6LXHVYr8iE78boYr+YKOZUd6oBRK5l3g
         NpuayHskg89JQYlZaY9lLv1eYxZtis6k9RMai7kG/1RDy5mVKYNmX8k4XBEZjpRN2NrR
         iSZg==
X-Gm-Message-State: AOJu0Yz1dBiH/qVOhyC9CLggKeV/Km6dFLsngSQjzH7r0dELQci3jErF
	+Pn9FeKXEJLqNi9VjbWWOglTObVEgIwyPLXClc+3gGuyVSy1T/a52NdFQ1HrMcL9R9+vygQUdAs
	zVNP+wzu3/jY+FVZP5VyPuUQJ/LvyzzfTVIJpmIyrY1fQaqZDJNBkTCKIP7NoWEln9TsuqubtBz
	hlnFH/gcMxEaJ3PdcUxHtt+Owib4VDF/AvIrOJJujWFOtNwVhQRPqZzCUlbEo9Cco=
X-Received: from pgcl27.prod.google.com ([2002:a63:701b:0:b0:c85:104d:a751])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c786:b0:3b4:7c33:296b with SMTP id adf61e73a8af0-3b497869594mr938429637.32.1780444742913;
 Tue, 02 Jun 2026 16:59:02 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:45 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-2-hramamurthy@google.com>
Subject: [PATCH net-next v2 01/15] gve: don't pass in unused parameter to gve_adminq_free
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294468-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:joshwash@google.com,m:hramamurthy@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:willemb@google.com,m:jordanrhee@google.com,m:jfraker@google.com,m:nktgrg@google.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4614633142

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
index 08587bf40ed4..70ffed8b52c3 100644
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
index 22a74b6aa17e..8e80f36116ec 100644
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
2.54.0.1013.g208068f2d8-goog


