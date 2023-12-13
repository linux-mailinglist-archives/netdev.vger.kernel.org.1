Return-Path: <netdev+bounces-56972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013488117AA
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450A41F21A6A
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD09364B8;
	Wed, 13 Dec 2023 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Newq4cEX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32F218F
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:36:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so6249099a12.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702481795; x=1703086595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxw+0i6TtbO9prolhBYfdHc3uY0Twx2dOtankjDcaSo=;
        b=Newq4cEXlkhQFSbkoYlzV/ULpYo0xdL47mupxWAl3bBa77kdM5RH33XqqCUQ7lBdrW
         ZEUs6yP4tOQbCcuwtK5gMLMfd+hmKhtmN+DMeqNsQsRTx38rxT9qNYYksQ+lSjrpIghQ
         gg3IggCzhJ83Q0BnIoHtHm0vbeNk1NLQKicOdX+JxrFAfKY/mjbwQoQUKYDK4RNYBLW8
         xR1EbULcjkX5c3vVSOVnug4y1Har7fvzJ2bKWEWLHNTsruOZhLnRiDBKKMQkItQT7N1z
         mQS1MU96lJR3IjHE4NWlBxnzn1RHCTO1VuzH6PPvkw12JmebfJs+ZLYhYD3ZVHgUzfTI
         XIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702481795; x=1703086595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxw+0i6TtbO9prolhBYfdHc3uY0Twx2dOtankjDcaSo=;
        b=hsLYUIjeKZ52nPHip6yrKvNKMF4HamUfxt0kNh103hhAvaf5sn5kd6uBZSherxUwvf
         BQESp5A0KoJzl/x/upWIZDfXDTuNCulDmefnpqWSazXY3kNfWTy5yMPJTl86SCF329A9
         U9kR/4jmKKsAZW/8a08aevw8ecDtXiHhp/jGQ4PlZ5MIJLlFhOVUvI81kQloovPHuvaz
         W9Pk5/nbEswIeauQSOzruJbu1pbYG5dyBISVKTC+/c6Dh0+ssyp0jzn/zoNd8lHakxM6
         K+VmrQvwbpu6KgWaWu+iLQcNbk+fLRnvBvUymUDNsusoRDGGGruMgQutZ59YiTWm3ZOI
         nNXQ==
X-Gm-Message-State: AOJu0Yy+1javoMzBojtgGzTqcouP13lXfs4xhTO0y5E77KsJrtFvHqAF
	g/iD9XSoD4c/CDkCAXHbOcQuGg==
X-Google-Smtp-Source: AGHT+IHpcAOg8ImSxjwV5QkCC/vaLXPJcW4G3nkfBxFb5eURBKzdPHO8f52JIkkyBdbVqmYyfz8FRA==
X-Received: by 2002:a17:907:971d:b0:a16:f41c:3714 with SMTP id jg29-20020a170907971d00b00a16f41c3714mr5639542ejc.22.1702481794958;
        Wed, 13 Dec 2023 07:36:34 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ry9-20020a1709068d8900b00a1f7470ba93sm7200961ejc.200.2023.12.13.07.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:36:34 -0800 (PST)
Date: Wed, 13 Dec 2023 16:36:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [Draft PATCH net-next 1/3] Documentation: netlink: add a YAML
 spec for team
Message-ID: <ZXnPgIc4qdxJ0fvN@nanopsycho>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
 <20231213084502.4042718-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213084502.4042718-2-liuhangbin@gmail.com>

