Return-Path: <netdev+bounces-56773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC21810CB2
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4744B20C9C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A7A1EB43;
	Wed, 13 Dec 2023 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3SlKFaH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31334F3
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:45:14 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0b2752dc6so58832185ad.3
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702457113; x=1703061913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtT/ElbQqdJwX418PMIMGHlJ/bgVex4PuuJXGBHr+A8=;
        b=a3SlKFaHC6M0eGdCs3tc8FhrxrlwYIE7DvL8UzBwN1y2cSAI6zs77OVUkJlsphlXF8
         +vzVnbWspZzwY8bnbZQ+4vpxzpzlXyNc1QEsVsYLCQ7ljH296TmttiKtEp3dKbOt/JHB
         poK3v+rfl8TnvfUnkC2kkGt8yadudQWFGC1qZ7wmKxxeyZUQdQfAWxCmQUvlxFpu71kV
         PGFnd5dT8uw3TvdmUYMBEM04Foez8CoDcyvCy4L+2aB2eXsgsPPiI8PJ7HClXNdCgPx+
         +JkLOVB6Nglu3/l3kmvzkVwCHrgF0uuk3izNUEOb9kWbP4jyKXRiy2tU0vmt7IQK4A/8
         KAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457113; x=1703061913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtT/ElbQqdJwX418PMIMGHlJ/bgVex4PuuJXGBHr+A8=;
        b=ufFKPMDiR0TLIR3MtHwupHL1FdF8/Xf1DJXXm8/85BX91ng7Ae/xhwy7xfpf8l+qgn
         WX2w6bhKxEV/ahcc4lSNuVbwvsHe3p5xv9fuFogweU/YRKLlHBoxTfSd+TkewX11xmTU
         U8/KjMqdQKWb+Uf0zBHg9r0u4cDPWLoYPPkPufm2Wo4b+rwXot1OHvdPO0YYwewzIJN7
         DipFqb8uGo5RGPkUjGQ8A96dws15Kudte4OZMYDLuRy7fiiOR6eznT7U8JFw6cF09EyR
         tG1vwbwqQLjTRDISNQzsQ6Bxdj7yRMdi/ioOR2sKEbD497gN9Oyuznnw6ZUQaquJ7QuS
         oN6g==
X-Gm-Message-State: AOJu0YyAK6S1Qn2lf+idoBBQ4vz6RLJYl6+/FdmdHp2DCOHzb1eOPM8U
	yhK+Bwfwitl1I0lB9SFTywc+EPjYPcVQ6v9TWh0=
X-Google-Smtp-Source: AGHT+IHKrzsBaA7lIeLCAVJ4Cuh8VMQ9vvphlogR263YMnrGwpYP3EgpMRgBj2ZhxAddaNNgYcMkuw==
X-Received: by 2002:a17:902:f546:b0:1d0:c37a:9d05 with SMTP id h6-20020a170902f54600b001d0c37a9d05mr10013464plf.75.1702457112893;
        Wed, 13 Dec 2023 00:45:12 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f54200b001cfc67d46efsm9897824plf.191.2023.12.13.00.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 00:45:12 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [Draft PATCH net-next 1/3] Documentation: netlink: add a YAML spec for team
Date: Wed, 13 Dec 2023 16:45:00 +0800
Message-ID: <20231213084502.4042718-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213084502.4042718-1-liuhangbin@gmail.com>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a YAML specification for team.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/specs/team.yaml | 205 ++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 2 files changed, 206 insertions(+)
 create mode 100644 Documentation/netlink/specs/team.yaml

diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
new file mode 100644
index 000000000000..5647068bf521
--- /dev/null
+++ b/Documentation/netlink/specs/team.yaml
@@ -0,0 +1,205 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: team
+
+protocol: genetlink-legacy
+
+doc: |
+  Network team device driver.
+
+c-family-name: team-genl-name
+c-version-name: team-genl-version
+kernel-policy: global
+uapi-header: linux/if_team.h
+
+definitions:
+  -
+    name: string-max-len
+    type: const
+    value: 32
+  -
+    name: genl-change-event-mc-grp-name
+    type: const
+    value: change_event
+
+attribute-sets:
+  -
+    name: team
+    doc:
+      The team nested layout of get/set msg looks like
+          [TEAM_ATTR_LIST_OPTION]
+              [TEAM_ATTR_ITEM_OPTION]
+                  [TEAM_ATTR_OPTION_*], ...
+              [TEAM_ATTR_ITEM_OPTION]
+                  [TEAM_ATTR_OPTION_*], ...
+              ...
+          [TEAM_ATTR_LIST_PORT]
+              [TEAM_ATTR_ITEM_PORT]
+                  [TEAM_ATTR_PORT_*], ...
+              [TEAM_ATTR_ITEM_PORT]
+                  [TEAM_ATTR_PORT_*], ...
+              ...
+    name-prefix: team-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: team-ifindex
+        type: u32
+      -
+        name: list-option
+        type: nest
+        nested-attributes: item-option
+      -
+        name: list-port
+        type: nest
+        nested-attributes: item-port
+  -
+    name: item-option
+    name-prefix: team-attr-item-
+    attr-cnt-name: __team-attr-item-option-max
+    attr-max-name: team-attr-item-option-max
+    attributes:
+      -
+        name: option-unspec
+        type: unused
+        value: 0
+      -
+        name: option
+        type: nest
+        nested-attributes: attr-option
+  -
+    name: attr-option
+    name-prefix: team-attr-option-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: name
+        type: string
+        checks:
+          # no unterminated-ok defination?
+          # do we have to hard code this?
+          max-len: 32
+      -
+        name: changed
+        type: flag
+      -
+        name: type
+        type: u8
+      -
+        name: data
+        type: binary
+      -
+        name: removed
+        type: flag
+      -
+        name: port-ifindex
+        type: u32
+        doc: for per-port options
+      -
+        name: array-index
+        type: u32
+        doc: for for array options
+  -
+    name: item-port
+    name-prefix: team-attr-item-
+    attr-cnt-name: __team-attr-item-port-max
+    attr-max-name: team-attr-item-port-max
+    attributes:
+      -
+        name: port-unspec
+        type: unused
+        value: 0
+      -
+        name: port
+        type: nest
+        nested-attributes: attr-port
+  -
+    name: attr-port
+    name-prefix: team-attr-port-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: ifindex
+        type: u32
+      -
+        name: changed
+        type: flag
+      -
+        name: linkup
+        type: flag
+      -
+        name: speed
+        type: u32
+      -
+        name: duplex
+        type: u8
+      -
+        name: removed
+        type: flag
+
+operations:
+  list:
+    -
+      name: noop
+      doc: No operation
+      value: 0
+      attribute-set: team
+      dont-validate: [ strict, dump ]
+
+      do:
+        # Actually it only reply the team netlink family
+        reply:
+          attributes:
+            - team-ifindex
+
+    -
+      name: options-set
+      doc: Set team options
+      attribute-set: team
+      dont-validate: [ strict, dump ]
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - team-ifindex
+            - list-option
+
+    -
+      name: options-get
+      doc: Get team options info
+      attribute-set: team
+      dont-validate: [ strict, dump ]
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - team-ifindex
+        reply:
+          attributes:
+            - list-option
+
+    -
+      name: port-list-get
+      doc: Get team ports info
+      attribute-set: team
+      dont-validate: [ strict, dump ]
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - team-ifindex
+        reply:
+          attributes:
+            - list-port
diff --git a/MAINTAINERS b/MAINTAINERS
index 7fb66210069b..b64e449f47f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21301,6 +21301,7 @@ F:	drivers/net/team/
 F:	include/linux/if_team.h
 F:	include/uapi/linux/if_team.h
 F:	tools/testing/selftests/drivers/net/team/
+F:	Documentation/netlink/specs/team.yaml
 
 TECHNICAL ADVISORY BOARD PROCESS DOCS
 M:	"Theodore Ts'o" <tytso@mit.edu>
-- 
2.43.0


