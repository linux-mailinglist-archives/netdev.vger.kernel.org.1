Return-Path: <netdev+bounces-66887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9148415B4
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C9028A4B9
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F07B51C5A;
	Mon, 29 Jan 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSQ/++pb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580285103F;
	Mon, 29 Jan 2024 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567729; cv=none; b=B6vlfpvDd5Hlrp+yDicczWFQAgvtTF8JYI6h/QNFrOyZov4WVPMr/Vp+GxWgnaFA/li+wK5IJaKnqzVunD78u8NLhSPYvA7DqsY0UnTMMbW9ecqAb6keaiRgVR7F8lz0usDVAdtULPGLhzwGZUQz22gRz3QMVcAfrsqJh0ktnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567729; c=relaxed/simple;
	bh=ANtnWEVXI1AV83OlOcvNu9rEOkcP/Did4RzDf3NBz7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZCoEwm8Io9tMKEfQwm1vVgpr+UX9l2QJrBCQR/2/ox7RJT5HK/GmxE3QcLrMoLIke0337gG6CuXL6oiNvEYHhCna5PGtgDB+s7AaxScY8e9jjK9iAjT4kZW2JsSk6pyEpPvZ5z3C/x5kYpvzsa0kRdTthljZNnF5TaUPAncyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSQ/++pb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ef6bbb61fso12706055e9.1;
        Mon, 29 Jan 2024 14:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567725; x=1707172525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JM/gR7NVL2DszlNp4e0M5nRJ+g7WurjZDhv7/vO4M8=;
        b=mSQ/++pblmbRrBilm/tDehiAGGxiZcgyRZ2aapT3oUDGRUh5zVZZihjArO/PKgFBEi
         12MNPcuC1umrPf3HZjbT5WaSL4LM/wdUzDz247CLpQRaYsP7Z5Ic4cMY0cVEEchl3Wx7
         macShYiGQmhPojmwOopL4bNYtOjyhXAwuU9Palh22tG4BVU+GnTbiVBeqC4Lg/YJRRlz
         EqOUltd/cslH13m9G0UejXCJq8PQJ4IFTKRk1k9WzwOaDlHewBgGmlvanKiWlW0gp1Fo
         g3LNtfSjW0QvFHm5gZeHB3VNpjWykPnrKy6loHxPijk4Ui2XgujgNodJ8mTWsB3V4cSu
         nXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567725; x=1707172525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JM/gR7NVL2DszlNp4e0M5nRJ+g7WurjZDhv7/vO4M8=;
        b=CKFZzbYrBdjbypBMUpB9TLUvsKXEgOcY8WYOsUzW6DFZyehzoloB0XITJMEgK7vVHr
         UKGHyNQ9ULw6AtrCJ9W/QjwNldU6llTv46+baKShkF/689PSkgZkEo3Cp9IowYujTSKR
         pxDU23RvIhuWwuEE5pixLkvMhbB7GuxOeC2dzOGrFpzua7wMxUyyZkAlOvxu0S77XlTX
         FHs5veeOrau0oz3bUI6xwmeRf52DXhuMyjG6M97GtsU9FtWLD2Cw5Ac1hZCj8FGiOd+j
         mHiafY+NZqRFi/iN0gioXBWNCYK/nEQ0tAX02yWWaoYZ2mPEaiQwfiSSrjj2Ou8TLDtW
         6wig==
X-Gm-Message-State: AOJu0YwO4+cnBB/p/977T51BPCyjKt8IFxuse54fzq4wWJMmxRQzZWSF
	/WPPo1Vi4QjQIcBh+uwFTE2lgs4CS8dkssZUX5PE176EggRUqm9OWZUyzGASpUA=
X-Google-Smtp-Source: AGHT+IFU+8Qwwv4EGo4YN8morFOH48qe1RGdvIgF1fueHIhQEyQguKULDOk7xYplmwi7bx7csUmuRw==
X-Received: by 2002:a05:600c:4f10:b0:40f:210:e60f with SMTP id l16-20020a05600c4f1000b0040f0210e60fmr75747wmq.18.1706567725185;
        Mon, 29 Jan 2024 14:35:25 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:24 -0800 (PST)
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
Subject: [PATCH net-next v2 04/13] tools/net/ynl: Refactor fixed header encoding into separate method
Date: Mon, 29 Jan 2024 22:34:49 +0000
Message-ID: <20240129223458.52046-5-donald.hunter@gmail.com>
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

Refactor the fixed header encoding into a separate _encode_struct method
so that it can be reused for fixed headers in sub-messages and for
encoding structs.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index f24581759acf..b22ddedb801b 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -720,6 +720,20 @@ class YnlFamily(SpecFamily):
                 fixed_header_attrs[m.name] = value
         return fixed_header_attrs
 
+    def _encode_struct(self, name, vals):
+        members = self.consts[name].members
+        attr_payload = b''
+        for m in members:
+            value = vals.pop(m.name) if m.name in vals else 0
+            if m.type == 'pad':
+                attr_payload += bytearray(m.len)
+            elif m.type == 'binary':
+                attr_payload += bytes.fromhex(value)
+            else:
+                format = NlAttr.get_format(m.type, m.byte_order)
+                attr_payload += format.pack(value)
+        return attr_payload
+
     def handle_ntf(self, decoded):
         msg = dict()
         if self.include_raw:
@@ -779,18 +793,8 @@ class YnlFamily(SpecFamily):
 
         req_seq = random.randint(1024, 65535)
         msg = self.nlproto.message(nl_flags, op.req_value, 1, req_seq)
-        fixed_header_members = []
         if op.fixed_header:
-            fixed_header_members = self.consts[op.fixed_header].members
-            for m in fixed_header_members:
-                value = vals.pop(m.name) if m.name in vals else 0
-                if m.type == 'pad':
-                    msg += bytearray(m.len)
-                elif m.type == 'binary':
-                    msg += bytes.fromhex(value)
-                else:
-                    format = NlAttr.get_format(m.type, m.byte_order)
-                    msg += format.pack(value)
+            msg += self._encode_struct(op.fixed_header, vals)
         for name, value in vals.items():
             msg += self._add_attr(op.attr_set.name, name, value)
         msg = _genl_msg_finalize(msg)
-- 
2.42.0


