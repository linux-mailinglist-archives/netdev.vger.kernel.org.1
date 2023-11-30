Return-Path: <netdev+bounces-52631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F3E7FF868
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B0428149A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F342E5810E;
	Thu, 30 Nov 2023 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4i3Zyhn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F9110DF;
	Thu, 30 Nov 2023 09:37:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b4744d603so10659885e9.2;
        Thu, 30 Nov 2023 09:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701365827; x=1701970627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsQQPUJFA0N9J6n5x1AuH73vk59hYe/eciqUbvnbPDs=;
        b=Q4i3ZyhnYqAnC5xetz3AnhBtP5ixdmvlalqHXLpns7RsP64t0Zwz3eVmjE+ecO/iA8
         iDy09NxDI6o/G7pS/8nxxDZBczc3xDhyg0//uoNGhuj3Azbsz8n6EvzRw8zen4fA70Kf
         +P7X1pY5oc3CtlI48PjXHjwfVH2RoPd/L/SjgZZDpw1qCFRRLB8gC5ozfBWfXh+ItDBG
         FePX+NlhOjipST6hVM91ogICU+tWul++Ci/PCNZgyphirLTtXdkUBk/0756rFmbgSNmR
         lJuSRQRVF9/rOCQvsTiIUoTTHGzI3CmUhIj5+PFxvvLnqb19LJFbfT126oeqj1tIjt3p
         Uu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365827; x=1701970627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsQQPUJFA0N9J6n5x1AuH73vk59hYe/eciqUbvnbPDs=;
        b=QgenBGk/Vmhd0JBb/HYF/By1gJlgGEowssoVFILY5WeRQCX3bZBJPn6pQ1RYVtOaTG
         x2fQ56zlMTH0w2PRlv74j2l9oCXjMiVbt5U7ZGtWXgBb7yfl/tOnFaGR952+PL3fdhnE
         bTAjTZw5ptuW6w4LiNxk7DCt+IFWIDUTCAK9A3G2ecOqqJ7iRGnfgCBaWudOeZtvRv5s
         KAlsNJHrEF6g4O9jOGOzeBEo0EShnaeJeDQw6UuMQqpTxDSDVqwnH/duPpHE9PVRlojP
         153cS8SP4//mf4PKgT5n2hyMYNjCjyXxF7kvBVjHU4HV4wOjshrIOZnAHM6wAMoQ7U6H
         jFGg==
X-Gm-Message-State: AOJu0YzcE/W4voCDdP1oOXuI+xra4iBtqKTNyokGyCW44GSpJqZ1GBfo
	VLxB1bao5gYiWs6yRcb2liX/iuYXIsj9kw==
X-Google-Smtp-Source: AGHT+IE5faEIkI09n5rI5etseYzweeI9aTeCq2ocgEFRooRPIxnCBE6QCV+ZBcFNokX5vGG4+Gr4xA==
X-Received: by 2002:a05:600c:4e8e:b0:40b:3d92:de29 with SMTP id f14-20020a05600c4e8e00b0040b3d92de29mr5929wmq.14.1701364246505;
        Thu, 30 Nov 2023 09:10:46 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4842:bce4:1c44:6271])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b00327b5ca093dsm2014531wrm.117.2023.11.30.09.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:10:45 -0800 (PST)
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
Subject: [PATCH net-next v1 2/6] doc/netlink: Add sub-message support to netlink-raw
Date: Thu, 30 Nov 2023 17:10:15 +0000
Message-ID: <20231130171019.12775-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130171019.12775-1-donald.hunter@gmail.com>
References: <20231130171019.12775-1-donald.hunter@gmail.com>
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


