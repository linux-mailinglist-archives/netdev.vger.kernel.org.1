Return-Path: <netdev+bounces-83340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A6891FA8
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856FA28A1C0
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F35314600D;
	Fri, 29 Mar 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qlv6xyMk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AB1C0DF1
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720233; cv=none; b=a054nCSEwjrNuE4ikbRnj2J9zirTFBf62cgTzQrH/YBRx3mMrRqKHssr9/WD4oZ/5Lfl7YPxraXL4I4XtGCRCJBNxm7AFXEZUw7fCPOD82SyWa1QhFGQ91ZvaxU+PeEktP4wf8CUGnKXnvYPV2MMTzqH2JGKTL6PAlI8YvdOI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720233; c=relaxed/simple;
	bh=s+0RIk8awyxwFk+qhi/qIw1OJwGO5Q6PrjhYmwmfsIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noT4lyIePHTKkepMGMP4oMC9zO3Lcg+1wSNxsips6kHX1lbMIs5s+NLjrNlPcA7tp5Kfw2MQZP0FVes4x34AZbAMXH83W3PgzWh94wbr+OFMNT5N0TcrH4g02zAs7SQbvJIPcP5SBZK/sfgOr23xsLeYH/5Pli/2es/G5oLzEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qlv6xyMk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4154464f150so9659795e9.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711720229; x=1712325029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UxhgUnaWx0Bx7zKrT6M6C3uLGshHFUXni3kBGNYqrU=;
        b=Qlv6xyMkt8YEsfHzhdKosA4okV/ht7Rim88G7vPSkM8gGNeztHGVVXAnK4TEMLMzfI
         vvOPxQ8klo40ifgoHVvwVjWi2VnQhgpyOdH/+o9yNSLwKdpu6xDGHyldrJ8feep8VzpM
         59XUYhWT2tjlMaTH3sqQrjisAMg776TVacNRcDs2gstYsA6k8IisMluHm8aGNgurnRty
         HUDSBnnuB28cqz+RjF6358yx19uHrQlrAf+7b6VEzwGPiPPXapNkmhs6msO8RqvLpSem
         Nk820gtqEKt76TLjXjgmq8LEljq6zwfajbMR++Ps7+FAGPpQ8f1/U3R2MPmJoVc8a/3f
         wL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711720229; x=1712325029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UxhgUnaWx0Bx7zKrT6M6C3uLGshHFUXni3kBGNYqrU=;
        b=bDXKvxoF+cfcfALx7WVcF59f2mFPDx/oRQocrfp0ReB8UdEvSwnZK38ClRhkSuOntD
         nXqhUElmy9M362yx3CXE4wO2YNoH5dQkmhvoq4j3p043bWaI4X/P0J3RtC28u6yVdZqp
         y7G33LMLmnMc64WRolDfU7gzVY4uRsbG0KLtaQ6TIrPzRP9vvbxQnzwo/IbxD0SZzwdY
         RLPoP/A2U1q9Rtuluy8Dpv5XSvOFfumaIcZHcglZwKUJYipE1qqsGkTwosyLhRwZHBmG
         DJBmWv669CdQIruv9199HjlzBx3qxGFiFnP+xJitG5UlwUGIPhucb2jw7i7DeqtRrlzS
         sLKA==
X-Gm-Message-State: AOJu0Ywlpnk+spVMVQbfQ7QRMc0oAK3Jp+17uHgOKG+Kuo7B6f4bcUnz
	jg01WHjGAH/RlBnZAXR7MIlElcX0yS+bXPosWlYsj5vexxc9jwEXZx+tv3NUVgg=
