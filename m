Return-Path: <netdev+bounces-74782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE1862C64
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 18:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01467B20C1E
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4901E1B597;
	Sun, 25 Feb 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMMQ0/kS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8577117BD6
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883193; cv=none; b=g2gg+wEnYqN3Iruwx7yDCV+5QiMKMmFNkrVBsZr45MJaAyiyqq/+Upqf87FVreaniOyqmnlfj7GlAL7H3eRNvSvHg+9BOzDfjggmPNcyfcbbQMBdqZscGqCUplSztXHFzENQJsZmpO7Bc84B7O/uwg6AmBEUKQq5+D1M7grdqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883193; c=relaxed/simple;
	bh=PX2GNCYHv6n1KXDu2ZDfzrozQFX7aIfSNoRfyRiEyIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmAKXK71v8bruoMoKYl/MB9VKfebfjpFDDDzv0waNFEJw6jc+ovIDOJFvX51MKW3gSrvVc8mq4MhjMXI0XWSpMFBaRQgs14w6L7c1LXVnvc4gGeHBUDEY+CW2aNY0CRCeae3+YrJ0dfftkF/nrWM3W5+E5JZRLd3W0bAV+lanLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMMQ0/kS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d220e39907so40641411fa.1
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708883189; x=1709487989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow9Dqjj2Vt2O9LPzJjX4mqagWHoEa67N0WCC5IIwegE=;
        b=dMMQ0/kSzPTFCIA2LPRKtoYDrDL2PbIpqUcR212xduNWt3bj9vKi7rJOuFMfF/W6kC
         S7+k2duqP+cAUI7bFs7ZnD8PVx1Twuw0Af50DuMPbMuUwGPOE8EzN84d9k27cxAf2RbD
         GoIPJJn0H4J4uZqkZ/sf+wzoRp4Bex1kRtdh0QxGLCCXZbkOXQt9AngFaEvhLCjJ3nmg
         OGHB6KS8eqFxKMn5JrZV99/R+xIiGoOPmBD99WNdoLQUsa4Ax4RKhCWVLQeks3X9LzaB
         nI8zN9hlD12YNcrKGmuVQ5y4bCC9kFg6NJZIq9xohxm6ji/uyJWVSSlYn4jNDLEDEQmH
         1dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708883189; x=1709487989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow9Dqjj2Vt2O9LPzJjX4mqagWHoEa67N0WCC5IIwegE=;
        b=q0B5mJm9XgMuLgA6b6i+5AxjD7Je1DX5hqyp5vpOS3fQopFJ48vcV7s2OH34UmMdSs
         7SQCAqiwaMUnBX3G+Lcqufy0UHbWiiA4SEz37s3Ua6h2nW4ywR6Dj69tvJgPL/q97MXE
         yzW1q6eygPs9BGm/xvmzA6HS+bKIpKBN82PWLsiKzcvjo6iv/hmq2TFKOZ4NiWVPYpXa
         j0GXmXUCBwFdNr/n9wlVSLW8fBJBwQzwQABbO0PeJLsMBwD3Wv/wMXGMXdsrW19gA0s4
         sugY7HJE6ulz3o4rb3hh7wd2Rwa+4hQwG85VUnE/do1fcfbdcA6b5zNOhd9hUFKvg5QW
         5Lvg==
X-Gm-Message-State: AOJu0Yzg0xaGb1yuenWPGAHrC+OmcZygf2J52aEgquHFB3DE1n2ZI8cn
	PtBZBxadbULPV4cGZazpjQ8xLrhAIZ2tE0KObUHyPRRyASmZkSQUpeHdhXg0YRg=
X-Google-Smtp-Source: AGHT+IHvJIgvwiEzLDJQ0inAadiuNnm1LfFTy3pLlKcf+Wmcytfx3GyWgBA04akAA0UNEvpzWcIKPw==
X-Received: by 2002:a05:651c:331:b0:2d2:4377:e9f3 with SMTP id b17-20020a05651c033100b002d24377e9f3mr2802519ljp.36.1708883188905;
        Sun, 25 Feb 2024 09:46:28 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:907c:51fb:7b4f:c84f])
        by smtp.gmail.com with ESMTPSA id r2-20020adff702000000b0033b60bad2fcsm5558729wrp.113.2024.02.25.09.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:46:28 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [RFC net-next 2/4] tools/net/ynl: Extract message encoding into _encode_message()
Date: Sun, 25 Feb 2024 17:46:17 +0000
Message-ID: <20240225174619.18990-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240225174619.18990-1-donald.hunter@gmail.com>
References: <20240225174619.18990-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the message encoding a separate method so that it can be reused for
encoding batch messages.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index ac55aa5a3083..c6fc9588c235 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -831,6 +831,16 @@ class YnlFamily(SpecFamily):
 
       return op['do']['request']['attributes'].copy()
 
+    def _encode_message(self, op, vals, nl_flags, req_seq):
+        msg = self.nlproto.message(nl_flags, op.req_value, 1, req_seq)
+        if op.fixed_header:
+            msg += self._encode_struct(op.fixed_header, vals)
+        search_attrs = SpaceAttrs(op.attr_set, vals)
+        for name, value in vals.items():
+            msg += self._add_attr(op.attr_set.name, name, value, search_attrs)
+        msg = _genl_msg_finalize(msg)
+        return msg
+
     def _op(self, method, vals, flags=None, dump=False):
         op = self.ops[method]
 
@@ -841,13 +851,7 @@ class YnlFamily(SpecFamily):
             nl_flags |= Netlink.NLM_F_DUMP
 
         req_seq = random.randint(1024, 65535)
-        msg = self.nlproto.message(nl_flags, op.req_value, 1, req_seq)
-        if op.fixed_header:
-            msg += self._encode_struct(op.fixed_header, vals)
-        search_attrs = SpaceAttrs(op.attr_set, vals)
-        for name, value in vals.items():
-            msg += self._add_attr(op.attr_set.name, name, value, search_attrs)
-        msg = _genl_msg_finalize(msg)
+        msg = self._encode_message(op, vals, nl_flags, req_seq)
 
         self.sock.send(msg, 0)
 
-- 
2.42.0


