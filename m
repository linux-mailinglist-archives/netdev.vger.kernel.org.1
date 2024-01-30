Return-Path: <netdev+bounces-67336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233D842D9D
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D065A1F252B5
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA0C762D4;
	Tue, 30 Jan 2024 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="yc7p5Ai7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EA71B53
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645990; cv=none; b=YReNVHbOu9DDj3s1+kf6MZ95nInXpU3YxeaQi486dlnlDCEb+1MFmPe/Xtl06WIp9gLa8Fu6P0j2i+mh1Vt8B8K253D4SIheVbJ07qhm5PRNKjRXPT99K19mGYQOHj1GKrQEb9uEqiwEMKUck3qipYnbGHl/CXMhhT89+QIsbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645990; c=relaxed/simple;
	bh=jCjAbkJtriD7ifpw1qebNMZZ8BWgs8SNrPPMBTZcbt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpf69wqH40YBWqQUUyRJ67769/ez675Ti0x85wNfZBHUtCmQBpM/teJIxXZWtCjgw9xwSgqVmk7ENf/8V1Gf5c9jWP+NMz9HdES+u1eSDe8ko8sE7iYeds07jLkQLhmM3/s8dogmFjwvYoXQOlcgXIURsuKBizODqzKiij2BPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=yc7p5Ai7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5111f40b8beso1069540e87.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 12:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706645987; x=1707250787; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/kR0u0El9IYx1DrH3bIc67HSSi50NSYYpP/QMJclvuE=;
        b=yc7p5Ai7FrLtVJkFf/l5EORcZFayOK4J7J1L0ejgFFiKXwpIu8mwyI/9Ggdk5AQcnV
         EqoJa41j4uHl3AMq3SPUoUMbb8wXAjIExrE1H9T5pLOjK6y3htMfvHl+ZzBqWMcqKmoO
         0RuIJHbC4lKlqKMVNmqWx5fh5Baec+zO6u30EUQ8tkKPSFxtxSqXxTFbLXULbef/9OyU
         aXjemEnq2ZnieF5oslb6QsJMkXqxqklAI6aiIvxoU+dpyR64WM0ndm0slt1nelWffX0m
         +AaD3VFv87Cutfs8YM6RXdc9ltzEIkoVT7ujF08Ld4NMonSrw7vOihjN792Z8hFHCZZp
         cHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645987; x=1707250787;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kR0u0El9IYx1DrH3bIc67HSSi50NSYYpP/QMJclvuE=;
        b=tdQa02/Dvu+BpiEUrqwXaJ00POwV8vvF742YVsmTdZN6oIKJWUyPtFhd6JT8X3C4RP
         Fks6XF91CaF6/d71uuRQ05ioG/HWd4p0bZCICzB4XMFbKloul5rJliQ87rb3tRgoAqdq
         rjgvgCS+4d/GHwSd1PeiHdUOQGgqLaEajQlPBXhPmwSOaMlDWU/LWGX2HO4CkXXv3Cat
         9hOY2lYHad47IirAAV54+tGBT+4uUrTBgoOLzIK4a2ShBaqGY6uyXBYtS2/sZdF2FJSY
         E7PKWRHuK1PMAaU14+Z0iVhE46zvNmu3h1BleVmry/R/grHg3nE4v8SU5GaQEQiN16gI
         qsNQ==
X-Gm-Message-State: AOJu0YxyC11px3ovo5f2cTEn/qAcJsF1UORYehldvEyo4UNpW6v3EOws
	vgUio/jokU5ZvheTig3qzw8o52IXcNSmXAk9ZZND0TC+6Fbuh1MD0DogYR7+WAA=
