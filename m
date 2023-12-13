Return-Path: <netdev+bounces-57095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB308121DF
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30DB28276C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736EC81840;
	Wed, 13 Dec 2023 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3DQmMhN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96885D56;
	Wed, 13 Dec 2023 14:42:24 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3363ebb277bso770150f8f.2;
        Wed, 13 Dec 2023 14:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507337; x=1703112137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1Cw3Yu6aGvXs5Wx/DiJERo5X0a59a10/3prA+sLwwY=;
        b=N3DQmMhN7DBdil13H9In7xS0S2I0rKO47Ny3RLnTgGvjYA9cvhqeC5ym89GQKW/7QN
         nCcjWuwcTMRYSldTA7tY15nKnveXV8yP/4/OeEnvQUpCSrNifBDd0PJNANXsPKvH0DuQ
         s0RtZTQuZtqeSJlFzbANkvv7z+o1IVo8gbj5JyRDJeqCAMn9RMdnyoXcWWagK9Awgte/
         n3sVZfzzSeAzBo1cettoTder+kMri8ZhOocZrgd3QtlmXSzknBR0MDjYUQD9OxP5R3mD
         nADT5QctBVyLCQTrsh2IBfBrfE6hjdvtbipUkVvtYxwmhWi2haHl0/YU5vRAAzo16v+4
         n31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507337; x=1703112137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1Cw3Yu6aGvXs5Wx/DiJERo5X0a59a10/3prA+sLwwY=;
        b=mbAwTK2HGOaymA2xwae13NGsTjjGdge0yfP/c3LX14Nz3V/3fHu3boo9pq+yHvDK33
         ez1hIUFZTfyHI8aBrWR4lxlKyeKHfcKqMSvEUyr1Pf+Gs7pbYdSH5JCsF/lEqeGXifSR
         qqrhO8oVq8T6vCWOcYsfCYr+eTmpRVje22elDgbOhNnPVAVK9kfi5uieHmV0RCuHpHPR
         EZnR5L3yYif/fkEVsfKO1nvUlPKCPch/XiuejomYCUzAza5guoYIHy8hCntW5T6bJinT
         Vrgn6WAatObPRx62Ul9oQqQyTKZ+bnGvdVemoXzI6Uox+pG/X+xRju1QQiJnOBBC5vCO
         qmvQ==
X-Gm-Message-State: AOJu0YybEjzOTTSAvMec+b4EhnZYaF89DM0ED+qDz22+wYjaAagCJerv
	ZMu1HB/5xJZvBv1vVybSVbi67GAMM+7aHg==
X-Google-Smtp-Source: AGHT+IGtD5sKA1ffZFl9OEdPFfBz1HeouPmCI0fY4okQtoN3SlcC/c9tgFRH5eWIySS6OCHsAW04Ow==
X-Received: by 2002:adf:a4d2:0:b0:333:3e32:8201 with SMTP id h18-20020adfa4d2000000b003333e328201mr3449999wrb.123.1702507337322;
        Wed, 13 Dec 2023 14:42:17 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:16 -0800 (PST)
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
Subject: [PATCH net-next v4 12/13] tools/net/ynl-gen-rst: Remove bold from attribute-set headings
Date: Wed, 13 Dec 2023 22:41:45 +0000
Message-ID: <20231213224146.94560-13-donald.hunter@gmail.com>
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

The generated .rst for attribute-sets currently uses a sub-sub-heading
for each attribute, with the attribute name in bold. This makes
attributes stand out more than the attribute-set sub-headings they are
part of.

Remove the bold markup from attribute sub-sub-headings.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 6b7afaa56e22..675ae8357d5e 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -235,7 +235,7 @@ def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
         lines.append(rst_section(entry["name"]))
         for attr in entry["attributes"]:
             type_ = attr.get("type")
-            attr_line = bold(attr["name"])
+            attr_line = attr["name"]
             if type_:
                 # Add the attribute type in the same line
                 attr_line += f" ({inline(type_)})"
-- 
2.42.0


