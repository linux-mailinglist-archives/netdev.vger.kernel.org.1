Return-Path: <netdev+bounces-113701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03893F9A0
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE6B1F2207A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A66415CD54;
	Mon, 29 Jul 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="uOFBDt8q"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E3815AAC1
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267499; cv=none; b=UXLrNWoK6s7bOZ2rn2veSC8IsdIJO2f/QAGoZHFQ/Gj6FP87z1x369962uIG3VuOyNUHf5MZxY2SQuCfdjqhH47vzQpTv3okYL0wqMrE3S0L4pW/T2j6EeI4QhMtjG/yVuPNA4r392E5L/5GB/I2E7Oobd1mD2BlsLlg2NotA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267499; c=relaxed/simple;
	bh=R97B9UZCbYzxtNIksHSmdO1l6y7EIS+8RcIWm+rKigE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QHOkfP6iT4DQWIcKUjaDyMBd1pjYDLv5WjcT5nQoqLSpUPXkx2+PlaBlUgo8RIaZLepaWU4lhLeq+9YFclUxoSe5xND0pI5i6QQRIwRcTxr8TpHDIqAlkDJl/x5+gXOqB1Wvmw53kjEf6WBxC2v5+NrPe8NDfifX2HEjv+9MXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=uOFBDt8q; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id B7B447DCF6;
	Mon, 29 Jul 2024 16:38:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267495; bh=R97B9UZCbYzxtNIksHSmdO1l6y7EIS+8RcIWm+rKigE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2006/15]=20l2tp:=20remove=20unused=20tunnel=20magic=20fiel
	 d|Date:=20Mon,=2029=20Jul=202024=2016:38:05=20+0100|Message-Id:=20
	 <bdd1c9e433acca09e8e391ce478092637a9ca68b.1722265212.git.jchapman@
	 katalix.com>|In-Reply-To:=20<cover.1722265212.git.jchapman@katalix
	 .com>|References:=20<cover.1722265212.git.jchapman@katalix.com>|MI
	 ME-Version:=201.0;
	b=uOFBDt8qG39oQQKRveGngqPKSXBXD+ZP4P2dk/rPeawgpHWTB74iZAd3fl6kNy11j
	 WRFafa2tObN3KAbvmzdqigAuHQx/45WYs/+EY60NmKsZubMLWmunAPKtiF0x0O+ZgW
	 +Fj8I9g2Epit8KYJQ8ITKBL4T8kCaYu/7ypjpjSz9dXRhICFEUG7aCmlRlmnPUJfbT
	 1GlPO1aY9cGVvFsTJyQDCa+2pIM/r/imFHidXysbqz5rz7dv3MXu4ZkMeGwiPSPpaL
	 TvH6pxjHHwn3JO93W41tB28+rrx5zoHBxmFzL6863WBvqII1mLrUhju+mQ4a3N7nSs
	 Zz6lTooDJLGhg==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 06/15] l2tp: remove unused tunnel magic field
Date: Mon, 29 Jul 2024 16:38:05 +0100
Message-Id: <bdd1c9e433acca09e8e391ce478092637a9ca68b.1722265212.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
References: <cover.1722265212.git.jchapman@katalix.com>
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

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
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


