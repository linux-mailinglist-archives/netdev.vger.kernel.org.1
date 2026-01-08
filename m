Return-Path: <netdev+bounces-248153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAEFD046EE
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECA1931C7579
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBF2D1F44;
	Thu,  8 Jan 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFG85hcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF8623645D
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888845; cv=none; b=eSiaizTPwpti591ti7Lgp7/kLT1SCGZ96Kamu+MKvdWlqGydzP/KPxDmvkfAHb/lvBmgt3Bts1y5cquKXx+M4+pUFJovTctuNeLyAcQqm6I0huvR5JN6Dup0U2XQVPaqpSfVvrrrjYq3iJxmF/noxV7AGcapXG/OL8zPI7LJI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888845; c=relaxed/simple;
	bh=MXYNv6GPQptH7ep7PcaH1dwnT3kfqeJgECIDbMJzJlk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H43GyVVDEXmBrvja/JyLs/nsqpAV/Vp2o6GA7e0YrktRAxDeMRtiehPZv0G09kuppELKAvwf5PK0vA06Bvor24b9MMnuTVsr2gAZpcrXKfuQgrZmm6TrhI6daYKqWQGDaoDXFU3aNg/SXZV2hnrpY1Fw30xBVWExhfNyqak9I0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFG85hcM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so1853551f8f.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767888842; x=1768493642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLL5UIxh5PUk40HwyUo69Fp+sMd2y28+0jBjp5B54vc=;
        b=fFG85hcMIXeRxak/NFVga78PpI136jpAhbd0O8aB0c2611wP4ugGnZNzBBUuiTW7JO
         fIThs9ZlHTmNJpOnTiKJCFKlBCYCF++Gp1YJ8WPp4mm9WNTJFbfJKz5nMGylF63e5esi
         dGE9bkKq8o+8Is5dw/J4a6gCWh3la39WHqr+pnGKmgXf2JV2EgSaVm4UOG7H+PlC1TT6
         BPU3Pzk/AHRvrEs0BDHob0I8Hmy53furPm1yOwYlGQugtlhDco7TfVp4q6aGdX/6yykz
         GIw/HS64IyzUFg5AynwT4FJaNvmJTBU7Kip8lHn7is0EMiluIfBwVtZcdZFKi5UMooW1
         sd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767888842; x=1768493642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CLL5UIxh5PUk40HwyUo69Fp+sMd2y28+0jBjp5B54vc=;
        b=j0sgIHbfn9nrqyOCXcx2RVDLpBERQmz4fbbVrT/wZxOTP5XHdVh5PBjhYbfhrqsySQ
         7+dFFIv5NSwRJ7GcZ+4T8xVTeQw3euoaPopt2KcgPwclAtvd9z60W/mM6vgTG6q5P5/T
         SImPu36Lfx0lIpZc86OThrpRHp76dwPyHRHQCVHH+JLrhDmBu41iGDCEkosxwiv+1Qge
         F0LcF88f4+F6DJQji+Ojs93futlW16+vbqJXDspEohZZRJ3BDXpZTaRlxYF7fZ0yfv2G
         ZMaeC2rRJ5SbPIWmVa20itJeodzfp9oqaVhevBVXp6kmNHud50A9eKKLHt3LByv+C55+
         2yBg==
X-Forwarded-Encrypted: i=1; AJvYcCUZvSqNm3tXEE4BBxEpxtRfT1RD7xpUwwJIuVm9sCW74TFsarv2opNb/sNm/CMZZ8cWm5eZLss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ//lM/Bgu7Cj0aixqHFgAyUYZZ1zPYrAeFPDXCa9qmM0wa8ZF
	M5i0GKvWgc5Y8FvtwEa5cP1clIwFRCebu4nkNo5VUVGLjyGaWbDbhSvc
