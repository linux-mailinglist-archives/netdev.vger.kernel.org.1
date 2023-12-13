Return-Path: <netdev+bounces-57102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82348121F4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82541C211D1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011FC81E53;
	Wed, 13 Dec 2023 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aADOw+bT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E52D5D;
	Wed, 13 Dec 2023 14:42:24 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c236624edso74223725e9.1;
        Wed, 13 Dec 2023 14:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507339; x=1703112139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r+VY7IUuzfIu//kONAqQEZqy6Nlng4O5ksundjjdjw=;
        b=aADOw+bTaVn+zJPFw3T6UKRucKbZzdeDwWi5k2mfxENBO8+39EAlvV9pCVRNce/xKh
         b2WkLyYpEqBnqffWbmIQuDtwgnKT0Rgm9kqC3+HyeztdBJKBDrM1HOodIY4eKD9vbFJ5
         KUM4WDEmV36/gFERAfs797pBeemiiZP1uKhO7a0MAWQ1sK12cCQksusQZO304MDXXShk
         8yYXlJRJQJ9i5GQTRs3JgfGF85EzUED/sQqdiZyEmK0MPfI6yJZXPHjX6Tx/pQfqdOwR
         8RyK6u1gh4TIkF0J0oFjVOZKEOAdujIOP0K0BQ342/VND/cROqgRHLNuRTdfHPzB7zLi
         TQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507339; x=1703112139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7r+VY7IUuzfIu//kONAqQEZqy6Nlng4O5ksundjjdjw=;
        b=aN8yfFMd3/hhFia04cpKQkstPrwi7Bm65PqJJbf3EK0SydMUdF58ZzeyVxRazjUUhM
         kxPU2XDX/msItTygLCQ63aC+XnpyD1EQD5nqcZpQgDZm8n/H+wzDukeL7gildYwg3VVX
         tefVNjIySL7CYipMclJuq7TCw63kAeXwDffCpQ27ylkxWJSlTDoFsbxlfx8AqRNQMcHN
         Fu+Y2bcHALbsVvRlKiqsrc01/LW1/Lxy7jQ72Z/PD23dvTkyzg7pGSn7TdwSMVk+5UwM
         tJ9fw1P5BdcLiPiEkPXuRJY0NniTbg9yzuitW4IrMIONSI/lfS/JU/fHGEt2W2mfTNlK
         b0Jw==
X-Gm-Message-State: AOJu0YzzHBDYmaS2tFNItFPavUVqphhCdVwuGJh4Zgx+gUBY0OdAuPmN
	UG35OO0orf7wYV20jNWDbHCjGwpiZFOLOQ==
X-Google-Smtp-Source: AGHT+IGHVhJIpAv0lGWB+wjeqbGWoqwX0Z5gxyrV3lt0zggyaHuhUWfwuIFbew11ron5fFYcwXlyKQ==
X-Received: by 2002:a05:600c:2d4c:b0:40b:5e1e:b3ae with SMTP id a12-20020a05600c2d4c00b0040b5e1eb3aemr4255056wmg.44.1702507338865;
        Wed, 13 Dec 2023 14:42:18 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:17 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v4 13/13] tools/net/ynl-gen-rst: Remove extra indentation from generated docs
Date: Wed, 13 Dec 2023 22:41:46 +0000
Message-ID: <20231213224146.94560-14-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213224146.94560-1-donald.hunter@gmail.com>
References: <20231213224146.94560-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The output from ynl-gen-rst.py has extra indentation that causes extra
<blockquote> elements to be generated in the HTML output.

Reduce the indentation so that sphinx doesn't generate unnecessary
<blockquote> elements.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 tools/net/ynl/ynl-gen-rst.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 675ae8357d5e..f7d5bf96736f 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -69,7 +69,7 @@ def rst_paragraph(paragraph: str, level: int = 0) -> str:
 
 def rst_bullet(item: str, level: int = 0) -> str:
     """Return a formatted a bullet"""
-    return headroom(level) + f" - {item}"
+    return headroom(level) + f"- {item}"
 
 
 def rst_subsection(title: str) -> str:
@@ -245,7 +245,7 @@ def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
             for k in attr.keys():
                 if k in preprocessed + ignored:
                     continue
-                lines.append(rst_fields(k, sanitize(attr[k]), 2))
+                lines.append(rst_fields(k, sanitize(attr[k]), 0))
             lines.append("\n")
 
     return "\n".join(lines)
@@ -263,7 +263,7 @@ def parse_sub_messages(entries: List[Dict[str, Any]]) -> str:
             lines.append(rst_bullet(bold(value)))
             for attr in ['fixed-header', 'attribute-set']:
                 if attr in fmt:
-                    lines.append(rst_fields(attr, fmt[attr], 2))
+                    lines.append(rst_fields(attr, fmt[attr], 1))
             lines.append("\n")
 
     return "\n".join(lines)
-- 
2.42.0


