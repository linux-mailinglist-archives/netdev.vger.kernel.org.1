Return-Path: <netdev+bounces-199160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C29ADF39C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FCE1BC0071
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A302ECEAD;
	Wed, 18 Jun 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0nu+sBh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4D1DE896
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750267078; cv=none; b=h9FYDlm/0GixIgiFPec9FNLlytpYfM2ZuCa6aIHny//Dm51XC+0xD87BPCEUPvT+CRC6+WQsdhi0WrM1nANQMRVuz9YnA130cRBWMgmu7NSFViLSEN3KVC7GGaKfxgIzLCiRbbSMUMkUkV0TuliKiYggBjXhRxsJbR9j34PtG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750267078; c=relaxed/simple;
	bh=lx03Ehom7n/h+SONssneYM9pbh/yTDNT9e9/Qp4Rbk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLblQftF0+AYkQcU+OslYYGmsiA0u+0KmdD0ziIUrtE6VystCex8qa8yE6A6CHtaB86fC/BtHw5fc++g8XeQyWF9dAb4SBNhq8abnVZrqpPu0aNpDSHuNokugNeZZe+nJPx6PTsS/hZ/UPndn64gMSuoS2ximJItt61wepNO+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0nu+sBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7F9C4CEE7;
	Wed, 18 Jun 2025 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750267078;
	bh=lx03Ehom7n/h+SONssneYM9pbh/yTDNT9e9/Qp4Rbk0=;
	h=From:To:Cc:Subject:Date:From;
	b=V0nu+sBhKhAWxQj8J3iNiIQ2GjBSqAILkdyTsylxNskcc2e7NC+/sG8k0Cy1NB8KI
	 1Vjia2jjW3+VPe5xNHVxTBIwKLQWjhYTV0Qh2Vm1f3sOYGo/B+ZnaGPiDkZUuIaClq
	 Mlyg+8W3xwYoPLY+57aeg43xkdY06T+HsQD7n06w2FzBwA0jLNeLGE2y75/uyV+oQx
	 iXwZmO6bzT2NDulrUWhQUvWl9WQJuihkzUnyTHkmPKmWuDq6pnIB+NzSbp4Rg+ofQY
	 65vWFyzGk+vSMm3kWLH2uv19mX7j7t1PBlUtJpZl9ZFRDIM3nNmIeXqYye0NhFkRWe
	 BmUEnKFlMQs6Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	arkadiusz.kubalewski@intel.com
Subject: [PATCH net] tools: ynl: fix mixing ops and notifications on one socket
Date: Wed, 18 Jun 2025 10:17:46 -0700
Message-ID: <20250618171746.1201403-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The multi message support loosened the connection between the request
and response handling, as we can now submit multiple requests before
we start processing responses. Passing the attr set to NlMsgs decoding
no longer makes sense (if it ever did), attr set may differ message
by messsage. Isolate the part of decoding responsible for attr-set
specific interpretation and call it once we identified the correct op.

Without this fix performing SET operation on an ethtool socket, while
being subscribed to notifications causes:

 # File "tools/net/ynl/pyynl/lib/ynl.py", line 1096, in _op
 # Exception|     return self._ops(ops)[0]
 # Exception|            ~~~~~~~~~^^^^^
 # File "tools/net/ynl/pyynl/lib/ynl.py", line 1040, in _ops
 # Exception|     nms = NlMsgs(reply, attr_space=op.attr_set)
 # Exception|                                    ^^^^^^^^^^^

The value of op we use on line 1040 is stale, it comes form the previous
loop. If a notification comes before a response we will update op to None
and the next iteration thru the loop will break with the trace above.

Fixes: 6fda63c45fe8 ("tools/net/ynl: fix cli.py --subscribe feature")
Fixes: ba8be00f68f5 ("tools/net/ynl: Add multi message support to ynl")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: arkadiusz.kubalewski@intel.com
---
 tools/net/ynl/pyynl/lib/ynl.py | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index ae4d1ef7b83a..7529bce174ff 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -231,14 +231,7 @@ from .nlspec import SpecFamily
                     self.extack['unknown'].append(extack)
 
             if attr_space:
-                # We don't have the ability to parse nests yet, so only do global
-                if 'miss-type' in self.extack and 'miss-nest' not in self.extack:
-                    miss_type = self.extack['miss-type']
-                    if miss_type in attr_space.attrs_by_val:
-                        spec = attr_space.attrs_by_val[miss_type]
-                        self.extack['miss-type'] = spec['name']
-                        if 'doc' in spec:
-                            self.extack['miss-type-doc'] = spec['doc']
+                self.annotate_extack(attr_space)
 
     def _decode_policy(self, raw):
         policy = {}
@@ -264,6 +257,18 @@ from .nlspec import SpecFamily
                 policy['mask'] = attr.as_scalar('u64')
         return policy
 
+    def annotate_extack(self, attr_space):
+        """ Make extack more human friendly with attribute information """
+
+        # We don't have the ability to parse nests yet, so only do global
+        if 'miss-type' in self.extack and 'miss-nest' not in self.extack:
+            miss_type = self.extack['miss-type']
+            if miss_type in attr_space.attrs_by_val:
+                spec = attr_space.attrs_by_val[miss_type]
+                self.extack['miss-type'] = spec['name']
+                if 'doc' in spec:
+                    self.extack['miss-type-doc'] = spec['doc']
+
     def cmd(self):
         return self.nl_type
 
@@ -277,12 +282,12 @@ from .nlspec import SpecFamily
 
 
 class NlMsgs:
-    def __init__(self, data, attr_space=None):
+    def __init__(self, data):
         self.msgs = []
 
         offset = 0
         while offset < len(data):
-            msg = NlMsg(data, offset, attr_space=attr_space)
+            msg = NlMsg(data, offset)
             offset += msg.nl_len
             self.msgs.append(msg)
 
@@ -1036,12 +1041,13 @@ genl_family_name_to_id = None
         op_rsp = []
         while not done:
             reply = self.sock.recv(self._recv_size)
-            nms = NlMsgs(reply, attr_space=op.attr_set)
+            nms = NlMsgs(reply)
             self._recv_dbg_print(reply, nms)
             for nl_msg in nms:
                 if nl_msg.nl_seq in reqs_by_seq:
                     (op, vals, req_msg, req_flags) = reqs_by_seq[nl_msg.nl_seq]
                     if nl_msg.extack:
+                        nl_msg.annotate_extack(op.attr_set)
                         self._decode_extack(req_msg, op, nl_msg.extack, vals)
                 else:
                     op = None
-- 
2.49.0


