Return-Path: <netdev+bounces-30311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91BA786DBC
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82081C20E27
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88376111BA;
	Thu, 24 Aug 2023 11:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1EC1119D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:20:28 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1752219BD;
	Thu, 24 Aug 2023 04:20:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401b0d97850so2371455e9.2;
        Thu, 24 Aug 2023 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692876024; x=1693480824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHo0WyP8xgW16yDEg6dBt6z1hcOwztrudJTUIb2n8nc=;
        b=seq9zvt5ElfFLErccMzSgjRYXACItf1unV/E6WOrf4yInZgbx3A29TwlPpRXG4NLUu
         3nwGAl9G+PPwTo2kBU4O1b031ycLJxCavKi3AiQPHigyl40Ol9VuIqunYrCSZqi3XAoH
         frUBdH5PpPECooLacJT7Ai337TtfiUA6QKiw/gtc/+RUTDyF2rjABnJ47hm+WEDSUz8a
         k0vySsd9AmmB2Ouxa5MNCRUsaPA7pUFkUFUKeEbPWtTMipR3jA+6Raqw43qZpWGGk9G7
         tUT6hE1m8/wN5mdNdtSx2lFrQDp7i99vbriX8tlRPjlQtjkhT2Rmjts2gvgA8sxsDnkn
         jnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876024; x=1693480824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHo0WyP8xgW16yDEg6dBt6z1hcOwztrudJTUIb2n8nc=;
        b=Hjg6KlS9/xI5I2J8H4UxY85bSeYCSketQEU7WScHLsmtihtrVwvsVsIrlhScdfSvqz
         7Qz3TLeHskuDG7QhhawT+JJgpIoHDwdJIdLwzxTE23EsNVg2GKKqIVNhsz0ja6/wRPez
         miEyI+YLRcJ8RtrJrSa7p75EXdYmg2ypBKy8YBikhZ5b2QXze/9RXmryAvClhvZze4jG
         XRA6aSR67hprS4O9yaviJEJSoxOzOEUvMyK6H9/8t6g78SEZHdME3wdpvFoKaSeTyoIH
         iX/GBKbatThNm/bIKff7MmcxciCEzAy3sw4JcF62eVVTMeBePGQzrzOOX5+e+dVIJM7h
         xlqw==
X-Gm-Message-State: AOJu0YzDzUttCZCq0yzEDSKNXUjdaxyEOPdWIGJBy7RPhPGe4Vl057pt
	Fykjb2dZ/hGmS/3gey+KxmPm0Rd6v0pNQQ==
X-Google-Smtp-Source: AGHT+IHnl200izGVnvM+E3LfWpfRIWzbCiPiStalVBBSzXeLRQxTd+f0zXrlXR9BPkRnv3YAdWIhtQ==
X-Received: by 2002:a05:6000:8b:b0:314:36f0:2214 with SMTP id m11-20020a056000008b00b0031436f02214mr10472163wrx.6.1692876024049;
        Thu, 24 Aug 2023 04:20:24 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d630e000000b0031980783d78sm21875295wru.54.2023.08.24.04.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:20:23 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v5 08/12] tools/net/ynl: Implement nlattr array-nest decoding in ynl
Date: Thu, 24 Aug 2023 12:19:59 +0100
Message-ID: <20230824112003.52939-9-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824112003.52939-1-donald.hunter@gmail.com>
References: <20230824112003.52939-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for the 'array-nest' attribute type that is used by several
netlink-raw families.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 tools/net/ynl/lib/ynl.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index e5001356ad0c..5d04a2b5fc78 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -492,6 +492,17 @@ class YnlFamily(SpecFamily):
                 decoded = NlAttr.formatted_string(decoded, attr_spec.display_hint)
         return decoded
 
+    def _decode_array_nest(self, attr, attr_spec):
+        decoded = []
+        offset = 0
+        while offset < len(attr.raw):
+            item = NlAttr(attr.raw, offset)
+            offset += item.full_len
+
+            subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
+            decoded.append({ item.type: subattrs })
+        return decoded
+
     def _decode(self, attrs, space):
         attr_space = self.attr_sets[space]
         rsp = dict()
@@ -511,6 +522,8 @@ class YnlFamily(SpecFamily):
                 decoded = True
             elif attr_spec["type"] in NlAttr.type_formats:
                 decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
+            elif attr_spec["type"] == 'array-nest':
+                decoded = self._decode_array_nest(attr, attr_spec)
             else:
                 raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
 
-- 
2.39.2 (Apple Git-143)


