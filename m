Return-Path: <netdev+bounces-247698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEACCFD9DA
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75E9C30049EA
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC4E314B83;
	Wed,  7 Jan 2026 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVtCgKua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0F315777
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788530; cv=none; b=UuHBMEKoJPW/peDX9CdhQD5EGmqaAA6JCmNRyGRIfr0FmkqP9FG3Q8rIkYvDoN1FlxJXFiCLy+LO55xOwnpsT+atTmgxq7X2erpFbBa0uP4K/bobwVsPSQL3CFUsXP3r2y9qypubx3Nav0TSDkKGFmznnZtyspMUnMn/vNSy3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788530; c=relaxed/simple;
	bh=BMp6R4x1yIsciJRSPhZ8xRmkNrnq7fV56uk3oOpAhqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOmkPyHSRPhJtlS/aMeHFEnXeEL7uHKrHDBeeBko0hwZGoP4H1UKwuu0frJYmYFVQuppxQ8Ci99K9HFetAlmxm2UMKXzx1n0tOqRs8chfeCzZhxTFWooAfF2mweSuN9ehFWe22sh5GrNVfbeS5nZTYKnFwmrBl+u6LGXhospjqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVtCgKua; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so17878075e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788527; x=1768393327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dTgTxaTPd//UAS/F9LGVNxcZlGVoOqdp8LxvbQ2uH8=;
        b=IVtCgKuaOp/2bYnAjFTR5p6lzukNEpoWIv4tk3YnyA0tR2l2Hj81Cm1yLlg22eNZNw
         Vi/cmg4PN5PVQ5jIFLAW0qfQn3SHb+VPFd7JIQPf4UKh6pBPEZo2AWDynm3UU6elHzPm
         ckaU47xvMS1UFe9KdvlY7CDXysdNuYkxu8Rlh91SuhItv8SF2e93IuWJTO4u6GU5LN1t
         Nt+3yJ45DksCVlEVCCZ9u6gYFVruPcEPSARqmCB/nkex8MZ9C9ypmnq14wbO5sIeO2jp
         bw3EECimTosYkDki7un7wRnJXis+c1nHeiwFGWMs3EbIS1jgcIeDKUKOtA4SVQa2UGiq
         YXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788527; x=1768393327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4dTgTxaTPd//UAS/F9LGVNxcZlGVoOqdp8LxvbQ2uH8=;
        b=VN+KO0tvWfbYXjzfp+y7vp24YZwuJY0Q1yodLMZxTn/lTuCC/DJysscClvvP/npFcY
         bE1KBiStMoKT5SkLKuSwHwCHTttZz/O0IoaxMPDYRvNz/HPT/FzbLNuma9QsJ+sVJFJd
         r+6bmKAjlM0agLGNzBgFGZHGllM5Z++HjRecTAVHHrkxoF2CLvtOihnpLKQZGYqQEKFr
         RCqwDQm807Y0LvsrQU3zsuiVxjWGLiIVku6CjNxL6LqhJSfGiByVTupUv7MwIEZoS9Qp
         3bMWr6Uu9Mxm49Xhv7/w3zs8by8h4FthzZlg2vbetOgDEFLqgfq4iQQt/mA0wqGslIm8
         FYdA==
X-Forwarded-Encrypted: i=1; AJvYcCWcdL1t2Na9aWcYPjqsZXJ5g59a6dkyTTxD3fb/xeNA3XiGLdeD1aqqZ+GJ6HwmWKq8U6/PGMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEY0q3ehjs6inSrxCLnmaIxDOpLTouhKrNYfyH8INZZ74jSe4n
	5VFNESjb/BohTosM/WKDYKkrHKDycUPs4odqvDJS8XhLrmeFqi21mQOJ
X-Gm-Gg: AY/fxX5iKIYTGMWZH5469LrvqygL4jGdQO/V2V9U8//Jk1vTSPbH8i93cc05x0nWb2R
	WfU1AHx17MNfhfyO9mIJn+PYONHCqx/NBSR28Lah9Amcz3dnpL7aYVQf/mYaPDqeO58jiDSqHF9
	T3g45WsdZtmWjbfwAZTFXAmp49G44tjCn0Hq7fmMSjJG9WUlXp/OH+D95u/QGEJlkyaBPNl4cfW
	XCwm7exHDkfoeZA23fHXj86GNZHYVlOs8D6CFhT4I66XFXE6i2evOzlu4JuBnOCKln3T5DGN/Gm
	jpEBz7OWJrYPX2Rmagl5x8e0rqCsHaPobEn7fwIEYKUU2kGLKkF4tCWPK6hao2mYjwCmpi2J0EB
	SK+y/VQcGgulZt7yaSmZytTvEe3vvIxEL11++/fsXqIf0ZodYjbW5EDD9ps1029AxDotc2BO4nL
	aY8CVt8ozUHF50RHv4vwM5vWwlCMPM
X-Google-Smtp-Source: AGHT+IEbABye2MIlV5/Nz6/mQ2Fyrkc/prgg2DQjPPn4BaCCy8n6CAuxLaJe3G7R/odxBnZC9et8SA==
X-Received: by 2002:a05:600c:8b0c:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-47d84b18a9fmr23413085e9.5.1767788527025;
        Wed, 07 Jan 2026 04:22:07 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:06 -0800 (PST)
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
Subject: [PATCH net-next v1 04/13] tools: ynl: fix pylint dict, indentation, long lines, uninitialised
Date: Wed,  7 Jan 2026 12:21:34 +0000
Message-ID: <20260107122143.93810-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107122143.93810-1-donald.hunter@gmail.com>
References: <20260107122143.93810-1-donald.hunter@gmail.com>
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
index 97229330c6c9..49c35568ceba 100644
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


