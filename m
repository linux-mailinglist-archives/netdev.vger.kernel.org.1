Return-Path: <netdev+bounces-73011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D939085A9E1
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5C0289498
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FF544C97;
	Mon, 19 Feb 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IqA17tyQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663744C93
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363546; cv=none; b=MeAtBHBrXdKoyUukWd0JVp4loXWuEdM0J6+1Z35iuvsEo3VAJYSEt6WDr2L/b/M+svNqoh4IOxbDdCkX3vhFOweUnKkyJdBdq3dDTBG13rjEOnJfgpQ8V7BHcJRU9f2xoT/IE3/gTdZ30DmFRnZbsdToUcOfZoHiwyCDUAXSA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363546; c=relaxed/simple;
	bh=d0eb+U915M3GJ1QpP3eRMvvJkhiVcCy55exGLeOsQug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyZN1dPkWcRklgrgKx9LQw8XfVftmcbf0S7nigabnH7U28ERt+w6F9JznowBdIbKlYMkW74Dq1vYEWQ2iHOxo6IrfgQiBFt0gAauECU4GjbRM4At4kGKQjAF/pNzTxU18wy8B5MqIvwXKmgMh0HjyX74smxCIw9AhFvZmwRqaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IqA17tyQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d640e7b48so101157f8f.2
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363542; x=1708968342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6Oq8wW83mYv2l6m5dZRs9rPR7CIzDAECgxUbwAoQGs=;
        b=IqA17tyQqqhCIGFqltowlZ25vmnRJmDvpngLKNtRv95L2Ye7nIceHr1X6JH6RybWSV
         +rhwZR+fPjdp1RS/YKkp9lt9jRJAt4//K1FiZhVFQHK6cpZyPJTxhJd/IOEpPjeHLgVn
         /FBrVUh6TxzA2HPD+/KGsanW1Wh+gBfu9DjH7pp5b9w5JeCO04+PsLapNwahLw141wvi
         3ThEIokkFdnTt4g62h91d17dpmfJxwCMNKu9yDh4ebNyTUyNcGciaqJDyIhNjFBtoWXf
         sEN7XR1vAGNpU7p8rCrR0QWfR76GHHUpgsM/eO2igeXkOQBlzvPxug3iKA0EmLZ0LQGu
         dq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363542; x=1708968342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6Oq8wW83mYv2l6m5dZRs9rPR7CIzDAECgxUbwAoQGs=;
        b=ed2CAFiGuNhy60sAGCYxshqRtN6FkvoHohB7dYl6nc/z64ziH2+X67zH/5NVEVrDKi
         pvmhXdyvQOMpOX3uibvezyiZDxVpjKlyo/ifI5nCdJx3uBH98s6Ungba9ZBSHT4exCj4
         BK79Hj6JWR9i7LieIIg4NOrm+GpxoWjz/gL2uyhsY/1ABOYtBiyBo6zmCBZHOprlN2kh
         kDXODvhZR8dO9KkB65UuytXlBQ+eXXVSmN0OZkHMB/b6bNJD3jl4FzZrJp4yPNFQSaQm
         I55/b32M7pFsItJS4lCgQSujj14SL3Izt2CpM9Q9QPQInDy9Iyft4unMRP6qJW5pOlNq
         Jd+w==
X-Gm-Message-State: AOJu0YwxrKbqWN1s3VF4feC8cerag1nxnUZ9pSddz7tBcukYnYH3Ipne
	In5LGvpSMzj7cf380RPFB8U4cFZx7iEneQPuG9usrTVNkIU0c9QK44RgLGaFDJEsVtNHPBZZMOU
	L
X-Google-Smtp-Source: AGHT+IFM4NCSECoV+80IhSeH27lpFPrvZpbufRPDWjJ3iWabCnv/EgQtqiRZvIhSPUjtP9NrXaihaQ==
X-Received: by 2002:a05:6000:110d:b0:33d:1ee9:3640 with SMTP id z13-20020a056000110d00b0033d1ee93640mr7029083wrw.17.1708363542287;
        Mon, 19 Feb 2024 09:25:42 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s8-20020adf9788000000b0033ae7d768b2sm10961517wrb.117.2024.02.19.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:25:41 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	lorenzo@kernel.org,
	alessandromarcolini99@gmail.com
Subject: [patch net-next 04/13] netlink: specs: allow sub-messages in genetlink-legacy
Date: Mon, 19 Feb 2024 18:25:20 +0100
Message-ID: <20240219172525.71406-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219172525.71406-1-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently sub-messages are only supported in netlink-raw template.
To be able to utilize them in devlink spec, allow them in
genetlink-legacy as well.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/genetlink-legacy.yaml   |  47 +++++++-
 Documentation/netlink/netlink-raw.yaml        |   6 +-
 .../netlink/genetlink-legacy.rst              | 101 ++++++++++++++++++
 .../userspace-api/netlink/netlink-raw.rst     | 101 ------------------
 4 files changed, 148 insertions(+), 107 deletions(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 938703088306..6cb50e2cc021 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -200,7 +200,8 @@ properties:
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
                         uint, sint, u8, u16, u32, u64, s32, s64,
-                        string, nest, array-nest, nest-type-value ]
+                        string, nest, array-nest, nest-type-value,
+                        sub-message ]
               doc:
                 description: Documentation of the attribute.
                 type: string
