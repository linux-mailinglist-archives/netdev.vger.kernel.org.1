Return-Path: <netdev+bounces-57099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF528121ED
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42A628271E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D281850;
	Wed, 13 Dec 2023 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiXRw7tT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1C8199F;
	Wed, 13 Dec 2023 14:42:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-333536432e0so6797099f8f.3;
        Wed, 13 Dec 2023 14:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507321; x=1703112121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27uWkbmkyJPi62oM04ESj5+OaIZhxLf9WPx67Wq2coQ=;
        b=eiXRw7tTzpcPD8f6+cDyLoAkAXuqGeFcg7bP5i/FMlxFgXfze1SNDi3HfC9FqnE+gs
         D7veXfb2M4eyvSfv4pUuZmBc0Rd3k51JiMRvKApNTIULtEMN7cLFKbHRdI0AlKL2m5cE
         ucmxjra1r1/H9mgKEZtD24Xyg3P5hn4nxRHXsq/kSlfCel2KzvSNVSvLIHnQmv/1H6AU
         LyH8bRc345hUHb/JmLg2o0ec/mSBU6SaUqidiEbTWts2x1qpnSnbhYoWHmTGY0PvtXX/
         wWuGgFK9LOwbMDmoifagXLgD7q4uZolsia4qtiENBd0jEoasJ/vXNYS0D6b1+O79epDB
         OQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507321; x=1703112121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27uWkbmkyJPi62oM04ESj5+OaIZhxLf9WPx67Wq2coQ=;
        b=rzJfQVRaG1k8lg4ozNuGfk8Ci+7J5pIOPcxcfn5KrFtBQc1QF1VCTAPduKnRM5THHK
         ymLJR8iK2h3EaqWqBYnzmZZai3WPOORFXo1IuXZPCm5bvGHJgRpZCmg1iE8UG0KF6xXp
         8mwTDPKaPoXxEWAywD0y4zE6ealXccnPvKqDEmOae3/JOxc2MmkgwZ1HA3Gdswq2CNfA
         fyJvRUeSjZTC9YbSoh23IL02yJxvt/5wLqyFzvWZtzv7qsUAVTErxP4s2G/mRtGQ18tk
         Wx2Q2RB6g2PNX7m4c83kn8SaWCc8ioUbM3Ci7zyUTTHeXDIqBUw/AjcfNO46xW6fhU7X
         TlVA==
X-Gm-Message-State: AOJu0YwgkCwwnuE3mWWkeCCc0e/NlCWv8LHd6u5dhrxVmyn1TvOeW04F
	MRllAGR8i0EWzQPoerUVYNMWjPOtqgwOuw==
X-Google-Smtp-Source: AGHT+IGY1Vlcty4Ay/49KKrxDFuCm+CtG/P8pthWINp6Wb4PAeP7N0CJDspISkVwBErjOgCVf92lnA==
X-Received: by 2002:a5d:6208:0:b0:333:2fd2:6f54 with SMTP id y8-20020a5d6208000000b003332fd26f54mr4118385wru.94.1702507320762;
        Wed, 13 Dec 2023 14:42:00 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:41:59 -0800 (PST)
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
Subject: [PATCH net-next v4 02/13] doc/netlink: Add sub-message support to netlink-raw
Date: Wed, 13 Dec 2023 22:41:35 +0000
Message-ID: <20231213224146.94560-3-donald.hunter@gmail.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/netlink-raw.yaml | 65 ++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index ad5395040765..04b92f1a5cd6 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -126,8 +126,10 @@ properties:
               name:
                 type: string
               type:
-                description: The netlink attribute type
-                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary ]
+                description: |
+                  The netlink attribute type. Members of type 'binary' or 'pad'
+                  must also have the 'len' property set.
+                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary, pad ]
               len:
                 $ref: '#/$defs/len-or-define'
               byte-order:
@@ -150,6 +152,14 @@ properties:
                   the right formatting mechanism when displaying values of this
                   type.
                 enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+            if:
+              properties:
+                type:
+                  oneOf:
+                    - const: binary
+                    - const: pad
+            then:
+              required: [ len ]
         # End genetlink-legacy
 
   attribute-sets:
@@ -202,7 +212,8 @@ properties:
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
                         u8, u16, u32, u64, s8, s16, s32, s64,
-                        string, nest, array-nest, nest-type-value ]
+                        string, nest, array-nest, nest-type-value,
+                        sub-message ]
               doc:
                 description: Documentation of the attribute.
                 type: string
@@ -261,6 +272,17 @@ properties:
                 description: Name of the struct type used for the attribute.
                 type: string
               # End genetlink-legacy
+              # Start netlink-raw
+              sub-message:
+                description: |
+                  Name of the sub-message definition to use for the attribute.
+                type: string
+              selector:
+                description: |
+                  Name of the attribute to use for dynamic selection of sub-message
+                  format specifier.
+                type: string
+              # End netlink-raw
 
       # Make sure name-prefix does not appear in subsets (subsets inherit naming)
       dependencies:
@@ -283,6 +305,43 @@ properties:
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
+                description: |
+                  Value to match for dynamic selection of sub-message format
+                  specifier.
+                type: string
+              fixed-header:
+                description: |
+                  Name of the struct definition to use as the fixed header
+                  for the sub message.
+                type: string
+              attribute-set:
+                description: |
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


