Return-Path: <netdev+bounces-148153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D119E08D0
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959CA16EFCC
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193271DAC83;
	Mon,  2 Dec 2024 16:29:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720F1D9A6D;
	Mon,  2 Dec 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156987; cv=none; b=VOMKSGjGcb9XIQ1SRFZNIauW3y5/oWm04xpyv5LzK1I2hUWDDkmqgM9o/JQP7TuEkkpEcPeyV+Hgi3z+EfTXzeu2FGuXne8vf1jx0P9HyGKOhVSgj51JItbhmWQMRfJVXdVwMu/fdM7xMg4zTZoUNp0CbdPQeCAxG3BOy+180D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156987; c=relaxed/simple;
	bh=RGO1hyF+llZjMyNRzE7tWdm/4j9Uucy+3W7C6t2Bog4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ob1mWriORuFQVz0wqjJqTekCtmCchl1vzT3e5AouszoF5TsBD3KMy/TJaKqVaEDIFEng56HRals0PhxboA9cafbD2B26updmVxz89KQ72GPUyzDWWe+2V8VUHxWu0LlOYynLXjmXknc+Scj+cAe5OdLjLPbZbVsZHtxptGTJBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724f42c1c38so3801222b3a.1;
        Mon, 02 Dec 2024 08:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156984; x=1733761784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6hTvrUTnqyZ4bZCr6uo4VnTCjEljG8ihWfTkzPNFHc=;
        b=ByCH690BxwTGDoVSRVJnscoEpJ0jFKsmYCVA1Tor6WsT13Gj6r9NXh6j5vfL6GbxKw
         9WMDDrs+DeXUI40WxBZJtb1ZvATEzCqq/4GJUZFpxGXXQN5zib/5f0/PjiTrfSxeX0m5
         A9DzfRmXUVbcckaK1f5TVPhBsPo9DhdzZOAqZhZFZ+8qJelk+j01BrMBKPxtQq4VGalF
         cB++DOO+ZC3mbNRoF+f5v1I1TpR36yZLBhbvCJwuUEDAIfZ7w6Ym2DQLvl2hLVztywcX
         GLcyUiIi/mwVZQtlCi+lNBUUIMPfI9hP1THtGfVysgYpQrAdXoHdh33PZnyGYutFoJJO
         GQkw==
X-Forwarded-Encrypted: i=1; AJvYcCUt8gFjxJLh11TWcxX/rSHEItUYjAEIMLSlVi0IsO1oxtDKsVOj/1zQHFNZkDkflasakxUFELHqORo=@vger.kernel.org, AJvYcCVFsBCC5dUJdpX642mI7z4HW8nQ6ulDx9z/AYl9JuZd+TVyEKfXIoOvTvjSIUskD96vFdOv2m7Gb4CPsb3v@vger.kernel.org
X-Gm-Message-State: AOJu0YwETf6+vIg6Fdf+RzjqXu9tGonxK12jiQeQkEli6ZM2O2ITJpIZ
	5zG6LX36JkSZ6K5afESyvHz5CxUT0fTP0B6ui4ofz/TEZO7VE2CCF6tfgg0=
X-Gm-Gg: ASbGncuu59crPO7wSnJ/So43DTvu3LhI+7u5rYexph5g7JQHxaJafXfWHbiVA5ryf4d
	tR7IfJmdt2o35JgL6ZSrsA/ppal+OWIyvjfunoLDq8xnM5Yys+uS8l7HWM78Ic3SPSQpEdfcmKj
	1zoKcA4ppajCD+/GExzTlYufWg2qwRum728KtvPb0OQatYK9/NSabNXC95cEYtNQpF1FJKKklyo
	dAklOYfanz1h+GftV1yw/NkhovEjD6a4SXmOqcBYnR4KVB2Pg==
X-Google-Smtp-Source: AGHT+IFMmpXuBFP+KxrmCC+7xm46ZKugjvMcr+/mfFDkaJddfcXtoU3gRyTsND9FGl2v6K6anU/UBw==
X-Received: by 2002:a05:6a00:3cc5:b0:724:d758:f35 with SMTP id d2e1a72fcca58-7252fffe134mr31578591b3a.2.1733156984262;
        Mon, 02 Dec 2024 08:29:44 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848d96sm8936640b3a.188.2024.12.02.08.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:29:43 -0800 (PST)
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
Subject: [PATCH net-next v3 5/8] ynl: include uapi header after all dependencies
Date: Mon,  2 Dec 2024 08:29:33 -0800
Message-ID: <20241202162936.3778016-6-sdf@fomichev.me>
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


