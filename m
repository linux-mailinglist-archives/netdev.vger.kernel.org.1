Return-Path: <netdev+bounces-67190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D3842481
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D321C23D08
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AF56A326;
	Tue, 30 Jan 2024 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gw7wOrGE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C39679F1
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616521; cv=none; b=sjZyTIg3QkLPGTGPo7Cdbe3i8t+2/nng4JsjwouBxrPPIAxt9xa6UToveHt9MkL5SJTfXIOVMsoF9IFuVv0A8g1PO9LzsUAQVTh/nxfCjvZ+cvs4sJM5U58MIMiEoT+E98tzANtROlsa9J9EElS/2jMNeaIcW/BIwqvZMmYHo8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616521; c=relaxed/simple;
	bh=cunQVUiQTJ/qT2fXX5skiLlpR0rFVpqpMADSPcBfbNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkBLMaYPKfN17xYjUikBsTceGlWCWR5AeaoKFn0+CPNGePC8CDvkhzFShHAVRGl1gfHr9PeCa3yF19P2xj8Nrt/hknZ0Ox1N1ICe9xU59+k1TqeIDWefD2HkLTWcxwtKXn1TW4O6geUfgXKjZEZzMWVUMyx6e8SCEkZr2HzElgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gw7wOrGE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40ed3101ce3so52283675e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 04:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706616518; x=1707221318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxfFOMPuRccX2RJ2AQIWh0HVQfb+lH5dr1aKaZmo7m4=;
        b=gw7wOrGEbfNmnjxPSON+RDc9YUuUr3bfBKdu3djPNRItH2DKL6xr/U79XeGypL/773
         yd/Fu7NW/fN52Mh4L69UQg/6CbIbdoyU+pkoRaJLgwhYE3djduFapfoQawOvM3WdTHWn
         lUNw4RdxFuxqVzdMfGBDL5lXejs8nTOHLydsM4VnBzwlcmBXfkDRp55IhoNHMf6RKcHv
         LbZYWx93sGHM1RTajTWgqKs0KVffIjzPt0bf2cJ1sK8ZHAiThBMImsSTO/ReRq6iymZZ
         v17Xx5IwMucIc0hGvsne7g1TDFa98CCHS9FDnGhPlS3MGcNB3jWe16wqM7DIy//jxUws
         0VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616518; x=1707221318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxfFOMPuRccX2RJ2AQIWh0HVQfb+lH5dr1aKaZmo7m4=;
        b=wMALyfQuhiEJXrg1YupY080rjKeD1RXBsrAmuEVIrLD+7Lf87whslu+wLVZ1nEYKOX
         XclesxBc+pGPD7sMmhRTsmFmYSxvcKVU4uCkhKXRMCBaQhYLDnmv+YZYGLmMnxr6oqUY
         3UMBbQMMpKvPRFrXewO3zs2gUmsqhOKeSJaO9XyaytK2sLoIrd79v8GBpLbjr6s0kHOm
         ZO8R0KVt8F8sQFhN3qEW5FQIv5hSs5jjJ3ba1GKQ8RDn1DW5EGnvQh/kRgQQdV/elJpQ
         OO1WkY60CVLcCn5kaeMNyYdKmCav5ux0wj71qvsxee8gGbliaZviDHBMrK40/y28b/nT
         C32A==
X-Gm-Message-State: AOJu0YwW7aTyrquTiSUWyxwzhNUfgnKt7H7u5h9C0U4f6uzhJ3gXTAwO
	Jsgx1lMwKzWBDdbbsIjaSK6iO26au7nGC2oEurLhwbHFrJJqlEOEd5lXTxlGBEsOpJTlLlkMC2k
	8HtI=
X-Google-Smtp-Source: AGHT+IG+i6aC18/3DDzkYJc8VbUFswjHEL65LrqwnDdBcKQGQghDv/LfWTuVSOqUu5qXjaNlM0fx0A==
X-Received: by 2002:a05:600c:1d1b:b0:40e:d332:bb8f with SMTP id l27-20020a05600c1d1b00b0040ed332bb8fmr6553595wms.5.1706616518463;
        Tue, 30 Jan 2024 04:08:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVoG7HP6f87zK5fUYTv8MjdIjEvPCPQdWAh2D/18j+b78Il60ssEiwwd1DylwT522U0ZafjL5JV8ez8ZJHHJBPY3JQA4ZAoc/ezflxKBxblpOSmRtVpFHAP2FTQbUaLU2wvENFc6n62sM2qupoYqNNuSdzSvCejLsHq5g/5TBwNxhHe+h5JLBAqyRKX7n/7rYRRycl9Byl7rymZGMoG2YXGCQVHwoOUNkni9RgwvNZisWefoSFtQoGpxRkFjYSr7t7lbZC6PBB/rlQ2uWprv72joYj2SqkmGp4fgHo/mJKZPej6MxmnwB4Hyx+9+owpDMFv6/W6+WKylUjA9BuFVtILBjpLqkQOXULMm35Yda/xGSENVNU0y18cFGJQJcSclpSN9SnjxG6gtsz43nc=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c1d1600b0040ef95e1c78sm4909525wms.3.2024.01.30.04.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:08:38 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	rrameshbabu@nvidia.com
