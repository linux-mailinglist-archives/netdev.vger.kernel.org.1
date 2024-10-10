Return-Path: <netdev+bounces-134219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8E199871C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CD5B22F83
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03471C9B6F;
	Thu, 10 Oct 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CKeIq+Fq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE81C7B6E
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565615; cv=none; b=g5bPvVYJrcELb2Yv+qTPTyhYBo3iyR5zaadXdCfE82uCb+aNwZtrD8Ajcb/eW2MTXXzRjB8kQ2afUfzw0chjKfeQlWiTiQdSFn34l3lwz6MLB7Yrw1KuDnlAvvr9okmZkeeCSrdenSLKUjPQQ34B9uoa/NCBrxKwi9YDMErYhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565615; c=relaxed/simple;
	bh=YqbNcsCsSmvmwawcMbUwIztik1Pu1pC4mrky7eF5GNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ0Is2dEcWLCXgBsnQZPBVQIedWOMVMlyQNNhRg12Z3R7I62h9/f3pw+nQPw+zAr9YzPPmMkcSwpgtW6ZPtPGvMkNtH3CsMSPdO50OCf4SVI0sHPFEL6+7sh1yIhcaspQ5wXaObipWGnoMvPEa9hLK/fzw29QWX65oLVdLMnvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CKeIq+Fq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a993f6916daso156490966b.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728565612; x=1729170412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8NyjKoeteFn0ywdj6Fr8bZBU280j0NJJP+sVuAhgRM=;
        b=CKeIq+FqLMWtUxlvmEWA9ZCd1yTZzMgC/CAmJwlYKEOJ/aWlM+Q4VktSZfzinqga5g
         DoR0luyuonQq7LXFtM997pHj+wE5mQA/+Kk+Zsz8FEMjN/YLIn30cQk/h+aewtKRjvb5
         gkwNKuzNKlZ7rRQdOacdqWy3cwjUx0KsUDfr246uD6wFY9VBU2oJC2z0TxIF7stB3Rsf
         pnLSYO528g22zxv8PDwJF6Cl3zOshYZlSYRsz4mDG9jE9E4m8evi+atE4rnlWrOCIFCR
         /ElPXt5UEWy7kkqvP/itd/qTR0qIsZDO164YsYhuKnwi1H+f32xYUaDCKy4x9xLdZTHj
         d0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565612; x=1729170412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8NyjKoeteFn0ywdj6Fr8bZBU280j0NJJP+sVuAhgRM=;
        b=tt9Rl8CJS2kpWbDNaX+ExtFPmTbl3cxWaFuk4hnjK4jPhHELAblVfb0hYgTw/K3Cun
         wFhzZrHASPQZFhnN4OwiMsjjx7IA3Hu7yTRBBpfn2IKLt+tGBuDb/qpwQB/YJqTk5oxR
         FKKimEv5s7llqSIHdyCbbI41IPd4QB1fiNN2J6qDdIqXF/8bWc/qjCtlA12K9PTnGM8T
         qdMmrWo1q0H+REKKaFz9YAFZ8aQWb7OxcZKADTrZhpfKPyukeu/oGFPvzcjTtjY69245
         YuboFDOGcJo/NeoliII0AE4Im3Qod5BbmClzjaHMVIz8tlFaW5Mrh7rToYjKUushi58W
         wSbQ==
X-Gm-Message-State: AOJu0YyeGTZ/DaRhMHjr6C/ejFkTa8T1z91slzuWPP40xpjhQVmneibu
	ib0aqiFSnTrLwB7SbR/q45t5P540p3C936EI28cYShwcjHhoWOPBo/Lh1obLmUyjbR/+aWvWvt5
	nLjMN5g==
X-Google-Smtp-Source: AGHT+IEMDufXyyX0Gjn+Ehby/0HZfOGR2U5UfXwA686yC+DlskdWN4LjU9/r1X5F4xzh2hUGt8h4tg==
X-Received: by 2002:a17:906:d259:b0:a99:42e7:21f with SMTP id a640c23a62f3a-a998d224f32mr566084366b.37.1728565611334;
        Thu, 10 Oct 2024 06:06:51 -0700 (PDT)
Received: from localhost ([37.48.49.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ede845sm88471066b.13.2024.10.10.06.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:06:50 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] dpll: add clock quality level attribute and op
Date: Thu, 10 Oct 2024 15:06:45 +0200
Message-ID: <20241010130646.399365-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241010130646.399365-1-jiri@resnulli.us>
References: <20241010130646.399365-1-jiri@resnulli.us>
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
v1->v2:
- extended quality enum documentation
- added "itu" prefix to the enum values
---
 Documentation/netlink/specs/dpll.yaml | 32 +++++++++++++++++++++++++++
 drivers/dpll/dpll_netlink.c           | 22 ++++++++++++++++++
 include/linux/dpll.h                  |  4 ++++
 include/uapi/linux/dpll.h             | 23 +++++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index f2894ca35de8..d64a3c4490d3 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -85,6 +85,34 @@ definitions:
           This may happen for example if dpll device was previously
           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
     render-max: true
+  -
+    type: enum
+    name: clock-quality-level
+    doc: |
+      level of quality of a clock device. The current list is defined
+      according to the table 11-7 contained in ITU-T G.8264/Y.1364
+      document. One may extend this list freely by other ITU-T defined
+      clock qualities, or different ones defined by another
+      standardization body (for those, please use different prefix).
+    entries:
+      -
+        name: itu-prc
+        value: 1
+      -
+        name: itu-ssu-a
+      -
+        name: itu-ssu-b
+      -
+        name: itu-eec1
+      -
+        name: itu-prtc
+      -
+        name: itu-eprtc
+      -
+        name: itu-eeec
+      -
+        name: itu-eprc
+    render-max: true
   -
     type: const
     name: temp-divider
@@ -252,6 +280,10 @@ attribute-sets:
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
index b0654ade7b7e..6b9db2e69f32 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -79,6 +79,28 @@ enum dpll_lock_status_error {
 	DPLL_LOCK_STATUS_ERROR_MAX = (__DPLL_LOCK_STATUS_ERROR_MAX - 1)
 };
 
+/**
+ * enum dpll_clock_quality_level - level of quality of a clock device. The
+ *   current list is defined according to the table 11-7 contained in ITU-T
+ *   G.8264/Y.1364 document. One may extend this list freely by other ITU-T
+ *   defined clock qualities, or different ones defined by another
+ *   standardization body (for those, please use different prefix).
+ */
+enum dpll_clock_quality_level {
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_PRC = 1,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_SSU_A,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_SSU_B,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_EEC1,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_PRTC,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_EPRTC,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_EEEC,
+	DPLL_CLOCK_QUALITY_LEVEL_ITU_EPRC,
+
+	/* private: */
+	__DPLL_CLOCK_QUALITY_LEVEL_MAX,
+	DPLL_CLOCK_QUALITY_LEVEL_MAX = (__DPLL_CLOCK_QUALITY_LEVEL_MAX - 1)
+};
+
 #define DPLL_TEMP_DIVIDER	1000
 
 /**
@@ -180,6 +202,7 @@ enum dpll_a {
 	DPLL_A_TEMP,
 	DPLL_A_TYPE,
 	DPLL_A_LOCK_STATUS_ERROR,
+	DPLL_A_CLOCK_QUALITY_LEVEL,
 
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
-- 
2.46.1


