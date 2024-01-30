Return-Path: <netdev+bounces-67335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4C0842D9B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A09B24302
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 20:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3847871B59;
	Tue, 30 Jan 2024 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="eScS3OeL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403471B41
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645989; cv=none; b=MT2r4qzLXDDckoJVYs3XdBa6g71JdboS0R731qXH5mI5Fs6SKGR6yZ3/gn6gzl7RFD7JTDc1VjdGYXn1Lgbfsg8jvPNlKQtIwXsNWHfQK48cb8IPdZxJWYA/uBTn3ncrcnTHlH5n0yckxjAf4XQXAGkNBktoRaK4mMEccDUB04U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645989; c=relaxed/simple;
	bh=t6uAJFMViO+HMxmFBNUKRYgjnERIYOpZmhn/2AN2c8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrBPNE2ULcBlTC+81UGs1VMw2qBtC9DinHojvhR27aomElHTPeXrFS/1k/zich8SZC/Qe1msorTh9vNnmgzpCoPflixWKryPpGdGO/12nx72yk/mxylBdiyoUB/+AoWbNctAtbspgVzlDlXCtufp+SrOwAxY3SOh/A5Ld0wQb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=eScS3OeL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51124983d6aso14191e87.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 12:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706645985; x=1707250785; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fPaQcwVDm1hs7rZIx/MRtZyeT8rTUy8NvGG7kGqel6E=;
        b=eScS3OeL/lzsv40EpDYybNhG7LlohDyshvByKfgRtm2FRRiLX2NMqx/342nUh3BCvj
         0MTHKrLg9rHf/19u3A0l4mhVew6UCpwxuw89mWz0WgnFwiQUGy1G2jHt5/DnRVsC8EBD
         M41UZAMnnfG4Vd0VD1MN5M5JjiWaI3Pb+DtV1+M7nsbgO/NJL68bCjLDZcPGRkcnCrpk
         jQmVX+8csP68xFLZ1UDw2KjiA8sYC3YUxLYc/OwbxhRGGVjK8zNz3CAxe6esrSiaK2aM
         YsQ2pyvZ4P1gw+M617xenz61xyxaKgRNpU2xPE2DObJqqB1T2mJjAkdWX+TXQMWxkY+N
         dpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645985; x=1707250785;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPaQcwVDm1hs7rZIx/MRtZyeT8rTUy8NvGG7kGqel6E=;
        b=vKwk0meDMfC2ZksCKVj2cEC1huF4hqNaR0XDwAI6+/W4FpcKo3yxVGcvxYT48kLGDu
         9CBSL6NurFr+jB4Sak1t6GE/8qOHgC3ciUfd437G1YdDQxtL9rO+lDR9ezXEb1igT8yN
         1yaL24t0oWdQmhJuPszGfLG3l6te86QYObjYUwzdzWvHqJDQ6ZnoA2ml78MhZzm5cBxD
         F2N5zJc5VyM6d3KaYbIXE4EZJAc6NyJzEYAft2fI5Xi6F8rK9PBhCk9EvlP0XyGrzMpo
         gruUrm5DF08oaX9R3etd9pG0MCBwEUdllU5gvJpIYvRGOQvWFIE6IkG0/dIUClyjaNes
         53Cw==
X-Gm-Message-State: AOJu0YzXCkpgsb6Ej9pNQy/+6a4LZT4hcu4FAssBEPuKTD1irIeVPu1l
	LEVXKgC+YSqidnblLJ7ufoGYXYi6W+PtO1coCn6OkfrdICjaPCGx+de7JnlXrN8=
X-Google-Smtp-Source: AGHT+IHVFNSV8RrsmxF7rB9qO1wDYJNJ81lroNkUywKlt3ACrS5kOQcymNfQt+XC6TRgrh/CGOyWFQ==
X-Received: by 2002:ac2:5f0f:0:b0:511:17f1:8e09 with SMTP id 15-20020ac25f0f000000b0051117f18e09mr2478972lfq.35.1706645985304;
        Tue, 30 Jan 2024 12:19:45 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056512480f00b0051011f64e1bsm1553239lfb.142.2024.01.30.12.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:19:44 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: jiri@resnulli.us,
	ivecera@redhat.com,
	netdev@vger.kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 1/5] net: switchdev: Wrap enums in mapper macros
Date: Tue, 30 Jan 2024 21:19:33 +0100
Message-Id: <20240130201937.1897766-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130201937.1897766-1-tobias@waldekranz.com>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

In order to avoid having to maintain separate mappings from enum
values to strings, wrap enumerators in mapper macros, so that
enum-to-string tables can be generated.

This will make it easier to create helpers that convert switchdev
objects to strings.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h | 113 ++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 45 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index a43062d4c734..76eabf95c647 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -16,21 +16,28 @@
 #define SWITCHDEV_F_SKIP_EOPNOTSUPP	BIT(1)
 #define SWITCHDEV_F_DEFER		BIT(2)
 