Subject: [patch net-next v2 1/3] dpll: extend uapi by lock status error attribute
Date: Tue, 30 Jan 2024 13:08:29 +0100
Message-ID: <20240130120831.261085-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130120831.261085-1-jiri@resnulli.us>
References: <20240130120831.261085-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

If the dpll devices goes to state "unlocked" or "holdover", it may be
caused by an error. In that case, allow user to see what the error was.
Introduce a new attribute and values it can carry.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 Documentation/netlink/specs/dpll.yaml | 39 +++++++++++++++++++++++++++
 include/uapi/linux/dpll.h             | 30 +++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index b14aed18065f..1755066d8308 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -51,6 +51,40 @@ definitions:
           if dpll lock-state was not DPLL_LOCK_STATUS_LOCKED_HO_ACQ, the
           dpll's lock-state shall remain DPLL_LOCK_STATUS_UNLOCKED)
     render-max: true
+  -
+    type: enum
+    name: lock-status-error
+    doc: |
+      if previous status change was done due to a failure, this provides
+      information of dpll device lock status error.
+      Valid values for DPLL_A_LOCK_STATUS_ERROR attribute
+    entries:
+      -
+        name: none
+        doc: |
+          dpll device lock status was changed without any error
+        value: 1
+      -
+        name: undefined
+        doc: |
+          dpll device lock status was changed due to undefined error.
+          Driver fills this value up in case it is not able
+          to obtain suitable exact error type.
+      -
+        name: media-down
+        doc: |
+          dpll device lock status was changed because of associated
+          media got down.
+          This may happen for example if dpll device was previously
+          locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
+      -
+        name: fractional-frequency-offset-too-high
+        doc: |
+          the FFO (Fractional Frequency Offset) between the RX and TX
+          symbol rate on the media got too high.
+          This may happen for example if dpll device was previously
+          locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
+    render-max: true
   -
     type: const
     name: temp-divider
@@ -214,6 +248,10 @@ attribute-sets:
         name: type
         type: u32
         enum: type
+      -
+        name: lock-status-error
+        type: u32
+        enum: lock-status-error
   -
     name: pin
     enum-name: dpll_a_pin
@@ -379,6 +417,7 @@ operations:
             - mode
             - mode-supported
             - lock-status
+            - lock-status-error
             - temp
             - clock-id
             - type
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index b4e947f9bfbc..0c13d7f1a1bc 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -50,6 +50,35 @@ enum dpll_lock_status {
 	DPLL_LOCK_STATUS_MAX = (__DPLL_LOCK_STATUS_MAX - 1)
 };
 
+/**
+ * enum dpll_lock_status_error - if previous status change was done due to a
+ *   failure, this provides information of dpll device lock status error. Valid
+ *   values for DPLL_A_LOCK_STATUS_ERROR attribute
+ * @DPLL_LOCK_STATUS_ERROR_NONE: dpll device lock status was changed without
+ *   any error
+ * @DPLL_LOCK_STATUS_ERROR_UNDEFINED: dpll device lock status was changed due
+ *   to undefined error. Driver fills this value up in case it is not able to
+ *   obtain suitable exact error type.
+ * @DPLL_LOCK_STATUS_ERROR_MEDIA_DOWN: dpll device lock status was changed
+ *   because of associated media got down. This may happen for example if dpll
+ *   device was previously locked on an input pin of type
+ *   PIN_TYPE_SYNCE_ETH_PORT.
+ * @DPLL_LOCK_STATUS_ERROR_FRACTIONAL_FREQUENCY_OFFSET_TOO_HIGH: the FFO
+ *   (Fractional Frequency Offset) between the RX and TX symbol rate on the
+ *   media got too high. This may happen for example if dpll device was
+ *   previously locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
+ */
+enum dpll_lock_status_error {
+	DPLL_LOCK_STATUS_ERROR_NONE = 1,
+	DPLL_LOCK_STATUS_ERROR_UNDEFINED,
+	DPLL_LOCK_STATUS_ERROR_MEDIA_DOWN,
+	DPLL_LOCK_STATUS_ERROR_FRACTIONAL_FREQUENCY_OFFSET_TOO_HIGH,
+
+	/* private: */
+	__DPLL_LOCK_STATUS_ERROR_MAX,
+	DPLL_LOCK_STATUS_ERROR_MAX = (__DPLL_LOCK_STATUS_ERROR_MAX - 1)
+};
+
 #define DPLL_TEMP_DIVIDER	1000
 
 /**
@@ -150,6 +179,7 @@ enum dpll_a {
 	DPLL_A_LOCK_STATUS,
 	DPLL_A_TEMP,
 	DPLL_A_TYPE,
+	DPLL_A_LOCK_STATUS_ERROR,
 
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
-- 
2.43.0


