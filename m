Return-Path: <netdev+bounces-82592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B888EA2C
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 17:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37982A362B
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CE31304B6;
	Wed, 27 Mar 2024 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lzw7ZRd8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947B412FB39
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555392; cv=none; b=iHgIcsdb0fZjl698g1qnWqZzYZU78oufl2vqzvqE1RkTrcgoWF3HYjp7rcB9jhG6uYxpTUvt2cC50mX7Hq44HHepgCzEjMdg7+xi8mF7i2vLPlz8BI1EW1nz9jRv9d7wlKEzUR96dcV2p9tmauALhRPaR0KABkJ2ReFanft2otU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555392; c=relaxed/simple;
	bh=3akiRIsg9ariRSmqL4zMkYN+HATJCR9eNt4gSUncbPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEWVDIyLooBReZxn0y7H9xknl/14JnKy/shIVrkZLYtRwJ4dHdRpMoni9nkRJwq5+AENbIGa1ULUoJ+Q3+WSaAcOOrG7nOhIjTD8xrlC460FiOA7jDnYaXrAm05TFbA5QGmqEmutgxDw1DqT12SMAwDvyjhQ9kdZ5kgR4yyYV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lzw7ZRd8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4141156f245so46698645e9.2
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555388; x=1712160188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yANHfsSq1wnQHY0oy3e5H0IzzlKaSeY4xO4Bq5L1W4A=;
        b=Lzw7ZRd83bFKY1t4Mg783/xrIoh47DWfnlXYWTyzKudHjlAPhDJzXFDvWiS2xuX6Gu
         V6a3NmHHNujl0lVFqT8PRgu5EgJVPHT/SxNqjVuaG/Te3UN+Rm59HFcrqJveCObdTwRS
         ceMwWZ/wEFMXBAO23hLTELIIU9d/1vaPF03RMtdJwSpu7hK/t/FTSV79zortFkDuJie6
         7vLSlwpuTDvASV5vuiRByodX9NlwXYHEMvL63dLXrlGkiOWo5q0gIetkZQUcp/DA/uVY
         cv8PqW+KMAJWcCkazDFs+u+oS6O7u+fWTtDW1KEL/2dZliU7Wnrxq8OXjPX09X3oewPT
         lQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555388; x=1712160188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yANHfsSq1wnQHY0oy3e5H0IzzlKaSeY4xO4Bq5L1W4A=;
        b=GhZX5TGcRgoD9uc1yQBrXV3q8F83fOS8nHrRL66QJYs3SM674gMJi/G6d+lKiVIrGo
         XBe5P8il4tqhcp14caOGSTpl0M55aDoJeE+bC7JqG8/6eRbPJ+Cxt+Denv7vSLFX/uWC
         P5gsiO2R8CPvC+PL9Wb+6txIFrwy2wXHChF6VXqfScuF3A8yBUpE4Itj4Ufq78lOMlBI
         bF2Zunhyicyrllp2YkPFmR8NlsdO82iFkB2ceFVlIPUfv2rzpHUkYGv2aQuVnra4upGr
         zYWzZzHmh3nwQCMykK9z4yesQ3eFgT9uT5BIHOLLRTcm0NZnUgTbhEB0+PuCoD0ETKSl
         Ba9A==
X-Gm-Message-State: AOJu0YydXzQjslF7/2pkiI4f1a/y8ylr8aPIE586nUQzGvUClAg6BJDU
	SdOAuEtKIvSnzwpExxERYR3PuyCXeKtH54iLQCb+bJ96S/v8p47eVEEx8wEkOcQ=
X-Google-Smtp-Source: AGHT+IE81RbhsENGEfqAOeVQfdhAEzLv4nHmA8Wh3qGC+F7hvW0b2zkedpV84M64aCmtcUd6UIgiwA==
X-Received: by 2002:a05:600c:1f8e:b0:414:71e2:a249 with SMTP id je14-20020a05600c1f8e00b0041471e2a249mr321444wmb.41.1711555387374;
        Wed, 27 Mar 2024 09:03:07 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:5876:f134:d112:62c7])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c191300b00414924f307csm2540450wmq.26.2024.03.27.09.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:03:06 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] tools/net/ynl: Add extack policy attribute decoding
