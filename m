Return-Path: <netdev+bounces-66891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B3A8415BC
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B93BB23E6D
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128A853E24;
	Mon, 29 Jan 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5ibpr6d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931753802;
	Mon, 29 Jan 2024 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567733; cv=none; b=WVuMDJhQgN9gIzmYKZ9V+17/nu3IY3CMuwveIVjeAETMegFCK6WCc7P+Br4MqM+opn9mrUcJJLcKLzFrgnvLP8v5daFLPiLGvKk/4+rTm9QPcHSASZGUBS1MdbpbMKjYagPmyv5R1AGNXpCsib4tX105k+x8+BfJ3lWWj1YAtoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567733; c=relaxed/simple;
	bh=v7mHrXLQRTCNsbXYMNkSWpZBqQ2SOM37cEmn1Anbty0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI5wjuXP97kzV3R8Jq+fCeJzdav3KzcSjlUCwT5YTZIZsVWPSmhCli4NLfu97vVSd3zBalJ+p2YJ1EKezlpFQU8deeXxOz8L5vxcB+io5K0pTEY5eDad5E9awFHwEWLDwIXqXc9c6imJujcSFVDy19Ugrd51DR7tfgNCqDxuH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5ibpr6d; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33934567777so2685153f8f.1;
        Mon, 29 Jan 2024 14:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567729; x=1707172529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfXnxN6LhrHnAn4S/DiUOKAmUqQTDXqkpo6xUmXayic=;
        b=U5ibpr6dFSjLt2ctg0dkK3IJ+5qNEvPVvQj9qu2E6NPmXKGGyxop02mlUy6PTo8C3a
         FaAySscRofrfZh/Vq1c3PrUBQILksY5aeNofPuH9yBkQoHN+ClbQ1sAOFsGeNOx3epbA
         +U8BhuDWHiiwc7WdmHSvhQOTGEq43qjoECke8G9aSRvtvmsAdU39CosF5GlzgSYmFRPA
         XjBLsV6pT4AsrSSPU8uT0BVq3ZR2W4D73YjuOPfcPxsbTmhFeHhOkEx+p5AWVQGN/LLl
         6sxhmMzn6yhld2BU4j4DqM9yJ1BWQckw5ZTflzXYCqRaUu88m5vKTsXPkWJbWqtDioz3
         g9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567729; x=1707172529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfXnxN6LhrHnAn4S/DiUOKAmUqQTDXqkpo6xUmXayic=;
        b=ZM+E0e4uzwhCQg1os0cnyZDOTJ/2t9xLa6/DO/mwq6iJzI7X169FOiZfzwNb3VmTsL
         soIVj5MeLryF0VpQ/VbwsB9jeDGp5ZR4D0O8WOW/KvMuQkOcn+JJOBXuN72L0qNZgCeN
         Kt9UzvtAooEVnMb/cL75Oy2662pXvwMUPoYjJof2uk3bTxSEIrbuXmElrgZ4IHNrrYEr
         nWgGDYdd08UDGEj+KbWg5lgiUWurwQtX1YwPMtDohkumnziCp1RUC3qWELEvuOJvEqg1
         Y+IjeSKCl7iilDdW0BBaYoZClgncbM30UywP9DkNA5o84BB6Mae+vTg+kA4x8H9Dgi7b
         OASw==
X-Gm-Message-State: AOJu0Yx+CzmojQO+Tdvbn9nlRXM9l7YXVQTTW0SOWcLY8ud5hueni2qb
	Tn3WDEAYB10+QzGMwdhwYIJCsD61nZ60XePCRmF65afpO7ujaswQeBRjKd/mGpM=
X-Google-Smtp-Source: AGHT+IGGZF5jQl3IIWuAsaM2aU2t9r80+mOvCIo7AYjYGPJYMksXZy09TOB84rzzslqknE19i6lktg==
X-Received: by 2002:a5d:49d1:0:b0:33a:e756:bd21 with SMTP id t17-20020a5d49d1000000b0033ae756bd21mr3602846wrs.43.1706567729446;
        Mon, 29 Jan 2024 14:35:29 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:29 -0800 (PST)
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
Subject: [PATCH net-next v2 08/13] tools/net/ynl: Rename _fixed_header_size() to _struct_size()
Date: Mon, 29 Jan 2024 22:34:53 +0000
Message-ID: <20240129223458.52046-9-donald.hunter@gmail.com>
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

Refactor the _fixed_header_size() method to be _struct_size() so that
naming is consistent with _encode_struct() and _decode_struct().

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 0e7e9f60ab7e..173ef4489e38 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -353,7 +353,7 @@ class NetlinkProtocol:
         fixed_header_size = 0
         if ynl:
             op = ynl.rsp_by_value[msg.cmd()]
-            fixed_header_size = ynl._fixed_header_size(op.fixed_header)
+            fixed_header_size = ynl._struct_size(op.fixed_header)
         msg.raw_attrs = NlAttrs(msg.raw, fixed_header_size)
         return msg
 
@@ -585,7 +585,7 @@ class YnlFamily(SpecFamily):
         offset = 0
         if msg_format.fixed_header:
             decoded.update(self._decode_struct(attr.raw, msg_format.fixed_header));
-            offset = self._fixed_header_size(msg_format.fixed_header)
+            offset = self._struct_size(msg_format.fixed_header)
         if msg_format.attr_set:
             if msg_format.attr_set in self.attr_sets:
                 subdict = self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set)
@@ -675,18 +675,18 @@ class YnlFamily(SpecFamily):
             return
 
         msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set))
-        offset = 20 + self._fixed_header_size(op.fixed_header)
+        offset = 20 + self._struct_size(op.fixed_header)
         path = self._decode_extack_path(msg.raw_attrs, op.attr_set, offset,
                                         extack['bad-attr-offs'])
         if path:
             del extack['bad-attr-offs']
             extack['bad-attr'] = path
 
-    def _fixed_header_size(self, name):
+    def _struct_size(self, name):
         if name:
-            fixed_header_members = self.consts[name].members
+            members = self.consts[name].members
             size = 0
-            for m in fixed_header_members:
+            for m in members:
                 if m.type in ['pad', 'binary']:
                     size += m.len
                 else:
-- 
2.42.0


