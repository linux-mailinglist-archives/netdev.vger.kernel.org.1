Return-Path: <netdev+bounces-57104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A848121FD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD781B21084
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500C081859;
	Wed, 13 Dec 2023 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4u1tjSv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E8818A;
	Wed, 13 Dec 2023 14:42:21 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-33638e7f71aso12592f8f.1;
        Wed, 13 Dec 2023 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507332; x=1703112132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLA+yZoLDjFMN/O1juANGCrbT+QdJr4gSE0ytCTmmgg=;
        b=c4u1tjSvxiVgT/Q6VzPGaTXFxfehipPkK1FS1FGq5QcXkrPDcpW6mtHhxb9bf5E85a
         DR4+sdXHaRLMsk3YvR9PJSs0ZYBACdP2elvxKXGTuSCK0QD8x0yA4hRBQtGe/8IxfIoy
         ruj4WhXe/jgXgJZPVE5BR8c3enHnNgTO6ljQtcdlk5rD2dZN/g5Y9qu8pl6yVKVrisE6
         CbzF6tEwP9VyzNg5aam58bmj9qLfRJ15IPXcHBb0QXfJGrlf56SPE6pGo+swmwpYEkVw
         Fq1j7DpP5O/xwzZ2kHrKBdIM6m2wZxny4avMqFcLoRptwkUh7YnyirU/oaExzex1X3DW
         BuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507332; x=1703112132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLA+yZoLDjFMN/O1juANGCrbT+QdJr4gSE0ytCTmmgg=;
        b=K+WloECAXWodkmsUmm4MsyIC4LfqgRHHPj1/eIaNe2mM9cIenLFDbPgSlYFQWZbNsZ
         xbiGN7ttTYFyK/OAUwkKl+d7Dzpnbj5ePNlVFuisw5mJhRZLryurgm6y3HkguN5mUi14
         Aa56wKw7QD4ymB2/IxjKnJQj+vYcrMqdGHmxDLwHkHzU6AjnYFVpOgquvALLbBze2gGn
         1n5QohI0f/bNj5py5qDZBDEHnK+B3Ah1O4SaV2m5TyXZMsXWpUG4Xwma8hYkGfAq7YTP
         yEeTh4ueDgKWmDgf9yKkTnveKGbhI8tVzY5Pn4M8Ne+YQrzyXPsO8yVHN5XWbBhppKnx
         ebIQ==
X-Gm-Message-State: AOJu0Yw2Q1k+noBT1oTxuAnhb6sX6TXc7uX9DDQXU/uZQtGCrp5d7lnN
	sEzUptxT5DSS7zhtrKQzZECa141NQa+2pQ==
X-Google-Smtp-Source: AGHT+IHwwRdiOM6SzNxTg3j+mxfZCkh/ui5oZxQYO7Sxu6FeJbfuyRxNTm9STeKXI+YfvUkXXIFcsw==
X-Received: by 2002:a05:6000:8c:b0:333:2fd7:95fd with SMTP id m12-20020a056000008c00b003332fd795fdmr4797055wrx.56.1702507332471;
        Wed, 13 Dec 2023 14:42:12 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:11 -0800 (PST)
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
Subject: [PATCH net-next v4 09/13] doc/netlink: Regenerate netlink .rst files if ynl-gen-rst changes
Date: Wed, 13 Dec 2023 22:41:42 +0000
Message-ID: <20231213224146.94560-10-donald.hunter@gmail.com>
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

Add ynl-gen-rst.py to the dependencies for the netlink .rst files in the
doc Makefile so that the docs get regenerated if the ynl-gen-rst.py
script is modified. Use $(Q) to honour V=1 in the rules that run
ynl-gen-rst.py

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 Documentation/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5c156fbb6cdf..3885bbe260eb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -106,10 +106,10 @@ YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
 YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
 
 $(YNL_INDEX): $(YNL_RST_FILES)
-	@$(YNL_TOOL) -o $@ -x
+	$(Q)$(YNL_TOOL) -o $@ -x
 
-$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml
-	@$(YNL_TOOL) -i $< -o $@
+$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
+	$(Q)$(YNL_TOOL) -i $< -o $@
 
 htmldocs: $(YNL_INDEX)
 	@$(srctree)/scripts/sphinx-pre-install --version-check
-- 
2.42.0


