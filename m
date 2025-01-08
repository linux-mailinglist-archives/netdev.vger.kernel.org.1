Return-Path: <netdev+bounces-156283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2687A05DBB
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CC0160AFF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719BC1FDE14;
	Wed,  8 Jan 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZV5m217"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA21F75B3
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344624; cv=none; b=WDIzuua/EeIKugZ/haxeSdJfp4ByYtcysTGqfkdF3d5PyaosgtzL1JJvm1tjJKRI2gJKnfbZExDnduYjCpih/Z7pHGJwg4nVkXyCqQt+wZr9cweiaPyh4cjlgRznJHpAtkBOA4Vv9klg3fMd0ZdXcke/jzFWmn9Kkg7zwKZOqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344624; c=relaxed/simple;
	bh=IDCxuSwOOqXzXTuYpI6f+k0V8+w7q3oPVkwYdpL6fq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Z/sdp8yAuNJ+OwHirWag6sNKdlHSY0k13EIHzDO3IsA/DJzbjHX+i3FQs56OqslhNqlZ0Z806lTQGMjKIc2RqwTlOWmMRyfzBOj5AZwGK1U4ZMhg/ZrOfczRTclbAxeOFi6V5IyRS4916jMQM0jMTqOOuR9877ihwBGpyTm0+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZV5m217; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736344621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LiHChfq5rqRZoafAxUhqrx/kQf5di1eKmkdYxxA5jgg=;
	b=dZV5m217AVZfmdGI/jDHTu5DFy4uajG0L9T19etanJP+NNF628edu7wa4CYDPID01V24Gn
	3na6/ac6KRBZwXMifNDrVBIe7yduntj70WO3MCigXFQXjNngYxVBQRHXoeAEQ+5EadXa0/
	VVM+ZiNxVoGU0yLWPGf3b8pTBLx9cQQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-yqXwvnyWPoqTE_Vw0prpTw-1; Wed,
 08 Jan 2025 08:56:55 -0500
X-MC-Unique: yqXwvnyWPoqTE_Vw0prpTw-1
X-Mimecast-MFC-AGG-ID: yqXwvnyWPoqTE_Vw0prpTw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAD4F19560B4;
	Wed,  8 Jan 2025 13:56:54 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.0])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E6809300018D;
	Wed,  8 Jan 2025 13:56:51 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	jdamato@fastly.com
Cc: pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v4 1/4] tools: ynl: move python code to separate sub-directory
Date: Wed,  8 Jan 2025 14:56:14 +0100
Message-ID: <a4151bad0e6984e7164d395125ce87fd2e048bf1.1736343575.git.jstancek@redhat.com>
In-Reply-To: <cover.1736343575.git.jstancek@redhat.com>
References: <cover.1736343575.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Move python code to a separate directory so it can be
packaged as a python module. Updates existing references
in selftests and docs.

