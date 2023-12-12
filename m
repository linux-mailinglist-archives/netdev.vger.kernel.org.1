Return-Path: <netdev+bounces-56619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6680FA06
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AF71F211D1
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC10E81E53;
	Tue, 12 Dec 2023 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZOnuBhm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC38B3;
	Tue, 12 Dec 2023 14:16:32 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3333131e08dso6737118f8f.2;
        Tue, 12 Dec 2023 14:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419390; x=1703024190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX/w+MX6yV0YupODP87XNrIOtRJppEOEjR5WnrR3vrY=;
        b=YZOnuBhmD4OVREqceh+8y+8HRpRDG1l3msKIjG1gNaVMSaHV7EEo1ccdkVgBfws1fl
         P7Kjat2809uHaKFNLA1jvguGuC/yfQTFXS7jDnSzdxDJ809wEcoDwlp9LW2x1hnW3qxP
         jl7IeQ2TaewLONv4UMgCfVtyisg/JBfHQXouGmDcSMCzmZrxGqGWV6Er8O7sBNodZTv/
         oakVNH9RLPMBwb6qB1WGVcos8B/3JUFQ6N3D7gTTOuoVUa3comowQR/hzY2QJCl4ohSI
         S/tFBrBsotzOmmAHvEQ4pCYwoPq+rfHPxY/9EyPPY9RyYu1ZKWuhYg51Pz01ryDV1Biz
         +yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419390; x=1703024190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XX/w+MX6yV0YupODP87XNrIOtRJppEOEjR5WnrR3vrY=;
        b=LUKrlndBwHpZfcNT6bvfR8gH6znPcrCrNEWIcOCf68Tt/mtRNVMT7XIqftf8ozzV4z
         5R6aKRBhe68FyYknhSh2a/8xQ1Z446OPrJOQa7DuW2MntnsuTjp3RFaG0K6zEVwaRyS2
         KTuhSdDjJ1u4tSJIAo6OqNQSfXj/cGE0bm2fS/HDtSF4c8AAlwA6+7SSlfoSqTiICpns
         S2AkYvhMFa6MG273BynOaBUJwOAyiOcuOB/EOM9EF6E3JUFnBJxe3L8BmS7ZeSj51glX
         XJDV5Bodh1IsGETPvRBHngZiq0hnHlX8RMdUOCZI6AypVv1l17y3I5DYxWp30+KjzGR7
         ytGw==
X-Gm-Message-State: AOJu0YxZJmHTRzlbs8qSdEqpPd002qabDGHuEWOlp7F8ZJZeyVDhPBki
	bx8T8h4q94QxgwhcV0IA6k+7U578oXQwpQ==
X-Google-Smtp-Source: AGHT+IGrhzRiGZQye/32ahaGEqp1z/YyLNRnQvCPMVgroG9LWF3sgBFtKlfABTNZJxQCcTF0diMxrQ==
X-Received: by 2002:a5d:670b:0:b0:333:1f99:45ec with SMTP id o11-20020a5d670b000000b003331f9945ecmr3686243wru.13.1702419390259;
        Tue, 12 Dec 2023 14:16:30 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm11680482wrt.22.2023.12.12.14.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:29 -0800 (PST)
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
Subject: [PATCH net-next v3 03/13] doc/netlink: Document the sub-message format for netlink-raw
Date: Tue, 12 Dec 2023 22:15:42 +0000
Message-ID: <20231212221552.3622-4-donald.hunter@gmail.com>
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

Document the spec format used by netlink-raw families like rt and tc.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 .../userspace-api/netlink/netlink-raw.rst     | 96 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/netlink/netlink-raw.rst b/Documentation/userspace-api/netlink/netlink-raw.rst
index f07fb9b9c101..1e14f5f22b8e 100644
--- a/Documentation/userspace-api/netlink/netlink-raw.rst
+++ b/Documentation/userspace-api/netlink/netlink-raw.rst
@@ -14,7 +14,8 @@ Specification
 The netlink-raw schema extends the :doc:`genetlink-legacy <genetlink-legacy>`
 schema with properties that are needed to specify the protocol numbers and
 multicast IDs used by raw netlink families. See :ref:`classic_netlink` for more
-information.
+information. The raw netlink families also make use of type-specific
+sub-messages.
 
 Globals
 -------
@@ -56,3 +57,96 @@ group registration.
       -
         name: rtnlgrp-mctp-ifaddr
         value: 34
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
-- 
2.42.0


