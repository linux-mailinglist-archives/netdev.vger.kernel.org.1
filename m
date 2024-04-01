Return-Path: <netdev+bounces-83701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579C18937B0
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5EE1C20AD3
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB84A1B;
	Mon,  1 Apr 2024 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbp4dqPb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF44A34
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711941024; cv=none; b=S/AMNxU0vVpsYIw42OsFSRUqzXrtFdeDEGbcnSP3Zll36B+ws3Vw9J0m6vqO1F8bZFZb52yb94eC2I+XmnCzLVdkWjwdDfZTa4IZh7KE64ZpiB/th1+PEy8MVaR9cgAMY3SWE2JxpCbhIeICigN8OplalqBzZRIy6auZesxjndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711941024; c=relaxed/simple;
	bh=YzFy0WxSKBWnCtCuqwHinhbRaBurdvJJ+1ZApk8hcaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1o7JyBVvqpLCQ+7iU140fpsyHQGNbZL7TCH4pvrejlR8pLQhFAuJKi9PWyzh9EckxahTmPiWZD9qkx9Vj/zztK/BmGxmdZjUNKvuMBx2YUqGPwe7yYBrJ3+8vMTBthvdOti4Ed1CGdPyNN+pJidTJ1W0VeEPvBHru/f0BZLQjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbp4dqPb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0edd0340fso32694955ad.2
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 20:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711941022; x=1712545822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCSmwUzUoPdqW7SzyEGrV4qg5YuSJ5jQ2xH4BhW4fu8=;
        b=Fbp4dqPbjte55aam1WH4YkuyedqDFieWHpp8T3S3lPEA33mdUfmND/Be4u3od3y2Ys
         PgswMZlOz296re8FtlV0zZin2jDgiba/ePXwW8L+jdXtxlqyGdD2PJM7I8IrgyJxLGOI
         GQA8xWXEgKbNyIFpdwsjsRi7idBdcjrfLzDaG0Yu7Goxwd30JPP4sx/mqxHSjkvFw2D9
         CeGk1W8DZ8zOokgjmKArIozCcV7IoAafJc9RS1CoaNxI6z6ykf4cWm8kyn1xSHUEv7UC
         TRnmNcXfDr/VmnKhQstEt4h6Sdq/CJBImHn9sL10zl0HnbBqAcWGwcrGBGSytouJHGIF
         HY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711941022; x=1712545822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCSmwUzUoPdqW7SzyEGrV4qg5YuSJ5jQ2xH4BhW4fu8=;
        b=QxQmn02iLQ7gGpFOHMStjmjPdot3zhjeINdPxEnA+IEsu4vpkHLn/4Z0Ec6f02+wdo
         WGJ//2vi/XP3igCU9GzNC/rSEJqfIABd/wAue2kkKIR2q4nfVqiibvQK0iYqfo7l6qUD
         e5/Fa+69TDqf/zfo/W4yFYl1UrlXzk62dGpCAO/VjN1Z0RRNHn2Zmz85yrm8w7rhj87i
         yJWiKbQuccptkp1TsCDaqDObyfnJSVqt7z3v7RyWTBHjH/SoQJhAbWKKqOuGQLzK/J19
         VazewuaS33vmcDkQYUd/dQt6vC1GEi0qgwCdWc+VKL4yvkZmBIlKaHQpKJEBF/9MPktR
         46bw==
X-Gm-Message-State: AOJu0YwKiiCRijFSO8E/kDp1UiqxwZWdanThgASGGD5+gaUmpmbO4xD4
	YMPveUXx17g9YFVc0egfQ3DYHmQMExy5XNsebXwLe7d5MmCdms4Y93bBDVJ93RYllw==
X-Google-Smtp-Source: AGHT+IFjDd2aKkuv6JXiTBCti0S3Lwp/Z0kocwV7ZqUA6UT/crrPXh6+d8xy7ekSNrIuYoOACY/z9g==
X-Received: by 2002:a17:903:184:b0:1dd:7df8:9ed7 with SMTP id z4-20020a170903018400b001dd7df89ed7mr12005448plg.15.1711941021671;
        Sun, 31 Mar 2024 20:10:21 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001e00ae60396sm7807464plk.91.2024.03.31.20.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 20:10:21 -0700 (PDT)
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
Subject: [PATCHv4 net-next 1/4] Documentation: netlink: add a YAML spec for team
Date: Mon,  1 Apr 2024 11:10:01 +0800
Message-ID: <20240401031004.1159713-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401031004.1159713-1-liuhangbin@gmail.com>
References: <20240401031004.1159713-1-liuhangbin@gmail.com>
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
 Documentation/netlink/specs/team.yaml | 204 ++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 2 files changed, 205 insertions(+)
 create mode 100644 Documentation/netlink/specs/team.yaml

diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
new file mode 100644
index 000000000000..c13529e011c9
--- /dev/null
+++ b/Documentation/netlink/specs/team.yaml
@@ -0,0 +1,204 @@
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


