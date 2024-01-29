Return-Path: <netdev+bounces-66888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F08415B5
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C483F1C23650
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0990524BA;
	Mon, 29 Jan 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTTlhBjM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7E51C3B;
	Mon, 29 Jan 2024 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567729; cv=none; b=PTllyVcCyj3o/6iVFC2c7/qgpA1dFCacdOyAN03X6ri0mIj7KAOdn4BUBMqaGpq7Pc4K7tY2XlXCKb4cVWLmSDjfwPD5/m9kIONZHDCecA5Ln8eEPZBjCMAQmqQtF4B8JRFbByQHRNJRHWCOgwHQNUJyX/J+AAIcW7xpwIxmmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567729; c=relaxed/simple;
	bh=hWx/ja2QPXjY1phmYXHcxIxn2UDyl08MO3R4pYjnO6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVbYWswXp8k2nXnGhEKFFtHunpkRhsSDDdh27d1Uk/hkmPUz00ORL1UULkXU8R/OMdjSlCUVfrF6g9rvoelMMhB60rZv/Jwu9Becf46Y8yjkD6xHWGgAn9qJjWbQE48wutSALd+w9OjCJTXss8y/ssrEcVQjg+Rx/Cgiji/xOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTTlhBjM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40f021d3f00so271065e9.0;
        Mon, 29 Jan 2024 14:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567726; x=1707172526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVmTeSgbnkcz+pALfFAGVh+BIbjfMn1ebWVGvNl/cfE=;
        b=JTTlhBjMBELQkFzdyWk8Z9/fRO7m/9vuKhBwh95eA0HK92X/Q3rKryAhB88csLW+zC
         7NirOK+neAKZyNh+OdN3LkxbiJoU60AZbDY3D2jB+9DgREM7hfwAZk4peRpmrP+/HAyX
         dE4h2qxKZ3TKvj+3fLqDYdfsgugbpuGQKiiQ52HdJEAHHFdHdqtnSP66xqeSgR787Wbd
         9O1dRfqXR9no/1fSaLslpCdEbwjXB8bLU80jGsY4jvT+/YFnm2d3cdLOBloYeLEpkVdO
         v3Id4F1XBnO1Y8RLMiIhrkY/w7tjfevJqBsI9FHT+e/2fL4vxudi2BVRMRUU0ZySPitC
         e7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567726; x=1707172526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVmTeSgbnkcz+pALfFAGVh+BIbjfMn1ebWVGvNl/cfE=;
        b=HKpChVdE507nBKCyuUf8J8IER5O6UCg/huY2XURu5XJ00C0hTbOtxx1PqHK1JTqB/e
         9z70aeqfHMnDB7lmOcI5u+DdrO8hG0T2JamrqCIo61eZQSZsoemb0t1D73kYLwQqdiPg
         /PoootjCb2vYOnv/sUde8Q46I3oVMFz36wkeXomYUq2Zq3UW2wDHn11U1JSQ4GOv/fTo
         apsCTcU1CzyYJeulZGsHpz3fzdyVAaEyPC0vYhbF9g7P/6dqiSo6jS2PhF4EtJpyPCh7
         7FEe+5+XukYQFjLJHXekeufCqZCUHPCl7X9ULoUPw3R4mokmD2/kvOL6OMNRPTwp24Xq
         XABA==
X-Gm-Message-State: AOJu0Yy9dhjpWQgiInhnnRgoUU08sBsFUyMQeaYfj6jQWbUgPgqFB8gn
	8qBBtv2X2bmYWfCT4aWe3QGIHaH1fEwpj3wG+CDk6FcA/eYz3+OHEGMz7OWYIv0=
