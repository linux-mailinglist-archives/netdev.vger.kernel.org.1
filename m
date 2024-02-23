Return-Path: <netdev+bounces-74366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512E68610B9
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A50285915
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AA57AE6E;
	Fri, 23 Feb 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="aWN4KV54"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3879DB5
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688812; cv=none; b=RYGvLy/IdpTtHLuN8PuYU8wkKMjmBL981Das6Yce/5nAMF8T8uaf8GsmJw09eseu+NkD9jPENjeWnOzBRotKLBCr7t8+eIVF6of7sI47fhog8R1g/nDFWDjgYnZvRek19frY3AGzdxSvI7cKUHJodJkw03lvbzyC2dgdRK8re5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688812; c=relaxed/simple;
	bh=n1GgHYtHsxsrAzgKRx3jPsMiLP1I7jvaanq3ckoFtwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7rPjsfS92oU0iavMlWmdNvO63lBzDVODcKaOEGYdYOV/BPU+2DTnUK6MqMyeBLLbCmqtxhpqKDIfPZ/9sj8EMIcuTI2CNfrr9TgmV3h/7qhczOoFC+PBynOnyjlD8szu/8b3VtGmjxvqzI74B4+VpJMqu88UF0UaLbJs4/Rkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=aWN4KV54; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d09cf00214so11127941fa.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688809; x=1709293609; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zkDAooeQBr5rThauoM1g1MywPOKO4Mf+GehhCfGa7To=;
        b=aWN4KV54dKK9VHoKadGzpOckv2CcQOP0AXDE0QFfY9BUUnbjEB9EKgY2xmyPrQEQqM
         bKWbBKk8lP6zq8udHmbwIgddbShCVyJOLOpV7D5PAahdReE4qioyCjvny/HQz0RQWWFG
         NZ7TskyYTuhyvPTu06ubla7LabeXFX8Ep7cbdUsH1vqIAKD1qgg/lSLOTw+KFncgvO9d
         MZ+of1MstLfc+XjLWqneGN5a3HVQ8474KniGVT/Ti4kqrvft6oS+Oh1RPUPnKKn73tHj
         lTUTZOSCpKVDVFsMDWUt0argyPV7gt2Kt8qq2MqUTD9V/V7R4bUMnnyd7HltkkQ0HVHM
         DWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688809; x=1709293609;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkDAooeQBr5rThauoM1g1MywPOKO4Mf+GehhCfGa7To=;
        b=otJgD4lpdWn+4ya9kWd+8eDsf4DRh7D3wNtYmrgXXeLw6peGF6f++zQ81D5JfJEZQO
         7vWqn0ggEpwR4+d7Vd40an02FE1RcIYdn6pCLYMO9S5onIIpwRUi1ka6PJitphxEY+R1
         69i4fQgZsh3p5l3sJNNim251vYWonZezc7B8F6OKjoO3LC5AfzRQ6X5wVV9zTvl5rfVO
         COX4remYorMAKPbI4KhjknMM5x/VucpXD5VIWDSBke4gEZtCh0bO/d0HYGTL6bGcXQ9u
         lBgltl8QyI38BUuRJMTj0ZU1nDllNKO99DgpzkKNvH1KGdlFVPFKJ6sBMRycrKISMJGo
         6dCg==
X-Forwarded-Encrypted: i=1; AJvYcCVsaA4C/yE6f9F3b67WBKuLxni5YbP3t2DgXD+hsaKvO+wMQxpvLO08gcWznThctn+ltcQoECjjuDtXl16SM+8wGxiMkAYN
X-Gm-Message-State: AOJu0YxKk3MATiMqV3KSYC+hp5pNWwI1sA2+8Mo5O3TeP8ELOHxJ5D4f
	cfCJVmRWW0Pr4PR5p2Nce3BsEUCYM9GijGae0YdEWXMDFiDWrd44Y2WepQqlm7s=
X-Google-Smtp-Source: AGHT+IGDDaf54W831L5Ts8Flm3Ec9j0oLrGHQ4QMtQP0ylEjumhcZqW25LR2wJeBe/FFYgdBRSZ+Mg==
X-Received: by 2002:ac2:4d03:0:b0:512:b24c:dba with SMTP id r3-20020ac24d03000000b00512b24c0dbamr1074063lfi.60.1708688809124;
        Fri, 23 Feb 2024 03:46:49 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:48 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 1/4] net: switchdev: Wrap enums in mapper macros
Date: Fri, 23 Feb 2024 12:44:50 +0100
Message-Id: <20240223114453.335809-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223114453.335809-1-tobias@waldekranz.com>
References: <20240223114453.335809-1-tobias@waldekranz.com>
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
index 8346b0d29542..86298a21c6c8 100644
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