X-Google-Smtp-Source: AGHT+IE0VfEtOlvoRwZzUzGYtOQ5m+vUwECq0a/1L/C2Orx8MKejzWFw9IH7PvQ/tCsiYkCqfwqugg==
X-Received: by 2002:a05:600c:4509:b0:414:89c7:c0af with SMTP id t9-20020a05600c450900b0041489c7c0afmr4868406wmo.13.1711720228642;
        Fri, 29 Mar 2024 06:50:28 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:3c9d:7a51:4242:88e2])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0041487f70d9fsm8590633wmo.21.2024.03.29.06.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:50:27 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Breno Leitao <leitao@debian.org>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 2/3] doc: netlink: Add hyperlinks to generated Netlink docs
Date: Fri, 29 Mar 2024 13:50:20 +0000
Message-ID: <20240329135021.52534-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329135021.52534-1-donald.hunter@gmail.com>
References: <20240329135021.52534-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update ynl-gen-rst to generate hyperlinks to definitions, attribute
sets and sub-messages from all the places that reference them.

Note that there is a single label namespace for all of the kernel docs.
Hyperlinks within a single netlink doc need to be qualified by the
family name to avoid collisions.

The label format is 'family-type-name' which gives, for example,
'rt-link-attribute-set-link-attrs' as the link id.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 60 +++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 5825a8b3bfb4..657e881d2ea4 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -82,9 +82,9 @@ def rst_subsubsection(title: str) -> str:
     return f"{title}\n" + "~" * len(title)
 
 
-def rst_section(title: str) -> str:
+def rst_section(namespace: str, prefix: str, title: str) -> str:
     """Add a section to the document"""
-    return f"\n{title}\n" + "=" * len(title)
+    return f".. _{namespace}-{prefix}-{title}:\n\n{title}\n" + "=" * len(title)
 
 
 def rst_subtitle(title: str) -> str:
@@ -102,6 +102,17 @@ def rst_list_inline(list_: List[str], level: int = 0) -> str:
     return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "]"
 
 
+def rst_ref(namespace: str, prefix: str, name: str) -> str:
+    """Add a hyperlink to the document"""
+    mappings = {'enum': 'definition',
+                'fixed-header': 'definition',
+                'nested-attributes': 'attribute-set',
+                'struct': 'definition'}
+    if prefix in mappings:
+        prefix = mappings[prefix]
+    return f":ref:`{namespace}-{prefix}-{name}`"
+
+
 def rst_header() -> str:
     """The headers for all the auto generated RST files"""
     lines = []
@@ -159,20 +170,24 @@ def parse_do_attributes(attrs: Dict[str, Any], level: int = 0) -> str:
     return "\n".join(lines)
 
 
-def parse_operations(operations: List[Dict[str, Any]]) -> str:
+def parse_operations(operations: List[Dict[str, Any]], namespace: str) -> str:
     """Parse operations block"""
     preprocessed = ["name", "doc", "title", "do", "dump"]
+    linkable = ["fixed-header", "attribute-set"]
     lines = []
 
     for operation in operations:
-        lines.append(rst_section(operation["name"]))
+        lines.append(rst_section(namespace, 'operation', operation["name"]))
         lines.append(rst_paragraph(sanitize(operation["doc"])) + "\n")
 
         for key in operation.keys():
             if key in preprocessed:
                 # Skip the special fields
                 continue
-            lines.append(rst_fields(key, operation[key], 0))
+            value = operation[key]
+            if key in linkable:
+                value = rst_ref(namespace, key, value)
+            lines.append(rst_fields(key, value, 0))
 
         if "do" in operation:
             lines.append(rst_paragraph(":do:", 0))
@@ -212,14 +227,14 @@ def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
     return "\n".join(lines)
 
 
-def parse_definitions(defs: Dict[str, Any]) -> str:
+def parse_definitions(defs: Dict[str, Any], namespace: str) -> str:
     """Parse definitions section"""
     preprocessed = ["name", "entries", "members"]
     ignored = ["render-max"]  # This is not printed
     lines = []
 
     for definition in defs:
