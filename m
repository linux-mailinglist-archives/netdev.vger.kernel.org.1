Return-Path: <netdev+bounces-82241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B709888CE01
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAEC1C669BB
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CCF13D2B2;
	Tue, 26 Mar 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWfecsW/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2913D250
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484014; cv=none; b=Z/FFSaG4GFebQ4B9YYocAmPRJItQXV/LZGhA/jp0WotCqYogr/qDEnq/MDmnYGwGJRS92YFU/LdTdM8R7hu2rolf48OEVLtNOA5JcNGwrEJgkI1e9RXGbUWM+09j1rohLUjTIG4GjSSqrGxGa3ZL4hdbuZAiAXEsuDadZgTzLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484014; c=relaxed/simple;
	bh=qR12GP6NVYx5Nk3w0DOoXTIdPO0woXUktGBR7vLZqMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDHSxohmJopSQZVkoI1uyOtnJebSugf/WD+uDdc+HgjPpc9Ur0VSqqfW27eaOu+S+8PmNg/DFOTavh3n9sLuZUafRZ0g6qEPa721u9ZyGm2EgQMSkhcSNKWXhI7Kp9JS+p/n1oGwKA63Aj1CLDKrwN+pdEpbprNsni7N2UbvjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWfecsW/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so5080663b3a.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 13:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711484012; x=1712088812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtShPJNf1utID5mIQiA3pMZtdYG5K059jXRUJJSX33Q=;
        b=NWfecsW/Issyikt1VXsIbwZ29B4Z22D1iAbPpKmgya7jwDruXpUHskv9Qne5wfgmqo
         KVUDrV82c8tCSNsY0ztEloZ8u0w6rgTUfpkP8ZVPv/RwjiIkIqQZZEqi6g0Ed3wfcSby
         s5xGfrS+wzY/DLi+kR3ICMDFzeX4hYzUU6CCUx1mnuko53pe+cuXgvRK1S+qWMI/Upa2
         Yx2VEYkRSETPOq+9HjU7bxhL7ReO8KN7ovsBzM+f9avAR+wG6pOaIyPDfKU335APWGJ3
         kojCjKaQH08u7Tnix0p4866eHiaD5cB4gWTuubTgt7MLPza5jkt1ulq0YrelZosIg+PB
         ApSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484012; x=1712088812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtShPJNf1utID5mIQiA3pMZtdYG5K059jXRUJJSX33Q=;
        b=Osq1QixP9/ZaXliB3eSDjU+7m2RlTeUljyaUzF5BCZcv6EFK70BJJiVcRstTJIjlKU
         xCV7T2cSls6TrvbyOUZ+To13s/XS3cafErkYlgiRIi+pzp3mjT+R5zGuiXaA21af8tVV
         ydEG6Hhf9VTFo/WJjYl9z3tLJAsjgg/lj4Djal11UzQHXRhCLSjUMAcqwVjqIrOMpyQC
         f+md8yjs9jzo4O9ltYxSgAkVL3oVfyLIsWXmWN1Rjy2mHDKFz+5P+xULA47JnC9tnMok
         PUNkLyYdnpSaEVNSSdrhOq/7BhbDKBNUdxk6AoObn6ITpP+pm5GB/FrU+OUNAIpkqJkV
         sKYg==
X-Gm-Message-State: AOJu0YzpubpLeF4S+wLw/rqNRhjRMHkbLVIdWXPGz5E92PQFWngDS1Wu
	ZssO8otVdDvybV8w+qso3rO3x3seIricCkvXWbAhpPLgdHJzEuTl4Z8S98yjfFQ=
X-Google-Smtp-Source: AGHT+IHJwSFrdkDSBQwkbCk22PqJXW2ABMxNaxsQT8e76z1ZgoaRKRcvNWjGXCQlh63+9BuQ8KGRlQ==
X-Received: by 2002:a05:6a00:80e:b0:6ea:b1f5:112b with SMTP id m14-20020a056a00080e00b006eab1f5112bmr941116pfk.21.1711484011900;
        Tue, 26 Mar 2024 13:13:31 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:e486:aac9:8397:25ce])
        by smtp.gmail.com with ESMTPSA id r18-20020aa78b92000000b006e647716b6esm6648939pfd.149.2024.03.26.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:13:31 -0700 (PDT)
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
Subject: [PATCH net-next v1 2/3] doc: netlink: Add hyperlinks to generated Netlink docs
Date: Tue, 26 Mar 2024 20:13:10 +0000
Message-ID: <20240326201311.13089-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326201311.13089-1-donald.hunter@gmail.com>
References: <20240326201311.13089-1-donald.hunter@gmail.com>
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
 tools/net/ynl/ynl-gen-rst.py | 44 +++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 5825a8b3bfb4..4be931c9bdbf 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -82,9 +82,9 @@ def rst_subsubsection(title: str) -> str:
     return f"{title}\n" + "~" * len(title)
 
 
