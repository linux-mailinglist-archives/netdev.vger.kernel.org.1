Return-Path: <netdev+bounces-123841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03218966A50
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4221F2337E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2B81BE24B;
	Fri, 30 Aug 2024 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dukDgac1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8AA1BD503;
	Fri, 30 Aug 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049095; cv=none; b=FENV49gBJ9+07rgBwHpTmZDKcmWsXiv/3fc3fvZbJFV7Y92Y8IOHJQIawmAUoOYtdTSWR+11pRoQ+VWNfSqntAOkOQthorXsPUyjuBuOUU+cnBhQ+poWRWn8F/AYe6ZeJO5IIc5+WXix2tSaZWqyL8p/DFL8RW1lt71SDsoZ6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049095; c=relaxed/simple;
	bh=idiWEe2joAxypk+x1lThB8f3TAGNsoowcgsTAygOHN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qsQSpRAYub0m3R05BzgCmEgoGPjNEF75N3hsuty0qkax8zkvls6xSkDK2z6hV+h/T8k+BjK8j7r71X0wfTtR7nwTS8onwJnDOXPLg5/cEj1Z/iXTsl4LzeLlRxRv0E6Re8AmmrcC/f4FnRXmYgQW/mRubLoizLZJ0GhONR5K7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dukDgac1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725049094; x=1756585094;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=idiWEe2joAxypk+x1lThB8f3TAGNsoowcgsTAygOHN8=;
  b=dukDgac1w/tLoi0gLCHmSLK1Ptp36Olt0DAnKp1XFg8CYXutcYFcfno7
   Uzup1a7l6Tb8yHRt3MwycJ2EUWU4OPmC7o8Rya08lXEGp4roTBMf4KYt2
   cAyMf+HD2oGiUOaDupaSZimv9rKRJFdsS/5q8a+phl2W4F+SEMwMIyQY+
   xSv9IZaGghfdfOpmjWR/RaE95FWOchQNoB8YDsKYmViR2L0xywlo9zydz
   H9ECRhU76gHCKRWcS/GzSlJwF845xjqw+h4tFqC6K3l00I+eO8mw5UtXX
   EZActNQ8VlAE8OTVB0vsuECBUE6J6nnAnfmKFs2VSDOQzhv6CwDtmBI+H
   w==;
X-CSE-ConnectionGUID: Sg/FgQpwTHq4LQc8aCzAUA==
X-CSE-MsgGUID: NF4lLJfmT8KB6coSjIU6iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23275863"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23275863"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 13:18:08 -0700
X-CSE-ConnectionGUID: ian5uW3MToSLGGZW4gq4vg==
X-CSE-MsgGUID: 4bRhfOWNTiuMhLG97jlTkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="64496888"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa007.jf.intel.com with ESMTP; 30 Aug 2024 13:18:05 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	jacob.e.keller@intel.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net] tools/net/ynl: fix cli.py --subscribe feature
Date: Fri, 30 Aug 2024 22:13:21 +0200
Message-Id: <20240830201321.292593-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Execution of command:
./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml /
	--subscribe "monitor" --sleep 10
fails with:
  File "/repo/./tools/net/ynl/cli.py", line 109, in main
    ynl.check_ntf()
  File "/repo/tools/net/ynl/lib/ynl.py", line 924, in check_ntf
    op = self.rsp_by_value[nl_msg.cmd()]
KeyError: 19

Parsing Generic Netlink notification messages performs lookup for op in
the message. The message was not yet decoded, and is not yet considered
GenlMsg, thus msg.cmd() returns Generic Netlink family id (19) instead of
proper notification command id (i.e.: DPLL_CMD_PIN_CHANGE_NTF=13).

Allow the op to be obtained within NetlinkProtocol.decode(..) itself if the
op was not passed to the decode function, thus allow parsing of Generic
Netlink notifications without causing the failure.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Link: https://lore.kernel.org/netdev/m2le0n5xpn.fsf@gmail.com/
Fixes: 0a966d606c68 ("tools/net/ynl: Fix extack decoding for directional ops")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 tools/net/ynl/lib/ynl.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index d42c1d605969..4e7993c8cd9a 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -386,8 +386,10 @@ class NetlinkProtocol:
     def _decode(self, nl_msg):
         return nl_msg
 
-    def decode(self, ynl, nl_msg, op):
+    def decode(self, ynl, nl_msg, op, ops_by_value):
         msg = self._decode(nl_msg)
+        if op is None:
+            op = ops_by_value[msg.cmd()]
         fixed_header_size = ynl._struct_size(op.fixed_header)
         msg.raw_attrs = NlAttrs(msg.raw, fixed_header_size)
         return msg
@@ -796,7 +798,7 @@ class YnlFamily(SpecFamily):
         if 'bad-attr-offs' not in extack:
             return
 
-        msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set), op)
+        msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set), op, self.rsp_by_value)
         offset = self.nlproto.msghdr_size() + self._struct_size(op.fixed_header)
         path = self._decode_extack_path(msg.raw_attrs, op.attr_set, offset,
                                         extack['bad-attr-offs'])
@@ -921,8 +923,7 @@ class YnlFamily(SpecFamily):
                     print("Netlink done while checking for ntf!?")
                     continue
 
-                op = self.rsp_by_value[nl_msg.cmd()]
-                decoded = self.nlproto.decode(self, nl_msg, op)
+                decoded = self.nlproto.decode(self, nl_msg, None, self.rsp_by_value)
                 if decoded.cmd() not in self.async_msg_ids:
                     print("Unexpected msg id done while checking for ntf", decoded)
                     continue
@@ -980,7 +981,7 @@ class YnlFamily(SpecFamily):
                     if nl_msg.extack:
                         self._decode_extack(req_msg, op, nl_msg.extack)
                 else:
-                    op = self.rsp_by_value[nl_msg.cmd()]
+                    op = None
                     req_flags = []
 
                 if nl_msg.error:
@@ -1004,7 +1005,7 @@ class YnlFamily(SpecFamily):
                     done = len(reqs_by_seq) == 0
                     break
 
-                decoded = self.nlproto.decode(self, nl_msg, op)
+                decoded = self.nlproto.decode(self, nl_msg, op, self.rsp_by_value)
 
                 # Check if this is a reply to our request
                 if nl_msg.nl_seq not in reqs_by_seq or decoded.cmd() != op.rsp_value:
-- 
2.38.1


