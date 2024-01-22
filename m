Return-Path: <netdev+bounces-64807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812EF83725A
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A650F1C2AD82
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E333DB86;
	Mon, 22 Jan 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR/0GZl8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9103DB84
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951160; cv=none; b=GtGXqQ+EG/ZWkj7Ojisj5Whbr8nTesEU/AiXEJoQ+ZZEwxulhClBB1IIzRzTh/GMIw2lp+9WK2aduIeo+Y2zplUCSfquqJe2mG9cqbra66QPT4uQatdtVAOkqaIZBDeM7S7uYXvAXUNK62LLQUBT1sMPXOK9XEmTBYQwsVpfxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951160; c=relaxed/simple;
	bh=UMu0ULEg0RSkhXHSeFI70UkeLGGrrkvDCyHYJy+rtd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD+yBsEBCw712/iZzbJexagrAeJqWvwwo2YLRyQIvOOVe1Dzk2MoGKxYqMceL1nKmFqKFmz/H+Wgay2XRMomt1HG9vvsUD0bH5exRni8pYEjukaoYxwPMtnB4FvYLV/1+jLn6aPkSh9BvMljnYI70yAMCOBemFnywRf+fZ4EWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR/0GZl8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33921b95dddso1648415f8f.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705951156; x=1706555956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSCdadprWeMVfFlh2AYZIyRk50xst4g5G77u6mF0zr4=;
        b=WR/0GZl8HXGFjHyqv1LaHiSHixEdP6q7GN56BMX2HXCDrGP9dJ/6k/5rd5PXKV/sHP
         5ZUjXb2No8wO1g/GF7BfHFA6qPD7hJwrou1qWg0rVzn3AOZ7hJKAsPYhFH+QHMVFsmbK
         rq7UOmUByJ/5iTS58FeJhSYycp1uh1tPqur4Wye37MJgYeUJId+mQ3s1KRhmqMN5MZd4
         Fuf1z+NQd/npCdSL1mfw6YDCqNW2JtCoeuOSMfQp9ny6fcs5Ny3LRn6pcbp0EIfF+G+g
         wkGWSbOSdy2tbNcwAWuO0s05vxc84i506dCxcw4/mTiZy6JmYAwlpZHliOCxIGk6h3Rg
         HdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705951156; x=1706555956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSCdadprWeMVfFlh2AYZIyRk50xst4g5G77u6mF0zr4=;
        b=YVfzl828VFlnr12KknWI+yRS1skQgdtTFg7H70brczICqAz7lusNN3XpZcBIlsr3w1
         FMJXwWxVnIGe2LjqeXY0QPtAC9TeVOywH1hw9nHPnF6Azcn7eBjtRwcIbEjYZqM3fAPY
         E4/EHQXziaKkvljH+WsH98HEpLpdzb1oXuCnyyOfo9d0pkR+K6Os0UoJd0yipFlK7T3e
         47SAgkFq7mWWJdoLE6UY8u/57JPPtTmjQ1sF3b3FmRUNs7G5k1WmbVlIHH87XINhc6LF
         22Y7j6GduW1GxCTeW0PVhOaOfd2rffYEeXK7ehqPwa2FWMeMNyKfwzqQfgdNC/0+VOfK
         pqmw==
X-Gm-Message-State: AOJu0YzuAJ28+gu+Ul8OGXY4HsHOdrHeZWL8m0vqC1AJokWjHAo7RWf3
	Uu9gYMRcts8W4D7IJDDNDOhMTNt9JhnTQoH7A97JbsrWX0RxTPv0
X-Google-Smtp-Source: AGHT+IHtNwK5E9ZQ8NyJi9eqCG6oaCAdzJRCrDwY/Ti+nZpQmZyYjbKKjjsCtG8qUeDjHUwjKe/Zpg==
X-Received: by 2002:adf:f18f:0:b0:337:6951:3e36 with SMTP id h15-20020adff18f000000b0033769513e36mr2079386wro.21.1705951156474;
        Mon, 22 Jan 2024 11:19:16 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b003392ba296b3sm6211104wry.56.2024.01.22.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:19:16 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH net-next 3/3] tools: ynl: add encoding support for 'sub-message' to ynl
