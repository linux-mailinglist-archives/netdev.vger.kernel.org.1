Return-Path: <netdev+bounces-30309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB82786DB6
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F8A1C20CF5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13766100C1;
	Thu, 24 Aug 2023 11:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B310966
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:20:25 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38C419B3;
	Thu, 24 Aug 2023 04:20:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fee769fd53so46231275e9.1;
        Thu, 24 Aug 2023 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692876021; x=1693480821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeOioWQbqu83Tsvvw7lSdRkXGk4CEXA20oNSkobpGlo=;
        b=gQiAqhcEyDPLomsMQQriZQ1l0Coxk2CvtQvZg5590+VoWiyK5ollT714vKPx4+e8id
         rn4OXWQUBY0mEjjsZBpQipIcueevB6c1roYyNmgCXxkXY1tkl1K2+U0nreze0678Kxm6
         fMlgmQW20xhsB/ClKH6wQoxOcsjT6JXmtqbLYmgg5GzzRuPhEduwQ9LtuNTUNLwO9u/j
         25N+AbhdFV4NNIG8J+ezLbZTFiwfSo4DepXzAgdj2jtTZj+Q66IZzUtSRph45hA5uskN
         GVrOGdRsv7MEa3JEJiz2DNmZgoVaGLdhYxfKXew2tjNhd7XGsj2Mb1uby4TpOyzXg4lq
         7s4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876021; x=1693480821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeOioWQbqu83Tsvvw7lSdRkXGk4CEXA20oNSkobpGlo=;
        b=a0qVrlKEC4RHORqjf4+a6KAc4AraX1ryMuR/wAGDFGmKY40PUbzgqteWIHLHmoAUPk
         W1bT+maDD0LG9furgtXU9y7pE5j2HR6g/Yn9gD0OhdJFvWYwbA6gyp00awtO9iDqLU9C
         ISEPBTch2/w1WSU2OgnPjXyeDQcjlgl8UXVlGux5HkB4RA96hQ9ShxjDgprhmJVYUKQf
         NMOX81oxSFVou7v6fQ7E0TyEk9rZDaPyxZKtLqDuM3lZ+9n990okERt9/nNK4s5lDXb6
         JQLDDWUTFct0qnHHqwSNQ4cuktXs75r+CpNEfUa1u+23gRj2uqzDiKwys3biEdPtaGws
         Ndzg==
X-Gm-Message-State: AOJu0YzTgOmZ6JfJyfOxqt0AMxDyT5M1FtZoqdb0W5vt2c/P5jNFZTzi
	1YXsS2FhckFzmNMjgvrUN5rYvQh1jZ9k1g==
X-Google-Smtp-Source: AGHT+IFT9viTQGZfSCa2lc1BmKh/+O6Tw3CHex9hWU4YutSgY9OO8Yvva5+/DCQijJ6QVWKzl52nbQ==
X-Received: by 2002:a5d:595f:0:b0:317:5b32:b2c3 with SMTP id e31-20020a5d595f000000b003175b32b2c3mr11926390wri.6.1692876021562;
        Thu, 24 Aug 2023 04:20:21 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d630e000000b0031980783d78sm21875295wru.54.2023.08.24.04.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:20:21 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v5 06/12] tools/net/ynl: Fix extack parsing with fixed header genlmsg
Date: Thu, 24 Aug 2023 12:19:57 +0100
Message-ID: <20230824112003.52939-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824112003.52939-1-donald.hunter@gmail.com>
References: <20230824112003.52939-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move decode_fixed_header into YnlFamily and add a _fixed_header_size
method to allow extack decoding to skip the fixed header.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 tools/net/ynl/lib/ynl.py | 65 ++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 6951bcc7efdc..1d1bc712456e 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -293,7 +293,7 @@ def _genl_load_families():
 
                 gm = GenlMsg(nl_msg)
                 fam = dict()
-                for attr in gm.raw_attrs:
+                for attr in NlAttrs(gm.raw):
                     if attr.type == Netlink.CTRL_ATTR_FAMILY_ID:
                         fam['id'] = attr.as_scalar('u16')
                     elif attr.type == Netlink.CTRL_ATTR_FAMILY_NAME:
@@ -317,23 +317,10 @@ def _genl_load_families():
 
 
 class GenlMsg:
