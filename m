Return-Path: <netdev+bounces-140286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B649A9B5D6A
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 09:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4313E1F23A9D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E31E0DCE;
	Wed, 30 Oct 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yWffw4Pg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD81E0DAA
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275931; cv=none; b=qg27Iv6O/qF41Z9TDrcbOzimjzv70ZEZe++FoEitcK3QO0OvShC+SbY4MHCvlxyid2POAN9FPXcP7fxbqwcQvYGOd7q3jDdBlte9WKhPzXWcAwsrJkXFv8bY9gEVVdt85N5DKD9tL9uW8qB77ofyP3pWKXD8T1dm2UwJBQLsfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275931; c=relaxed/simple;
	bh=oTlqfHr3FC4walZt4pSbFSnRSwRPL9C0Bxp6Ha6dzZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lINy9tuh7u9nPuzbmUfJ5XYMt43fMH6c8kwCdlow7UAxYZhkpxlAHTwnJMzAi5uRepo+2NIUbxBHBovdY3sNhtevTz1aloXVgKLNV3pvRftrMDv3IXY7KfnqUG4LWmv65HdNch1MierYUcQ6EaMsSr/xA5qhmT2f98Vjjze6+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yWffw4Pg; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e13375d3so7112392e87.3
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730275926; x=1730880726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3ZKOxbHj9GU+f3af4F+AXfTiK55g3wfnII0b2pp/Nk=;
        b=yWffw4PgQ4Rjj3fjYCYOxbI10Z/WqG9sklwEvy/rKJb0HxI0NiVozRJGTmrVq/EK2v
         F5vuKMvyXr0pk9ajssZ5HUz15BoZ5mTywtMHCYn40lDVcYIJrhrN8ZhNF6ijxvYVZLws
         niJ+UTk/jcfw3Usp5FAe+b/VsRzZgxjRd/I66uw4A07PBOJ+YnSEQDV7M55mwlXIO2Jj
         4M+h9ZvAyFgafD2rIt29a7jw4lSBtIvotj7OneuOmIVmqK4Ob4S/mRfMbtm13dU6wHKU
         lITp/jMKmz/k61GjqUAj4AnEwCBCV7c1MI5JO/2pA6fWudA0JF49e85MA1xo5kk4rgUN
         zG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730275926; x=1730880726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3ZKOxbHj9GU+f3af4F+AXfTiK55g3wfnII0b2pp/Nk=;
        b=Ijeo4Ce+t2eCyNPp1qejFFDCdskWIDYtNuLhr1wxHVClyyzeqc0jW69+eF7nDJTzgo
         uYw9lSsxzO3ZEbn9xDR/ZoQzqlnjFtQoPwiFY3ymhb+d2MPDu5D6ZdgTSMHQpF071FGt
         +riwK859cRllsl9z3zrNGe30WoMY3GimBEcqHBaroZZc95iiOKHPAqL9PdeEoaztawxC
         BrwBf7q+HDugUzmQepncxPvlcNcpFl+Ser2JXwIcRPQ6hUMeNckVtkYxsXXG1cOY+97r
         OqQ7BV38OONW/60xu3LJDXiNM8pG2M0ldlyiHfvxrq/rowGAleydzKanK7PX6RhsUJ4F
         0etg==
X-Gm-Message-State: AOJu0YzQGbgSTiIHxgtUAOO5FMgXXEiGJBuKSodSq5tampvuWWvIleD6
	e49U18/N+eTgXzw8w83uHcfRC0YE3fYmMjpiTGu8PqUmjuRaFV9jBlZYTDrrq/V+Yi6BWkFPsqi
	DVRU=
X-Google-Smtp-Source: AGHT+IHXDHTFNEeJJuYaDwuQSB2pin03YCstXTXpZzkwDgSWvXj1k8vmONoffk4HNpriRv6yP9/eXA==
X-Received: by 2002:a05:6512:6cc:b0:536:56d8:24b4 with SMTP id 2adb3069b0e04-53b348c707fmr6159030e87.5.1730275925855;
        Wed, 30 Oct 2024 01:12:05 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb4b27sm14685401f8f.117.2024.10.30.01.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 01:12:05 -0700 (PDT)
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
	tariqt@nvidia.com,
	maciejm@nvidia.com
Subject: [PATCH net-next v4 1/2] dpll: add clock quality level attribute and op
Date: Wed, 30 Oct 2024 09:11:56 +0100
Message-ID: <20241030081157.966604-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030081157.966604-1-jiri@resnulli.us>
References: <20241030081157.966604-1-jiri@resnulli.us>
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
v3->v4:
- changed clock-quality-level enum documentation to clearly talk about
  holdover status.
- added documentation of clock-quality-level attribute to explain when
  it can be put multiple times
v2->v3:
- changed "itu" prefix to "itu-opt1"
- changed driver op to pass bitmap to allow to set multiple qualities
  and pass it to user over multiple attrs
- enhanced the documentation a bit
v1->v2:
- extended quality enum documentation
- added "itu" prefix to the enum values
---
 Documentation/netlink/specs/dpll.yaml | 41 +++++++++++++++++++++++++++
 drivers/dpll/dpll_netlink.c           | 24 ++++++++++++++++
 include/linux/dpll.h                  |  4 +++
 include/uapi/linux/dpll.h             | 24 ++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index f2894ca35de8..8feefeae5376 100644
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
+      the dpll lock-status is DPLL_LOCK_STATUS_HOLDOVER.
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
@@ -252,6 +282,17 @@ attribute-sets:
         name: lock-status-error
         type: u32
         enum: lock-status-error
+      -
+        name: clock-quality-level
+        type: u32
+        enum: clock-quality-level
+        multi-attr: true
+        doc: |
+          Level of quality of a clock device. This mainly applies when
+          the dpll lock-status is DPLL_LOCK_STATUS_HOLDOVER. This could
+          be put to message multiple times to indicate possible parallel
+          quality levels (e.g. one specified by ITU option 1 and another
+          one specified by option 2).
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
index b0654ade7b7e..2b7ec2da4bcc 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -79,6 +79,29 @@ enum dpll_lock_status_error {
 	DPLL_LOCK_STATUS_ERROR_MAX = (__DPLL_LOCK_STATUS_ERROR_MAX - 1)
 };
 
+/**
+ * enum dpll_clock_quality_level - level of quality of a clock device. This
+ *   mainly applies when the dpll lock-status is DPLL_LOCK_STATUS_HOLDOVER. The
+ *   current list is defined according to the table 11-7 contained in ITU-T
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


