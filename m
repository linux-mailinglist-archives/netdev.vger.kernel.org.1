Return-Path: <netdev+bounces-55988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6497B80D250
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6E528125F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E564D58C;
	Mon, 11 Dec 2023 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7cwHT4x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30D1BD;
	Mon, 11 Dec 2023 08:41:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c3f68b649so23369055e9.0;
        Mon, 11 Dec 2023 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312862; x=1702917662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsQQPUJFA0N9J6n5x1AuH73vk59hYe/eciqUbvnbPDs=;
        b=Z7cwHT4xACEehbOuuE3IgfcGd63VQmPX9WTxSCC8R6LRwlAc3SypB8iccXBIfm5wju
         zkYp7M/oiarOc3NVHDBV0FzzGtaGZjA8F2Ds+Bsyi/Ztjsg4CBrIlF2K9Vz+DR8cL/aS
         SxfLy5aN9ZbBTYnbZoWUxmcJDOO8NnDx3LLN7zbqq+btoLrhASYyRhRkovkPkerQk4F1
         6AcLy7FtjzA6MX7r8aOSzxIG0xdAszwoPCQPCnz9i/z5CkiHpCI4tvBsMVZq9m1PxXyW
         MJ49ZJiVftZzQyLQacvwVxcRmzWDPI/4bUTlDv96/dzs3cIRphFzxq7KD2tSTI7HnIWJ
         ZkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312862; x=1702917662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsQQPUJFA0N9J6n5x1AuH73vk59hYe/eciqUbvnbPDs=;
        b=pPTMx3FBsZxRhVwBMtAkE/kXzKi+LEpzBcsbvQvYhq/s6YBYgiSobOkXMsLWhJQNCB
         wmrro6WN+5JL9tLOx/H8dQaQXCqhwxQva6teYHNAp1mGrr8b59fLSPfGkIf2XhVdSsL5
         7ruYV7By5+GkTUqGp/P3vKpn53YuoowZuKOjAj+lV8Wgp53kG30/WWGgsTS85/Or+Clt
         oSj9p1Z6PbB3pzjddQDY134kJRkZcHtYJFoimKMhtpw660MpTLAR/57UU48fqKLwGo3O
         05qFVeqqhXi0+/nV30Wmm9qtPH2fb5ObjI3/pUOXKss73QxPCifBeRMFldmaQbD7GmEX
         fj8A==
X-Gm-Message-State: AOJu0Yyp1UK5EnxeL2lx9toahEz7aoBzOxJijL1DgGd4cHqY5FSUJatq
	riX4ZwVIraqehIzc2A9dDnlHMuS2qVS4RQ==
X-Google-Smtp-Source: AGHT+IFLkVQAmQ9+Slha9vDncyewXXYSAcJnM/43wGLgNR6l0Iqo2uAxY4KyCIqR3Ux3TsUPgocfeQ==
X-Received: by 2002:a05:600c:44a:b0:40c:3bb2:ca4e with SMTP id s10-20020a05600c044a00b0040c3bb2ca4emr1603709wmb.54.1702312861605;
        Mon, 11 Dec 2023 08:41:01 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm7418679wmq.26.2023.12.11.08.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:41:00 -0800 (PST)
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
Subject: [PATCH net-next v2 05/11] doc/netlink: Add sub-message support to netlink-raw
Date: Mon, 11 Dec 2023 16:40:33 +0000
Message-ID: <20231211164039.83034-6-donald.hunter@gmail.com>
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

Add a 'sub-message' attribute type with a selector that supports
polymorphic attribute formats for raw netlink families like tc.

A sub-message attribute uses the value of another attribute as a
selector key to choose the right sub-message format. For example if the
following attribute has already been decoded:

  { "kind": "gre" }

and we encounter the following attribute spec:

  -
    name: data
    type: sub-message
    sub-message: linkinfo-data-msg
    selector: kind

Then we look for a sub-message definition called 'linkinfo-data-msg' and
use the value of the 'kind' attribute i.e. 'gre' as the key to choose
the correct format for the sub-message:

  sub-messages:
    name: linkinfo-data-msg
    formats:
      -
        value: bridge
        attribute-set: linkinfo-bridge-attrs
      -
        value: gre
        attribute-set: linkinfo-gre-attrs
      -
        value: geneve
        attribute-set: linkinfo-geneve-attrs

This would decode the attribute value as a sub-message with the
attribute-set called 'linkinfo-gre-attrs' as the attribute space.

A sub-message can have an optional 'fixed-header' followed by zero or
more attributes from an attribute-set. For example the following
'tc-options-msg' sub-message defines message formats that use a mixture
of fixed-header, attribute-set or both together:

  sub-messages:
    -
      name: tc-options-msg
      formats:
        -
          value: bfifo
          fixed-header: tc-fifo-qopt
        -
          value: cake
          attribute-set: tc-cake-attrs
        -
          value: netem
          fixed-header: tc-netem-qopt
          attribute-set: tc-netem-attrs

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 51 +++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index ad5395040765..26203282422f 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -202,7 +202,8 @@ properties:
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
                         u8, u16, u32, u64, s8, s16, s32, s64,
-                        string, nest, array-nest, nest-type-value ]
+                        string, nest, array-nest, nest-type-value,
+                        sub-message ]
               doc:
                 description: Documentation of the attribute.
                 type: string
@@ -261,6 +262,17 @@ properties:
                 description: Name of the struct type used for the attribute.
                 type: string
               # End genetlink-legacy
+              # Start netlink-raw
+              sub-message:
+                description:
+                  Name of the sub-message definition to use for the attribute.
+                type: string
+              selector:
+                description:
+                  Name of the attribute to use for dynamic selection of sub-message
+                  format specifier.
+                type: string
+              # End netlink-raw
 
       # Make sure name-prefix does not appear in subsets (subsets inherit naming)
       dependencies:
@@ -283,6 +295,43 @@ properties:
             items:
               required: [ type ]
 
+  # Start netlink-raw
+  sub-messages:
+    description: Definition of sub message attributes
+    type: array
+    items:
+      type: object
+      additionalProperties: False
+      required: [ name, formats ]
+      properties:
+        name:
+          description: Name of the sub-message definition
+          type: string
+        formats:
+          description: Dynamically selected format specifiers
+          type: array
+          items:
+            type: object
+            additionalProperties: False
+            required: [ value ]
+            properties:
+              value:
+                description:
+                  Value to match for dynamic selection of sub-message format
+                  specifier.
+                type: string
+              fixed-header:
+                description:
+                  Name of the struct definition to use as the fixed header
+                  for the sub message.
+                type: string
+              attribute-set:
+                description:
+                  Name of the attribute space from which to resolve attributes
+                  in the sub message.
+                type: string
+  # End netlink-raw
+
   operations:
     description: Operations supported by the protocol.
     type: object
-- 
2.42.0


