Return-Path: <netdev+bounces-234118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9967AC1CC7F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CD054E0553
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD6E3563C1;
	Wed, 29 Oct 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDywUxIv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6152F746C;
	Wed, 29 Oct 2025 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762683; cv=none; b=CiRByYiAxKeH7m/luk0Lv+BxTFz8SS5w0sbW3fe2+xgeXade66mMJoT6wXvGxd1Ilz8EzpOrtFuBDJuNFZ1Jae0Tw7CE+qKtGTcQ2Ch9j3L0Bt1p7xmc/LklU6onwWawcmloEy3cTOVxnd55FP+IvPQHT8+0AUKS2decpXzbnDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762683; c=relaxed/simple;
	bh=rFbi7t1GmGErUNK4uhpTSb/Y5veEcgHn+WO9PSvt4aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kKxPwmGFYJnsgUcHXkpz+vioopAyGbGfZOU7vTv9HYDfHAucisSligKnnAryk6bTHxf6JnChdocJ4mbUQXvQ7a7YF44mKUATn2NIT16TQiQUyeGWNLLVQ6J4tRYdeIR8hSbK1lkCngFdkRp2TX74iFARFTUuJq6CFZsmkvVX3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDywUxIv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761762681; x=1793298681;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=rFbi7t1GmGErUNK4uhpTSb/Y5veEcgHn+WO9PSvt4aA=;
  b=YDywUxIv/YG8VrlA6K4W0r75L6yk3nCilw4E1UE79gdK265kI8tO4LXR
   xDiZXgMo3h1yPbXQ8FI9uxRpOkHcdOrAPSMP5s/3YjNhaGmQLUX687Ddw
   Nf/quyGomHtJUv77SBOrReE6P4zlzanGjBdF1EcEZ4Jf4d2FdEcMYG8BV
   SzFUOPBwEbNhYEs0G62nLf6D1gCVpRu8fLKnRuRnEcuebt2GU7/XFCII+
   i5sDen7TueUaXgVeeoAlqtdad61TLQ5fM+R4z8stzzUHYxGS5B0BqyzQS
   lMchskk89Q+17oY5+labOUdmdUpUphse9dg1rgcNJXPoHHbzD6Zehi0Nn
   A==;
X-CSE-ConnectionGUID: zno6siMITMeymPguEQ/iZw==
X-CSE-MsgGUID: BwvMySZzThOnZ7SckLUg5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75343141"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75343141"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 11:31:20 -0700
X-CSE-ConnectionGUID: aiKdA1VnQpiY3f64HthNUw==
X-CSE-MsgGUID: NMPSGFOARG6RC3ANIEG+1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="185668954"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 11:31:21 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 29 Oct 2025 11:30:42 -0700
Subject: [PATCH] docs: kdoc: fix duplicate section warning message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
X-B4-Tracking: v=1; b=H4sIAFNdAmkC/x2NwQ6CMBAFf4Xs2U2gBhR/xXCo7RNXyEK2oCaEf
 7fhOIeZ2SjBBIluxUaGjySZNEN1Kii8vPZgiZnJla6uStfye+Cn/HiAKUaOU+C4zqMEv4ANy2r
 KX28q2vMj1hf4cxsad6UcnA1ZPWb3bt//SlpusHwAAAA=
X-Change-ID: 20251029-jk-fix-kernel-doc-duplicate-return-warning-bd57ea39c628
To: Jonathan Corbet <corbet@lwn.net>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=6136;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=rFbi7t1GmGErUNK4uhpTSb/Y5veEcgHn+WO9PSvt4aA=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkym2Aqx+4q9WwLWZF36V7T50JoZsrJsaxZXfjL+P9Nn0
 4+dJ3vqOkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZjIlWCGv6LvjVh5nO8Jb5ta
 93aKqlfqrGXnatWce5xXHTpy9fXpd7EMPxnP2nDGzDVy61r0x3/C44JTj8znTE2xm7u2b/uz/Nu
 iFewA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The python version of the kernel-doc parser emits some strange warnings
with just a line number in certain cases:

$ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
Warning: 174
Warning: 184
Warning: 190
Warning: include/linux/virtio_config.h:226 No description found for return value of '__virtio_test_bit'
Warning: include/linux/virtio_config.h:259 No description found for return value of 'virtio_has_feature'
Warning: include/linux/virtio_config.h:283 No description found for return value of 'virtio_has_dma_quirk'
Warning: include/linux/virtio_config.h:392 No description found for return value of 'virtqueue_set_affinity'

I eventually tracked this down to the lone call of emit_msg() in the
KernelEntry class, which looks like:

  self.emit_msg(self.new_start_line, f"duplicate section name '{name}'\n")