X-Gm-Gg: AY/fxX4gaamBji3anh9xVIcFNsltUVGgfrSYahLI7XqIQ5TXiMofAuqYRZtzzDF9mIz
	MQcuTp8ZlyUh5NXEWVuVRi6gK2FCzDFsXQyxrwQT7BDmvIpNVWRsFhB6UMg2FgBvH6UewjSHhUf
	F9HEVgSXzTUVa9sn7CO6dikPruTIle0m3ydQTEKHWRFTQOUsw++MVLtzLwaAX76Ysu0MqeiV+ng
	QA2K/H5cb0kEFMpxdeti5jlE8wnHY1gtkphGVrgqSjYs7BH/0Iw/UoqTmM4Qrs8emouUjtA6FSl
	CnLV+i+V0v1yg40vNSJZ1Elm833EZ7Q0F8+JZ6nrqkalStJhlniGPBU/7fJUgkUWb7yQrux+GKx
	G4SCrgE8xtaTlH3CnDvTI562cB5keCzajWFN/rWSSjD4FZHmNfM0yJV77vrrQP8IFeg/MeMbslC
	iAXObq/fba3Tg/epWfbAzhRXQ5SJ7g
X-Google-Smtp-Source: AGHT+IFSR7OrZGmAkbuK3KTFbwypOtsBS5UWM2Z8CLQAaFKU04q9Y3Yb9pryEJYGXxFcRkgvtLImQw==
X-Received: by 2002:a05:6000:401f:b0:42f:8816:a509 with SMTP id ffacd0b85a97d-432c3779246mr8266484f8f.62.1767888841499;
        Thu, 08 Jan 2026 08:14:01 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm17140039f8f.29.2026.01.08.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:13:59 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ruben Wauters <rubenru09@aol.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 04/13] tools: ynl: fix pylint dict, indentation, long lines, uninitialised
Date: Thu,  8 Jan 2026 16:13:30 +0000
Message-ID: <20260108161339.29166-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108161339.29166-1-donald.hunter@gmail.com>
References: <20260108161339.29166-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix pylint warnings for:

- use-dict-literal
- bad-indentation
- line-too-long
- possibly-used-before-assignment

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/nlspec.py | 19 ++++++++--------
 tools/net/ynl/pyynl/lib/ynl.py    | 37 ++++++++++++++++---------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index a35f827f09e3..fcd4106d0cfa 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -129,8 +129,8 @@ class SpecEnumSet(SpecElement):
 
         prev_entry = None
         value_start = self.yaml.get('value-start', 0)
-        self.entries = dict()
-        self.entries_by_val = dict()
+        self.entries = {}
+        self.entries_by_val = {}
         for entry in self.yaml['entries']:
             e = self.new_entry(entry, prev_entry, value_start)
             self.entries[e.name] = e
@@ -451,6 +451,7 @@ class SpecFamily(SpecElement):
             stream.seek(0)
             spec = pyyaml.safe_load(stream)
 
+        self.fixed_header = None
         self._resolution_list = []
 
         super().__init__(self, spec)
@@ -579,13 +580,13 @@ class SpecFamily(SpecElement):
             self.msgs[op.name] = op
 
     def find_operation(self, name):
-      """
-      For a given operation name, find and return operation spec.
-      """
-      for op in self.yaml['operations']['list']:
-        if name == op['name']:
-          return op
-      return None
+        """
+        For a given operation name, find and return operation spec.
+        """
+        for op in self.yaml['operations']['list']:
+            if name == op['name']:
+                return op
+        return None
 
     def resolve(self):
         self.resolve_up(super())
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 6e39618e5598..040ff3b87c17 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -235,7 +235,7 @@ class NlMsg:
 
         self.extack = None
         if self.nl_flags & Netlink.NLM_F_ACK_TLVS and extack_off:
-            self.extack = dict()
+            self.extack = {}
             extack_attrs = NlAttrs(self.raw[extack_off:])
             for extack in extack_attrs:
                 if extack.type == Netlink.NLMSGERR_ATTR_MSG:
@@ -296,7 +296,8 @@ class NlMsg:
         return self.nl_type
 
     def __repr__(self):
-        msg = f"nl_len = {self.nl_len} ({len(self.raw)}) nl_flags = 0x{self.nl_flags:x} nl_type = {self.nl_type}"
+        msg = (f"nl_len = {self.nl_len} ({len(self.raw)}) "
+               f"nl_flags = 0x{self.nl_flags:x} nl_type = {self.nl_type}")
         if self.error:
             msg += '\n\terror: ' + str(self.error)
         if self.extack:
