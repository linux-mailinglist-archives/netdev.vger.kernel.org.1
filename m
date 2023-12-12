Return-Path: <netdev+bounces-56629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AF380FA1A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6224A1C20E30
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914A26610F;
	Tue, 12 Dec 2023 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0EgyQbh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87733AC;
	Tue, 12 Dec 2023 14:16:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3331752d2b9so4181573f8f.3;
        Tue, 12 Dec 2023 14:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419405; x=1703024205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHEg6ZXv1YE3c9UTRSvzM/ei4Hb8xqiQ3kNy7PW6Q9U=;
        b=H0EgyQbhW7QLvjby4D58y3B2tLvDocZhuuuiFr5NnAErOX3cJETtKuxK/dv4oJoQGH
         acR+p6ZaAaWB1j0/1rSemo34HNrUq5r+UOSvxS2qD9TKJIEXai2OuNQ6EXhgEoKddejK
         SHEVnaU7j7YTC/PJN+WY2kGPjxVfLs7t0NIQQWe2XckzopMRHCRxb7uSUP/CixkPj4Gp
         Vwt+K1+FZuzlorXkkFeBF8buz/PyfqMdIyeQSEd36cNhehuVEwFqlkec4p82qrZfNoem
         IBe0JKWJWf5KODGstNJ1l3sBy33xCXqfb3+HInCcVCtsh0Wfarp6HgMGbbvXLn7yWqwG
         WVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419405; x=1703024205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHEg6ZXv1YE3c9UTRSvzM/ei4Hb8xqiQ3kNy7PW6Q9U=;
        b=xIk0wzZ6RTZ2bqyMAhUko+JU/57/YQhSsWEe6/D6xfUsaemZSWBdvLMC22FRgdXxne
         4IWeYllh9ZyD3aPbiVQyGLBkKJyY4Rk69/6gYDTGh0g1lt913RrXXbo/Ij2PWwd8WzGm
         dTeL7RB2UEEO/v1TXLHXK4f/xnMglW3Hnn86JyY5adgXzjjb5xpPMXKDZ8CoAyC9u5Jl
         Bc838xtTLBLbYyfowaDMv3NdK/HY3m82IdgJQqFKQ++BxQJZxU4EJZruTh9DjU5Gr2uY
         xtlc84U209bo8VTZczHJzY/BWPOL7BMfD69MfQYuRORGIBdNZlpHsjpNs/1GcXLG1ciF
         kI7g==
X-Gm-Message-State: AOJu0YwosYY2fwqv58EnA6pfcP5/4Kp5GJuxtNBtpRsdqeUHZEMJTihP
	v4IXmIxTr2bE5ZNHfvgnYbYM09h5xIIAHA==
X-Google-Smtp-Source: AGHT+IFNr8oHt+6ib4hM8XNzmfqM+XQOfntzXtWBe0En6NRJIErjNHdd1yVK80dSeN/3KrqPkKWgvg==
X-Received: by 2002:a05:6000:b83:b0:336:3467:6030 with SMTP id dl3-20020a0560000b8300b0033634676030mr1063095wrb.23.1702419405615;
        Tue, 12 Dec 2023 14:16:45 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm11680482wrt.22.2023.12.12.14.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:45 -0800 (PST)
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
Subject: [PATCH net-next v3 13/13] tools/net/ynl-gen-rst: Remove extra indentation from generated docs
Date: Tue, 12 Dec 2023 22:15:52 +0000
Message-ID: <20231212221552.3622-14-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212221552.3622-1-donald.hunter@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
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


