Return-Path: <netdev+bounces-223110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4CB57F7D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AFB18849BA
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85B73451AA;
	Mon, 15 Sep 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="WEW24BMr"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941BE340D8A;
	Mon, 15 Sep 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947675; cv=none; b=Yu+E1BFIBoDywB0voekCJPp8LNpVVu1ECDqJDs6V5Td0xgHUKG88UJyP84WutDmUg/EEsEnUHIx9HZ0v42wQtES0qAFld7noh7aziiWfcIobSP9B3Db62Bz1a9UMNoxCZqJieooStVdlgL4nac7Hgtrm6jrxJuB5PgJZe8qe1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947675; c=relaxed/simple;
	bh=IsmjNeaXavqPvifeThqRq8BNJU4LPyh8Y4FXmPIrN2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoIJhFb1ZoovT0snWB76C5lnXJtSYBldW8XJA8bWLrAKPemaE5AGqtUOZSMoH5/hjgc4gudYxGJSbOLORiwA1DS8xQ58sF9RYCWIklSsIwmJsj6fWXbA+Otswi129NaQ7qK884Bwx95ozEL3Oq3zvHVg4toHm9J/B6Znq2/hddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=WEW24BMr; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757947661;
	bh=IsmjNeaXavqPvifeThqRq8BNJU4LPyh8Y4FXmPIrN2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WEW24BMrMoIAB6//FCu9YqsdwI5AcZBBuX+35+Ggi7+lMKwLnQ+a52vkM1tbBhyPd
	 ebI37IDVsiZJeeKtMvFrihYh3b5MTjPu1nmXdWJ40CencVLpV8KguEPlHAhoswSvJl
	 oDQZ36lRXm6+Rd/uQiqxSjhwGUv13Q47Ytj1v7B7juFEmrBf8pRrGr4hLVnPESTfnH
	 3PP8pbEQhqMp1PkYLWDdtliGMAmyt+Vsey8OoSviFnscS0Cm0excutaR55atOpJnpi
	 Vrxvjox43wlpUJpZrzcbUXSKzGI+vm6/uWGmu5SOSS0rsM7Uuj/rom/GKRMlHC+SRL
	 BwlE1zzNqdtXg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 044D06013B;
	Mon, 15 Sep 2025 14:47:41 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 2BC77203CF3; Mon, 15 Sep 2025 14:43:06 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 04/11] tools: ynl-gen: refactor local vars for .attr_put() callers
Date: Mon, 15 Sep 2025 14:42:49 +0000
Message-ID: <20250915144301.725949-5-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915144301.725949-1-ast@fiberby.net>
References: <20250915144301.725949-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor the generation of local variables needed when building
requests, by moving the logic from put_req_nested() into a new
helper put_local_vars(), and use the helper before .attr_put() is
called, thus generating the local variables assumed by .attr_put().

Previously only put_req_nested() generated the variables assumed
by .attr_put(),  print_req() only generated the count iterator `i`,
and print_dump() neither generated `i` nor `array`.

This patch fixes the build errors below:
$ make -C tools/net/ynl/generated/
[...]
-e      GEN wireguard-user.c
-e      GEN wireguard-user.h
-e      CC wireguard-user.o
wireguard-user.c: In function ‘wireguard_get_device_dump’:
wireguard-user.c:480:9: error: ‘array’ undeclared (first use in func)
  480 |         array = ynl_attr_nest_start(nlh, WGDEVICE_A_PEERS);
      |         ^~~~~
wireguard-user.c:480:9: note: each undeclared identifier is reported
                        only once for each function it appears in
wireguard-user.c:481:14: error: ‘i’ undeclared (first use in func)
  481 |         for (i = 0; i < req->_count.peers; i++)
      |              ^
wireguard-user.c: In function ‘wireguard_set_device’:
wireguard-user.c:533:9: error: ‘array’ undeclared (first use in func)
  533 |         array = ynl_attr_nest_start(nlh, WGDEVICE_A_PEERS);
      |         ^~~~~
make: *** [Makefile:52: wireguard-user.o] Error 1
make: Leaving directory '/usr/src/linux/tools/net/ynl/generated'

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 3266af19edcd..a0c571456236 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2040,6 +2040,20 @@ def put_enum_to_str(family, cw, enum):
     _put_enum_to_str_helper(cw, enum.render_name, map_name, 'value', enum=enum)
 
 
+def put_local_vars(struct):
+    local_vars = []
+    has_array = False
+    has_count = False
+    for _, arg in struct.member_list():
+        has_array |= arg.type == 'indexed-array'
+        has_count |= arg.presence_type() == 'count'
+    if has_array:
+        local_vars.append('struct nlattr *array;')
+    if has_count:
+        local_vars.append('unsigned int i;')
+    return local_vars
+
+
 def put_req_nested_prototype(ri, struct, suffix=';'):
     func_args = ['struct nlmsghdr *nlh',
                  'unsigned int attr_type',
@@ -2062,15 +2076,7 @@ def put_req_nested(ri, struct):
         init_lines.append(f"hdr = ynl_nlmsg_put_extra_header(nlh, {struct_sz});")
         init_lines.append(f"memcpy(hdr, &obj->_hdr, {struct_sz});")
 
-    has_anest = False
-    has_count = False
-    for _, arg in struct.member_list():
-        has_anest |= arg.type == 'indexed-array'
-        has_count |= arg.presence_type() == 'count'
-    if has_anest:
-        local_vars.append('struct nlattr *array;')
-    if has_count:
-        local_vars.append('unsigned int i;')
+    local_vars += put_local_vars(struct)
 
     put_req_nested_prototype(ri, struct, suffix='')
     ri.cw.block_start()
@@ -2354,10 +2360,7 @@ def print_req(ri):
         local_vars += ['size_t hdr_len;',
                        'void *hdr;']
 
-    for _, attr in ri.struct["request"].member_list():
-        if attr.presence_type() == 'count':
-            local_vars += ['unsigned int i;']
-            break
+    local_vars += put_local_vars(ri.struct['request'])
 
     print_prototype(ri, direction, terminate=False)
     ri.cw.block_start()
@@ -2424,6 +2427,9 @@ def print_dump(ri):
         local_vars += ['size_t hdr_len;',
                        'void *hdr;']
 
+    if 'request' in ri.op[ri.op_mode]:
+        local_vars += put_local_vars(ri.struct['request'])
+
     ri.cw.write_func_lvar(local_vars)
 
     ri.cw.p('yds.yarg.ys = ys;')
-- 
2.51.0


