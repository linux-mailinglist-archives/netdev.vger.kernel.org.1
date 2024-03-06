Return-Path: <netdev+bounces-78151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505C287437F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B974A1F26C0C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF771CA83;
	Wed,  6 Mar 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNItXwhI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF62D1C6B8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766656; cv=none; b=tScLOqT6tb9exLNckMR4jMEy72GcRHvuYkOS6pWA0EgwuopE/u69GtqfRNIwyjp06LYzd3+VCfg9NHpFtJaZMsgUUfXjlZtJN0PYhdawnOSXI55S7PVna8fM79TOI3wF0/SAPkQ0ssVmNmrhmuYHtBggfYOX5zjMA3gqHXpby0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766656; c=relaxed/simple;
	bh=KFAN5YWY+EsZQAqGMVpjlxXLzkOqIvT+Vuo+PDo+sL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3nAU6OZER4awJ5MlTHAbTfTgLctfJj1/NVgder3JeA9Gfw3GeZFLJ1jwSW1EnPCC2O2L1mWQaKSUd1bgIWusuvIm/etYZuRjhHHonVo2FQXGdybnAB+y/PDQ2JzcvxKCkL/3q4RE28tXa/3KZYcRGqVGUtZoN7bp1P35+bjrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNItXwhI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e2268ed96so156966f8f.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 15:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766653; x=1710371453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRHnbXtB32cLDQSrOyTYKzXDyrTH/Qa1ZN7Ooz9+0cY=;
        b=RNItXwhIjBr1HyD7YiDnVSTOaexrsb3KYWVpfxjsEbRVGRK8mS6v4ILUlCN5EpIsXL
         IvV4pnQZD+xS6xbtx3xlaGdD9m7JH0yegU1zniyoaRO+gjzXZAiF+dMcrrwL55zGIqn5
         IXWNikOk+wKx7tbnzGRXBl7zTnfYPsrb0EQaZIcd+Ii69hJb1rSnXuwkWGpgsd2/vThp
         F0V70qOBVVkiEIfNQTqhSOxSE7YcNSsBnADLP2wZWwJwjpprpdITY20fyyUya6AImtPC
         cnWPlVXH76eaQ9KD6H7WSTy2LAd05fMFAjgc03RAwxD9hb2fKk8yQlH47q96gR8i/fsa
         3RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766653; x=1710371453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRHnbXtB32cLDQSrOyTYKzXDyrTH/Qa1ZN7Ooz9+0cY=;
        b=Lj0NbPlXayObIR5I/tYO+o3hkdi/fCoheR/yA49nXqZW9UPL3VEcupkGnNXB0M6lNw
         +jpPgMshUXFKqjTxH49GroMoAiUb/qG/Pf07Sp5wpTaBI4uErabapU0nZylIFveXIFs+
         dOGrBwl7a3nHLHCtcKoE7jrOUQsKZUqVzetEBSRFkwida0hVacBeV4++/yWhys4lSmX/
         i/LTqtUgZwLVgcopaf/eawnDq5G35xArTARA17YXQ99VVsH6GUxndltr/uMpYMhFW6a4
         T9DOVrkO6G+A2f/bVfCE5rSE5bBO3/JMxFrs3xG4SUYKcqOj99BTdzyff8xRukoOIjjo
         utZw==
X-Gm-Message-State: AOJu0YwTx6Clmj++FIbiE/cRGMoi57zlxO/whqVXD+O0Wm8aCfiLzihq
	tPgdTLSPtNQ8lOUHM6E1uYWPMCc+qzyMxc6bGiP1HTDe5gGLvNoACgg606hgSIc=
X-Google-Smtp-Source: AGHT+IHIZ0cwp4riiSCOsaMtVTlXATGPCe7JjHA8N2Tx5VEx0VJR5z+MDUWdukgBs41hQAibfKO/KA==
X-Received: by 2002:a5d:61c2:0:b0:33e:d27:4ed3 with SMTP id q2-20020a5d61c2000000b0033e0d274ed3mr10508875wrv.64.1709766652651;
        Wed, 06 Mar 2024 15:10:52 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:952f:caa6:b9c0:b4d8])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm18722810wru.112.2024.03.06.15.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:10:51 -0800 (PST)
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
Subject: [PATCH net-next v3 2/6] tools/net/ynl: Report netlink errors without stacktrace
Date: Wed,  6 Mar 2024 23:10:42 +0000
Message-ID: <20240306231046.97158-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306231046.97158-1-donald.hunter@gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ynl does not handle NlError exceptions so they get reported like program
failures. Handle the NlError exceptions and report the netlink errors
more cleanly.

Example now:

Netlink error: No such file or directory
nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
	error: -2	extack: {'bad-attr': '.op'}

Example before:

Traceback (most recent call last):
  File "/home/donaldh/net-next/./tools/net/ynl/cli.py", line 81, in <module>
    main()
  File "/home/donaldh/net-next/./tools/net/ynl/cli.py", line 69, in main
    reply = ynl.dump(args.dump, attrs)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/donaldh/net-next/tools/net/ynl/lib/ynl.py", line 906, in dump
    return self._op(method, vals, [], dump=True)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/donaldh/net-next/tools/net/ynl/lib/ynl.py", line 872, in _op
    raise NlError(nl_msg)
lib.ynl.NlError: Netlink error: No such file or directory
nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
	error: -2	extack: {'bad-attr': '.op'}

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/cli.py          | 18 +++++++++++-------
 tools/net/ynl/lib/__init__.py |  4 ++--
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index e8a65fbc3698..f131e33ac3ee 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -6,7 +6,7 @@ import json
 import pprint
 import time
 
-from lib import YnlFamily, Netlink
+from lib import YnlFamily, Netlink, NlError
 
 
 class YnlEncoder(json.JSONEncoder):
@@ -66,12 +66,16 @@ def main():
     if args.sleep:
         time.sleep(args.sleep)
 
-    if args.do:
-        reply = ynl.do(args.do, attrs, args.flags)
-        output(reply)
-    if args.dump:
-        reply = ynl.dump(args.dump, attrs)
-        output(reply)
+    try:
+        if args.do:
+            reply = ynl.do(args.do, attrs, args.flags)
+            output(reply)
+        if args.dump:
+            reply = ynl.dump(args.dump, attrs)
+            output(reply)
+    except NlError as e:
+        print(e)
+        exit(1)
 
     if args.ntf:
         ynl.check_ntf()
diff --git a/tools/net/ynl/lib/__init__.py b/tools/net/ynl/lib/__init__.py
index f7eaa07783e7..9137b83e580a 100644
--- a/tools/net/ynl/lib/__init__.py
+++ b/tools/net/ynl/lib/__init__.py
@@ -2,7 +2,7 @@
 
 from .nlspec import SpecAttr, SpecAttrSet, SpecEnumEntry, SpecEnumSet, \
     SpecFamily, SpecOperation
-from .ynl import YnlFamily, Netlink
+from .ynl import YnlFamily, Netlink, NlError
 
 __all__ = ["SpecAttr", "SpecAttrSet", "SpecEnumEntry", "SpecEnumSet",
-           "SpecFamily", "SpecOperation", "YnlFamily", "Netlink"]
+           "SpecFamily", "SpecOperation", "YnlFamily", "Netlink", "NlError"]
-- 
2.42.0