Also rename ynl-gen-[c|rst] to ynl_gen_[c|rst], avoid
dashes as these prevent easy imports for entrypoints.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/Makefile                                 | 2 +-
 Documentation/networking/multi-pf-netdev.rst           | 4 ++--
 Documentation/networking/napi.rst                      | 4 ++--
 Documentation/networking/netlink_spec/readme.txt       | 2 +-
 Documentation/userspace-api/netlink/intro-specs.rst    | 8 ++++----
 tools/net/ynl/Makefile                                 | 2 ++
 tools/net/ynl/generated/Makefile                       | 2 +-
 tools/net/ynl/lib/.gitignore                           | 1 -
 tools/net/ynl/lib/Makefile                             | 1 -
 tools/net/ynl/pyynl/.gitignore                         | 2 ++
 tools/net/ynl/pyynl/__init__.py                        | 0
 tools/net/ynl/{ => pyynl}/cli.py                       | 0
 tools/net/ynl/{ => pyynl}/ethtool.py                   | 0
 tools/net/ynl/{ => pyynl}/lib/__init__.py              | 0
 tools/net/ynl/{ => pyynl}/lib/nlspec.py                | 0
 tools/net/ynl/{ => pyynl}/lib/ynl.py                   | 0
 tools/net/ynl/{ynl-gen-c.py => pyynl/ynl_gen_c.py}     | 0
 tools/net/ynl/{ynl-gen-rst.py => pyynl/ynl_gen_rst.py} | 0
 tools/net/ynl/ynl-regen.sh                             | 2 +-
 tools/testing/selftests/net/lib/py/ynl.py              | 4 ++--
 tools/testing/selftests/net/ynl.mk                     | 3 ++-
 21 files changed, 20 insertions(+), 17 deletions(-)
 create mode 100644 tools/net/ynl/pyynl/.gitignore
 create mode 100644 tools/net/ynl/pyynl/__init__.py
 rename tools/net/ynl/{ => pyynl}/cli.py (100%)
 rename tools/net/ynl/{ => pyynl}/ethtool.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/__init__.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/nlspec.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/ynl.py (100%)
 rename tools/net/ynl/{ynl-gen-c.py => pyynl/ynl_gen_c.py} (100%)
 rename tools/net/ynl/{ynl-gen-rst.py => pyynl/ynl_gen_rst.py} (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index fa71602ec961..52c6c5a3efa9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -104,7 +104,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 YNL_INDEX:=$(srctree)/Documentation/networking/netlink_spec/index.rst
 YNL_RST_DIR:=$(srctree)/Documentation/networking/netlink_spec
 YNL_YAML_DIR:=$(srctree)/Documentation/netlink/specs
-YNL_TOOL:=$(srctree)/tools/net/ynl/ynl-gen-rst.py
+YNL_TOOL:=$(srctree)/tools/net/ynl/pyynl/ynl_gen_rst.py
 
 YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
 YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
diff --git a/Documentation/networking/multi-pf-netdev.rst b/Documentation/networking/multi-pf-netdev.rst
index 2cd25d81aaa7..2f5a5bb3ca9a 100644
--- a/Documentation/networking/multi-pf-netdev.rst
+++ b/Documentation/networking/multi-pf-netdev.rst
@@ -89,7 +89,7 @@ Observability
 =============
 The relation between PF, irq, napi, and queue can be observed via netlink spec::
 
-  $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump queue-get --json='{"ifindex": 13}'
+  $ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump queue-get --json='{"ifindex": 13}'
   [{'id': 0, 'ifindex': 13, 'napi-id': 539, 'type': 'rx'},
    {'id': 1, 'ifindex': 13, 'napi-id': 540, 'type': 'rx'},
    {'id': 2, 'ifindex': 13, 'napi-id': 541, 'type': 'rx'},
@@ -101,7 +101,7 @@ The relation between PF, irq, napi, and queue can be observed via netlink spec::
    {'id': 3, 'ifindex': 13, 'napi-id': 542, 'type': 'tx'},
    {'id': 4, 'ifindex': 13, 'napi-id': 543, 'type': 'tx'}]
 
-  $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump napi-get --json='{"ifindex": 13}'
+  $ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump napi-get --json='{"ifindex": 13}'
   [{'id': 543, 'ifindex': 13, 'irq': 42},
    {'id': 542, 'ifindex': 13, 'irq': 41},
    {'id': 541, 'ifindex': 13, 'irq': 40},
diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index 02720dd71a76..6083210ab2a4 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -199,13 +199,13 @@ parameters mentioned above use hyphens instead of underscores:
 
 Per-NAPI configuration can be done programmatically in a user application
 or by using a script included in the kernel source tree:
-``tools/net/ynl/cli.py``.
+``tools/net/ynl/pyynl/cli.py``.
 
 For example, using the script:
 
 .. code-block:: bash
 
-  $ kernel-source/tools/net/ynl/cli.py \
+  $ kernel-source/tools/net/ynl/pyynl/cli.py \
             --spec Documentation/netlink/specs/netdev.yaml \
             --do napi-set \
             --json='{"id": 345,
diff --git a/Documentation/networking/netlink_spec/readme.txt b/Documentation/networking/netlink_spec/readme.txt
index 6763f99d216c..030b44aca4e6 100644
--- a/Documentation/networking/netlink_spec/readme.txt
+++ b/Documentation/networking/netlink_spec/readme.txt
@@ -1,4 +1,4 @@
 SPDX-License-Identifier: GPL-2.0
 
 This file is populated during the build of the documentation (htmldocs) by the
-tools/net/ynl/ynl-gen-rst.py script.
+tools/net/ynl/pyynl/ynl_gen_rst.py script.
diff --git a/Documentation/userspace-api/netlink/intro-specs.rst b/Documentation/userspace-api/netlink/intro-specs.rst
index bada89699455..a4435ae4628d 100644
--- a/Documentation/userspace-api/netlink/intro-specs.rst
+++ b/Documentation/userspace-api/netlink/intro-specs.rst
@@ -15,7 +15,7 @@ developing Netlink related code. The tool is implemented in Python
 and can use a YAML specification to issue Netlink requests
 to the kernel. Only Generic Netlink is supported.
 
-The tool is located at ``tools/net/ynl/cli.py``. It accepts
+The tool is located at ``tools/net/ynl/pyynl/cli.py``. It accepts
 a handul of arguments, the most important ones are:
 
  - ``--spec`` - point to the spec file
@@ -27,7 +27,7 @@ YAML specs can be found under ``Documentation/netlink/specs/``.
 
 Example use::
 
-  $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/ethtool.yaml \
+  $ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/ethtool.yaml \
         --do rings-get \
 	--json '{"header":{"dev-index": 18}}'
   {'header': {'dev-index': 18, 'dev-name': 'eni1np1'},
@@ -75,7 +75,7 @@ the two marker lines like above to a file, add that file to git,
 and run the regeneration tool. Grep the tree for ``YNL-GEN``
 to see other examples.
 
-The code generation itself is performed by ``tools/net/ynl/ynl-gen-c.py``
+The code generation itself is performed by ``tools/net/ynl/pyynl/ynl_gen_c.py``
 but it takes a few arguments so calling it directly for each file
 quickly becomes tedious.
 
@@ -84,7 +84,7 @@ YNL lib
 
 ``tools/net/ynl/lib/`` contains an implementation of a C library
 (based on libmnl) which integrates with code generated by
-``tools/net/ynl/ynl-gen-c.py`` to create easy to use netlink wrappers.
+``tools/net/ynl/pyynl/ynl_gen_c.py`` to create easy to use netlink wrappers.
 
 YNL basics
 ----------
diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index d1cdf2a8f826..5268b91bf7ed 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -21,5 +21,7 @@ clean distclean:
 		fi \
 	done
 	rm -f libynl.a
+	rm -rf pyynl/__pycache__
+	rm -rf pyynl/lib/__pycache__
 
 .PHONY: all clean distclean $(SUBDIRS)
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 7db5240de58a..00af721b1571 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -12,7 +12,7 @@ include ../Makefile.deps
 YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
 	--exclude-op stats-get
 
-TOOL:=../ynl-gen-c.py
+TOOL:=../pyynl/ynl_gen_c.py
 
 GENS_PATHS=$(shell grep -nrI --files-without-match \
 		'protocol: netlink' \
diff --git a/tools/net/ynl/lib/.gitignore b/tools/net/ynl/lib/.gitignore
index 296c4035dbf2..a4383358ec72 100644
--- a/tools/net/ynl/lib/.gitignore
+++ b/tools/net/ynl/lib/.gitignore
@@ -1,2 +1 @@
-__pycache__/
 *.d
diff --git a/tools/net/ynl/lib/Makefile b/tools/net/ynl/lib/Makefile
index 94c49cca3dca..4b2b98704ff9 100644
--- a/tools/net/ynl/lib/Makefile
+++ b/tools/net/ynl/lib/Makefile
@@ -19,7 +19,6 @@ ynl.a: $(OBJS)
 
 clean:
 	rm -f *.o *.d *~
-	rm -rf __pycache__
 
 distclean: clean
 	rm -f *.a
diff --git a/tools/net/ynl/pyynl/.gitignore b/tools/net/ynl/pyynl/.gitignore
new file mode 100644
index 000000000000..b801cd2d016e
--- /dev/null
+++ b/tools/net/ynl/pyynl/.gitignore
@@ -0,0 +1,2 @@
+__pycache__/
+lib/__pycache__/
diff --git a/tools/net/ynl/pyynl/__init__.py b/tools/net/ynl/pyynl/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/pyynl/cli.py
similarity index 100%
rename from tools/net/ynl/cli.py
rename to tools/net/ynl/pyynl/cli.py
diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
similarity index 100%
rename from tools/net/ynl/ethtool.py
rename to tools/net/ynl/pyynl/ethtool.py
diff --git a/tools/net/ynl/lib/__init__.py b/tools/net/ynl/pyynl/lib/__init__.py
similarity index 100%
rename from tools/net/ynl/lib/__init__.py
rename to tools/net/ynl/pyynl/lib/__init__.py
diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
similarity index 100%
rename from tools/net/ynl/lib/nlspec.py
rename to tools/net/ynl/pyynl/lib/nlspec.py
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
similarity index 100%
rename from tools/net/ynl/lib/ynl.py
rename to tools/net/ynl/pyynl/lib/ynl.py
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
similarity index 100%
rename from tools/net/ynl/ynl-gen-c.py
rename to tools/net/ynl/pyynl/ynl_gen_c.py
diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
similarity index 100%
rename from tools/net/ynl/ynl-gen-rst.py
rename to tools/net/ynl/pyynl/ynl_gen_rst.py
diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
index a37304dcc88e..81b4ecd89100 100755
--- a/tools/net/ynl/ynl-regen.sh
+++ b/tools/net/ynl/ynl-regen.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
-TOOL=$(dirname $(realpath $0))/ynl-gen-c.py
+TOOL=$(dirname $(realpath $0))/pyynl/ynl_gen_c.py
 
 force=
 search=
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 076a7e8dc3eb..ad1e36baee2a 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -13,14 +13,14 @@ try:
         SPEC_PATH = KSFT_DIR / "net/lib/specs"
 
         sys.path.append(tools_full_path.as_posix())
-        from net.lib.ynl.lib import YnlFamily, NlError
+        from net.lib.ynl.pyynl.lib import YnlFamily, NlError
     else:
         # Running in tree
         tools_full_path = KSRC / "tools"
         SPEC_PATH = KSRC / "Documentation/netlink/specs"
 
         sys.path.append(tools_full_path.as_posix())
-        from net.ynl.lib import YnlFamily, NlError
+        from net.ynl.pyynl.lib import YnlFamily, NlError
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `ynl` library from kernel sources")
     ksft_pr(str(e))
diff --git a/tools/testing/selftests/net/ynl.mk b/tools/testing/selftests/net/ynl.mk
index d43afe243779..12e7cae251be 100644
--- a/tools/testing/selftests/net/ynl.mk
+++ b/tools/testing/selftests/net/ynl.mk
@@ -31,7 +31,8 @@ $(OUTPUT)/libynl.a: $(YNL_SPECS) $(OUTPUT)/.libynl-$(YNL_GENS_HASH).sig
 	$(Q)cp $(top_srcdir)/tools/net/ynl/libynl.a $(OUTPUT)/libynl.a
 
 EXTRA_CLEAN += \
-	$(top_srcdir)/tools/net/ynl/lib/__pycache__ \
+	$(top_srcdir)/tools/net/ynl/pyynl/__pycache__ \
+	$(top_srcdir)/tools/net/ynl/pyynl/lib/__pycache__ \
 	$(top_srcdir)/tools/net/ynl/lib/*.[ado] \
 	$(OUTPUT)/.libynl-*.sig \
 	$(OUTPUT)/libynl.a
-- 
2.43.0


