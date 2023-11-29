Return-Path: <netdev+bounces-52085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5547FD3B0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0753B282E78
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78871B27C;
	Wed, 29 Nov 2023 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuaWtwe6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BF910C0;
	Wed, 29 Nov 2023 02:12:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-332eeb16e39so2844269f8f.1;
        Wed, 29 Nov 2023 02:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701252756; x=1701857556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te2xZ3LGiGKvdmyNt2KwT8wR0BVKNTLKW0pRiCg1eQY=;
        b=HuaWtwe62oQO/4Ot8d8iVj6BmPHNLVNxgdQ3hHQNrw+VuZoyP1JDl+dmbbVm2GIrc3
         1DT+Hgk7GivoP3TtL4Xp66MPwJswHMreqDiMHQZ71sudhUoVuQrWptr2VoyNB0IgA2F5
         f1gqTJXho2RzCWEt5Qt3UIZFarBbfImohf6cwvcyBTZAiXi1ezQxPjO6+fMyl83nTuFt
         1DUW0XfOc8Ril/ECjQOyNAht+dkx7OQhB4gUClIZxZb/k3lfzG5MH2Dt49sVKs22+B34
         hlcVyz3HccFbADbmGsGL92wkq7snue+W0NubKOMPD145Ifn2DZpFUPo6fJpxa/iNV6M4
         31kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252756; x=1701857556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te2xZ3LGiGKvdmyNt2KwT8wR0BVKNTLKW0pRiCg1eQY=;
        b=W/W/1D0w43kHTxO3PteXaGwsClPK6VF4Vhv7hVwIbzWpPp+M1Aa4J3jJSlMKBp3cUt
         DmNSCAb4tKn4OGw/Tl+WtVuOve78lwdVzO4lkIPXFXr12y9GMmFX2KDBIWg4wlei4xFr
         WIQUnwUk+N+MMcsEVPkYfWo3mdCwsZlypp58Wg25ov3m6yV09OQNgOiNIDaeZDtBJkHo
         Uu8QNQym8mZG0nb+uoLt0wPXEe/sB0VZ4NVk4T4j6df5QRR6n3iDcCQIIIdfLs99rs98
         V1R+zyeOxg9D6VnN48K+sLb8j03IKPqyNW0yec5l2a+Ky70O9G85IA97VmPob9ozIb/e
         yoVg==
X-Gm-Message-State: AOJu0YyJH0+G9Hls4InyF+fADooO6GYmxtKFgLAs+a7Q7WwMYg0H0BzL
	/RsHpdRDUyIwYbPo+JUyDYedUSccCAXM4A==
X-Google-Smtp-Source: AGHT+IG1v8egTwKqRxhVvfXv9Ct69hz779yjsLCIqc3TRqZoPCqtTD31ZK9qYE6E4zQ4eWcY24ZNag==
X-Received: by 2002:adf:e602:0:b0:333:9eb:5005 with SMTP id p2-20020adfe602000000b0033309eb5005mr3722156wrm.27.1701252755852;
        Wed, 29 Nov 2023 02:12:35 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:648d:8c5c:f210:5d75])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm17296877wrc.95.2023.11.29.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:12:34 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [RFC PATCH net-next v1 3/6] tools/net/ynl: Add dynamic attribute decoding to ynl
Date: Wed, 29 Nov 2023 10:11:56 +0000
Message-ID: <20231129101159.99197-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129101159.99197-1-donald.hunter@gmail.com>
References: <20231129101159.99197-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement dynamic attribute space selection and decoding to
the ynl library.

Encode support is not yet implemented. Support for dynamic selectors
at a different nest level from the key attribute is not yet supported.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/nlspec.py | 27 +++++++++++++++++++++++++++
 tools/net/ynl/lib/ynl.py    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 92889298b197..c32c85ddf8fb 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -142,6 +142,29 @@ class SpecEnumSet(SpecElement):
             mask += e.user_value(as_flags)
         return mask
 
+class SpecDynAttr(SpecElement):
+    """ Single Dynamic Netlink atttribute type
+
+    Represents a choice of dynamic attribute type within an attr space.
+
+    Attributes:
+        value         attribute value to match against dynamic type selector
+        struct_name   string, name of struct definition
+        sub_type      string, name of sub type
+        len           integer, optional byte length of binary types
+        display_hint  string, hint to help choose format specifier
+                      when displaying the value
+    """
+    def __init__(self, family, parent, yaml):
+        super().__init__(family, yaml)
+
+        self.value = yaml.get('value')
+        self.struct_name = yaml.get('struct')
+        self.sub_type = yaml.get('sub-type')
+        self.byte_order = yaml.get('byte-order')
+        self.len = yaml.get('len')
+        self.display_hint = yaml.get('display-hint')
+
 
 class SpecAttr(SpecElement):
     """ Single Netlink atttribute type
@@ -173,9 +196,13 @@ class SpecAttr(SpecElement):
         self.byte_order = yaml.get('byte-order')
         self.len = yaml.get('len')
         self.display_hint = yaml.get('display-hint')
+        self.dynamic_types = {}
 
         self.is_auto_scalar = self.type == "sint" or self.type == "uint"
 
+        if 'selector' in yaml:
+            for item in yaml.get('selector').get('list', []):
+                self.dynamic_types[item['value']] = SpecDynAttr(family, self, item)
 
 class SpecAttrSet(SpecElement):
     """ Netlink Attribute Set class.
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 92995bca14e1..5ce01ce37573 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -549,6 +549,36 @@ class YnlFamily(SpecFamily):
         else:
             rsp[name] = [decoded]
 
+    def _resolve_selector(self, attr_spec, vals):
+        if 'selector' in attr_spec:
+            selector = attr_spec['selector']
+            key = selector['attribute']
+            if key in vals:
+                value = vals[key]
+                if value in attr_spec.dynamic_types:
+                    spec = attr_spec.dynamic_types[value]
+                    return spec
+                else:
+                    raise Exception(f"No entry for {key}={value} in selector for '{attr_spec['name']}'")
+            else:
+                raise Exception(f"There is no value for {key} to use in selector for '{attr_spec['name']}'")
+        else:
+            raise Exception("type=dynamic requires a selector in '{attr_spec['name']}'")
+
+    def _decode_dynamic(self, attr, attr_spec, rsp):
+        dyn_spec = self._resolve_selector(attr_spec, rsp)
+        if dyn_spec['type'] == 'binary':
+            decoded = self._decode_binary(attr, dyn_spec)
+        elif dyn_spec['type'] == 'nest':
+            attr_space = dyn_spec['nested-attributes']
+            if attr_space in self.attr_sets:
+                decoded = self._decode(NlAttrs(attr.raw), attr_space)
+            else:
+                raise Exception(f"Unknown attribute-set '{attr_space}'")
+        else:
+            raise Exception(f"Unknown type '{spec['type']}' for value '{value}'")
+        return decoded
+
     def _decode(self, attrs, space):
         if space:
             attr_space = self.attr_sets[space]
@@ -586,6 +616,8 @@ class YnlFamily(SpecFamily):
                     value = self._decode_enum(value, attr_spec)
                     selector = self._decode_enum(selector, attr_spec)
                 decoded = {"value": value, "selector": selector}
+            elif attr_spec["type"] == 'dynamic':
+                decoded = self._decode_dynamic(attr, attr_spec, rsp)
             else:
                 if not self.process_unknown:
                     raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
-- 
2.42.0


