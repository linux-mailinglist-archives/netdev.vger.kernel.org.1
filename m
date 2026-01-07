Return-Path: <netdev+bounces-247700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C78CFDA67
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2777D30D1595
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CF9316184;
	Wed,  7 Jan 2026 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbd1RHUq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20A314D37
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788533; cv=none; b=V5MLDRRujdwbX9nZ7Y2ZCZjt5Z+852SoOxhxwhO7AHl3Pefl3/b4Q/VAOHGS4173Wfljt/90wnA/zuLTEojK5b9ecIzXYLIgRoPjFuilddC+p7iUNCxNRjlGeMRjw7FmZASD3yU0/WdG8g7ZiG+1lTqFC1wbvwwl/DKpshSxdaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788533; c=relaxed/simple;
	bh=3CiuJ9GUNB8dHXwYaiEw9pTUZWAu5nwh20o/SFV5c2M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVJZDagu/nKUvPXTEulNYn6LiQoGhtnOLAieg6zkVcFpdZQZM7Q7DXKMbGlOmwubnNyUUin4gvHJc+VwM2pRzYDPXTLZ7lIKDvx4a06AnxSLKUjdWXUGeUg19yPqiLsLSNkyNqwPOsnKqlZZCb2hthxD1vRGzrjXNodRmlVwEiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbd1RHUq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-430f57cd471so1026648f8f.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788530; x=1768393330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDEXlpAjXWmF8DqaMuG3FZG7sNZbQ7rzz4RGJ32dXeU=;
        b=Vbd1RHUqWOefRp4Nld77jMm3NsnvaX+g2+fplpZWy/y+XeKxR0N0IVtyhWzBOBKqPx
         29aOZiKkF3fPg9WQXEkQLhAJWDHYxDSJ0WIhOga4dt+J4onJ0hVX3DpkwrllAe2v9AnT
         3X5HjKmpB2jxyY3sSOx6sS8eryB53bgdUKD9GymJjmMst2tXd2ct1sKlkqbLN2K5jCwb
         hfUGslrXevAcX9F2f/WJ5tjn9SlJcSLWW3CvECZueBM69tlbIbVZdFppI4JWBc4Bj8/q
         iDsrtiXBWGTvAnZllEqX4nIjouFrpmsm8XaJXcc8XbPnlIsGMW2JsSzTPR9Z594me3FP
         iIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788530; x=1768393330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sDEXlpAjXWmF8DqaMuG3FZG7sNZbQ7rzz4RGJ32dXeU=;
        b=bAVoQj53tZqO34iB4/nxVNPDAnD176de/dhCEH402qWCbmmsZB+266i3jfb9xzeCin
         jn5GB5kaRp+4vE3zMp22O3p3rjQwAYRo5R7MVeatzMbXnUaXpwVoujL051TXccO1k54F
         sdxDL748YWcXLCyLTxuODin+I/IDQqHY0zMhPtu7uHXGmO/iF3KExiW9CWA0p57rFMd7
         XynPjRuxZA32+ENFSnbUUMyuDT9hQyLtjv0iS0T4s7MhUeNoCp7T32lTfNniJ/9ml02G
         6gAjTnHKsKSuj647bp48JAjedRCfoyh1lG8sNK4iuvg7W9TZfTrA7v45izY6FNhjEdR3
         YuFg==
X-Forwarded-Encrypted: i=1; AJvYcCW+o3vWatPU60/Hkfs+hohhlBmgbFncsJa0XTLxZ+5YcIVub1Ot6EowOZGWiQrnPn/fGIFnXus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ywoc+liWruLJPTAEFIjA3iNcEwWvXFtod9rGUmymeiyFOOt1
	+s+9GhRxO1H/AqGs1aQeSr7sCwd4VzVlDiB45M9W5xS26PFWIG20e3DT
X-Gm-Gg: AY/fxX5nctbkph05f438jstgHWF99jbEkTb24UK61Kjvujfe0Krc5Ytof7mMYHPzRFr
	aZMvKefgGT7E5UQtc0A+Gn6MeV7Uo85/0Rh+cy2prHnKfdf2aLsPtiPShWf3yCvT83Ezc2IxuC8
	JWdN1jQ5FLOIv/4BUPkgNJCFKS1i43aFz4wYHkSe2TDB50j6s2Lrs/nJmffSKexPR6ZfVhXFN3B
	Od6kWs8eWrzm5JPjSYZ5j0gfyX1J7d76HoGHdoMnUdGYxUdY8PPXkHsWowxAYnh0/j3ixTp9PbU
	dZVFNKTLUrzka1JyAlphLX0FxsK9ceHghzkarI1ayWYgC6rPQH5bVFFm7ssNsjbMKbkgXcIfAy8
	BSJZMfHcT1bwPp4hdPwWEymgeVPSdrhE7JqQFeDw52Bu8EMtXNPu/a+mpdTs2j9qccVW9aqo85E
	jDgk9HKSpQtPNngrsnzE/QOpDllc2b
