Return-Path: <netdev+bounces-76759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A936F86ECA2
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 00:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36973280CD6
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 23:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6295F479;
	Fri,  1 Mar 2024 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUpvF0jh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481DB5F46D
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334353; cv=none; b=aWE8rnINA1FofjOT/2TZ1ePaPsa5wZ6ECVXJUGRlcfbrVM4xJQZaWGLAO86ToM4oWAmcmMKYcGvQcI41mL5jQreLXBPDCwAvl8hFe/sPBPXNCw8jgtF+nwx3YFIPKJGK1ZITl15+5x8vRrLlgj0ixX1WOdSEaz+JdcXnjuuWrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334353; c=relaxed/simple;
	bh=M1FbGGMoVFJFwVHbr/8l0T3dLBK7vaN6zfOQcp/J4/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtgE3b3gaLpR2LMq1hlbR3NarGPa7SiYpfLSDKs2K+oL1W3tHLa60wOw3in0BCDBQTL/mw+R2t1J9brbHi2n3J4VxE2/gmTl+nPRoKuFZdGFyj4TqKa7uY/JoKb7wb2CGZmE/9BC2n4BmBz3M6QcnylwZ6p4mG+7aYSdOgmVoJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUpvF0jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81916C433B1;
	Fri,  1 Mar 2024 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709334352;
	bh=M1FbGGMoVFJFwVHbr/8l0T3dLBK7vaN6zfOQcp/J4/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUpvF0jhStmlzFr95uaaYJaituN/G/uynHM8gzPh1hKCkLW/fevSB/eqAhs2a7Vyg
	 g5TvPHDGVrZioeMhv+H4AOsRhlOo21nWWow4iyud7hQZ/sAHHwjCxST6P5BEWEQ7bb
	 JmAb5X7TrNU4pYY1dRJuC25WxUkhlg155ryVJ1lr7wuMnx1OUQlmao6A2Y2vVrNzYt
	 j5n6pM3q7j2s7KbfIhJBTK5HVTaNUbaV/BQHguI3hvkqrOicCyJdYuykuGzbY4Pyp+
	 tZjouDtlGHt8oNrAGkkRHNhkf+TnaICxjdZ6SHnrqkANge0bCd9AOAYNSPIwi/KQ87
	 vX3j4HG/elz5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] tools: ynl: support debug printing messages
Date: Fri,  1 Mar 2024 15:05:41 -0800
Message-ID: <20240301230542.116823-4-kuba@kernel.org>
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

For manual debug, allow printing the netlink level messages
to stderr.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index bc5a526dbb99..2462228dacc1 100644
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
@@ -428,6 +429,7 @@ genl_family_name_to_id = None
         self.async_msg_ids = set()
         self.async_msg_queue = []
 
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


