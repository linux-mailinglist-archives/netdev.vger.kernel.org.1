Return-Path: <netdev+bounces-65108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A99383943E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB1D1C233FF
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F459664C5;
	Tue, 23 Jan 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMsccCWd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1349664D8;
	Tue, 23 Jan 2024 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025961; cv=none; b=cjwaG6Ni8EjJb8FMMFKgLMLab4LR0HfWqQpVApstasb9PrTWq25t6NwabzWQFP4BNrv4owzlpUhQ/v0zrEVeRneieJwQGUyJRDqAapxzOZ8U36TO0j3ka/BudZRL3Kk5TNYikesZSHT5z4bqtVjIjPcTHQwtnB327oLNXe+D6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025961; c=relaxed/simple;
	bh=tIgGv0KnVH34ruV1fjg9Mtf0x/61cO/Fe0Eyu66IMTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LA+5KvZRRcDOWnSjTvWKEjokYC6N4e2d89LJmyZTtoMAS5uIvn9ycRabf3cGu4cunk73On0tXbioTeQiqHvliTc5mdkWCp07AgzvVNlPXpDuyrErCrCt20VdzjY/6MiVcRYWmeWMdcq7m6mHFr+ZI00fr4KFKHTIOVgaqx83xyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMsccCWd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so53693925e9.0;
        Tue, 23 Jan 2024 08:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025957; x=1706630757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCehdhBo3wRBwnltXd+8d4qQNNR8hWcRbU494BI0zoQ=;
        b=BMsccCWd73U7hcmh9OGi5H3T8txc98rCX2+Udn0/QkBIdBIl/qiXzsZW8uLjUbe8EF
         YN+LCFzjpCvZYn3JUnzLH8LK5GH/CCmpp4sXy6uqeMtSfkDQJTs4ti44192MT2D3alkP
         VopAHugkXaNDfNFBJhW/7MdquoC7mMWBZoLToTqh5/zSajicsNF4yq3jYcat+4XvGDzb
         mQdi1ojbjosRzKj7K7F4L4hdfk+55INDVwmb1K642VVhPM2uu/Z5v0FW8fZQisXIcTPL
         3lL6IT8uxL/ipSt2Wb06FoAUI7G36tzLq40RCtrrvoZ21D49XIsSKz0kHDxXTCJm4jax
         3QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025957; x=1706630757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCehdhBo3wRBwnltXd+8d4qQNNR8hWcRbU494BI0zoQ=;
        b=OcDFy2Zn5iNVdNe3dlJpVqZ+C+b6GoO5/ft7vB/tUE308olEw7gU+AnmG+LD8ypZDX
         wjKY4EkVQcOpX38kGYbhjIPpDll6XE1uPg8NOVqCAG4msaEsLVqcdInTVF1iNZFN0caQ
         hIJ9LqQG+k7gCacx6G477dqVQAHP11jZA6AK2N5n6UAdQw8jPrA0hFxeiMNBAoXu7Bb+
         vNe003sjw7V1nbOjR11eMT7xmwXcantbb7ogbNFhtfWPZL0zEaK8iE7A6R3SbmdSzFYF
         rpCsAxCU8CtygJBQYMIKCvyfjxd/XtgOj4G8gjUi0HZw8YYpEvafuPLEUn/JEXm154fT
         gFRA==
X-Gm-Message-State: AOJu0Yy8qF061OqJDlO/PldI28yhVdEZh2+OFv2oEhuBeCuhIAc1ijSe
	xHJ0MTSlOdl3+31wNa4jKZSyOVFFbgbOFV86CcxpjkME2bTpj5Dse1dZAVRzc6QQfqcd
X-Google-Smtp-Source: AGHT+IFMdkztQgn4VQ/FB7qB6rWQNCRu91RHvCEahY2eeE+9mvpuqq/3dtRyZU/l5V7RlWEGNVi7yw==
X-Received: by 2002:a1c:7318:0:b0:40e:448a:b4d9 with SMTP id d24-20020a1c7318000000b0040e448ab4d9mr194974wmb.257.1706025956696;
        Tue, 23 Jan 2024 08:05:56 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:05:55 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 06/12] tools/net/ynl: Combine struct decoding logic in ynl
