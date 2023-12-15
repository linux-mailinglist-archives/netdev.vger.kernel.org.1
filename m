Return-Path: <netdev+bounces-57826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F881449F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490D91F210A7
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF318B06;
	Fri, 15 Dec 2023 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7+QfI2E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034610787;
	Fri, 15 Dec 2023 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c68c1990dso5312905e9.0;
        Fri, 15 Dec 2023 01:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633053; x=1703237853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxXuARXpUOTWn+Jd0eqJGLDuAdQmEtyPzHOk05QV36U=;
        b=C7+QfI2E1N/RzR7fGQdJs/R2rqWxRpk/gJZmlPzzgKjZkLt3AXRacFKpraqxa1BQ9k
         iE9PfT/+siEt4VKN1UO3GrzIbNUI70oFZz8Scdj4JcqGmuA3+hztYHzEo+M3MIAmdAjs
         a3cYxZj+gviAWjfFumWSsQWvJx6QrbL1za4orxveaG9FPURoqXsO9oM1oymucgut5EQP
         BYxh7G7VE6Asz7jZEd7xI/RpQfZcFtK2cyuipmO/5TYySdozAnXkYdrs7HdbMjA476J0
         Km7QpW8QqUYHQrRO5zNV5Upv19mexy2StAjFScgD9oZiSo8XpbmFXfVloT/TH5k5WhQ0
         uI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633053; x=1703237853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxXuARXpUOTWn+Jd0eqJGLDuAdQmEtyPzHOk05QV36U=;
        b=OQWktilKmBkaa8fm0EatTSV3vvYst3oaLYaKRAnTNZnhxnE3cUuViKKJPMmn+OTEKp
         2jBqnE1cF0YFJdtbZ2F6SXsgDOSeCtxLi2QCSjWERbyTAS92vDDNf3B3iC7OurbxGAz7
         oMgF9ZclWrknqwZI3pnkz/S/vzFiuavHfforcoQpkCkCb/bSepWOpOtPwIkmfYwLwGW0
         qqWzzVrdjZWc4lrJKC7HcJRGFXE2u5jilkmRL8FzphA5/3/HQF3nYEkvq/iQQF+Ct1r4
         9O7P0S2PuvN1gJW1hE+wxW9fkoZrIDS1S6y1sYUbrQ4sXypUleKfvjqPwDnBKweqSJAT
         o8Gg==
X-Gm-Message-State: AOJu0YxDcAD74kGP2x2PJR0f3E0HCxjDakp3B4hEdoeZA5j2kBrC4/2z
	FtvLEEJactoK9qRqU5uz9BqK3CN7nd9N/w==
X-Google-Smtp-Source: AGHT+IGRTrr9Q66kXjCBgUw65c9PyhWXFI3Yr+E3/1Md+PUrWXFc+IjCkceqzxU2tkCfrRiq/k6YZg==
X-Received: by 2002:a1c:6a0a:0:b0:40c:240b:f839 with SMTP id f10-20020a1c6a0a000000b0040c240bf839mr3855645wmc.166.1702633053199;
        Fri, 15 Dec 2023 01:37:33 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:32 -0800 (PST)
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
Subject: [PATCH net-next v5 01/13] tools/net/ynl: Use consistent array index expression formatting
Date: Fri, 15 Dec 2023 09:37:08 +0000
Message-ID: <20231215093720.18774-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215093720.18774-1-donald.hunter@gmail.com>
References: <20231215093720.18774-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use expression formatting that conforms to the python style guide.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


