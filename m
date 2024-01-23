Return-Path: <netdev+bounces-65109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252C0839444
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2077CB2850A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0F961670;
	Tue, 23 Jan 2024 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvVbxmeJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0369566B21;
	Tue, 23 Jan 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025963; cv=none; b=oXVqzBNvuQ6BJ/x4JvFZwI8MS4gJLsAgcPQcY3hxcICXCJsVx4ZSN2+zTbgKAhEoIWL4KEq0Jrj2kOTA7Zx83JtZ0W5XLB4Tb9P+vaZusGf+cF5Hp5rOibpNQGOZJU9/h2EU2zRgoBVKxjyVp8VXbx22lxFmT4mVjhytlXykRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025963; c=relaxed/simple;
	bh=7gK+Q7PJqTYLD8G3xf+tj76K/kc5XxyHzKCT6s9ZmQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfcFDdCT3HL8QnYfB8q2wsGwaFcRc8vv0DO5g0dJFXt67/bGvCH3RN1R7/kdwN2+nIjtBTftKqAhcfSuc82UQfuZFWg7rD9JT/oReu5RBTkqo1B1ycpP25tDejwhqyoVGcp2gIqIcIjis+VPu6Tg/I/35Az+oCCIyhYtfHWkhH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvVbxmeJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3392b15ca41so1866708f8f.0;
        Tue, 23 Jan 2024 08:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025959; x=1706630759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hfxc9N8ws6M4r8t8UAKHptiCOpz6LlWHgmCSp34OYJM=;
        b=HvVbxmeJf/+KDPZ64nP8T498rrKCD1NAK/4ZBQzthbQVz1ujYKO+JKUHWpST4STglF
         gdqcun/PiTT4fGgVVSKt9zZUzqt33/ypabdk7VocVzMQsd2N/21zdUi7cHBCWQJ9Jx7c
         byZHYK5QGCfIp/7OaGkgTve40toiCTbHmyjM21HZCoW7E9DtZUGGbYVZ5gD3rzEyuSLD
         RQITUhioLjSmdxxmfnNCJU2cYUQ5NfmyY7kj8doCbuYqCwQBsWnArT3/cMmZl4m+0BUw
         nhUu05KVokY5iGvTLl7odK25IkZJpIBilCiGpFIMCZETKUNUJcSUBjw6UhZbriSzCCJU
         1BCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025959; x=1706630759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hfxc9N8ws6M4r8t8UAKHptiCOpz6LlWHgmCSp34OYJM=;
        b=RBNQPf3dmA3i/EdQ0eRhCzq57WlXgwky5+IWCxaFJzsoX3x/G9gSbjIpYGA8lruLrq
         2GAI4w9RDfhk2+vwaonk5lo3qyJyBlfbpsN1oxDERilWVJM+bLD5RryHzNcltdrRTfH9
         ghpToznH9Uo0MJAiW2ghLWIarBa58HVjGTPL+OhZHNDcNu/12smYoGsZTiy+g5yVHBGI
         R80oqIZblAGO6dtSrUOpyyCI1VdkJYk7L3KYsko9pPiPJY9eygjxxXPAxSHeW36rsRlQ
         gebPsjfiHLCnxG4nuzjUBbygCaT0+Fr41xbPtLdjAPK4UZiOcwHJvU0X1NCf5zImwtrw
         M2gA==
X-Gm-Message-State: AOJu0YxdZTxdb4RBi2eAd9QhXhkpzET8F274kUcHHEzgn2nfi+cnNyu5
	pce45b7WlldTuVrEuWqL3g+qiD/KzUQrrTxa7xXqo45Nib25WsyjKOl2bLYiPgTZ2e1E
X-Google-Smtp-Source: AGHT+IFU5Cmk/msFDcYNznpmjs29Z7xryMf7P5aWPMPLowlDeWvOjMni6wiSycnoD9BGT91xgQNBkg==
X-Received: by 2002:adf:a119:0:b0:337:c3ef:8c8d with SMTP id o25-20020adfa119000000b00337c3ef8c8dmr3240326wro.40.1706025959027;
        Tue, 23 Jan 2024 08:05:59 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:05:57 -0800 (PST)
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
Subject: [PATCH net-next v1 07/12] tools/net/ynl: Rename _fixed_header_size() to _struct_size()
Date: Tue, 23 Jan 2024 16:05:33 +0000
Message-ID: <20240123160538.172-8-donald.hunter@gmail.com>
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

Refactor the _fixed_header_size() method to be _struct_size() so that
naming is consistent with _encode_struct() and _decode_struct().

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index cc1106cbe8a6..f040c8a2a575 100644
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
 
@@ -567,7 +567,7 @@ class YnlFamily(SpecFamily):
         offset = 0
         if msg_format.fixed_header:
             decoded.update(self._decode_struct(attr.raw, msg_format.fixed_header));
-            offset = self._fixed_header_size(msg_format.fixed_header)
+            offset = self._struct_size(msg_format.fixed_header)
         if msg_format.attr_set:
             if msg_format.attr_set in self.attr_sets:
                 subdict = self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set)
@@ -656,18 +656,18 @@ class YnlFamily(SpecFamily):
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


