Return-Path: <netdev+bounces-18646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96679758210
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD58F281653
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F32213AF7;
	Tue, 18 Jul 2023 16:24:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B1156DA
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 16:24:40 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37875B5
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689697479; x=1721233479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MU8wC3hsx/Y8pobDsNxIfsct/lJK9LdI7UyRTn80YQo=;
  b=Z77kOduISj+uNEL8ykoMJtUYMC9WfPdb4czTy+CSqNwaRuRO/1p6lntc
   YzM8UCgQ2sYx3gg7rmwK6rK6KFyKvRr/KTlQbtHS4D/teZ2h0ahdIiZ86
   OrfMTON1TR5pedm7XD70+IwgfRUdpMeey4RpgRXksrlyWZgOHNqPyor1G
   WuR1tEzRsMS1X0HXvFIc3bmF/c5mkADCPQ4XLCMCMdSZYbO3nw2NsiBKs
   Sg6uLuW/jhGu8PcyOcuicpm5n/l2a20HPUkAYW1L1OjuSY5I5IO1ZzUkC
   w5uhhMj8utny25lkDwFJFjXqxQYFLdHrUO4c4PODM9fWgn5xUT/e2QCMN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="368894215"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="368894215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 09:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="753388394"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="753388394"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2023 09:24:32 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: kuba@kernel.org,
	donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v3 2/2] tools: ynl-gen: fix parse multi-attr enum attribute
Date: Tue, 18 Jul 2023 18:22:25 +0200
Message-Id: <20230718162225.231775-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230718162225.231775-1-arkadiusz.kubalewski@intel.com>
References: <20230718162225.231775-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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
 tools/net/ynl/lib/ynl.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 5db7d47067f9..671ef4b5eaa6 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -135,7 +135,7 @@ class NlAttr:
         format = self.get_format(type)
         return [ x[0] for x in format.iter_unpack(self.raw) ]
 
-    def as_struct(self, members):
+    def as_struct(self, members, attr_spec):
         value = dict()
         offset = 0
         for m in members:
@@ -147,6 +147,9 @@ class NlAttr:
                 format = self.get_format(m.type, m.byte_order)
                 [ decoded ] = format.unpack_from(self.raw, offset)
                 offset += format.size
+
+            if m.enum:
+                decoded = self._decode_enum(decoded, attr_spec)
             if m.display_hint:
                 decoded = self.formatted_string(decoded, m.display_hint)
             value[m.name] = decoded
@@ -417,8 +420,7 @@ class YnlFamily(SpecFamily):
         pad = b'\x00' * ((4 - len(attr_payload) % 4) % 4)
         return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_payload + pad
 
-    def _decode_enum(self, rsp, attr_spec):
-        raw = rsp[attr_spec['name']]
+    def _decode_enum(self, raw, attr_spec):
         enum = self.consts[attr_spec['enum']]
         if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
             i = attr_spec.get('value-start', 0)
@@ -430,15 +432,12 @@ class YnlFamily(SpecFamily):
                 i += 1
         else:
             value = enum.entries_by_val[raw].name
-        rsp[attr_spec['name']] = value
+        return value
 
     def _decode_binary(self, attr, attr_spec):
         if attr_spec.struct_name:
             members = self.consts[attr_spec.struct_name]
-            decoded = attr.as_struct(members)
-            for m in members:
-                if m.enum:
-                    self._decode_enum(decoded, m)
+            decoded = attr.as_struct(members, attr_spec)
         elif attr_spec.sub_type:
             decoded = attr.as_c_array(attr_spec.sub_type)
         else:
@@ -466,6 +465,9 @@ class YnlFamily(SpecFamily):
             else:
                 raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
 
+            if 'enum' in attr_spec:
+                decoded = self._decode_enum(int.from_bytes(attr.raw, "big"), attr_spec)
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