@@ -361,7 +362,7 @@ def _genl_load_families():
                     return
 
                 gm = GenlMsg(nl_msg)
-                fam = dict()
+                fam = {}
                 for attr in NlAttrs(gm.raw):
                     if attr.type == Netlink.CTRL_ATTR_FAMILY_ID:
                         fam['id'] = attr.as_scalar('u16')
@@ -370,7 +371,7 @@ def _genl_load_families():
                     elif attr.type == Netlink.CTRL_ATTR_MAXATTR:
                         fam['maxattr'] = attr.as_scalar('u32')
                     elif attr.type == Netlink.CTRL_ATTR_MCAST_GROUPS:
-                        fam['mcast'] = dict()
+                        fam['mcast'] = {}
                         for entry in NlAttrs(attr.raw):
                             mcast_name = None
                             mcast_id = None
@@ -390,6 +391,7 @@ class GenlMsg:
         self.nl = nl_msg
         self.genl_cmd, self.genl_version, _ = struct.unpack_from("BBH", nl_msg.raw, 0)
         self.raw = nl_msg.raw[4:]
+        self.raw_attrs = []
 
     def cmd(self):
         return self.genl_cmd
@@ -560,8 +562,7 @@ class YnlFamily(SpecFamily):
             for single_value in value:
                 scalar += enum.entries[single_value].user_value(as_flags = True)
             return scalar
-        else:
-            return enum.entries[value].user_value()
+        return enum.entries[value].user_value()
 
     def _get_scalar(self, attr_spec, value):
         try:
@@ -750,8 +751,7 @@ class YnlFamily(SpecFamily):
     def _decode_unknown(self, attr):
         if attr.is_nest:
             return self._decode(NlAttrs(attr.raw), None)
-        else:
-            return attr.as_bin()
+        return attr.as_bin()
 
     def _rsp_add(self, rsp, name, is_multi, decoded):
         if is_multi is None:
@@ -800,7 +800,8 @@ class YnlFamily(SpecFamily):
 
     # pylint: disable=too-many-statements
     def _decode(self, attrs, space, outer_attrs = None):
-        rsp = dict()
+        rsp = {}
+        search_attrs = {}
         if space:
             attr_space = self.attr_sets[space]
             search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
@@ -818,7 +819,9 @@ class YnlFamily(SpecFamily):
 
             try:
                 if attr_spec["type"] == 'nest':
-                    subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'], search_attrs)
+                    subdict = self._decode(NlAttrs(attr.raw),
+                                           attr_spec['nested-attributes'],
+                                           search_attrs)
                     decoded = subdict
                 elif attr_spec["type"] == 'string':
                     decoded = attr.as_strz()
@@ -927,12 +930,11 @@ class YnlFamily(SpecFamily):
                     format_ = NlAttr.get_format(m.type, m.byte_order)
                     size += format_.size
             return size
-        else:
-            return 0
+        return 0
 
     def _decode_struct(self, data, name):
         members = self.consts[name].members
-        attrs = dict()
+        attrs = {}
         offset = 0
         for m in members:
             value = None
@@ -969,7 +971,7 @@ class YnlFamily(SpecFamily):
             elif m.type == 'binary':
                 if m.struct:
                     if value is None:
-                        value = dict()
+                        value = {}
                     attr_payload += self._encode_struct(m.struct, value)
                 else:
                     if value is None:
@@ -1026,7 +1028,7 @@ class YnlFamily(SpecFamily):
         return raw
 
     def handle_ntf(self, decoded):
-        msg = dict()
+        msg = {}
         if self.include_raw:
             msg['raw'] = decoded
         op = self.rsp_by_value[decoded.cmd()]
@@ -1166,9 +1168,8 @@ class YnlFamily(SpecFamily):
                     if decoded.cmd() in self.async_msg_ids:
                         self.handle_ntf(decoded)
                         continue
-                    else:
-                        print('Unexpected message: ' + repr(decoded))
-                        continue
+                    print('Unexpected message: ' + repr(decoded))
+                    continue
 
                 rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
                 if op.fixed_header:
-- 
2.52.0


