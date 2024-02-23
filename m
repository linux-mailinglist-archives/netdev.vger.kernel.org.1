Return-Path: <netdev+bounces-74369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB0A8610C1
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B7B1F21DDC
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670797BB16;
	Fri, 23 Feb 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="TgLW/B3S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC27B3F9
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688816; cv=none; b=pC/9t9AKvuJoTlpy1/FTe3JkgKgI51uODAGtADdaE4eCA2cosSF4mhSWjIZEkjgi0Q6dmLJBkTTs4CaoDp0hYnHEowo/8l8hVKNF4E26PEnY6R3nYUS7dpQLldeoRmLJouGJK/mz3Z6qcPD766URZ7JN+TucRbCWyTIeEQCr0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688816; c=relaxed/simple;
	bh=Aklu3AOTd5lHiK77HWRI2BGxuV00bQ+Z+t85v8TanpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/KTckv5n3ZjqudF2MDkLcQ3Usd6QTaEgNTOXmJkI40PTtsI7zTotEj7v36Se60Y2zgNxktaKUj1SZVrr1BtCFxfWus5Uq9HiEZwPXyT9tsV7vA7amCzhw6j9UOJo49MVQXCJWnYmlUmXDC+p10LfgpiNfxgz2GDPhcZCHK1Npc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=TgLW/B3S; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512b700c8ebso965013e87.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688812; x=1709293612; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5fiokJc9zM6smEbrCoaTInj6Uw6RY6DPtGrC3zqaCf0=;
        b=TgLW/B3SAxAycEwIpc9F6XKnVl27mYYPCozNQQxUNMcKQ6nB4hOztM+uuU5QBZ6HNz
         I63M3/wU2ZtvwEXJ79w3QEVkEu1+vfBJqJ3XUgfPycjNAtp9STHFSBrEON17nF3y9Hmy
         ywdNySgZAzwchejgSCZrZZX5UlDX6IEb4nLxUjDP9T+DcufP+QCw92BHQaoOdTK0wuLv
         4XzHOynIHoKnIHd8eyTPzxSHElTNOvqMDcJEIj6wt/NhFCH1fAso1rD2y+1k4MYMNo0F
         rBSz0faoMHNukbUEWqJbHVctatXc1rEZy1HDwSuolYYqd+3MS9puUyQvionrgHeIlHKI
         fHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688812; x=1709293612;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fiokJc9zM6smEbrCoaTInj6Uw6RY6DPtGrC3zqaCf0=;
        b=ihIWpnIVvgiOI4Vsmqvd5SYoYWwFXndMLvDjWywtIqY4S9Vl3lhoCr9rv5SkjhRiXA
         4qpkGI4wZdogA5AMxeWONyiarVJEMrq+kQnfIFKSGK6lgWGIDfaynGNhWpLcigo0aC4A
         oGxs3Go7QLnrhnr01zYlCjfJXpdy2r9cPsai50zoKuSNGSV0cEMY4WJJbjf8tH+psNUk
         tHWKhxXBEaCcVstd0eOLFqNcXw5LW4Hs1/N5J7CnAkZeEmUiQoPs6xF5+8sbsjWIHJjC
         PFOkEVpNpJGxrjg7MFVydkGBxUWemt4c6bI5f2lZ7rgMS8EQUx/KfVVoQA3xSLBBOPZG
         oUrg==
X-Forwarded-Encrypted: i=1; AJvYcCWX+zK51gpuxl6fGE6j3hxoWzS8oNeNUgSDIYplehxs11wVi9UYceDzVNyiskOidNiBjG/A51ZRwNUd6G7MPJ9GU5nndF+c
X-Gm-Message-State: AOJu0YyojS53jZAFvFgnnXWPoXi5e72PRHeD0l0hQDkcaFQ79hYNqkwK
	UWhrXbFXZCGtObuiAA8gPOEVcEweJAXnD6i8mERuXxDfHnCDqJ6vUwvTiE83VzM=
X-Google-Smtp-Source: AGHT+IGBYXLp3kgxZ52vrpr0KeBz25IpYvIgdCgnLA0WXvBUzRaSDJyjGBlXkb3ZmlOXmDfSlXQQtw==
X-Received: by 2002:a05:6512:6d0:b0:512:ac4a:4e07 with SMTP id u16-20020a05651206d000b00512ac4a4e07mr1773844lff.30.1708688812362;
        Fri, 23 Feb 2024 03:46:52 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:51 -0800 (PST)
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
Subject: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
Date: Fri, 23 Feb 2024 12:44:53 +0100
Message-Id: <20240223114453.335809-5-tobias@waldekranz.com>
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

Add a basic set of tracepoints:

- switchdev_defer: Fires whenever an operation is enqueued to the
  switchdev workqueue for deferred delivery.

- switchdev_call_{atomic,blocking}: Fires whenever a notification is
  sent to the corresponding switchdev notifier chain.

- switchdev_call_replay: Fires whenever a notification is sent to a
  specific driver's notifier block, in response to a replay request.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/trace/events/switchdev.h | 74 ++++++++++++++++++++++++++++++++
 net/switchdev/switchdev.c        | 71 +++++++++++++++++++++++++-----
 2 files changed, 135 insertions(+), 10 deletions(-)
 create mode 100644 include/trace/events/switchdev.h

