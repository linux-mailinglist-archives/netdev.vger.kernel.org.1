Return-Path: <netdev+bounces-57827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA758144A2
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9CC8B22A84
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D461B182CA;
	Fri, 15 Dec 2023 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPVyYEFl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6518AEE;
	Fri, 15 Dec 2023 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c236624edso4900905e9.1;
        Fri, 15 Dec 2023 01:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633054; x=1703237854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGssoF1O5HSfVfjjkIsf0Wdlljg6vF5Ii5rBo5ZZgAQ=;
        b=hPVyYEFlCsnYMcn+l3Q5Cysu0jsryIGtvjlsSKBHEuvQwDm3uPWX3neF+ouEOtukaO
         Jn0aU3UmZMIymK+yLlwKeN34X0OIjv0F/ha7cz2DP8d6ooiPFcIl7L/UMhi9LA352H9f
         /OfulW+RZeQvC1GvfAK2IZiHIVSPqpc0bx2/IIyTWeOuy/LBZk/hZCW1EEQWRw4n5LEb
         PLGhqNkvTQ3GI+4xf1ppng5HLQMAc0Q51xRvb0EVRrSpJFXTzbm9gFtWuwTdGh+GmFx5
         Ak5jRPXZG86CCyzOecoAiRAk8wg7qNu9Wt1425R/gzhv+FivofzB6x/2H/YR9FJhYbn6
         uzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633054; x=1703237854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGssoF1O5HSfVfjjkIsf0Wdlljg6vF5Ii5rBo5ZZgAQ=;
        b=YVEnIO35dcc/4+xV8s3HChhFEYodW2BjIN4LVAseDxM9ccctW7vLM97fgQLH7KAg8J
         o3ljjDSExjkH7Q5hcOCH1qAQ4HgmdDrKkbztq+N3Iw7K/ucJqVUNMoVPoCrSwUws92kM
         Tt4dvSseaYFPElRy3mWs6+oNgPC3RrcxREHoCZClwF94UUjkRSPllEEf02mcHXpZM45A
         JjBp93BPzbZR3LFawmUYGQViZ2mjVnr3QBPxNOHcNIo11Cetza/Qg3YJlRaeGngyFiEC
         5G1ab9PLNg1jzloWD7N8wzkr+C8To6EGebtJq47/Z1u8mdv3ec/HAPxxwUzN3OWPJQS2
         HRTw==
X-Gm-Message-State: AOJu0Yz/SDa8YfLKdIXXyOEOsx4NEuQVWdtCImYuljJY24ZMDtqkDfex
	KIe5/X9XY0PPS76O65anbESfed47CT+vKQ==
X-Google-Smtp-Source: AGHT+IFyujPe52FxJbSXASeM/b9fA9zLjVYkut/VYxtX6adO3mrWRXqJJFxkn6iKboi2CZomSosAvQ==
X-Received: by 2002:a05:600c:1913:b0:40c:3742:59b with SMTP id j19-20020a05600c191300b0040c3742059bmr5792876wmq.114.1702633054561;
        Fri, 15 Dec 2023 01:37:34 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:33 -0800 (PST)
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
Subject: [PATCH net-next v5 02/13] doc/netlink: Add sub-message support to netlink-raw
Date: Fri, 15 Dec 2023 09:37:09 +0000
Message-ID: <20231215093720.18774-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215093720.18774-1-donald.hunter@gmail.com>
References: <20231215093720.18774-1-donald.hunter@gmail.com>
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

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
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


