Return-Path: <netdev+bounces-141307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58289BA6BC
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 17:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9261F21F23
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254918870F;
	Sun,  3 Nov 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RooQ2uSe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E21885A0
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730652801; cv=none; b=unY0+fMQdMhHXjUI+b6cbvznUGakr85uWWwKg+I0nBQMdpYH3Op4piflxRShkxRBHPNbqvULk081IJZ6MxLzrhMyZ8sVz41bguuemhbGLwQpLWleyFM0WHQKEV0RdrEGs2G0J62x1TVMQc8tigXMU1jOxzd/MPiaHsAy3oIfeFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730652801; c=relaxed/simple;
	bh=D3eFYkPTuifDJnIZDQ/qRbgOsV3FdN2FZnPucJ9+me0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MpoD3so6ZYvlsJa7Uesz5uKGhaoGRQj3BqYqaSBln9MfwD94jONhEhlJ7bJXB/8Hh3hU7HDc6VVqW3DUHlPsZTcvsyJZfP7xenGGcv6nMI3hMsOgbitsolD7StVZ+x6B3kaIzXEMl0Rmmi5bY6Q+1zNRw8V4hhLrHezmL+mR9g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RooQ2uSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4670FC4CECD;
	Sun,  3 Nov 2024 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730652800;
	bh=D3eFYkPTuifDJnIZDQ/qRbgOsV3FdN2FZnPucJ9+me0=;
	h=From:To:Cc:Subject:Date:From;
	b=RooQ2uSe5D+5I9pqVTc+Zq2pZMHUPxAQpTICqBZ9/3lRcNovr1VxdbQno9gxrsa7z
	 qKhYYT6cJ7t6VqYb+bZbg+LIYtIqDc6kFiSCzNIEHCbMXQYE1Ag4IaRuTX/0KV5JXL
	 ssBruwDsSKxcvFCXKCeRBgRLhW08M8lpB+RNd01XuXo4PF5n8lWAFXuOhxytRGS8GW
	 0ObYED+fgN+zH3u3sF2RAOny4y/x6halgyPpULnT80bKzj2dIp95TKyKvdQFX+6I5g
	 Kf71bfb5NYtx+xLzaaXG4c2JeURh7Dg/0DaGLvS8qjMLZEaJ0ZkfxvLR81S9GnMTrC
	 EnxRHMj42+LXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com
Subject: [PATCH net-next] tools: ynl-gen: de-kdocify enums with no doc for entries
Date: Sun,  3 Nov 2024 08:53:14 -0800
Message-ID: <20241103165314.1631237-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes the names of the enum entries are self-explanatory
or come from standards. Forcing authors to write trivial kdoc
for each of such entries seems unreasonable, but kdoc would
complain about undocumented entries.

Detect enums which only have documentation for the entire
type and no documentation for entries. Render their doc
as a plain comment.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: vadim.fedorenko@linux.dev
CC: arkadiusz.kubalewski@intel.com
CC: jiri@resnulli.us
CC: donald.hunter@gmail.com
---
 include/uapi/linux/dpll.h   | 14 +++++++-------
 tools/net/ynl/lib/nlspec.py |  3 +++
 tools/net/ynl/ynl-gen-c.py  | 14 +++++++++-----
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 2b7ec2da4bcc..bf97d4b6d51f 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -79,13 +79,13 @@ enum dpll_lock_status_error {
 	DPLL_LOCK_STATUS_ERROR_MAX = (__DPLL_LOCK_STATUS_ERROR_MAX - 1)
 };
 
-/**
- * enum dpll_clock_quality_level - level of quality of a clock device. This
- *   mainly applies when the dpll lock-status is DPLL_LOCK_STATUS_HOLDOVER. The
- *   current list is defined according to the table 11-7 contained in ITU-T
- *   G.8264/Y.1364 document. One may extend this list freely by other ITU-T
- *   defined clock qualities, or different ones defined by another
- *   standardization body (for those, please use different prefix).
+/*
+ * level of quality of a clock device. This mainly applies when the dpll
+ * lock-status is DPLL_LOCK_STATUS_HOLDOVER. The current list is defined
+ * according to the table 11-7 contained in ITU-T G.8264/Y.1364 document. One
+ * may extend this list freely by other ITU-T defined clock qualities, or
+ * different ones defined by another standardization body (for those, please
+ * use different prefix).
  */
 enum dpll_clock_quality_level {
 	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_PRC = 1,
diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index b6d6f8aef423..a745739655ad 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -131,6 +131,9 @@ jsonschema = None
     def has_doc(self):
         if 'doc' in self.yaml:
             return True
+        return self.has_entry_doc()
+
+    def has_entry_doc(self):
         for entry in self.entries.values():
             if entry.has_doc():
                 return True
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index aa22eb092475..c48b69071111 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2437,11 +2437,15 @@ _C_KW = {
             enum = family.consts[const['name']]
 
             if enum.has_doc():
-                cw.p('/**')
-                doc = ''
-                if 'doc' in enum:
-                    doc = ' - ' + enum['doc']
-                cw.write_doc_line(enum.enum_name + doc)
+                if enum.has_entry_doc():
+                    cw.p('/**')
+                    doc = ''
+                    if 'doc' in enum:
+                        doc = ' - ' + enum['doc']
+                    cw.write_doc_line(enum.enum_name + doc)
+                else:
+                    cw.p('/*')
+                    cw.write_doc_line(enum['doc'], indent=False)
                 for entry in enum.entries.values():
                     if entry.has_doc():
                         doc = '@' + entry.c_name + ': ' + entry['doc']
-- 
2.47.0


