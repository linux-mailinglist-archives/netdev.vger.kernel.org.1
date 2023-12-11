Return-Path: <netdev+bounces-55989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6A280D252
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76682818FA
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C814D5A6;
	Mon, 11 Dec 2023 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpyTn1sx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7291591;
	Mon, 11 Dec 2023 08:41:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c32df9174so38681555e9.3;
        Mon, 11 Dec 2023 08:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312863; x=1702917663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ej28qEYqLx0vL4chsMYb5U5igG+9wrUv40h6XE2I4o=;
        b=HpyTn1sx4gQ+pZhxEsynYRCa9wuX1zanhHopXM0aeUP82ckiQYVzjOKpM2qxMHWXJL
         Hni8W7VbeG7ZIvWDRHrEZ6D6r/g6szgdDL779rJcelxsS2adKrFPP3kzk1lHEk0nZo6N
         NeFCuzYpxjASFj5WWx+g9DT9PpsUSEXsBFF6cuG20qn2455JVsd/Fyak8layBLX3XMWL
         37Lfa1LkE7HCdJVW4eHQJxwvMKkaYLr8XJqHW+wasLFg0x8yDX1KBv2o84ggvy3BCYsP
         ObBlcjsxeALeY2ap1f8nQl0hl4i73ex+i12/p3voBcBVPw3VK8KptxP5w8/4WGJPe+DK
         KNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312863; x=1702917663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ej28qEYqLx0vL4chsMYb5U5igG+9wrUv40h6XE2I4o=;
        b=pTgsWwg+6VmuO8TTF2niz531QSGa198HQQahD6pTBPBLybMftG+gaUVLO4SaBHEAp6
         eq4C+hwoHwpd4CXZ9ONGoeuhQ+1hPwhM0CK2gqByBiy2vi10jdNAPjG3MGQ7ucfUpfHS
         wqMz2gT0CJhQ/JFOHNsZaVqFoagdhxbniCPah5K0Ihej6yHlWrkBnFxQapExJubk6Qfr
         p960uxfNNZIhVIdZT+9i3j7gZYgxRIiloe3v63p6Z5zT2ECLu+rXrdRVzy8Z7jwcC+zo
         GxVEo6Q8MosAVcGUnKBh+FY5HsgI3ggLhOVoY8H7xGtglaefx0rbGwMwdrfOYK4qd85p
         xm5Q==
X-Gm-Message-State: AOJu0YwkZT6fwlqJwp9fngi4Ri6CRKfzGtBBRnRZ+OFrLVZR3VXh9rub
	C1Z/A8dj3A3Y57RDra1ts6GDnyCV2MmdoA==
X-Google-Smtp-Source: AGHT+IHilBKdL9kB+2kcle3fhulQ57VJGgXoAsPP7OAJWhYkvrPttBD9qGeirCnjaZkwpXRsh7Gqpg==
X-Received: by 2002:a05:600c:1d12:b0:40c:295f:119c with SMTP id l18-20020a05600c1d1200b0040c295f119cmr1870315wms.31.1702312863175;
        Mon, 11 Dec 2023 08:41:03 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm7418679wmq.26.2023.12.11.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:41:02 -0800 (PST)
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
Subject: [PATCH net-next v2 06/11] doc/netlink: Document the sub-message format for netlink-raw
Date: Mon, 11 Dec 2023 16:40:34 +0000
Message-ID: <20231211164039.83034-7-donald.hunter@gmail.com>
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

Document the spec format used by netlink-raw families like rt and tc.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 .../userspace-api/netlink/netlink-raw.rst     | 75 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/netlink/netlink-raw.rst b/Documentation/userspace-api/netlink/netlink-raw.rst
index f07fb9b9c101..e1d3e5ecfc6a 100644
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
@@ -56,3 +57,75 @@ group registration.
       -
         name: rtnlgrp-mctp-ifaddr
         value: 34
+
+Sub-messages
+------------
+
+Several raw netlink families such as rt_link and tc have type-specific
+sub-messages. These sub-messages can appear as an attribute in a top-level or a
+nested attribute space.
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
+Then we look for a sub-message definition called 'linkinfo-data-msg' and use the
+value of the 'kind' attribute i.e. 'gre' as the key to choose the correct format
+for the sub-message:
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
+called 'linkinfo-gre-attrs' as the attribute space.
+
+A sub-message can have an optional 'fixed-header' followed by zero or more
+attributes from an attribute-set. For example the following 'tc-options-msg'
+sub-message defines message formats that use a mixture of fixed-header,
+attribute-set or both together:
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


