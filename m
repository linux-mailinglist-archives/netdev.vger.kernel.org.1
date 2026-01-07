Return-Path: <netdev+bounces-247699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68ADCFDA61
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10F4F301355C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1061D314D36;
	Wed,  7 Jan 2026 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqFZrfiJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08339314A89
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788531; cv=none; b=omWeLVDXo84csBqIlgkQnzuId4KnsIdvvKOvz5Ejk3rpELCwmmFzh+5IN/jDz+bv4Pt4BKtD68hPAekcmW2cCqxhP6tzRVv+wfaVgQFmc64XtRMyjzyvxokQn042ShlOOegIxFSB9KFpKwc4cDIAU2Wm6PaEF1Yd73iCl9OLnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788531; c=relaxed/simple;
	bh=Z8lU+lVRqMll2t2yBZHnwVVk/18mACZNcR+H/6PbCKU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huWjxnO1WwOxamSzpsGvz1slJWRKsXjJftSE2tudH2fRmfRulpDzFbTjQgrRGUDClahrrHt1YvRmedtuMzu48vulkaGvrSjwgDnKB9uEL0ghZSFHgt2lHuyGgpauKQ0EaHBU3X+N4k2xYxqYn++7ITOzegL9D3KOx/IImgVvpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqFZrfiJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so1180004f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788528; x=1768393328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvuKTS5WXlUzFAytHIWkLOWY6H71+YVDPc5+q2gdMe8=;
        b=eqFZrfiJNOaRe306DzYqdwjVwvpFiJ1dqIDHvXY5U5BJnwjaZEHqWdfE+WVYBY25DQ
         Zl3Rpz9JP9viLjSvaKV5Pw/g9CKbitix3HE3Cg7O6P/TSav0vSre3YYAOZwvT7/Tw2RV
         ky5wqYhoRTE1QBZTpC67WRQB/Z1032JAEomxJIK3vgRnua5mEXMc9u2pTd/CQweFKGeN
         pCQNI9lQj8EX8QPqWm8uOfC02zkSrUoCyd66Ks3UgcVYEOXq9kRpFXjm+9VN/UMtpXHV
         n+u/H+OPowpLA7uNIZWUa3IvmOkTFjKH1TIEyfHt1j+gG/RJVN89HuM59GLJP1xvEQB5
         q2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788528; x=1768393328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JvuKTS5WXlUzFAytHIWkLOWY6H71+YVDPc5+q2gdMe8=;
        b=ZyBan7w0TUypyW2ZPSwn8THWcvpZ701tuB0pkhmdWoQcWMbhDksLT5ofrF8fD/rOLB
         aJerJB4ush99NuUGaBNwWCWSBTEWQj7U4/2s8gja0KQKL4bjgq89mCiJFxOdNchIWWXG
         y0p4H3WXszWMDOhJrn0YC1xXDJ1VX3ks1ai4/Br0Z7/yrbI+gP7q2iLinL5a91NeqqJO
         1bZoVCXaz37CIZTN4ZZCMyVMs8RiDu7WO+WJbhxgizHYl9lNZA9JifMQxQEQHJrB4NRM
         leG4jKGnGYXlYlAo61YR3psgaS3ogAztbfQ1R/8PWi48zBwwseQTOoNpaB8DRmT/MYz4
         9how==
X-Forwarded-Encrypted: i=1; AJvYcCWE8Ski8ZsKKr7RgFvmVFaUpRw5YBrRGnS7vJjXfUO2NKOK6I8reC3efVLwhx+VHvLuYpD1+RY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzqwr1aBiNd3FfNBS6LhmLw9ZeXjerF6EDEsHASG3rDOTJecWm
	AAO96jbw5tZsMArz3eg4sMEJwVnW7je58vyPfQ+x3FLBS1BS53UAcE/q
X-Gm-Gg: AY/fxX5c6ETlS0PdPCzwvFKndrIjuwBHNVauzqOEQwKlWjIEFVHOhDDyHzgBs/FQ+HA
	Hk2O94I82yS5QlcPyKtSGf3i2zevhHswy0q/4d2ENinC+mLgRwW/16WeYtifzY1CNRLGjOZDDCc
	IYgHRicgqB04OkG2vXUe2DlA/Pxc8KsDAosNPa3n7ZXPleOgjVcq1l98FvlfUy1e1/idC+jW2Iw
	fk6HhhuAH4RdxckYbB1VB1AzGbAiqEzgteX9q2/IxwafiDFPKnRkvH6xX0sX3gM3OJ+KEJyGfZa
	DX/IXuDeG84WXla5bfFUfVsVvaczKyLM+rKmwFGDhquSOQHi7n5fvVnhTnt1m+EQcu5NIS+K6DV
	TQVIat2AkjTEzSRzfzAyhPY+8dROmU/w/YvaqyH+4z2ZgaBWZpWpIfs7hXLS9YIdI2rdP7Jl/VN
	j7sreOuWCKKqPB9yZmzbmvo/hHu8lK
