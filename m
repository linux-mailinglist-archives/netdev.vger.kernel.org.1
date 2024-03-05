Return-Path: <netdev+bounces-77348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FBF87154A
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2370A1C21179
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E175A4C4;
	Tue,  5 Mar 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvr2UQ9G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A024C637
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616796; cv=none; b=cbaq5O40dSSfGYmG0uGxqRfNUqNw7arvO1oLGUNrXADwOvOYeMP5TrKNh5go+cFHKpXpS6rd7ljVpn727y1KTm0I83RNzpiPrCozr8zB3tYfvIu39dIEbRuEKlCdJz/GpbsHj18mulht1ayb4NlrTnB77gZ4WagQVKbsodOo5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616796; c=relaxed/simple;
	bh=vlXNscYVmI9A9o6+mBNrH59tYt31nVVZDVGvFZFv1v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GM6mLw5tKVJFdcAc81YDaugNJr0necbZe/JnLtmZpGT39YEVITYGejRfKA4qXJ+zadd3f90U47duh/F4ZaXKSDHG9js5Eh4M3xqeRcOT/AQg9UZejTuRG7ffcBbsrZvC716FXf98nvEVQnH7FIv+jDoUMNk5t9VATW2AuwJcotc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvr2UQ9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770ADC43390;
	Tue,  5 Mar 2024 05:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709616795;
	bh=vlXNscYVmI9A9o6+mBNrH59tYt31nVVZDVGvFZFv1v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvr2UQ9G1LFU5nPesP5/Zbl2LqNWFD3+tqXGzVnn3yY1/GsN+9q52+2NMuA2CEqY9
	 EB2REYFcr62PmWWKQ+lAQfTfmBHrpb0x0u4y3a2JLeHtHj7IPlJijEAamfGffaGhEw
	 FkuihKQxc2aDPyx0PFmrlyzkKiUMLiPo8OBybLhJTqhb4AxZrOieVB8bBJ/BPeGsaD
	 5SIKpzJVSiNdmTAWMX0MB6JiRHeMO8tDgazYs1tBUVVEiAAIDaO63QvQfLiQjCFzmY
	 Q/PCmO9+bJR5zZNmP7yYO3yQPmuDV8eHsZDqLHa8hTNqWT6we9l3YXKWerxwgvzNar
	 20COouxczjm2Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/4] tools: ynl: allow setting recv() size
Date: Mon,  4 Mar 2024 21:33:08 -0800
Message-ID: <20240305053310.815877-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305053310.815877-1-kuba@kernel.org>
References: <20240305053310.815877-1-kuba@kernel.org>
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
v2:
 - move the handling somewhere a bit more sensible
 - use 0 as default, and if to set it
---
 tools/net/ynl/lib/ynl.py | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 92ade9105f31..c3ff5be33e4e 100644
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
+                 recv_size=0):
         super().__init__(def_path, schema)
 
         self.include_raw = False
@@ -415,6 +420,16 @@ genl_family_name_to_id = None
         except KeyError:
             raise Exception(f"Family '{self.yaml['name']}' not supported by the kernel")
 
+        # Note that netlink will use conservative (min) message size for
+        # the first dump recv() on the socket, our setting will only matter
+        # from the second recv() on.
+        self._recv_size = recv_size if recv_size else 131072
+        # Netlink will always allocate at least PAGE_SIZE - sizeof(skb_shinfo)
+        # for a message, so smaller receive sizes will lead to truncation.
+        # Note that the min size for other families may be larger than 4k!
+        if self._recv_size < 4000:
+            raise ConfigError()
+
         self.sock = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, self.nlproto.proto_num)
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_CAP_ACK, 1)
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_EXT_ACK, 1)
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


