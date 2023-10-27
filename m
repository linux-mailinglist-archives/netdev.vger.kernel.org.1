Return-Path: <netdev+bounces-44897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3404A7DA37E
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F8C2824D4
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC523D998;
	Fri, 27 Oct 2023 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm1TUIJh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430A405E9
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9875FC433C8;
	Fri, 27 Oct 2023 22:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698446052;
	bh=/vFBRcijZbBGOxe89h/NyRV9oxAUvw3cMTba9cML1uQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Lm1TUIJhzUHCdygn49AWJpeCLsJhTqcNZrb+kQNXT3jQmUAypIQB/MRF0QFNWicuO
	 DeseaDMhp5iVXtrQcpqTBdWEceWhdrMGDfbNJHIjf4lAAIO7kbS36g4GswL11pW2Zb
	 ogNWr5fmpvEsBAy/ymHySyMDv8Q16CDeCpd0SzOQH1/t8S0tGuVitx2sECSDoBqgyI
	 Qu7n0/SOu8OC1Td5/H96i+cVkaRbHdmBZs9NdxXwRF30hCNa+7BJAwG07qgCLawtOl
	 z5yZJlp3DD153A1jS9aXAB/LhKalIJdZIkoBdS5ADZUUYauqLozeeLmUz72Z9tsCT/
	 vZzxd899T6iOg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] tools: ynl-gen: don't touch the output file if content is the same
Date: Fri, 27 Oct 2023 15:34:08 -0700
Message-ID: <20231027223408.1865704-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I often regenerate all YNL files in the tree to make sure they
are in sync with the codegen and specs. Generator rewrites
the files unconditionally, so since make looks at file modification
time to decide what to rebuild - my next build takes longer.

We already generate the code to a tempfile most of the time,
only overwrite the target when we have to.

Before:

  $ stat include/uapi/linux/netdev.h
    File: include/uapi/linux/netdev.h
    Size: 2307      	Blocks: 8          IO Block: 4096   regular file
  Access: 2023-10-27 15:19:56.347071940 -0700
  Modify: 2023-10-27 15:19:45.089000900 -0700
  Change: 2023-10-27 15:19:45.089000900 -0700
   Birth: 2023-10-27 15:19:45.088000894 -0700

  $ ./tools/net/ynl/ynl-regen.sh -f
  [...]

  $ stat include/uapi/linux/netdev.h
    File: include/uapi/linux/netdev.h
    Size: 2307      	Blocks: 8          IO Block: 4096   regular file
  Access: 2023-10-27 15:19:56.347071940 -0700
  Modify: 2023-10-27 15:22:18.417968446 -0700
  Change: 2023-10-27 15:22:18.417968446 -0700
   Birth: 2023-10-27 15:19:45.088000894 -0700

After:

  $ stat include/uapi/linux/netdev.h
    File: include/uapi/linux/netdev.h
    Size: 2307      	Blocks: 8          IO Block: 4096   regular file
  Access: 2023-10-27 15:22:41.520114221 -0700
  Modify: 2023-10-27 15:22:18.417968446 -0700
  Change: 2023-10-27 15:22:18.417968446 -0700
   Birth: 2023-10-27 15:19:45.088000894 -0700

  $ ./tools/net/ynl/ynl-regen.sh -f
  [...]

  $ stat include/uapi/linux/netdev.h
    File: include/uapi/linux/netdev.h
    Size: 2307      	Blocks: 8          IO Block: 4096   regular file
  Access: 2023-10-27 15:22:41.520114221 -0700
  Modify: 2023-10-27 15:22:18.417968446 -0700
  Change: 2023-10-27 15:22:18.417968446 -0700
   Birth: 2023-10-27 15:19:45.088000894 -0700

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 13427436bfb7..c4003a83cd5d 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -3,6 +3,7 @@
 
 import argparse
 import collections
+import filecmp
 import os
 import re
 import shutil
@@ -1168,7 +1169,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if out_file is None:
             self._out = os.sys.stdout
         else:
-            self._out = tempfile.TemporaryFile('w+')
+            self._out = tempfile.NamedTemporaryFile('w+')
             self._out_file = out_file
 
     def __del__(self):
@@ -1177,6 +1178,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def close_out_file(self):
         if self._out == os.sys.stdout:
             return
+        # Avoid modifying the file if contents didn't change
+        self._out.flush()
+        if os.path.isfile(self._out_file) and filecmp.cmp(self._out.name, self._out_file, shallow=False):
+            return
         with open(self._out_file, 'w+') as out_file:
             self._out.seek(0)
             shutil.copyfileobj(self._out, out_file)
-- 
2.41.0


