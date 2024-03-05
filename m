Return-Path: <netdev+bounces-77349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E4187154B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813721C212BD
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E73F7AE56;
	Tue,  5 Mar 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahsoD4y8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D879927
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616796; cv=none; b=j07TkSqua/I8NIkwRqkK115w6lxVUXSnpM//f/3XIpAYiFhOBXTa+TDY0oq6sDa5nIjbsdm/U4S780edxwc5zMODC6LxXw3jLQF5xoljnAgxAGaooxByxStRQeuFvYIdRMFSzAjrXvOa+HZoMcwGG3NkHD1hOacNdaYu9iNZnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616796; c=relaxed/simple;
	bh=Z5tGXdIJBb5HUThHoPBFEbgFQ2DtdDvWugcWnNPAJ9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbkKm6lbgUT/Nzgg2rcOOHVu5V05PCbJuBbvRoHL2KFFsxgoNDmL0ehAhygQFycrIM1sQLXJu8k3nXwfxIZqy5KkGsEmyLZqGwUq1+jjLB/jNzyoERRjaJUgdmYX8QdT3UkmqMhqobmU0fTJ2cBHCFKTItlCZ0Tkr0pJLtAI2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahsoD4y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04293C433F1;
	Tue,  5 Mar 2024 05:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709616796;
	bh=Z5tGXdIJBb5HUThHoPBFEbgFQ2DtdDvWugcWnNPAJ9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahsoD4y8HIk5uv7qO7v4IV2SyGAeZqZQEnGYSdaAXM3+zebWznku4L4/alTkEA1Vf
	 w0gclSMyKgxPyda3qN1Ho91t9VuYHSZ9G6r5Y62EVW9pGAv/xNVfv4zNcTm6ayB/jz
	 JGlQd1/ImwQlQq9hFLn29L2C3JPCtx0lzCcDMEK3e69clElRlvfE7lHKBsvBaVbJH7
	 MAZJvXVEBpMxZzYFOULMSANoYVMiR6abJqdy75AOpP5FiA5Owa0PoraUNKRdD8543V
	 /6aJAqHr8sBUoWXR3ac0+PKlwmsVN5a/dTFyvrPQiwdEPF40Jc7Hy2wIsPdjn3u55y
	 wsQ+3H+iBMrgA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/4] tools: ynl: support debug printing messages
Date: Mon,  4 Mar 2024 21:33:09 -0800
Message-ID: <20240305053310.815877-4-kuba@kernel.org>
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

For manual debug, allow printing the netlink level messages
to stderr.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index c3ff5be33e4e..239e22b7a85f 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -7,6 +7,7 @@ import random
 import socket
 import struct
 from struct import Struct
+import sys
 import yaml
 import ipaddress
 import uuid
@@ -420,6 +421,7 @@ genl_family_name_to_id = None
         except KeyError:
             raise Exception(f"Family '{self.yaml['name']}' not supported by the kernel")
 
+        self._recv_dbg = False
         # Note that netlink will use conservative (min) message size for
         # the first dump recv() on the socket, our setting will only matter
         # from the second recv() on.
@@ -453,6 +455,17 @@ genl_family_name_to_id = None
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
+    def set_recv_dbg(self, enabled):
+        self._recv_dbg = enabled
+
+    def _recv_dbg_print(self, reply, nl_msgs):
+        if not self._recv_dbg:
+            return
+        print("Recv: read", len(reply), "bytes,",
+              len(nl_msgs.msgs), "messages", file=sys.stderr)
+        for nl_msg in nl_msgs:
+            print("  ", nl_msg, file=sys.stderr)
+
     def _encode_enum(self, attr_spec, value):
         enum = self.consts[attr_spec['enum']]
         if enum.type == 'flags' or attr_spec.get('enum-as-flags', False):
@@ -819,6 +832,7 @@ genl_family_name_to_id = None
                 return
 
             nms = NlMsgs(reply)
+            self._recv_dbg_print(reply, nms)
             for nl_msg in nms:
                 if nl_msg.error:
                     print("Netlink error in ntf!?", os.strerror(-nl_msg.error))
@@ -871,6 +885,7 @@ genl_family_name_to_id = None
         while not done:
             reply = self.sock.recv(self._recv_size)
             nms = NlMsgs(reply, attr_space=op.attr_set)
+            self._recv_dbg_print(reply, nms)
             for nl_msg in nms:
                 if nl_msg.extack:
                     self._decode_extack(msg, op, nl_msg.extack)
-- 
2.44.0


