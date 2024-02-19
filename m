Return-Path: <netdev+bounces-73014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C085A9E4
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE4CB2603C
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B848447A61;
	Mon, 19 Feb 2024 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gjRRgzp5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085574594D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363555; cv=none; b=jOlMgvgSe9XK1gzp3CyqA/iqsIJDNyXLIfUscjXblyABFvEtntkztLNyctANDsLGa0ru2PjcdlYylH2ruPUuidqMb81JRS4frpjHzXIo4nfkPmGTOjmMFm+DxbTWaqsAQjlW+Mtr4fQ6hGJtHSnXxtsmt6taYMNA9cdaURtjVhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363555; c=relaxed/simple;
	bh=FAZBfa++7j/K7/n7e5FxBykhn9klPNwABfnn5l8c7zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZWy4P/IFAu450NXFFJRd8/RDTgf/GFFZuDvWaAowoEnPWOirAMDTn5ok0wF5d+ogD+o3cwAUjDwLdV5sYuRlYtdukI9Cp+IkkyfjHQ18dak7a4Swa8g/rKWZ+s5+QiHv9oZWFd6nbrbS8DjS934fHcq0f6/LQR9k1nE9gudHnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gjRRgzp5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41265d2f7acso9316485e9.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363552; x=1708968352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Fq3p/IfJFXI2r+7jsJUt/OXDP9zZUxHE6KScodL9cI=;
        b=gjRRgzp5Y+/Jobcgq5pT39EcjuhjWxhObP8/mqtwLvfAmbIFSFxtFg6l0r4Y4o77mC
         mAqaillt5A/JgoX/A1CdbLmuPFD57QkB8mINsDXKEYGCLtWa10UZC11bZM2DfcDXjOTF
         Gl3wVqTegmoIYikwQUVt1nEe/zOKiJKJTu/Oe4IZLUt4oIw5VAB8vRA01jPOpBP0ua+/
         ygiglmmpF0fDGvk2DdvYcWam7k6jLASdA0HlxyM+AlrJuP9hbplIvoV254ftBprID9TI
         A/dLGaVXPcc5DAg0EMc0hjAChCYUn4aQj9GWVJ5bGMm82LBSCKbmc6Je1KYEr/1y2DV5
         zP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363552; x=1708968352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Fq3p/IfJFXI2r+7jsJUt/OXDP9zZUxHE6KScodL9cI=;
        b=toVTH3A92+CAFbaM8Bf8wq1RuWKF9ZYY/p41qOk5Vm3/MnBLZ3nqjmnEgZpQPQQKEs
         FpsPkAyiA4z40QHXIewLfFl6HM0NWoZUM29qC0U1yjVeZ6u6Pr/uH7HfbZRGjtJr7zTM
         2rZG0/VzeNQ5P7W/ElDjZxXLUH2+7XIdw6L2dVSpx5NK+fAKDSYxej3XqZU5Oz7jZA3h
         PPwQSZjX92nM5ceN6STAHgH0Q/LDLjmdhW5RoCzMV5t/P2FTDRqC39djtIHcybkgajo3
         HDDRuOZeX2+1+Mo8bV+bj0zE8eohL2NmwR21id6rZY+YiiDTYiLt5uEhkPrOyp23QGwq
         f1Ng==
X-Gm-Message-State: AOJu0YzlZkjaBwPmv8Or4EeJr/4rjbYi3in9WEvqBccoxmp4hTzd+96t
	2t9ktyznaLpnYZL09p6cjiOfPP9u46eJrXq/EZAVN508BbdH2HEKCoBUGaZ116sDf0iMxQ9uTa0
	2
X-Google-Smtp-Source: AGHT+IG/mdfnikVko0WdQww8yuDh2qz70gzF76ETUhOUxch5dUBfRSn4+HJ8gpx7kLkx6UVyJHq3Cg==
X-Received: by 2002:a05:600c:4711:b0:412:6b21:dad9 with SMTP id v17-20020a05600c471100b004126b21dad9mr773121wmo.25.1708363552493;
        Mon, 19 Feb 2024 09:25:52 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b0040f0219c371sm12073169wmq.19.2024.02.19.09.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:25:52 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	lorenzo@kernel.org,
	alessandromarcolini99@gmail.com
Subject: [patch net-next 07/13] tools: ynl: add support for list in nested attribute
Date: Mon, 19 Feb 2024 18:25:23 +0100
Message-ID: <20240219172525.71406-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219172525.71406-1-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Some nested attributes, like devlink-fmg, contain plain list of
attributes that may repeat. Current decode rsp implementation is
dictionary which causes duplicate attributes to be re-written.

To solve this, introduce "nested-list" flag for "nest" type which
indicates the _decode() function to use list instead of dictionary and
store each decoded attribute into this list as a separate dictionary.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/genetlink-legacy.yaml |  3 +++
 tools/net/ynl/lib/ynl.py                    | 18 ++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 77d89f81c71f..0e0ee3b4ff5f 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -220,6 +220,9 @@ properties:
               nested-attributes:
                 description: Name of the space (sub-space) used inside the attribute.
                 type: string
+              nested-list:
+                description: The nested attribute contains a list of attributes.
+                type: boolean
               enum:
                 description: Name of the enum type used for the attribute.
                 type: string
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 8591e6bfe40b..08fe27c8dec7 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -386,8 +386,12 @@ class SpaceAttrs:
     def lookup(self, name):
         for scope in self.scopes:
             if name in scope.spec:
-                if name in scope.values:
+                if isinstance(scope.values, dict) and name in scope.values:
                     return scope.values[name]
+                if isinstance(scope.values, list):
+                    for item in reversed(scope.values):
+                        if name in item:
+                            return item[name]
                 spec_name = scope.spec.yaml['name']
                 raise Exception(
                     f"No value for '{name}' in attribute space '{spec_name}'")
@@ -568,6 +572,10 @@ class YnlFamily(SpecFamily):
             return attr.as_bin()
 
     def _rsp_add(self, rsp, name, is_multi, decoded):
+        if isinstance(rsp, list):
+            rsp.append({name: decoded})
+            return
+
         if is_multi == None:
             if name in rsp and type(rsp[name]) is not list:
                 rsp[name] = [rsp[name]]
@@ -620,8 +628,8 @@ class YnlFamily(SpecFamily):
                 raise Exception(f"Unknown attribute-set '{attr_space}' when decoding '{attr_spec.name}'")
         return decoded
 
-    def _decode(self, attrs, space, outer_attrs = None):
-        rsp = dict()
+    def _decode(self, attrs, space, outer_attrs = None, to_list = False):
+        rsp = list() if to_list else dict()
         if space:
             attr_space = self.attr_sets[space]
             search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
@@ -637,7 +645,9 @@ class YnlFamily(SpecFamily):
                 continue
 
             if attr_spec["type"] == 'nest':
-                subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'], search_attrs)
+                nested_list = attr_spec['nested-list'] if 'nested-list' in attr_spec else False
+                subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'],
+                                       search_attrs, to_list = nested_list)
                 decoded = subdict
             elif attr_spec["type"] == 'string':
                 decoded = attr.as_strz()
-- 
2.43.2


