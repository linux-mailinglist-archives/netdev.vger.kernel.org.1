Return-Path: <netdev+bounces-199331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC481ADFDF1
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC483AC08D
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FCC2475F7;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3Ias+ip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099EB14F98;
	Thu, 19 Jun 2025 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315821; cv=none; b=ClP93R9l0xIpB6k+RmRvvAzyZsTxiX1Kr3KsMDOYwGcWmBEycP5huGk4BpnavOu5luBhUDhJSKlqOqwl+NLKjGLdH3nYENPbGDDZ19806Ai9fgsoNK8rED2qp1RblgrtM1XqTUuyypRJO80E2hXUP6VGUzO092MJVshrMHLr2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315821; c=relaxed/simple;
	bh=JvTI+DF/1Dszyn4T0n7ZKhi6vNtj6FoC1Ae/TMd5FHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+qfVXZYT29iX4h+3j0SR4PhWQcJxwbHnBi0Jg++OjmrZQ7alQfNb2gzl5a9Lx7v5xQEybC/DTwe6rLLxS1a3yPMG8uKzDbyokQSFof2t/cbdzH9mlbrj12ugmHVeX7uEPriREMN3w6P5dVvId4q/WDGMZiflwvCCiq57FIVLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3Ias+ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FEBC4CEEF;
	Thu, 19 Jun 2025 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750315820;
	bh=JvTI+DF/1Dszyn4T0n7ZKhi6vNtj6FoC1Ae/TMd5FHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3Ias+ipf86GGwEO696BS4I3hyYvFXlxOBAGciBgQQdC+P+FTYaKXuiz7aXKqEekB
	 41ROxbKjmPuoKAd9tjfNgQqtOqQYazDXp6UegXPSFE0/pZ+LCyI/gFx5I1zmeq7Jr9
	 tA81uMylDht8q2RvATdvzBe93F4GvuVAy2Z08iAW1lF+Rb1kETwLbWk8haNy/j8Y3j
	 1AOV+ArwTydcOqym6NhVQx+FxNx130IYvv0gRNHa8vhMf7pqjfvRAjDx/G0jWUr1IT
	 oAmKW6DE2sqa5wo3YM0ZLVbEgD4eP3sqO1PwNPhHlH00nh30QsotYnZb99Sbw1UkTu
	 OgpLPizO9qIrA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uS96I-00000003dGa-3TSR;
	Thu, 19 Jun 2025 08:50:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v7 01/17] docs: conf.py: properly handle include and exclude patterns
Date: Thu, 19 Jun 2025 08:48:54 +0200
Message-ID: <737b08e891765dc10bd944d4d42f8b1e37b80275.1750315578.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750315578.git.mchehab+huawei@kernel.org>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

When one does:
	make SPHINXDIRS="foo" htmldocs

All patterns would be relative to Documentation/foo, which
causes the include/exclude patterns like:

	include_patterns = [
		...
		f'foo/*.{ext}',
	]

to break. This is not what it is expected. Address it by
adding a logic to dynamically adjust the pattern when
SPHINXDIRS is used.

That allows adding parsers for other file types.

It should be noticed that include_patterns was added on
Sphinx 5.1:
	https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-include_patterns

So, a backward-compatible code is needed when we start
using it for real.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/conf.py | 67 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 12de52a2b17e..4ba4ee45e599 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -17,6 +17,66 @@ import os
 import sphinx
 import shutil
 
+# Get Sphinx version
+major, minor, patch = sphinx.version_info[:3]
+
+# Include_patterns were added on Sphinx 5.1
+if (major < 5) or (major == 5 and minor < 1):
+    has_include_patterns = False
+else:
+    has_include_patterns = True
+    # Include patterns that don't contain directory names, in glob format
+    include_patterns = ['**.rst']
+
+# Location of Documentation/ directory
+doctree = os.path.abspath('.')
+
+# Exclude of patterns that don't contain directory names, in glob format.
+exclude_patterns = []
+
+# List of patterns that contain directory names in glob format.
+dyn_include_patterns = []
+dyn_exclude_patterns = ['output']
+
+# Properly handle include/exclude patterns
+# ----------------------------------------
+
+def update_patterns(app):
+
+    """
+    On Sphinx, all directories are relative to what it is passed as
+    SOURCEDIR parameter for sphinx-build. Due to that, all patterns
+    that have directory names on it need to be dynamically set, after
+    converting them to a relative patch.
+
+    As Sphinx doesn't include any patterns outside SOURCEDIR, we should
+    exclude relative patterns that start with "../".
+    """
+
+    sourcedir = app.srcdir  # full path to the source directory
+    builddir = os.environ.get("BUILDDIR")
+
+    # setup include_patterns dynamically
+    if has_include_patterns:
+        for p in dyn_include_patterns:
+            full = os.path.join(doctree, p)
+
+            rel_path = os.path.relpath(full, start = app.srcdir)
+            if rel_path.startswith("../"):
+                continue
+
+            app.config.include_patterns.append(rel_path)
+
+    # setup exclude_patterns dynamically
+    for p in dyn_exclude_patterns:
+        full = os.path.join(doctree, p)
+
+        rel_path = os.path.relpath(full, start = app.srcdir)
+        if rel_path.startswith("../"):
+            continue
+
+        app.config.exclude_patterns.append(rel_path)
+
 # helper
 # ------
 
@@ -219,10 +279,6 @@ language = 'en'
 # Else, today_fmt is used as the format for a strftime call.
 #today_fmt = '%B %d, %Y'
 
-# List of patterns, relative to source directory, that match files and
-# directories to ignore when looking for source files.
-exclude_patterns = ['output']
-
 # The reST default role (used for this markup: `text`) to use for all
 # documents.
 #default_role = None
@@ -516,3 +572,6 @@ kerneldoc_srctree = '..'
 # the last statement in the conf.py file
 # ------------------------------------------------------------------------------
 loadConfig(globals())
+
+def setup(app):
+	app.connect('builder-inited', update_patterns)
-- 
2.49.0


