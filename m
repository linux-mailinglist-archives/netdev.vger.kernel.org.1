Return-Path: <netdev+bounces-148150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758FE9E0B66
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 665A2B3DEE4
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320CB1AF0AA;
	Mon,  2 Dec 2024 16:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B81A265B;
	Mon,  2 Dec 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156983; cv=none; b=D6WSOPxJEGzDj/g9ZQijWlxL2DO4ZNkPQPDh4vA0MPJxL5F9uAhTdF1mFM4m2vFeX1LCgZj0tkTHO6Ll/i6tnGkfhfXEy3y32ieEWwfgzzgceEYbJ8AHZQEcqI3tCYy2KrYFSRpc/b8XClItA3vosBc/c+365ujZELsmmTT6c/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156983; c=relaxed/simple;
	bh=nx/1q4UxfEC4CdlsFRFIMhLyLex9mIfjyJUUuj/UgFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaBvAPReajufxjpnAu+kSXP0S8COE0Cs1Z+mfs6ApJ0CnNuL3EaPEz5obzESbIF31HQRuyFdu4Gk/suuR9PmSs10603klWuPPmhiPgp3cEAsrJO77HA7X/SaG+1OTHNVw8HVwZ+3/0saeadQmJR9dqrW3uBbbKDKl7N3i+St9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e9ff7a778cso4011373a91.1;
        Mon, 02 Dec 2024 08:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156979; x=1733761779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiduPAtZh1MVyOKWslb5l/TwKEKfq1TiSzGE5bgoCZQ=;
        b=uYQ+b1HG1iKEq96decaM1k9mm5hTYuRL7CPpnHPolYFt9Z6JnjV4GfRQ9BCe4AcupJ
         NjOSoocVcNBvZtSDYBMOHUp18W4WoYZPevItrorpI3M+l5HvBIgDhSyiaPYLAmlF4AOH
         o1nfm0NJD+F0JRKBPSDxEik+16ACzxfwF9FwCVtYUTL6yaLfKOJtwl8Oh77qboV7M8sI
         OI7dwH3ypsw6BlVDeBisVoAUh4mBlXic21liLo5EuN9QQbzDUArhfg7OcD8WwxMHbHQ1
         V0Dfp43FmpFbvfPcDVvKx6s9JqZQvDFu0E1fLDJTKjTQOxO2pAmWiqHgL8WuwVXWqkEi
         RBTw==
X-Forwarded-Encrypted: i=1; AJvYcCWbHQLORefaZt0/8/aDWFnx9OnE+x1Ry7Qv9fstQyuqTufgezwW575l1tJGMwBxLhasRUjLnd7C5fI=@vger.kernel.org, AJvYcCWprQC5mhJ0zMf8BI1FrCO9Tt6V5ovy0iPDJxY8en7OGp9jniYlHXlzYOINA1K91CW7oLRsm9deSNSfaCxY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ShK4kauJRWonh/6Q4nwfB5FUGakHrYRbr0Sa/O5oi6eCAPdP
	DKQooQQxMybtStUCnFDMi/gBNKCGpiuUWYcG4Xly5EpSoBkltsQzwO+AcrA=
X-Gm-Gg: ASbGncsau8lB3InTIKv8ZOxToBQXFdKTcx0eijH135gDno6KCsqyTRkLvbVW24wqqR4
	oujJjZHlWicd8JSFJ3J+z87w8NcuO7QfBiCg7ZZa/JNLmTYEC2ppQgGtl8z2jUhF+cAANDjweaK
	/pFxGWtFuDanFjc0skqB4CO3isruq4FxIMj5c2XGbrCO8DkrqY8fZtdvfxcbxB8kMumomRvKJZC
	PTfT/w6SPOIayVsyXon7pUUnSq8rozLncF/fEIdSJP5OCT9UA==
X-Google-Smtp-Source: AGHT+IFhSNGZ2h1sltqYvfBRHuTNb4MkMk6UjjNyguI/8SchjDrm709TOpEs6p8GgHJJD+jYBPf5VA==
X-Received: by 2002:a17:90b:4d0d:b0:2ea:5fed:4a32 with SMTP id 98e67ed59e1d1-2ee25af2e0bmr28906554a91.11.1733156978873;
        Mon, 02 Dec 2024 08:29:38 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eea580bfe9sm3195435a91.39.2024.12.02.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:29:38 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next v3 1/8] ynl: support enum-cnt-name attribute in legacy definitions
Date: Mon,  2 Dec 2024 08:29:29 -0800
Message-ID: <20241202162936.3778016-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202162936.3778016-1-sdf@fomichev.me>
References: <20241202162936.3778016-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is similar to existing attr-cnt-name in the attributes
to allow changing the name of the 'count' enum entry.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/netlink/genetlink-c.yaml             | 3 +++
 Documentation/netlink/genetlink-legacy.yaml        | 3 +++
 Documentation/userspace-api/netlink/c-code-gen.rst | 4 +++-
 tools/net/ynl/ynl-gen-c.py                         | 8 ++++++--
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 4f803eaac6d8..9660ffb1ed6a 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -106,6 +106,9 @@ additionalProperties: False
         name-prefix:
           description: For enum the prefix of the values, optional.
           type: string
+        enum-cnt-name:
+          description: Name of the render-max counter enum entry.
+          type: string
         # End genetlink-c
 
   attribute-sets:
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 8db0e22fa72c..16380e12cabe 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -117,6 +117,9 @@ additionalProperties: False
         name-prefix:
           description: For enum the prefix of the values, optional.
           type: string
+        enum-cnt-name:
+          description: Name of the render-max counter enum entry.
+          type: string
         # End genetlink-c
         # Start genetlink-legacy
         members:
diff --git a/Documentation/userspace-api/netlink/c-code-gen.rst b/Documentation/userspace-api/netlink/c-code-gen.rst
index 89de42c13350..46415e6d646d 100644
--- a/Documentation/userspace-api/netlink/c-code-gen.rst
+++ b/Documentation/userspace-api/netlink/c-code-gen.rst
@@ -56,7 +56,9 @@ If ``name-prefix`` is specified it replaces the ``$family-$enum``
 portion of the entry name.
 
 Boolean ``render-max`` controls creation of the max values
-(which are enabled by default for attribute enums).
+(which are enabled by default for attribute enums). These max
+values are named ``__$pfx-MAX`` and ``$pfx-MAX``. The name
+of the first value can be overridden via ``enum-cnt-name`` property.
 
 Attributes
 ==========
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index d8201c4b1520..bfe95826ae3e 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -801,6 +801,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.user_type = 'int'
 
         self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
+        self.enum_cnt_name = yaml.get('enum-cnt-name', None)
 
         super().__init__(family, yaml)
 
@@ -2472,9 +2473,12 @@ _C_KW = {
                     max_val = f' = {enum.get_mask()},'
                     cw.p(max_name + max_val)
                 else:
+                    cnt_name = enum.enum_cnt_name
                     max_name = c_upper(name_pfx + 'max')
-                    cw.p('__' + max_name + ',')
-                    cw.p(max_name + ' = (__' + max_name + ' - 1)')
+                    if not cnt_name:
+                        cnt_name = '__' + name_pfx + 'max'
+                    cw.p(c_upper(cnt_name) + ',')
+                    cw.p(max_name + ' = (' + c_upper(cnt_name) + ' - 1)')
             cw.block_end(line=';')
             cw.nl()
         elif const['type'] == 'const':
-- 
2.47.0


