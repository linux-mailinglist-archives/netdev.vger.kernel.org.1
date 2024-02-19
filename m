Return-Path: <netdev+bounces-73019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC52F85A9F4
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940212894E6
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF2547F52;
	Mon, 19 Feb 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BUIqyLia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094F47F50
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363601; cv=none; b=TB62lcF6PGsiX2d4T8cF/E8AgU5QgfVWiAQk5oA6nlKQ6tdUf9p6+IvjjjdXOPOsQ67A1v3unqVgIGRsT8LkXgvH4UI0+JyO+QV6iFvd49FcFvOTMCltSdMYUPtPkhq+8zecc8ggo22mp/RfwjFu6w1+VG7ontHazHSbnX7jvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363601; c=relaxed/simple;
	bh=VRKk7yOlO8DXmg9hQG2w/9bbrZuBSTd+E6Guh7zsh2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub02EoDEOkjL7A1udo3ZWoQvTq+JzuspiACPo95kmW+Xq6Q7iEPcxoxAsIRXUp0maBCKY++/PD4GUXNrF65ojF1pOt0qzecB8pbff2B9eLqVmvj6EBffIzYITYF0Hjv82eT9SdX2ieWvt86S/gGWh1VSP6vRPAzhkQe+5+J3jS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BUIqyLia; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c0485fc8b8so3791203b6e.3
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363599; x=1708968399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FqBgwBflH6YWZwugnlqxLB4TkK+bo8pYTgy0Tzpf9g=;
        b=BUIqyLiaK87yYxdUq2tlKrVZWLGIr2nvu6z9B0KAsGsNW8mhsyKLnr9CE5y4JPi+NU
         zjLvrZ6UHJWzT09xi1u03MbTmsz/D1jhfXD/06mDalRYD5wh2KnSOpKWqnt1T1XNc/QI
         yX1Hx8FVDzrLYDmihsm25t9+xehYqddqyCGZwy51GBhZNj7zJztCiBlXrCZPM8fW9D9H
         1omq9LYUKS6FtUSz6IBXr4crYeExcZHO7Ud7iwqxPXGCXy8R90Uim9BZqdsAPNVPEhUY
         FJeszmMpW/sjPn7GzTBm1s7vaR+GSeh14Lib2UFAw5nWWcLdCaYcIUa2FnhmP+aJnFuR
         qEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363599; x=1708968399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FqBgwBflH6YWZwugnlqxLB4TkK+bo8pYTgy0Tzpf9g=;
        b=UvhHFnOSIbZcu56Eu0v1dsxsVl9N05vCMS2np4959XzxbRxVt3gjdyhpwFd4Zfvx0b
         nO9P108NAmtXFhUsLj0sZGMJRknEtE7oPHTSsMs0rb9DfWeu9bjiebaxw0P+O8JWfod9
         Sa3LAlHWwZggBm9x6uvi9wyocXdWObLfzU1fSn979R8V1cyYffkDEV5hz18FQAvDfEPY
         Wpx6MdT7RgHXX3esVjS6n7kDZO4hIFm2KlDRYwQroY9uDU3bT+zl6oDCbMHH8AyrZzu9
         HehoRsuRTjOQVWjCHPDzGTjhx7mUSoGxWl3HyUiL5cl0JosDT77pjFuH0ERcIR5UjgAy
         trEw==
X-Gm-Message-State: AOJu0YxNzZRiKmoM1oFGxpaXVcDUYZtt9PP7w+mUHiVEFPjUuLMSGyVB
	Ht4k6M9RGtzxgrcKqHnh+1UC8ILtyWZ0tt7LgaoDzdaoDUGieXBUIshHFCUXwgifU7+Ml+dyTj5
	s
