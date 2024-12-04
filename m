Return-Path: <netdev+bounces-149058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6709E3ED2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90641617AF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B120E01E;
	Wed,  4 Dec 2024 15:55:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8120DD68;
	Wed,  4 Dec 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327759; cv=none; b=FneLUvnIJ4vTXo/228o8YCi9AC9W3B25i5sIOOeixYlZ/jL7OEdfvhtaIg7+lR4KCl8ILK+M/+YdS9vkrprXDcTMyXX0qasO8/ZSN2/5n4WfvwfypD6NKdnzJexjRDxwNBNuaAZQ442JBpIoSMVBjh4g+9d6hpaZQ1PaE+dehIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327759; c=relaxed/simple;
	bh=RGO1hyF+llZjMyNRzE7tWdm/4j9Uucy+3W7C6t2Bog4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAe70hTl3yBjnc5KpZbnFxQGdXM5U+LYtPog5eYV9mwi607IIJy7YaQDKTukoMiCpan0u1jVXEADrSxOp6GI8vuZ9XOidj+OJMzxPHAP2DbDQNek0tP/8srphDypyknA5brDM0cGAl+lv/EW0wu6bJoCDjneMGIlcMuo5Ed5l9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215666ea06aso9417235ad.0;
        Wed, 04 Dec 2024 07:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327757; x=1733932557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6hTvrUTnqyZ4bZCr6uo4VnTCjEljG8ihWfTkzPNFHc=;
        b=Gec07mgKcS8wMF3LByvMObkCbwuH4rdHTME77NGqnBOFjFRSUGZX637KgcDu2QFmDI
         YAFmPKyIsdokrrwQX8neMdlCAQsGp9e+PnFi4lOgWePfk1XQ45fxk5kfcxPfBM0EtN9h
         W4at1GvjQvIVkFxBjq40NN/sH621ldLR7Nz7WQEQ7UVZXg/lcOSF9k8rH7C3uoPKp53g
         KWx8EQg9ZoYzUP+heB64QWBTnuqLWKwn3DG78yXGwtKIQHpPakDwRefhPa/H14Yp6ayY
         2Q/2fCk2pgX8HOOdpwWGC1/dpoI45fRdLWCpDkXX8RjQUpB4wjyodDAJ23ApOVVZnuI3
         0DLg==
X-Forwarded-Encrypted: i=1; AJvYcCU3ccE+VP07JKldj4LrcYaavde3Eob5IwH8KsEsHR5tToKjnCOaoC/GWpwvcsUYhvG4MEcPKwyVRQA=@vger.kernel.org, AJvYcCXTzxgThMR8dtcBBzBkzqj0DuCU51RL4ID67kTLvm1i6rjtoGNY5QjYxm5yBUZrg1HpX4GhR9Fqv3pWQGzJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ODecT5/aMLoG78b0ljP95ZVafVFvLNnptin26srhUYg/UmpM
	LD0abDTRgb6kAdRGYc5Y4oaW59zbxmDlngJ+bTQaQURKt7YMWjeWSO1yT6M=
X-Gm-Gg: ASbGncvurnxecsvbF0WUZEzdOc19jgyJWroVDQppaQJDwDglNzA6rcB9xXogPrAs2EN
	Ixetn+fVuSSk8FokXyfub7fR9Fe4+g9KhN8VTUwQU32v/bM98TC2Mj931fxDEnjsTkk9n4Q7ivC
	mGbjEZXaUYxdyUut3J+qxqjn53if8+eMm+sZUMsBF6QhrbYauwfNijQfBmAw2YEz674Qjbf+yMM
	A/Pz/1Ba/zH+9cqIpONzAeeF7iofT6PeXQpI0MtrGQE/TsPwA==
X-Google-Smtp-Source: AGHT+IGXHrjA8oFgUcSdbLxmp9WArBbCUXkC7JWKH+Ib7b6Fu91p9XVrPnxuPil978vjaM+wfH8aag==
X-Received: by 2002:a17:902:da85:b0:215:a808:61cf with SMTP id d9443c01a7336-215be6fcee9mr120929865ad.25.1733327756732;
        Wed, 04 Dec 2024 07:55:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215650b3cc1sm76037645ad.0.2024.12.04.07.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:55:56 -0800 (PST)
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
Subject: [PATCH net-next v4 5/8] ynl: include uapi header after all dependencies
Date: Wed,  4 Dec 2024 07:55:46 -0800
Message-ID: <20241204155549.641348-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204155549.641348-1-sdf@fomichev.me>
References: <20241204155549.641348-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Essentially reverse the order of headers for userspace generated files.

Before (make -C tools/net/ynl/; cat tools/net/ynl/ethtool-user.h):
  #include <linux/ethtool_netlink_generated.h>
  #include <linux/ethtool.h>
  #include <linux/ethtool.h>
  #include <linux/ethtool.h>

After:
  #include <linux/ethtool.h>
  #include <linux/ethtool_netlink_generated.h>

While at it, make sure we track which headers we've already included
and include the headers only once.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/net/ynl/ynl-gen-c.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 2bf4d992e54a..8098bcbb6f40 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2782,12 +2782,17 @@ _C_KW = {
         else:
             cw.p(f'#include "{hdr_file}"')
             cw.p('#include "ynl.h"')
-        headers = [parsed.uapi_header]
+        headers = []
     for definition in parsed['definitions']:
         if 'header' in definition:
             headers.append(definition['header'])
+    if args.mode == 'user':
+        headers.append(parsed.uapi_header)
+    seen_header = []
     for one in headers:
-        cw.p(f"#include <{one}>")
+        if one not in seen_header:
+            cw.p(f"#include <{one}>")
+            seen_header.append(one)
     cw.nl()
 
     if args.mode == "user":
-- 
2.47.0


