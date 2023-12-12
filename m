Return-Path: <netdev+bounces-56617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79480FA02
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 531A3B20FA9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B264CF0;
	Tue, 12 Dec 2023 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db0PflJF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C380AC;
	Tue, 12 Dec 2023 14:16:29 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33635d11dabso765243f8f.0;
        Tue, 12 Dec 2023 14:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419387; x=1703024187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbhqH38QY9mINP6O9YwXefvYMAhzZwOMci15LQjG1rg=;
        b=Db0PflJFmu7tXAzX7jIMeHwzDHWM47XKUrXeZ1XJ2iMg1M4P2+ybYtwYZ7SVOvKJtO
         iPRUj8/nZ/oJRk6vML3XSVWz7fcmrCFhcwT90sbXm/8AtnFEaO4y0g9f/yPUXhfuSchs
         7ZxXNZpcfCCX2S3t1IsIrMrsoM5BbVEx6QS8AdM3/l7bw9AfPBpW4dO5ZeG0OE3Ahq51
         sDpAFF29o+IV8QF0SsfM/0cbblaYCxb1JZJvvgT9gHEh9Rj5Y15bF9NRr2azgz057lgO
         MAO/PttDZ9rgLVSNMaRxrrU4g/bvq1O8PruOD+uqqNCO/yrqV0uZ37vEYFcud0JGFxex
         7p1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419387; x=1703024187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbhqH38QY9mINP6O9YwXefvYMAhzZwOMci15LQjG1rg=;
        b=MHcDAkCynVID54puzQNTq9AP4QesqeqQqx5qBUi0IScYqNLOdu2HpAYXeiVtaUs0Ru
         PHUu/U3FeWdQk7YWK+5WJBCWpPj5tRHX36Nd5UUonx9MkRyjXvlW8NDk9WRuv/KQUu3d
         jinyG/4ueUkRv1vdpZIX+SzRZqXfy5bABTTUWKj08bI6WUeyKJB/Siho8/kEGsBekpRC
         R3zXcUkPNZuaS7GglQii8qFw2XvfOkiuykJZubz5/YiCfTrgc/3FY9M7acnjO8tOxbWV
         Vp3CdL7WSqoMUWRLQhYmTZ3cHymQ8LnUpT2w+h27grCV6/FVhQ4pOOAdRqDm54cdCuPn
         j63Q==
X-Gm-Message-State: AOJu0Yy0wF150zgCaslVaUorClP00YA5oe0Advadapx1n4HyK+qGLcd/
	DXNiHcEpnpKQCwebY2Eo7G+HzYD0nK5w/w==
X-Google-Smtp-Source: AGHT+IFbO1X7Vi2zj0MWvDwh40WYBzhZW5BWyHowiZh1+AvC0Ch1JXfkQZKnfV+yut1T+ZNEmVPVtA==
X-Received: by 2002:adf:e10f:0:b0:333:533d:9ce1 with SMTP id t15-20020adfe10f000000b00333533d9ce1mr3638722wrz.82.1702419387340;
        Tue, 12 Dec 2023 14:16:27 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm11680482wrt.22.2023.12.12.14.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:26 -0800 (PST)
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
Subject: [PATCH net-next v3 01/13] tools/net/ynl: Use consistent array index expression formatting
Date: Tue, 12 Dec 2023 22:15:40 +0000
Message-ID: <20231212221552.3622-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212221552.3622-1-donald.hunter@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
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


