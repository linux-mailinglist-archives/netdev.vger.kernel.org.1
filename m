Return-Path: <netdev+bounces-83193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4289152E
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9B5286696
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 08:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4B74AEDE;
	Fri, 29 Mar 2024 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOFiDmbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F563BF
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700940; cv=none; b=p5Tgf3YcOylfF13yzFhDFfdHOxAt0mU0X+FTJpJ+FIpZ6BR1ZS4p1diGHhigRnRRj/vEk/hub3PIu6ZyXbxoEWhHK8L4KXf8Z3D0eiCx9Hg1VMUDA3TyJg2vSaXIyfbmY8d1R6/JlqdbyrPhjcto/NOiHUYOeZ0z7tx26tt8cBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700940; c=relaxed/simple;
	bh=RQPxMvBYHIyv/Z2PhyXGdx336liJQSNR0+PnKub8rls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jauh1iG+8nrlZ5RBwOFoL+RN8EPD7BhvYu7jawBIvfKV8W1FV8hH45XaaMVU4WMiSd+FOvlcM6S+KAyL7k8s8AipwdJE3CZ/uxmc2fD+TX6FKgvnJ+OhDo5r1YhqIHK5aGVmsqUF4YT49nknUlytyv7VI7IxEPX6qRDYlLATtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOFiDmbz; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c3f7259bbcso3917b6e.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711700937; x=1712305737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcW0b9cmvjU+oQ3Sf479izV870s0snA3M4JZt9csdVI=;
        b=NOFiDmbz+RzwQmrV8gSt2kOnRb/83FCfCsgfThtbQ2kP5mh9dzlQuPVOreCJN/0Yc7
         oAz5OVMBuTnw/wMZDFCzkzHmtKKVu0EP0hrMMDw1k11l7eBO7pBvSjFIlPGlJS40BUWh
         YjB0UfKL/tCm1X/EAyKDtrYoQn1LCOKj9xGU0fXGA9lwTDlgeSVBm45/uMq7IXIQC7+Q
         OMD3y7MWS9652iIwE9H5l4ed3NuVac7zfxeuTJ8zoJ1FPw2rrB1PIdE6r9O/WzDjvHPq
         kFf3HzekmUmABZYh5tqfn2Fz9nZJfZ114sKGumtzyLVs1lWsDWIN+HzfWnxYVsdma/kC
         +r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711700937; x=1712305737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcW0b9cmvjU+oQ3Sf479izV870s0snA3M4JZt9csdVI=;
        b=UoE5TUE2KceFMPzpRh4kuWb3yzGZfRSOqxrN0VPWKYBq20KAkTRHq8EjV8WiL204m0
         n5eVRaAqnMIOxyxdIs1dbs+fI6Qse1TIw/5GILGIBDC7dT5+sNB5I8nL6Bz+kkHGVSFC
         2gJjs/KKCkhl1Y6MAPWhBqHo2iYqyUFxzw4cqKOTns6GMM8BaB78s3mxhzU3FHAFzmjx
         95tukbzIZaBuuvD394+XiR4tSxw/+1pM9pWcF2UsFoOWDVqlW95dukbpnKTAP0ScP9Xw
         wa8HpOD8goPKyYo+D5lPQUmvK1fZb4i5Xwu2O8cSv7NO7T8iN6gs9FXSqi9u2rnEayB7
         JgNA==
X-Gm-Message-State: AOJu0YwDrw8agvuGsSzv6vt9/V2kXmz0ixrgGseZfhekgZ+BGz6jSSTp
	OrGC4bSQXVFzdXpdFSRyKD8g82ml0PimoMS+LiBOY4EXKk0fmVI23OrInqc3ORnBykUW
X-Google-Smtp-Source: AGHT+IH5PG7QzLbJvZbySzi8WotLj6SX+FIOp0akpcf9MSUW0J2QIZlp7/cII6D6tThPZEpF6h9nQQ==
X-Received: by 2002:a05:6808:1649:b0:3c3:dbf0:174a with SMTP id az9-20020a056808164900b003c3dbf0174amr1711462oib.10.1711700937026;
        Fri, 29 Mar 2024 01:28:57 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b12-20020a056a000a8c00b006e5a915a9e7sm2656020pfl.10.2024.03.29.01.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 01:28:56 -0700 (PDT)
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
Subject: [PATCHv3 net-next 1/4] Documentation: netlink: add a YAML spec for team
Date: Fri, 29 Mar 2024 16:28:44 +0800
Message-ID: <20240329082847.1902685-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329082847.1902685-1-liuhangbin@gmail.com>
References: <20240329082847.1902685-1-liuhangbin@gmail.com>
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
 Documentation/netlink/specs/team.yaml | 206 ++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 2 files changed, 207 insertions(+)
 create mode 100644 Documentation/netlink/specs/team.yaml

diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
new file mode 100644
index 000000000000..907f54c1f2e3
--- /dev/null
+++ b/Documentation/netlink/specs/team.yaml
@@ -0,0 +1,206 @@
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
+            - team-ifindex
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
index 6a233e1a3cf2..909c2c531d8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21665,6 +21665,7 @@ TEAM DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
 S:	Supported
+F:	Documentation/netlink/specs/team.yaml
 F:	drivers/net/team/
 F:	include/linux/if_team.h
 F:	include/uapi/linux/if_team.h
-- 
2.43.0


