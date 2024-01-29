Return-Path: <netdev+bounces-66885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D2D8415B0
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6764A1C22C72
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CFE50A9D;
	Mon, 29 Jan 2024 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqNUE7Eu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D54C605;
	Mon, 29 Jan 2024 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567726; cv=none; b=gzyErETW0Qe7ApAYtHYHSkTf94jQcN7PeTRya7APSoJxDmK6UgqvV522bbaLg5cAozqKXqTVi4XhifkcUCLPRl2Pj1dljuxABlGlS4725D/x4AZprdM92W+EtUEiUSxai641Fm+vZhO700LzF5YE+py45sNThneBbpH6dBIUfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567726; c=relaxed/simple;
	bh=oXNIrlpbTKUfQPJHUWPw/qMK/7MKjDVQDLOBMzrF0IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9L3t+GeK1zPP7D9LM7aiwaV6Y3mFbSNRSLx3NFP39JKbRCJ9eqm4DbNMF8s3FZlY/FT+jL2Uh7YQ6hokndF2BcedBHkdLvtKOhffs4xmLX+EfMbd4NLZOFzmzwXG/UBqaXWEzBMqq5PGvMNM7P+KKhsbqiDxsTKA/Oy+KGUmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqNUE7Eu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e80046264so43562575e9.0;
        Mon, 29 Jan 2024 14:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567723; x=1707172523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpynuJh5fIDOf0QfYdr4oU7DJfOhE7bZIxOiGaTAD6k=;
        b=WqNUE7EuNWkeTiaC2RU/HHJ/TCnSJ2EOHdLx0qsFZp6eGmsQbimrWFrEpT/es6W4cF
         C7VOE2hPoPSiwxLyx2gHmQDVBQhc57ndrDKx+y9Plq//G5eX29ibArOby5PEMAYQL3Yo
         slET/8U7obz/IyrC7+6lsPtK0dkNa/5widKHwJiY5zrtE8LGm1v2AT7ACbiZiLe05BwT
         3wFv0DApQVA84h0iQXmuGBLz27F9iG2B7ezj8QBfbDRcpaGJpyY9trbzhVtwcN6jAW9z
         HOTz7gyw+BW1WddvV6c4tiww8wlj20GGjGJAd2cBDGYo5u9qvN0MmtamzLp4G8qtiiqw
         lLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567723; x=1707172523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpynuJh5fIDOf0QfYdr4oU7DJfOhE7bZIxOiGaTAD6k=;
        b=akDBXGNwEdZfCo7xlTGSIP5a41qMk8f+zL0D+q39lor9kyKymv6q5Oi//PpM28Lr7I
         PSxO+OXVAnHjAxjNGWRieNibSRk0PvaKCeIc8uIcge1LZ7e7M9UuLIe6/6bKqwn7kQSh
         0u0JX/lN9KRO+n0NGW+7l1MD0xuazNYiotJiNtVdVyPvIMLSurvJOEvJdioP2EXBfxVh
         fMOpguF2fHlY/JtVohQCpgF9bHdz9YDbzck1/zpdEo96ufeWy+RJLB6IHSKdeGcYpOHF
         P6TsRa1wPWJJVo4afqDDgLbRrHWzCci4rHhHiEO2T3/rYUQkJ11QeEOE10mQK39kejC0
         Hq7g==
X-Gm-Message-State: AOJu0YxqUI23ott2IpEIhX5SZM3XN0U621RMpLHh8QKZf8hIg7YnP0WR
	jZLGhOW2pzGaiNzYlQOvkaMIdWs41HGy7JmK7n2VfMCEu99r3SBB45iEF9ZwYqk=
X-Google-Smtp-Source: AGHT+IHG9MErHJA7U+Wc/9sc0vHLk2YYL7mOOugOzMChMBzbKoVWBOn3LtmURMNsWb87Arv7+5bjug==
X-Received: by 2002:a05:600c:3c82:b0:40e:c6ae:3c88 with SMTP id bg2-20020a05600c3c8200b0040ec6ae3c88mr5651589wmb.35.1706567722943;
        Mon, 29 Jan 2024 14:35:22 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:22 -0800 (PST)
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
Subject: [PATCH net-next v2 02/13] tools/net/ynl: Support sub-messages in nested attribute spaces
Date: Mon, 29 Jan 2024 22:34:47 +0000
Message-ID: <20240129223458.52046-3-donald.hunter@gmail.com>
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

