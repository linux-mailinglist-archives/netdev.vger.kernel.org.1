Return-Path: <netdev+bounces-73016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEF085A9E6
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD962894B5
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1B247F5F;
	Mon, 19 Feb 2024 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Zh0msQR2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589547F66
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363562; cv=none; b=LfiCziqm2DazVeyebkcPc39gKuwZGUJUTLKFVelaWQ8cynItTEv+Lc9063b0IkkEqrnLsgjfuJ84QmI0np+A6y2LKR+LqEXmC9S+K3WcmKYhrBIvm7dSp4lZqkyK8VSoC/kIeYZTxnQZkCR076CHvLyq7E+eDiFoRVrIhQ+iXe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363562; c=relaxed/simple;
	bh=qoJaqWXXg5rI4XdWMgT95nwV5PqftHgMeTqk5uYVKrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDfgafeom5r9SbZ9/P/FdXm60Ka8n9MzKvyrEmkA2xV5PkUZNCpFQiT1VeRGazqNmLWS9x6LtJh3QQOD25iiapv/WZjqYwv8ITMJazNYUCJYfJN5DtyAXCsKz1qMbRcuA1q4N5Cw5K2/HSyjrEfHtMaoGJx1/CQAvOh7LScfMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Zh0msQR2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41265d2f7acso9317815e9.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363559; x=1708968359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfmVQ5R2UOAKUN7/YSww2fNeo+L1KnH68E7KMxQ9YUU=;
        b=Zh0msQR2hLlBogcfRTJzT7AceNC01i9OrtRLUchcDk8+w1LvZmx+jwXkwWNB7bdGbc
         YN7qhWrIkEDgiJmBoBSmsFc5so/hjfP6rTgBvzlFcvKLUKnZB7flrPeZlQMoDhiS0IMQ
         u8MGXmCCbBfiEqFfPWWNLMOi0/m2A9lUyC1968EcV6tp8hg7mHifVr66mGGec6rdgF8W
         6SlLKWPunADJ4bhRxRsCEW9FC9wGy7nA2Dh7HlDfB5W0YOlO+aucko0Gj8Im7Av6XLD4
         BgsEDHeiX4PRAvLe2J7DJkR1wWckQOkJvuFSFDSru3PUjnA7FsJPBIUNJdztvQh6qm8a
         4hhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363559; x=1708968359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfmVQ5R2UOAKUN7/YSww2fNeo+L1KnH68E7KMxQ9YUU=;
        b=rs/5MxW/eWMUyCgTHlPs/MLKwdk9G8V9uP4S7bSEYeXiKsVSRhKSLYDZjxDAin35ZU
         blICMWq2sN5YvkBP0vw7UEMOAmyDZaZjO0Xl3h0fEK6WRczzZ9RRXfqTAV0jlt8C2GnY
         AwKanCnvXKxLcA9pmcUBWVSrQRo6gtsnurgoCEfjV8sN54PeUEb+xFryU06nPQ10jNl4
         KnfVWmEsZAawRpVCRbX6Qc6AZW1gjVrA2bg8vmWVJzupADUjyadN1NcltjNOszvCpFzN
         5GIETHke3X03Q37RDgtxb47Wou6KP33+ppVDxJKP32fmhW6x9Ukr1qdhPmynY7RtHw1+
         G8Xw==
X-Gm-Message-State: AOJu0YyXFut6X/lktm+Vd2gZW0oS8ohHdAgzYbUHVY24brgxj2YR8XbH
	+1VsN8qF1NvLeLam4jUYF+YgyhX0S1di4GO9WAh5g0uuvjBUDJJ5Xb/5CJCSwx+hBf/eH0VPCKS
	H
