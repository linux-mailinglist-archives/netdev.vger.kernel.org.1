Return-Path: <netdev+bounces-66893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E558415C0
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4CA1F252CE
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9795467B;
	Mon, 29 Jan 2024 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpJ7rh0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CA54276;
	Mon, 29 Jan 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567735; cv=none; b=oW8XzYCz8jVBw5Pc9cYpFz78KoYVYUh+9yjAtoCm1iixpAZSTfZwEVtW+f4GM9Tv435mzA+jFVOMPkd2e7991McT0VveHxV+Kv9fICTk2+q7IREz5O6rdgASobVVgzTpNLTQR4i76xwf0+vvtz+rqkXKKYnmLdFdf6DOos3mrnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567735; c=relaxed/simple;
	bh=hG82PmU96foe+hKO0K3H/9CAb3vxzu+h0O9pK1YlwpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxCQfUtQd4vXaJoAYPhk+cSyMTZ/FpCazjtbzcH4w3Kt/GyOPYh/l2aqDewZ7et9F2Vq2HHvY9wViHqa8SMY7TeSinzLNY1WNbwjjGL1/nvrdnoo2NWp3s3lSH5PZCWGznaT35LX60IuwGxDlVZSZzcNCdMOPrn65DyuVZorvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpJ7rh0A; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so11996905e9.3;
        Mon, 29 Jan 2024 14:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567731; x=1707172531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLRsyiBLlG1o/uwlyldd0juZuNiwvnE4YR1zXRqyT+w=;
        b=QpJ7rh0A/KxE1As8+lEQiBzmzQdUGl4zTzPCFKCAbdQ9OFZ9hCLQJRhKfFRRRhUspG
         UPAb6EmE728GUWJOaR+Dwe8n+yA0RbbdECzyNsjbMVcCWXRuvpsZ/RrXjUKDIPgxV+v6
         MYLz4lCAr5CRZTG2u9zjHoScSD6plFN4Dt8kPxLN0k24eTbWn9dbSHyjwA+v3vniutfr
         mv8wtIR/njXeHbzbuF/8dxax4XhavCZI4pU+VQz5EJQWnSxEo2jfgdY+kcTMVBcmvexA
         dd6SgACFUzWfydygLk0wWxVmTcM3uSiYMjWR1aIpV5BoCjdRjQDYm5wgUHbHY/GK78No
         CiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567731; x=1707172531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLRsyiBLlG1o/uwlyldd0juZuNiwvnE4YR1zXRqyT+w=;
        b=dUi1C75YV59GxtTNO5GxdCIwbykRYI6d3PxtVjTYPjVlSZxJV4478sTxOS09oPTD4W
         F+tJfZFQKTO7YCSRaiL1/X29Yn0xmJUE7oZS5Di3ADCoPtIsPDwj0TOxuRzKPwFnwBac
         HMEEkWtkgmKU01JRJZqbKVbTQWmc/OEhOpcOVzeuiXmUujOYx4a4PsHPZmbtj26xw9+C
         CbHF3fPSO6awAUDqSyAcvpoYz0YDgfyLyPWkC51Rx9HB7yuQ7CkbWXL7tB0iE7nt3LLg
         L8vwaOQSfkuu1Yn4lw4Z9BdohsGmMLY50p2KRsFw8RRmoZUc0fVgUO//elic/9NDAdMG
         lAzg==
X-Gm-Message-State: AOJu0YzlFVEgIm59XFzyLeZPXvDqJvfz3hdfuiOBsP/1OFcvDiTzvaKG
	BbCgYwTfASM7w72FtgkjzAx7qwmkIqxNW/o0l6zSRzDgxL7WxxEjfgsfC2h9P+E=
X-Google-Smtp-Source: AGHT+IGTz9LEWhX0dX3SS/wuQaV5Jr6/xP6h8h41ftyAq3MUnlT5aqD8ZRaNstpm/25mwUVjKTbydA==
X-Received: by 2002:a05:600c:4ecb:b0:40e:4f81:3f68 with SMTP id g11-20020a05600c4ecb00b0040e4f813f68mr6042883wmq.16.1706567731452;
        Mon, 29 Jan 2024 14:35:31 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:31 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 10/13] tools/net/ynl: Add support for nested structs
