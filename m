Return-Path: <netdev+bounces-133662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4E39969EF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E215B21A11
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE09193075;
	Wed,  9 Oct 2024 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UjLR6WZe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BD194AC7
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476767; cv=none; b=HrleFIgtn8cb0bSqDdfD3WNCcPusJj4Zrso5fKuwzR5iaQ5O98w5c1XFZQJXSPkksKNcagslJiOuxMjT7zfsHX0atqWLaoiSA5JoC5/JVllJRZRRRSujFdagkMMIvNXM/KDb61wQuEowwK/7+eAzspT01FERoCDJUSIWIAHPKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476767; c=relaxed/simple;
	bh=C+glbKMjnJlyCl+2w1/BKXYPasQovYzPxKzXmjE7LK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBxtgtl0OfjFuSWK458xOceK4TplLzxpYW+ub/3amnoTkDTuxrOy1nXjcP1NwhnMMRCb6JVXqJKwqxEnjY8Yd37hO94192aRf9NQ+jMHV37Kly/tSZ5/RDJKQuERjH6+gNmDBYtpDHcN5xxr3p807wqvRJPRYaJ5o9QBryiRiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UjLR6WZe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-430576ff251so12598545e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728476760; x=1729081560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCQO2FFZCGkX1V0LlbHd7X5uhHHFddu5tKuxPkK7PLQ=;
        b=UjLR6WZeGLFy6yh/+p2jeOj8t87yAtBG8/v187kYpls5RtFxX7WGc6W860dMVDLUg7
         lzzNQBgXZHNKM+t9CH3lHthklxhem6GcH6EeAgyJCafALbUjP42BeCYynPCrbter2E0d
         OGrbOt7zu/vZGWZJs0ztc4mGthwtLlYVRNnOTqAMzQwtqsJtH/Y9FN5cBnR4Bqs73fzo
         DpEffTwuwvzPL9Gp50fEyYYgqcp0PDYFmf5SnZlx026a4tKMKplFW34X5U9u2jreZ3Ff
         1D4CuWI9G36HYS7iCJ7IcLHnx5bgfFhTl7da7kOmNvgSHyR4GxR+BjoVdknWizsTTCqH
         cp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476760; x=1729081560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCQO2FFZCGkX1V0LlbHd7X5uhHHFddu5tKuxPkK7PLQ=;
        b=CasugFGb5yvvnWOPPQ9QtIw9zQAhC5nYFGw4Fa957CkDQHH5UHgIt3oWsE8MYkkn5M
         N8SqU2pmbf10lBlp+4IX7I/zAtYG8bv1y5RP3VCAJ93ncVSfFNprrlbYG7B1SK6Q5hnc
         7Ocyzn2pJL2Euj55AtB/zO/xJTlUP69WWaIEEkt6W5JUI+kpUtWi/fvt627Fqdy+VOOC
         F9nvqh6wX26HDeUQLssZvfuTgUG4uoMZ3rmXybXNgQms8huu+mzn+ldfntQeB0562dWT
         eFdQ5Xi2LGdF/5Fhm9LKUDpOPNQKPDQMudUN3N7Bb86NGZ9mAFlWreu65SLX2Q0RBR4I
         Idlg==
X-Gm-Message-State: AOJu0YxJe1tj67VHocqKAqfpRzgz3JbFVbzKh8oHJHqhgBydnqaWfIcw
	U9kDMzT5GQXntIMjiMccPqixYGAezHM/GS8yNJjIuDd4N5M8Z/qfH+BwS2UIJT+bG/Q7YH6q03z
	/Is4=
X-Google-Smtp-Source: AGHT+IHq+kUL23AGgbT4kHSc7bsF3Qj4WkpoQ7MrdkJ60nSpN2+IQ+UTMVf1i6v52EG0pzvpqdqX4w==
X-Received: by 2002:a5d:5c88:0:b0:37d:3e8c:f708 with SMTP id ffacd0b85a97d-37d3e8cf837mr1021329f8f.20.1728476760518;
        Wed, 09 Oct 2024 05:26:00 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf31a7esm19562295e9.9.2024.10.09.05.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:25:59 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] dpll: add clock quality level attribute and op