X-Google-Smtp-Source: AGHT+IG49S9OlbgA7OyNRTGOxx+sxRViIeG9mHSX6HZATY2X57l0sdOYRUNyVUzhTrx4ePvFdyuzqw==
X-Received: by 2002:a05:6000:310d:b0:431:7a0:dbc3 with SMTP id ffacd0b85a97d-432c37983eamr3100402f8f.29.1767788528202;
        Wed, 07 Jan 2026 04:22:08 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:07 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ruben Wauters <rubenru09@aol.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v1 05/13] tools: ynl: fix pylint misc warnings
Date: Wed,  7 Jan 2026 12:21:35 +0000
Message-ID: <20260107122143.93810-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107122143.93810-1-donald.hunter@gmail.com>
References: <20260107122143.93810-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix pylint warnings for:

- unused-argument
- consider-using-in
- consider-using-get
- consider-using-f-string
- protected-access
- unidiomatic-typecheck
- no-else-return

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/doc_generator.py |  3 +--
 tools/net/ynl/pyynl/lib/nlspec.py        |  5 ++---
 tools/net/ynl/pyynl/lib/ynl.py           | 16 ++++++++--------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index 3a16b8eb01ca..d1afff9d9956 100644
--- a/tools/net/ynl/pyynl/lib/doc_generator.py
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -109,8 +109,7 @@ class RstFormatters:
                     'fixed-header': 'definition',
                     'nested-attributes': 'attribute-set',
                     'struct': 'definition'}
-        if prefix in mappings:
-            prefix = mappings[prefix]
+        prefix = mappings.get(prefix, prefix)
         return f":ref:`{namespace}-{prefix}-{name}`"
 
     def rst_header(self) -> str:
diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index fcd4106d0cfa..f3173146b64b 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -105,8 +105,7 @@ class SpecEnumEntry(SpecElement):
     def user_value(self, as_flags=None):
         if self.enum_set['type'] == 'flags' or as_flags:
             return 1 << self.value
-        else:
-            return self.value
+        return self.value
 
 
 class SpecEnumSet(SpecElement):
@@ -194,7 +193,7 @@ class SpecAttr(SpecElement):
         self.sub_message = yaml.get('sub-message')
         self.selector = yaml.get('selector')
 
-        self.is_auto_scalar = self.type == "sint" or self.type == "uint"
+        self.is_auto_scalar = self.type in ("sint", "uint")
 
 
 class SpecAttrSet(SpecElement):
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 49c35568ceba..2ad954f885f3 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -415,7 +415,7 @@ class NetlinkProtocol:
         nlmsg = struct.pack("HHII", nl_type, nl_flags, seq, 0)
         return nlmsg
 
-    def message(self, flags, command, version, seq=None):
+    def message(self, flags, command, _version, seq=None):
         return self._message(command, flags, seq)
 
     def _decode(self, nl_msg):
@@ -425,7 +425,7 @@ class NetlinkProtocol:
         msg = self._decode(nl_msg)
         if op is None:
             op = ynl.rsp_by_value[msg.cmd()]
-        fixed_header_size = ynl._struct_size(op.fixed_header)
+        fixed_header_size = ynl.struct_size(op.fixed_header)
         msg.raw_attrs = NlAttrs(msg.raw, fixed_header_size)
         return msg
 
@@ -755,7 +755,7 @@ class YnlFamily(SpecFamily):
 
     def _rsp_add(self, rsp, name, is_multi, decoded):
         if is_multi is None:
-            if name in rsp and type(rsp[name]) is not list:
+            if name in rsp and not isinstance(rsp[name], list):
                 rsp[name] = [rsp[name]]
                 is_multi = True
             else:
@@ -788,7 +788,7 @@ class YnlFamily(SpecFamily):
         offset = 0
         if msg_format.fixed_header:
             decoded.update(self._decode_struct(attr.raw, msg_format.fixed_header))
-            offset = self._struct_size(msg_format.fixed_header)
+            offset = self.struct_size(msg_format.fixed_header)
         if msg_format.attr_set:
             if msg_format.attr_set in self.attr_sets:
                 subdict = self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set)
@@ -908,7 +908,7 @@ class YnlFamily(SpecFamily):
             return
 
         msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set), op)
-        offset = self.nlproto.msghdr_size() + self._struct_size(op.fixed_header)
+        offset = self.nlproto.msghdr_size() + self.struct_size(op.fixed_header)
         search_attrs = SpaceAttrs(op.attr_set, vals)
         path = self._decode_extack_path(msg.raw_attrs, op.attr_set, offset,
                                         extack['bad-attr-offs'], search_attrs)
@@ -916,14 +916,14 @@ class YnlFamily(SpecFamily):
             del extack['bad-attr-offs']
             extack['bad-attr'] = path
 
-    def _struct_size(self, name):
+    def struct_size(self, name):
         if name:
             members = self.consts[name].members
             size = 0
             for m in members:
                 if m.type in ['pad', 'binary']:
                     if m.struct:
-                        size += self._struct_size(m.struct)
+                        size += self.struct_size(m.struct)
                     else:
                         size += m.len
                 else:
@@ -987,7 +987,7 @@ class YnlFamily(SpecFamily):
 
     def _formatted_string(self, raw, display_hint):
         if display_hint == 'mac':
-            formatted = ':'.join('%02x' % b for b in raw)
+            formatted = ':'.join(f'{b:x}' for b in raw)
         elif display_hint == 'hex':
             if isinstance(raw, int):
                 formatted = hex(raw)
-- 
2.52.0


