Return-Path: <netdev+bounces-74367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ADC8610BC
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3791F21423
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9B67A733;
	Fri, 23 Feb 2024 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="k7LPgUaP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AA67AE47
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688814; cv=none; b=DgXu9nhTnhtOFDY3meZchYvSHkfZXfiAjAwMxN8P8yBzF/aOTqvFrq8wmWnMOiKA/ZjlFeaahMGiOOmEwIWldrKSinbTYEK/2/N94+/1+jIvxaO1SB0nx+JEEMc8QeH3sx/BaHoPpC7Ik6HVbHrj8r+KAzRhHaM4NP2J7/R85ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688814; c=relaxed/simple;
	bh=8I/5DOW5gW4lbco+7gFw8uvyQqN/6Ux3tmUrXsaJIkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCZm4U1LX6rhW3OMaTw+P84WiBdXUX+AEVQ9KKJrOfqKzOAjWrpKra4RfS1yO8Nq5gzADylpY83E5oYI9C68u5ySRknMz6eo0Qs+G3C5fElXFucdDk7CuPIoAsc5xMCJ5o2TrphtaRzUxX5YxQzMNr/1hTe6Zpa4YDs1krYmTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=k7LPgUaP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512cba0f953so890076e87.2
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688810; x=1709293610; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HiVTpXcFGxZ36jj3cKnJQtbHcUpuJpU/8Cq1LhZQMSg=;
        b=k7LPgUaPjZr0hf5Tcyk9+Momy8BIMDnQovyohkRDbsjnCoCAlvwxj2YUiD3bmDcK16
         k44Qs8zAVPv+DqlYftbr5A6QBgPFWHKZ+pZZ1GjVOI3ijGKycT9fZUl8k8LWTmRACTdM
         HoXvtm1DGhYxOR7gFYfrqR/S1MzuhqjiWXQ7YIbsWP/VTTRS5N6gI5Nj0ZwOY6I4sGq1
         S92AOSZRqi6ZArg0WPmaHy1gB2QBhqLsUPoYzzIfVKDCD1ydGZ+efnF6rsXlfx9BSzTN
         vMNyzOZpwP1jQ/Di7w5WUSfQDFrwc9vGoDgvk2HCEIoGzBvNiXmYK2tfKUU+Zawxfame
         0QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688810; x=1709293610;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiVTpXcFGxZ36jj3cKnJQtbHcUpuJpU/8Cq1LhZQMSg=;
        b=WvdPBxZBpfy8vFw/EN9v6KQS5M6q0GndSdS+24N4ZHqOG8O5KjwTkPQZdx1msj3M81
         m9QmAV4CQM/KJN4XNyBxX5t2MpfBwHsZtZ8tOFwoDuZyBXZfqA84fN3w4fxJCvWT9g7c
         xSsgVvkdp1DdS/kD7//YatRi4GkA3fpVZ6n6DMcIW1X+R1WsYLR/2IeInvfoLVo7O1ZF
         QismKBaAiwMuQHB2mqeBbm/mUFB+3c230QxL0VnzT2m/GoZdsUpjmfkT4VqNIzppwcZQ
         kW7mzCWDIH74/RK5h1/7jvPqhG3VSFcRl3QkCYUCIcPxa4FuYZX6yaqFpgrkCHPVyGCI
         1u9g==
X-Forwarded-Encrypted: i=1; AJvYcCWJ8OrLWboG6QuCRAWAZBh0KXzmF8siz8uQ82y1qa6d62Qp3oTf7TVN/ojX6AVjKOD/t80rvwBgrAjCflJv7KKL8fNKvh/t
X-Gm-Message-State: AOJu0YwsvGTdlo+zoU89IrWiYK4Ch738dNp3fY77mdCl/2++BgkZoEVG
	1l2kivWyVdVqGGjuLo81wy2Y8jYiMdetwPDIXbNLrNlysgurfmqUQLn4WWSJpcg=
X-Google-Smtp-Source: AGHT+IHnvrfG+0bMJ2aDuSPshp30LXi/eioIOLjyUv8r3s1ySbENhqicUXk6EzkNy603h2zbbzTOmA==
X-Received: by 2002:ac2:5049:0:b0:512:9e9f:2f1d with SMTP id a9-20020ac25049000000b005129e9f2f1dmr1156913lfm.58.1708688810303;
        Fri, 23 Feb 2024 03:46:50 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:49 -0800 (PST)
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
Subject: [PATCH v3 net-next 2/4] net: switchdev: Add helpers to display switchdev objects as strings
Date: Fri, 23 Feb 2024 12:44:51 +0100
Message-Id: <20240223114453.335809-3-tobias@waldekranz.com>
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

Useful both in error messages and in tracepoints.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h       |  14 ++
 net/switchdev/Makefile        |   2 +-
 net/switchdev/switchdev-str.c | 278 ++++++++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 net/switchdev/switchdev-str.c

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 86298a21c6c8..9bf387664e71 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -394,6 +394,20 @@ int switchdev_handle_port_attr_set(struct net_device *dev,
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