X-Google-Smtp-Source: AGHT+IF1spc64vDV0ybVKbrZ7Db0Y+UymsQr4fBAfYFFqnXN8UMmSOvnQKNGcWCPaU0SNHlkriyLjQ==
X-Received: by 2002:a05:6871:289c:b0:21e:6066:a35c with SMTP id bq28-20020a056871289c00b0021e6066a35cmr12756415oac.6.1708363599474;
        Mon, 19 Feb 2024 09:26:39 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p7-20020a05622a13c700b0042c750bf876sm2737239qtk.43.2024.02.19.09.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:26:39 -0800 (PST)
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
Subject: [patch net-next 12/13] netlink: specs: devlink: add missing fmsg-obj-value-data attribute definitions
Date: Mon, 19 Feb 2024 18:26:27 +0100
Message-ID: <20240219172628.71455-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219172628.71455-1-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
 <20240219172628.71455-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add missing fmsg-obj-value-data definition. Use newly introduced
sub-message replace-attribute infrastructure to allow to process
attribute type selected by fmsg-obj-value-type.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 89 ++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index fa4440141b05..d2bc0e366d09 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -641,13 +641,14 @@ attribute-sets:
         name: fmsg-obj-value-type
         type: u8
         enum: fmsg-obj-value-type
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: fmsg-obj-value-data
+        type: sub-message
+        sub-message: dl-fmsg-obj-value-data-msg
+        selector: fmsg-obj-value-type
       -
         name: health-reporter
         type: nest
-        value: 114
         nested-attributes: dl-health-reporter
       -
         name: health-reporter-name
@@ -1226,6 +1227,10 @@ attribute-sets:
         name: fmsg-nest-end
       -
         name: fmsg-obj-name
+      -
+        name: fmsg-obj-value-type
+      -
+        name: fmsg-obj-value-data
 
   -
     name: dl-health-reporter
@@ -1331,6 +1336,54 @@ attribute-sets:
         name: param-value-data
         type: flag
 
+  -
+    name: dl-fmsg-obj-value-data-u8-attrs
+    subset-of: devlink
+    attributes:
+      -
+        name: fmsg-obj-value-data
+        type: u8
+
+  -
+    name: dl-fmsg-obj-value-data-u32-attrs
+    subset-of: devlink
+    attributes:
+      -
+        name: fmsg-obj-value-data
+        type: u32
+
+  -
+    name: dl-fmsg-obj-value-data-u64-attrs
+    subset-of: devlink
+    attributes:
+      -
+        name: fmsg-obj-value-data
+        type: u64
+
+  -
+    name: dl-fmsg-obj-value-data-flag-attrs
+    subset-of: devlink
+    attributes:
+      -
+        name: fmsg-obj-value-data
+        type: flag
+
+  -
+    name: dl-fmsg-obj-value-data-string-attrs
+    subset-of: devlink
+    attributes:
+      -
+        name: fmsg-obj-value-data
+        type: string
+
+  -
+    name: dl-fmsg-obj-value-data-binary-attrs
+    subset-of: devlink
+    attributes:
+      -
+        name: fmsg-obj-value-data
+        type: binary
+
 sub-messages:
   -
     name: dl-param-value-data-msg
@@ -1356,6 +1409,34 @@ sub-messages:
         attribute-set: dl-param-value-data-flag-attrs
         attribute-replace: true
 
+  -
+    name: dl-fmsg-obj-value-data-msg
+    formats:
+      -
+        value: u8
+        attribute-set: dl-fmsg-obj-value-data-u8-attrs
+        attribute-replace: true
+      -
+        value: u32
+        attribute-set: dl-fmsg-obj-value-data-u32-attrs
+        attribute-replace: true
+      -
+        value: u64
+        attribute-set: dl-fmsg-obj-value-data-u64-attrs
+        attribute-replace: true
+      -
+        value: flag
+        attribute-set: dl-fmsg-obj-value-data-flag-attrs
+        attribute-replace: true
+      -
+        value: string
+        attribute-set: dl-fmsg-obj-value-data-string-attrs
+        attribute-replace: true
+      -
+        value: binary
+        attribute-set: dl-fmsg-obj-value-data-binary-attrs
+        attribute-replace: true
+
 operations:
   enum-model: directional
   list:
-- 
2.43.2


