Return-Path: <netdev+bounces-57092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B262F8121D9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7031C213F4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98A981848;
	Wed, 13 Dec 2023 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZNdPXJT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF918D;
	Wed, 13 Dec 2023 14:42:08 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3333b46f26aso6703951f8f.1;
        Wed, 13 Dec 2023 14:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507326; x=1703112126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uDEek6+Jtpacg00rqhgwzK/qMhvND186I0lm7RnUWw=;
        b=JZNdPXJT2g6gACWQku60AFJlaaKigqpOuN/puo3kF/aDXIgKXvRdErdLPhOu3Z1KgC
         pKv+GUTWNHF4TexHcXFmrR+Kn1+h7/iDUnD2hKYxwz7kDFyU2r4id/nnospo/RXb+umq
         Ii90C9azGh+iJ++0CcyFuLj2w7MFKlEyKC1KlCq/c+nZCR1G6L9lEQFriv29ud6F+n/1
         s7fbTEAGVK34R81pUyUsbIe5k1c3P9m8hR4PDIqYVaTrE/h2U9ykQG+cDfGzjGRgiASN
         zxrF5WAoCk6pUge21R+Xhbs1jneE7DP8Sd/3Av30yPNKjPcesD3ly+CQ3erfXQEPmbum
         Mgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507326; x=1703112126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uDEek6+Jtpacg00rqhgwzK/qMhvND186I0lm7RnUWw=;
        b=dwe6aWbETmvdrmhwar/ig81y6m+HEEpNv4sRMELzWKtBJLToHuTEm5+P0S3dC+Cv4R
         NHDXzrs79GDue42lVM1lBgfk6guBwR7fXDRtdDm6BXnQF8L3I492NMTuLyqgA1avqzkb
         Js1Lc/mzCReC4qYtU5p2I4RGvfHi3Fq3+lSKeFrLKudvPSh5JSvx2GRePtApjf69hbMS
         YegaQlVaPG4EIATjI1/JSUF0M4Bn+D+kXjIUBtF16jzz5HNTND3LqmcIt5bKXbcOQAHI
         qJj519cOyDOu0kPDhsoS3pGWtkkjdzRYnQZj39b4Ckfg2A+mFY+fUdoHMWHq2RtNY0kl
         Vnmw==
X-Gm-Message-State: AOJu0Yxq5qhHazLvaP56tRAtHJwptrace9PuParOPk7ekvrVUDs6Vzpf
	olrZdOPIg62DiM5DcaFEBBU7+fEcEgYubA==
X-Google-Smtp-Source: AGHT+IEBEmWzC8X4b7L02+NO3WoNfTyzBoy8jXzSLF4I282U9edUETIl+MHS28CVftLDThg3kvdzWg==
X-Received: by 2002:a5d:4701:0:b0:336:3fd4:2585 with SMTP id y1-20020a5d4701000000b003363fd42585mr785386wrq.110.1702507326035;
        Wed, 13 Dec 2023 14:42:06 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:04 -0800 (PST)
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
Subject: [PATCH net-next v4 05/13] tools/net/ynl: Add binary and pad support to structs for tc
Date: Wed, 13 Dec 2023 22:41:38 +0000
Message-ID: <20231213224146.94560-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213224146.94560-1-donald.hunter@gmail.com>
References: <20231213224146.94560-1-donald.hunter@gmail.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


