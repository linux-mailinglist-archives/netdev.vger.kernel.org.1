Return-Path: <netdev+bounces-45908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7897E0417
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 14:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5041C20FA3
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 13:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E603518632;
	Fri,  3 Nov 2023 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ACD18623;
	Fri,  3 Nov 2023 13:56:43 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9718B7;
	Fri,  3 Nov 2023 06:56:38 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9be3b66f254so307656066b.3;
        Fri, 03 Nov 2023 06:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699019797; x=1699624597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHTCE7ROeImvpUXZ1SAvqpDykbwHTyy61xMy2AytBh0=;
        b=SZssVkdX9mupRt5f5hrd1uZtIL8EnEeI1++K3ccaR4rh/zIh2XOF7W8c6VItHrZydo
         hJgpKiNvm25pGC/uTkPuehNr56bCiL59mxykvYoHXQaUiBNO2uSY5tCurtG8DVRGuvzV
         cT/gt/zekLrGZfe0eMAqo/abtHZG5IjCyBxOGfvIsyGHdvwmlpnnPx8gn7sU+9HyzAsN
         6Pe5sNHwrdIP+YgsACBfLCSJxH8RQNP61Dvojorg2zI5nMPujmdK7FgtMxmZBDXF1X+C
         Ndn7PcWA7BZqECs/EHbL6En4nfguTOEpCIlpFiJJ0mrXBcW1n+pdZ0MEH6Js7eyzBVA7
         K4rw==
X-Gm-Message-State: AOJu0YzaLQoErBrHM5cRldr+GMpKj8ppfgF/9cKwfUaWPjfAL6/iJbTr
	1pIjA791MvcflJzpfPASlDM=
X-Google-Smtp-Source: AGHT+IH6+LcAVLmJe/Buh8eFeUfYVrBhpsRdik4jYowZPgkjC8OQtwKEHSQQy29cxuFaIdcB6c3jGA==
X-Received: by 2002:a17:907:940a:b0:9bf:4e0b:fb06 with SMTP id dk10-20020a170907940a00b009bf4e0bfb06mr7384104ejc.14.1699019796950;
        Fri, 03 Nov 2023 06:56:36 -0700 (PDT)
Received: from localhost (fwdproxy-cln-005.fbsv.net. [2a03:2880:31ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id v26-20020a17090606da00b009ae57888718sm919405ejb.207.2023.11.03.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:56:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH] Documentation: Document the Netlink spec
Date: Fri,  3 Nov 2023 06:56:22 -0700
Message-Id: <20231103135622.250314-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a Sphinx extension that parses the Netlink YAML spec files
(Documentation/netlink/specs/), and generates a rst file to be
displayed into Documentation pages.

Create a new Documentation/networking/netlink_spec page, and a sub-page
for each Netlink spec that needs to be documented, such as ethtool,
devlink, netdev, etc.

Create a Sphinx directive extension that reads the YAML spec
(located under Documentation/netlink/specs), parses it and returns a RST
string that is inserted where the Sphinx directive was called.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/conf.py                         |   2 +-
 Documentation/networking/index.rst            |   1 +
 .../networking/netlink_spec/devlink.rst       |   9 +
 .../networking/netlink_spec/ethtool.rst       |   9 +
 Documentation/networking/netlink_spec/fou.rst |   9 +
 .../networking/netlink_spec/handshake.rst     |   9 +
 .../networking/netlink_spec/index.rst         |  21 ++
 .../networking/netlink_spec/netdev.rst        |   9 +
 .../networking/netlink_spec/ovs_datapath.rst  |   9 +
 .../networking/netlink_spec/ovs_flow.rst      |   9 +
 .../networking/netlink_spec/ovs_vport.rst     |   9 +
 .../networking/netlink_spec/rt_addr.rst       |   9 +
 .../networking/netlink_spec/rt_link.rst       |   9 +
 .../networking/netlink_spec/rt_route.rst      |   9 +
 Documentation/sphinx/netlink_spec.py          | 283 ++++++++++++++++++
 Documentation/sphinx/requirements.txt         |   1 +
 16 files changed, 406 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/networking/netlink_spec/devlink.rst
 create mode 100644 Documentation/networking/netlink_spec/ethtool.rst
 create mode 100644 Documentation/networking/netlink_spec/fou.rst
 create mode 100644 Documentation/networking/netlink_spec/handshake.rst
 create mode 100644 Documentation/networking/netlink_spec/index.rst
 create mode 100644 Documentation/networking/netlink_spec/netdev.rst
 create mode 100644 Documentation/networking/netlink_spec/ovs_datapath.rst
 create mode 100644 Documentation/networking/netlink_spec/ovs_flow.rst
 create mode 100644 Documentation/networking/netlink_spec/ovs_vport.rst
 create mode 100644 Documentation/networking/netlink_spec/rt_addr.rst
 create mode 100644 Documentation/networking/netlink_spec/rt_link.rst
 create mode 100644 Documentation/networking/netlink_spec/rt_route.rst
 create mode 100755 Documentation/sphinx/netlink_spec.py

diff --git a/Documentation/conf.py b/Documentation/conf.py
index d4fdf6a3875a..10ce47d1a7df 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -55,7 +55,7 @@ needs_sphinx = '1.7'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat']
+              'kernel_abi', 'kernel_feat', 'netlink_spec']
 
 if major >= 3:
     if (major > 3) or (minor > 0 or patch >= 2):
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 5b75c3f7a137..ee3a2085af71 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -55,6 +55,7 @@ Contents:
    filter
    generic-hdlc
    generic_netlink
