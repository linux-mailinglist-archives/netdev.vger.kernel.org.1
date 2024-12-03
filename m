Return-Path: <netdev+bounces-148415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40AE9E19FF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2303B375C3
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03571DEFEA;
	Tue,  3 Dec 2024 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw+I8Mrs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E81DFD83
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218046; cv=none; b=Bu25OX/259P1FqikWf9/G/XPTEoooXUfMrnJSmSH8mPieIg5G5XZou5th0c0eJpBwJ0wXtFfZbQapWlnUrFi3OICJRjihsXBwuiI6Y27GQ58qU/TUb59fP9DcaGAHoKQr2Pyt9oXj+TCOSV+EPWZ/k3OKl+dR5J6QwoqiLGtepw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218046; c=relaxed/simple;
	bh=39SHD+VjfNUd7C3Ji7Di7q+42sRYS1L14vIFwRE0JO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=UWyE0Cjzjb95F9xK1VkDzn/J4JWk4rRcmcoZV1L693I1Rk/3ovfW0Iz8L3goQi5lvkOE8lQeYrNQpjk6+wuRByVj4h6z4Kad+UXnCMFHbU3x2ms+ePb5rUPFF8arFtA/aUNuKGkKizNbLJZIF2OfLJ3Gyborh7WU7pbB/dNlats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dw+I8Mrs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733218044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJrry1UVSeQzVul0wdv32bJIy87aa7w5dz7DAhlFvV4=;
	b=dw+I8MrsSLLQ79c9MKyNc3a2shrHK3unsMauIXTDfWZ804yggs7STR7GS1LCxN8Q29X2Cg
	Bisau+EGMgTK80MpDwKRZn02hF1hzdBRvPL/o5ukhwo1I55Y8KxCtA6dPt2A9mSujFykP7
	/LFZvOOh5DanseG50w/VlU0fIYadFxU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-XP3M99xYMtih2sajAbQf1g-1; Tue,
 03 Dec 2024 04:27:22 -0500
X-MC-Unique: XP3M99xYMtih2sajAbQf1g-1
X-Mimecast-MFC-AGG-ID: XP3M99xYMtih2sajAbQf1g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB5861944B38;
	Tue,  3 Dec 2024 09:27:20 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C8411956052;
	Tue,  3 Dec 2024 09:27:15 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH 1/5] tools: ynl: move python code to separate sub-directory
Date: Tue,  3 Dec 2024 10:27:00 +0100
Message-ID: <20b2bdfe94fed5b9694e22c79c79858502f5e014.1733216767.git.jstancek@redhat.com>
In-Reply-To: <cover.1733216767.git.jstancek@redhat.com>
References: <cover.1733216767.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move python code to a separate directory so it can be
packaged as a python module.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/Makefile                    | 1 +
 tools/net/ynl/generated/Makefile          | 2 +-
 tools/net/ynl/lib/.gitignore              | 1 -
 tools/net/ynl/lib/Makefile                | 1 -
 tools/net/ynl/pyynl/__init__.py           | 0
 tools/net/ynl/{ => pyynl}/cli.py          | 0
 tools/net/ynl/{ => pyynl}/ethtool.py      | 0
 tools/net/ynl/pyynl/lib/.gitignore        | 1 +
 tools/net/ynl/{ => pyynl}/lib/__init__.py | 0
 tools/net/ynl/{ => pyynl}/lib/nlspec.py   | 0
 tools/net/ynl/{ => pyynl}/lib/ynl.py      | 0
 tools/net/ynl/{ => pyynl}/ynl-gen-c.py    | 0
 tools/net/ynl/{ => pyynl}/ynl-gen-rst.py  | 0
 tools/net/ynl/ynl-regen.sh                | 2 +-
 14 files changed, 4 insertions(+), 4 deletions(-)
 create mode 100644 tools/net/ynl/pyynl/__init__.py
 rename tools/net/ynl/{ => pyynl}/cli.py (100%)
 rename tools/net/ynl/{ => pyynl}/ethtool.py (100%)
 create mode 100644 tools/net/ynl/pyynl/lib/.gitignore
 rename tools/net/ynl/{ => pyynl}/lib/__init__.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/nlspec.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/ynl.py (100%)
 rename tools/net/ynl/{ => pyynl}/ynl-gen-c.py (100%)
 rename tools/net/ynl/{ => pyynl}/ynl-gen-rst.py (100%)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index d1cdf2a8f826..617b405d9ef8 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -21,5 +21,6 @@ clean distclean:
 		fi \
 	done
 	rm -f libynl.a
+	rm -rf pyynl/lib/__pycache__
 
 .PHONY: all clean distclean $(SUBDIRS)
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 7db5240de58a..36519ea2792a 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -12,7 +12,7 @@ include ../Makefile.deps
 YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
 	--exclude-op stats-get
 
-TOOL:=../ynl-gen-c.py
+TOOL:=../pyynl/ynl-gen-c.py
 
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
diff --git a/tools/net/ynl/pyynl/lib/.gitignore b/tools/net/ynl/pyynl/lib/.gitignore
new file mode 100644
index 000000000000..c18dd8d83cee
--- /dev/null
+++ b/tools/net/ynl/pyynl/lib/.gitignore
@@ -0,0 +1 @@
+__pycache__/
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
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/pyynl/ynl-gen-c.py
similarity index 100%
rename from tools/net/ynl/ynl-gen-c.py
rename to tools/net/ynl/pyynl/ynl-gen-c.py
diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/pyynl/ynl-gen-rst.py
similarity index 100%
rename from tools/net/ynl/ynl-gen-rst.py
rename to tools/net/ynl/pyynl/ynl-gen-rst.py
diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
index a37304dcc88e..3212dab1cc6e 100755
--- a/tools/net/ynl/ynl-regen.sh
+++ b/tools/net/ynl/ynl-regen.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
-TOOL=$(dirname $(realpath $0))/ynl-gen-c.py
+TOOL=$(dirname $(realpath $0))/pyynl/ynl-gen-c.py
 
 force=
 search=
-- 
2.43.0


