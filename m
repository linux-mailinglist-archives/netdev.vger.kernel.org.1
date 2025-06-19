Return-Path: <netdev+bounces-199343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAC0ADFE16
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9563B893E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC5F25F98A;
	Thu, 19 Jun 2025 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IimrqQdi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FCC253959;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315821; cv=none; b=tpY8ekRtmxW5EKAyiQPYPDtAY4M5rsTnCJGD1fQAvIgqJXHZplKe9aEegaDULk7SzUu11V4QMLhB1VJRG+ZZz0HQj9ZauyY8oGw6qEsOBb+jv4lwqk0H0gzjnDLgLAXHccn0Dqv2ej30l9wsNWuXtHKQRWdhOLr7CkO4NKj55J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315821; c=relaxed/simple;
	bh=4NisMpZH9SoZ5VV4u6jFkhlkA+lqE03MPhW7QcfYJIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpgNsgbZFaFNTde9MBGPPeBlqP5y/L+KpaHLyEK+hghI4EtRZOZ0Hm8pNhJZEKGDETyMBfheE6vDsWaRsVfR/ns9kSgiNn0Qa8gZkr7FO3LGzlpfCSd0m4ewwEd6/n5wx5N6NULIM4qm6VLP398MxBFxlkonrIKNSV4qtVbEHZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IimrqQdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA05C19424;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750315821;
	bh=4NisMpZH9SoZ5VV4u6jFkhlkA+lqE03MPhW7QcfYJIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IimrqQdiUejm+wBblyRRTg9HZcr+2iaV49ANTlPsNNx0zs93yGxnDtI/Cb8IeQHHx
	 xa8pBTEpSS1n56wI4IgWeyBHCVuxHMJEPmpIG/xRn8JFtfZmJOerxntvR3gV29bV8X
	 CYaay9TE4gQ1sHmq13+OtupdxdHXmm+As9sA16UO/JFpk93dsYGaOXUxeys4KvTJY/
	 duNCnzf3pORXb456NAOpc9Dy6zruowkPUAxYQo/UDod1du1SZkQzQ0hK6n/iANYOy9
	 Pm4v7KPG1+GX6YZPf1+u/zJ1+0Q5iICJCAPKhVjZP0dHoMl+HijwHPF5UGwAS/wBX6
	 W5/BC6MlZrvJQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uS96J-00000003dHc-1GDW;
	Thu, 19 Jun 2025 08:50:19 +0200
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
Subject: [PATCH v7 17/17] docs: conf.py: Check Sphinx and docutils version
Date: Thu, 19 Jun 2025 08:49:10 +0200
Message-ID: <8719d77d3a6ef30dff58f959dad5dd973496eeea.1750315578.git.mchehab+huawei@kernel.org>
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

As reported by Akira, there are incompatibility issues with
Sphinx and docutils.

I manually checked that before docutils 0.17.1, yaml generation
doesn't work properly. Akira checked that 0.19 is problematic too.

After check Sphinx release notes, it seems that the
versions that are supposed to cope well together are:

	========  ============  ============
	Sphinx    Min Docutils  Max Docutils
	Version   Version       Version
	--------  ------------  ------------
	< 4.0.0	  0.17.1        0.17.1
	< 6.0.0	  0.17.1        0.18.1
	< 7.0.0   0.18.0        0.18.1
	>= 7.0.0  0.20.0        0.21.2
	========  ============  ============

Add a logic inside conf.py to check the above, emitting warnings
if the docutils version don't match what is known to be supported.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/6fcb75ee-61db-4fb3-9c5f-2029a7fea4ee@gmail.com/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 5eddf5885f77..6047ec85add1 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -9,7 +9,11 @@ import os
 import shutil
 import sys
 
+import docutils
 import sphinx
+from sphinx.util import logging
+
+logger = logging.getLogger(__name__)
 
 # If extensions (or modules to document with autodoc) are in another directory,
 # add these directories to sys.path here. If the directory is relative to the
@@ -21,11 +25,34 @@ from load_config import loadConfig               # pylint: disable=C0413,E0401
 # Minimal supported version
 needs_sphinx = "3.4.3"
 
-# Get Sphinx version
-major, minor, patch = sphinx.version_info[:3]          # pylint: disable=I1101
+# Get Sphinx and docutils versions
+sphinx_ver = sphinx.version_info[:3]          # pylint: disable=I1101
+docutils_ver = docutils.__version_info__[:3]
+
+#
+if sphinx_ver < (4, 0, 0):
+    min_docutils = (0, 16, 0)
+    max_docutils = (0, 17, 1)
+elif sphinx_ver < (6, 0, 0):
+    min_docutils = (0, 17, 0)
+    max_docutils = (0, 18, 1)
+elif sphinx_ver < (7, 0, 0):
+    min_docutils = (0, 18, 0)
+    max_docutils = (0, 18, 1)
+else:
+    min_docutils = (0, 20, 0)
+    max_docutils = (0, 21, 2)
+
+sphinx_ver_str = ".".join([str(x) for x in sphinx_ver])
+docutils_ver_str = ".".join([str(x) for x in docutils_ver])
+
+if docutils_ver < min_docutils:
+    logger.warning(f"Docutils {docutils_ver_str} is too old for Sphinx {sphinx_ver_str}. Doc generation may fail")
+elif docutils_ver > max_docutils:
+    logger.warning(f"Docutils {docutils_ver_str} could be too new for Sphinx {sphinx_ver_str}. Doc generation may fail")
 
 # Include_patterns were added on Sphinx 5.1
-if (major < 5) or (major == 5 and minor < 1):
+if sphinx_ver < (5, 1, 0):
     has_include_patterns = False
 else:
     has_include_patterns = True
-- 
2.49.0