@@ -261,6 +262,15 @@ properties:
               struct:
                 description: Name of the struct type used for the attribute.
                 type: string
+              sub-message:
+                description: |
+                  Name of the sub-message definition to use for the attribute.
+                type: string
+              selector:
+                description: |
+                  Name of the attribute to use for dynamic selection of sub-message
+                  format specifier.
+                type: string
               # End genetlink-legacy
 
       # Make sure name-prefix does not appear in subsets (subsets inherit naming)
@@ -284,6 +294,41 @@ properties:
             items:
               required: [ type ]
 
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
+
   operations:
     description: Operations supported by the protocol.
     type: object
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index ac4e05415f2f..cc38b026c451 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -280,8 +280,6 @@ properties:
               struct:
                 description: Name of the struct type used for the attribute.
                 type: string
-              # End genetlink-legacy
-              # Start netlink-raw
               sub-message:
                 description: |
                   Name of the sub-message definition to use for the attribute.
@@ -291,7 +289,7 @@ properties:
                   Name of the attribute to use for dynamic selection of sub-message
                   format specifier.
                 type: string
-              # End netlink-raw
+              # End genetlink-legacy
 
       # Make sure name-prefix does not appear in subsets (subsets inherit naming)
       dependencies:
@@ -314,7 +312,6 @@ properties:
             items:
               required: [ type ]
 
-  # Start netlink-raw
   sub-messages:
     description: Definition of sub message attributes
     type: array
@@ -349,7 +346,6 @@ properties:
                   Name of the attribute space from which to resolve attributes
                   in the sub message.
                 type: string
-  # End netlink-raw
 
   operations:
     description: Operations supported by the protocol.
diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
index 70a77387f6c4..7126b650090e 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -280,3 +280,104 @@ At the spec level we can define a ``dumps`` property for the ``do``,
 perhaps with values of ``combine`` and ``multi-object`` depending
 on how the parsing should be implemented (parse into a single reply
 vs list of objects i.e. pretty much a dump).
+
+Sub-messages
+------------
+
+Several raw netlink families such as
+:doc:`rt_link<../../networking/netlink_spec/rt_link>` and
+:doc:`tc<../../networking/netlink_spec/tc>` use attribute nesting as an
+abstraction to carry module specific information.
+
+Conceptually it looks as follows::
+
+    [OUTER NEST OR MESSAGE LEVEL]
+      [GENERIC ATTR 1]
+      [GENERIC ATTR 2]
+      [GENERIC ATTR 3]
+      [GENERIC ATTR - wrapper]
+        [MODULE SPECIFIC ATTR 1]
+        [MODULE SPECIFIC ATTR 2]
+
+The ``GENERIC ATTRs`` at the outer level are defined in the core (or rt_link or
+core TC), while specific drivers, TC classifiers, qdiscs etc. can carry their
+own information wrapped in the ``GENERIC ATTR - wrapper``. Even though the
+example above shows attributes nesting inside the wrapper, the modules generally
+have full freedom to define the format of the nest. In practice the payload of
+the wrapper attr has very similar characteristics to a netlink message. It may
+contain a fixed header / structure, netlink attributes, or both. Because of
+those shared characteristics we refer to the payload of the wrapper attribute as
+a sub-message.
+
+A sub-message attribute uses the value of another attribute as a selector key to
+choose the right sub-message format. For example if the following attribute has
+already been decoded:
+
+.. code-block:: json
+
+  { "kind": "gre" }
+
+and we encounter the following attribute spec:
+
+.. code-block:: yaml
+
+  -
+    name: data
+    type: sub-message
+    sub-message: linkinfo-data-msg
+    selector: kind
+
+Then we look for a sub-message definition called ``linkinfo-data-msg`` and use
+the value of the ``kind`` attribute i.e. ``gre`` as the key to choose the
+correct format for the sub-message:
+
+.. code-block:: yaml
+
+  sub-messages:
+    name: linkinfo-data-msg
+    formats:
+      -
+        value: bridge
+        attribute-set: linkinfo-bridge-attrs
+      -
+        value: gre
+        attribute-set: linkinfo-gre-attrs
+      -
+        value: geneve
+        attribute-set: linkinfo-geneve-attrs
+
+This would decode the attribute value as a sub-message with the attribute-set
+called ``linkinfo-gre-attrs`` as the attribute space.
+
+A sub-message can have an optional ``fixed-header`` followed by zero or more
+attributes from an ``attribute-set``. For example the following
+``tc-options-msg`` sub-message defines message formats that use a mixture of
+``fixed-header``, ``attribute-set`` or both together:
+
+.. code-block:: yaml
+
+  sub-messages:
+    -
+      name: tc-options-msg
+      formats:
+        -
+          value: bfifo
+          fixed-header: tc-fifo-qopt
+        -
+          value: cake
+          attribute-set: tc-cake-attrs
+        -
+          value: netem
+          fixed-header: tc-netem-qopt
+          attribute-set: tc-netem-attrs
+
+Note that a selector attribute must appear in a netlink message before any
+sub-message attributes that depend on it.
+
+If an attribute such as ``kind`` is defined at more than one nest level, then a
+sub-message selector will be resolved using the value 'closest' to the selector.
+For example, if the same attribute name is defined in a nested ``attribute-set``
+alongside a sub-message selector and also in a top level ``attribute-set``, then
+the selector will be resolved using the value 'closest' to the selector. If the
+value is not present in the message at the same level as defined in the spec
+then this is an error.
diff --git a/Documentation/userspace-api/netlink/netlink-raw.rst b/Documentation/userspace-api/netlink/netlink-raw.rst
index 1990eea772d0..5fb8b7cd6558 100644
--- a/Documentation/userspace-api/netlink/netlink-raw.rst
+++ b/Documentation/userspace-api/netlink/netlink-raw.rst
@@ -58,107 +58,6 @@ group registration.
         name: rtnlgrp-mctp-ifaddr
         value: 34
 
