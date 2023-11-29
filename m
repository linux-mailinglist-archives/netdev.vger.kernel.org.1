Return-Path: <netdev+bounces-52084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C527FD3AD
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7CB282E5F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B7E1A5BC;
	Wed, 29 Nov 2023 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4NgSl9v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A0DD7F;
	Wed, 29 Nov 2023 02:12:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332cb136335so4520963f8f.0;
        Wed, 29 Nov 2023 02:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701252754; x=1701857554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yWoSEmRIuqlmSxP7Kp9u1Gyx2u43lx1c7DNGAxn/Dc=;
        b=N4NgSl9vOM+lZ8JrS7qZ96avTIQrGUSEHZPa4a0NX5ZajQJrIFzQizVkN9I9VEIvUr
         /TcpH/Acpavp9KGxptE4OV5gg7Yo2QHBAmte0n5tNewKw5gsF7yBi9UNG+KBlS7yhABh
         KSqRyZm2VyZRfRiaEkk03Y7vs0FpRtQ5LiZWENuLrXAL2NiuqpxAaziCiZ17BUxAhQz9
         OCHiPsk+hhrPauXp4a84ViEJxTw1L7Z3d5LHzKPX7kiguvuvamKEPGeirQxws9iQZkpQ
         8tofP7yvXFUfpRI2uLnBePcGc8qf1mADawZAo70Y5sGicmk9e6AKS8sCEOKpjDLxkrCa
         OmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252754; x=1701857554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yWoSEmRIuqlmSxP7Kp9u1Gyx2u43lx1c7DNGAxn/Dc=;
        b=mjT6FYGEx5q5AlvepJXDyGDAy9JIfK1x/K5uhfTaQGlmCzCB9wapqxcMxsqRs/M7Rx
         PQmPCDH06Gh7QK29O1+abFmKHZdnk0mJ2F0eb5rac1u/n/pDso+rgSCy98a8VP7cAG8D
         wTO8kjacc8RlTLmcemXA4etC19KAqA00764P3UPZLD+eETF1+pxq5nnbvuh1wYaDF77E
         HVFpAZ/ASo9ZFZfSygyFcWSnr3VIZVVtUAV3PZhWYFv9egWSp+cjCaIg4N8JJYatjq6p
         aE+QrEuaKp9yRvJEatGLTYBdNyYNlNoGd5DGK+r3wDbVw/JeIEm/vEeJNQZK9EksHU1G
         hEyw==
X-Gm-Message-State: AOJu0YxMLTNrQFhnF/hL2NregxTMXSp4d2GG5BnHKeL6yMC/nXY6tHUq
	8pNEyve5KFyRS0QP0dtFIou71rW4z63BCA==
X-Google-Smtp-Source: AGHT+IGhaObCzarZG9YqZ4pTQOaRxnkjKHamCuHB7ICDeB68d4Wtu4eFjW5ONT5EuBl6IMBhl7pK8Q==
X-Received: by 2002:a5d:488f:0:b0:333:19b:d32e with SMTP id g15-20020a5d488f000000b00333019bd32emr5566097wrq.56.1701252754365;
        Wed, 29 Nov 2023 02:12:34 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:648d:8c5c:f210:5d75])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm17296877wrc.95.2023.11.29.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:12:33 -0800 (PST)
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
Subject: [RFC PATCH net-next v1 2/6] doc/netlink: Add a nest selector to netlink-raw schema
Date: Wed, 29 Nov 2023 10:11:55 +0000
Message-ID: <20231129101159.99197-3-donald.hunter@gmail.com>
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

Add a 'dynamic' attribute type with a selector that declares how to
choose the attribute-space for nested attributes. Use the value of
another attribute as the selector key. For example if the following
attribute has already been decoded:

  { "kind": "gre" }

then the following selector:

  selector:
    attribute: kind
    list:
      -
        value: bridge
        type: nest
        nested-attributes: linkinfo-bridge-attrs
      -
        value: gre
        type: nest
        nested-attributes: linkinfo-gre-attrs
      -
        value: geneve
        type: nest
        nested-attributes: linkinfo-geneve-attrs

would decode the value as nested attributes, using the
'linkinfo-gre-attrs' attribute space.

This approach was chosen so that different value types can be handled by
the same selector, allowing a mix of e.g. nest, struct and binary.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 38 +++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index ad5395040765..62061e180f8f 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -202,7 +202,7 @@ properties:
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
                         u8, u16, u32, u64, s8, s16, s32, s64,
-                        string, nest, array-nest, nest-type-value ]
+                        string, nest, array-nest, nest-type-value, dynamic ]
               doc:
                 description: Documentation of the attribute.
                 type: string
@@ -261,6 +261,42 @@ properties:
                 description: Name of the struct type used for the attribute.
                 type: string
               # End genetlink-legacy
+              # Start netlink-raw
+              selector:
+                description:
+                  Map of attribute definitions for dynamic selection of type
+                  specific attribute spaces.
+                type: object
+                required: [ attribute, list ]
+                additionalProperties: false
+                properties:
+                  attribute:
+                    description:
+                      Name of the attribute that contains the type identifier
+                      string.
+                    type: string
+                  list:
+                    type: array
+                    items:
+                      type: object
+                      required: [ value, type ]
+                      additionalProperties: false
+                      properties:
+                        value:
+                          description: Type identifier string to match.
+                          type: string
+                        type:
+                          description: The netlink attribute type.
+                          enum: [ binary, nest ]
+                        nested-attributes:
+                          description:
+                            Name of the sub-space used inside the attribute.
+                          type: string
+                        struct:
+                          description:
+                            Name of the struct type used for the attribute.
+                          type: string
+              # End netlink-raw
 
       # Make sure name-prefix does not appear in subsets (subsets inherit naming)
       dependencies:
-- 
2.42.0