-    def __init__(self, nl_msg, fixed_header_members=[]):
+    def __init__(self, nl_msg):
         self.nl = nl_msg
-
-        self.hdr = nl_msg.raw[0:4]
-        offset = 4
-
-        self.genl_cmd, self.genl_version, _ = struct.unpack("BBH", self.hdr)
-
-        self.fixed_header_attrs = dict()
-        for m in fixed_header_members:
-            format = NlAttr.get_format(m.type, m.byte_order)
-            decoded = format.unpack_from(nl_msg.raw, offset)
-            offset += format.size
-            self.fixed_header_attrs[m.name] = decoded[0]
-
-        self.raw = nl_msg.raw[offset:]
-        self.raw_attrs = NlAttrs(self.raw)
+        self.genl_cmd, self.genl_version, _ = struct.unpack_from("BBH", nl_msg.raw, 0)
+        self.raw = nl_msg.raw[4:]
 
     def __repr__(self):
         msg = repr(self.nl)
@@ -509,17 +496,44 @@ class YnlFamily(SpecFamily):
 
         return None
 
-    def _decode_extack(self, request, attr_space, extack):
+    def _decode_extack(self, request, op, extack):
         if 'bad-attr-offs' not in extack:
             return
 
-        genl_req = GenlMsg(NlMsg(request, 0, attr_space=attr_space))
-        path = self._decode_extack_path(genl_req.raw_attrs, attr_space,
-                                        20, extack['bad-attr-offs'])
+        genl_req = GenlMsg(NlMsg(request, 0, op.attr_set))
+        fixed_header_size = self._fixed_header_size(op)
+        offset = 20 + fixed_header_size
+        path = self._decode_extack_path(NlAttrs(genl_req.raw[fixed_header_size:]),
+                                        op.attr_set, offset,
+                                        extack['bad-attr-offs'])
         if path:
             del extack['bad-attr-offs']
             extack['bad-attr'] = path
 
+    def _fixed_header_size(self, op):
+        if op.fixed_header:
+            fixed_header_members = self.consts[op.fixed_header].members
+            size = 0
+            for m in fixed_header_members:
+                format = NlAttr.get_format(m.type, m.byte_order)
+                size += format.size
+            return size
+        else:
+            return 0
+
+    def _decode_fixed_header(self, msg, name):
+        fixed_header_members = self.consts[name].members
+        fixed_header_attrs = dict()
+        offset = 0
+        for m in fixed_header_members:
+            format = NlAttr.get_format(m.type, m.byte_order)
+            [ value ] = format.unpack_from(msg.raw, offset)
+            offset += format.size
+            if m.enum:
+                value = self._decode_enum(value, m)
+            fixed_header_attrs[m.name] = value
+        return fixed_header_attrs
+
     def handle_ntf(self, nl_msg, genl_msg):
         msg = dict()
         if self.include_raw:
@@ -594,7 +608,7 @@ class YnlFamily(SpecFamily):
             nms = NlMsgs(reply, attr_space=op.attr_set)
             for nl_msg in nms:
                 if nl_msg.extack:
-                    self._decode_extack(msg, op.attr_set, nl_msg.extack)
+                    self._decode_extack(msg, op, nl_msg.extack)
 
                 if nl_msg.error:
                     raise NlError(nl_msg)
@@ -605,7 +619,7 @@ class YnlFamily(SpecFamily):
                     done = True
                     break
 
-                gm = GenlMsg(nl_msg, fixed_header_members)
+                gm = GenlMsg(nl_msg)
                 # Check if this is a reply to our request
                 if nl_msg.nl_seq != req_seq or gm.genl_cmd != op.rsp_value:
                     if gm.genl_cmd in self.async_msg_ids:
@@ -615,8 +629,9 @@ class YnlFamily(SpecFamily):
                         print('Unexpected message: ' + repr(gm))
                         continue
 
-                rsp_msg = self._decode(gm.raw_attrs, op.attr_set.name)
-                rsp_msg.update(gm.fixed_header_attrs)
+                rsp_msg = self._decode(NlAttrs(gm.raw), op.attr_set.name)
+                if op.fixed_header:
+                    rsp_msg.update(self._decode_fixed_header(gm, op.fixed_header))
                 rsp.append(rsp_msg)
 
         if not rsp:
-- 
2.39.2 (Apple Git-143)


