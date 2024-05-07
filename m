Return-Path: <netdev+bounces-94028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E7D8BDFD1
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA5E1F253BA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCFE71B40;
	Tue,  7 May 2024 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1569fFQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72F8F62
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078172; cv=none; b=pYBW9pHYW8xu+fT7LGYhOKhsua3u8DoqTOnSuvEK3NljODbGvXUbbGzGwn7RKze8KJMsVA28me1j5WButFr6tAyGGDhDZ5z74SVozRYrkKYvSSkiVK0VB0Iy/hwDQW8Qj3GZJd+LbV8UclGCjzvPSGBCN1JXCfBCM+K/1vurHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078172; c=relaxed/simple;
	bh=SnSpweNs7JgipgxkC8+lysJkSH14djmciPXfMLmGFFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CxdmgfTMZWEqk2d1O/UOfFRRZ9b14bmv2iduYG5TcCg4J6Jhga/YxM2e3ec2pHqRYIPu95sPnZ7W1SAwnQ5xiE3XNOTtPYTnkYK7bwogUBDe6P2EN8ZCZ5bnmwzp1I2SAN1TvwDjJeA+zWXIJEGvL0VrkvVhTsu2BTK6itvxKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1569fFQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5210684cee6so1232104e87.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715078168; x=1715682968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qBLD8Ai+c/j0/vqpC7R8CP8PKT5t/umEMkKEJwnu2JE=;
        b=G1569fFQ4CCT9pEyjQGqhv56n1umaHWns1mQ7OA0WqOwIjoI6CDGY42zpjlWWk/wmC
         jb0ylbAT8/P8zzZTNv66QiuwNv0zvlHvLkorTmF8urzg9tVNNy1Zij/Rcc6gCUG8Tk5+
         +DL1F69VCn/gqiSeBxyfFTgVUUhKXzI13lqzlQ/vw+0dG+yRkLItZEZb2RB2j895wHaH
         i/12XncggAXVv9Y0KXOCmkx41vOe6PMMCT633k7lxCMFf5CZ0OswUEOP1z6n4l1cK6JP
         DMfqejLXTbc7Fvs/Ef/rzlI01xt/uOGVazHSv98h+4DBoKfMUSFa0cIMBqtJKtXurSuo
         QH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715078168; x=1715682968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBLD8Ai+c/j0/vqpC7R8CP8PKT5t/umEMkKEJwnu2JE=;
        b=ZXG1ENo2ba80WWNB+RdiOf1vI9SVyRxWsnOV/fYoagKduee6iHlFij3ZoPlqjh+9/V
         J0NJwzWOsihQOJGzsXqrjvNMLlSnwwDT1v+c1BBGTFOa1POdXM6mvevkyHwty6Awmd5a
         HrobJrlvZOKcBgFdHP4u7dIEzuUHdAlqgQ1qJgCtl4sJp5s1SxNXmFkf0TZTRdSoi6Yh
         qXLbdm4A2sRvO++Omqpr9cIbiMV2FnmTr0gqNSWxx7vHVv9zC6SNwWhoOeMRdhCi42oo
         VvYQn+L0Zl924VZKI7I61MaFBaHhL6JPG8M7l8XXM0/iPA1/0CNOin1EAVrS4i78xrKv
         10Bg==
X-Gm-Message-State: AOJu0YwtA8/MXXGUSMnJfY0dHzKb9p4gT04Ihh/hzsz9oG9L8PDwBVv+
	oSFtBsZM+tVHZLheg3++x31JMk+QR+6IDkuK3S8OZuDQAL4CapJK8ko3gvDz
X-Google-Smtp-Source: AGHT+IG5IiKgU/rQCySmaCPXoOz66rEhfruOR7gAjTKehpyAx/DiLsntxridmAYu48WS8s6oIsgtRA==
X-Received: by 2002:a05:6512:1390:b0:518:e69b:25a2 with SMTP id fc16-20020a056512139000b00518e69b25a2mr10215325lfb.45.1715078167903;
        Tue, 07 May 2024 03:36:07 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:3862:614f:7276:d1e0])
        by smtp.gmail.com with ESMTPSA id da11-20020a056000196b00b00349ff2e0345sm12800934wrb.70.2024.05.07.03.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:36:07 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] netlink/specs: Add VF attributes to rt_link spec
