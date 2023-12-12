Return-Path: <netdev+bounces-56624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6EE80FA11
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250BA1C20E32
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAA464CE7;
	Tue, 12 Dec 2023 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRn7F02i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE5BAA;
	Tue, 12 Dec 2023 14:16:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3360ae2392eso4226493f8f.2;
        Tue, 12 Dec 2023 14:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419399; x=1703024199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTmLxwDY3uXGw1t8UzPhfep8DgGt/+7AHl7mjkoqE8k=;
        b=NRn7F02ilXh9KnuXxH6VSqiswowludTrrB5HlzkYEaVLcsuiAeDavQ91hCToL3XWeZ
         GEnldFtR6bTSsbhM33liVu7VsZrN3dduyH474jDyzHGtUoXe6QzV96BsD8+c06a2jlmk
         8ycfbsPD/zHxWOvq5zhhc+9TUhvm5t1r1WPjSn7SUVpbC97zGzPUnLGP8Wq8Il+YEhWQ
         376PQsB/MQ8wWmymg3Cqv9yukXLAt9vNkPQ0mIRkn2QkmIu8ouTeMxBpW8rOB7F6QHWh
         ysMllIcULxrqk3AKlG/Onp6PfUv18fMxrfpDfp2DmQfImpVfMbsWy54ERqYdl2VFLtNS
         hJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419399; x=1703024199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTmLxwDY3uXGw1t8UzPhfep8DgGt/+7AHl7mjkoqE8k=;
        b=eK99cjwV707hQ1nCWqBpCtYs8VBZj0gCc5gWyI0ZTSeXQlQIryhCSzby2crkMtYW2y
         UXDGc7stn4LT19P/DbAzZBbpHayOkPqER7VHYm9k6YrzibkA/YZkMm9UXtkQPDzvuvgx
         hmLXCydY+02M+laKiDVXRpzSjj2fqGkv2a4QFIEocQoFB9P7v1+mvDaUanHHGVenpOfI
         bzJdbsUJ/otr+jaou5/U1Mq700gBkFWrkVYYukFRsQNzJy2vT+tAANdTzswTJknwZ625
         rnIM4d3fpnubB0owsuUwhXM72xFGClRvODSDhlZxodlbbikxMTq/PmfK6y8LzPjpo4tq
         2m3g==
X-Gm-Message-State: AOJu0YzIzNRa6QBSnSBQTryHLBSnLw7LNL4BRECBDi6iOOV9NuoYI4w5
	6qCY7G5Cgi1ywz7h3Olmt6ibN7YEpBpkRQ==
X-Google-Smtp-Source: AGHT+IFOE7nWbeekWmSr+gZaH9GT7rmpa9FK5wSXXKGH5u7lKZEPgf1sQ6H61oPwhlf6S6fYPgJaLg==
X-Received: by 2002:adf:fa03:0:b0:333:4a9b:d441 with SMTP id m3-20020adffa03000000b003334a9bd441mr3272235wrr.131.1702419399526;
        Tue, 12 Dec 2023 14:16:39 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm11680482wrt.22.2023.12.12.14.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:38 -0800 (PST)
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
Subject: [PATCH net-next v3 09/13] doc/netlink: Regenerate netlink .rst files if ynl-gen-rst changes
Date: Tue, 12 Dec 2023 22:15:48 +0000
Message-ID: <20231212221552.3622-10-donald.hunter@gmail.com>
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

Add ynl-gen-rst.py to the dependencies for the netlink .rst files in the
doc Makefile so that the docs get regenerated if the ynl-gen-rst.py
script is modified. Use $(Q) to honour V=1 in these rules.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5c156fbb6cdf..5f36a392ddfc 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -105,11 +105,11 @@ YNL_TOOL:=$(srctree)/tools/net/ynl/ynl-gen-rst.py
 YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
 YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
 
-$(YNL_INDEX): $(YNL_RST_FILES)
-	@$(YNL_TOOL) -o $@ -x
+$(YNL_INDEX): $(YNL_RST_FILES) $(YNL_TOOL)
+	$(Q)$(YNL_TOOL) -o $@ -x
 
-$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml
-	@$(YNL_TOOL) -i $< -o $@
+$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
+	$(Q)$(YNL_TOOL) -i $< -o $@
 
 htmldocs: $(YNL_INDEX)
 	@$(srctree)/scripts/sphinx-pre-install --version-check
-- 
2.42.0


