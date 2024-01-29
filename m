Return-Path: <netdev+bounces-66763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276D0840931
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922871F27FD5
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCF2153BC7;
	Mon, 29 Jan 2024 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i5+a2Dkl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496CA153BDA
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540367; cv=none; b=sjLpei07p8bGg0qq+ZUpeH8gfOim849GnkLGvJFBqiQiAYb6boOA2zZVPNysLsZWqdK3NXDBTieqwfpgG1TKH44OhQ4WajMGxfRFWdq4pvJotaXLWK9ETDg7MdZoT+M7+hiGixiCR66oN6M8+EeUFW/SF52DYUBw5Ae/qeGOUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540367; c=relaxed/simple;
	bh=hta23/G+8utfOrsbQEJr9zCWrMy/+Z5fD6oPYEfxupA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4QfXsbVNcVHa4K53GxfCTMdymhAFvp15OdE1wIhTEFGXHzNlHzSEvdx2aVx4M3G0LDICO8SbhbosBc3JL2Exun/kL/B+CkyvjipxkrHPSOvlw7PmMakasvKozGQBy5EBkgUIypdmG/84NpjrOWN4/rXROyc7zPksialHN6iGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=i5+a2Dkl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a35e9161b8cso83268366b.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 06:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706540363; x=1707145163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUEcATRoqgdSTmWPi/AnlbzHt1e8IP5T+d1tEQq1sqM=;
        b=i5+a2DklpwYRsOKlJY0hd2D8T6Qeq0psayh76PnkZhcWX6ljtcyg5FNUmaYQlw5aTF
         zUG4mNBP+T9CA2gmfkPF1IN9ji7Q4rIrnakHBN7c64MGEI2QPO12NRqD+tpvr6FkNNCb
         pHGtxBu4nNAG8oFzA8pkaG6lhuzC0JRC52wOD1RVDo8BBC36p4jAIHJ9WXjPf27rLMtB
         3vwSJp+mTVEBB23lJHl+amEPw7Tf8ULDlpnuuVVr5xY5/gSFHu8efvtaPKblMGCb+mWr
         knV+yK/6c0TmWiE0blQ/APeJTWQc2w3p44e6dJiaR6mcXleJY1QausRP+onfA6Ll00de
         wlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540363; x=1707145163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUEcATRoqgdSTmWPi/AnlbzHt1e8IP5T+d1tEQq1sqM=;
        b=q1KqUMes3EhoaFgwtdVZ+qTDAItLUk100YHrPDFNjOR2UYKS1U9OdCq6sWzt3SM/qJ
         pkZUN7S7IH1N++0chs8lJpaMmpctJKtbA/ufaWjI9req3K065GIJZunroRQ7tsymlHUc
         ZVYP2kcqYgF+7BBDycbRoEfyE6gJTVOBsb2q4sLDjIy/jCEXz37WCi2F9lPK4lxDsLDX
         1FjkziNLAxKVxg4eDPrxu//V9UADtqpsbiXrzMKydFbfjtSueDyelEUuwKNM+LnVt9kC
         9NLS5VlNDJHG/6BvThVRQwo9P/0Rn24fyKP9o6IHPv7OIe14PzockGTcfgPno9dIFTS5
         SDEA==
X-Gm-Message-State: AOJu0YwMCDK3BbQnCdGoSVaUSZonOLEo18e9bycR3KDu5Nxy+bwTiWCt
	rAiVADFDYw0x34+iAAgAB6xlI9ilM4mhrmzpSNxvd6oRotr+xvdLBNc5MSokNt2jOZ5hXy2k8j6
	G8WRJcQ==
X-Google-Smtp-Source: AGHT+IF6ikerbnIjhr/FPyswvBebDDLSRYTDkD5PrvJ8QkEFdMTtQ/c3f9ywXHrCsymI6MvCACFTWQ==
X-Received: by 2002:a17:906:e53:b0:a31:7ce5:d44b with SMTP id q19-20020a1709060e5300b00a317ce5d44bmr4186891eji.71.1706540363242;
        Mon, 29 Jan 2024 06:59:23 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id wb5-20020a170907d50500b00a30d9c59771sm3995372ejc.32.2024.01.29.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:59:22 -0800 (PST)
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
Subject: [patch net-next 1/3] dpll: extend uapi by lock status error attribute
Date: Mon, 29 Jan 2024 15:59:14 +0100
Message-ID: <20240129145916.244193-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129145916.244193-1-jiri@resnulli.us>
References: <20240129145916.244193-1-jiri@resnulli.us>
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


