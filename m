Return-Path: <netdev+bounces-28159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8086F77E6AD
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12601C210EF
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1709416413;
	Wed, 16 Aug 2023 16:40:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8D174D9
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:40:10 +0000 (UTC)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A2419A4
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:40:09 -0700 (PDT)
Received: from kero.packetmixer.de (p200300fA272a67000bB2d6DCAf57d46e.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id A3E20FB5CB;
	Wed, 16 Aug 2023 18:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204003; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11GJVf3mHqk6CBqwQS0ucNSZAqSlqPiz6vx8rtLSE8Q=;
	b=1gXJSkh5TOOdUOZ0MlX3uWaPteM2CB5UuLPNo+FHc9CvibFPCl/kuWeG5IQqcXRUbH49Ud
	Jzcg0ltn4cHhM86s6vH34Xy9/cDH8jljsNqwcPuQqvws6KJPzEEMvVU8oLQQsiDGb6Kk8p
	7ySIVMDGYoqAGPb176gObY+b1dlUbWiRmbd8IzieKOVsBgPuYKs2rneqtLsvShgnsl9sqU
	gPqHU7/MKg5hBtMHEUqpd4l0j0joOtsJjXFymd4YgpRPQj5ew9rpFXN5Dw2HBG0Y4vLaNx
	Au0+xbiNDIhXdq8F6Q93opsTYGOvI+kZ+fY7B3JDnjpxyzO1P02WS32oU9+kbA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 6/7] batman-adv: Keep batadv_netlink_notify_* static
Date: Wed, 16 Aug 2023 18:39:59 +0200
Message-Id: <20230816164000.190884-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816164000.190884-1-sw@simonwunderlich.de>
References: <20230816164000.190884-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692204003;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11GJVf3mHqk6CBqwQS0ucNSZAqSlqPiz6vx8rtLSE8Q=;
	b=X4zxSjo3QoOa0lfTBSYXoMx/sNMNU8Cyn0bbAtXPWxR+qrL9sfKYPTt9a5u/YQoxXY4oOH
	WPRC5IYYOnwKCwLHDr+DsQ5XS0/wb47k2Ubo25xPDz5Qei2Y5MLouRMmK66bkHs43l8Bl6
	rr4VOrId4FDvXGSX+UNZDlGQ0mnTT7Mop/9lhGvnQKF1++ljNCic2AeL6hn5kSS3HAnlbg
	r0zHFpJh382jcDNaDc35JV7nESgJlZ3l9PB4x0Ou+KKNBps6/fkPKrk0z/JgCKg2UpTmA8
	tZUqF7vpGvSaKb8FQkVsJV84GI8TZ87N9p22FWLCOn/ycdfE2B3ZQYn90brzFQ==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204003; a=rsa-sha256;
	cv=none;
	b=v4+4vyKKXtUZY7uAr2EL6pZr+1KHZQg1Nnczdf1mOIMSt2KUQaVOw9IzIh4rqdhSa8gHNZMpIMVVqG71QIA9ZyCPSYmaNtGYnqunWr2XzYhkNqwUr+wVkerVOdMJ/7MWWl2VU1YIBTaWaaOTt68pfvg29XLqfYwszXC7H/COLhU+gujlNVbaNRamb/iohWtecvoCWMVa1O3vcpVYKILb0qXE0ijkmsnBk6Ai6ikW8WBE0vWBWNMaL6kYIhKYi6W8b+UshvK006yRsgHrKGDLcvH8503OkjPeq4GH6ATKjKnKyKbDSPb3Ii+7mjp1R8Qd+REXr17Gx6axE1U72c5GfQ==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sven Eckelmann <sven@narfation.org>

The batadv_netlink_notify_*() functions are not used by any other source
file. Just keep them local to netlink.c to get informed by the compiler
when they are not used anymore.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/netlink.c | 10 +++++-----
 net/batman-adv/netlink.h |  6 ------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index ad5714f737be..b6c512ce6704 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -377,7 +377,7 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
  *
  * Return: 0 on success, < 0 on error
  */
-int batadv_netlink_notify_mesh(struct batadv_priv *bat_priv)
+static int batadv_netlink_notify_mesh(struct batadv_priv *bat_priv)
 {
 	struct sk_buff *msg;
 	int ret;
@@ -858,8 +858,8 @@ static int batadv_netlink_hardif_fill(struct sk_buff *msg,
  *
  * Return: 0 on success, < 0 on error
  */
-int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
-				 struct batadv_hard_iface *hard_iface)
+static int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
+					struct batadv_hard_iface *hard_iface)
 {
 	struct sk_buff *msg;
 	int ret;
@@ -1073,8 +1073,8 @@ static int batadv_netlink_vlan_fill(struct sk_buff *msg,
  *
  * Return: 0 on success, < 0 on error
  */
-int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
-			       struct batadv_softif_vlan *vlan)
+static int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
+				      struct batadv_softif_vlan *vlan)
 {
 	struct sk_buff *msg;
 	int ret;
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 48102cc7490c..876d2806a67d 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -21,12 +21,6 @@ int batadv_netlink_tpmeter_notify(struct batadv_priv *bat_priv, const u8 *dst,
 				  u8 result, u32 test_time, u64 total_bytes,
 				  u32 cookie);
 
-int batadv_netlink_notify_mesh(struct batadv_priv *bat_priv);
-int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
-				 struct batadv_hard_iface *hard_iface);
-int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
-			       struct batadv_softif_vlan *vlan);
-
 extern struct genl_family batadv_netlink_family;
 
 #endif /* _NET_BATMAN_ADV_NETLINK_H_ */
-- 
2.39.2


