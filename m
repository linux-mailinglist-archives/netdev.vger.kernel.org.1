Return-Path: <netdev+bounces-65106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3CA839438
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695821F27074
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBB4664BF;
	Tue, 23 Jan 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXLPA0LO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD664A89;
	Tue, 23 Jan 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025957; cv=none; b=nAuzX0ugssQ5vKDOA9oAgkhNiTK4KYe4naXYYKO0TkjGAIYgtde3SmYxfrjVF90F3j09Ch7dMKcWpw/fPJ03z7f7j8fH7bK092wOl8NghQRc0T2y+zbfQLapVlMHJ9gCBPgzs2aduUcD/WwuuhPI/tMtcYXzNtsu1epjxd7GpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025957; c=relaxed/simple;
	bh=mlIrTgzwyP094bcSNKK/Wi82s2TnOYwwyJfgh2GO+b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pjx3EVyDeeN6iPMfF1+c78/tXNEuM9exPTUCWe959YC1EBF6rqHkwgdqEK+ZTmsl/pbgRFvUxEAt0UyFeYHPO7y0j0MosRyH8mfZGjQ08MXde2BEYBh1GR0KHEr6pQxRFGQWeBtJuqkpXZTi4vQVM5SMABPUetqF80QQze5NPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXLPA0LO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e9d4ab5f3so48638715e9.2;
        Tue, 23 Jan 2024 08:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025953; x=1706630753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmRjBSuIOt9of23+aywKWiGP5DZrvI5CG2rVGVa0CCM=;
        b=MXLPA0LOzQzQIQxARWwliTOQPoHhc/B1wRfKa7Et6hEUK7zfS+X2/d5HHtHTxBnbXK
         8zleHftAUmCTNwLsOiFLBKJA5NcZxIClgo/89vUpEyoLh/ZmqJPEBs15TkqgzZdoYXKE
         x8M7DhSIODP021Re9J9uMMusZjmKleWgr17BbRgAAXLbqmGQ0wDCuF+MNYooI4FqyOg7
         bLK2BIzJz3f/djqAJsWkGSzjEAqbT/9Prf3awb01feaCJk97eRRhAH3AzFQCakccsVkL
         awGNzFDqcfdZqaRE57fOYe/zFwg2HSvolpZbtT5ctuT3vtusHjFo9j6Fu2HtqDIq+KjV
         Ah6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025953; x=1706630753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmRjBSuIOt9of23+aywKWiGP5DZrvI5CG2rVGVa0CCM=;
        b=WOi6wIsdDCIw1poxdZI6epksihsyvYn1H4nOuo9DcdRAwY9g5W1A6soKsm7W0IzDYI
         Cgxz+uwWC7YJE+d0g4jie0IFS4t2vMD7GcXdhG4qEhlN8Xyh3CUwqd1tm2HVNDfro5un
         +suTJCmN1rNDH66++qV20aC+w4kkbFv/8Ef17sBjwtH06NwuhvvxWsnlFLGDd4uLiSpa
         4ilQ3wV2gWWvQD9wKqWcZdTG7fEbl8gLKJ9LpPPurQ7USRtYUVpYXBb40ryNggHoaGNj
         GjO7DjS6Q6dJn88KJSE9Y70BEWYtJkBz4HFRmfW4fTdoxrsnJcY3979Ft1H1T4faWpRa
         0IVw==
X-Gm-Message-State: AOJu0YzdKh+HedXe4PIFd3OV1/HdnT4NFlraLXUF0yyIJEUO7mZ1qdA7
	6ihmE4uK74O55VuFsnaP3qRHHTExxQYAhnjNY0LN+UU0GBPSmAEif9x+q/OYnJgH6Ei5
X-Google-Smtp-Source: AGHT+IHIdmBFPUkjjawXnAaSg0gRMBmxJGXPieqLCocuQZ9Yg7Aq0eVudzXGg5+4GVHC56o4tW+MSQ==
X-Received: by 2002:a7b:c3d2:0:b0:40e:6d77:85f2 with SMTP id t18-20020a7bc3d2000000b0040e6d7785f2mr243665wmj.173.1706025952903;
        Tue, 23 Jan 2024 08:05:52 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:05:51 -0800 (PST)
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
Subject: [PATCH net-next v1 04/12] tools/net/ynl: Add support for encoding sub-messages
Date: Tue, 23 Jan 2024 16:05:30 +0000
Message-ID: <20240123160538.172-5-donald.hunter@gmail.com>
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

Add sub-message encoding to ynl. This makes it possible to create
tc qdiscs and other polymorphic netlink objects.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index dd54205f866f..d1005e662d52 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -449,7 +449,7 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
-    def _add_attr(self, space, name, value):
+    def _add_attr(self, space, name, value, vals):
         try:
             attr = self.attr_sets[space][name]
         except KeyError:
@@ -458,8 +458,10 @@ class YnlFamily(SpecFamily):
         if attr["type"] == 'nest':
             nl_type |= Netlink.NLA_F_NESTED
             attr_payload = b''
+            subvals = ChainMap(value, vals)
             for subname, subvalue in value.items():
-                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue)
+                attr_payload += self._add_attr(attr['nested-attributes'],
+                                               subname, subvalue, subvals)
         elif attr["type"] == 'flag':
             attr_payload = b''
         elif attr["type"] == 'string':
@@ -469,6 +471,8 @@ class YnlFamily(SpecFamily):
                 attr_payload = value
             elif isinstance(value, str):
                 attr_payload = bytes.fromhex(value)
+            elif isinstance(value, dict) and attr.struct_name:
+                attr_payload = self._encode_struct(attr.struct_name, value)
             else:
                 raise Exception(f'Unknown type for binary attribute, value: {value}')
         elif attr.is_auto_scalar:
@@ -481,6 +485,20 @@ class YnlFamily(SpecFamily):
             attr_payload = format.pack(int(value))
         elif attr['type'] in "bitfield32":
             attr_payload = struct.pack("II", int(value["value"]), int(value["selector"]))
+        elif attr['type'] == 'sub-message':
+            msg_format = self._resolve_selector(attr, vals)
+            attr_payload = b''
+            if msg_format.fixed_header:
+                attr_payload += self._encode_struct(msg_format.fixed_header, value)
+            if msg_format.attr_set:
+                if msg_format.attr_set in self.attr_sets:
+                    nl_type |= Netlink.NLA_F_NESTED
+                    subvals = ChainMap(value, vals)
+                    for subname, subvalue in value.items():
+                        attr_payload += self._add_attr(msg_format.attr_set,
+                                                       subname, subvalue, subvals)
+                else:
+                    raise Exception(f"Unknown attribute-set '{msg_format.attr_set}'")
         else:
             raise Exception(f'Unknown type at {space} {name} {value} {attr["type"]}')
 
@@ -777,7 +795,7 @@ class YnlFamily(SpecFamily):
         if op.fixed_header:
             msg += self._encode_struct(op.fixed_header, vals)
         for name, value in vals.items():
-            msg += self._add_attr(op.attr_set.name, name, value)
+            msg += self._add_attr(op.attr_set.name, name, value, vals)
         msg = _genl_msg_finalize(msg)
 
         self.sock.send(msg, 0)
-- 
2.42.0


