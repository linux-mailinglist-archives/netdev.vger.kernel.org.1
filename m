Return-Path: <netdev+bounces-71192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E9385298D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FA81C23584
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB9514296;
	Tue, 13 Feb 2024 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="I3VMu9ez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E31754E
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807890; cv=none; b=oPN7fKUkJJqVgx2heT8A3q40gWi2Q65V86gqcM7r4E5Y3Cvczk7zuBA2xvG/3zHXTr8pxrvf5j6e6HLcNm/f9C2380AT6a/aHB8k0ARZGgwlhOB7k5rWeeXNXUyx+cVxdDRjblwA5NAvjmqijCwNnq7FB52e0kSy390ch1AYs0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807890; c=relaxed/simple;
	bh=rmFrhK655RfR/TcXixh671p4kYSvJ2aEaaZNIGghdrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ad4/EgXq4xp/vWvWr6z69MUfTrJuAiDCcuvj9h2KzFbGmpys1eKZ1SFUQans1Tk6LJafJ0MpxZL9m03BiH/JRIr9nV2c1UBNgOKD6kOQl7kkUiAXJKDMgLg9Zsmev1fC7kiN4EDFFva2AnkSYUbNGihwKPwymSQs+9/+FcEkEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=I3VMu9ez; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-337d05b8942so3341302f8f.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 23:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707807885; x=1708412685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/Jdd3kihKdgWslTtwYbywut02NauK3mmlbVWG3nsP4=;
        b=I3VMu9ezt6zN2OaGwsftD+2+cbki18V/JSkBdeFmnVOTKlDtguVWYBVAkWzvCcF9nW
         8Uq2ns8GcbJOO/oBJqMees3AlUyVmgRMq8YfM0bPCnDMjXXsCGgIsHD03l4TVSYSRCP2
         ysQlVNrIEJQrdInOqC01dEKfFOYCPvX4aWeT7l7wMJxWbBMIvuv7hTBo6zgeceyHIxD1
         Lcsvo/NkEJko2osYHa80l4/0mC552LXYEzx5iT9r78Eurarhg1idu1yzFpAX/1SiIy2J
         j1+4A1Fks5hGaZeBKEKV5QiU5+mGDZ8oQUL98qUnOqakGa0PRiUgzRCSOmrIdMd5oCeu
         wKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707807885; x=1708412685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/Jdd3kihKdgWslTtwYbywut02NauK3mmlbVWG3nsP4=;
        b=nkdTEQIbraZP6CTxS+O5EYEeDf7IXhEEyL9aHMku3m0cTsvYk120J1Iz1cOEwlRBYV
         l3eItKASECZirfIw+mcQCnrkIGQtGJakt4U8YnNoIPrR6J/d4+XGwIxpeY1YAvqKAHrB
         yko6cdkUl/P1+1I64Xr1w0HvLe2wQdXMaNaYqUqFMCqBowMyWvs7BD8AdjNOq+26QgGs
         V4BXrm+GtbzLXPS4nFBvmuZr8iDtIx9h7W1Wtghl8WZePNfEQgcd27Wwca7GvhJiI5kP
         Q0z7GR3qeDkqpY7Xe24pbXEfW9LvVXDIYSEeLCVcouN63pvpTsN3R1X4/LcUZO7+xH0z
         X6qQ==
X-Gm-Message-State: AOJu0Yyye45zBzK0tdXZ0MzbaovUFnbzn0yEubYA5KnqUVS1XZJJ+vke
	VVOiyBc26/oDUqxQ3cq+W9Ptu2KR0Ar8FYDaO0/DEhbywBcn6bIz2QEnXCXxFwMi/VlrwppWB3I
	jhA8=
X-Google-Smtp-Source: AGHT+IFb9FaMGALzTVa5/4n3SPKYX3UajkbBrsErXeiTJ6FGQm0XTJH2E79Lp48rMqSYD30REyJ8eA==
X-Received: by 2002:adf:e68a:0:b0:33b:433d:e1d7 with SMTP id r10-20020adfe68a000000b0033b433de1d7mr6583148wrm.1.1707807884894;
        Mon, 12 Feb 2024 23:04:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0YrZqxHb5pSoNi99HVdqRNtxw4Y4QDjxcyaLHW6cpKFnK4Pv2PhJnnHxIfe5FaW+OyVgD4Qu+mXwl5Nz+CdIs1ai8FWE4aCdc0tvIbZ8pnsuGTvidE1H5Pfx1zFtcOezk6tmLHfQcyRN7wLYccaNStUGfmhsnzKkIg+HQNNwW/dB22TpYyhaFAuvwnvQFO8isofKo4y0=
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id ck13-20020a5d5e8d000000b0033b684d6d5csm8861313wrb.20.2024.02.12.23.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 23:04:44 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	donald.hunter@gmail.com
Subject: [patch net-next] tools: ynl: fix attr_space variable to exist even if processing unknown attribute
Date: Tue, 13 Feb 2024 08:04:43 +0100
Message-ID: <20240213070443.442910-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

If message contains unknown attribute and user passes
"--process-unknown" command line option, _decode() gets called with space
arg set to None. In that case, attr_space variable is not initialized
used which leads to following trace:

Traceback (most recent call last):
  File "./tools/net/ynl/cli.py", line 77, in <module>
    main()
  File "./tools/net/ynl/cli.py", line 68, in main
    reply = ynl.dump(args.dump, attrs)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "tools/net/ynl/lib/ynl.py", line 909, in dump
    return self._op(method, vals, [], dump=True)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "tools/net/ynl/lib/ynl.py", line 894, in _op
    rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "tools/net/ynl/lib/ynl.py", line 639, in _decode
    self._rsp_add(rsp, attr_name, None, self._decode_unknown(attr))
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "tools/net/ynl/lib/ynl.py", line 569, in _decode_unknown
    return self._decode(NlAttrs(attr.raw), None)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "tools/net/ynl/lib/ynl.py", line 630, in _decode
    search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
                              ^^^^^^^^^^
UnboundLocalError: cannot access local variable 'attr_space' where it is not associated with a value

Fix this by setting attr_space to None in case space is arg None.

Fixes: bf8b832374fb ("tools/net/ynl: Support sub-messages in nested attribute spaces")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/lib/ynl.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 03c7ca6aaae9..b16d24b7e288 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -588,10 +588,12 @@ class YnlFamily(SpecFamily):
         return decoded
 
     def _decode(self, attrs, space, outer_attrs = None):
+        rsp = dict()
         if space:
             attr_space = self.attr_sets[space]
-        rsp = dict()
-        search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
+            search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
+        else:
+            search_attrs = None
 
         for attr in attrs:
             try:
-- 
2.43.0


