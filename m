Return-Path: <netdev+bounces-20801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B057076107B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B4D1C20C72
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9111D2E3;
	Tue, 25 Jul 2023 10:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4E41ED42
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:19:17 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292FE172E
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690280352; x=1721816352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=99gW/yOl5FT2quICEBTp/v0i+7/8Rqsj6Nda9CPLtqo=;
  b=SAN8NIf/mp7m7WMthkmMGAdTN1NDyO200g6u66Z/LYyZTMytc6uJpcg/
   5MGzvufJV/lm0Nf7rcdAEEOXlIOnTQLzbNUZ900sIsKT5VpPCsmHvFXrs
   zsRZdnh/nOn7GS1pqoJhnxW6q90jaOkjnor7Cbj0hVncA06GFKjDwQx73
   TRVXH6QV9azIOLSYpjzpNGhnuoxgGBtrSRZa6BLAZDZomYWRKOmQfyqAT
   uJtjFgwnNdqtXPPBW/9oCvGLLQTTYQM1vy+aXx14Zww9iWlO5c1F4ZQH+
   7A946E7LxXenG0SB34cuAg6HlyxKNiyMrAA44qSF46a+x+ozbIr9NBAPU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="367706031"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367706031"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:19:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="869429703"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2023 03:19:11 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: kuba@kernel.org,
	donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: simon.horman@corigine.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v5 2/2] tools: ynl-gen: fix parse multi-attr enum attribute
Date: Tue, 25 Jul 2023 12:16:42 +0200
Message-Id: <20230725101642.267248-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230725101642.267248-1-arkadiusz.kubalewski@intel.com>
References: <20230725101642.267248-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When attribute is enum type and marked as multi-attr, the netlink
respond is not parsed, fails with stack trace:
Traceback (most recent call last):
  File "/net-next/tools/net/ynl/./test.py", line 520, in <module>
    main()
  File "/net-next/tools/net/ynl/./test.py", line 488, in main
    dplls=dplls_get(282574471561216)
  File "/net-next/tools/net/ynl/./test.py", line 48, in dplls_get
    reply=act(args)
  File "/net-next/tools/net/ynl/./test.py", line 41, in act
    reply = ynl.dump(args.dump, attrs)
  File "/net-next/tools/net/ynl/lib/ynl.py", line 598, in dump
    return self._op(method, vals, dump=True)
  File "/net-next/tools/net/ynl/lib/ynl.py", line 584, in _op
    rsp_msg = self._decode(gm.raw_attrs, op.attr_set.name)
  File "/net-next/tools/net/ynl/lib/ynl.py", line 451, in _decode
    self._decode_enum(rsp, attr_spec)
  File "/net-next/tools/net/ynl/lib/ynl.py", line 408, in _decode_enum
    value = enum.entries_by_val[raw].name
TypeError: unhashable type: 'list'
error: 1

Redesign _decode_enum(..) to take a enum int value and translate
it to either a bitmask or enum name as expected.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 tools/net/ynl/lib/ynl.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 027b1c0aecb4..3ca28d4bcb18 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -417,8 +417,7 @@ class YnlFamily(SpecFamily):
         pad = b'\x00' * ((4 - len(attr_payload) % 4) % 4)
         return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_payload + pad
 
-    def _decode_enum(self, rsp, attr_spec):
-        raw = rsp[attr_spec['name']]
+    def _decode_enum(self, raw, attr_spec):
         enum = self.consts[attr_spec['enum']]
         if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
             i = 0
@@ -430,7 +429,7 @@ class YnlFamily(SpecFamily):
                 i += 1
         else:
             value = enum.entries_by_val[raw].name
-        rsp[attr_spec['name']] = value
+        return value
 
     def _decode_binary(self, attr, attr_spec):
         if attr_spec.struct_name:
@@ -438,7 +437,7 @@ class YnlFamily(SpecFamily):
             decoded = attr.as_struct(members)
             for m in members:
                 if m.enum:
-                    self._decode_enum(decoded, m)
+                    decoded[m.name] = self._decode_enum(decoded[m.name], m)
         elif attr_spec.sub_type:
             decoded = attr.as_c_array(attr_spec.sub_type)
         else:
@@ -466,6 +465,9 @@ class YnlFamily(SpecFamily):
             else:
                 raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
 
+            if 'enum' in attr_spec:
+                decoded = self._decode_enum(decoded, attr_spec)
+
             if not attr_spec.is_multi:
                 rsp[attr_spec['name']] = decoded
             elif attr_spec.name in rsp:
@@ -473,8 +475,6 @@ class YnlFamily(SpecFamily):
             else:
                 rsp[attr_spec.name] = [decoded]
 
-            if 'enum' in attr_spec:
-                self._decode_enum(rsp, attr_spec)
         return rsp
 
     def _decode_extack_path(self, attrs, attr_set, offset, target):
-- 
2.38.1


