Return-Path: <netdev+bounces-144523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA819C7AB6
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D001F220D9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C048202641;
	Wed, 13 Nov 2024 18:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73470806;
	Wed, 13 Nov 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521429; cv=none; b=G3akHE3dcfH1hEx9/xJzNCZO7fW7Sc5U3uF9gO1OmCF8f1RaWxshCK3AXhmV3TX4elrmnbNf3JV3nX9tkZhXncKKxLv6nly6WF8duNF47utJwXwGVOynipdd/mnGFS2XBNtwmnkEF3BVNaLeRf08PHmOr+xVlIHEsLd8gXaPUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521429; c=relaxed/simple;
	bh=wepfqwBUvr+6mdQX/N7zEZx37AqQglovyChCYbR/fv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8aVa2xOcXrMyXUJSHjkI9/g9EliJfwavVsDWtQn0GC57zA5b3Gt/29AEv0H0qp0lJMyjxrnDdwyuuzBGpgpmb20QaCYat2V/cC8mK1v1ITx4wrjGqzTpkrTbAlGIcMiZ4FSNxRBxNh+f6+ezcN6RBxwPCZv/r3guxjUufEpWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e681bc315so826269b3a.0;
        Wed, 13 Nov 2024 10:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731521426; x=1732126226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFP4BGNMSeQAYd4JkfpkSSVTp1E+u/bS0lm9lwazT8U=;
        b=fnxU7odMI3StVeq4nOOgUDrWhfCm7MXdc0ENR+0SnSq0iRzCXmWW7QbWUxSjJRZbAG
         /HM/h+uDWN3s6REmE1MqeULGLS1is7epUBdXvvEd5Vs6yVWTPF1qHZtgxcit0K3L7N79
         mEvf7qa/jywcs6zjZJbvGc8fxVauXWRrvH1VWfMVxoIT4FYgx6FJBXdt+3ZdlCSSLzNK
         o8sEkCqbCXjMsWh1fIJWJuqd+KuEhPLBVi7O3duPoa5dYkFViOJKZjgfDLJtKJu9JrTN
         rhL/AGbo0K8joZIlwy7TI/3lauPMGZbf5txMya7tNKiSOZmfjkm1buxlvS75iLneExwb
         oOWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHLFCxO8eBFukupor/EaMsJxdFqJ0jYLH39Cx9XplEmqw4dt5rMvTZJwRykJOjKSy/cqTKoUgmNsCAAyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+xDY9MqrV5mI1hDO6HIqURwnozzP7coGROhB9Nt8ppY9G7hZ
	BhU1DIPDHlNe+26nqxg0jSbHEI9hKh8KpYG1ojq0/igYZJmswxA8wUfwKR8=
X-Google-Smtp-Source: AGHT+IHnmj65PAFFBha/58YSiSN5vvTLsGhgl0PJ2p+oclxyflz9a8At0gTo/E1ggOTD0YNlj2J7Ag==
X-Received: by 2002:a05:6a00:32c9:b0:71e:467e:a75d with SMTP id d2e1a72fcca58-72466800a5emr480654b3a.12.1731521426424;
        Wed, 13 Nov 2024 10:10:26 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785fbe9sm13596733b3a.37.2024.11.13.10.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:10:26 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next 1/7] ynl: support attr-cnt-name attribute in legacy definitions
Date: Wed, 13 Nov 2024 10:10:17 -0800
Message-ID: <20241113181023.2030098-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113181023.2030098-1-sdf@fomichev.me>
References: <20241113181023.2030098-1-sdf@fomichev.me>
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
 Documentation/netlink/genetlink-legacy.yaml | 3 +++
 tools/net/ynl/ynl-gen-c.py                  | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 8db0e22fa72c..83f874ae7198 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -119,6 +119,9 @@ additionalProperties: False
           type: string
         # End genetlink-c
         # Start genetlink-legacy
+        attr-cnt-name:
+          description: Name of the render-max counter enum entry.
+          type: string
         members:
           description: List of struct members. Only scalars and strings members allowed.
           type: array
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index c48b69071111..210972b4796a 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -798,6 +798,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.user_type = 'int'
 
         self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
+        self.attr_cnt_name = yaml.get('attr-cnt-name', None)
 
         super().__init__(family, yaml)
 
@@ -2468,9 +2469,12 @@ _C_KW = {
                     max_val = f' = {enum.get_mask()},'
                     cw.p(max_name + max_val)
                 else:
+                    cnt_name = enum.attr_cnt_name
                     max_name = c_upper(name_pfx + 'max')
-                    cw.p('__' + max_name + ',')
-                    cw.p(max_name + ' = (__' + max_name + ' - 1)')
+                    if not cnt_name:
+                        cnt_name = '__' + c_upper(name_pfx + 'max')
+                    cw.p(cnt_name + ',')
+                    cw.p(max_name + ' = (' + cnt_name + ' - 1)')
             cw.block_end(line=';')
             cw.nl()
         elif const['type'] == 'const':
-- 
2.47.0