Date: Tue,  7 May 2024 11:36:03 +0100
Message-ID: <20240507103603.23017-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for retrieving VFs as part of link info. For example:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
  --do getlink --json '{"ifi-index": 38, "ext-mask": ["vf", "skip-stats"]}'
{'address': 'b6:75:91:f2:64:65',
 [snip]
 'vfinfo-list': {'info': [{'broadcast': b'\xff\xff\xff\xff\xff\xff\x00\x00'
                                        b'\x00\x00\x00\x00\x00\x00\x00\x00'
                                        b'\x00\x00\x00\x00\x00\x00\x00\x00'
                                        b'\x00\x00\x00\x00\x00\x00\x00\x00',
                           'link-state': {'link-state': 'auto', 'vf': 0},
                           'mac': {'mac': b'\x00\x00\x00\x00\x00\x00\x00\x00'
                                          b'\x00\x00\x00\x00\x00\x00\x00\x00'
                                          b'\x00\x00\x00\x00\x00\x00\x00\x00'
                                          b'\x00\x00\x00\x00\x00\x00\x00\x00',
                                   'vf': 0},
                           'rate': {'max-tx-rate': 0,
                                    'min-tx-rate': 0,
                                    'vf': 0},
                           'rss-query-en': {'setting': 0, 'vf': 0},
                           'spoofchk': {'setting': 0, 'vf': 0},
                           'trust': {'setting': 0, 'vf': 0},
                           'tx-rate': {'rate': 0, 'vf': 0},
                           'vlan': {'qos': 0, 'vf': 0, 'vlan': 0},
                           'vlan-list': {'info': [{'qos': 0,
                                                   'vf': 0,
                                                   'vlan': 0,
                                                   'vlan-proto': 0}]}},
                          {'broadcast': b'\xff\xff\xff\xff\xff\xff\x00\x00'
                                        b'\x00\x00\x00\x00\x00\x00\x00\x00'
                                        b'\x00\x00\x00\x00\x00\x00\x00\x00'
                                        b'\x00\x00\x00\x00\x00\x00\x00\x00',
                           'link-state': {'link-state': 'auto', 'vf': 1},
                           'mac': {'mac': b'\x00\x00\x00\x00\x00\x00\x00\x00'
                                          b'\x00\x00\x00\x00\x00\x00\x00\x00'
                                          b'\x00\x00\x00\x00\x00\x00\x00\x00'
                                          b'\x00\x00\x00\x00\x00\x00\x00\x00',
                                   'vf': 1},
                           'rate': {'max-tx-rate': 0,
                                    'min-tx-rate': 0,
                                    'vf': 1},
                           'rss-query-en': {'setting': 0, 'vf': 1},
                           'spoofchk': {'setting': 0, 'vf': 1},
                           'trust': {'setting': 0, 'vf': 1},
                           'tx-rate': {'rate': 0, 'vf': 1},
                           'vlan': {'qos': 0, 'vf': 1, 'vlan': 0},
                           'vlan-list': {'info': [{'qos': 0,
                                                   'vf': 1,
                                                   'vlan': 0,
                                                   'vlan-proto': 0}]}}]},
 'xdp': {'attached': 0}}

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_link.yaml | 237 ++++++++++++++++++++++-
 1 file changed, 235 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 113ecd17c880..0f02b9579b5a 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -770,6 +770,139 @@ definitions:
       -
         name: to
         type: u32
