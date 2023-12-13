Return-Path: <netdev+bounces-57091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 761F18121D7
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215991F21673
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD118183F;
	Wed, 13 Dec 2023 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdAQS0cw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F719AF;
	Wed, 13 Dec 2023 14:42:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-336420a244dso733848f8f.0;
        Wed, 13 Dec 2023 14:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507322; x=1703112122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ippq1dNaZAqHOjJJsClArBZB/4VVzURJxqB5Fea8pY0=;
        b=MdAQS0cwkNkV8h6mOzZ/yVtpn9ytaTfGM6edaY774pbo+7fVQOMPknXoBH6lsf0fGj
         DRlepBR7b7mx/p+usi2VXHNFeTpMlQ8Tq1F5slRVYwIsgucdgmEcTB9E2aWtJPtTlxLE
         MnYKvZAdUI5R9QpbKxBAjLtnx0k8Vue4Q8DgbcJclvvDPqJDMzPnXc1E7g/sqSqU0CpH
         JbV3uPD6SIaflCnXyShg58jgjNkpQ4tqezTl2wSVMJUc+UqDKUBiNFY4IV8OEW4j5vCO
         Tukl57U9YTGtXaN85ympNpI3vGy3uhqUnO9p2gWn02J0q3prrtjFvIhC7IFxulj+jt9i
         MGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507322; x=1703112122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ippq1dNaZAqHOjJJsClArBZB/4VVzURJxqB5Fea8pY0=;
        b=KwnBz1etpXGmJHCXaTA+wSOWirHZpkpEtKE2QYX9HaRnRDo6t3qxLRSuifHNBjgLdf
         pd7DX1NGc5LYGCxXxKUrtNKsBmRLiUc2hV0Qwj1mHInzJmj++WpvM7SzgecM017hbR16
         BEfgz6aVZ68Iu6elNcNFkssJccIWQkgmd7gtkztRWH3J94uF051kClzKuVnOjEnLkcrD
         wyLqSRuwFLRHUPXPr988dWmMze+CVV9l3gjH3vjbw3P2FpH2KdDJNnWFM6os3kvV8/k2
         ccbPIBFh9/dm/xdr23j9n3j/U+ZvXz8TUxXxhfPNNTanX811mY8ETZANSrNmgiVN6CKA
         Rvaw==
X-Gm-Message-State: AOJu0YwZTku/U7cdBauhBsRlJW0nMY85J7+32O2fkGSjlLuqH/9gp3XO
	kUwMyjFazip+F/vrdn5Dez6aezcDWC05Vw==
X-Google-Smtp-Source: AGHT+IGTTEUY/pykFmRDd/FBn8yYOcFxnI/k75CyZMa1Gh4WG1XUfZEJwecLfwxe+Gb+k5YdcjU8cw==
X-Received: by 2002:adf:db4e:0:b0:336:4476:ee57 with SMTP id f14-20020adfdb4e000000b003364476ee57mr268749wrj.112.1702507322392;
        Wed, 13 Dec 2023 14:42:02 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:01 -0800 (PST)
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
Subject: [PATCH net-next v4 03/13] doc/netlink: Document the sub-message format for netlink-raw
Date: Wed, 13 Dec 2023 22:41:36 +0000
Message-ID: <20231213224146.94560-4-donald.hunter@gmail.com>
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

Document the spec format used by netlink-raw families like rt and tc.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


