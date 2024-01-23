Return-Path: <netdev+bounces-65111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B5839442
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D37D1F2AB79
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E4E6A336;
	Tue, 23 Jan 2024 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd+clmEk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4C66B35;
	Tue, 23 Jan 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025967; cv=none; b=GraBB6Ah2pREV7sdRqX9sex44onJ60dHaPYrxVFWfkVfci45F3NxOl3/rsBt5J/+vUDKzxUG0kXdFTmAXiDaHA650w0xZ1N52//JwoW8cMtWM6Lu5bo2YII7zlbMd7UlDxuhuYgL2j0bNi9niE1j6EShK4O1iStkYeso1Nl0NGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025967; c=relaxed/simple;
	bh=0bTLvkXDxr5VVuJAW5EXhbjgNPIt/0wSadxHQ9aB7qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucGxXSpdhDHpXxC6Owx2T1+tSp6aWu6IdVCtNBxat7Dx0NHTfWHf0ufTumUkf/1gMq7nZLiAhKpSwRI7mXekQMJxsX6Q18CiZEKPvt3aWSoR4cIkBmLMe5676EIGyzXliPdalAJvdvLBf5c4YksLGjVhoE62O2LqSPRfk021v5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd+clmEk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33937dd1b43so1585267f8f.3;
        Tue, 23 Jan 2024 08:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025963; x=1706630763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOml7HfM1hqqj4E7N3j4rQCmumlp/z9U0ns2sKtNDRo=;
        b=Xd+clmEkfMDnE+yJik9jDY5ZzhD4gAC/mvCZGaHl1QNfvRXoRJh78JnqES6zor9c82
         CBlBeNbGJalDXqoryrb21shPVdQAkqouAFaREmnW2kAMzea40Dxx21mN4iqG9/owLXEz
         Fp2PaqrETPOvpwy9Qrd8uLFFLihUfY6pF9RJ2ErEeV2j3hw39NVDUvfj5cJASMBSc3CX
         JSKHG7WGRyofmtsSJGWmy+zFJoNF/pNcSHllIdgGOUI2DCZaCEl87eg4Zm/isNlMrHuL
         bUZ1O8Rm0I0wD9qNs+aPWHvR3Xek9c8MZa3UETHE/S7xXC2p98vaj6dxXG6+zxP2BPRa
         4LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025963; x=1706630763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOml7HfM1hqqj4E7N3j4rQCmumlp/z9U0ns2sKtNDRo=;
        b=S664m7XQFeh5Ywu4vVVA3Fulrd2xK25cQQdd7S6n5j5PrsnawH1wZqa2qdJFMS0XVp
         uhtiXcvsftR+2v1PLMN3B33DYBeHlw3g8SXJIOeFpgsGc9B46SEDWgN/osPk4maL9d+I
         YrBm4T+d3WefVF9roJ0SCCEuhkJjE42weOy43lta03E2rkGY6THVPVUMLIMv8uNdxVyZ
         nTpR10adjPvoncUWIvrg1kPIhQp9dhjM3Xbw8hr29ED0fnf9r5dtYupuzzeNA6Ki6qK3
         m8M+uhhZ3xpCb7adi4Jhs/3YFZM+xM8pCiyyAVh/1VXOrLF/FrTp0H4ooQYYSrAh+psu
         5jew==
X-Gm-Message-State: AOJu0YxckDkgLZCNHLKnHkoFyZ9P1Cc+hRBkFKkeJAEOv1wmel/k8MqT
	qVT5az/0ugQejEMJ9KeX6Vx/PbwobK3wPbpzLyhzsN7dU5ayxld8U2jQjWowLfQGVzGH
X-Google-Smtp-Source: AGHT+IGrtFgaNVl/QyUpfZ1V2i+C88GPGgNv/mMOiOzPPKDl2/ngg2GLfdTBZGxbFmzKMwmGPDhBcA==
X-Received: by 2002:a5d:5f53:0:b0:337:bc8e:2ae4 with SMTP id cm19-20020a5d5f53000000b00337bc8e2ae4mr4366164wrb.130.1706025963598;
        Tue, 23 Jan 2024 08:06:03 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:06:02 -0800 (PST)
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
Subject: [PATCH net-next v1 09/12] tools/net/ynl: Add support for nested structs
Date: Tue, 23 Jan 2024 16:05:35 +0000
Message-ID: <20240123160538.172-10-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240123160538.172-1-donald.hunter@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
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
index c9c5b1fcc6f4..dff2c042e6c3 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -655,7 +655,10 @@ class YnlFamily(SpecFamily):
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
@@ -672,8 +675,14 @@ class YnlFamily(SpecFamily):
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
@@ -694,10 +703,15 @@ class YnlFamily(SpecFamily):
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


