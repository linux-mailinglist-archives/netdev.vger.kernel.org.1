Return-Path: <netdev+bounces-221219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215D5B4FC61
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C861BC775C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914C5340D9A;
	Tue,  9 Sep 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="x00Engyz"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9593218D0
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424127; cv=none; b=H2NN7gFv/E6kfdB9sU1xRdG3AWrlK7f8BfngGOvZqTipn4fqI1KlgjN+yYzCmpWHAE5SOVauLBFNum2TOg4Tqm7fxcqtEEpu1kjC45cbFCKz2Ceh19f9lY7AHpIpca/IUSERuI42DE754YcMXI968YhE4KBU9eM/Bj2rHGjhijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424127; c=relaxed/simple;
	bh=nTklphbKec1dqeg91ig+HC41qiYgIMM8IRMQcK4cZJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CnYk1i3CaQG9krZm+iWp/94f/zPDwMnjrdiJfu+4gF5c+k11t6tsk4D2jdXaDms2+8LK0dfz5RNIzcqSNVwNw1F5RhKNQHLi9NvCjW8nVFWrjpsl1EH59EGaq7Kgx1xbkVn6eH3ulbYjG98vsZPSpVmh+Yo8EbMlZ5xEoouRk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=x00Engyz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 30728C6B39E;
	Tue,  9 Sep 2025 13:21:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D9E7D60630;
	Tue,  9 Sep 2025 13:22:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08454102F27F2;
	Tue,  9 Sep 2025 15:22:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757424121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Jgxw2vjes+YPCoBh3+f4yiXw6JgQQ3m2MdCmEakuFeo=;
	b=x00EngyzjawEDroEo35gEIRYINhMH5la0uRynqeF8Nxgnv6h6Y0EDwcs1LQXuf00sgzoG8
	/eDvqRHv8I8gTlEjS/0ip5jwStv3ZeOwXXL3SI+jZylIlR1yyGPK54kgZexbO4JNIP2CdG
	hTSbbd2xPv7pIcE20ZkDdYeTxYnYDCJCx6dvH9yrdGto+OtzUK8hr8ynmJSLS9QndGGCtU
	VshpOjxGVAvgHd+qRGMgklyi6WOeOB3lyDnL7iMIo1388vWA4LnykyW8Ru/8Uka8Yhgo6M
	P9cQHxkmGbJc8jQVHR2aDQgsjkOcL4gN6O4d+KAW0byzFQ8nQfH5wdHeZY60lA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Sep 2025 15:21:42 +0200
Subject: [PATCH iproute2-next 1/2] scripts: Add uapi header import script
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
References: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
In-Reply-To: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

Add a script to automate importing Linux UAPI headers from kernel source.
The script handles dependency resolution and creates a commit with proper
attribution, similar to the ethtool project approach.

Usage:
    $ LINUX_GIT="$LINUX_PATH" iproute2-import-uapi [commit]

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 scripts/iproute2-import-uapi | 67 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/scripts/iproute2-import-uapi b/scripts/iproute2-import-uapi
new file mode 100755
index 00000000..505ab25a
--- /dev/null
+++ b/scripts/iproute2-import-uapi
@@ -0,0 +1,67 @@
+#!/bin/bash -e
+#
+# iproute2-import-uapi [commit]
+#
+# Imports sanitized copies of kernel uapi headers from <commit> (can be
+# a commit id, a tag or a branch name). If the argument is omitted,
+# commit currently checked out in the kernel repository is used.
+
+sn="${0##*/}"
+export ARCH="x86_64"
+mkopt="-j$(nproc)" || mkopt=''
+
+if [ ! -d "$LINUX_GIT" ]; then
+    echo "${sn}: please set LINUX_GIT to the location of kernel git" >&2
+    exit 1
+fi
+
+pushd "$LINUX_GIT"
+if [ -n "$1" ]; then
+    git checkout "$1"
+fi
+desc=$(git describe --exact-match 2>/dev/null \
+       || git show -s --abbrev=12 --pretty='%h: ("%s")')
+kobj=$(mktemp -d)
+make $mkopt O="$kobj" allmodconfig
+make $mkopt O="$kobj" prepare
+make $mkopt O="$kobj" INSTALL_HDR_PATH="${kobj}/hdr" headers_install
+popd
+
+pushd include/uapi
+find . -type f -name '*.h' -exec cp -v "${kobj}/hdr/include/{}" {} \;
+
+go_on=true
+while $go_on; do
+    go_on=false
+    while read f; do
+        if [ "${f#asm/}" != "$f" ]; then
+            # skip architecture dependent asm/ headers
+            continue
+        fi
+        if [ -f "$f" ]; then
+            # already present
+            continue
+        fi
+	if [ ! -f "${kobj}/hdr/include/${f}" ]; then
+            # not a kernel header
+            continue
+        fi
+        echo "+ add $f"
+        go_on=true
+        mkdir -p "${f%/*}"
+        cp "${kobj}/hdr/include/${f}" "${f}"
+    done < <(
+        find . -type f -name '*.[ch]' -exec sed -nre '\_^[[:blank:]]*#include[[:blank:]]<.+>_ { s_^[[:blank:]]*#include[[:blank:]]<([^>]*)>.*$_\1_ ; p }' {} \; \
+            | LC_ALL=C sort -u
+    )
+done
+popd
+rm -rf "$kobj"
+
+git add include/uapi
+git commit -s -F - <<EOT
+Update kernel headers
+
+Update kernel headers to commit:
+	${desc}
+EOT

-- 
2.43.0


