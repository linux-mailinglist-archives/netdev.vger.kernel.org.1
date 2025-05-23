Return-Path: <netdev+bounces-192997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B0AC2127
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 12:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B67B841C
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83722228C92;
	Fri, 23 May 2025 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhe+WUrw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679422A4D6
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747996251; cv=none; b=UGWWnbHHK2x8xarRWH5CEmXqApGtw/HYFJ60gehl4lPzhER+BY5+IuT5sQZAiRzFoEdQXXK3xehW1gJNq9WtckZ6YoQUoUtbJaOXRGuvr5tdGwXJUyeUfpZ/56YP6MPAjsCjC0xih2k8h3RkxEgovAbBahzch8NOGQhzhHjRKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747996251; c=relaxed/simple;
	bh=VPp/mAYQescqqvBHjFXtXRQi1Y3YApV3oqzUfqmJ7As=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwXqrPe8uDK6UmPb6oE1N9ODYqFFHWCqJyBuCbORPU6VBHCgepGnCBClPAk2kY85e0nTyaj4+daO6wwbip/IgjndHnD9W30qhCGsL3FCaL6oepvSVtgtaUAxBWVFUK/Tr7Hvr6Koqf7f3ipI5j99zm/udKc5U61FdU0fdRXuRO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bhe+WUrw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441ab63a415so94867795e9.3
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 03:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747996247; x=1748601047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOjxJSYGxT9UhmRJmVkAknXCevMEWqmnm4FKczQ8nEI=;
        b=Bhe+WUrwgg/vvbBymp+XXz43GNUKZnfAJVDWyWQUt7qcNM/Df6+ZPiv1eAjwioxEdT
         4Hhi0NLdldfMLAStxi1fLC2Sb4riL9kF2U0SbJK43mOMaAPL3/5XB4kfwXKjYtOR5maJ
         B2G9GHpJ9/gRRyO9wA2mRLxrScPp5S/PUOeICbwnErBYr+W3v0FatbyiVRbrlHhizK8L
         2nqCamKxfaa9ozfpo3S69ST2H9LgcdWTFk2vIgCQ5S1c0OZrL/aSQaqgL6B9PJuEXUUm
         4TU6f6kJcGMAeyU2u2fu4ue2sLgksXa70++eJTJN2pYsgfex7tQF04COKBWaN9VcfSFp
         vcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747996247; x=1748601047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOjxJSYGxT9UhmRJmVkAknXCevMEWqmnm4FKczQ8nEI=;
        b=NfFW3iFuq57nbDZ/gDERN2gdUT0EgTvQXWZb3y3m8F9owITIsdgWd9m0WD7w3E3vj0
         QRjyMtMrdj7WhkC4ve2nLzsj+QeAArX/q/FtX4dF1akWwURmJ2Qrs0IdALyZ2qMjZ8Fo
         759XTT8nvH/oBut+43R2vpeXidq+XyPJtvrsJCKYULFWa7Rl+MutaQ6x3HKjiZEnCFEI
         bX3lqPI1zq5sggPYzNrNGKtKVZL2trsbAcLWlLVd6unICLx+rwYu2GXY0i5/k1WzOHJE
         95Lh5AyCEqEwdqQ3KqE4HSfPJ5bDhrH/Oxuhb6lbupRSgRRqNMN70JtSj/+ZRdg6f7vL
         hrsA==
X-Gm-Message-State: AOJu0YxM6L2o6u8VUlqD1LZiZIPc8OcFYr51QqaadoFoUc6wBzIcGwSW
	oExCrHAUpNri0WmXcqLkfncV3Y1G+u4pyfS8wPJSD+6wi7UA3ZgBSTimUp+Tdw==
X-Gm-Gg: ASbGncsjBomMMIvMmFKn6TQWPXS5GiRX2tLqeeaE52ktG3HEjYz1w/BuRJwDl/LUmZZ
	q2l2MEgpG5VbmNid+yE3tD6e9NXUdQkJJv/E5a+5Uglv3q9wvkgZH3WFr9iKo/k0K4OWeWNXq+/
	RvwQcfa8VmRN5A+iw7Gmqax8Nx5C8PEc9nW6ztXhn4AoouaxzPkesGNiS3kweeN7bH6gjIvg8Og
	kXZcGD27feuWSNraJswp44AjsXY9lXZue1a3h204tWzABuv/vSqfJAAodZFyEvabV/D7smeVdRR
	kKRwClF31SsyVqoptLfOeFprYzVcv11gPQGquUlaNq6oS3PwfLYgCVcLMgAcQ4ILoOIV
X-Google-Smtp-Source: AGHT+IEDpNL4sx4RLs1ngbJLOQyW2q1mq9kqZUoJrS6CYfClgU41sNkPo1R88zqya/h6PelnCebRGQ==
X-Received: by 2002:a05:6000:4202:b0:3a3:653e:165 with SMTP id ffacd0b85a97d-3a3653e095fmr22454659f8f.39.1747996247277;
        Fri, 23 May 2025 03:30:47 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:f9df:85fc:d54:1dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88941sm26503818f8f.61.2025.05.23.03.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:30:46 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] tools: ynl: parse extack for sub-messages