Date: Wed, 27 Mar 2024 16:03:02 +0000
Message-ID: <20240327160302.69378-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NLMSGERR_ATTR_POLICY extack attribute has been ignored by ynl up to
now. Extend extack decoding to include _POLICY and the nested
NL_POLICY_TYPE_ATTR_* attributes.

For example:

./tools/net/ynl/cli.py \
  --spec Documentation/netlink/specs/rt_link.yaml \
  --create --do newlink --json '{
    "ifname": "12345678901234567890",
    "linkinfo": {"kind": "bridge"}
    }'
Netlink error: Numerical result out of range
nl_len = 104 (88) nl_flags = 0x300 nl_type = 2
	error: -34	extack: {'msg': 'Attribute failed policy validation',
'policy': {'max-length': 15, 'type': 'string'}, 'bad-attr': '.ifname'}

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 5fa7957f6e0f..557ef5a22b7d 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
 from collections import namedtuple
+from enum import Enum
 import functools
 import os
 import random
@@ -76,6 +77,25 @@ class Netlink:
     NLMSGERR_ATTR_MISS_TYPE = 5
     NLMSGERR_ATTR_MISS_NEST = 6
 
+    # Policy types
+    NL_POLICY_TYPE_ATTR_TYPE = 1
+    NL_POLICY_TYPE_ATTR_MIN_VALUE_S = 2
+    NL_POLICY_TYPE_ATTR_MAX_VALUE_S = 3
+    NL_POLICY_TYPE_ATTR_MIN_VALUE_U = 4
+    NL_POLICY_TYPE_ATTR_MAX_VALUE_U = 5
+    NL_POLICY_TYPE_ATTR_MIN_LENGTH = 6
+    NL_POLICY_TYPE_ATTR_MAX_LENGTH = 7
+    NL_POLICY_TYPE_ATTR_POLICY_IDX = 8
+    NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE = 9
+    NL_POLICY_TYPE_ATTR_BITFIELD32_MASK = 10
+    NL_POLICY_TYPE_ATTR_PAD = 11
+    NL_POLICY_TYPE_ATTR_MASK = 12
+
+    AttrType = Enum('AttrType', ['flag', 'u8', 'u16', 'u32', 'u64',
+                                  's8', 's16', 's32', 's64',
+                                  'binary', 'string', 'nul-string',
+                                  'nested', 'nested-array',
+                                  'bitfield32', 'sint', 'uint'])
 
 class NlError(Exception):
   def __init__(self, nl_msg):
@@ -198,6 +218,8 @@ class NlMsg:
                     self.extack['miss-nest'] = extack.as_scalar('u32')
                 elif extack.type == Netlink.NLMSGERR_ATTR_OFFS:
                     self.extack['bad-attr-offs'] = extack.as_scalar('u32')
+                elif extack.type == Netlink.NLMSGERR_ATTR_POLICY:
+                    self.extack['policy'] = self._decode_policy(extack.raw)
                 else:
                     if 'unknown' not in self.extack:
                         self.extack['unknown'] = []
@@ -214,6 +236,34 @@ class NlMsg:
                             desc += f" ({spec['doc']})"
                         self.extack['miss-type'] = desc
 
+    def _decode_policy(self, raw):
+        policy = {}
+        for attr in NlAttrs(raw):
+            if attr.type == Netlink.NL_POLICY_TYPE_ATTR_TYPE:
+                type = attr.as_scalar('u32')
+                policy['type'] = Netlink.AttrType(type).name
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_S:
+                policy['min-value-s'] = attr.as_scalar('s64')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_S:
+                policy['max-value-s'] = attr.as_scalar('s64')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_U:
+                policy['min-value-u'] = attr.as_scalar('u64')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_U:
+                policy['max-value-u'] = attr.as_scalar('u64')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_LENGTH:
+                policy['min-length'] = attr.as_scalar('u32')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_LENGTH:
+                policy['max-length'] = attr.as_scalar('u32')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_POLICY_IDX:
+                policy['policy-idx'] = attr.as_scalar('u32')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE:
+                policy['policy-maxtype'] = attr.as_scalar('u32')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_BITFIELD32_MASK:
+                policy['bitfield32-mask'] = attr.as_scalar('u32')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MASK:
+                policy['mask'] = attr.as_scalar('u64')
+        return policy
+
     def cmd(self):
         return self.nl_type
 
-- 
2.44.0


