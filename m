Return-Path: <netdev+bounces-233296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACBCC113DB
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 20:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01088565540
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6E31CA4E;
	Mon, 27 Oct 2025 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUd27wGY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0056E322A04
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593407; cv=none; b=qFNE5Q8Qu0p9pN96vhWRjV0I9+Q5fP0X8hJPzMKNfz6007N66Gu/Hk3TbLoSGY9AUR3089NCwoyVQznSct4WlQyHkBc1I0YGpcKRy1ws79u5RKc12JA4pTp9h9N1gt26Pu+e+Sfw3haIVjKid5O6LR79u4ijoCnuCAHHIYrDg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593407; c=relaxed/simple;
	bh=t2TOiBIkhd1uKqzPmt1GX46rx4bd/kAxHrtp7CTkebE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kv0d+1+1mmPLP05zfLY6kfphIS1Br1iNF6Gms9OGP/OUCSCYqtMMtfgW5TDbHJ5LpRev2BsxgZoPM95TzCoCHBbImIGyPBIwsb3H06FzqO6/WCGVHPrnAFsajp5W6+vG4Yi0NEkrPTU9oAY+s6Iz555yPm6CvweqwdvKQ8zMvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUd27wGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F034C4CEF1;
	Mon, 27 Oct 2025 19:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761593404;
	bh=t2TOiBIkhd1uKqzPmt1GX46rx4bd/kAxHrtp7CTkebE=;
	h=From:To:Cc:Subject:Date:From;
	b=nUd27wGYOpq4VGYXnSR1dAOnUFm8Fm/+OJu24TueXX/XgcSpE1bPhU8Iv3BUNdZzY
	 ia82rfVzKKDkfvD7rw1/eaTHXHq8hayyLFH5kOVP03bUSpVRV5On5UhCCw4WvSFnGy
	 kAVhI4v543A+RrgWY2X5Jn1sNSCRIoDh2IYYeh7+9bXD/piM97IqW2LgK+4lu3VEaR
	 QGFLDglUNBodJlysoaqlrNXjHuI9ET0KrAOWGJPvMsdskGD5iyVROoZcgqLyAq5QMl
	 6vDtPKn9acNjiWkE3ZQHRNC5uUhNnZ1Mnhz9aoYf6vxz4Ts7PP3oZKs8SyYmYwPleh
	 9tojvSoHhgXhQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	ast@fiberby.net
Subject: [PATCH net-next v2 1/2] tools: ynl: fix indent issues in the main Python lib
Date: Mon, 27 Oct 2025 12:29:57 -0700
Message-ID: <20251027192958.2058340-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Class NlError() and operation_do_attributes() are indented by 2 spaces
rather than 4 spaces used by the rest of the file.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - new patch

CC: donald.hunter@gmail.com
CC: ast@fiberby.net
---
 tools/net/ynl/pyynl/lib/ynl.py | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 62383c70ebb9..bdcc4f031d39 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -100,12 +100,12 @@ from .nlspec import SpecFamily
                                   'bitfield32', 'sint', 'uint'])
 
 class NlError(Exception):
-  def __init__(self, nl_msg):
-    self.nl_msg = nl_msg
-    self.error = -nl_msg.error
+    def __init__(self, nl_msg):
+        self.nl_msg = nl_msg
+        self.error = -nl_msg.error
 
-  def __str__(self):
-    return f"Netlink error: {os.strerror(self.error)}\n{self.nl_msg}"
+    def __str__(self):
+        return f"Netlink error: {os.strerror(self.error)}\n{self.nl_msg}"
 
 
 class ConfigError(Exception):
@@ -1039,15 +1039,15 @@ genl_family_name_to_id = None
                     self.check_ntf()
 
     def operation_do_attributes(self, name):
-      """
-      For a given operation name, find and return a supported
-      set of attributes (as a dict).
-      """
-      op = self.find_operation(name)
-      if not op:
-        return None
+        """
+        For a given operation name, find and return a supported
+        set of attributes (as a dict).
+        """
+        op = self.find_operation(name)
+        if not op:
+            return None
 
-      return op['do']['request']['attributes'].copy()
+        return op['do']['request']['attributes'].copy()
 
     def _encode_message(self, op, vals, flags, req_seq):
         nl_flags = Netlink.NLM_F_REQUEST | Netlink.NLM_F_ACK
-- 
2.51.0