Date: Tue, 23 Jan 2024 16:05:32 +0000
Message-ID: <20240123160538.172-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240123160538.172-1-donald.hunter@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_decode_fixed_header() and NlAttr.as_struct() both implemented struct
decoding logic. Deduplicate the code into newly named _decode_struct()
method.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 47 ++++++++++++----------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index ea4638c56802..cc1106cbe8a6 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -148,23 +148,6 @@ class NlAttr:
         format = self.get_format(type)
         return [ x[0] for x in format.iter_unpack(self.raw) ]
 
-    def as_struct(self, members):
-        value = dict()
-        offset = 0
-        for m in members:
-            # TODO: handle non-scalar members
-            if m.type == 'binary':
-                decoded = self.raw[offset : offset + m['len']]
-                offset += m['len']
-            elif m.type in NlAttr.type_formats:
-                format = self.get_format(m.type, m.byte_order)
-                [ decoded ] = format.unpack_from(self.raw, offset)
-                offset += format.size
-            if m.display_hint:
-                decoded = self.formatted_string(decoded, m.display_hint)
-            value[m.name] = decoded
-        return value
-
     def __repr__(self):
         return f"[type:{self.type} len:{self._len}] {self.raw}"
 
@@ -521,11 +504,7 @@ class YnlFamily(SpecFamily):
 
     def _decode_binary(self, attr, attr_spec):
         if attr_spec.struct_name:
-            members = self.consts[attr_spec.struct_name]
-            decoded = attr.as_struct(members)
-            for m in members:
-                if m.enum:
-                    decoded[m.name] = self._decode_enum(decoded[m.name], m)
+            decoded = self._decode_struct(attr.raw, attr_spec.struct_name)
         elif attr_spec.sub_type:
             decoded = attr.as_c_array(attr_spec.sub_type)
         else:
@@ -587,7 +566,7 @@ class YnlFamily(SpecFamily):
         decoded = {}
         offset = 0
         if msg_format.fixed_header:
-            decoded.update(self._decode_fixed_header(attr, msg_format.fixed_header));
+            decoded.update(self._decode_struct(attr.raw, msg_format.fixed_header));
             offset = self._fixed_header_size(msg_format.fixed_header)
         if msg_format.attr_set:
             if msg_format.attr_set in self.attr_sets:
@@ -698,26 +677,28 @@ class YnlFamily(SpecFamily):
         else:
             return 0
 
-    def _decode_fixed_header(self, msg, name):
-        fixed_header_members = self.consts[name].members
-        fixed_header_attrs = dict()
+    def _decode_struct(self, data, name):
+        members = self.consts[name].members
+        attrs = dict()
         offset = 0
-        for m in fixed_header_members:
+        for m in members:
             value = None
             if m.type == 'pad':
                 offset += m.len
             elif m.type == 'binary':
-                value = msg.raw[offset : offset + m.len]
+                value = data[offset : offset + m.len]
                 offset += m.len
             else:
                 format = NlAttr.get_format(m.type, m.byte_order)
-                [ value ] = format.unpack_from(msg.raw, offset)
+                [ value ] = format.unpack_from(data, offset)
                 offset += format.size
             if value is not None:
                 if m.enum:
                     value = self._decode_enum(value, m)
-                fixed_header_attrs[m.name] = value
-        return fixed_header_attrs
+                elif m.display_hint:
+                    value = NlAttr.formatted_string(value, m.display_hint)
+                attrs[m.name] = value
+        return attrs
 
     def _encode_struct(self, name, vals):
         members = self.consts[name].members
@@ -745,7 +726,7 @@ class YnlFamily(SpecFamily):
         op = self.rsp_by_value[decoded.cmd()]
         attrs = self._decode(decoded.raw_attrs, op.attr_set.name)
         if op.fixed_header:
-            attrs.update(self._decode_fixed_header(decoded, op.fixed_header))
+            attrs.update(self._decode_struct(decoded.raw, op.fixed_header))
 
         msg['name'] = op['name']
         msg['msg'] = attrs
@@ -836,7 +817,7 @@ class YnlFamily(SpecFamily):
 
                 rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
                 if op.fixed_header:
-                    rsp_msg.update(self._decode_fixed_header(decoded, op.fixed_header))
+                    rsp_msg.update(self._decode_struct(decoded.raw, op.fixed_header))
                 rsp.append(rsp_msg)
 
         if not rsp:
-- 
2.42.0


