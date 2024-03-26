Return-Path: <netdev+bounces-81891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0767188B886
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AE62E3444
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560B8129A68;
	Tue, 26 Mar 2024 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzeP6xu1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3619128381
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423826; cv=none; b=GF1QYq6wZANxhAjaGtgCy/suVx31fLZBzkdnZ+WRbEWiq8CTodlPjFxsbIIRCW2cXfMl+X62RkvrQMF0ZPO3grGzvKsi9T7x7kd+3lTl//4TDgqfZdkN5wU9b2Gmqn/YR3IxtSHpk3rb8HTiBGz1dQpv+kLCrQMa/iYZd5G4Mjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423826; c=relaxed/simple;
	bh=3W0o9Col6X9eZ6NtnnoWQAWiLOqq1gzSw1qjiocg1UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1y4l6ESMBKBvhgcUflnYP3UyxJ7VMmIhAnR5JLGcUTa3lGcHrFHgZ2s9ix3plCvWCKMUpJyXwRI5HGov4GkWEJz9I40Om5zin+pjtcEhHJ9eCROVoQNEf+BQLVSs1LyADglBUXFUG1Lo0xwXF+AteI3W0D5F6rCxw0R4GoluNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzeP6xu1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0f2798cd8so813925ad.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711423823; x=1712028623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mszzsWjzS6UDjaLacTsFs6aCcORO6C2G6boDJutjqY=;
        b=AzeP6xu1uKnUeYZ+ol/f8diyXYRhSVHJjrAmyCAkuvOc+1ZHqaQgiGoYDszkn2kFPd
         xfjcjvgCmk7fgcHXkoRZy3YY5z7V4vhKwj8Su3KXRbWgPmVor36HVI2Jvdhpai50ESOX
         SzIh2a0b6EP77tdF6Df9Rtrzmw/Gyds0VNN2ZLGG4VaBRsbh9wGbRvaB0uK+ftZK/dgI
         /gXS+UGYlj6Lv1gSG8okZdAPCZbfcxWaeiGDFZfSfot+IhkMjcd01NOzwg8a7AgMkD6i
         C8c2BEhwzkNVKPLCGaFMmeByZebqzLWzORspgpTDt3bgrH3xLwTv8yqX5nr9Cw93QF8o
         iTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711423823; x=1712028623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mszzsWjzS6UDjaLacTsFs6aCcORO6C2G6boDJutjqY=;
        b=WN2bPEi3QxSzxr/STJR9uuUTJM5iyqdL+z4570Td54j83Lg0zoWzAXfbdtDyJZeByk
         cFd3jpgBYRxZSVqej5pTkfgoInnQULCgawqRR56ekSXGoY+Fy/8OZZV8ae1guH+sGgsH
         hyMeEIIyMNVSW2eNIGs2i22e8UvFLv8AtceBsF+6lvo4YLjsc/xwwhkQdrZTG1wGZh8h
         kr0iWqLIYoXik4+5O/wL+BB04+JJ50EafITvp2jzqfPrLwkA79cuCeeYL5glhEB+huUt
         HVYMYNZN6PdsQ4IdQPpIAWUJajoPc2s6LGxTalSIOwn4aVvhM9YK1twccZaC+rD8fYl5
         ujAA==
X-Gm-Message-State: AOJu0Yx/lGJwrtzIihMpmZFPED8iazClro4PLvcPPo4ekiwHIeT7c7d/
	xk5WOQ5aL7HwW6GPvQBWen6xAKYZ+d2dCMW7Os7TW8BPGJqWO7KtZ+BzPYPmNbD5AQ==
X-Google-Smtp-Source: AGHT+IFi2T3U7xCtBLaC7zILHzDCar66uu7vifyuXEFZ1vqAFQfCFZ/IAa656gv02bT30CnPfmUw7A==
X-Received: by 2002:a17:902:e54d:b0:1e0:a7ed:e7b3 with SMTP id n13-20020a170902e54d00b001e0a7ede7b3mr2074696plf.33.1711423823627;
        Mon, 25 Mar 2024 20:30:23 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902654d00b001dd99fe365dsm5676310pln.42.2024.03.25.20.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 20:30:23 -0700 (PDT)
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
Subject: [PATCH net-next 1/4] Documentation: netlink: add a YAML spec for team
Date: Tue, 26 Mar 2024 11:30:01 +0800
Message-ID: <20240326033005.2072622-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326033005.2072622-1-liuhangbin@gmail.com>
References: <20240326033005.2072622-1-liuhangbin@gmail.com>
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
index f736af98d7b5..0b08b8549ebf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21640,6 +21640,7 @@ F:	drivers/net/team/
 F:	include/linux/if_team.h
 F:	include/uapi/linux/if_team.h
 F:	tools/testing/selftests/drivers/net/team/
+F:	Documentation/netlink/specs/team.yaml
 
 TECHNICAL ADVISORY BOARD PROCESS DOCS
 M:	"Theodore Ts'o" <tytso@mit.edu>
-- 
2.43.0