diff --git a/include/trace/events/switchdev.h b/include/trace/events/switchdev.h
new file mode 100644
index 000000000000..dcaf6870d017
--- /dev/null
+++ b/include/trace/events/switchdev.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM	switchdev
+
+#if !defined(_TRACE_SWITCHDEV_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SWITCHDEV_H
+
+#include <linux/tracepoint.h>
+#include <net/switchdev.h>
+
+#define SWITCHDEV_TRACE_MSG_MAX 128
+
+DECLARE_EVENT_CLASS(switchdev_call,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, val)
+		__string(dev, info->dev ? netdev_name(info->dev) : "(null)")
+		__field(const struct switchdev_notifier_info *, info)
+		__field(int, err)
+		__array(char, msg, SWITCHDEV_TRACE_MSG_MAX)
+	),
+
+	TP_fast_assign(
+		__entry->val = val;
+		__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)");
+		__entry->info = info;
+		__entry->err = err;
+		switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_MSG_MAX);
+	),
+
+	TP_printk("dev %s %s -> %d", __get_str(dev), __entry->msg, __entry->err)
+);
+
+DEFINE_EVENT(switchdev_call, switchdev_defer,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err)
+);
+
+DEFINE_EVENT(switchdev_call, switchdev_call_atomic,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err)
+);
+
+DEFINE_EVENT(switchdev_call, switchdev_call_blocking,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err)
+);
+
+DEFINE_EVENT(switchdev_call, switchdev_call_replay,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err)
+);
+
+#endif /* _TRACE_SWITCHDEV_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index f73249269a87..74d715166981 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -19,6 +19,9 @@
 #include <linux/rtnetlink.h>
 #include <net/switchdev.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/switchdev.h>
+
 static bool switchdev_obj_eq(const struct switchdev_obj *a,
 			     const struct switchdev_obj *b)
 {
@@ -180,8 +183,20 @@ static void switchdev_port_attr_set_deferred(struct net_device *dev,
 static int switchdev_port_attr_set_defer(struct net_device *dev,
 					 const struct switchdev_attr *attr)
 {
-	return switchdev_deferred_enqueue(dev, attr, sizeof(*attr),
-					  switchdev_port_attr_set_deferred);
+	int err;
+
+	err = switchdev_deferred_enqueue(dev, attr, sizeof(*attr),
+					 switchdev_port_attr_set_deferred);
+
+	if (trace_switchdev_defer_enabled()) {
+		struct switchdev_notifier_port_attr_info attr_info = {
+			.info.dev = dev,
+			.attr = attr,
+		};
+
+		trace_switchdev_defer(SWITCHDEV_PORT_ATTR_SET, &attr_info.info, err);
+	}
+	return err;
 }
 
 /**
@@ -263,8 +278,20 @@ static void switchdev_port_obj_add_deferred(struct net_device *dev,
 static int switchdev_port_obj_add_defer(struct net_device *dev,
 					const struct switchdev_obj *obj)
 {
-	return switchdev_deferred_enqueue(dev, obj, switchdev_obj_size(obj),
-					  switchdev_port_obj_add_deferred);
+	int err;
+
+	err = switchdev_deferred_enqueue(dev, obj, switchdev_obj_size(obj),
+					 switchdev_port_obj_add_deferred);
+
+	if (trace_switchdev_defer_enabled()) {
+		struct switchdev_notifier_port_obj_info obj_info = {
+			.info.dev = dev,
+			.obj = obj,
+		};
+
+		trace_switchdev_defer(SWITCHDEV_PORT_OBJ_ADD, &obj_info.info, err);
+	}
+	return err;
 }
 
 /**
@@ -313,8 +340,20 @@ static void switchdev_port_obj_del_deferred(struct net_device *dev,
 static int switchdev_port_obj_del_defer(struct net_device *dev,
 					const struct switchdev_obj *obj)
 {
-	return switchdev_deferred_enqueue(dev, obj, switchdev_obj_size(obj),
-					  switchdev_port_obj_del_deferred);
+	int err;
+
+	err = switchdev_deferred_enqueue(dev, obj, switchdev_obj_size(obj),
+					 switchdev_port_obj_del_deferred);
+
+	if (trace_switchdev_defer_enabled()) {
+		struct switchdev_notifier_port_obj_info obj_info = {
+			.info.dev = dev,
+			.obj = obj,
+		};
+
+		trace_switchdev_defer(SWITCHDEV_PORT_OBJ_DEL, &obj_info.info, err);
+	}
+	return err;
 }
 
 /**
@@ -394,7 +433,11 @@ EXPORT_SYMBOL_GPL(switchdev_port_obj_act_is_deferred);
 int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
 			  struct switchdev_notifier_info *info)
 {
-	return nb->notifier_call(nb, type, info);
+	int ret;
+
+	ret = nb->notifier_call(nb, type, info);
+	trace_switchdev_call_replay(type, info, notifier_to_errno(ret));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(switchdev_call_replay);
 
@@ -437,9 +480,13 @@ int call_switchdev_notifiers(unsigned long val, struct net_device *dev,
 			     struct switchdev_notifier_info *info,
 			     struct netlink_ext_ack *extack)
 {
+	int ret;
+
 	info->dev = dev;
 	info->extack = extack;
-	return atomic_notifier_call_chain(&switchdev_notif_chain, val, info);
+	ret = atomic_notifier_call_chain(&switchdev_notif_chain, val, info);
+	trace_switchdev_call_atomic(val, info, notifier_to_errno(ret));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(call_switchdev_notifiers);
 
@@ -463,10 +510,14 @@ int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
 				      struct switchdev_notifier_info *info,
 				      struct netlink_ext_ack *extack)
 {
+	int ret;
+
 	info->dev = dev;
 	info->extack = extack;
-	return blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
-					    val, info);
+	ret = blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
+					   val, info);
+	trace_switchdev_call_blocking(val, info, notifier_to_errno(ret));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(call_switchdev_blocking_notifiers);
 
-- 
2.34.1


