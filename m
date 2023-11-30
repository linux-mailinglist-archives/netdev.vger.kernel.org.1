Return-Path: <netdev+bounces-52619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D67FF7D4
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A753B20D5B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C8655C26;
	Thu, 30 Nov 2023 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLqSFtWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED5010E2;
	Thu, 30 Nov 2023 09:14:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b538d5c4eso8209955e9.1;
        Thu, 30 Nov 2023 09:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701364441; x=1701969241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWl/4qXizi6Ul7FtDLArDPeN2uRl1gF4/EhF2ynBmFQ=;
        b=NLqSFtWtnAiDe7tix8o1I/mAJyDqprjn9pZxSzdzC2h/zWpUdTr1Xjyccch+2ZDRzf
         RS9U10LsYq1/9zHwvjcoMMfVtY5xtR8/isIId9AZLdDAVrJI37xFRS+Q3WGl2cio9dDr
         S1oGclkMSPqlNfgBrOtsixpCBdrRtf/RKMsUNOlBGVAv4CDeIyjyrF56I4j+gIf5qwXK
         HSWG6XmqGQra2ieox0hqYXGI1xzm9m7NzZbd4HiMve4lTcdQo0xURNXX9bOledT4iQWj
         uta1gwLJpS4n5zxlge+2p1LTVzwhME8d0quZ25Q5sxidTCgg9mc8iDS8C6sZtRq8jtks
         Fwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701364441; x=1701969241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWl/4qXizi6Ul7FtDLArDPeN2uRl1gF4/EhF2ynBmFQ=;
        b=d2gHHjUfM2iY/lDrptBKnOKIm5I7rDPUASaGp1c36vgXoZqiSSz9glmrhz4fySiw0Q
         bTaM0bWZ16eZaSC+Mku6GZ8L06778ercsa5DJhg5S3Cp7HsKD5OIZDhFVqvcYWbW90eE
         LZhSWPnhoonzuzgqTOFdL65TSe9C+131/SIs3JM0DXyrHt04S0JwTjr3p/LxbBICX8Nd
         OZyRBw73obOCWU93Zh3qIJE/66LOu4htAmTKvHhgOVkUgfGqYbfUaD6DGXZymm7K9tUT
         wtNLFqdiU2p/vLHlKaDHnW/1+Tm5bvZliEkZSirIXHOhhkblIuSMiRXGzOmivQE9tiVQ
         SN1w==
X-Gm-Message-State: AOJu0YxLCA+OxjM3L+9nPx2DfVfS9QJUdmRhujn8z8TaLBhYUiaRceAc
	EYcPF+lRESLdve7IFiQAmt++oiaww30IVA==
X-Google-Smtp-Source: AGHT+IFcjULPc6i1EL7NlmgVnLtLDnVD4YxzkCXSb+WBV7McMvSCaxucbUxj/Gr9orpl0B0v10g52w==
X-Received: by 2002:a5d:5648:0:b0:333:160c:549f with SMTP id j8-20020a5d5648000000b00333160c549fmr16385wrw.60.1701364441137;
        Thu, 30 Nov 2023 09:14:01 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4842:bce4:1c44:6271])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b003332ef77db4sm260519wrv.44.2023.11.30.09.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:13:59 -0800 (PST)
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
Date: Thu, 30 Nov 2023 17:13:47 +0000
Message-ID: <20231130171349.13021-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
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


