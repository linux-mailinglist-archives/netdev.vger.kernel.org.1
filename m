Return-Path: <netdev+bounces-125105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE096BF46
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A334B2A4CB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B641DB93D;
	Wed,  4 Sep 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Er536IWs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75701DA609;
	Wed,  4 Sep 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458107; cv=none; b=Un927oJ5gHTYls8+4sv7ybnc7mxButdQ4Ln9EQYdJgxvVNTod77eZS8YdYRRE1GmpNa68J5C2ew1Z8bT0oLJFJPSeOv1FE++kp7AtpNgcb7nLEkxGmjFKLchwGQ9zVIHF+s1Zd3qYdUGUDlPKtzMM8VvpBSTXpdXH+PkqoYXlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458107; c=relaxed/simple;
	bh=Pw09EoXu7B/k/Ba1l1esGop2w51rj9+9eY060VZllXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BsTCY5iyytnYfNcrWQCJCLXaE26VXb+39rVk+ddQ3HTcI4UBpKpAbEU31qqmbVGgNGfLS39rnj/HBbyRKTIfJEVIs8UlaexjOIv8ieYSmcAlibR9Msq1xeSXmC20kVsN5y97rSyeR/TANPn8lGmY8HvnDnd6A9UwS7W5zOg2FtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Er536IWs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725458106; x=1756994106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pw09EoXu7B/k/Ba1l1esGop2w51rj9+9eY060VZllXE=;
  b=Er536IWsgYqIeubJ+lFtagXAuLyRki9fi/NbPTgIMMCBYdHljM16WBBI
   HhgqjzJ8wOLoVjDLC21iYZdXwgc3JGViHyUzo1cXH/yDBPYItUcRsCILd
   nAquWlF5DQkcEYTLvTeKv4wtUEB6MCl6t2GVXM5kaLeEGN6bLLvFYgoq8
   ZqC+oSID1hiDPOeQsCl3KWQaYb7mNTLCyPZdY5NWHhlz498c8sveRNanG
   P7v3+q8mpCm1rEsI6KYi5LteR3hZiu0d1gtmaKafzrhYV5l+KtPQ+WGqd
   E5FSu+yXF2X4KVSxuUgekNreSvuZbVbMJs0r2sAj+fc0Gd8BNgtreSxmP
   g==;
X-CSE-ConnectionGUID: H+lnth23R8OYMSoQIwavyw==
X-CSE-MsgGUID: nFEJ+QZRQMOOe0StCOHucA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="49524852"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="49524852"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 06:55:05 -0700
X-CSE-ConnectionGUID: 2aKm/M8WTTKUAOjIZtU3qA==
X-CSE-MsgGUID: KVNsQYM+T0q2bJdw8VZCbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="70155632"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa004.jf.intel.com with ESMTP; 04 Sep 2024 06:55:02 -0700
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
Subject: [PATCH net v2] tools/net/ynl: fix cli.py --subscribe feature
Date: Wed,  4 Sep 2024 15:50:34 +0200
Message-Id: <20240904135034.316033-1-arkadiusz.kubalewski@intel.com>
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
v2:
- use ynl.rsp_by_value[] within decode(..) instead of passing additional
  argument from the caller function
---
 tools/net/ynl/lib/ynl.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index d42c1d605969..c22c22bf2cb7 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -388,6 +388,8 @@ class NetlinkProtocol:
 
     def decode(self, ynl, nl_msg, op):
         msg = self._decode(nl_msg)
+        if op is None:
+            op = ynl.rsp_by_value[msg.cmd()]
         fixed_header_size = ynl._struct_size(op.fixed_header)
         msg.raw_attrs = NlAttrs(msg.raw, fixed_header_size)
         return msg
@@ -921,8 +923,7 @@ class YnlFamily(SpecFamily):
                     print("Netlink done while checking for ntf!?")
                     continue
 
-                op = self.rsp_by_value[nl_msg.cmd()]
-                decoded = self.nlproto.decode(self, nl_msg, op)
+                decoded = self.nlproto.decode(self, nl_msg, None)
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
-- 
2.38.1


