Return-Path: <netdev+bounces-65104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252D4839433
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B11BB25E7F
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB9863510;
	Tue, 23 Jan 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhDNatIc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDF561665;
	Tue, 23 Jan 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025952; cv=none; b=mvm9VZzHU75c2pScjGcsqSbaJOEIUUaM3xU21xQlUZPyeuDDN9vFTVlw9EHlBGt0Ad3VRVXFqCh2Rt/3lbZtbcBRn0Zg4DWXFYZny3BzKpgnl8hvgVM+V6ziwkbx5lOMVWqix8B1iEoznfLInMnjF/6w6GQ9CJnrY/eZGLJoW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025952; c=relaxed/simple;
	bh=wGQ2wXJhQOmb+5CEhiazfvQGcY5+AUc3utMAHnbGSDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/a8sxP7CQLpPFSnXWBoN+POKMVirRxof0edxBgziUAOyuJqiMOizt3pLnbRZa93564UM1hejTwRVRlxQLdSzgVyFPM6emPabtuL6RWE619N64YN1MYR44N/yJ7YAnpLysgWoJXasJO1Qd3HLFJ2qrbtwj4hQLkOGPmyZwGD+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhDNatIc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ec3535225so2082475e9.2;
        Tue, 23 Jan 2024 08:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025948; x=1706630748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryo8HRjGnljrClxgJ6alqFUbKEiQl5mSg8DOiMtGabA=;
        b=UhDNatIcrosQRudbRn+3SWDdvdbsSf6gh4R/nMbx68rs4heRXPNGAl07b6HgzNiy1Q
         G4k3nHI/V7g5Jf2EXmUs1KXdYn6yxxdSvmKFpBU41bOPTBmMdJn66L7KH8asMDwO6VUm
         8hO+NssqRfZV0Rxv+/sTySTyVI7s3OnAQYP7vchH1/UF1aX9hrYYrpK10+MfFK9rCTZT
         rPgJnjRA2SqzN/8HzV6YCpBfbBBiRtKLc9D2emIXN9PAX6fhtvEC6ArVhCG4aTsrdu7s
         sYuJQLm699bq+KU5NWM8PA53nQlezocghFsUQwBGiphZM6gBsSVQwlmhuNBXTBHPgQ9h
         /Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025948; x=1706630748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryo8HRjGnljrClxgJ6alqFUbKEiQl5mSg8DOiMtGabA=;
        b=I+FBkZwun7HO9LNtVpoztEVklO7vRnxWqbyzTz/Upb5Y4xZvoBquzhLJJqFh3wyfVP
         TN0bZ1ksGRBknXSA6Tz7RBUQlhagj5Cy1G89CJ1qndKdrQkQ4TbKQS8DEL24gSOmHrfZ
         6Ha453dBzty1nxjyGm5FtILJx48vaM3r57zAwdNDWcx5l6K6lpw34ljgwI/wVihLaIcm
         bV0Ufrkkhmq+P7kj6+cP6gWE1UODdvXlUbWfAFSp7KKTGY/A2E4TVy6EN5cDpKLAjarN
         H8xPccaWDybVaWAK7Ifd7CudYNR4L0vbzLmC3jTw45YA6ECpBZhH8ipdHcwiEPI2kJea
         p5TA==
X-Gm-Message-State: AOJu0YzNzC59iw5ylApH+G5Hj5Bj2z7XXPSM/jPACsI+CBMc3DIx85sO
	AO+8DGBB1ObbMeU1WgioWsJyShD91qD3YG8u9lNhYsT+9XJk9aYcwcYpEjV+WvCh0Dry
X-Google-Smtp-Source: AGHT+IFb6wjAXVE63pR4TcjrddfzxSW/TyWAnily9aK+fHwnkXOCPpNqBbqDhvk1YOQmaqaY+hTPfg==
X-Received: by 2002:a05:600c:33aa:b0:40e:4f69:323d with SMTP id o42-20020a05600c33aa00b0040e4f69323dmr362117wmp.248.1706025948360;
        Tue, 23 Jan 2024 08:05:48 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:05:46 -0800 (PST)
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
Subject: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages in nested attribute spaces
Date: Tue, 23 Jan 2024 16:05:28 +0000
Message-ID: <20240123160538.172-3-donald.hunter@gmail.com>
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

Sub-message selectors could only be resolved using values from the
current nest level. Enable value lookup in outer scopes by using
collections.ChainMap to implement an ordered lookup from nested to
outer scopes.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 1e10512b2117..b00cde5d29e5 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
-from collections import namedtuple
+from collections import namedtuple, ChainMap
 import functools
 import os
 import random
@@ -564,8 +564,8 @@ class YnlFamily(SpecFamily):
         spec = sub_msg_spec.formats[value]
         return spec
 
-    def _decode_sub_msg(self, attr, attr_spec, rsp):
-        msg_format = self._resolve_selector(attr_spec, rsp)
+    def _decode_sub_msg(self, attr, attr_spec, vals):
+        msg_format = self._resolve_selector(attr_spec, vals)
         decoded = {}
         offset = 0
         if msg_format.fixed_header:
@@ -579,10 +579,11 @@ class YnlFamily(SpecFamily):
                 raise Exception(f"Unknown attribute-set '{attr_space}' when decoding '{attr_spec.name}'")
         return decoded
 
-    def _decode(self, attrs, space):
+    def _decode(self, attrs, space, outer_vals = ChainMap()):
         if space:
             attr_space = self.attr_sets[space]
         rsp = dict()
+        vals = ChainMap(rsp, outer_vals)
         for attr in attrs:
             try:
                 attr_spec = attr_space.attrs_by_val[attr.type]
@@ -594,7 +595,7 @@ class YnlFamily(SpecFamily):
                 continue
 
             if attr_spec["type"] == 'nest':
-                subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'])
+                subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'], vals)
                 decoded = subdict
             elif attr_spec["type"] == 'string':
                 decoded = attr.as_strz()
@@ -617,7 +618,7 @@ class YnlFamily(SpecFamily):
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


