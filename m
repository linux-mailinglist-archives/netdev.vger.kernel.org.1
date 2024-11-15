Return-Path: <netdev+bounces-145375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5B29CF4FA
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BA52893FF
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8C31E1C2D;
	Fri, 15 Nov 2024 19:36:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570151D63F0;
	Fri, 15 Nov 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699412; cv=none; b=lldIET4gbdyJEY9LK1fBExs8+bFpE7yFw9HILswnxbHIZeKT2TbbH25laW/iFx49OVIImuAF8JDDInrrOe3CNYvIvYuoO0gKyD3XugtNZM0EuTeKub+BFJU9n9j9YyZbt8WvaQUwMIUzdqzZ1MwQDbkkTc33zuGaYkdNzgUVpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699412; c=relaxed/simple;
	bh=LJCi16uBVzofCIGZW8Thf5aK7hpT+0W/+ExLkSulXJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFTnfWDEk9w2UyWmGpbsrhaKXLucBCOzBi/pKmVQr0vcXqjBvMWFEF6ATOPup3FdotJaPVruzOkKDoQPgPwfbMC3QFpk+NDzakr6KF5D1Wr2bEJ0LKiryDLyYwW3ETbyNpqHI9AfnXCPnFb4Ad+PM7LqjRpv+hu+MX/8eIn49Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f450f7f11dso2351a12.2;
        Fri, 15 Nov 2024 11:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699409; x=1732304209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlNpJSVmyFUS31WHgmShvqL/urAeCOgEQgXd4kMEOLg=;
        b=olcBVblUzZoGDNQBiN6iMNsRc0//ZKfgb8nM1h3HtK0Yy/3UbNbqbrrXh5vH7NX+4c
         GboOw2syeLNYEtoOBxtPP/qDCahNTNaVpGRlbw2bhml8M43I5zWSvX4sX4w9jgTXR0N3
         lNRkFi7WLsDOOoNFvRc+eAiXavoFgLS70dEXnIW4kRXY3Ar7l6S2bEowZN6NHlJB4Ci3
         MzAsUNsWBMLj47HptRu2jQBmPFd6AgMZlUfInJLuSK3OXDg4FPUivLp6QKuFovr4G9OF
         QWHBPWmjsY4hWy8oYlyFJmGfi8kzLI7pTE7Ha8ckkj9HXI3sR3TTfjPqRWh6+obSWaNn
         Kl9g==
X-Forwarded-Encrypted: i=1; AJvYcCUCiZAByUQvCibXCCNAOqPRnHfctGGkK+/eU0m34LB4/RJ5CXQWm7CXIhAd9AjtWebPfof1iXtTVcw=@vger.kernel.org, AJvYcCVoxJ0Pj5zwMEvDJn9UwFIcmLyuGbWCyTYHOWZSon+YMO1uqIXSkTqDmfPQogBkzAqfaX0DKRnwPgkGfEZL@vger.kernel.org
X-Gm-Message-State: AOJu0YwZu6OUeba4BSTCQ6jCNuS2CKMme+ojuilZfuiOnoxosNbChsGl
	Snmr1t4IiwbQ851lm8AeYXuAnWzy7yNFDyLY1h8e4vZ/ha2frIYJfJNkhuM=
X-Google-Smtp-Source: AGHT+IHTqUjdVKy3Qncpy7KPSxayRIDAyVWzaou5ixNvcn4fzw9hACfPxJOS5QXdV6TDgeiiSZKALw==
X-Received: by 2002:a17:90b:1a85:b0:2e2:b6c2:2ae with SMTP id 98e67ed59e1d1-2ea1559adbamr4032268a91.36.1731699409208;
        Fri, 15 Nov 2024 11:36:49 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f1a634sm3243894a91.14.2024.11.15.11.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:36:48 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me
Subject: [PATCH net-next v2 1/8] ynl: support enum-cnt-name attribute in legacy definitions
Date: Fri, 15 Nov 2024 11:36:39 -0800
Message-ID: <20241115193646.1340825-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115193646.1340825-1-sdf@fomichev.me>
References: <20241115193646.1340825-1-sdf@fomichev.me>
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
index 394b0023b9a3..55e7f2415b0b 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -801,6 +801,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.user_type = 'int'
 
         self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
+        self.enum_cnt_name = yaml.get('enum-cnt-name', None)
 
         super().__init__(family, yaml)
 
@@ -2471,9 +2472,12 @@ _C_KW = {
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