X-Google-Smtp-Source: AGHT+IGRnzL62245dTo+sps7KvmZ9F7isQ7MnPn/pLoGbW3g06d0gN5VN7/bSVntp703dmpTeDeSHw==
X-Received: by 2002:a05:6000:288b:b0:431:16d:63d7 with SMTP id ffacd0b85a97d-432c37615a2mr2896263f8f.47.1767788529639;
        Wed, 07 Jan 2026 04:22:09 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:09 -0800 (PST)
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
Subject: [PATCH net-next v1 06/13] tools: ynl: fix pylint global variable related warnings
Date: Wed,  7 Jan 2026 12:21:36 +0000
Message-ID: <20260107122143.93810-7-donald.hunter@gmail.com>
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

Refactor to avoid using global variables to fix the following pylint
issues:

- invalid-name
- global-statement
- global-variable-not-assigned

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/nlspec.py | 16 +++++++---------
 tools/net/ynl/pyynl/lib/ynl.py    | 24 ++++++++++--------------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index f3173146b64b..5cc10e654ed6 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -13,10 +13,6 @@ import os
 import yaml as pyyaml
 
 
-# To be loaded dynamically as needed
-jsonschema = None
-
-
 class SpecException(Exception):
     """Netlink spec exception.
     """
@@ -439,6 +435,10 @@ class SpecFamily(SpecElement):
         mcast_groups  dict of all multicast groups (index by name)
         kernel_family   dict of kernel family attributes
     """
+
+    # To be loaded dynamically as needed
+    jsonschema = None
+
     def __init__(self, spec_path, schema_path=None, exclude_ops=None):
         with open(spec_path, "r", encoding='utf-8') as stream:
             prefix = '# SPDX-License-Identifier: '
@@ -463,15 +463,13 @@ class SpecFamily(SpecElement):
         if schema_path is None:
             schema_path = os.path.dirname(os.path.dirname(spec_path)) + f'/{self.proto}.yaml'
         if schema_path:
-            global jsonschema
-
             with open(schema_path, "r", encoding='utf-8') as stream:
                 schema = pyyaml.safe_load(stream)
 
-            if jsonschema is None:
-                jsonschema = importlib.import_module("jsonschema")
+            if self.jsonschema is None:
+                self.jsonschema = importlib.import_module("jsonschema")
 
-            jsonschema.validate(self.yaml, schema)
+            self.jsonschema.validate(self.yaml, schema)
 
         self.attr_sets = collections.OrderedDict()
         self.sub_msgs = collections.OrderedDict()
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 2ad954f885f3..0b7dd2a3c76d 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -320,9 +320,6 @@ class NlMsgs:
         yield from self.msgs
 
 
-genl_family_name_to_id = None
-
-
 def _genl_msg(nl_type, nl_flags, genl_cmd, genl_version, seq=None):
     # we prepend length in _genl_msg_finalize()
     if seq is None:
@@ -338,6 +335,8 @@ def _genl_msg_finalize(msg):
 
 # pylint: disable=too-many-nested-blocks
 def _genl_load_families():
+    genl_family_name_to_id = {}
+
     with socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, Netlink.NETLINK_GENERIC) as sock:
         sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_CAP_ACK, 1)
 
@@ -348,18 +347,14 @@ def _genl_load_families():
 
         sock.send(msg, 0)
 
-        global genl_family_name_to_id
-        genl_family_name_to_id = dict()
-
         while True:
             reply = sock.recv(128 * 1024)
             nms = NlMsgs(reply)
             for nl_msg in nms:
                 if nl_msg.error:
-                    print("Netlink error:", nl_msg.error)
-                    return
+                    raise YnlException(f"Netlink error: {nl_msg.error}")
                 if nl_msg.done:
-                    return
+                    return genl_family_name_to_id
 
                 gm = GenlMsg(nl_msg)
                 fam = {}
@@ -439,15 +434,16 @@ class NetlinkProtocol:
 
 
 class GenlProtocol(NetlinkProtocol):
+    genl_family_name_to_id = None
+
     def __init__(self, family_name):
         super().__init__(family_name, Netlink.NETLINK_GENERIC)
 
-        global genl_family_name_to_id
-        if genl_family_name_to_id is None:
-            _genl_load_families()
+        if self.genl_family_name_to_id is None:
+            self.genl_family_name_to_id = _genl_load_families()
 
-        self.genl_family = genl_family_name_to_id[family_name]
-        self.family_id = genl_family_name_to_id[family_name]['id']
+        self.genl_family = self.genl_family_name_to_id[family_name]
+        self.family_id = self.genl_family_name_to_id[family_name]['id']
 
     def message(self, flags, command, version, seq=None):
         nlmsg = self._message(self.family_id, flags, seq)
-- 
2.52.0


