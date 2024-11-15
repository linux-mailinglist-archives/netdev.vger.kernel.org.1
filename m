Return-Path: <netdev+bounces-145378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA1B9CF503
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152281F21F81
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C841E47B9;
	Fri, 15 Nov 2024 19:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F225D1E32DA;
	Fri, 15 Nov 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699416; cv=none; b=pTt5tV9Asxj8842YpazOMEcamI2WxbP+HahBOclYS8UtMlcqI6vfZ3qq+Y5RUjZ8XkdEt6KjDFaOOpEfRDttPoh0geuMtllCXwmR/TkIVH9oxucuBKSdPnrjALlmrWRbWPmHk/KDAzRTwg/O6wpZZmXwFPrgQZIj5x1G+mR6mek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699416; c=relaxed/simple;
	bh=faaMXfJYfuow/ltwSWOiJC8jGRiLGsZloDL3Wvc6u0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6YBcOHy/eod+SAaFtbaj1QRKhxPidX6IEW1eOc2PwJHC5CYc6E++Hbiv/MnM3bEGuZHYS7l/NAIKUg55WllCtJCh6sPki7vH2i0N9wqF0nO0US65G0/nXNyBfhYUN/I+1DudYAhru//QyhkH+ZakTiIJIl4wcWpl62jphCZKzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-211c1bd70f6so17968325ad.0;
        Fri, 15 Nov 2024 11:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699414; x=1732304214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2zixJ6bg1ERpm7DhfabkX8EOs8JLcd3Ty5tEJKE0ZI=;
        b=jfvj8VJBFl+KZnso2MiUwEU4tbo3MqGj8EobIPTfS9SoooeCMmYn3nV3yOeME6NcwE
         YISfdeqXJtzvmzPebINwEGPPs5nVrSPdGr7/S9pSHId1vorwtGV1WI8S+WyocmcxPQU7
         Y8c3RJxemtvZKiECCPciibSO6DAvSq9JWEppJouC50vrkEdRXEZUyi4e0yTW8CjLS2Ou
         +4MTtBFtryfNf/4hekDEuXlpQpJP9xhSAmLfnUWbc9lGsLTwOcXaehL0QKoHG8wKJmfy
         vZLfMvf5FSBm+nx3bRTuekYS8wpY96oPJL13E5ifZHbNqZcyiY4xpnbo+y5PIWuJK+wD
         qs1A==
X-Forwarded-Encrypted: i=1; AJvYcCViWVVo77asB4SgJiXgCV5jJ6Df+cJBrFNymsBlqBFaJaQfecJ4I3S8sKoEYnPC8qODaL2gSuuAsi30CwZ+@vger.kernel.org, AJvYcCWDSa4ysKGpdvznRbPCEVuQD0BoiDKHNW45zHtQzA875pndqnZYOSr4pxU/0IP+D5T9Wq51+3PNV/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4i9ZFycx6bpptq1l53dKd+PHYTe/ivVYy9VTPgqYEabAZix2
	Co+LBx35POKTgEFirfyRPUUzopFIK1qCFLnbo6tOeXyCTRTf69A7DEM+IlQ=
X-Google-Smtp-Source: AGHT+IGOMfVDWF0nv5jgESPFzMUPux6TWK8QY3aNuivC8DizfU8labuWg18PdZSxgI4lOAIt0JOADw==
X-Received: by 2002:a17:902:da8b:b0:20e:df57:db50 with SMTP id d9443c01a7336-211c0faa33cmr133803395ad.18.1731699413949;
        Fri, 15 Nov 2024 11:36:53 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724772010f6sm1729386b3a.195.2024.11.15.11.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:36:53 -0800 (PST)
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
Subject: [PATCH net-next v2 5/8] ynl: include uapi header after all dependencies
Date: Fri, 15 Nov 2024 11:36:43 -0800
Message-ID: <20241115193646.1340825-6-sdf@fomichev.me>
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

Essentially reverse the order of headers for userspace generated files.

Before (make -C tools/net/ynl/; cat tools/net/ynl/generated/ethtool-user.h):
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
index e5ac6f89b78a..d86d185b6383 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2781,12 +2781,17 @@ _C_KW = {
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