Sub-message selectors could only be resolved using values from the
current nest level. Enable value lookup in outer scopes by using
collections.ChainMap to implement an ordered lookup from nested to
outer scopes.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 1e10512b2117..f24581759acf 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -405,6 +405,26 @@ class GenlProtocol(NetlinkProtocol):
         return self.genl_family['mcast'][mcast_name]
 
 
+
+class SpaceAttrs:
+    SpecValuesPair = namedtuple('SpecValuesPair', ['spec', 'values'])
+
+    def __init__(self, attr_space, attrs, outer = None):
+        outer_scopes = outer.scopes if outer else []
+        inner_scope = self.SpecValuesPair(attr_space, attrs)
+        self.scopes = [inner_scope] + outer_scopes
+
+    def lookup(self, name):
+        for scope in self.scopes:
+            if name in scope.spec:
+                if name in scope.values:
+                    return scope.values[name]
+                spec_name = scope.spec.yaml['name']
+                raise Exception(
+                    f"No value for '{name}' in attribute space '{spec_name}'")
+        raise Exception(f"Attribute '{name}' not defined in any attribute-set")
+
+
 #
 # YNL implementation details.
 #
@@ -548,24 +568,22 @@ class YnlFamily(SpecFamily):
         else:
             rsp[name] = [decoded]
 
-    def _resolve_selector(self, attr_spec, vals):
+    def _resolve_selector(self, attr_spec, search_attrs):
         sub_msg = attr_spec.sub_message
         if sub_msg not in self.sub_msgs:
             raise Exception(f"No sub-message spec named {sub_msg} for {attr_spec.name}")
         sub_msg_spec = self.sub_msgs[sub_msg]
 
         selector = attr_spec.selector
-        if selector not in vals:
-            raise Exception(f"There is no value for {selector} to resolve '{attr_spec.name}'")
-        value = vals[selector]
+        value = search_attrs.lookup(selector)
         if value not in sub_msg_spec.formats:
             raise Exception(f"No message format for '{value}' in sub-message spec '{sub_msg}'")
 
         spec = sub_msg_spec.formats[value]
         return spec
 
-    def _decode_sub_msg(self, attr, attr_spec, rsp):
-        msg_format = self._resolve_selector(attr_spec, rsp)
+    def _decode_sub_msg(self, attr, attr_spec, search_attrs):
+        msg_format = self._resolve_selector(attr_spec, search_attrs)
         decoded = {}
         offset = 0
         if msg_format.fixed_header:
@@ -579,10 +597,12 @@ class YnlFamily(SpecFamily):
                 raise Exception(f"Unknown attribute-set '{attr_space}' when decoding '{attr_spec.name}'")
         return decoded
 
-    def _decode(self, attrs, space):
+    def _decode(self, attrs, space, outer_attrs = None):
         if space:
             attr_space = self.attr_sets[space]
         rsp = dict()
+        search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
+
         for attr in attrs:
             try:
                 attr_spec = attr_space.attrs_by_val[attr.type]
@@ -594,7 +614,7 @@ class YnlFamily(SpecFamily):
                 continue
 
             if attr_spec["type"] == 'nest':
-                subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'])
+                subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'], search_attrs)
                 decoded = subdict
             elif attr_spec["type"] == 'string':
                 decoded = attr.as_strz()
@@ -617,7 +637,7 @@ class YnlFamily(SpecFamily):
                     selector = self._decode_enum(selector, attr_spec)
                 decoded = {"value": value, "selector": selector}
             elif attr_spec["type"] == 'sub-message':
-                decoded = self._decode_sub_msg(attr, attr_spec, rsp)
+                decoded = self._decode_sub_msg(attr, attr_spec, vals)
             else:
                 if not self.process_unknown:
                     raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
-- 
2.42.0


