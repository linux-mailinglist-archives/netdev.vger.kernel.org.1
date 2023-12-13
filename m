Return-Path: <netdev+bounces-57096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCFE8121E2
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C3B282852
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD381E34;
	Wed, 13 Dec 2023 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvovFUr8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04052100;
	Wed, 13 Dec 2023 14:42:21 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-336447f240cso280482f8f.3;
        Wed, 13 Dec 2023 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507334; x=1703112134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHxjA/PI+QAMG6yG9cC6vwGS4SQuFy0Xe9c6W4xTqrU=;
        b=FvovFUr8+5Aw/FRG+Xl69tY1wVwyKCG71oIyTyzNi4jisGlkJSdt65HPOwMbQdB5Pu
         KT0Y9/c1h/neQTmdtyG3mhI2tAseJzcxx7+W3a71WxcLAY98zPcgb2Cc312WbFDs8uZo
         FRByVFB1o3D3867HXmTTlUy5yUY8Oot8K6YVGogtEYqqiMOcdhQMwSiNbKSKn6xmoQSe
         wwn90XeAeLIX+7IST/GnqOzyMfipAND479C4yjAYHp7SnSqVd9Fp6UeRRjXTqaPrHtOi
         nbxIm1nVKad3Fs3KFQgpYfu2glfikBxlB2QUrWPrxXiSJvvvWdvb3uwRsNIYBwThl0Uu
         4DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507334; x=1703112134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHxjA/PI+QAMG6yG9cC6vwGS4SQuFy0Xe9c6W4xTqrU=;
        b=lxoXEh83rnxvtbhOYV+P6kyxbUnQNF1JTHF9DeTU7aBvs1rtQdzB6s49/Ll65mMVzj
         5WiaHgENK9Rt9vupa1QsJqpmuhNu0+ol/2UZTJlJwYyNeJO8sqvU8pPbZAsE5jlVahh0
         hCVIzH/IWHGESLFs5UpyhK+x2ITn7/hGRIYikxjzL5oKqaP2xnYeo0ir41/Ya/iO+07S
         OQTAGgsLltufPN9Yz1mhH7x4SpKI6pcrOQ9v2VLZfL7trTu2TDFySmQBkEggYAWT+DhQ
         N2H9F2x4kuWLY+Y4J01mGnWDQAHqflsOLA3gmbfOJqTLRXGwuhZzyN6AyXZHx0pbYqgD
         v5+w==
X-Gm-Message-State: AOJu0Ywq4FVjrwZ8aXB08gUM+R1Z3glBKB+QASk799LLTKsl0dKqh681
	7KE6QjafhjicMvDgMVyzFA3pqnbGXkKyqw==
X-Google-Smtp-Source: AGHT+IEg0WtTu4qjzMSrMijZ6fI204HwGzosDV0CpG8WD+3/4kZpxrJ+LzBdVQOSrYPBzdxdTlAFiA==
X-Received: by 2002:a5d:58c9:0:b0:336:363e:fa7f with SMTP id o9-20020a5d58c9000000b00336363efa7fmr1496907wrf.140.1702507334118;
        Wed, 13 Dec 2023 14:42:14 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:13 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v4 10/13] tools/net/ynl-gen-rst: Add sub-messages to generated docs
Date: Wed, 13 Dec 2023 22:41:43 +0000
Message-ID: <20231213224146.94560-11-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213224146.94560-1-donald.hunter@gmail.com>
References: <20231213224146.94560-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a section for sub-messages to the generated .rst files.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 tools/net/ynl/ynl-gen-rst.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index b6292109e236..19e5b34554a1 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -251,6 +251,24 @@ def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
     return "\n".join(lines)
 
 
+def parse_sub_messages(entries: List[Dict[str, Any]]) -> str:
+    """Parse sub-message definitions"""
+    lines = []
+
+    for entry in entries:
+        lines.append(rst_section(entry["name"]))
+        for fmt in entry["formats"]:
+            value = fmt["value"]
+
+            lines.append(rst_bullet(bold(value)))
+            for attr in ['fixed-header', 'attribute-set']:
+                if attr in fmt:
+                    lines.append(rst_fields(attr, fmt[attr], 2))
+            lines.append("\n")
+
+    return "\n".join(lines)
+
+
 def parse_yaml(obj: Dict[str, Any]) -> str:
     """Format the whole YAML into a RST string"""
     lines = []
@@ -287,6 +305,11 @@ def parse_yaml(obj: Dict[str, Any]) -> str:
         lines.append(rst_subtitle("Attribute sets"))
         lines.append(parse_attr_sets(obj["attribute-sets"]))
 
+    # Sub-messages
+    if "sub-messages" in obj:
+        lines.append(rst_subtitle("Sub-messages"))
+        lines.append(parse_sub_messages(obj["sub-messages"]))
+
     return "\n".join(lines)
 
 
-- 
2.42.0


