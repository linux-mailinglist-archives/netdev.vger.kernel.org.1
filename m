Return-Path: <netdev+bounces-283355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KnmD5ls9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:16:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C6E4B0C57
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30E79303CD1C
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA0A2D5C91;
	Sat,  2 May 2026 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4v9PryX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EFB2C3257
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691660; cv=none; b=TxWlmQbzwj9hQQNiM5OOxeW/KJXBp5LicrH2sGZ98gQvQyJwVf56DWJiOZovrNm7c2qDZfqByHZ7LgRCwbzHfIuQo2XnEAMHa4yVu2/HJEt4dRHUAl7XPWsAFXLOSuqCLvHtuLB/k9LYrxX1h88ayp4xRoptX0wsxTdT9PBDa0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691660; c=relaxed/simple;
	bh=WHvI9thA8f+9Dwyb4c0i1CwICrs++o6o/1tUs/9Wwww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X+Y5/TmtVynWu74PdbZNA/CCqN2IH70sHg79dFQ/0Wzs6TBizCGP7xR64/fTtzbrjHAhif9uxwQJa+EgrCgT5MURZT+Rj5/lJ/juumArpewnkQuqAO0rZQYrs2L8ePYVLVYR1QMgD6enBXm5tWLkxXSAbTXPhsOk5Fvki7H4tP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4v9PryX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso3094280a91.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691659; x=1778296459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vkm8Z9gWjhY3TEBfk4zh+n6ni3yKNgZWxh5Z676e3tk=;
        b=h4v9PryXRyAxFi0E42gFwk432xa10IImnywuPpMRXK2YdU3/s7qYfZC48OffsgUuHj
         ts0PKdEeFYsVrFzzJTKBCUrTCrp3EJbZ0MST2/4k0dX5nZRXbWXgzzwk8WVbmXBNV9Vq
         XH+kLa6rRtM5ui4Bb1Po7XBAAMP/KkA00Ka8v8rcoYsCPRuGNXNS6ApRDLHpK7O1h1De
         VEM4M1KzuZfcHIg935obkyAvfZQblD0u0V5gC5vJrd55dT/b6sSUwfBS9u2RRPyF3Myq
         89rVeoVqXPkRxx7UQtHMOokNeKeeKEdXkjVBy12M31k279nuNz0bcm5S8YpHTMRg0AZo
         GriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691659; x=1778296459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkm8Z9gWjhY3TEBfk4zh+n6ni3yKNgZWxh5Z676e3tk=;
        b=cCrlYSZ7Iy1/Heuukd9vY0X3qNsbL2aHUGo6H/WQPwgB2RaUZN2J7t3zRijlX/yMcG
         WhRarg9w4TULYUd93PRn21MgaudCg3N3sjS5HFUdy8M+xwj47EF+OHXNq2F1+xWazzOe
         iWhorns3gxLd0b/eWOM2AMqS5sBFh+PvFJuwaFEcPKPSOzgey/fvd0SD1QV/ZbELL/u4
         jFk/0wupy7wKTSjuDBrIpK8yKQqu9yM7XdG70gS9Qse1RzW2+C/QxERlgN0ImRFx0L/x
         E7hiRwhitEjY/W5qwTWbuNI9p7n5iEuaj/0/uEICOB23E0WWn4OwhGVfmEfs3YM128E+
         jFEQ==
X-Forwarded-Encrypted: i=1; AFNElJ94RIBUmsGUMBJ6ob6/CSO6MjZC8KqqT8oOW9NqK3SEVBaVqlQzcmsZiRlJomsOYGLF+Clh4iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfBW/GkgGJplj4y+RrTcuAYN9ckCzSAz4Q9bKFQ6m/+Coxjfi
	z/reEcWRkFVME6/ivgHC7F2K6PGWtSyey37yV8nJVYrup6SMmrFoDPjG7+UGGoITOAmOM+17hqp
	Bp8vwvQ==
X-Received: from pfbhb4.prod.google.com ([2002:a05:6a00:8584:b0:834:e113:ef04])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca2:b0:3a2:ebfc:6bf3
 with SMTP id adf61e73a8af0-3a7f1bc418cmr1325524637.29.1777691658588; Fri, 01
 May 2026 20:14:18 -0700 (PDT)
Date: Sat,  2 May 2026 03:13:01 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 08/15] vxlan: Free vxlan_sock with kfree_rcu().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C4C6E4B0C57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283355-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

We will remove synchronize_rcu() in udp_tunnel_sock_release().

We must ensure that vxlan_sock is freed after inflight RX fast path.

Let's free vxlan_sock with kfree_rcu().

Note that vxlan_sock.vni_list[] is 8K and struct rcu_head must
be placed before it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++--
 include/net/vxlan.h            | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ce99da44ea7d..00facbfabced 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1524,13 +1524,13 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 
 	if (__vxlan_sock_release_prep(sock4)) {
 		udp_tunnel_sock_release(sock4->sk);
-		kfree(sock4);
+		kfree_rcu(sock4, rcu);
 	}
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (__vxlan_sock_release_prep(sock6)) {
 		udp_tunnel_sock_release(sock6->sk);
-		kfree(sock6);
+		kfree_rcu(sock6, rcu);
 	}
 #endif
 }
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 8b52294b2902..dfba89695efc 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -186,6 +186,7 @@ struct vxlan_metadata {
 struct vxlan_sock {
 	struct hlist_node hlist;
 	struct sock	  *sk;
+	struct rcu_head	  rcu;
 	struct hlist_head vni_list[VNI_HASH_SIZE];
 	refcount_t	  refcnt;
 	u32		  flags;
-- 
2.54.0.545.g6539524ca2-goog


