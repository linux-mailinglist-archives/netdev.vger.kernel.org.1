Return-Path: <netdev+bounces-55991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E33D80D25D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F241F2193A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D84E1C2;
	Mon, 11 Dec 2023 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn1QpWnC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8F8B4;
	Mon, 11 Dec 2023 08:41:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c26a45b2dso26119745e9.1;
        Mon, 11 Dec 2023 08:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312866; x=1702917666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKmjWpfKlebY0rBStckhhFkb5iaVTU1byGNCOfVc64U=;
        b=dn1QpWnCj8g1lyL0J+gHpFXEoRyb7zd1PuexTYkwSUNBqQJ6CkX6MIqnhyOnUSLkdt
         cPCq4jNd2m4xN6UDNmqqfpXmoS2CHItGEYsYawCTSPVO83KE8CRFDteZeEFNg2DqarqE
         Oczp4pnvgDco4gIvAnpcSyG1M6QnPfavCXRLXLG8NxPhM3JuOddKEM3JA3Ib/YkmNuRv
         w9bg0GIh8usInBOOg3YTHa51jPZGh8Xtk9qDWEcyxOhSG631kR5uLo9jQA8IOR4YMcUA
         mZFxAR0II5aRu2cepHTDzmhK8AV7TRn7iTusHw7Od41kelqoNR8DDdedYvIQFPpaNAHJ
         y2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312866; x=1702917666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKmjWpfKlebY0rBStckhhFkb5iaVTU1byGNCOfVc64U=;
        b=hPh807KKLeqAKH/f1uC/fzmgX8yNrudvhsv7Vc+V0na6vsgGlbtzv9uP7CYZwT9egH
         Bm8CANFzcTVjOeH8DgrW27LTBd1cvxlddwbBnnrqClT2ssrY03kmPjsckc4l2cBl8VTF
         GMZZd25AAGhgLixLEP1Nna5aPT+GIFy5EpmR6zc8JnXOLYHjEerMD3ytfu1PLyt01fWU
         1iOQzYUiM7Nq04/CdAEBrm7FAT7gUOeQEf1tylSrkABl+B/6bB/Gj+CdR9P4AShb0hX0
         CuETvSjwTdRPllPhsLmy/jabct6HOLSaN1nokdN9EL/cicZlLKrOQCvxHsazFx+NtIN/
         GG6w==
X-Gm-Message-State: AOJu0YzKoH634y8VK/iLRuIXivi3eDVjnW8dIjPhOXiY5MGxFb8I/OQe
	rKaC91CFp4g4G0tqWEystL38ynyFJoyeiA==
X-Google-Smtp-Source: AGHT+IFUUawKy/bZOoF+mb+Hd8goLluT1/SRF1HuXvpkcM8h/W6fcYt8Wj176r2rD0WRk9C5/cL3fw==
X-Received: by 2002:a7b:c4d7:0:b0:40b:5e26:238b with SMTP id g23-20020a7bc4d7000000b0040b5e26238bmr2535753wmk.60.1702312866089;
        Mon, 11 Dec 2023 08:41:06 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm7418679wmq.26.2023.12.11.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:41:05 -0800 (PST)
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
Subject: [PATCH net-next v2 08/11] tools/net/ynl: Add binary and pad support to structs for tc
Date: Mon, 11 Dec 2023 16:40:36 +0000
Message-ID: <20231211164039.83034-9-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211164039.83034-1-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
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