-Sub-messages
-------------
-
-Several raw netlink families such as
-:doc:`rt_link<../../networking/netlink_spec/rt_link>` and
-:doc:`tc<../../networking/netlink_spec/tc>` use attribute nesting as an
-abstraction to carry module specific information.
-
-Conceptually it looks as follows::
-
-    [OUTER NEST OR MESSAGE LEVEL]
-      [GENERIC ATTR 1]
-      [GENERIC ATTR 2]
-      [GENERIC ATTR 3]
-      [GENERIC ATTR - wrapper]
-        [MODULE SPECIFIC ATTR 1]
-        [MODULE SPECIFIC ATTR 2]
-
-The ``GENERIC ATTRs`` at the outer level are defined in the core (or rt_link or
-core TC), while specific drivers, TC classifiers, qdiscs etc. can carry their
-own information wrapped in the ``GENERIC ATTR - wrapper``. Even though the
-example above shows attributes nesting inside the wrapper, the modules generally
-have full freedom to define the format of the nest. In practice the payload of
-the wrapper attr has very similar characteristics to a netlink message. It may
-contain a fixed header / structure, netlink attributes, or both. Because of
-those shared characteristics we refer to the payload of the wrapper attribute as
-a sub-message.
-
-A sub-message attribute uses the value of another attribute as a selector key to
-choose the right sub-message format. For example if the following attribute has
-already been decoded:
-
-.. code-block:: json
-
-  { "kind": "gre" }
-
-and we encounter the following attribute spec:
-
-.. code-block:: yaml
-
-  -
-    name: data
-    type: sub-message
-    sub-message: linkinfo-data-msg
-    selector: kind
-
-Then we look for a sub-message definition called ``linkinfo-data-msg`` and use
-the value of the ``kind`` attribute i.e. ``gre`` as the key to choose the
-correct format for the sub-message:
-
-.. code-block:: yaml
-
-  sub-messages:
-    name: linkinfo-data-msg
-    formats:
-      -
-        value: bridge
-        attribute-set: linkinfo-bridge-attrs
-      -
-        value: gre
-        attribute-set: linkinfo-gre-attrs
-      -
-        value: geneve
-        attribute-set: linkinfo-geneve-attrs
-
-This would decode the attribute value as a sub-message with the attribute-set
-called ``linkinfo-gre-attrs`` as the attribute space.
-
-A sub-message can have an optional ``fixed-header`` followed by zero or more
-attributes from an ``attribute-set``. For example the following
-``tc-options-msg`` sub-message defines message formats that use a mixture of
-``fixed-header``, ``attribute-set`` or both together:
-
-.. code-block:: yaml
-
-  sub-messages:
-    -
-      name: tc-options-msg
-      formats:
-        -
-          value: bfifo
-          fixed-header: tc-fifo-qopt
-        -
-          value: cake
-          attribute-set: tc-cake-attrs
-        -
-          value: netem
-          fixed-header: tc-netem-qopt
-          attribute-set: tc-netem-attrs
-
-Note that a selector attribute must appear in a netlink message before any
-sub-message attributes that depend on it.
-
-If an attribute such as ``kind`` is defined at more than one nest level, then a
-sub-message selector will be resolved using the value 'closest' to the selector.
-For example, if the same attribute name is defined in a nested ``attribute-set``
-alongside a sub-message selector and also in a top level ``attribute-set``, then
-the selector will be resolved using the value 'closest' to the selector. If the
-value is not present in the message at the same level as defined in the spec
-then this is an error.
-
 Nested struct definitions
 -------------------------
 
-- 
2.43.2


