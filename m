Return-Path: <netdev+bounces-112596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EAD93A1FF
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E171F237F3
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AE8154434;
	Tue, 23 Jul 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="WKg2h/Ow"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89E21509BF
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742715; cv=none; b=Id7zNVXYnL3cVxulgVZbRliwB21gfXHBr+z5mec3nao7SMD5XClmlRvJsY84i4wf9AwtZR7csHHeSawyMBTL8V10aAm4CXw68cjylgjK4lfaWbszjp/LOfLQwS6lD+23NkztqjbY+j+G6hZQG2vUmh064J5sJq52qOzBxAO+1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742715; c=relaxed/simple;
	bh=Zl3XWrPm9nzsOmQ3jqkZ4f5PG9RSmVQ2p3Qpf6hXkK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EDqHCqz6Px8fxsT3TCP/d4uaMpUpwMHC72xNl022/+JAt3vMQwyTtNacc31SLuNMkVRaWhBpDy1GltksLLx9Z7wXds20gMm/oWPtJPe7py85Gmolmq2IMHYWZDZidMPoQ+Ekda/mLXjHC2TJA8qUTHN2eGBnvr8R7WxV1CyLp50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=WKg2h/Ow; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id CE9B87DCED;
	Tue, 23 Jul 2024 14:51:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742705; bh=Zl3XWrPm9nzsOmQ3jqkZ4f5PG9RSmVQ2p3Qpf6hXkK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2006/15]=20l2tp:=20remove=20unused=20tunnel=20magic=20field|Dat
	 e:=20Tue,=2023=20Jul=202024=2014:51:34=20+0100|Message-Id:=20<7736
	 9a8db320f2925c6c15dc8e7afda701b11fcc.1721733730.git.jchapman@katal
	 ix.com>|In-Reply-To:=20<cover.1721733730.git.jchapman@katalix.com>
	 |References:=20<cover.1721733730.git.jchapman@katalix.com>|MIME-Ve
	 rsion:=201.0;
	b=WKg2h/OwizIQhv3Vu4s3cgWL1U8UDhdscswNZpNrdLBtOEiDjWThvGk69riAy22a2
	 nnB1ZzUpmdW/u7iZvKzQ8TGVwVsESDEL4R57cInpcOgwZKz4+wlbmUxosCyXiquA07
	 7+O+UOgd3YwrH13PQ7SqsfOKJhQxjZxDrBzoaDTE5/9/96ZcljUSBQqrt0MtGPz/WO
	 gSh+4FhI/Fp6Kv3R1lYwCLYGPlBCUaFmCD0LviYYCd0geMxbmmrvDsGDlgVSyGyHdN
	 iV8ahqG296JZpwkR3IApcT8/yOiqMdVkLPqaSvc0rHN7c5lEjU+podek2j3ZMtlzjC
	 BnMimeslfO5Ew==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 06/15] l2tp: remove unused tunnel magic field
Date: Tue, 23 Jul 2024 14:51:34 +0100
Message-Id: <77369a8db320f2925c6c15dc8e7afda701b11fcc.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721733730.git.jchapman@katalix.com>
References: <cover.1721733730.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since l2tp no longer derives tunnel pointers directly via
sk_user_data, it is no longer useful for l2tp to check tunnel pointers
using a magic feather. Drop the tunnel's magic field.
---
 net/l2tp/l2tp_core.c | 1 -
 net/l2tp/l2tp_core.h | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 59a171fa1a39..1ef14f99e78c 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1527,7 +1527,6 @@ int l2tp_tunnel_create(int fd, int version, u32 tunnel_id, u32 peer_tunnel_id,
 	tunnel->tunnel_id = tunnel_id;
 	tunnel->peer_tunnel_id = peer_tunnel_id;
 
-	tunnel->magic = L2TP_TUNNEL_MAGIC;
 	sprintf(&tunnel->name[0], "tunl %u", tunnel_id);
 	spin_lock_init(&tunnel->list_lock);
 	tunnel->acpt_newsess = true;
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index a41cf6795df0..50107531fe3b 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -16,7 +16,6 @@
 #endif
 
 /* Random numbers used for internal consistency checks of tunnel and session structures */
-#define L2TP_TUNNEL_MAGIC	0x42114DDA
 #define L2TP_SESSION_MAGIC	0x0C04EB7D
 
 struct sk_buff;
@@ -155,8 +154,6 @@ struct l2tp_tunnel_cfg {
  */
 #define L2TP_TUNNEL_NAME_MAX 20
 struct l2tp_tunnel {
-	int			magic;		/* Should be L2TP_TUNNEL_MAGIC */
-
 	unsigned long		dead;
 
 	struct rcu_head rcu;
-- 
2.34.1


