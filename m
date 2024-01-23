Return-Path: <netdev+bounces-65105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF197839436
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971C21F21DF9
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DB961665;
	Tue, 23 Jan 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKi8/LaU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C163519;
	Tue, 23 Jan 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025955; cv=none; b=fJPbNHCEu74CQnYqj8oTFLDK68+5gAHn93KYKpsoGdvusPgzEpwJp4ya/jsdKrEo/0CZypuWhJfBPtEwy5N//6SffH5tZfh3AbMOcy9XNpcDrlv7+xi3JkJKRLAd9HA5uCgzpKeXY6drafyMHISfDn/jCCbdYqKFoDxyVcsb1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025955; c=relaxed/simple;
	bh=UAyF8X7QSWT7mXbILRIB+tuM8vms7O+Ylss9/Xo4KPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSAiz/447MFWEm9RWJR0Udo24x5yDBdYev7056qRbo6zu6tpYX/gkn7TrnTsj9RkpAcj59pjM7UsBm0mt1u7GWMzykTzNEk5PwS6eAn0LBMGWYwlRZuKoMiZlVZyiS3mNnBvMmIeSBgmx42U7kUhZIoLtr8+9NMOuaG92Ha62rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKi8/LaU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so56936055e9.1;
        Tue, 23 Jan 2024 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025951; x=1706630751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nu3GBbweqqLjVKM1I/MvCjJ4k7t4quChK5YPaJt0ls=;
        b=GKi8/LaUbqn7y6h6VAx7VX51yKm/2vZt9v1qYUlIsIdPP1pELA5S7cmD+Zc3xBc4Uj
         6OV8rigcNkhqZizmApiudsk5q1ZUP9D1pZ6cMBSeQciyvPPIAVFus0GeRc+351EjlukY
         uwLHnZZzUOuoJDDdbTCM1d1OX/h+Kd98kIiQPBxaxSHe8C+S+MNVdLFX5yP1BuYsZCrp
         vp7bV5KtP0jbb8qAL/LMySmdJBvzlJHdRfQSt4qoCkUPRtW0dbBszEFjZmYr3zmZuYUi
         jT7h5srXWwJFpmXAuUq+lZz5QJ+VxJzmGbKT0K3IwL9fiR43NWvCQT2wKbp/dze+BtI1
         b8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025951; x=1706630751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nu3GBbweqqLjVKM1I/MvCjJ4k7t4quChK5YPaJt0ls=;
        b=baDSn6IQliXB6utqpfafEiusS/aztWAJldDxNmgll7dkecCFRg5B7/Cz0KHVWQFbIx
         wwrarW5wSe5Q9eKJZkOIU4oQ9/GKAN4+zXlUP039/Dk5+W/szd4/u+TdM2vraEslxgT7
         gIYLNoE6YUxXsO7R29Bp9sYq7ogDYN9TqV3e8qHX3O1rYjQX4527nfT35Jg6uDdkAwG7
         BuaSmt9g+IKguFS97+M/CVjKDJsU+zMdNAYFusaXb9tLKuWWIwKyn3zs65kLF+pedvei
         jTu3h/Ewe8d3mp5qXL19XPREgDmtAR8fmQk+YJKXxDxPF5t5+KSRkvPAb8KbJ2rYd9hg
         Fbgw==
X-Gm-Message-State: AOJu0Ywptd8w36u0dvQHMCaVWH8qQFKbz2TQc7t/iCLH2Nd9wwwnDYe+
	F3AVv2ecsov47QSWqqg/HCCzCnr48aRb6cs2fGMFtOhDGWc3STMRowfvzjuBObO1riYZ
X-Google-Smtp-Source: AGHT+IHKgu0iJ8YgSFPKKDbtdjE8Pu9GBIuAmpDvtgIr/BpB2CHjl2lOsCZfwxKWdODVkDg3a84npg==
X-Received: by 2002:a05:600c:540b:b0:40e:4800:c91f with SMTP id he11-20020a05600c540b00b0040e4800c91fmr301710wmb.9.1706025950651;
        Tue, 23 Jan 2024 08:05:50 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:05:48 -0800 (PST)
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
Subject: [PATCH net-next v1 03/12] tools/net/ynl: Refactor fixed header encoding into separate method
Date: Tue, 23 Jan 2024 16:05:29 +0000
Message-ID: <20240123160538.172-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240123160538.172-1-donald.hunter@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
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
index b00cde5d29e5..dd54205f866f 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -701,6 +701,20 @@ class YnlFamily(SpecFamily):
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
@@ -760,18 +774,8 @@ class YnlFamily(SpecFamily):
 
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


