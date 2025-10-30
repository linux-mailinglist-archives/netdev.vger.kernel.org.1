Return-Path: <netdev+bounces-234503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30293C2219D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 20:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D564A3A2B14
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 19:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB360332ECC;
	Thu, 30 Oct 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbHVe6//"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1842333440;
	Thu, 30 Oct 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854325; cv=none; b=HumguV1m8a3lHfTl78em8A6PdDgV5YO6yhFnLTSbBwEQ2fuPQpJqHg04m4ClUFUumwZrLRiR0TrU9CIWWh9c3EdCtqjx81FzGn3Zuz3oo0tPA4Ir0sVSQi0ij3OSybWuSwxXyeeRMtiwpYj8pRbWo0tDFlE9IVKmmYyFhHbybb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854325; c=relaxed/simple;
	bh=gX0eYm6yHbhuq2jgqmTjz7o0HFpQFtUjRWVy79LpAqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=orPVZ2PaCLcyl1BRRcyziBXBgFKH8oKiX5KfPyBXBnDMrKLKMt0AVINqjHDEJ14nVMqQdkwhwXwMnhZOQ8rI0C5vx7BF7f0rntY/KJAJpi29ztxc9G9A+LtOa5/k1cG9T2NYLp3UpPjKKwYwUdniFdBlVW+oaRt5TdgM/Ac7MtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbHVe6//; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761854324; x=1793390324;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=gX0eYm6yHbhuq2jgqmTjz7o0HFpQFtUjRWVy79LpAqo=;
  b=TbHVe6//3DnwIDhbDKpniNRaT16s79pRCVlSMKuPHuy+V3CBsN4iw6H1
   rcU6PmJoFbX7fzddOP5y/OnISETyd67IYiCdXrVK2ArUyfDDK5ue6n0YZ
   EQZpMJwy91SjrFbIkOHOKoEItUIpzgkF1HsT1t0YR2RQ7qxg+5FwNyMBF
   h/xe4iZvJGjmo13df4YsO7vpd9eS2juHx2V9upqb2FUUf83xRf0TxJT3v
   jHOHGTSByfn1jfxTCC0UyWGlauQqBcei7FHy5lEW2wRm10FPpW5QLlaPz
   DgK853J1d7aqrY0vFrp2dQbtuAFj1iOqbAco+vxPY+YzJVJRS7S/NHIx2
   A==;
X-CSE-ConnectionGUID: yGeOpAgdS+OtxZXF0L54eg==
X-CSE-MsgGUID: qnANKxWXSv6MuRVGrz+MzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64159368"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="64159368"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:58:43 -0700
X-CSE-ConnectionGUID: sTbGkBz8SJaolOUPAMb6vg==
X-CSE-MsgGUID: QcVpFbzCTJWRayLCOEXSXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="190390693"
Received: from unknown (HELO orcnseosdtnuc.amr.corp.intel.com) ([10.166.241.20])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:58:44 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Oct 2025 12:58:32 -0700
Subject: [PATCH v2] docs: kdoc: fix duplicate section warning message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-jk-fix-kernel-doc-duplicate-return-warning-v2-1-ec4b5c662881@intel.com>
X-B4-Tracking: v=1; b=H4sIAGfDA2kC/52NQQ6CMBBFr2K6dgwtouDKexgWpR1hBFsyLagh3
 N3KEVy+n/z3FhGQCYO47BbBOFMg7xKo/U6YTrsWgWxioTJVyExV8OjhTm/okR0OYL0BO40DGR0
 RGOPEDl6aHbkWGlucUeeVOalSJOHImK5b7FYn7ihEz5+tPcvf+ldmliBBlWiLskGTZ8cruYjDw
 finqNd1/QJs8b7Z5AAAAA==
X-Change-ID: 20251029-jk-fix-kernel-doc-duplicate-return-warning-bd57ea39c628
To: Jonathan Corbet <corbet@lwn.net>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-782a1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5810;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=gX0eYm6yHbhuq2jgqmTjz7o0HFpQFtUjRWVy79LpAqo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzmw8XXVA9e+/v6pP5fbsUHB45UZy9fki0fH8If/UP3m
 sD6Td/yO0pZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZhI7C6G/66NFe+qtly4dXhl
 jYFWkb95x87XfxPik6PXKm7/8PTn+bMM/7PFl7+50TFH9rPeWi2pHJeKqy+805jaXgpeL1gYcaT
 alQsA
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
Changes in v2:
- Rebased onto docs-next from git://git.lwn.net/linux.git
- Link to v1: https://patch.msgid.link/20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com
---
 scripts/lib/kdoc/kdoc_parser.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 6e5c115cbdf3..ee1a4ea6e725 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -275,6 +275,8 @@ class KernelEntry:
 
         self.leading_space = None
 
+        self.fname = fname
+
         # State flags
         self.brcount = 0
         self.declaration_start_line = ln + 1
@@ -289,9 +291,11 @@ class KernelEntry:
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
@@ -337,7 +341,7 @@ class KernelEntry:
                 # Only warn on user-specified duplicate section names
                 if name != SECTION_DEFAULT:
                     self.emit_msg(self.new_start_line,
-                                  f"duplicate section name '{name}'\n")
+                                  f"duplicate section name '{name}'")
                 # Treat as a new paragraph - add a blank line
                 self.sections[name] += '\n' + contents
             else:
@@ -393,15 +397,15 @@ class KernelDoc:
                           'Python 3.7 or later is required for correct results')
             python_warning = True
 
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

---
base-commit: b4ff1f611b00b94792988cff794124fa3c2ae8f8
change-id: 20251029-jk-fix-kernel-doc-duplicate-return-warning-bd57ea39c628

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