X-Google-Smtp-Source: AGHT+IGM0/coxBJnjo+o1MWTQNKo7eLMj1fp1SMkGV8xwHedlPVV7WPIKMAGIyNPfN/ZChX1W6/ZVA==
X-Received: by 2002:a05:600c:5123:b0:40d:484e:935 with SMTP id o35-20020a05600c512300b0040d484e0935mr6009812wms.12.1706567726226;
        Mon, 29 Jan 2024 14:35:26 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:25 -0800 (PST)
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
Subject: [PATCH net-next v2 05/13] tools/net/ynl: Add support for encoding sub-messages
Date: Mon, 29 Jan 2024 22:34:50 +0000
Message-ID: <20240129223458.52046-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240129223458.52046-1-donald.hunter@gmail.com>
References: <20240129223458.52046-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sub-message encoding to ynl. This makes it possible to create
tc qdiscs and other polymorphic netlink objects.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index b22ddedb801b..b063094e8a4b 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -469,7 +469,7 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
-    def _add_attr(self, space, name, value):
+    def _add_attr(self, space, name, value, search_attrs):
         try:
             attr = self.attr_sets[space][name]
         except KeyError:
@@ -478,8 +478,10 @@ class YnlFamily(SpecFamily):
         if attr["type"] == 'nest':
             nl_type |= Netlink.NLA_F_NESTED
             attr_payload = b''
+            sub_attrs = SpaceAttrs(self.attr_sets[space], value, search_attrs)
             for subname, subvalue in value.items():
-                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue)
+                attr_payload += self._add_attr(attr['nested-attributes'],
+                                               subname, subvalue, sub_attrs)
         elif attr["type"] == 'flag':
             attr_payload = b''
         elif attr["type"] == 'string':
@@ -489,6 +491,8 @@ class YnlFamily(SpecFamily):
                 attr_payload = value
             elif isinstance(value, str):
                 attr_payload = bytes.fromhex(value)
+            elif isinstance(value, dict) and attr.struct_name:
+                attr_payload = self._encode_struct(attr.struct_name, value)
             else:
                 raise Exception(f'Unknown type for binary attribute, value: {value}')
         elif attr.is_auto_scalar:
@@ -501,6 +505,20 @@ class YnlFamily(SpecFamily):
             attr_payload = format.pack(int(value))
         elif attr['type'] in "bitfield32":
             attr_payload = struct.pack("II", int(value["value"]), int(value["selector"]))
+        elif attr['type'] == 'sub-message':
+            msg_format = self._resolve_selector(attr, search_attrs)
+            attr_payload = b''
+            if msg_format.fixed_header:
+                attr_payload += self._encode_struct(msg_format.fixed_header, value)
+            if msg_format.attr_set:
+                if msg_format.attr_set in self.attr_sets:
+                    nl_type |= Netlink.NLA_F_NESTED
+                    sub_attrs = SpaceAttrs(msg_format.attr_set, value, search_attrs)
+                    for subname, subvalue in value.items():
+                        attr_payload += self._add_attr(msg_format.attr_set,
+                                                       subname, subvalue, sub_attrs)
+                else:
+                    raise Exception(f"Unknown attribute-set '{msg_format.attr_set}'")
         else:
             raise Exception(f'Unknown type at {space} {name} {value} {attr["type"]}')
 
@@ -637,7 +655,7 @@ class YnlFamily(SpecFamily):
                     selector = self._decode_enum(selector, attr_spec)
                 decoded = {"value": value, "selector": selector}
             elif attr_spec["type"] == 'sub-message':
-                decoded = self._decode_sub_msg(attr, attr_spec, vals)
+                decoded = self._decode_sub_msg(attr, attr_spec, search_attrs)
             else:
                 if not self.process_unknown:
                     raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
@@ -795,8 +813,9 @@ class YnlFamily(SpecFamily):
         msg = self.nlproto.message(nl_flags, op.req_value, 1, req_seq)
         if op.fixed_header:
             msg += self._encode_struct(op.fixed_header, vals)
+        search_attrs = SpaceAttrs(op.attr_set, vals)
         for name, value in vals.items():
-            msg += self._add_attr(op.attr_set.name, name, value)
+            msg += self._add_attr(op.attr_set.name, name, value, search_attrs)
         msg = _genl_msg_finalize(msg)
 
         self.sock.send(msg, 0)
-- 
2.42.0