Date: Fri, 23 May 2025 11:30:31 +0100
Message-ID: <20250523103031.80236-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the Python YNL extack decoding to handle sub-messages in the same
way that YNL C does. This involves retaining the input values so that
they are available during extack decoding.

./tools/net/ynl/pyynl/cli.py --family rt-link --do newlink --create \
    --json '{
        "linkinfo": {"kind": "netkit", "data": {"policy": 10} }
    }'
Netlink error: Invalid argument
nl_len = 92 (76) nl_flags = 0x300 nl_type = 2
	error: -22
	extack: {'msg': 'Provided default xmit policy not supported', 'bad-attr': '.linkinfo.data(netkit).policy'}

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 39 ++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index dcc2c6b298d6..55b59f6c79b8 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -594,7 +594,7 @@ class YnlFamily(SpecFamily):
             scalar_selector = self._get_scalar(attr, value["selector"])
             attr_payload = struct.pack("II", scalar_value, scalar_selector)
         elif attr['type'] == 'sub-message':
-            msg_format = self._resolve_selector(attr, search_attrs)
+            msg_format, _ = self._resolve_selector(attr, search_attrs)
             attr_payload = b''
             if msg_format.fixed_header:
                 attr_payload += self._encode_struct(msg_format.fixed_header, value)
@@ -712,10 +712,10 @@ class YnlFamily(SpecFamily):
             raise Exception(f"No message format for '{value}' in sub-message spec '{sub_msg}'")
 
         spec = sub_msg_spec.formats[value]
-        return spec
+        return spec, value
 
     def _decode_sub_msg(self, attr, attr_spec, search_attrs):
-        msg_format = self._resolve_selector(attr_spec, search_attrs)
+        msg_format, _ = self._resolve_selector(attr_spec, search_attrs)
         decoded = {}
         offset = 0
         if msg_format.fixed_header:
@@ -787,7 +787,7 @@ class YnlFamily(SpecFamily):
 
         return rsp
 
-    def _decode_extack_path(self, attrs, attr_set, offset, target):
+    def _decode_extack_path(self, attrs, attr_set, offset, target, search_attrs):
         for attr in attrs:
             try:
                 attr_spec = attr_set.attrs_by_val[attr.type]
@@ -801,26 +801,37 @@ class YnlFamily(SpecFamily):
             if offset + attr.full_len <= target:
                 offset += attr.full_len
                 continue
-            if attr_spec['type'] != 'nest':
+
+            pathname = attr_spec.name
+            if attr_spec['type'] == 'nest':
+                sub_attrs = self.attr_sets[attr_spec['nested-attributes']]
+                search_attrs = SpaceAttrs(sub_attrs, search_attrs.lookup(attr_spec['name']))
+            elif attr_spec['type'] == 'sub-message':
+                msg_format, value = self._resolve_selector(attr_spec, search_attrs)
+                if msg_format is None:
+                    raise Exception(f"Can't resolve sub-message of {attr_spec['name']} for extack")
+                sub_attrs = self.attr_sets[msg_format.attr_set]
+                pathname += f"({value})"
+            else:
                 raise Exception(f"Can't dive into {attr.type} ({attr_spec['name']}) for extack")
             offset += 4
-            subpath = self._decode_extack_path(NlAttrs(attr.raw),
-                                               self.attr_sets[attr_spec['nested-attributes']],
-                                               offset, target)
+            subpath = self._decode_extack_path(NlAttrs(attr.raw), sub_attrs,
+                                               offset, target, search_attrs)
             if subpath is None:
                 return None
-            return '.' + attr_spec.name + subpath
+            return '.' + pathname + subpath
 
         return None
 
-    def _decode_extack(self, request, op, extack):
+    def _decode_extack(self, request, op, extack, vals):
         if 'bad-attr-offs' not in extack:
             return
 
         msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set), op)
         offset = self.nlproto.msghdr_size() + self._struct_size(op.fixed_header)
+        search_attrs = SpaceAttrs(op.attr_set, vals)
         path = self._decode_extack_path(msg.raw_attrs, op.attr_set, offset,
-                                        extack['bad-attr-offs'])
+                                        extack['bad-attr-offs'], search_attrs)
         if path:
             del extack['bad-attr-offs']
             extack['bad-attr'] = path
@@ -1012,7 +1023,7 @@ class YnlFamily(SpecFamily):
         for (method, vals, flags) in ops:
             op = self.ops[method]
             msg = self._encode_message(op, vals, flags, req_seq)
-            reqs_by_seq[req_seq] = (op, msg, flags)
+            reqs_by_seq[req_seq] = (op, vals, msg, flags)
             payload += msg
             req_seq += 1
 
@@ -1027,9 +1038,9 @@ class YnlFamily(SpecFamily):
             self._recv_dbg_print(reply, nms)
             for nl_msg in nms:
                 if nl_msg.nl_seq in reqs_by_seq:
-                    (op, req_msg, req_flags) = reqs_by_seq[nl_msg.nl_seq]
+                    (op, vals, req_msg, req_flags) = reqs_by_seq[nl_msg.nl_seq]
                     if nl_msg.extack:
-                        self._decode_extack(req_msg, op, nl_msg.extack)
+                        self._decode_extack(req_msg, op, nl_msg.extack, vals)
                 else:
                     op = None
                     req_flags = []
-- 
2.49.0


