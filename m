Return-Path: <netdev+bounces-55986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD60480D24A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984A32819AC
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BFA4CE12;
	Mon, 11 Dec 2023 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf+xlH6N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE999;
	Mon, 11 Dec 2023 08:41:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c3f68b649so23368505e9.0;
        Mon, 11 Dec 2023 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312859; x=1702917659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlNSZVQHBMTDZhp80OGMMJ5AyxFceDk7/7lyntcJyn0=;
        b=Lf+xlH6NozTlaT4wSCC8fz0mWWVpFcCaEOWt1LIDp7+ZP6gHlRiGffMaXXoBI8U+pU
         TaThi2TVCzJX1a7HUTV1saRp7G8FH7sb7mNuKVp01INT/+4HQiRCCl27Cm+ibrrVj1lz
         dpI+15TVnlQiTRa7s4mmIGNqXA4Hz3EneDNaL91ZIaORzO58TuDhDMQLYC2XyYfD7ESb
         5TRRR39gbmH+k++obxZzqJesUTp2UdIlzCZZTkcNyVEBWG3kfC3PBeSQOW9HDkH/4hAG
         ApvBDtT92nF3IkQvKCQbaLdxKzkts9G5FN8mUc8yqHRVrj5eDktnPP7+Kr6Ct73g45cT
         pcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312859; x=1702917659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlNSZVQHBMTDZhp80OGMMJ5AyxFceDk7/7lyntcJyn0=;
        b=KrODzXCvCf3EOQsiQbL83L45wD2juBVsAtrlY9KOptpyQ79dDZRTX0PNJPnWa6xLk3
         uM1sRbK5dcBWs0FTdum/7uedp4I3NuYt7jqdg3m1gDH9XPsqidq7a7aN+fl6vGpwPl6w
         pF9yL8XkYl/XWipL11UlxJ1BnkFBtCwGV42ZUbwrR6+Q0SrdVATFPBuSf8C1SXTDEvsE
         17ESwodQR0VDKHQZlf13Wgm4tE82bqBzd5mIFJ6iuShhsRYkPhRGOX7wYxmf77m0wu3h
         lNTbYc0/ZqEKRf+Po0Py/6zs5folD1jp7wpkfpPN80hn99w0wyP0fl4hLCxalfd9dd5y
         AN4A==
X-Gm-Message-State: AOJu0YxaiZebY4+uZTvc1i47xjLBTIG8DI5zD1GiDRdySSFwdCK8Z1N/
	NP6tkWsLU4YJ1ePO0Cg33fB9UMB477cXYw==
X-Google-Smtp-Source: AGHT+IFFy/stuYp33ecwZEwSZKKcs9bPDRC66WvlrmdAQqyohW0U5EhMuQchEfjDhy/ZTrDE0qrWjQ==
X-Received: by 2002:a05:600c:2251:b0:40c:347b:b5c4 with SMTP id a17-20020a05600c225100b0040c347bb5c4mr1541177wmm.237.1702312858838;
        Mon, 11 Dec 2023 08:40:58 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm7418679wmq.26.2023.12.11.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:40:58 -0800 (PST)
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
Subject: [PATCH net-next v2 03/11] doc/netlink: Regenerate netlink .rst files if ynl-gen-rst changes
Date: Mon, 11 Dec 2023 16:40:31 +0000
Message-ID: <20231211164039.83034-4-donald.hunter@gmail.com>
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

Add ynl-gen-rst.py to the dependencies for the netlink .rst files in the
doc Makefile so that the docs get regenerated if the ynl-gen-rst.py
script is modified.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5c156fbb6cdf..9a31625ea1ff 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -105,11 +105,12 @@ YNL_TOOL:=$(srctree)/tools/net/ynl/ynl-gen-rst.py
 YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
 YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
 
-$(YNL_INDEX): $(YNL_RST_FILES)
+$(YNL_INDEX): $(YNL_RST_FILES) $(YNL_TOOL)
 	@$(YNL_TOOL) -o $@ -x
 
-$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml
-	@$(YNL_TOOL) -i $< -o $@
+$(YNL_RST_DIR)/%.rst: $(YNL_TOOL)
+$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
+	$(YNL_TOOL) -i $< -o $@
 
 htmldocs: $(YNL_INDEX)
 	@$(srctree)/scripts/sphinx-pre-install --version-check
-- 
2.42.0


