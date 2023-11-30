Return-Path: <netdev+bounces-52716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645B57FFDED
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965A21C20F75
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE30860EF4;
	Thu, 30 Nov 2023 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0YNXwgc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D22210DE;
	Thu, 30 Nov 2023 13:50:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-333229dcebdso875569f8f.0;
        Thu, 30 Nov 2023 13:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701381013; x=1701985813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWl/4qXizi6Ul7FtDLArDPeN2uRl1gF4/EhF2ynBmFQ=;
        b=C0YNXwgcTjSE6W3xbwTU85ABvlaZPmTPtkXAwEwEo6OLiq+mu3bJohnAsITxq7o2gQ
         YoEtZLQGjZt0DlJRO6nB0LnBDIHRYtvoj05bnuQh9VfxNfx/m7Duw01v3CgZwOlZdqSR
         nm9myc4hdj+NZ5ymGHyslsV7IWFa53LeCpAXw613KGpgs4lEWuk+b+1DNdyv2VE8AM7e
         GHVTZm9WuqmtCk+S+dV5wyELVt0tbdpmkyTkqOETYzITEN0HbNXYfrQN8rwGlAaur31c
         HV/Psj5Le3yZOpumgvfC2QAN12qp4bewOuZI0MaxA/zpSMmCvp5kVDA4zfO7yufv3sqq
         Y2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381013; x=1701985813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWl/4qXizi6Ul7FtDLArDPeN2uRl1gF4/EhF2ynBmFQ=;
        b=CCaL88JIW8RFBGmZqxSq0m1EG7N3Xl6cIYuo5TbyVeWpXCwoziYNO+PVFM3pQBC7ZY
         7ittoa1E0qJXwDvc9QO2RZCmPEQ8ZCYDllaCPexP2FRpc0xg5PQEfITFDSoqwkf2s8Mz
         /5qhNC0rb3e/xmKWHhhZ52ume50EtWysK/C6JTaSWUf/cfvIIuIx5Q+5e2MmwyoLNImL
         8YAbFU+ylm/PRWBEWNEI0u/WPzdcjVy3IcPYrZ83R23WEW5G9Kl3IwPOp/ESbkNP6HOq
         kvjF2P0ndSL/zIr9Ykw6XPtryz2goL7thSc2hzbxv8MBTDA2E8Qpy+9jch77yO1Ay8GV
         0jzQ==
X-Gm-Message-State: AOJu0YwEHzB1KaHuksiagFReeREUMOfXHqBA9KS3PH45LG9Mt+oxfVpm
	/hY3ZfqQ5a0s1CMJDsULiAWWHzw+gxGoYg==
X-Google-Smtp-Source: AGHT+IFCcOo15oLc7nrX9FZQDKdaXW00YOVqg1+ZKZMjzhhrKtW+qbT/hrBquDeKZ4Gtu35j0sYQrQ==
X-Received: by 2002:adf:b1d3:0:b0:333:18ea:bf08 with SMTP id r19-20020adfb1d3000000b0033318eabf08mr153340wra.59.1701381013279;
        Thu, 30 Nov 2023 13:50:13 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4842:bce4:1c44:6271])
        by smtp.gmail.com with ESMTPSA id dd10-20020a0560001e8a00b0032fbe5b1e45sm2519237wrb.61.2023.11.30.13.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:50:12 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 4/6] tools/net/ynl: Add binary and pad support to structs for tc
Date: Thu, 30 Nov 2023 21:49:56 +0000
Message-ID: <20231130214959.27377-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130214959.27377-1-donald.hunter@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tc netlink-raw family needs binary and pad types for several
qopt C structs. Add support for them to ynl.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml |  2 +-
 tools/net/ynl/lib/ynl.py               | 36 +++++++++++++++++++-------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 26203282422f..dc3d4eeb67bb 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -127,7 +127,7 @@ properties:
                 type: string
               type:
                 description: The netlink attribute type
-                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary ]
+                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary, pad ]
               len:
                 $ref: '#/$defs/len-or-define'
               byte-order:
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 886ecef5319e..4f1c1e51845e 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -670,8 +670,11 @@ class YnlFamily(SpecFamily):
             fixed_header_members = self.consts[name].members
             size = 0
             for m in fixed_header_members:
-                format = NlAttr.get_format(m.type, m.byte_order)
-                size += format.size
+                if m.type in ['pad', 'binary']:
+                    size += m.len
+                else:
+                    format = NlAttr.get_format(m.type, m.byte_order)
+                    size += format.size
             return size
         else:
             return 0
@@ -681,12 +684,20 @@ class YnlFamily(SpecFamily):
         fixed_header_attrs = dict()
         offset = 0
         for m in fixed_header_members:
-            format = NlAttr.get_format(m.type, m.byte_order)
-            [ value ] = format.unpack_from(msg.raw, offset)
-            offset += format.size
-            if m.enum:
-                value = self._decode_enum(value, m)
-            fixed_header_attrs[m.name] = value
+            value = None
+            if m.type == 'pad':
+                offset += m.len
+            elif m.type == 'binary':
+                value = msg.raw[offset:offset+m.len]
+                offset += m.len
+            else:
+                format = NlAttr.get_format(m.type, m.byte_order)
+                [ value ] = format.unpack_from(msg.raw, offset)
+                offset += format.size
+            if value is not None:
+                if m.enum:
+                    value = self._decode_enum(value, m)
+                fixed_header_attrs[m.name] = value
         return fixed_header_attrs
 
     def handle_ntf(self, decoded):
@@ -753,8 +764,13 @@ class YnlFamily(SpecFamily):
             fixed_header_members = self.consts[op.fixed_header].members
             for m in fixed_header_members:
                 value = vals.pop(m.name) if m.name in vals else 0
-                format = NlAttr.get_format(m.type, m.byte_order)
-                msg += format.pack(value)
+                if m.type == 'pad':
+                    msg += bytearray(m.len)
+                elif m.type == 'binary':
+                    msg += bytes.fromhex(value)
+                else:
+                    format = NlAttr.get_format(m.type, m.byte_order)
+                    msg += format.pack(value)
         for name, value in vals.items():
             msg += self._add_attr(op.attr_set.name, name, value)
         msg = _genl_msg_finalize(msg)
-- 
2.42.0