X-Google-Smtp-Source: AGHT+IFh0HHVll5sw5Nq4AgsSSSI6YdJFc2R2Mq9ChKyGSUXQib91Y/1HO7g3O8kQlRBD9kVGoUQwA==
X-Received: by 2002:a05:6512:3046:b0:50e:7124:8953 with SMTP id b6-20020a056512304600b0050e71248953mr7611361lfb.26.1706645986755;
        Tue, 30 Jan 2024 12:19:46 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056512480f00b0051011f64e1bsm1553239lfb.142.2024.01.30.12.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:19:45 -0800 (PST)
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
Subject: [PATCH v2 net-next 2/5] net: switchdev: Add helpers to display switchdev objects as strings
Date: Tue, 30 Jan 2024 21:19:34 +0100
Message-Id: <20240130201937.1897766-3-tobias@waldekranz.com>
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

Useful both in error messages and in tracepoints.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h       |  14 ++
 net/switchdev/Makefile        |   2 +-
 net/switchdev/switchdev-str.c | 278 ++++++++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 net/switchdev/switchdev-str.c

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 76eabf95c647..250053748c08 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -391,6 +391,20 @@ int switchdev_handle_port_attr_set(struct net_device *dev,
 			int (*set_cb)(struct net_device *dev, const void *ctx,
 				      const struct switchdev_attr *attr,
 				      struct netlink_ext_ack *extack));
+
+/* switchdev-str.c */
+ssize_t switchdev_attr_str(const struct switchdev_attr *attr,
+			   char *buf, size_t len);
+ssize_t switchdev_obj_str(const struct switchdev_obj *obj,
+			  char *buf, size_t len);
+ssize_t switchdev_fdb_info_str(enum switchdev_notifier_type nt,
+			       const struct switchdev_notifier_fdb_info *fdbi,
+			       char *buf, size_t len);
+ssize_t switchdev_brport_str(const struct switchdev_brport *brport,
+			     char *buf, size_t len);
+ssize_t switchdev_notifier_str(enum switchdev_notifier_type nt,
+			       const struct switchdev_notifier_info *info,
+			       char *buf, size_t len);
 #else
 
 static inline int
diff --git a/net/switchdev/Makefile b/net/switchdev/Makefile
index c5561d7f3a7c..a40e4421087b 100644
--- a/net/switchdev/Makefile
+++ b/net/switchdev/Makefile
@@ -3,4 +3,4 @@
 # Makefile for the Switch device API
 #
 
