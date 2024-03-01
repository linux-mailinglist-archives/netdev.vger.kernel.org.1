Return-Path: <netdev+bounces-76647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11AE86E6FA
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF6F1C228C3
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A5EBE76;
	Fri,  1 Mar 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBWHhVZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418E883B
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313285; cv=none; b=mAdvCrOVe7OWorkb90eKex/a3j47cC+pYooZJ0423pzVV8CS+dcEXjARNmBLeN3fTj9OhSvY/IPvQEDWqzhNO8ZREIRTFZeqIpX5fGlAxEuw9/1BTUnV54P3bO8SrD44eYYdQ17l541wyh4t7Eo3SnqbFPCjfxmE9xCd7wRiqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313285; c=relaxed/simple;
	bh=ITuzUrJ3LP04wRnLQqcNN+gf5uuq5gxvhzZLVz1+Jo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdFRPqTcb9m27YvVIehEDzcve1BBax4HL1Sj2gsqVnrHoiD01+7P5pdzW794T4RrW9RPjZsxS1nDxvzLb0VIzwWUbmLsji2AqwJQD2lEQ5J/DrHseCy6heO00T6XrguokNtQ0xx9W0VRQDGiZviZEkhLBfYvmBtbdj+R0WJ0GUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBWHhVZF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so21170015e9.0
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 09:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709313281; x=1709918081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dwjYerr/y8Vv41J2to9nLIRNF2G1qLwh4ctTCr/G/o=;
        b=QBWHhVZFKtp0j1w0QFxr9+3o+H5eIPd9+uddJ280BSa8VLuZPjxDt0yziV06qHGBRx
         77PewdJZbXXxmzQCt7k585iEEwx57a/QtDEJB1GYFGFrHbjvsP5ZG6W9Bmf/e7LrE5s1
         odUlzfaJZLSFd733z2z8v5Xs16ICL8cfspJrRx3szZXfDvT0cRuiP2ePfqjKdeY2fjtt
         tM1LY60KCkCEUMXoMiWoBptvEN9md9S04jPbhCK8vV7fDqOfPWb4dBLkYyOCsDlo8VEK
         2mL9gwqybY/pOFQenQ+toh9XFJeO8IvWiGuI1YBLIikyq1FkEQITl3aRicuOXd1CpEQz
         bIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313281; x=1709918081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dwjYerr/y8Vv41J2to9nLIRNF2G1qLwh4ctTCr/G/o=;
        b=irqM1GBWnpaRI3T8n9xEdsHEppkow7KF6uF7PvXVVjv/Pas+inkF7BqO0Py1yuP5In
         GEFDxxEXbsMYwQIkaChlSJoJqNnrLDM6ASBa7VDtXaNDryTxAhOgsVVNQSWm8/dzI7Eu
         OP+6i3x5h19EqfudqiwF8uDmhYcOGc9HxobNJ3i5FUPp/B8IRuzcURwQOElremqa3WMD
         YsZwUD20pEYDXSfqdex9eBiFQJ0Jrvqof2rUsTOcx8wQayq+ChdCJcypjSx5SRXBp8Fn
         mKWVmHLphF2NAY+uRrWf2mdvOXrvJDZvdHbdB/D3nQBCIyREpHtUY9JeG0EbibAesnJL
         nxFA==
X-Gm-Message-State: AOJu0YxmXJOagobi6o2aWZHDqD0T7hhOR2v1Scm3LeFmp2/VofOTRco1
	ac0nrFZJMgYCDHZfoZr/9kUyM1EsOEFDeGAk8xr357Vbzgxn9I65GIaA/xfJJRE=
X-Google-Smtp-Source: AGHT+IHbXytC+GSMu9Y0ikZKwWS7Wf+ypPJ4inCvhoA2hs+gCwLkTgKX+oheVUizuTeSvGOYOg0Dtw==
X-Received: by 2002:a05:600c:4fc6:b0:412:b237:346e with SMTP id o6-20020a05600c4fc600b00412b237346emr2744383wmq.20.1709313281564;
        Fri, 01 Mar 2024 09:14:41 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:c06e:e547:41d1:e2b2])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600003c800b0033e17ff60e4sm3387556wrg.7.2024.03.01.09.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:14:40 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 3/4] tools/net/ynl: Extend array-nest for multi level nesting
Date: Fri,  1 Mar 2024 17:14:30 +0000
Message-ID: <20240301171431.65892-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240301171431.65892-1-donald.hunter@gmail.com>
References: <20240301171431.65892-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nlctrl family uses 2 levels of array nesting for policy attributes.
Add a 'nest-depth' property to genetlink-legacy and extend ynl to use
it.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/genetlink-legacy.yaml | 3 +++
 tools/net/ynl/lib/nlspec.py                 | 2 ++
 tools/net/ynl/lib/ynl.py                    | 9 ++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 938703088306..872c76065f1b 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -261,6 +261,9 @@ properties:
               struct:
                 description: Name of the struct type used for the attribute.
                 type: string
+              nest-depth:
+                description: Depth of nesting for an array-nest, defaults to 1.
+                type: integer
               # End genetlink-legacy
 
       # Make sure name-prefix does not appear in subsets (subsets inherit naming)
diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index fbce52395b3b..50e8447f089a 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -161,6 +161,7 @@ class SpecAttr(SpecElement):
         sub_message   string, name of sub message type
         selector      string, name of attribute used to select
                       sub-message type
+        nest_depth    integer, depth of array nesting
 
         is_auto_scalar bool, attr is a variable-size scalar
     """
@@ -178,6 +179,7 @@ class SpecAttr(SpecElement):
         self.display_hint = yaml.get('display-hint')
         self.sub_message = yaml.get('sub-message')
         self.selector = yaml.get('selector')
+        self.nest_depth = yaml.get('nest-depth', 1)
 
         self.is_auto_scalar = self.type == "sint" or self.type == "uint"
 
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 29262505a3f2..efceea9433f2 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -556,14 +556,17 @@ class YnlFamily(SpecFamily):
                 decoded = self._formatted_string(decoded, attr_spec.display_hint)
         return decoded
 
-    def _decode_array_nest(self, attr, attr_spec):
+    def _decode_array_nest(self, attr, attr_spec, depth):
         decoded = []
         offset = 0
         while offset < len(attr.raw):
             item = NlAttr(attr.raw, offset)
             offset += item.full_len
 
-            subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
+            if depth > 1:
+                subattrs = self._decode_array_nest(item, attr_spec, depth - 1)
+            else:
+                subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
             decoded.append({ item.type: subattrs })
         return decoded
 
@@ -649,7 +652,7 @@ class YnlFamily(SpecFamily):
                 if 'enum' in attr_spec:
                     decoded = self._decode_enum(decoded, attr_spec)
             elif attr_spec["type"] == 'array-nest':
-                decoded = self._decode_array_nest(attr, attr_spec)
+                decoded = self._decode_array_nest(attr, attr_spec, attr_spec.nest_depth)
             elif attr_spec["type"] == 'bitfield32':
                 value, selector = struct.unpack("II", attr.raw)
                 if 'enum' in attr_spec:
-- 
2.42.0