Date: Mon, 29 Jan 2024 22:34:55 +0000
Message-ID: <20240129223458.52046-11-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240129223458.52046-1-donald.hunter@gmail.com>
References: <20240129223458.52046-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it possible for struct definitions to reference other struct
definitions ofr binary members. For example, the tbf qdisc uses this
struct definition for its parms attribute:

  -
    name: tc-tbf-qopt
    type: struct
    members:
      -
        name: rate
        type: binary
        struct: tc-ratespec
      -
        name: peakrate
        type: binary
        struct: tc-ratespec
      -
        name: limit
        type: u32
      -
        name: buffer
        type: u32
      -
        name: mtu
        type: u32

This adds the necessary schema changes and adds nested struct encoding
and decoding to ynl.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 15 ++++++++++++---
 tools/net/ynl/lib/nlspec.py            |  2 ++
 tools/net/ynl/lib/ynl.py               | 26 ++++++++++++++++++++------
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 04b92f1a5cd6..ac4e05415f2f 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -152,14 +152,23 @@ properties:
                   the right formatting mechanism when displaying values of this
                   type.
                 enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+              struct:
+                description: Name of the nested struct type.
+                type: string
             if:
               properties:
                 type:
-                  oneOf:
-                    - const: binary
-                    - const: pad
+                  const: pad
             then:
               required: [ len ]
+            if:
+              properties:
+                type:
+                  const: binary
+            then:
+              oneOf:
+                - required: [ len ]
+                - required: [ struct ]
         # End genetlink-legacy
 
   attribute-sets:
diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 44f13e383e8a..5d197a12ab8d 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -248,6 +248,7 @@ class SpecStructMember(SpecElement):
         len         integer, optional byte length of binary types
         display_hint  string, hint to help choose format specifier
                       when displaying the value
+        struct      string, name of nested struct type
     """
     def __init__(self, family, yaml):
         super().__init__(family, yaml)
@@ -256,6 +257,7 @@ class SpecStructMember(SpecElement):
         self.enum = yaml.get('enum')
         self.len = yaml.get('len')
         self.display_hint = yaml.get('display-hint')
+        self.struct = yaml.get('struct')
 
 
 class SpecStruct(SpecElement):
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 2b0ca61deaf8..0f4193cc2e3b 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -674,7 +674,10 @@ class YnlFamily(SpecFamily):
             size = 0
             for m in members:
                 if m.type in ['pad', 'binary']:
-                    size += m.len
+                    if m.struct:
+                        size += self._struct_size(m.struct)
+                    else:
+                        size += m.len
                 else:
                     format = NlAttr.get_format(m.type, m.byte_order)
                     size += format.size
@@ -691,8 +694,14 @@ class YnlFamily(SpecFamily):
             if m.type == 'pad':
                 offset += m.len
             elif m.type == 'binary':
-                value = data[offset : offset + m.len]
-                offset += m.len
+                if m.struct:
+                    len = self._struct_size(m.struct)
+                    value = self._decode_struct(data[offset : offset + len],
+                                                m.struct)
+                    offset += len
+                else:
+                    value = data[offset : offset + m.len]
+                    offset += m.len
             else:
                 format = NlAttr.get_format(m.type, m.byte_order)
                 [ value ] = format.unpack_from(data, offset)
@@ -713,10 +722,15 @@ class YnlFamily(SpecFamily):
             if m.type == 'pad':
                 attr_payload += bytearray(m.len)
             elif m.type == 'binary':
-                if value is None:
-                    attr_payload += bytearray(m.len)
+                if m.struct:
+                    if value is None:
+                        value = dict()
+                    attr_payload += self._encode_struct(m.struct, value)
                 else:
-                    attr_payload += bytes.fromhex(value)
+                    if value is None:
+                        attr_payload += bytearray(m.len)
+                    else:
+                        attr_payload += bytes.fromhex(value)
             else:
                 if value is None:
                     value = 0
-- 
2.42.0