X-Google-Smtp-Source: AGHT+IF8Oeci0xI4yrjharBye7dnDNOMT6j0r4aV0iWNntezCO2Zm86EQ3pZtufJ/oQ+SG/2uJ58eQ==
X-Received: by 2002:a05:600c:91a:b0:40e:f46d:ad35 with SMTP id m26-20020a05600c091a00b0040ef46dad35mr11316981wmp.36.1708363559538;
        Mon, 19 Feb 2024 09:25:59 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b00411c724fa10sm11835191wmb.2.2024.02.19.09.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:25:58 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	lorenzo@kernel.org,
	alessandromarcolini99@gmail.com
Subject: [patch net-next 09/13] netlink: specs: devlink: add missing param attribute definitions
Date: Mon, 19 Feb 2024 18:25:25 +0100
Message-ID: <20240219172525.71406-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219172525.71406-1-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add missing values list attribute and all nested attributes definition,
including param-value-data. For this one, use newly introduced
sub-message replace-attribute infrastructure to allow to process
attribute type selected by param-value-type.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 108 +++++++++++++++++++++--
 1 file changed, 102 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 88abe137c8ef..71a95163c419 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -515,14 +515,24 @@ attribute-sets:
         name: param-type
         type: u8
         enum: param-type
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: param-values-list
+        type: nest
+        nested-attributes: dl-param-values-list
+      -
+        name: param-value
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-param-value
+      -
+        name: param-value-data
+        type: sub-message
+        sub-message: dl-param-value-data-msg
+        selector: param-type
       -
         name: param-value-cmode
         type: u8
         enum: param-cmode
-        value: 87
       -
         name: region-name
         type: string
@@ -1131,8 +1141,24 @@ attribute-sets:
         name: param-generic
       -
         name: param-type
+      -
+        name: param-values-list
+
+  -
+    name: dl-param-values-list
+    subset-of: devlink
+    attributes:
+      -
+        name: param-value
 
-      # TODO: fill in the attribute param-value-list
+  -
+    name: dl-param-value
+    subset-of: devlink
+    attributes:
+      -
+        name: param-value-data
+      -
+        name: param-value-cmode
 
   -
     name: dl-region-snapshots
@@ -1243,6 +1269,71 @@ attribute-sets:
         name: flash
         type: flag
 
+  -
+    name: dl-param-value-data-u8-attrs
+    subset-of: devlink
+    attributes:
+      -
+        name: param-value-data
+        type: u8
+
+  -
+    name: dl-param-value-data-u16-attrs
+    subset-of: devlink
+    attributes:
+      -
+        name: param-value-data
+        type: u16
+
+  -
+    name: dl-param-value-data-u32-attrs
+    subset-of: devlink
+    attributes:
+      -
+        name: param-value-data
+        type: u32
+
+  -
+    name: dl-param-value-data-string-attrs
+    subset-of: devlink
+    attributes:
+      -
+        name: param-value-data
+        type: string
+
+  -
+    name: dl-param-value-data-flag-attrs
+    subset-of: devlink
+    attributes:
+      -
+        name: param-value-data
+        type: flag
+
+sub-messages:
+  -
+    name: dl-param-value-data-msg
+    formats:
+      -
+        value: u8
+        attribute-set: dl-param-value-data-u8-attrs
+        attribute-replace: true
+      -
+        value: u16
+        attribute-set: dl-param-value-data-u16-attrs
+        attribute-replace: true
+      -
+        value: u32
+        attribute-set: dl-param-value-data-u32-attrs
+        attribute-replace: true
+      -
+        value: string
+        attribute-set: dl-param-value-data-string-attrs
+        attribute-replace: true
+      -
+        value: flag
+        attribute-set: dl-param-value-data-flag-attrs
+        attribute-replace: true
+
 operations:
   enum-model: directional
   list:
@@ -1731,7 +1822,12 @@ operations:
             - dev-name
             - param-name
         reply: &param-get-reply
-          attributes: *param-id-attrs
+          attributes:
+            - bus-name
+            - dev-name
+            - param-name
+            - param-type
+            - param-values-list
       dump:
         request:
           attributes: *dev-id-attrs
-- 
2.43.2