Wed, Dec 13, 2023 at 09:45:00AM CET, liuhangbin@gmail.com wrote:
>Add a YAML specification for team.
>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> Documentation/netlink/specs/team.yaml | 205 ++++++++++++++++++++++++++
> MAINTAINERS                           |   1 +
> 2 files changed, 206 insertions(+)
> create mode 100644 Documentation/netlink/specs/team.yaml
>
>diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
>new file mode 100644
>index 000000000000..5647068bf521
>--- /dev/null
>+++ b/Documentation/netlink/specs/team.yaml
>@@ -0,0 +1,205 @@
>+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>+
>+name: team
>+
>+protocol: genetlink-legacy
>+
>+doc: |
>+  Network team device driver.
>+
>+c-family-name: team-genl-name
>+c-version-name: team-genl-version
>+kernel-policy: global
>+uapi-header: linux/if_team.h
>+
>+definitions:
>+  -
>+    name: string-max-len
>+    type: const
>+    value: 32
>+  -
>+    name: genl-change-event-mc-grp-name
>+    type: const
>+    value: change_event
>+
>+attribute-sets:
>+  -
>+    name: team
>+    doc:
>+      The team nested layout of get/set msg looks like
>+          [TEAM_ATTR_LIST_OPTION]
>+              [TEAM_ATTR_ITEM_OPTION]
>+                  [TEAM_ATTR_OPTION_*], ...
>+              [TEAM_ATTR_ITEM_OPTION]
>+                  [TEAM_ATTR_OPTION_*], ...
>+              ...
>+          [TEAM_ATTR_LIST_PORT]
>+              [TEAM_ATTR_ITEM_PORT]
>+                  [TEAM_ATTR_PORT_*], ...
>+              [TEAM_ATTR_ITEM_PORT]
>+                  [TEAM_ATTR_PORT_*], ...
>+              ...
>+    name-prefix: team-attr-
>+    attributes:
>+      -
>+        name: unspec
>+        type: unused
>+        value: 0
>+      -
>+        name: team-ifindex
>+        type: u32
>+      -
>+        name: list-option
>+        type: nest
>+        nested-attributes: item-option
>+      -
>+        name: list-port
>+        type: nest
>+        nested-attributes: item-port
>+  -
>+    name: item-option
>+    name-prefix: team-attr-item-
>+    attr-cnt-name: __team-attr-item-option-max
>+    attr-max-name: team-attr-item-option-max
>+    attributes:
>+      -
>+        name: option-unspec
>+        type: unused
>+        value: 0
>+      -
>+        name: option
>+        type: nest
>+        nested-attributes: attr-option
>+  -
>+    name: attr-option
>+    name-prefix: team-attr-option-
>+    attributes:
>+      -
>+        name: unspec
>+        type: unused
>+        value: 0
>+      -
>+        name: name
>+        type: string
>+        checks:
>+          # no unterminated-ok defination?
>+          # do we have to hard code this?
>+          max-len: 32
>+      -
>+        name: changed
>+        type: flag
>+      -
>+        name: type
>+        type: u8
>+      -
>+        name: data
>+        type: binary
>+      -
>+        name: removed
>+        type: flag
>+      -
>+        name: port-ifindex
>+        type: u32
>+        doc: for per-port options
>+      -
>+        name: array-index
>+        type: u32
>+        doc: for for array options
>+  -
>+    name: item-port
>+    name-prefix: team-attr-item-
>+    attr-cnt-name: __team-attr-item-port-max
>+    attr-max-name: team-attr-item-port-max
>+    attributes:
>+      -
>+        name: port-unspec
>+        type: unused
>+        value: 0
>+      -
>+        name: port
>+        type: nest
>+        nested-attributes: attr-port
>+  -
>+    name: attr-port
>+    name-prefix: team-attr-port-
>+    attributes:
>+      -
>+        name: unspec
>+        type: unused
>+        value: 0
>+      -
>+        name: ifindex
>+        type: u32
>+      -
>+        name: changed
>+        type: flag
>+      -
>+        name: linkup
>+        type: flag
>+      -
>+        name: speed
>+        type: u32
>+      -
>+        name: duplex
>+        type: u8
>+      -
>+        name: removed
>+        type: flag
>+
>+operations:
>+  list:
>+    -
>+      name: noop
>+      doc: No operation
>+      value: 0
>+      attribute-set: team
>+      dont-validate: [ strict, dump ]

What is this good for?


>+
>+      do:
>+        # Actually it only reply the team netlink family
>+        reply:
>+          attributes:
>+            - team-ifindex
>+
>+    -
>+      name: options-set
>+      doc: Set team options
>+      attribute-set: team
>+      dont-validate: [ strict, dump ]

There is no dump op. Same below.


>+      flags: [ admin-perm ]
>+
>+      do:
>+        request:
>+          attributes:
>+            - team-ifindex
>+            - list-option
>+
>+    -
>+      name: options-get
>+      doc: Get team options info
>+      attribute-set: team
>+      dont-validate: [ strict, dump ]
>+      flags: [ admin-perm ]
>+
>+      do:
>+        request:
>+          attributes:
>+            - team-ifindex
>+        reply:
>+          attributes:
>+            - list-option
>+
>+    -
>+      name: port-list-get
>+      doc: Get team ports info
>+      attribute-set: team
>+      dont-validate: [ strict, dump ]
>+      flags: [ admin-perm ]
>+
>+      do:
>+        request:
>+          attributes:
>+            - team-ifindex
>+        reply:
>+          attributes:
>+            - list-port
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 7fb66210069b..b64e449f47f9 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -21301,6 +21301,7 @@ F:	drivers/net/team/
> F:	include/linux/if_team.h
> F:	include/uapi/linux/if_team.h
> F:	tools/testing/selftests/drivers/net/team/
>+F:	Documentation/netlink/specs/team.yaml
> 
> TECHNICAL ADVISORY BOARD PROCESS DOCS
> M:	"Theodore Ts'o" <tytso@mit.edu>
>-- 
>2.43.0
>

