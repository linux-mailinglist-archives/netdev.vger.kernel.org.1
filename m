Return-Path: <netdev+bounces-222290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849CEB53CD6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3051117C6ED
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A9258CF7;
	Thu, 11 Sep 2025 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Ycdp3kZq"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98C1E3DD7;
	Thu, 11 Sep 2025 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621133; cv=none; b=M8L126zsKylFvqb0esseDC0AQXg1kaO3It/hqu3sJauh+1PcOsTPoNYL0NSY2Fd7XeaPW10MBWfzESzQkeFeqlhtiAkbDEVW4UimPvyQsZ1ftm2BkKjKi9wKOe9LnnMpy5pnKPlh3xsSzoL1HhvHSN+vbXnlZBi/P4JW48baZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621133; c=relaxed/simple;
	bh=XXjcTNKslt1b6PY8TquSYL6KbSfUAvUwDGK7Xz4t9us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6OFIieBhdC/pajkJu7Ixan89q8U46l9q7KkDivBKjtLkaEhROwzzY7379GsWko3+ZokGUNpJT/BD4tVZSZAUNbwsEtjl3PFJBctunyAv1dYpuGnBXPJuBafQeas+5OUb24oEKfVvcZ9/dlnsHF0gQBdE8MOc/hoqi+eFP/+5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Ycdp3kZq; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=XXjcTNKslt1b6PY8TquSYL6KbSfUAvUwDGK7Xz4t9us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ycdp3kZqhwXL2kf+4Twbc5x3QcYvB1DuXLbqmZIEiKRMQNByXEoRrOYLqg2vhATjN
	 1txvhfIMfWGiCLcruCG0ha5YVTOr1LSczv8deqIawWbCur0XT2cYfzvQ4wVqtIXbsh
	 D3Aviwj5cD6CYWHrQnGl7nxWcPUhXM9nQUIN+lJpqw0AN6sdmQlVfR4XZvZ00hgsLJ
	 FKcKmkqjJTzutsU3Cysdqq4qcAKlD/6N1ARX17p0rcvKC0jlEitvcRuulp/BnqwMaO
	 eOwt0jTdlY8i5Qh23BhxOkZPrxAu34tl1v0G46VD6v1lM8OswiyEMY+K0SQyfzAq2S
	 BDvpRn+lWjyiQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8B1E460078;
	Thu, 11 Sep 2025 20:05:26 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 02C7C203CF3; Thu, 11 Sep 2025 20:05:21 +0000 (UTC)
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
Subject: [PATCH net-next v3 04/13] tools: ynl-gen: refactor local vars for .attr_put() callers
Date: Thu, 11 Sep 2025 20:04:57 +0000
Message-ID: <20250911200508.79341-5-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911200508.79341-1-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor the generation of local variables needed when building
requests, by moving the logic into the Type classes, and use the
same helper in all places where .attr_put() is called.

If any attributes requests identical local_vars, then they will
be deduplicated, attributes are assumed to only use their local
variables transiently.

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
 tools/net/ynl/pyynl/ynl_gen_c.py | 35 ++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 3266af19edcd..e4cb8c95632c 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -235,6 +235,12 @@ class Type(SpecAttr):
         line = f"ynl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name})"
         self._attr_put_line(ri, var, line)
 
+    def attr_put_local_vars(self):
+        local_vars = []
+        if self.presence_type() == 'count':
+            local_vars.append('unsigned int i;')
+        return local_vars
+
     def attr_put(self, ri, var):
         raise Exception(f"Put not implemented for class type {self.type}")
 
@@ -840,6 +846,10 @@ class TypeArrayNest(Type):
                      '}']
         return get_lines, None, local_vars
 
+    def attr_put_local_vars(self):
+        local_vars = ['struct nlattr *array;']
+        return local_vars + super().attr_put_local_vars()
+
     def attr_put(self, ri, var):
         ri.cw.p(f'array = ynl_attr_nest_start(nlh, {self.enum_name});')
         if self.sub_type in scalars:
@@ -2040,6 +2050,13 @@ def put_enum_to_str(family, cw, enum):
     _put_enum_to_str_helper(cw, enum.render_name, map_name, 'value', enum=enum)
 
 
+def put_local_vars(struct):
+    local_vars = set()
+    for _, attr in struct.member_list():
+        local_vars |= set(attr.attr_put_local_vars())
+    return list(local_vars)
+
+
 def put_req_nested_prototype(ri, struct, suffix=';'):
     func_args = ['struct nlmsghdr *nlh',
                  'unsigned int attr_type',
@@ -2062,15 +2079,7 @@ def put_req_nested(ri, struct):
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
@@ -2354,10 +2363,7 @@ def print_req(ri):
         local_vars += ['size_t hdr_len;',
                        'void *hdr;']
 
-    for _, attr in ri.struct["request"].member_list():
-        if attr.presence_type() == 'count':
-            local_vars += ['unsigned int i;']
-            break
+    local_vars += put_local_vars(ri.struct["request"])
 
     print_prototype(ri, direction, terminate=False)
     ri.cw.block_start()
@@ -2424,6 +2430,9 @@ def print_dump(ri):
         local_vars += ['size_t hdr_len;',
                        'void *hdr;']
 
+    if "request" in ri.op[ri.op_mode]:
+        local_vars += put_local_vars(ri.struct["request"])
+
     ri.cw.write_func_lvar(local_vars)
 
     ri.cw.p('yds.yarg.ys = ys;')
-- 
2.51.0


