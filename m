Return-Path: <netdev+bounces-135087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDCF99C2B0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFEE281202
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E314B08A;
	Mon, 14 Oct 2024 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qfjYpPCJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4B14A614
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893505; cv=none; b=RO6XgHSBH6m0PTFaIGH/rEVTJmM+MDtyfwGsO5a2opGt3sWawxYyCKHp2Yh7fY5gKzJMERrNVq8/iOkxXRbE0jkE+ijkOwUjR6EKRPC/9S4gJH7ktZJl5S7l922dXQzhfjrZuHlRXPAdh31TG9BhUdA3i0HkQHOYyJFEq9RvitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893505; c=relaxed/simple;
	bh=9UNb7PKKsJz/o2S+r8MRe2fv54CYx88dkrer7Na7J00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeRw7CwLsNiIwE1pCWLj9AYUuWr4t9AMBpT/M3MVp6zzgcaNfJAvvjQ7SKUvjOkS4zqAfR2lFqbUwAQbvuaFVDsYXJyqfnciezzZrZQPjpYF6Behe4UazgvghYDwrXJg0WqSjAZ0DbUSHo+9BGNB4ypfsZ3MPkdp2yO0u7LyWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qfjYpPCJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so2138331f8f.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 01:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728893502; x=1729498302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXNlcvr0PxQxP3sirNUWwavi2m6orpeMlZrWPoTdICc=;
        b=qfjYpPCJX8SjBYpPc0inqp7x2/ThADFKldAHlub3vSoCGaBgSOo3FsJptWjvGsjLfK
         2jXjyxzMH1ylSheUk3OimsY1HhlxqIq3izZhtE/9qpJ3aDQNhx/uU/MI8T7pv9+cKBHI
         vN0iaQ8NWtsDyB4W/udaeeqniAKIqy1VgY9/vlU1TB2MiBEjbkkc00kclRzIKGeSP3v5
         KUlLuE9GWyWMazLNvjL2w0gKmYzsYyRwE/FbPnY64ZbqtCQ4RYm2IixJjgqqYm4HECS/
         PlqbXqILdckwiF+4CCEQT62BfnIfJfSghQBgw1zsbSi/WBxs0+xN90bnTibdCxxTIfHi
         61cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893502; x=1729498302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXNlcvr0PxQxP3sirNUWwavi2m6orpeMlZrWPoTdICc=;
        b=jPQJlkv7LMT8YsKS75eusdCBlfGvkon8n5lyjXFtWWV68XyHGt7MrXi/8uAgrTDX0+
         xCY5pzstpvBSTOK1KL2JvqueMadcxixR9E0ffEbbnyIEE4oGiF5uE5yrFWEPT8CPVZTn
         1hxV6z6TQctXJF9HLZwJGOWzAxtJg96RNXOWye2c0go3zdK38ikIU2uYyPP9RhDgGhav
         FNvAlJPGRqnKWjh2F9CIpxvxs1rB72sugOfswHejYD3i20RAvKRuhxlcdK96Q4ZmUN/T
         TyF5n65p7RDT8q17IlIcS47QgHhnwaOAOt23Werj4Vs0ViTAgHCE/fjd94k5E+lYmuhx
         q9bg==
X-Gm-Message-State: AOJu0YwA6ft5QDBIoI/buTPx8bUfkYu9X6Yiz6rdN6ROXTNas1e3q+YL
	LnZGtIeF22KYBEQl1SvkxL4O/FCNFp8lntVlpbFpzq+TNuplE6C5Pxh9iQ8v8Uz3GHJI0BjFrdV
	8hyQ=
X-Google-Smtp-Source: AGHT+IHidjcVM4ODWZQ/ypexliawY2ld86NLWxxf7690uPUCeFWMwSv7d39lDbxQJAeneEffYfQAuw==
X-Received: by 2002:a05:6000:10c5:b0:374:b5fc:d31a with SMTP id ffacd0b85a97d-37d551fb375mr6621350f8f.25.1728893501386;
        Mon, 14 Oct 2024 01:11:41 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b42d8sm147674755e9.31.2024.10.14.01.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:11:40 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com
Subject: [PATCH net-next v3 1/2] dpll: add clock quality level attribute and op
Date: Mon, 14 Oct 2024 10:11:32 +0200
Message-ID: <20241014081133.15366-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014081133.15366-1-jiri@resnulli.us>
References: <20241014081133.15366-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In order to allow driver expose quality level of the clock it is
running, introduce a new netlink attr with enum to carry it to the
userspace. Also, introduce an op the dpll netlink code calls into the
driver to obtain the value.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- changed "itu" prefix to "itu-opt1"
- changed driver op to pass bitmap to allow to set multiple qualities
  and pass it to user over multiple attrs
