Return-Path: <netdev+bounces-76646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17886E6F9
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEAB1C21861
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C2F4C9C;
	Fri,  1 Mar 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8nOQpb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B195663
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313284; cv=none; b=O2TJ+grvEYsqNOs9iY+ksS+yYnqI/BJjwJwNEs2RDbxY6iukuvwZaYnOqlGJUN1T6T9lswOtrJt/r3TQCMeh/Nviw4qr1tOpNsRdaj4inwnEREaJ65udJnobNlezVTK3SWMblWFHR7AtmjNJG0eW/HmbXpppvfl/If03gKTyerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313284; c=relaxed/simple;
	bh=bMK+HuEPPslYD2gVKITnQmNcq1JK/b+mMe9FIMAJg9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llhdWWDlxPOF3ARjF9FxrU2/Fdr8mJuFfxuEqPDWEQD84tWGDlJHL5BxDZtLG7z3HdtglKEdZJj7xjB1jwKkjXzy9LWFnKQ4GFzhERS8pPCxlZpImUDezfteliwY5IMJHC0QPPLWADuX9OMdnJkCfQH2ZN2cwzaddP3Athu0vv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8nOQpb6; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d28464c554so29509191fa.3
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 09:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709313280; x=1709918080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGy7I9gmi30fpuWsigLrpycA1+OS7TEwTIlqse2LMjo=;
        b=C8nOQpb6MjXI29PBOhYPcqwRkAv6ddBYD/M2zUg80hBEz3uh5CaR88P0dLAO0Q5p7q
         wSk918AIIgcSQf3IUOK8YKUuf0qEItdIwnJcjT3+D4KxdBDpBO2jro80vzqgPufHDKw+
         5rSZjo+xIFhP3/BaPsAMY3QJ/4q+tW3Ze6r/1yX6f0dF2ycWfoWKypCUnEJiREctz8qm
         nCTiU0cO9VA2nUt3zONYDkcxt2sHcO8hlN91PWpPDu/MM4Y9go681i3/Qak195bsvgEu
         gXj5SIB5qBRfaZ5UhYu9zrBZpXN5uqvqP13bznkxi6ztvfsoNtOldo7BxbnXJEek/mE+
         ll7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313280; x=1709918080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGy7I9gmi30fpuWsigLrpycA1+OS7TEwTIlqse2LMjo=;
        b=o88EhL2BsvK4G343OLuDvCiNXabshSbmvNFf82FWA2SL2x/uE4jP/28M1lTYOflQXO
         ziIJDmXy20HqjRKd6KHWNVNthuC9qRmeMbmZpQiyUgFoZDmd6Z+b2HLxHLUvVx/zZyVk
         DbVg7Gbsz9qf43dhb22d2NrHO+eVMXk1Q03MxNmUDzOUxbAEwqIDnNVTecSnuNKLmibX
         4E9f+l0v0ejOAgiFgSQHmzaL/LW4ENW2CPR6lA3r8nUQoWa+o97/ULS5usJfylp7q7Jf
         2OFhNpaR341UqCyu1l3WMsykQr9FeQTDdgswvErJwjj5b4DthyXKo+NawqDy22c20dHC
         1pow==
X-Gm-Message-State: AOJu0YwkXFHPR+tv8VPBmNUXMjlk/iIE/O5kRmst/xW0kxToel05Rj0Q
	83b/w5a4tcwvtGMyrMGscAUSVU/4JB+BpUh5ata1aupT16rq5jLD8cF+H/UE7vs=
X-Google-Smtp-Source: AGHT+IGHHRJLCV5hig7J/bNCn6D6U4DT15uN3Pn9+pvs/vLYBayJtfG/SUM11jQ21jVDQN3knB6tLw==
X-Received: by 2002:a05:651c:10d4:b0:2d2:d0ba:2586 with SMTP id l20-20020a05651c10d400b002d2d0ba2586mr1676036ljn.24.1709313280222;
        Fri, 01 Mar 2024 09:14:40 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:c06e:e547:41d1:e2b2])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600003c800b0033e17ff60e4sm3387556wrg.7.2024.03.01.09.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:14:39 -0800 (PST)
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
Subject: [PATCH net-next v1 2/4] tools/net/ynl: Report netlink errors without stacktrace
Date: Fri,  1 Mar 2024 17:14:29 +0000
Message-ID: <20240301171431.65892-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240301171431.65892-1-donald.hunter@gmail.com>
References: <20240301171431.65892-1-donald.hunter@gmail.com>
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
---
 tools/net/ynl/cli.py          | 18 +++++++++++-------
 tools/net/ynl/lib/__init__.py |  4 ++--
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 0f8239979670..cccf4d801b76 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -6,7 +6,7 @@ import json
 import pprint
 import time
 
-from lib import YnlFamily, Netlink
+from lib import YnlFamily, Netlink, NlError
 
 
 class YnlEncoder(json.JSONEncoder):
@@ -61,12 +61,16 @@ def main():
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


