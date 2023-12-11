Return-Path: <netdev+bounces-55987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF69A80D24D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE001C2142F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC584D124;
	Mon, 11 Dec 2023 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBC4RVZb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4E2A9;
	Mon, 11 Dec 2023 08:41:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c2c5a8150so43495755e9.2;
        Mon, 11 Dec 2023 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312860; x=1702917660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxPQVrrz2Ug5Uynghno+8beeLy8eNboRdzRT1XtNilw=;
        b=NBC4RVZbWqvqsp/wCW0wpp/dZiPKNZW3ajeKCQvIi0tcIaqV8eyCEA1HIEMrCX2XHv
         J4QA9/WzLGme5KRhYd8MtFpVHVu+gthN4S7V089hJPrwXrxa6Suv8P4HHvLQx+xSZtZY
         SVWXW1L1oC9u6u+uV9IKMvHMZ/iByjwXese7e6buVYxhPeYRDYUTps082k6N+P8yxEfE
         koN3CXWniH9Mb3Duy5xwck7v5yoxgHdj1CxZuA35UoFGfGUz3kLjptJQEo9z5iM7HDq1
         7Z5aWyNCX6lrK21S2HeNQmIONOofZqqFej7gO5jOLZwA0F2TjfgHCy0Z1/UY+jbe7zev
         KnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312860; x=1702917660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxPQVrrz2Ug5Uynghno+8beeLy8eNboRdzRT1XtNilw=;
        b=GlG4t4m5/KsqdEfz9Qgi0pb1IcoJgEBz7RvBdlF7BIMq1jMvAG5cBnp6zpv6ikDEGW
         xYoQ4J3o2ucqaHyHdQtBRFHzhzv8QAY0JEj/qU4h304Kw3cNQOBH36E1uDir3XgM7oRl
         62STCk46HeUkUFpgE7Z9Ok988S0hAdkR2mZhjotTDdxIZ7QAp+Bg94HyUddayCy15ZOP
         EEXS3PwxDTfE2P1EvaFhzqiyFguwjVHu/4uoMtxLEpVcmCQTxu5GXw8qIidYIL0I5IbK
         CIkAodb5csKaxO/25geASNjaeqimXZZDjUdvfXhmDE29aFUefHBAvK6O/GVGHXzmdtty
         1eow==
X-Gm-Message-State: AOJu0YxBGMyP3t3s91y040MnqzuPcq+XQ3SM597bBhmEL9Hay+k8feuj
	EYyNJc2AK3QkIyP4Ik8cYZCl4MiIlo+RAQ==
X-Google-Smtp-Source: AGHT+IEYChbqWoiBcVRfIpDVcogC4dQsf+E068hwS50aEw+Hc/x5ULonzwJcwjHyrax4mXKFgNYt/w==
X-Received: by 2002:a05:600c:84ca:b0:40c:3cc0:8616 with SMTP id er10-20020a05600c84ca00b0040c3cc08616mr1932572wmb.73.1702312860135;
        Mon, 11 Dec 2023 08:41:00 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm7418679wmq.26.2023.12.11.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:40:59 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 04/11] tools/net/ynl: Use consistent array index expression formatting
Date: Mon, 11 Dec 2023 16:40:32 +0000
Message-ID: <20231211164039.83034-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211164039.83034-1-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use expression formatting that conforms to the python style guide.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 92995bca14e1..5c48f0c9713c 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -98,12 +98,12 @@ class NlAttr:
     }
 
     def __init__(self, raw, offset):
-        self._len, self._type = struct.unpack("HH", raw[offset:offset + 4])
+        self._len, self._type = struct.unpack("HH", raw[offset : offset + 4])
         self.type = self._type & ~Netlink.NLA_TYPE_MASK
         self.is_nest = self._type & Netlink.NLA_F_NESTED
         self.payload_len = self._len
         self.full_len = (self.payload_len + 3) & ~3
-        self.raw = raw[offset + 4:offset + self.payload_len]
+        self.raw = raw[offset + 4 : offset + self.payload_len]
 
     @classmethod
     def get_format(cls, attr_type, byte_order=None):
@@ -154,7 +154,7 @@ class NlAttr:
         for m in members:
             # TODO: handle non-scalar members
             if m.type == 'binary':
-                decoded = self.raw[offset:offset+m['len']]
+                decoded = self.raw[offset : offset + m['len']]
                 offset += m['len']
             elif m.type in NlAttr.type_formats:
                 format = self.get_format(m.type, m.byte_order)
@@ -193,12 +193,12 @@ class NlAttrs:
 
 class NlMsg:
     def __init__(self, msg, offset, attr_space=None):
-        self.hdr = msg[offset:offset + 16]
+        self.hdr = msg[offset : offset + 16]
 
         self.nl_len, self.nl_type, self.nl_flags, self.nl_seq, self.nl_portid = \
             struct.unpack("IHHII", self.hdr)
 
-        self.raw = msg[offset + 16:offset + self.nl_len]
+        self.raw = msg[offset + 16 : offset + self.nl_len]
 
         self.error = 0
         self.done = 0
-- 
2.42.0


