Return-Path: <netdev+bounces-82414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CAF88DAEA
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C6DB23980
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D576D47F7E;
	Wed, 27 Mar 2024 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEhb/XlI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB974779F
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533817; cv=none; b=FrHJlIDbvtVNJjqs3+2qJ+ah7iHUHidk42Z5fj6lH4JFJ9L8Sti6sNkZgioYRbBOPQHQYzbIBBuMQI623GTDFLJJFmDoZTyQvvzedxPMoL3VP66nZX6eEy0z/ppQpWnqMGh5L52Chva6yfybyt1HjIIvoQXL0JuTUF52vY7RtmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533817; c=relaxed/simple;
	bh=URl0hrM5596f9MMLyKll+C1Apb3Ay8K5RlvkitvTomI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYFqKH2eSRPpb9KROPK7xrXKgMngIw82JpLXUxjCLsm226eg6KdWyIVsq1uKdZOnV8b8VArFWL58uPrIyFeby5ObcCZxL3weWAePPAUXY+XvarSiMjSI+BeAWRJOID3wdmISWMbnU0Sw2T6OcMN0PKJu3MlE+SP0vxp7j8jtgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEhb/XlI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b3dc3564so4630388b3a.2
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711533814; x=1712138614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RQRtsXBjluXmDUSMq2ixY1pG7m0lBY5i7940bdVFtU=;
        b=GEhb/XlIlFmWOEP8H48TyLze8HkeoRo5WLLKJ0m/m10NAMn8MnL+Uf6qg3Cszjx4Ux
         +rB4oXPw8/ujpayyU8ODiLNg5ji2LVngRNstAR3H0wCQUYD0uTWt5vb3Axzp5d6awJ6p
         0jWbJC/OmXS095TVL3eLCjvldXvWKpNCO33V0ueIYMY+xqtz4k1QFZ3OCAYsF2QGPGwK
         gqdFMzKtfLsGY7QPT+6WFq2HHLBNjB/hcTGoTNCBu4Zhau1kS3wLj09/bW6FFpp6i1lR
         wLUzXNbhNRPIgBIFO7uRMBa7ZSmmxOHe6btpntgLk1VhajucaAQd1FzBXDZ6Q8xhFxgn
         F2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711533814; x=1712138614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RQRtsXBjluXmDUSMq2ixY1pG7m0lBY5i7940bdVFtU=;
        b=QGVemOeZg2wmnBgpDxMg2yGXyKWo0jmCPD+GtnErin+RcFqF1yPkB5VNbDK0/tP2o+
         OsqlSYxd3BZ2Xt8YNBYhsxMoHKfQzKt7KCMQnWNGqGT5XKLc8m34EzZOhV2NeRIjEbwA
         oN4AtURiMZ8UKncZaCQ/3hfwfRBa1gd3afogZBNi0Oe6TZbMtqkb3yxOUSSmii0vm/7j
         HnZsC8tHIkPRp4NAaxeP1uuo6BWIKJGUo1vYcmh6hlEEY1yilt5PXHgw9iXVV7W2xCkf
         5v8AZyQm34XIY8cGSQj8ArInbfC0wwB73r+FfZpwQKT2edkkiTDO8Fen081ZkWsIG8cf
         JB8Q==
X-Gm-Message-State: AOJu0Yz4BKB5K+MQZEDurszY0iBdJ5mf5I8UCMN7KBtPgVIvCa/G0rHF
	5zzFhCG91p0B3Sd1JatgZ73PoO60ymb8zDYs+cM8Q/kwsUf0I77xgwbHpGKiFHDymfhs
X-Google-Smtp-Source: AGHT+IHzL9Qnm7R5Qskk8XDyMhhpI4LaGsUsUBDS2KPDRnSUL2XThh9XeoxKYqRSWx8o5zJ8fvFenA==
X-Received: by 2002:a05:6a21:3a45:b0:1a3:5d2a:4001 with SMTP id zu5-20020a056a213a4500b001a35d2a4001mr4042557pzb.44.1711533813531;
        Wed, 27 Mar 2024 03:03:33 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b006e6b2ba1577sm7478913pfn.138.2024.03.27.03.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 03:03:32 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/4] Documentation: netlink: add a YAML spec for team
Date: Wed, 27 Mar 2024 18:03:15 +0800
Message-ID: <20240327100318.1085067-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327100318.1085067-1-liuhangbin@gmail.com>
References: <20240327100318.1085067-1-liuhangbin@gmail.com>
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
Draft -> v1: remove dump from team options.
---
 Documentation/netlink/specs/team.yaml | 208 ++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 2 files changed, 209 insertions(+)
 create mode 100644 Documentation/netlink/specs/team.yaml

diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
new file mode 100644
index 000000000000..3ec1e61267eb
--- /dev/null
+++ b/Documentation/netlink/specs/team.yaml
@@ -0,0 +1,208 @@
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
+          max-len: string-max-len
+          unterminated-ok: true
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
+        doc: for array options
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
+      dont-validate: [ strict ]
+
+      do:
+        # Actually it only reply the team netlink family
+        reply:
+          attributes:
+            - unspec
+
+    -
+      name: options-set
+      doc: Set team options
+      attribute-set: team
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+
+      do:
+        request: &option_attrs
+          attributes:
+            - team-ifindex
+            - list-option
+            - item-option
+            - attr-option
+        reply: *option_attrs
+
+    -
+      name: options-get
+      doc: Get team options info
+      attribute-set: team
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - team-ifindex
+        reply: *option_attrs
+
+    -
+      name: port-list-get
+      doc: Get team ports info
+      attribute-set: team
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - team-ifindex
+        reply: &port_attrs
+          attributes:
+            - team-ifindex
+            - list-port
+            - item-port
+            - attr-port
diff --git a/MAINTAINERS b/MAINTAINERS
index f736af98d7b5..7a4b55a8fe7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21636,6 +21636,7 @@ TEAM DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
 S:	Supported
+F:	Documentation/netlink/specs/team.yaml
 F:	drivers/net/team/
 F:	include/linux/if_team.h
 F:	include/uapi/linux/if_team.h
-- 
2.43.0