+#define SWITCHDEV_ATTR_ID_MAPPER(_fn)	\
+	_fn(UNDEFINED),			\
+	_fn(PORT_STP_STATE),		\
+	_fn(PORT_MST_STATE),		\
+	_fn(PORT_BRIDGE_FLAGS),		\
+	_fn(PORT_PRE_BRIDGE_FLAGS),	\
+	_fn(PORT_MROUTER),		\
+	_fn(BRIDGE_AGEING_TIME),	\
+	_fn(BRIDGE_VLAN_FILTERING),	\
+	_fn(BRIDGE_VLAN_PROTOCOL),	\
+	_fn(BRIDGE_MC_DISABLED),	\
+	_fn(BRIDGE_MROUTER),		\
+	_fn(BRIDGE_MST),		\
+	_fn(MRP_PORT_ROLE),		\
+	_fn(VLAN_MSTI),			\
+	/*  */
+
+#define SWITCHDEV_ATTR_ID_ENUMERATOR(_id) \
+	SWITCHDEV_ATTR_ID_ ## _id
+
 enum switchdev_attr_id {
-	SWITCHDEV_ATTR_ID_UNDEFINED,
-	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
-	SWITCHDEV_ATTR_ID_PORT_MST_STATE,
-	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
-	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
-	SWITCHDEV_ATTR_ID_PORT_MROUTER,
-	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
-	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
-	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL,
-	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
-	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
-	SWITCHDEV_ATTR_ID_BRIDGE_MST,
-	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
-	SWITCHDEV_ATTR_ID_VLAN_MSTI,
+	SWITCHDEV_ATTR_ID_MAPPER(SWITCHDEV_ATTR_ID_ENUMERATOR)
 };
 
 struct switchdev_mst_state {
@@ -69,18 +76,25 @@ struct switchdev_attr {
 	} u;
 };
 
+#define SWITCHDEV_OBJ_ID_MAPPER(_fn)	\
+	_fn(UNDEFINED),			\
+	_fn(PORT_VLAN),			\
+	_fn(PORT_MDB),			\
+	_fn(HOST_MDB),			\
+	_fn(MRP),			\
+	_fn(RING_TEST_MRP),		\
+	_fn(RING_ROLE_MRP),		\
+	_fn(RING_STATE_MRP),		\
+	_fn(IN_TEST_MRP),		\
+	_fn(IN_ROLE_MRP),		\
+	_fn(IN_STATE_MRP),		\
+	/*  */
+
+#define SWITCHDEV_OBJ_ID_ENUMERATOR(_id) \
+	SWITCHDEV_OBJ_ID_ ## _id
+
 enum switchdev_obj_id {
-	SWITCHDEV_OBJ_ID_UNDEFINED,
-	SWITCHDEV_OBJ_ID_PORT_VLAN,
-	SWITCHDEV_OBJ_ID_PORT_MDB,
-	SWITCHDEV_OBJ_ID_HOST_MDB,
-	SWITCHDEV_OBJ_ID_MRP,
-	SWITCHDEV_OBJ_ID_RING_TEST_MRP,
-	SWITCHDEV_OBJ_ID_RING_ROLE_MRP,
-	SWITCHDEV_OBJ_ID_RING_STATE_MRP,
-	SWITCHDEV_OBJ_ID_IN_TEST_MRP,
-	SWITCHDEV_OBJ_ID_IN_ROLE_MRP,
-	SWITCHDEV_OBJ_ID_IN_STATE_MRP,
+	SWITCHDEV_OBJ_ID_MAPPER(SWITCHDEV_OBJ_ID_ENUMERATOR)
 };
 
 struct switchdev_obj {
@@ -209,27 +223,36 @@ struct switchdev_brport {
 	bool tx_fwd_offload;
 };
 
+#define SWITCHDEV_TYPE_MAPPER(_fn)	\
+	_fn(UNKNOWN),			\
+					\
+	_fn(FDB_ADD_TO_BRIDGE),		\
+	_fn(FDB_DEL_TO_BRIDGE),		\
+	_fn(FDB_ADD_TO_DEVICE),		\
+	_fn(FDB_DEL_TO_DEVICE),		\
+	_fn(FDB_OFFLOADED),		\
+	_fn(FDB_FLUSH_TO_BRIDGE),	\
+					\
+	_fn(PORT_OBJ_ADD),		\
+	_fn(PORT_OBJ_DEL),		\
+	_fn(PORT_ATTR_SET),		\
+					\
+	_fn(VXLAN_FDB_ADD_TO_BRIDGE),	\
+	_fn(VXLAN_FDB_DEL_TO_BRIDGE),	\
+	_fn(VXLAN_FDB_ADD_TO_DEVICE),	\
+	_fn(VXLAN_FDB_DEL_TO_DEVICE),	\
+	_fn(VXLAN_FDB_OFFLOADED),	\
+					\
+	_fn(BRPORT_OFFLOADED),		\
+	_fn(BRPORT_UNOFFLOADED),	\
+	_fn(BRPORT_REPLAY),		\
+	/*  */
+
+#define SWITCHDEV_TYPE_ENUMERATOR(_id) \
+	SWITCHDEV_ ## _id
+
 enum switchdev_notifier_type {
-	SWITCHDEV_FDB_ADD_TO_BRIDGE = 1,
-	SWITCHDEV_FDB_DEL_TO_BRIDGE,
-	SWITCHDEV_FDB_ADD_TO_DEVICE,
-	SWITCHDEV_FDB_DEL_TO_DEVICE,
-	SWITCHDEV_FDB_OFFLOADED,
-	SWITCHDEV_FDB_FLUSH_TO_BRIDGE,
-
-	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
-	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
-	SWITCHDEV_PORT_ATTR_SET, /* May be blocking . */
-
-	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
-	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
-	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
-	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
-	SWITCHDEV_VXLAN_FDB_OFFLOADED,
-
-	SWITCHDEV_BRPORT_OFFLOADED,
-	SWITCHDEV_BRPORT_UNOFFLOADED,
-	SWITCHDEV_BRPORT_REPLAY,
+	SWITCHDEV_TYPE_MAPPER(SWITCHDEV_TYPE_ENUMERATOR)
 };
 
 struct switchdev_notifier_info {
-- 
2.34.1


