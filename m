Return-Path: <netdev+bounces-52087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A247FD3B6
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D81E282DD7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143CE1B297;
	Wed, 29 Nov 2023 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hey1Amx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B7D10DD;
	Wed, 29 Nov 2023 02:12:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-332fd81fc8dso2488216f8f.3;
        Wed, 29 Nov 2023 02:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701252760; x=1701857560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkBsTL9nrVjctijvE+YbYrzImc81e4ljZYTKXc6wv0k=;
        b=hey1Amx2+s22hk9Ib0dK1mvL64Wj7QLVrFN/bcmNLa7D9QY2ZluZchdQbJXMnCXAiX
         1Jr4hYKM+KVVC7IItE+N11SGhEGbkyCQsNO6u6K42mTxcE4nsBvdVcCAaFyYjFKHVsFQ
         qV9bLp34PlyZO9O81S6kq8pvAK7atULyt8k7BsMonTXfA5hanIxciAZugIWrEF9oCYx7
         g9doocwwcXu2BBxKRefNkBo5n8xuivM4rMhcFb/OvRqqmtDzwSY6o93CRNVjC3+zzB/d
         dgv8iAvOnsB+sTL14rVezqLoxPIXw28Nq1QGhXICgoQT6NTt8/YDNP73x+o5AJV7PnIk
         2aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252760; x=1701857560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkBsTL9nrVjctijvE+YbYrzImc81e4ljZYTKXc6wv0k=;
        b=j449IG0Hkzsd5jkCjZfXrdlqvU2dgpIITrPcJMJhXXZLd4bX8VxlMvYXoEt5qWJWG1
         V/Cw0nj03RFl9q4SDsFzcuF8gq5AEO2/IukxMRyusWt5bh331pMNc7v1yNRz7aNavIkx
         Z/WgWOFA/91SGaMJ3RlRM+mMpV3pQ54BCrAAZYhiZqO+zYGeyg5FcsoQ6lcBqNynUX+j
         jt1BYupeNB5lAW0oynSFppwOBuxcLDDUk1Rgq8TZWRZG8nVpPe6I3LGOmjhjSpHMHc8d
         JPSaaTlF7svm4UTDCpMS91SOTFWcJQD8WVWX6hdH4NNXQNPrMNYbwEf8rgg5a4pCZQsT
         uyVg==
X-Gm-Message-State: AOJu0YzjrSbnlEO360id986aOSAsZxatICvaamjVCb72jN+kpW856OLy
	UvpyQKIltmOXX5PQdTEqWXKXCo0VYpfzjw==
X-Google-Smtp-Source: AGHT+IED4UjOCVMDV75Pc1W80n94fzjHbzOklqDy8vqSwaspmOB9xfAfwvHqMlAhmFGyB5NUNVXoGQ==
X-Received: by 2002:adf:ee49:0:b0:333:a27:2326 with SMTP id w9-20020adfee49000000b003330a272326mr3736606wro.25.1701252759876;
        Wed, 29 Nov 2023 02:12:39 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:648d:8c5c:f210:5d75])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm17296877wrc.95.2023.11.29.02.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:12:39 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [RFC PATCH net-next v1 6/6] tools/net/ynl: Add optional fixed-header to dynamic nests
Date: Wed, 29 Nov 2023 10:11:59 +0000
Message-ID: <20231129101159.99197-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129101159.99197-1-donald.hunter@gmail.com>
References: <20231129101159.99197-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for an optional fixed-header to dynamic nested attribute
spaces. Several of the tc qdiscs have a binary struct for their
'options' instead of nested attributes. But the 'netem' qdisc has a
struct followed by nlattrs in its 'options'.

If a nest can have an optional fixed-header followed by zero or more
nlattrs then all cases can be supported.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml |  2 ++
 tools/net/ynl/lib/ynl.py               | 24 +++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 62061e180f8f..b5295057dcea 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -292,6 +292,8 @@ properties:
                           description:
                             Name of the sub-space used inside the attribute.
                           type: string
+                        fixed-header:
+                          type: string
                         struct:
                           description:
                             Name of the struct type used for the attribute.
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 5ce01ce37573..86d591cb0047 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -170,10 +170,9 @@ class NlAttr:
 
 
 class NlAttrs:
-    def __init__(self, msg):
+    def __init__(self, msg, offset=0):
         self.attrs = []
 
-        offset = 0
         while offset < len(msg):
             attr = NlAttr(msg, offset)
             offset += attr.full_len
@@ -371,8 +370,8 @@ class NetlinkProtocol:
         fixed_header_size = 0
         if ynl:
             op = ynl.rsp_by_value[msg.cmd()]
-            fixed_header_size = ynl._fixed_header_size(op)
-        msg.raw_attrs = NlAttrs(msg.raw[fixed_header_size:])
+            fixed_header_size = ynl._fixed_header_size(op.fixed_header)
+        msg.raw_attrs = NlAttrs(msg.raw, fixed_header_size)
         return msg
 
     def get_mcast_id(self, mcast_name, mcast_groups):
@@ -571,8 +570,15 @@ class YnlFamily(SpecFamily):
             decoded = self._decode_binary(attr, dyn_spec)
         elif dyn_spec['type'] == 'nest':
             attr_space = dyn_spec['nested-attributes']
+            fixed_header_name = dyn_spec.yaml.get('fixed-header')
             if attr_space in self.attr_sets:
-                decoded = self._decode(NlAttrs(attr.raw), attr_space)
+                decoded = {}
+                offset = 0
+                if fixed_header_name:
+                    decoded.update(self._decode_fixed_header(attr, fixed_header_name));
+                    offset = self._fixed_header_size(fixed_header_name)
+                subdict = self._decode(NlAttrs(attr.raw, offset), attr_space)
+                decoded.update(subdict)
             else:
                 raise Exception(f"Unknown attribute-set '{attr_space}'")
         else:
@@ -658,16 +664,16 @@ class YnlFamily(SpecFamily):
             return
 
         msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set))
-        offset = 20 + self._fixed_header_size(op)
+        offset = 20 + self._fixed_header_size(op.fixed_header)
         path = self._decode_extack_path(msg.raw_attrs, op.attr_set, offset,
                                         extack['bad-attr-offs'])
         if path:
             del extack['bad-attr-offs']
             extack['bad-attr'] = path
 
-    def _fixed_header_size(self, op):
-        if op.fixed_header:
-            fixed_header_members = self.consts[op.fixed_header].members
+    def _fixed_header_size(self, name):
+        if name:
+            fixed_header_members = self.consts[name].members
             size = 0
             for m in fixed_header_members:
                 format = NlAttr.get_format(m.type, m.byte_order)
-- 
2.42.0


