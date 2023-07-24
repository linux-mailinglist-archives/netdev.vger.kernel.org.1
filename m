Return-Path: <netdev+bounces-20373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7764775F34B
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3243228135B
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0AF882D;
	Mon, 24 Jul 2023 10:28:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64468C00
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:28:36 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4CE30E3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690194502; x=1721730502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EtQK91vZZmmIsg5AAuoge8NKyNP1VPwbv2BYmPPNx5I=;
  b=UrJBsThD1pSIDUlqi5AazUeMwmqRhJUsxJKTjmhdB4VilzOS1kX0RT2r
   Ft5flSJd47OshyMI0d2WEj6pp2soRWQgCg2fkEVtyon6YIuSQ8+Jsl0R6
   Wa4LVnGE46ZRI/RxWLAbQYbnBm+vOCLwQDuQV/mWapI/AahRuD57rFfGc
   w7ak8a9XyDcz3O34zv4/vZXNPM1/BemlQPeYdUMvYlQDDtPtvanFZgVeG
   EQdHcjqtOyFH6ZLIF/fNXoOWS9pJ+mQCv7133PRhHDkv+0Q/dZzVHZaWu
   GQWMDaZq/FWvnMWgInCUU0ExsT1ve7uu6/MtyhVA3x2f3wwUBRARZnoTz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="431200815"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="431200815"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="719630845"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="719630845"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2023 03:27:40 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: kuba@kernel.org,
	donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: simon.horman@corigine.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v4 2/2] tools: ynl-gen: fix parse multi-attr enum attribute
Date: Mon, 24 Jul 2023 12:25:21 +0200
Message-Id: <20230724102521.259545-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230724102521.259545-1-arkadiusz.kubalewski@intel.com>
References: <20230724102521.259545-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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
 tools/net/ynl/lib/ynl.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 027b1c0aecb4..3e2ade2194cd 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -147,6 +147,7 @@ class NlAttr:
                 format = self.get_format(m.type, m.byte_order)
                 [ decoded ] = format.unpack_from(self.raw, offset)
                 offset += format.size
+
             if m.display_hint:
                 decoded = self.formatted_string(decoded, m.display_hint)
             value[m.name] = decoded
@@ -417,8 +418,7 @@ class YnlFamily(SpecFamily):
         pad = b'\x00' * ((4 - len(attr_payload) % 4) % 4)
         return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_payload + pad
 
-    def _decode_enum(self, rsp, attr_spec):
-        raw = rsp[attr_spec['name']]
+    def _decode_enum(self, raw, attr_spec):
         enum = self.consts[attr_spec['enum']]
         if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
             i = 0
@@ -430,7 +430,7 @@ class YnlFamily(SpecFamily):
                 i += 1
         else:
             value = enum.entries_by_val[raw].name
-        rsp[attr_spec['name']] = value
+        return value
 
     def _decode_binary(self, attr, attr_spec):
         if attr_spec.struct_name:
@@ -438,7 +438,7 @@ class YnlFamily(SpecFamily):
             decoded = attr.as_struct(members)
             for m in members:
                 if m.enum:
-                    self._decode_enum(decoded, m)
+                     decoded[m.name] = self._decode_enum(decoded[m.name], m)
         elif attr_spec.sub_type:
             decoded = attr.as_c_array(attr_spec.sub_type)
         else:
@@ -466,6 +466,9 @@ class YnlFamily(SpecFamily):
             else:
                 raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
 
+            if 'enum' in attr_spec:
+                decoded = self._decode_enum(decoded, attr_spec)
+
             if not attr_spec.is_multi:
                 rsp[attr_spec['name']] = decoded
             elif attr_spec.name in rsp:
@@ -473,8 +476,6 @@ class YnlFamily(SpecFamily):
             else:
                 rsp[attr_spec.name] = [decoded]
 
-            if 'enum' in attr_spec:
-                self._decode_enum(rsp, attr_spec)
         return rsp
 
     def _decode_extack_path(self, attrs, attr_set, offset, target):
-- 
2.38.1


