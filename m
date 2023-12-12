Return-Path: <netdev+bounces-56621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF40280FA09
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA4F282117
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CD26470F;
	Tue, 12 Dec 2023 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dELrEdXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F159AA;
	Tue, 12 Dec 2023 14:16:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3332fc9b9b2so5507545f8f.1;
        Tue, 12 Dec 2023 14:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419393; x=1703024193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtxJiqIly6O4FepYd7MdD0YiyWEuZi0nvauvTiLnJ/I=;
        b=dELrEdXIE/CwN0U0yICdsfMO1zf6EwCAa+FQMLKGjVg20+jN6AF73ThVcIBmPpOqkA
         Lu31UZOVz0AGKqILlquxt57uMGTD2HPJZ+dvsfxzF7BJ5M3A2wMjwzi6yFcwCCsspx6S
         /QNP7c/y0cOcompJom9pVolU5Oe80kx2dsfn2acXA/NysuoRLfUy4eTh5raxhJxc1SAz
         hz127rt1HwpfcAmFIePs4QMCz3AzuBd6Gug46ohKK1dVLQimX+M9NbvlSpJgX66dalsW
         TBR6m/pyMmogymxl0U6EqN/NRd6/wxFnbFgCDqhs2j5RS+yNgSGXa44+QnQHDd8WgOGc
         2GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419393; x=1703024193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtxJiqIly6O4FepYd7MdD0YiyWEuZi0nvauvTiLnJ/I=;
        b=X+0du+2ivaqCyGradkpnq7dTvrV83dV1weJzUoMGn8+M7ikZTnCpB/SnFW4arvM9iQ
         paacqYD5N4ci0HCxQ+RHGM6qhKWzC98tfmYUhYTJF/tI2Tp4HEobDyNFTXSTN6KQix/y
         iDMnHzBuTpF/0p3Px6Oibf/CiwfDiwXnWx7X89o+LlQvTJXgA0KDYR4SqLp8rzqNgPK9
         qpb2wx55urnQWW36mynIl82bPp7w952IoH5/Vzxv7hmc/JIQvhILxW6fPQf9rGHtLD+w
         XmnrYFxkjtiHlq2+cpvPJtuVXWPDAK8KCrQeUEmQN4mnxcAEwWQXRYAuRj3eLClMNW8W
         MQPQ==
X-Gm-Message-State: AOJu0Yw1yT/T4tjmHgA3GrSTF1J6C0aFlKc7SgSe0bwW4g0apIW7VQU9
	PxbE5zWwswLKMj3YQudZLEMBWF0f37jtTg==
X-Google-Smtp-Source: AGHT+IErUHjTZChohZzK/Pz31pdFIo2I3HbHnDDl66s7mhREMXdoVSy0Ao+bYrh5Y43v9c1u+xcREg==
X-Received: by 2002:adf:e450:0:b0:336:2ee0:24a6 with SMTP id t16-20020adfe450000000b003362ee024a6mr409271wrm.63.1702419393059;
        Tue, 12 Dec 2023 14:16:33 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm11680482wrt.22.2023.12.12.14.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:32 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 05/13] tools/net/ynl: Add binary and pad support to structs for tc
Date: Tue, 12 Dec 2023 22:15:44 +0000
Message-ID: <20231212221552.3622-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212221552.3622-1-donald.hunter@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
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
 tools/net/ynl/lib/ynl.py | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index a69fb0c9f728..61d672c57fb0 100644
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
+                value = msg.raw[offset : offset + m.len]
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