-        lines.append(rst_section(definition["name"]))
+        lines.append(rst_section(namespace, 'definition', definition["name"]))
         for k in definition.keys():
             if k in preprocessed + ignored:
                 continue
@@ -237,14 +252,15 @@ def parse_definitions(defs: Dict[str, Any]) -> str:
     return "\n".join(lines)
 
 
-def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
+def parse_attr_sets(entries: List[Dict[str, Any]], namespace: str) -> str:
     """Parse attribute from attribute-set"""
     preprocessed = ["name", "type"]
+    linkable = ["enum", "nested-attributes", "struct", "sub-message"]
     ignored = ["checks"]
     lines = []
 
     for entry in entries:
-        lines.append(rst_section(entry["name"]))
+        lines.append(rst_section(namespace, 'attribute-set', entry["name"]))
         for attr in entry["attributes"]:
             type_ = attr.get("type")
             attr_line = attr["name"]
@@ -257,25 +273,31 @@ def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
             for k in attr.keys():
                 if k in preprocessed + ignored:
                     continue
-                lines.append(rst_fields(k, sanitize(attr[k]), 0))
+                if k in linkable:
+                    value = rst_ref(namespace, k, attr[k])
+                else:
+                    value = sanitize(attr[k])
+                lines.append(rst_fields(k, value, 0))
             lines.append("\n")
 
     return "\n".join(lines)
 
 
-def parse_sub_messages(entries: List[Dict[str, Any]]) -> str:
+def parse_sub_messages(entries: List[Dict[str, Any]], namespace: str) -> str:
     """Parse sub-message definitions"""
     lines = []
 
     for entry in entries:
-        lines.append(rst_section(entry["name"]))
+        lines.append(rst_section(namespace, 'sub-message', entry["name"]))
         for fmt in entry["formats"]:
             value = fmt["value"]
 
             lines.append(rst_bullet(bold(value)))
             for attr in ['fixed-header', 'attribute-set']:
                 if attr in fmt:
-                    lines.append(rst_fields(attr, fmt[attr], 1))
+                    lines.append(rst_fields(attr,
+                                            rst_ref(namespace, attr, fmt[attr]),
+                                            1))
             lines.append("\n")
 
     return "\n".join(lines)
@@ -289,7 +311,9 @@ def parse_yaml(obj: Dict[str, Any]) -> str:
 
     lines.append(rst_header())
 
-    title = f"Family ``{obj['name']}`` netlink specification"
+    family = obj['name']
+
+    title = f"Family ``{family}`` netlink specification"
     lines.append(rst_title(title))
     lines.append(rst_paragraph(".. contents:: :depth: 3\n"))
 
@@ -300,7 +324,7 @@ def parse_yaml(obj: Dict[str, Any]) -> str:
     # Operations
     if "operations" in obj:
         lines.append(rst_subtitle("Operations"))
-        lines.append(parse_operations(obj["operations"]["list"]))
+        lines.append(parse_operations(obj["operations"]["list"], family))
 
     # Multicast groups
     if "mcast-groups" in obj:
@@ -310,17 +334,17 @@ def parse_yaml(obj: Dict[str, Any]) -> str:
     # Definitions
     if "definitions" in obj:
         lines.append(rst_subtitle("Definitions"))
-        lines.append(parse_definitions(obj["definitions"]))
+        lines.append(parse_definitions(obj["definitions"], family))
 
     # Attributes set
     if "attribute-sets" in obj:
         lines.append(rst_subtitle("Attribute sets"))
-        lines.append(parse_attr_sets(obj["attribute-sets"]))
+        lines.append(parse_attr_sets(obj["attribute-sets"], family))
 
     # Sub-messages
     if "sub-messages" in obj:
         lines.append(rst_subtitle("Sub-messages"))
-        lines.append(parse_sub_messages(obj["sub-messages"]))
+        lines.append(parse_sub_messages(obj["sub-messages"], family))
 
     return "\n".join(lines)
 
-- 
2.44.0