+   netlink_spec/index
    gen_stats
    gtp
    ila
diff --git a/Documentation/networking/netlink_spec/devlink.rst b/Documentation/networking/netlink_spec/devlink.rst
new file mode 100644
index 000000000000..ca4b98e29690
--- /dev/null
+++ b/Documentation/networking/netlink_spec/devlink.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+Family ``devlink`` netlink specification
+========================================
+
+.. contents::
+
+.. netlink-spec:: devlink.yaml
diff --git a/Documentation/networking/netlink_spec/ethtool.rst b/Documentation/networking/netlink_spec/ethtool.rst
new file mode 100644
index 000000000000..017d5dff427b
--- /dev/null
+++ b/Documentation/networking/netlink_spec/ethtool.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+Family ``ethtool`` netlink specification
+========================================
+
+.. contents::
+
+.. netlink-spec:: ethtool.yaml
diff --git a/Documentation/networking/netlink_spec/fou.rst b/Documentation/networking/netlink_spec/fou.rst
new file mode 100644
index 000000000000..4db939091f67
--- /dev/null
+++ b/Documentation/networking/netlink_spec/fou.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Family ``fou`` netlink specification
+=======================================
+
+.. contents::
+
+.. netlink-spec:: fou.yaml
diff --git a/Documentation/networking/netlink_spec/handshake.rst b/Documentation/networking/netlink_spec/handshake.rst
new file mode 100644
index 000000000000..ed3d79843602
--- /dev/null
+++ b/Documentation/networking/netlink_spec/handshake.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+Family ``handshake`` netlink specification
+==========================================
+
+.. contents::
+
+.. netlink-spec:: handshake.yaml
diff --git a/Documentation/networking/netlink_spec/index.rst b/Documentation/networking/netlink_spec/index.rst
new file mode 100644
index 000000000000..b330bda0ea21
--- /dev/null
+++ b/Documentation/networking/netlink_spec/index.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Netlink Specifications
+======================
+
+.. toctree::
+   :maxdepth: 2
+
+   devlink
+   ethtool
+   fou
+   handshake
+   netdev
+   ovs_datapath
+   ovs_flow
+   ovs_vport
+   rt_addr
+   rt_link
+   rt_route
+
diff --git a/Documentation/networking/netlink_spec/netdev.rst b/Documentation/networking/netlink_spec/netdev.rst
new file mode 100644
index 000000000000..4f43c31805dd
--- /dev/null
+++ b/Documentation/networking/netlink_spec/netdev.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Family ``netdev`` netlink specification
+=======================================
+
+.. contents::
+
+.. netlink-spec:: netdev.yaml
diff --git a/Documentation/networking/netlink_spec/ovs_datapath.rst b/Documentation/networking/netlink_spec/ovs_datapath.rst
new file mode 100644
index 000000000000..8045a5c93001
--- /dev/null
+++ b/Documentation/networking/netlink_spec/ovs_datapath.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================================
+Family ``ovs_datapath`` netlink specification
+=============================================
+
+.. contents::
+
+.. netlink-spec:: ovs_datapath.yaml
diff --git a/Documentation/networking/netlink_spec/ovs_flow.rst b/Documentation/networking/netlink_spec/ovs_flow.rst
new file mode 100644
index 000000000000..3a60d75b79b4
--- /dev/null
+++ b/Documentation/networking/netlink_spec/ovs_flow.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+Family ``ovs_flow`` netlink specification
+=========================================
+
+.. contents::
+
+.. netlink-spec:: ovs_flow.yaml
diff --git a/Documentation/networking/netlink_spec/ovs_vport.rst b/Documentation/networking/netlink_spec/ovs_vport.rst
new file mode 100644
index 000000000000..2be013c0b524
--- /dev/null
+++ b/Documentation/networking/netlink_spec/ovs_vport.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+Family ``ovs_vport`` netlink specification
+==========================================
+
+.. contents::
+
+.. netlink-spec:: ovs_vport.yaml
diff --git a/Documentation/networking/netlink_spec/rt_addr.rst b/Documentation/networking/netlink_spec/rt_addr.rst
new file mode 100644
index 000000000000..ca002646fa5c
--- /dev/null
+++ b/Documentation/networking/netlink_spec/rt_addr.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+Family ``rt_addr`` netlink specification
+========================================
+
+.. contents::
+
+.. netlink-spec:: rt_addr.yaml
diff --git a/Documentation/networking/netlink_spec/rt_link.rst b/Documentation/networking/netlink_spec/rt_link.rst
new file mode 100644
index 000000000000..e07481a34880
--- /dev/null
+++ b/Documentation/networking/netlink_spec/rt_link.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+Family ``rt_link`` netlink specification
+========================================
+
+.. contents::
+
+.. netlink-spec:: rt_link.yaml
diff --git a/Documentation/networking/netlink_spec/rt_route.rst b/Documentation/networking/netlink_spec/rt_route.rst
new file mode 100644
index 000000000000..7fe674dc098e
--- /dev/null
+++ b/Documentation/networking/netlink_spec/rt_route.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+Family ``rt_route`` netlink specification
+=========================================
+
+.. contents::
+
+.. netlink-spec:: rt_route.yaml
diff --git a/Documentation/sphinx/netlink_spec.py b/Documentation/sphinx/netlink_spec.py
new file mode 100755
index 000000000000..80756e72ed4f
--- /dev/null
+++ b/Documentation/sphinx/netlink_spec.py
@@ -0,0 +1,283 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8; mode: python -*-
+
+"""
+    netlink-spec
+    ~~~~~~~~~~~~~~~~~~~
+
+    Implementation of the ``netlink-spec`` ReST-directive.
+
+    :copyright:  Copyright (C) 2023  Breno Leitao <leitao@debian.org>
+    :license:    GPL Version 2, June 1991 see linux/COPYING for details.
+
+    The ``netlink-spec`` reST-directive performs extensive parsing
+    specific to the Linux kernel's standard netlink specs, in an
+    effort to avoid needing to heavily mark up the original YAML file.
+
+    This code is split in three big parts:
+        1) RST formatters: Use to convert a string to a RST output
+        2) Parser helpers: Helper functions to parse the YAML data
+        3) NetlinkSpec Directive: The actual directive class
+"""
+
+from typing import Any, Dict, List
+import os.path
+from docutils.parsers.rst import Directive
+from docutils import statemachine
+import yaml
+
+__version__ = "1.0"
+SPACE_PER_LEVEL = 4
+
+# RST Formatters
+def rst_definition(key: str, value: Any, level: int = 0) -> str:
+    """Format a single rst definition"""
+    return headroom(level) + key + "\n" + headroom(level + 1) + str(value)
+
+
+def rst_paragraph(paragraph: str, level: int = 0) -> str:
+    """Return a formatted paragraph"""
+    return headroom(level) + paragraph
+
+
+def headroom(level: int) -> str:
+    """Return space to format"""
+    return " " * (level * SPACE_PER_LEVEL)
+
+
+def rst_bullet(item: str, level: int = 0) -> str:
+    """Return a formatted a bullet"""
+    return headroom(level) + f" - {item}"
+
+def rst_subsubtitle(title: str) -> str:
+    """Add a sub-sub-title to the document"""
+    return f"{title}\n" + "~" * len(title)
+
+
+def rst_fields(key: str, value: str, level: int = 0) -> str:
+    """Return a RST formatted field"""
+    return headroom(level) + f":{key}: {value}"
+
+
+def rst_subtitle(title: str, level: int = 0) -> str:
+    """Add a subtitle to the document"""
+    return headroom(level) + f"\n{title}\n" + "-" * len(title)
+
+
+def rst_list_inline(list_: List[str], level: int = 0) -> str:
+    """Format a list using inlines"""
+    return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "]"
+
+
+def bold(text: str) -> str:
+    """Format bold text"""
+    return f"**{text}**"
+
+
+def inline(text: str) -> str:
+    """Format inline text"""
+    return f"``{text}``"
+
+
+def sanitize(text: str) -> str:
+    """Remove newlines and multiple spaces"""
+    # This is useful for some fields that are spread in multiple lines
+    return str(text).replace("\n", "").strip()
+
+
+# Parser helpers
+# ==============
+def parse_mcast_group(mcast_group: List[Dict[str, Any]]) -> str:
+    """Parse 'multicast' group list and return a formatted string"""
+    lines = []
+    for group in mcast_group:
+        lines.append(rst_paragraph(group["name"], 1))
+
+    return "\n".join(lines)
+
+
+def parse_do(do_dict: Dict[str, Any], level: int = 0) -> str:
+    """Parse 'do' section and return a formatted string"""
+    lines = []
+    for key in do_dict.keys():
+        lines.append(rst_bullet(bold(key), level + 1))
+        lines.append(parse_do_attributes(do_dict[key], level + 1) + "\n")
+
+    return "\n".join(lines)
+
+
+def parse_do_attributes(attrs: Dict[str, Any], level: int = 0) -> str:
+    """Parse 'attributes' section"""
+    if "attributes" not in attrs:
+        return ""
+    lines = [rst_fields("attributes", rst_list_inline(attrs["attributes"]), level + 1)]
+
+    return "\n".join(lines)
+
+
+def parse_operations(operations: List[Dict[str, Any]]) -> str:
+    """Parse operations block"""
+    preprocessed = ["name", "doc", "title", "do", "dump"]
+    lines = []
+
+    for operation in operations:
+        lines.append(rst_subsubtitle(operation["name"]))
+        lines.append(rst_paragraph(operation["doc"]) + "\n")
+        if "do" in operation:
+            lines.append(rst_paragraph(bold("do"), 1))
+            lines.append(parse_do(operation["do"], 1))
+        if "dump" in operation:
+            lines.append(rst_paragraph(bold("dump"), 1))
+            lines.append(parse_do(operation["dump"], 1))
+
+        for key in operation.keys():
+            if key in preprocessed:
+                # Skip the special fields
+                continue
+            lines.append(rst_fields(key, operation[key], 1))
+
+        # New line after fields
+        lines.append("\n")
+
+    return "\n".join(lines)
+
+
+def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
+    """Parse a list of entries"""
+    lines = []
+    for entry in entries:
+        if isinstance(entry, dict):
+            # entries could be a list or a dictionary
+            lines.append(
+                rst_fields(entry.get("name"), sanitize(entry.get("doc")), level)
+            )
+        elif isinstance(entry, list):
+            lines.append(rst_list_inline(entry, level))
+        else:
+            lines.append(rst_bullet(inline(sanitize(entry)), level))
+
+    lines.append("\n")
+    return "\n".join(lines)
+
+
+def parse_definitions(defs: Dict[str, Any]) -> str:
+    """Parse definitions section"""
+    preprocessed = ["name", "entries", "members"]
+    ignored = ["render-max"] # This is not printed
+    lines = []
+
+    for definition in defs:
+        lines.append(rst_subsubtitle(definition["name"]))
+        for k in definition.keys():
+            if k in preprocessed + ignored:
+                continue
+            lines.append(rst_fields(k, sanitize(definition[k]), 1))
+
+        # Field list needs to finish with a new line
+        lines.append("\n")
+        if "entries" in definition:
+            lines.append(rst_paragraph(bold("Entries"), 1))
+            lines.append(parse_entries(definition["entries"], 2))
+        if "members" in definition:
+            lines.append(rst_paragraph(bold("members"), 1))
+            lines.append(parse_entries(definition["members"], 2))
+
+    return "\n".join(lines)
+
+
+def parse_attributes_set(entries: List[Dict[str, Any]]) -> str:
+    """Parse attribute from attribute-set"""
+    preprocessed = ["name", "type"]
+    ignored = ["checks"]
+    lines = []
+
+    for entry in entries:
+        lines.append(rst_bullet(bold(entry["name"])))
+        for attr in entry["attributes"]:
+            type_ = attr.get("type")
+            attr_line = bold(attr["name"])
+            if type_:
+                # Add the attribute type in the same line
+                attr_line += f" ({inline(type_)})"
+
+            lines.append(rst_bullet(attr_line, 2))
+
+            for k in attr.keys():
+                if k in preprocessed + ignored:
+                    continue
+                lines.append(rst_fields(k, sanitize(attr[k]), 3))
+            lines.append("\n")
+
+    return "\n".join(lines)
+
+
+def parse_yaml(obj: Dict[str, Any]) -> str:
+    """Format the whole yaml into a RST string"""
+    lines = []
+
+    # This is coming from the RST
+    lines.append(rst_subtitle("Summary"))
+    lines.append(rst_paragraph(obj["doc"], 1))
+
+    # Operations
+    lines.append(rst_subtitle("Operations"))
+    lines.append(parse_operations(obj["operations"]["list"]))
+
+    # Multicast groups
+    if "mcast-groups" in obj:
+        lines.append(rst_subtitle("Multicast groups"))
+        lines.append(parse_mcast_group(obj["mcast-groups"]["list"]))
+
+    # Definitions
+    lines.append(rst_subtitle("Definitions"))
+    lines.append(parse_definitions(obj["definitions"]))
+
+    # Attributes set
+    lines.append(rst_subtitle("Attribute sets"))
+    lines.append(parse_attributes_set(obj["attribute-sets"]))
+
+    return "\n".join(lines)
+
+
+def parse_yaml_file(filename: str, debug: bool = False) -> str:
+    """Transform the yaml specified by filename into a rst-formmated string"""
+    with open(filename, "r") as file:
+        yaml_data = yaml.safe_load(file)
+        content = parse_yaml(yaml_data)
+
+    if debug:
+        # Save the rst for inspection
+        print(content, file=open(f"/tmp/{filename.split('/')[-1]}.rst", "w"))
+
+    return content
+
+
+# Main Sphinx Extension class
+def setup(app):
+    """Sphinx-build register function for 'netlink-spec' directive"""
+    app.add_directive("netlink-spec", NetlinkSpec)
+    return dict(version=__version__, parallel_read_safe=True, parallel_write_safe=True)
+
+
+class NetlinkSpec(Directive):
+    """NetlinkSpec (``netlink-spec``) directive class"""
+    has_content = True
+    # Argument is the filename to process
+    required_arguments = 1
+
+    def run(self):
+        srctree = os.path.abspath(os.environ["srctree"])
+        yaml_file = os.path.join(
+            srctree, "Documentation/netlink/specs", self.arguments[0]
+        )
+        self.state.document.settings.record_dependencies.add(yaml_file)
+
+        try:
+            content = parse_yaml_file(yaml_file)
+        except FileNotFoundError as exception:
+            raise self.severe(str(exception))
+
+        self.state_machine.insert_input(statemachine.string2lines(content), yaml_file)
+
+        return []
diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 335b53df35e2..a8a1aff6445e 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,4 @@
 # jinja2>=3.1 is not compatible with Sphinx<4.0
 jinja2<3.1
 Sphinx==2.4.4
+pyyaml
-- 
2.34.1