This looks like all the other emit_msg calls. Unfortunately, the definition
within the KernelEntry class takes only a message parameter and not a line
number. The intended message is passed as the warning!

Pass the filename to the KernelEntry class, and use this to build the log
message in the same way as the KernelDoc class does.

To avoid future errors, mark the warning parameter for both emit_msg
definitions as a keyword-only argument. This will prevent accidentally
passing a string as the warning parameter in the future.

Also fix the call in dump_section to avoid an unnecessary additional
newline.

Fixes: e3b42e94cf10 ("scripts/lib/kdoc/kdoc_parser.py: move kernel entry to a class")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
We recently discovered this while working on some netdev text
infrastructure. All of the duplicate section warnings are not being logged
properly, which was confusing the warning comparison logic we have for
testing patches in NIPA.

This appears to have been caused by the optimizations in:
https://lore.kernel.org/all/cover.1745564565.git.mchehab+huawei@kernel.org/

Before this fix:
$ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
Warning: 174
Warning: 184
Warning: 190
Warning: include/linux/virtio_config.h:226 No description found for return value of '__virtio_test_bit'
Warning: include/linux/virtio_config.h:259 No description found for return value of 'virtio_has_feature'
Warning: include/linux/virtio_config.h:283 No description found for return value of 'virtio_has_dma_quirk'
Warning: include/linux/virtio_config.h:392 No description found for return value of 'virtqueue_set_affinity'

After this fix:
$ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
Warning: include/linux/virtio_config.h:174 duplicate section name 'Return'
Warning: include/linux/virtio_config.h:184 duplicate section name 'Return'
Warning: include/linux/virtio_config.h:190 duplicate section name 'Return'
Warning: include/linux/virtio_config.h:226 No description found for return value of '__virtio_test_bit'
Warning: include/linux/virtio_config.h:259 No description found for return value of 'virtio_has_feature'
Warning: include/linux/virtio_config.h:283 No description found for return value of 'virtio_has_dma_quirk'
Warning: include/linux/virtio_config.h:392 No description found for return value of 'virtqueue_set_affinity'
---
 scripts/lib/kdoc/kdoc_parser.py | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 2376f180b1fa..2acf9f6e5c35 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -254,7 +254,7 @@ SECTION_DEFAULT = "Description"  # default section
 
 class KernelEntry:
 
-    def __init__(self, config, ln):
+    def __init__(self, config, fname, ln):
         self.config = config
 
         self._contents = []
@@ -274,6 +274,8 @@ class KernelEntry:
 
         self.leading_space = None
 
+        self.fname = fname
+
         # State flags
         self.brcount = 0
         self.declaration_start_line = ln + 1
@@ -288,9 +290,11 @@ class KernelEntry:
         return '\n'.join(self._contents) + '\n'
 
     # TODO: rename to emit_message after removal of kernel-doc.pl
-    def emit_msg(self, log_msg, warning=True):
+    def emit_msg(self, ln, msg, *, warning=True):
         """Emit a message"""
 
+        log_msg = f"{self.fname}:{ln} {msg}"
+
         if not warning:
             self.config.log.info(log_msg)
             return
@@ -336,7 +340,7 @@ class KernelEntry:
                 # Only warn on user-specified duplicate section names
                 if name != SECTION_DEFAULT:
                     self.emit_msg(self.new_start_line,
-                                  f"duplicate section name '{name}'\n")
+                                  f"duplicate section name '{name}'")
                 # Treat as a new paragraph - add a blank line
                 self.sections[name] += '\n' + contents
             else:
@@ -387,15 +391,15 @@ class KernelDoc:
             self.emit_msg(0,
                           'Python 3.7 or later is required for correct results')
 
-    def emit_msg(self, ln, msg, warning=True):
+    def emit_msg(self, ln, msg, *, warning=True):
         """Emit a message"""
 
-        log_msg = f"{self.fname}:{ln} {msg}"
-
         if self.entry:
-            self.entry.emit_msg(log_msg, warning)
+            self.entry.emit_msg(ln, msg, warning=warning)
             return
 
+        log_msg = f"{self.fname}:{ln} {msg}"
+
         if warning:
             self.config.log.warning(log_msg)
         else:
@@ -440,7 +444,7 @@ class KernelDoc:
         variables used by the state machine.
         """
 
-        self.entry = KernelEntry(self.config, ln)
+        self.entry = KernelEntry(self.config, self.fname, ln)
 
         # State flags
         self.state = state.NORMAL

---
base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
change-id: 20251029-jk-fix-kernel-doc-duplicate-return-warning-bd57ea39c628

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


