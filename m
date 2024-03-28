Return-Path: <netdev+bounces-82936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4C89040B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC21F2478F
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA9351C46;
	Thu, 28 Mar 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgmbqbQX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85112FB34
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641404; cv=none; b=QMjMpxpcb0skDKRE6cXlrrKHyT2LE3jK4g9Bp/nPyg6gCay8woUhoWapCiqXx3MTcrluq77Y/dd0w5/RRGAEAiVHoCIZ+ORy4P7KErbPxLXv50htQu9/NeBxpX4MOBIJnD/k/Rj7Mo/viCYguqcKs/c9svBISL8NWJxvqqva6Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641404; c=relaxed/simple;
	bh=hM7k7fC4i+XTtzIeab29jCRt+/dgHbQs3yXHbHCRzO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6msJv5SPh9T1l5OBkPqLOdcAju0o+WC36NafdL6B+pBu04552TUxVtIC9VTqKw3yrWXSQHp8ExEhCijT9V9/5ubqpkSNhjtJ4KkxELakRMuSHaV66Ld1l2jYYIBdUAcrL4W/7pgi68Zf3Qi0GJbzb7iSDH/PtpSzbjsmrULuqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgmbqbQX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41545e9f482so4454255e9.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711641401; x=1712246201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RByI44aaxcj0M/mpGXU6ahmjrJD6IldGtCb5KILPsGc=;
        b=MgmbqbQXbm5R+J8bdPEAD+mfXl49dK/6/p9JYT4u+NWGnqzAtb8jLpev+T7fD5j1Yf
         idLc8Sjrucu/sHMrIT7TR2yTziuYBVk/s0tg2NnnHGFE6SaPVt7Y0sLpj3UOzLXcgyJh
         pPoJSz7v3eMpu690HG20mpHtnz+Pd0hWzaQxMnL0uaPObHvyC+BZjUjv3Lfk0mFUS2v+
         S0ydBn0z5h4D4ws8LaBZpdRfSTdKRD5ZAqxXBbYkY9OJmUuE2FKkGngj7OfoO3pbv09H
         1zo0PiJBuzqGpb6UXqshMaC8A75zuTShW9oe+/5CZdWTu6DxtPlWtJEJxeXGstQgvzVX
         /Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711641401; x=1712246201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RByI44aaxcj0M/mpGXU6ahmjrJD6IldGtCb5KILPsGc=;
        b=sx0Y8IsBfm3+YyMklUn0W/+017iCktytiSA/0gcLdJqdYuUZBsv3FzCwi8EXFk1Egv
         Y0BwUqcukpQYqd02GohMoJk/kIKBpB8eSE/KcTz35PXgbmuqKOrZV1WAiljTjqkWZvyZ
         5eOr90bEpGYx9EJW2sKXEN8XUNhjl3ArY7a6dziZgdoPXf0ASQUeKzhtvaUURPpHm69h
         MZQhTK1tcy74OsBEtG1Ip294xkV6uezqJC8JOP+hcDCPgS1KQIYHFiP0wevT4XxPLWRR
         piwCQx2tx2VLlkBilYrBxZmcjEF2Xf1yFM47+p2VAXASesuO6/Hx0hGQ2HF/Jb9K5fhR
         h6Pw==
X-Gm-Message-State: AOJu0YyrpXfiVNrJQj2nes/iBmO52OR1lPEAFYi+JzSj5yX+QP7QbQVl
	uG4mFXXM1rO9mPN3mmtAOsHjgQqOOlEYA58SaoLLOKwsm1ruv1LiZyxham5ZvZc=
X-Google-Smtp-Source: AGHT+IGsd7XFC6En5heDTzSPShRcaP625Lh3kjSb2CP1ku5u9/4j7DiuElbFM51gdl+Bvv3Sb4cOAQ==
X-Received: by 2002:a05:600c:190d:b0:414:e63:4d20 with SMTP id j13-20020a05600c190d00b004140e634d20mr2745382wmq.16.1711641400628;
        Thu, 28 Mar 2024 08:56:40 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7530:d5b0:adf6:d5c5])
        by smtp.gmail.com with ESMTPSA id fl20-20020a05600c0b9400b00415460607b0sm2042831wmb.31.2024.03.28.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:56:40 -0700 (PDT)
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
Subject: [PATCH net-next v2] tools/net/ynl: Add extack policy attribute decoding
Date: Thu, 28 Mar 2024 15:56:36 +0000
Message-ID: <20240328155636.64688-1-donald.hunter@gmail.com>
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
Changes v1 -> v2 (Thanks to Jakub Kicinski):
 - Combine '-s' and '-u' variants into 'min-value' and 'max-value'
 - Don't handle the policy attrs that don't get used for extack reporting

 tools/net/ynl/lib/ynl.py | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 5fa7957f6e0f..7eeb73184c06 100644
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
@@ -214,6 +236,30 @@ class NlMsg:
                             desc += f" ({spec['doc']})"
                         self.extack['miss-type'] = desc
 
+    def _decode_policy(self, raw):
+        policy = {}
+        for attr in NlAttrs(raw):
+            if attr.type == Netlink.NL_POLICY_TYPE_ATTR_TYPE:
+                type = attr.as_scalar('u32')
+                policy['type'] = Netlink.AttrType(type).name
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_S:
+                policy['min-value'] = attr.as_scalar('s64')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_S:
+                policy['max-value'] = attr.as_scalar('s64')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_U:
+                policy['min-value'] = attr.as_scalar('u64')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_U:
+                policy['max-value'] = attr.as_scalar('u64')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_LENGTH:
+                policy['min-length'] = attr.as_scalar('u32')
+            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_LENGTH:
+                policy['max-length'] = attr.as_scalar('u32')
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