-obj-y += switchdev.o
+obj-y += switchdev.o switchdev-str.o
diff --git a/net/switchdev/switchdev-str.c b/net/switchdev/switchdev-str.c
new file mode 100644
index 000000000000..a1fa7315cc28
--- /dev/null
+++ b/net/switchdev/switchdev-str.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/if_bridge.h>
+#include <net/switchdev.h>
+
+static ssize_t switchdev_str_write_id(char *buf, size_t len, unsigned long id,
+				      const char *const *names, size_t n_names)
+{
+	if (id < n_names && names[id])
+		return snprintf(buf, len, "%s", names[id]);
+
+	return snprintf(buf, len, "UNKNOWN<%lu>", id);
+}
+
+ssize_t switchdev_attr_str(const struct switchdev_attr *attr,
+			   char *buf, size_t len)
+{
+#define _ATTR_ID_STRINGER(_id) [SWITCHDEV_ATTR_ID_ ## _id] = #_id
+	static const char *const attr_id_strs[] = {
+		SWITCHDEV_ATTR_ID_MAPPER(_ATTR_ID_STRINGER)
+	};
+#undef _ATTR_ID_STRINGER
+
+	static const char *const stp_state_strs[] = {
+		[BR_STATE_DISABLED] = "disabled",
+		[BR_STATE_LISTENING] = "listening",
+		[BR_STATE_LEARNING] = "learning",
+		[BR_STATE_FORWARDING] = "forwarding",
+		[BR_STATE_BLOCKING] = "blocking",
+	};
+
+	char *cur = buf;
+	ssize_t n;
+
+	n = switchdev_str_write_id(cur, len, attr->id, attr_id_strs,
+				   ARRAY_SIZE(attr_id_strs));
+	if (n < 0)
+		return n;
+
+	cur += n;
+	len -= n;
+
+	n = snprintf(cur, len, "(flags %#x orig %s) ", attr->flags,
+		     attr->orig_dev ? netdev_name(attr->orig_dev) : "(null)");
+	if (n < 0)
+		return n;
+
+	cur += n;
+	len -= n;
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
+		n = switchdev_str_write_id(cur, len, attr->u.stp_state,
+					   stp_state_strs, ARRAY_SIZE(stp_state_strs));
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_MST_STATE:
+		n = snprintf(cur, len, "msti %u", attr->u.mst_state.msti);
+		if (n < 0)
+			return n;
+
+		cur += n;
+		len -= n;
+
+		n = switchdev_str_write_id(cur, len, attr->u.mst_state.state,
+					   stp_state_strs, ARRAY_SIZE(stp_state_strs));
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		n = snprintf(cur, len, "val %#lx mask %#lx",
+			     attr->u.brport_flags.val,
+			     attr->u.brport_flags.mask);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_MROUTER:
+	case SWITCHDEV_ATTR_ID_BRIDGE_MROUTER:
+		n = snprintf(cur, len, "%s",
+			     attr->u.mrouter ? "enabled" : "disabled");
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
+		n = snprintf(cur, len, "%ums",
+			     jiffies_to_msecs(clock_t_to_jiffies(attr->u.ageing_time)));
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
+		n = snprintf(cur, len, "%s",
+			     attr->u.vlan_filtering ? "enabled" : "disabled");
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL:
+		n = snprintf(cur, len, "%#x", attr->u.vlan_protocol);
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED:
+		n = snprintf(cur, len, "%s",
+			     attr->u.mc_disabled ? "active" : "inactive");
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_MST:
+		n = snprintf(cur, len, "%s",
+			     attr->u.mst ? "enabled" : "disabled");
+		break;
+	case SWITCHDEV_ATTR_ID_VLAN_MSTI:
+		n = snprintf(cur, len, "vid %u msti %u",
+			     attr->u.vlan_msti.vid, attr->u.vlan_msti.msti);
+		break;
+	default:
+		/* Trim trailing space */
+		return --cur - buf;
+	}
+
+	if (n < 0)
+		return n;
+
+	cur += n;
+	return cur - buf;
+}
+EXPORT_SYMBOL_GPL(switchdev_attr_str);
+
+ssize_t switchdev_obj_str(const struct switchdev_obj *obj,
+			  char *buf, size_t len)
+{
+#define _OBJ_ID_STRINGER(_id) [SWITCHDEV_OBJ_ID_ ## _id] = #_id
+	static const char *const obj_id_strs[] = {
+		SWITCHDEV_OBJ_ID_MAPPER(_OBJ_ID_STRINGER)
+	};
+#undef _OBJ_ID_STRINGER
+
+	const struct switchdev_obj_port_vlan *vlan;
+	const struct switchdev_obj_port_mdb *mdb;
+	char *cur = buf;
+	ssize_t n;
+
+	n = switchdev_str_write_id(cur, len, obj->id, obj_id_strs,
+				   ARRAY_SIZE(obj_id_strs));
+	if (n < 0)
+		return n;
+
+	cur += n;
+	len -= n;
+
+	n = snprintf(cur, len, "(flags %#x orig %s) ", obj->flags,
+		     obj->orig_dev ? netdev_name(obj->orig_dev) : "(null)");
+	if (n < 0)
+		return n;
+
+	cur += n;
+	len -= n;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+		n = snprintf(cur, len, "vid %u flags %#x%s", vlan->vid,
+			     vlan->flags, vlan->changed ? "(changed)" : "");
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
+		n = snprintf(cur, len, "vid %u addr %pM", mdb->vid, mdb->addr);
+		break;
+	default:
+		/* Trim trailing space */
+		return --cur - buf;
+	}
+
+	if (n < 0)
+		return n;
+
+	cur += n;
+	return cur - buf;
+}
+EXPORT_SYMBOL_GPL(switchdev_obj_str);
+
+ssize_t switchdev_fdb_info_str(enum switchdev_notifier_type nt,
+			       const struct switchdev_notifier_fdb_info *fdbi,
+			       char *buf, size_t len)
+{
+	switch (nt) {
+	case SWITCHDEV_FDB_FLUSH_TO_BRIDGE:
+		return snprintf(buf, len, "vid %u", fdbi->vid);
+	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
+	case SWITCHDEV_FDB_DEL_TO_BRIDGE:
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+	case SWITCHDEV_FDB_OFFLOADED:
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE:
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE:
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE:
+	case SWITCHDEV_VXLAN_FDB_OFFLOADED:
+		return snprintf(buf, len, "vid %u addr %pM%s%s%s%s",
+				fdbi->vid, fdbi->addr,
+				fdbi->added_by_user ? " added_by_user" : "",
+				fdbi->is_local ? " is_local" : "",
+				fdbi->locked ? " locked" : "",
+				fdbi->offloaded ? " offloaded" : "");
+	default:
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(switchdev_fdb_info_str);
+
+ssize_t switchdev_brport_str(const struct switchdev_brport *brport,
+			     char *buf, size_t len)
+{
+	return snprintf(buf, len, "dev %s%s",
+			brport->dev ? netdev_name(brport->dev) : "(null)",
+			brport->tx_fwd_offload ? " tx_fwd_offload" : "");
+}
+EXPORT_SYMBOL_GPL(switchdev_brport_str);
+
+ssize_t switchdev_notifier_str(enum switchdev_notifier_type nt,
+			       const struct switchdev_notifier_info *info,
+			       char *buf, size_t len)
+{
+#define _TYPE_STRINGER(_id) [SWITCHDEV_ ## _id] = #_id
+	static const char *const type_strs[] = {
+		SWITCHDEV_TYPE_MAPPER(_TYPE_STRINGER)
+	};
+#undef _TYPE_STRINGER
+
+	const struct switchdev_notifier_port_attr_info *attri;
+	const struct switchdev_notifier_brport_info *brporti;
+	const struct switchdev_notifier_port_obj_info *obji;
+	const struct switchdev_notifier_fdb_info *fdbi;
+	char *cur = buf;
+	ssize_t n;
+
+	n = switchdev_str_write_id(cur, len, nt, type_strs,
+				   ARRAY_SIZE(type_strs));
+	if (n < 0)
+		return n;
+
+	cur += n;
+	len -= n;
+
+	if (len > 0) {
+		*cur++ = ' ';
+		len--;
+	}
+
+	switch (nt) {
+	case SWITCHDEV_FDB_FLUSH_TO_BRIDGE:
+	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
+	case SWITCHDEV_FDB_DEL_TO_BRIDGE:
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+	case SWITCHDEV_FDB_OFFLOADED:
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE:
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE:
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE:
+	case SWITCHDEV_VXLAN_FDB_OFFLOADED:
+		fdbi = container_of(info, typeof(*fdbi), info);
+		n = switchdev_fdb_info_str(nt, fdbi, cur, len);
+		break;
+	case SWITCHDEV_PORT_OBJ_ADD:
+	case SWITCHDEV_PORT_OBJ_DEL:
+		obji = container_of(info, typeof(*obji), info);
+		n = switchdev_obj_str(obji->obj, cur, len);
+		break;
+	case SWITCHDEV_PORT_ATTR_SET:
+		attri = container_of(info, typeof(*attri), info);
+		n = switchdev_attr_str(attri->attr, cur, len);
+		break;
+	case SWITCHDEV_BRPORT_OFFLOADED:
+	case SWITCHDEV_BRPORT_UNOFFLOADED:
+	case SWITCHDEV_BRPORT_REPLAY:
+		brporti = container_of(info, typeof(*brporti), info);
+		n = switchdev_brport_str(&brporti->brport, cur, len);
+		break;
+	default:
+		/* Trim trailing space */
+		return --cur - buf;
+	}
+
+	if (n < 0)
+		return n;
+
+	cur += n;
+	return cur - buf;
+}
+EXPORT_SYMBOL_GPL(switchdev_notifier_str);
-- 
2.34.1


