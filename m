Return-Path: <netdev+bounces-65113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB86839447
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A409C1F25FC5
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C33263512;
	Tue, 23 Jan 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt3DdVAl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B0F6BB37;
	Tue, 23 Jan 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025975; cv=none; b=UZwG59J5P94OSY3YO9O/yMYXkVmcSphvcN4YFO/OpwU8r1wDy9MR9nZI1VTEZGrV8ZV0/Tf78wU9gdpUcArhsW28OTS7kQV/1j4MztpqIMmq3SH5r74zEVq/Sh2R6z3TZzHGPCvbiDJk1krKBGtH7Q6LOJr6pv78XJLnFXJ/pME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025975; c=relaxed/simple;
	bh=gCCFkbQi3h7pB/H0SVmDbXDwzfcTplJjQwGfdvt6208=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzBk0D7zR876ieYpBpMoQm9kvu8U4Rs/CHCBdiKxWSnPBjPNSFRetPUiWdfFnLuq+7JKBWIEgLsiyaT1k42PFA2lYy6wnH4NkCuAAsyvhT9Nk0WdRbsmDbizfjdR1sa1w8z8NmHKMfZb8iR433EPMpVJjEN+LbCKmGNwebZjUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt3DdVAl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3392b15ca41so1866839f8f.0;
        Tue, 23 Jan 2024 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025968; x=1706630768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLxo4L/OXpdRV2DRbWL0FX0uXQ9Q3iAQOyTEhytQtW8=;
        b=mt3DdVAl4pErRtNtKQlv1jt8PXm8/tpmXbYHtFLtkuUt6IzWi06LzsBEFkWdjv0cJI
         qXTsgO1CtPzBhdmaKR60eNGG0/hvX+lVWXmXhX+FAsvbV83+LTVC7++YO5xY87UBZdkz
         mCY5koMReaMgLKBNesgJe2bdYBzUY46Drzn/bd5PKT3r4Vb4v7UZBYfcXZrqK1K6v9g0
         XMypvQqCDe2mU1sr1tF35QaXfeOWRwtxl8kcBtvKQqWofPqMQ1YXXiw6R8fInqRq8/9o
         6nnltVBFJOBycv6RBvdGsy9935V3MTOOxeknA+vLG9DDgyuw/9E5YnNZ9uSKpdl1K9FF
         ZkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025968; x=1706630768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLxo4L/OXpdRV2DRbWL0FX0uXQ9Q3iAQOyTEhytQtW8=;
        b=qdNk4VMKj8PvnzHkGW1hNxAVJrdzd+ncFQLIVxSC9Hm8DQdy/7UagijD17Qn3LZLnR
         hPzw8brVwfRY+rZBeVqFQxYXwLBeK1BxUf3f/W0Q3xJRTFDnaNsNqs3bAaypAdDbgPxL
         2W8pQD99Pnm1/HpbPepEewAFYQ9OaVClez8CCe0U8JcfZV1ZRc6Y/3cXSGmDk3fOyiQX
         d8PzOIVNXnXPSgDCVoKfFoTi1Zw1q4/4B3x+gJt3hx9QfUKVspnuAkdlFS2zlc9SZMwW
         gMCVPLyidHExEvUU8RGbGLy9xKVHv2qsyjgKcBxa54pIpqMnBuolkfPkIiKKMa+o2dHU
         XLdA==
X-Gm-Message-State: AOJu0Yx0Uqwo1Ibya9Ja8oLPppojJRiuDxAEislIeM5RRelsaMz4BNnw
	bebhPmGFlXteq1fAsCzxMTZc2aNqONI7y9Rr1LMAQE4rj7CY4fuXKRnJzCKUthL5RLmp
X-Google-Smtp-Source: AGHT+IG8+SgBWRMFHu9bObYhTM0IW5C15Gr6W9kN/UKPB0m0aiz1jLa87D/sFPlBagWEEo9uEy/N/g==
X-Received: by 2002:adf:f641:0:b0:337:b36d:72a4 with SMTP id x1-20020adff641000000b00337b36d72a4mr3112401wrp.36.1706025967916;
        Tue, 23 Jan 2024 08:06:07 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:06:06 -0800 (PST)
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
Subject: [PATCH net-next v1 11/12] tools/net/ynl: Add type info to struct members in generated docs
Date: Tue, 23 Jan 2024 16:05:37 +0000
Message-ID: <20240123160538.172-12-donald.hunter@gmail.com>
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

Extend the ynl doc generator to include type information for struct
members, ignoring the pad type.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 262d88f88696..75c969d36b6a 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -189,12 +189,20 @@ def parse_operations(operations: List[Dict[str, Any]]) -> str:
 
 def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
     """Parse a list of entries"""
+    ignored = ["pad"]
     lines = []
     for entry in entries:
         if isinstance(entry, dict):
             # entries could be a list or a dictionary
+            field_name = entry.get("name", "")
+            if field_name in ignored:
+                continue
+            type_ = entry.get("type")
+            struct_ = entry.get("struct")
+            if type_:
+                field_name += f" ({inline(type_)})"
             lines.append(
-                rst_fields(entry.get("name", ""), sanitize(entry.get("doc", "")), level)
+                rst_fields(field_name, sanitize(entry.get("doc", "")), level)
             )
         elif isinstance(entry, list):
             lines.append(rst_list_inline(entry, level))
-- 
2.42.0


