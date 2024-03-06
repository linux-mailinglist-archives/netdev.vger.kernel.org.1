Return-Path: <netdev+bounces-77911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9143873722
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA061C21A78
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AB6130AEB;
	Wed,  6 Mar 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFFo6g/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22FC86AE9
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729834; cv=none; b=beVehF0GfVSgGH+I2X9Wo5LnF+aOU6ee00Cynht1PzntreQaG7304gi0dYJthYEpA3snySR1fHOi+XyYWJVkRYKy8N6W9rjzTvPKOHoLd3Jfs1vJ8VI8iBg1ckyUf41bexczvD19Inu13iQP955LV81Xgp6Kd7Q+4xq4RbRFnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729834; c=relaxed/simple;
	bh=nDCJ3eaSXIg6bwGEZ1SyaLIaxerMhudsN4/UrqnAu58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hb07Jqrw0D7+b4w//1nwDEn6m2ojuMAGJOKv0naieQj52p77Zlt2JGAeTS+E5L7imPa3+xCNKr6jfEHFCyuDjE5lhiUbXPQORdnCyYCc1HTr1/M2q9qjdtWIzIrOr0HlisLz3nBqmie3FBO8pLm7JBspvR/5I02jOnWmb1o0us8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFFo6g/v; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412f8d2b0fcso2702445e9.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 04:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709729831; x=1710334631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAD2BKLxK8AlKfwB8eeB8Ra1Y5lNbnQ/Edb//dSEFhQ=;
        b=RFFo6g/vt9GWXjqy9pxWRjMYbFHjGJ62ojbYirmT6ztuAeIzEwklhmw95hZPBXS2F9
         iQuYEeX2P64TrvF4DXoVDU0Ka0/J0cNa+34hm9YeAxGSALCJW60mvbvc5l6mEIfEj48e
         Bijd5altbT4NKv+3pl3hJav4JeLR6B32UlAew9CjdxfaLp5mRlMrm6X/4nkYjCv/GFcl
         lV3lf9S64gC/DXMMWQfjKxUiyOtUPuw4s4YPduL3Lmhlm1iXfWWIsgfJhqj7doNulrKR
         jDAYEB2YmEwoX7r9NboIF2F3tGjKpOu72s3v+YRDwA2Gf0hzaCi0OEj68j4bDswDOUTz
         4/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729831; x=1710334631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAD2BKLxK8AlKfwB8eeB8Ra1Y5lNbnQ/Edb//dSEFhQ=;
        b=jZFqOHOA+QWJ1IZRBaWGS6wByxU+I4g1rCvSCj0pe55L0xytpTxI7ofrxUU5+JeQoX
         QN7MV85hfQC1cOnhppUd00u6ReCz92x0r0PWc0P+8yDL1hdgBkbplUAUfz6oZiuGvifj
         SC8ixhBoypLLm1kWZaTtEyR51yYm9w24IEQg7gticyYxlNkMVHDe1HuosZan4dPIelHP
         1xyEJ1ggOCIs98va5mMj3LlZmWIem1ilDjK/r7IlamfOWgSJUORWu3jx3YmhSuNI8vMn
         hiIU30hznqomEBEbiPD5S3i/4ympuNtF+HM20XI63FIq6E0BcWaFxBE8ZOekeHNDzFGH
         dX5Q==
X-Gm-Message-State: AOJu0Yw5otzsi9JwjMFXGX3GccVlCRzXq07msGn3rzeREKeKaMa3uG9N
	cWMwCa7+w0xTeeatA42+lZzxJmeUo9IqK5k4Xvs8K5Jya2tdGyNNovexvGWWdg8=
X-Google-Smtp-Source: AGHT+IEVChPT6nWDMZdDH0EuEjPwCtbpHQuyUZ1sOSwTG/0syG06xYdMsiq9nMZa6P1iQ8j7Tce6oQ==
X-Received: by 2002:a05:600c:458b:b0:412:bd3e:9fee with SMTP id r11-20020a05600c458b00b00412bd3e9feemr11136501wmo.0.1709729830441;
        Wed, 06 Mar 2024 04:57:10 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:503c:e93d:cfcc:281b])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b00412b6fbb9b5sm11857279wmq.8.2024.03.06.04.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:57:09 -0800 (PST)
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
Subject: [PATCH net-next v2 2/5] tools/net/ynl: Report netlink errors without stacktrace
Date: Wed,  6 Mar 2024 12:57:01 +0000
Message-ID: <20240306125704.63934-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306125704.63934-1-donald.hunter@gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
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


