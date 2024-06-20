Return-Path: <netdev+bounces-105218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B1E910286
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F76728372F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C2B1AB8F3;
	Thu, 20 Jun 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="YpC1y/de"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF801AB348
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883042; cv=none; b=rhaOVfrmrsvgnDO/xeEkzM4Bo5hyddT+VdJhom1DioZT/YtUiyHx91V0+X2/Jm8j59NUOo6+xH91pAZYYw3qS0+6gm6Wo7hqZY0/d9w8Oj2Oku3/PmyRFIaxmxTWMTD1MbYKo+Z5LuBMX8Ge0grEiFbyKP6Egb6EExp7EmyEBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883042; c=relaxed/simple;
	bh=SdrasX0wN84TNUZiTRH4tX5ubI2HsZxK3mB8erws5UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoreTlVs2vQRYiwpX7zHzeljLme9F00qHEBwBBSiVDV41i9gOwuiSL8sT/oMYf7K7wbBYYT6nlwGYoBTlrFu+OTaqz54DRJDkWGIRq7YJLTTyvT25HB7OpISUSNOj90CEzafsxvTN+Mo0AoJy2yIUwgfYjXlNACAA70vhfwLdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=YpC1y/de; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:530f:c40e:e1d0:8f13])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 5F0747DA40;
	Thu, 20 Jun 2024 12:22:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1718882565; bh=SdrasX0wN84TNUZiTRH4tX5ubI2HsZxK3mB8erws5UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20gnault@redhat.com,=0D=0A=09samuel.thibault@ens-
	 lyon.org,=0D=0A=09ridge.kennedy@alliedtelesis.co.nz|Subject:=20[PA
	 TCH=20net-next=201/8]=20l2tp:=20remove=20unused=20list_head=20memb
	 er=20in=20l2tp_tunnel|Date:=20Thu,=2020=20Jun=202024=2012:22:37=20
	 +0100|Message-Id:=20<994810f6a34e545b87122afb3772f5727dab0b3e.1718
	 877398.git.jchapman@katalix.com>|In-Reply-To:=20<cover.1718877398.
	 git.jchapman@katalix.com>|References:=20<cover.1718877398.git.jcha
	 pman@katalix.com>|MIME-Version:=201.0;
	b=YpC1y/deqpjIGw24tCnvMPesZMWoyX2h/VQEma7D+nfisvUqOQrYJxd+5AqiFlQve
	 LSMpaDscBEkJnMXF/kt1eqIwqYKEmiyKHcwwX8P6nim537xGANqVpPt9Xp56p4BHYO
	 AXE1/kBFgxAKTner/18D4/FhsS09qwFBLwbdz3IIwZhkxyPZD247ny5ySGBPEJNT4v
	 U5GxrB5Cz/Hh4qZih9RB8ox0hfLF5jW2FaPjCWUA/7CTKSfK7pA1uGthX+7/jvcdHc
	 6Fuumt7/h3BXWEUmE9pb7NWsDClklUbuUazFz6Mw1siW4+LIGAvzN5irBoYtrIZqLe
	 PHtwaOFr1YWZg==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: gnault@redhat.com,
	samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz
Subject: [PATCH net-next 1/8] l2tp: remove unused list_head member in l2tp_tunnel
Date: Thu, 20 Jun 2024 12:22:37 +0100
Message-Id: <994810f6a34e545b87122afb3772f5727dab0b3e.1718877398.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718877398.git.jchapman@katalix.com>
References: <cover.1718877398.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove an unused variable in struct l2tp_tunnel which was left behind
by commit c4d48a58f32c5 ("l2tp: convert l2tp_tunnel_list to idr").

Signed-off-by: James Chapman <jchapman@katalix.com>
Reviewed-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 2 --
 net/l2tp/l2tp_core.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 88a34db265d8..69f8c9f5cdc7 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1462,8 +1462,6 @@ int l2tp_tunnel_create(int fd, int version, u32 tunnel_id, u32 peer_tunnel_id,
 	/* Init delete workqueue struct */
 	INIT_WORK(&tunnel->del_work, l2tp_tunnel_del_work);
 
-	INIT_LIST_HEAD(&tunnel->list);
-
 	err = 0;
 err:
 	if (tunnelp)
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 91ebf0a3f499..54dfba1eb91c 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -174,7 +174,6 @@ struct l2tp_tunnel {
 	enum l2tp_encap_type	encap;
 	struct l2tp_stats	stats;
 
-	struct list_head	list;		/* list node on per-namespace list of tunnels */
 	struct net		*l2tp_net;	/* the net we belong to */
 
 	refcount_t		ref_count;
-- 
2.34.1