- enhanced the documentation a bit
v1->v2:
- extended quality enum documentation
- added "itu" prefix to the enum values
---
 Documentation/netlink/specs/dpll.yaml | 35 +++++++++++++++++++++++++++
 drivers/dpll/dpll_netlink.c           | 24 ++++++++++++++++++
 include/linux/dpll.h                  |  4 +++
 include/uapi/linux/dpll.h             | 24 ++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index f2894ca35de8..0bd708e136ff 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -85,6 +85,36 @@ definitions:
           This may happen for example if dpll device was previously
           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
     render-max: true
+  -
+    type: enum
+    name: clock-quality-level
+    doc: |
+      level of quality of a clock device. This mainly applies when
+      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
+      The current list is defined according to the table 11-7 contained
+      in ITU-T G.8264/Y.1364 document. One may extend this list freely
+      by other ITU-T defined clock qualities, or different ones defined
+      by another standardization body (for those, please use
+      different prefix).
+    entries:
+      -
+        name: itu-opt1-prc
+        value: 1
+      -
+        name: itu-opt1-ssu-a
+      -
+        name: itu-opt1-ssu-b
+      -
+        name: itu-opt1-eec1
+      -
+        name: itu-opt1-prtc
+      -
+        name: itu-opt1-eprtc
+      -
+        name: itu-opt1-eeec
+      -
+        name: itu-opt1-eprc
+    render-max: true
   -
     type: const
     name: temp-divider
@@ -252,6 +282,11 @@ attribute-sets:
         name: lock-status-error
         type: u32
         enum: lock-status-error
+      -
+        name: clock-quality-level
+        type: u32
+        enum: clock-quality-level
+        multi-attr: true
   -
     name: pin
     enum-name: dpll_a_pin
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index fc0280dcddd1..c130f87147fa 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -169,6 +169,27 @@ dpll_msg_add_temp(struct sk_buff *msg, struct dpll_device *dpll,
 	return 0;
 }
 
+static int
+dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct dpll_device *dpll,
+				 struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX) = { 0 };
+	enum dpll_clock_quality_level ql;
+	int ret;
+
+	if (!ops->clock_quality_level_get)
+		return 0;
+	ret = ops->clock_quality_level_get(dpll, dpll_priv(dpll), qls, extack);
+	if (ret)
+		return ret;
+	for_each_set_bit(ql, qls, DPLL_CLOCK_QUALITY_LEVEL_MAX)
+		if (nla_put_u32(msg, DPLL_A_CLOCK_QUALITY_LEVEL, ql))
+			return -EMSGSIZE;
+
+	return 0;
+}
+
 static int
 dpll_msg_add_pin_prio(struct sk_buff *msg, struct dpll_pin *pin,
 		      struct dpll_pin_ref *ref,
@@ -557,6 +578,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 	if (ret)
 		return ret;
 	ret = dpll_msg_add_lock_status(msg, dpll, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_clock_quality_level(msg, dpll, extack);
 	if (ret)
 		return ret;
 	ret = dpll_msg_add_mode(msg, dpll, extack);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 81f7b623d0ba..5e4f9ab1cf75 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -26,6 +26,10 @@ struct dpll_device_ops {
 			       struct netlink_ext_ack *extack);
 	int (*temp_get)(const struct dpll_device *dpll, void *dpll_priv,
 			s32 *temp, struct netlink_ext_ack *extack);
+	int (*clock_quality_level_get)(const struct dpll_device *dpll,
+				       void *dpll_priv,
+				       unsigned long *qls,
+				       struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_ops {
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index b0654ade7b7e..4b37542eace3 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -79,6 +79,29 @@ enum dpll_lock_status_error {
 	DPLL_LOCK_STATUS_ERROR_MAX = (__DPLL_LOCK_STATUS_ERROR_MAX - 1)
 };
 
+/**
+ * enum dpll_clock_quality_level - level of quality of a clock device. This
+ *   mainly applies when the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
+ *   The current list is defined according to the table 11-7 contained in ITU-T
+ *   G.8264/Y.1364 document. One may extend this list freely by other ITU-T
+ *   defined clock qualities, or different ones defined by another
+ *   standardization body (for those, please use different prefix).
+ */
+enum dpll_clock_quality_level {
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_PRC = 1,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_SSU_A,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_SSU_B,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EEC1,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_PRTC,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRTC,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EEEC,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRC,
+
+	/* private: */
+	__DPLL_CLOCK_QUALITY_LEVEL_MAX,
+	DPLL_CLOCK_QUALITY_LEVEL_MAX = (__DPLL_CLOCK_QUALITY_LEVEL_MAX - 1)
+};
+
 #define DPLL_TEMP_DIVIDER	1000
 
 /**
@@ -180,6 +203,7 @@ enum dpll_a {
 	DPLL_A_TEMP,
 	DPLL_A_TYPE,
 	DPLL_A_LOCK_STATUS_ERROR,
+	DPLL_A_CLOCK_QUALITY_LEVEL,
 
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
-- 
2.47.0