Date: Wed,  9 Oct 2024 14:25:46 +0200
Message-ID: <20241009122547.296829-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241009122547.296829-1-jiri@resnulli.us>
References: <20241009122547.296829-1-jiri@resnulli.us>
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
 Documentation/netlink/specs/dpll.yaml | 28 +++++++++++++++++++++++++++
 drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
 include/linux/dpll.h                  |  4 ++++
 include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
 4 files changed, 75 insertions(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index f2894ca35de8..77a8e9ddb254 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -85,6 +85,30 @@ definitions:
           This may happen for example if dpll device was previously
           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
     render-max: true
+  -
+    type: enum
+    name: clock-quality-level
+    doc: |
+      level of quality of a clock device.
+    entries:
+      -
+        name: prc
+        value: 1
+      -
+        name: ssu-a
+      -
+        name: ssu-b
+      -
+        name: eec1
+      -
+        name: prtc
+      -
+        name: eprtc
+      -
+        name: eeec
+      -
+        name: eprc
+    render-max: true
   -
     type: const
     name: temp-divider
@@ -252,6 +276,10 @@ attribute-sets:
         name: lock-status-error
         type: u32
         enum: lock-status-error
+      -
+        name: clock-quality-level
+        type: u32
+        enum: clock-quality-level
   -
     name: pin
     enum-name: dpll_a_pin
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index fc0280dcddd1..689a6d0ff049 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -169,6 +169,25 @@ dpll_msg_add_temp(struct sk_buff *msg, struct dpll_device *dpll,
 	return 0;
 }
 
+static int
+dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct dpll_device *dpll,
+				 struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	enum dpll_clock_quality_level ql;
+	int ret;
+
+	if (!ops->clock_quality_level_get)
+		return 0;
+	ret = ops->clock_quality_level_get(dpll, dpll_priv(dpll), &ql, extack);
+	if (ret)
+		return ret;
+	if (nla_put_u32(msg, DPLL_A_CLOCK_QUALITY_LEVEL, ql))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int
 dpll_msg_add_pin_prio(struct sk_buff *msg, struct dpll_pin *pin,
 		      struct dpll_pin_ref *ref,
@@ -557,6 +576,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
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
index 81f7b623d0ba..e99cdb8ab02c 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -26,6 +26,10 @@ struct dpll_device_ops {
 			       struct netlink_ext_ack *extack);
 	int (*temp_get)(const struct dpll_device *dpll, void *dpll_priv,
 			s32 *temp, struct netlink_ext_ack *extack);
+	int (*clock_quality_level_get)(const struct dpll_device *dpll,
+				       void *dpll_priv,
+				       enum dpll_clock_quality_level *ql,
+				       struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_ops {
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index b0654ade7b7e..0572f9376da4 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -79,6 +79,26 @@ enum dpll_lock_status_error {
 	DPLL_LOCK_STATUS_ERROR_MAX = (__DPLL_LOCK_STATUS_ERROR_MAX - 1)
 };
 
+/**
+ * enum dpll_clock_quality_level - if previous status change was done due to a
+ *   failure, this provides information of dpll device lock status error. Valid
+ *   values for DPLL_A_LOCK_STATUS_ERROR attribute
+ */
+enum dpll_clock_quality_level {
+	DPLL_CLOCK_QUALITY_LEVEL_PRC = 1,
+	DPLL_CLOCK_QUALITY_LEVEL_SSU_A,
+	DPLL_CLOCK_QUALITY_LEVEL_SSU_B,
+	DPLL_CLOCK_QUALITY_LEVEL_EEC1,
+	DPLL_CLOCK_QUALITY_LEVEL_PRTC,
+	DPLL_CLOCK_QUALITY_LEVEL_EPRTC,
+	DPLL_CLOCK_QUALITY_LEVEL_EEEC,
+	DPLL_CLOCK_QUALITY_LEVEL_EPRC,
+
+	/* private: */
+	__DPLL_CLOCK_QUALITY_LEVEL_MAX,
+	DPLL_CLOCK_QUALITY_LEVEL_MAX = (__DPLL_CLOCK_QUALITY_LEVEL_MAX - 1)
+};
+
 #define DPLL_TEMP_DIVIDER	1000
 
 /**
@@ -180,6 +200,7 @@ enum dpll_a {
 	DPLL_A_TEMP,
 	DPLL_A_TYPE,
 	DPLL_A_LOCK_STATUS_ERROR,
+	DPLL_A_CLOCK_QUALITY_LEVEL,
 
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
-- 
2.46.1


