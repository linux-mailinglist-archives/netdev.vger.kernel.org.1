Return-Path: <netdev+bounces-76757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7853186ECA0
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 00:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D0028802C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 23:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0014B5EE8E;
	Fri,  1 Mar 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnEDAvW1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA35EE87
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334352; cv=none; b=fWpLPdWRxJgHlRDiRf5QW50kAhnZe6NmZE68ZEZo44pd0BWGO2rhWpamaMoXNE3EH+9kbVhzQhdtXXdYDH7k1YYB9JkLY5lTrt91v2rLbXFY/cRCHzirAl4qUfjFWbC87f72QvqsRZ5xUMK6vFsmkSm9OBCYJDFFOy42z2DVj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334352; c=relaxed/simple;
	bh=R79Jbbmzra6Cjtq8MYHP5ttSVah2jSDgzWPs1rikcWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVA+wrb9f0lsVw1rR7GIcuQ/X7JdPiNrbcVpoObptPwXgRKDtxi6up+kAzjo9f3ENWy62YokvEc8TLSFK9E46UcSlS05cvMLkpl0+OrQ2G2suUsNIhvoeiusq1YaQyBGxgD0Rlm0oxRZsduhGO2UzTOO/a3YQ78tJnf0ei25eQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnEDAvW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28952C43394;
	Fri,  1 Mar 2024 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709334352;
	bh=R79Jbbmzra6Cjtq8MYHP5ttSVah2jSDgzWPs1rikcWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnEDAvW1cgiXJvJvduBqkCSTdZoXmyObuTyS1wvmD4jnAdJ/5j00MLZuryfc6wxbu
	 Lxrm+0eiaMDkPHM1NUm4DxkSj3OaMQ7HbWm69DS1sXgL6vJD1d+52kjPPaCbzSiFUm
	 vFXA4wFLICrgd9eORLOirK2NvA9LwsU5vHiGrS7bwPpJCfQyNwSPtvHI5xbMFlCJ3X
	 6pu/Z+cJRpOw60qDUzPDHYhTGU9iCfC7IWhAaZPcnnZJtWSBzaCyan2bMtljhO0rOr
	 y3KHeV8I/0G0guUZUEd8/ujuEgBGqKeKcT1qpCbtCnpfqpYCrkEbTzzoaPqIrkEunf
	 WjTfG1w4Vk1Xg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] tools: ynl: allow setting recv() size
Date: Fri,  1 Mar 2024 15:05:40 -0800
Message-ID: <20240301230542.116823-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301230542.116823-1-kuba@kernel.org>
References: <20240301230542.116823-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the size of the buffer we use for recv() configurable.
The details of the buffer sizing in netlink are somewhat
arcane, we could spend a lot of time polishing this API.
Let's just leave some hopefully helpful comments for now.
This is a for-developers-only feature, anyway.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 92ade9105f31..bc5a526dbb99 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -84,6 +84,10 @@ from .nlspec import SpecFamily
     return f"Netlink error: {os.strerror(-self.nl_msg.error)}\n{self.nl_msg}"
 
 
+class ConfigError(Exception):
+    pass
+
+
 class NlAttr:
     ScalarFormat = namedtuple('ScalarFormat', ['native', 'big', 'little'])
     type_formats = {
@@ -400,7 +404,8 @@ genl_family_name_to_id = None
 
 
 class YnlFamily(SpecFamily):
-    def __init__(self, def_path, schema=None, process_unknown=False):
+    def __init__(self, def_path, schema=None, process_unknown=False,
+                 recv_size=131072):
         super().__init__(def_path, schema)
 
         self.include_raw = False
@@ -423,6 +428,16 @@ genl_family_name_to_id = None
         self.async_msg_ids = set()
         self.async_msg_queue = []
 
+        # Note that netlink will use conservative (min) message size for
+        # the first dump recv() on the socket, our setting will only matter
+        # from the second recv() on.
+        self._recv_size = recv_size
+        # Netlink will always allocate at least PAGE_SIZE - sizeof(skb_shinfo)
+        # for a message, so smaller receive sizes will lead to truncation.
+        # Note that the min size for other families may be larger than 4k!
+        if self._recv_size < 4000:
+            raise ConfigError()
+
         for msg in self.msgs.values():
             if msg.is_async:
                 self.async_msg_ids.add(msg.rsp_value)
@@ -799,7 +814,7 @@ genl_family_name_to_id = None
     def check_ntf(self):
         while True:
             try:
-                reply = self.sock.recv(128 * 1024, socket.MSG_DONTWAIT)
+                reply = self.sock.recv(self._recv_size, socket.MSG_DONTWAIT)
             except BlockingIOError:
                 return
 
@@ -854,7 +869,7 @@ genl_family_name_to_id = None
         done = False
         rsp = []
         while not done:
-            reply = self.sock.recv(128 * 1024)
+            reply = self.sock.recv(self._recv_size)
             nms = NlMsgs(reply, attr_space=op.attr_set)
             for nl_msg in nms:
                 if nl_msg.extack:
-- 
2.44.0