+  -
+    name: ifla-vf-mac
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: mac
+        type: binary
+        len: 32
+  -
+    name: ifla-vf-vlan
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: vlan
+        type: u32
+      -
+        name: qos
+        type: u32
+  -
+    name: ifla-vf-tx-rate
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: rate
+        type: u32
+  -
+    name: ifla-vf-spoofchk
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: setting
+        type: u32
+  -
+    name: ifla-vf-link-state
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: link-state
+        type: u32
+        enum: ifla-vf-link-state-enum
+  -
+    name: ifla-vf-link-state-enum
+    type: enum
+    entries:
+      - auto
+      - enable
+      - disable
+  -
+    name: ifla-vf-rate
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: min-tx-rate
+        type: u32
+      -
+        name: max-tx-rate
+        type: u32
+  -
+    name: ifla-vf-rss-query-en
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: setting
+        type: u32
+  -
+    name: ifla-vf-trust
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: setting
+        type: u32
+  -
+    name: ifla-vf-guid
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: guid
+        type: u64
+  -
+    name: ifla-vf-vlan-info
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: vlan
+        type: u32
+      -
+        name: qos
+        type: u32
+      -
+        name: vlan-proto
+        type: u32
+  -
+    name: rtext-filter
+    type: flags
+    entries:
+      - vf
+      - brvlan
+      - brvlan-compressed
+      - skip-stats
+      - mrp
+      - cfm-config
+      - cfm-status
+      - mst
 
 attribute-sets:
   -
@@ -847,7 +980,7 @@ attribute-sets:
       -
         name: vfinfo-list
         type: nest
-        nested-attributes: vfinfo-attrs
+        nested-attributes: vfinfo-list-attrs
       -
         name: stats64
         type: binary
@@ -873,6 +1006,8 @@ attribute-sets:
       -
         name: ext-mask
         type: u32
+        enum: rtext-filter
+        enum-as-flags: true
       -
         name: promiscuity
         type: u32
@@ -1004,9 +1139,107 @@ attribute-sets:
         type: nest
         value: 45
         nested-attributes: mctp-attrs
+  -
+    name: vfinfo-list-attrs
+    attributes:
+      -
+        name: info
+        type: nest
+        nested-attributes: vfinfo-attrs
+        multi-attr: true
   -
     name: vfinfo-attrs
-    attributes: []
+    attributes:
+      -
+        name: mac
+        type: binary
+        struct: ifla-vf-mac
+      -
+        name: vlan
+        type: binary
+        struct: ifla-vf-vlan
+      -
+        name: tx-rate
+        type: binary
+        struct: ifla-vf-tx-rate
+      -
+        name: spoofchk
+        type: binary
+        struct: ifla-vf-spoofchk
+      -
+        name: link-state
+        type: binary
+        struct: ifla-vf-link-state
+      -
+        name: rate
+        type: binary
+        struct: ifla-vf-rate
+      -
+        name: rss-query-en
+        type: binary
+        struct: ifla-vf-rss-query-en
+      -
+        name: stats
+        type: nest
+        nested-attributes: vf-stats-attrs
+      -
+        name: trust
+        type: binary
+        struct: ifla-vf-trust
+      -
+        name: ib-node-guid
+        type: binary
+        struct: ifla-vf-guid
+      -
+        name: ib-port-guid
+        type: binary
+        struct: ifla-vf-guid
+      -
+        name: vlan-list
+        type: nest
+        nested-attributes: vf-vlan-attrs
+      -
+        name: broadcast
+        type: binary
+  -
+    name: vf-stats-attrs
+    attributes:
+      -
+        name: rx-packets
+        type: u64
+        value: 0
+      -
+        name: tx-packets
+        type: u64
+      -
+        name: rx-bytes
+        type: u64
+      -
+        name: tx-bytes
+        type: u64
+      -
+        name: broadcast
+        type: u64
+      -
+        name: multicast
+        type: u64
+      -
+        name: pad
+        type: pad
+      -
+        name: rx-dropped
+        type: u64
+      -
+        name: tx-dropped
+        type: u64
+  -
+    name: vf-vlan-attrs
+    attributes:
+      -
+        name: info
+        type: binary
+        struct: ifla-vf-vlan-info
+        multi-attr: true
   -
     name: vf-ports-attrs
     attributes: []
-- 
2.44.0


