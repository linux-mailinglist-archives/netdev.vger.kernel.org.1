Return-Path: <netdev+bounces-55993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAEA80D262
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CED1F2167B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E64E606;
	Mon, 11 Dec 2023 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJvSvaRb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF4E99;
	Mon, 11 Dec 2023 08:41:12 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c25973988so49452815e9.2;
        Mon, 11 Dec 2023 08:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312870; x=1702917670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZRt55MNwlpC06RV2/yj8PFQakwrgHeG+KOF8yDxxdM=;
        b=ZJvSvaRbshRGD1RMt8I1CAkRBC0UuQUG7LOuTCw6E/4qAPbIHUfzlObwfswSdDZLFf
         QNbDVTb6Vsr8v8+c/f6MFdDru3B5HNe9MwA3yDFM1Y8xUhhAkquSlPp+jqhishj1VAUL
         OxzYntHdEva1FlKLppv922JBBbu4tJhkW66/hYfn2St1sIyCcRPk6tILovIiZOuhcNYp
         4oy/8RnUzCFujSKGLnHVGhTLLbhHeOqISCid8/LYZcFNCCvufx5+1FB54yz4m6+Bfx7V
         mI11ITC/rYEzlHwVjMVTZLKh7+OFPFX38HYeM7pnLNOIJLFZvZurOJ28S19MVROuAuQW
         xfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312870; x=1702917670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZRt55MNwlpC06RV2/yj8PFQakwrgHeG+KOF8yDxxdM=;
        b=pl4uRTbJGSH1vpx4zctcX2wJIANtAqhKUXTpN6DqP9XuJFTDFX97WvKxmDbOOSw4LO
         fgk88Qoag24Zw1OO72W+OY5tYnywnbzmmV5UoYcRsl2hy1/uMq6w3VFcaWsOO9nqTS87
         1c9bUs1hTlA1JGE+b/LEOOwdqOJ9H+VNDioicnhhAQSArbT09ZPUKntaChcavMTVch3F
         WJe6ep36u18hP0KPHApfloCPpCK5mbnk2s/XTiBIl3aJekMtFBGEqhKInDWO7EisC0Tw
         TnCW2+nv3s3JXHLNAswZbRhB4rGa6XloNCU1aJUiSZ41aUBwAx8iVjJ2o/MNkwWsTkOQ
         YYcQ==
X-Gm-Message-State: AOJu0Yzo6gS07QJeGME9db1krQZZ+4HQPpOCWCBbbBrSss/AGUjfKaBF
	r39S3MFBWaqxPzXPj1qEyCGdVH3T/Q91PQ==
X-Google-Smtp-Source: AGHT+IFgQQWG63Ma02Ck1oJa0Qi3kr3mC0k2ZNH23yRReO+QjM6QizHD56afhXAkCNHdAZqVYKLdmg==
X-Received: by 2002:a05:600c:1c1a:b0:40b:5e1c:af27 with SMTP id j26-20020a05600c1c1a00b0040b5e1caf27mr2468295wms.45.1702312870460;
        Mon, 11 Dec 2023 08:41:10 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm7418679wmq.26.2023.12.11.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:41:09 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 11/11] tools/net/ynl-gen-rst: Add sub-messages to generated docs
Date: Mon, 11 Dec 2023 16:40:39 +0000
Message-ID: <20231211164039.83034-12-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211164039.83034-1-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a section for sub-messages to the generated .rst files.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index f0bb2f4dc4fa..c030233fdcbb 100755
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


