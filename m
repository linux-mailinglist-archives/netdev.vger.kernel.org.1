Return-Path: <netdev+bounces-57101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332EB8121F1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0DA1F217A5
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D0481854;
	Wed, 13 Dec 2023 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFeMBhUp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4791984;
	Wed, 13 Dec 2023 14:42:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c2718a768so73409655e9.0;
        Wed, 13 Dec 2023 14:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507319; x=1703112119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbhqH38QY9mINP6O9YwXefvYMAhzZwOMci15LQjG1rg=;
        b=jFeMBhUpIXMQlmoP9xU+y9V3zefTsvfAMBD7gCzcN/+dT8QTmiroRh6eDDVsbF7OFd
         tznAdywQLFpJe2F4rpk5SEeF7T2t7lbvIJsD8OqmSwiM7sEq/sEn8Nr2/uZtWe+VjLQR
         89w13VXbeXfwlBilQNQsY8uRWeBc99A6URtLpHXltZ7hTD2dD6r2ASQ0OZPMD0f/T6oi
         adjbbvuzVVS2AT+WesLsC5Ol2tJrrFZm6lMReQ6BECTIpQtr/42Vwmil+mK1ppV1lHFY
         jI1P3Uosbifr3U24P4hJHUVrVO7jdQ1yZFJuJ6ggBDmRpgJC/Y3RB6m3YxDZngE3V+qL
         zwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507319; x=1703112119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbhqH38QY9mINP6O9YwXefvYMAhzZwOMci15LQjG1rg=;
        b=DC8JRm3hDvk7WGmnCHayREUZd29Ph2BtbEQwgdejt4qW7NU9TTUQSeCHmiX5B6miV2
         QAYeTdP42iSWu6y+Jyhri6n53oYZfChMlpuUkiuQ/m21uvytd3iySgt78/gh65hOccTM
         jt9Y7kTN5hx/8a4bgSH7bVnU1TqDwmQdqZRnCOZwiOZgO6eLjng/ZqllX98856yD/Ir5
         2uCbuhwVmXX1uhOb40JzbScZDvHqMi9dVJfEPZgE2N/uUAbq8lCwxMLwGSj3l1gPhflz
         WMQBE7QBzko5/T1qqNJjxtVQTWuPdF3Rh98D1nfstXYmVGPGhp142VfZDVCWd/RzVA1U
         lu4w==
X-Gm-Message-State: AOJu0YzHCZMfj+Mk/WVv6I64aYLjF27ealMDtAUhfYFCH4OUVzdhHNuL
	lP7pS58dwmK12w0W8hDPm3BoJyZvbXmfvQ==
X-Google-Smtp-Source: AGHT+IF6qv3lCeRwjzVciuUD0gtgZgqGF2O+++su3zaBSt6Wx9ZUXhBc54aE9pefbYnRgu7o5OfzwQ==
X-Received: by 2002:a05:600c:4e4a:b0:40c:3555:e22c with SMTP id e10-20020a05600c4e4a00b0040c3555e22cmr5029199wmq.23.1702507318908;
        Wed, 13 Dec 2023 14:41:58 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:41:57 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v4 01/13] tools/net/ynl: Use consistent array index expression formatting
Date: Wed, 13 Dec 2023 22:41:34 +0000
Message-ID: <20231213224146.94560-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213224146.94560-1-donald.hunter@gmail.com>
References: <20231213224146.94560-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use expression formatting that conforms to the python style guide.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


