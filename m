Return-Path: <netdev+bounces-55984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66F380D242
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6311C213CE
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C47D3B785;
	Mon, 11 Dec 2023 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2TEWRyD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C7B8E;
	Mon, 11 Dec 2023 08:40:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so18794775e9.2;
        Mon, 11 Dec 2023 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312857; x=1702917657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMq84b1ixh7LsEvwYtWDIyUwWStfl0XyTRo6LMJFqeE=;
        b=e2TEWRyDhkcSruW/b2mQEv9f803D2O87UnhU/W56CFD3347w1wk6F+rkk0pLbMpMrQ
         J7S2Wb31o0jC7KlJk0c9fy0xjnP5zztmfUnmchchy4RVkhjsSCzUez2ElNGNSs/of080
         GQ6azCa/DrQ3srREX+QEBWzS8kl/LFEue6sJJ8iAjsGvPCiEOHOQfhPnzI0Kj+kmMycJ
         45sFrNk5uEn0UNmJncg4RS4NGxvgFS+FF5MRP/l+ID9oX0PPwqtbKyAx/BoqqeyQ5ohK
         Nxtttv+fhh4/keXn0r6iyFWLxOeSlG0rfsTt26iJtilE2xFvWvuZXnyX1ObnAvGBRT2j
         gqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312857; x=1702917657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMq84b1ixh7LsEvwYtWDIyUwWStfl0XyTRo6LMJFqeE=;
        b=rChagLd3toAgVmpnbyVq3HfehMYUftrr6a0+VOTQ3c3jwJZZXOlEqFxKeCQpRq8N9A
         XNd390oL31EoogfbP4A3fG+opQMP11tcCQO6JfUOg1wVqytWF+4spQQUFB2RlOwIGRAr
         CcBANSZuJ3oMFZZ05E2d7FVgvtNbqZvn2BQpdjpKCP3EUEVuaiByP015ByAluKtDaouB
         5jpowAblQQFbfsWWczxggncDPW8SMT68o8fgCKRGVKySUXzQhP0znsrm+KP1DKi+a02M
         oip8DP8C6sJfAC/pKg8pUd061ZLreN1c9K46J23KdojXdXaFpBr0LNgvXg0/9RioNcmO
         G7Tg==
X-Gm-Message-State: AOJu0Yw12nbcRspyBGWQFzExphuLyXAqc5VX3SALVk3cnrifvz4BsH/n
	evlDurnV6QnyGHt6jPVLqm8RqxKKjfzRRA==
X-Google-Smtp-Source: AGHT+IGQ27lvIADIzR1rsQC1lh3WGxdrUezHNgsu2JCSVO9hPxfEnY56AN572YbCA0eCFK61vv/nvA==
X-Received: by 2002:a05:600c:21c7:b0:40c:28de:63d5 with SMTP id x7-20020a05600c21c700b0040c28de63d5mr2412495wmj.144.1702312855127;
        Mon, 11 Dec 2023 08:40:55 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm7418679wmq.26.2023.12.11.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:40:54 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 01/11] tools/net/ynl-gen-rst: Use bullet lists for attribute-set entries
Date: Mon, 11 Dec 2023 16:40:29 +0000
Message-ID: <20231211164039.83034-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211164039.83034-1-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generated .rst for attribute-sets currently uses a sub-sub-heading
for each individual attribute. Change this to use a bullet list the
attributes in an attribute-set. It is more compact and readable.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index b6292109e236..a1d046c60512 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -240,7 +240,7 @@ def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
                 # Add the attribute type in the same line
                 attr_line += f" ({inline(type_)})"
 
-            lines.append(rst_subsubsection(attr_line))
+            lines.append(rst_bullet(attr_line))
 
             for k in attr.keys():
                 if k in preprocessed + ignored:
-- 
2.42.0