-def rst_section(title: str) -> str:
+def rst_section(prefix: str, title: str) -> str:
     """Add a section to the document"""
-    return f"\n{title}\n" + "=" * len(title)
+    return f".. _{family}-{prefix}-{title}:\n\n{title}\n" + "=" * len(title)
 
 
 def rst_subtitle(title: str) -> str:
@@ -101,6 +101,16 @@ def rst_list_inline(list_: List[str], level: int = 0) -> str:
     """Format a list using inlines"""
     return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "]"
 
+def rst_ref(prefix: str, name: str) -> str:
+    """Add a hyperlink to the document"""
+    mappings = {'enum': 'definition',
+                'fixed-header': 'definition',
+                'nested-attributes': 'attribute-set',
+                'struct': 'definition'}
+    if prefix in mappings:
+        prefix = mappings[prefix]
+    return f":ref:`{family}-{prefix}-{name}`"
+
 
 def rst_header() -> str:
     """The headers for all the auto generated RST files"""
@@ -162,17 +172,21 @@ def parse_do_attributes(attrs: Dict[str, Any], level: int = 0) -> str:
 def parse_operations(operations: List[Dict[str, Any]]) -> str:
     """Parse operations block"""
     preprocessed = ["name", "doc", "title", "do", "dump"]
+    linkable = ["fixed-header", "attribute-set"]
     lines = []
 
     for operation in operations:
-        lines.append(rst_section(operation["name"]))
+        lines.append(rst_section('operation', operation["name"]))
         lines.append(rst_paragraph(sanitize(operation["doc"])) + "\n")
 
         for key in operation.keys():
             if key in preprocessed:
                 # Skip the special fields
                 continue
-            lines.append(rst_fields(key, operation[key], 0))
+            value = operation[key]
+            if key in linkable:
+                value = rst_ref(key, value)
+            lines.append(rst_fields(key, value, 0))
 
         if "do" in operation:
             lines.append(rst_paragraph(":do:", 0))
@@ -219,7 +233,7 @@ def parse_definitions(defs: Dict[str, Any]) -> str:
     lines = []
 
     for definition in defs:
-        lines.append(rst_section(definition["name"]))
+        lines.append(rst_section('definition', definition["name"]))
         for k in definition.keys():
             if k in preprocessed + ignored:
                 continue
@@ -240,11 +254,12 @@ def parse_definitions(defs: Dict[str, Any]) -> str:
 def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
     """Parse attribute from attribute-set"""
     preprocessed = ["name", "type"]
+    linkable = ["enum", "nested-attributes", "struct", "sub-message"]
     ignored = ["checks"]
     lines = []
 
     for entry in entries:
-        lines.append(rst_section(entry["name"]))
+        lines.append(rst_section('attribute-set', entry["name"]))
         for attr in entry["attributes"]:
             type_ = attr.get("type")
             attr_line = attr["name"]
@@ -257,7 +272,11 @@ def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
             for k in attr.keys():
                 if k in preprocessed + ignored:
                     continue
-                lines.append(rst_fields(k, sanitize(attr[k]), 0))
+                if k in linkable:
+                    value = rst_ref(k, attr[k])
+                else:
+                    value = sanitize(attr[k])
+                lines.append(rst_fields(k, value, 0))
             lines.append("\n")
 
     return "\n".join(lines)
@@ -268,14 +287,14 @@ def parse_sub_messages(entries: List[Dict[str, Any]]) -> str:
     lines = []
 
     for entry in entries:
-        lines.append(rst_section(entry["name"]))
+        lines.append(rst_section('sub-message', entry["name"]))
         for fmt in entry["formats"]:
             value = fmt["value"]
 
             lines.append(rst_bullet(bold(value)))
             for attr in ['fixed-header', 'attribute-set']:
                 if attr in fmt:
-                    lines.append(rst_fields(attr, fmt[attr], 1))
+                    lines.append(rst_fields(attr, rst_ref(attr, fmt[attr]), 1))
             lines.append("\n")
 
     return "\n".join(lines)
@@ -289,7 +308,11 @@ def parse_yaml(obj: Dict[str, Any]) -> str:
 
     lines.append(rst_header())
 
-    title = f"Family ``{obj['name']}`` netlink specification"
+    # Save the family for use in ref labels
+    global family
+    family = obj['name']
+
+    title = f"Family ``{family}`` netlink specification"
     lines.append(rst_title(title))
     lines.append(rst_paragraph(".. contents:: :depth: 3\n"))
 
@@ -398,7 +421,6 @@ def generate_main_index_rst(output: str) -> None:
     logging.debug("Writing an index file at %s", output)
     write_to_rstfile("".join(lines), output)
 
-
 def main() -> None:
     """Main function that reads the YAML files and generates the RST files"""
 
-- 
2.44.0