Date: Mon, 22 Jan 2024 20:19:41 +0100
Message-ID: <0eedc19860e9b84f105c57d17219b3d0af3100d2.1705950652.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705950652.git.alessandromarcolini99@gmail.com>
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add encoding support for 'sub-message' attribute and for resolving
sub-message selectors at different nesting level from the key
attribute.

Also, add encoding support for multi-attr attributes.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 54 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 1e10512b2117..f8c56944f7e7 100644
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
@@ -458,8 +458,13 @@ class YnlFamily(SpecFamily):
         if attr["type"] == 'nest':
             nl_type |= Netlink.NLA_F_NESTED
             attr_payload = b''
-            for subname, subvalue in value.items():
-                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue)
+            # Check if it's a list of values (i.e. it contains multi-attr elements)
+            for subname, subvalue in (
+                ((k, v) for item in value for k, v in item.items())
+                if isinstance(value, list)
+                else value.items()
+            ):
+                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue, vals)
         elif attr["type"] == 'flag':
             attr_payload = b''
         elif attr["type"] == 'string':
@@ -481,6 +486,12 @@ class YnlFamily(SpecFamily):
             attr_payload = format.pack(int(value))
         elif attr['type'] in "bitfield32":
             attr_payload = struct.pack("II", int(value["value"]), int(value["selector"]))
+        elif attr['type'] == "sub-message":
+            spec = self._resolve_selector(attr, vals)
+            attr_spec = spec["attribute-set"]
+            attr_payload = b''
+            for subname, subvalue in value.items():
+                attr_payload += self._add_attr(attr_spec, subname, subvalue, vals)
         else:
             raise Exception(f'Unknown type at {space} {name} {value} {attr["type"]}')
 
@@ -555,9 +566,40 @@ class YnlFamily(SpecFamily):
         sub_msg_spec = self.sub_msgs[sub_msg]
 
         selector = attr_spec.selector
-        if selector not in vals:
+
+        def _find_attr_path(attr, vals, path=None):
+            if path is None:
+                path = []
+            if isinstance(vals, dict):
+                if attr in vals:
+                    return path
+                for k, v in vals.items():
+                    result = _find_attr_path(attr, v, path + [k])
+                    if result is not None:
+                        return result
+            elif isinstance(vals, list):
+                for idx, v in enumerate(vals):
+                    result = _find_attr_path(attr, v, path + [idx])
+                    if result is not None:
+                        return result
+            return None
+
+        def _find_selector_val(sel, vals, path):
+            while path != []:
+                v = vals.copy()
+                for step in path:
+                    v = v[step]
+                if sel in v:
+                    return v[sel]
+                path.pop()
+            return vals[sel] if sel in vals else None
+
+        attr_path = _find_attr_path(attr_spec.name, vals)
+        value = _find_selector_val(selector, vals, attr_path)
+
+        if value is None:
             raise Exception(f"There is no value for {selector} to resolve '{attr_spec.name}'")
-        value = vals[selector]
+
         if value not in sub_msg_spec.formats:
             raise Exception(f"No message format for '{value}' in sub-message spec '{sub_msg}'")
 
@@ -772,7 +814,7 @@ class YnlFamily(SpecFamily):
                     format = NlAttr.get_format(m.type, m.byte_order)
                     msg += format.pack(value)
         for name, value in vals.items():
-            msg += self._add_attr(op.attr_set.name, name, value)
+            msg += self._add_attr(op.attr_set.name, name, value, vals)
         msg = _genl_msg_finalize(msg)
 
         self.sock.send(msg, 0)
-- 
2.43.0


