Return-Path: <netdev+bounces-157183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A21BEA093B3
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11810165106
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CBB211283;
	Fri, 10 Jan 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/NoMVKP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5D20E709
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520122; cv=none; b=WR+ruAt1lyWq1auwufrScmd7OdcHDhMgpA99hHSWpv/k2CtYE3/HgWY53UQyw8Abz6yr8aWUvNFjLS/bFgO6H2arS39FRuV5qD/6JLRY49kQkPlWJzi2ZGMsumC+uGHvizC2x7ilRumPqq2xoXX8SO/Uy6vbvfq0YHBtE6ED+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520122; c=relaxed/simple;
	bh=DB2YuAAcamyIpHI5F3IkHc3Clmkq7ng78Sd28jLZY/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5RUVuPpRiQOEmASPFHyPGUoDnznZuinur/S4OfxCQS7/pab7Q41WNRMS9fl0R1wVVGbmr+LT4+StSXd0TD7aqseupTeQC3gUPzoI0hea/dkGKWwarvAmw54wsC74kidvX9UqgHgr+N7ZDMgqRxMjzgHP3OonvpVaE9Mc8JgG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/NoMVKP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso1194722f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 06:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736520118; x=1737124918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6MRiiaRK258ydTWiZWoWPdA3I8IQgxz+CpKKGOYygww=;
        b=e/NoMVKPb4LXNYzMn66lMxwJ7e5Bzm005Ohet6joWDfVC+AjA8Jx6QxpQ+5maS/s5n
         BuTrxgnnM0gKnWlokV8nqHY9cMYV0KjFvX9ENcsR5TSbiE+uDEHh5aHGzGGi3qdCmtxH
         vaDGNeVs42e7KP5+KoAPSZa6CPY5oAr8XThlr2hy+KyeKW/tYNflBLCdBF81t/BH/deu
         68a3Jgyt8iG8gW5Oz16L4C9HI0ZmdaDyOf2676HDVf05nBUfO5yODn5ZKeDQCLND2u1a
         8+7zWZyAg0hUsvvo6h/bavYOc1Do7kg7p8JLfn+AMNuRbUb07MEX/FVOKxp2YkBcBHP0
         cL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736520118; x=1737124918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MRiiaRK258ydTWiZWoWPdA3I8IQgxz+CpKKGOYygww=;
        b=Kkj3zyU8y9r7b+tWOHtlyxI+gg915GYuJcargCLAJnzB6beM9q7NpShH8J5J6XP9nC
         llWFdR29uVl/4ezCaP8hop95aWYinkKhzYslKDwr+WXODnYruwYv6XfOZIEdVsj6tdrT
         BA9/5ykPCvATKAjMbgOLrh2Vci0uBOfYiZfgSKZqQrovEUKN8BEI0Lz27bFUjREqeUJb
         Z3g+K3E+A4tgIgSL2NwJ4P/JADSvih0ul8sEw9NLbhjMhkgidmkwhEHd8m+vfL9+VPQb
         ItZWFO2Ju1euFmL1qFQNy3tjvcZ19lidm+DxLZZDbX4K/0pMJObsetQgCpcnVE9wRcaD
         E8NA==
X-Gm-Message-State: AOJu0Yx5hbHqZU14IApV5CxTrNWDS8C6aLKtZj3acHkcEbUsh/uZJoon
	r/egKAgAFtOc/lqfHxpsXMi79Ywf+iLbJbrYPBa69Ad30SwN8yXRXwhDvA==
X-Gm-Gg: ASbGnctdBRtAEkrP0HxVd7cr4yEzfXjP0cVNyqiyEuoNQtwcmdIRN3AazC/p7eVR3SS
	ghAhLHm/5TeyLNPfaBD8nRC+Z0ZvKlzUbtu76723vmkZQewbnBtkzHyRqvEe9M1UneZatJccUd3
	gfuFi89xeKWHW6yiZqaopchHKLl6f8NS/Quy7BNCjQk1sX6kem9Z6MfxusEAx1JBlWpOi+Pvx0z
	ff+mkzddCazCT9MJMLh476WvItG28WehcIKoSnaZVjj7DxpmEinla3d+TZCeC6VrBfDMMAN884=
X-Google-Smtp-Source: AGHT+IFWOp4k9NyOv9fdHi8spOXPm7cFvPwBISGGLzGHqQlFpd98c/Ow7nwMpxt6+lwkUGfFcG/bYQ==
X-Received: by 2002:a5d:64cb:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-38a872d2a11mr9545507f8f.3.1736520117903;
        Fri, 10 Jan 2025 06:41:57 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:a9f1:3595:7617:6954])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddca2dsm88602265e9.21.2025.01.10.06.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:41:57 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 1/2] tools/net/ynl: add support for --family and --list-families
Date: Fri, 10 Jan 2025 14:41:44 +0000
Message-ID: <20250110144145.3493-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a --family option to ynl to specify the spec by family name instead
of file path, with support for searching in-tree and system install
location and a --list-families option to show the available families.

./tools/net/ynl/pyynl/cli.py --family rt_addr --dump getaddr

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/cli.py | 44 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 41d9fa5c818d..70dd8bf7512b 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -3,6 +3,7 @@
 
 import argparse
 import json
+import os
 import pathlib
 import pprint
 import sys
@@ -10,6 +11,23 @@ import sys
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlFamily, Netlink, NlError
 
+sys_schema_dir='/usr/share/ynl'
+relative_schema_dir='../../../../Documentation/netlink'
+
+def schema_dir():
+    script_dir = os.path.dirname(os.path.abspath(__file__))
+    schema_dir = os.path.abspath(f"{script_dir}/{relative_schema_dir}")
+    if not os.path.isdir(schema_dir):
+        schema_dir = sys_schema_dir
+    if not os.path.isdir(schema_dir):
+        raise Exception(f"Schema directory {schema_dir} does not exist")
+    return schema_dir
+
+def spec_dir():
+    spec_dir = schema_dir() + '/specs'
+    if not os.path.isdir(spec_dir):
+        raise Exception(f"Spec directory {spec_dir} does not exist")
+    return spec_dir
 
 class YnlEncoder(json.JSONEncoder):
     def default(self, obj):
@@ -32,7 +50,14 @@ def main():
 
     parser = argparse.ArgumentParser(description=description,
                                      epilog=epilog)
-    parser.add_argument('--spec', dest='spec', type=str, required=True)
+    spec_group = parser.add_mutually_exclusive_group(required=True)
+    spec_group.add_argument('--family', dest='family', type=str,
+                            help='name of the netlink FAMILY')
+    spec_group.add_argument('--list-families', action='store_true',
+                            help='list all available netlink families')
+    spec_group.add_argument('--spec', dest='spec', type=str,
+                            help='choose the family by SPEC file path')
+
     parser.add_argument('--schema', dest='schema', type=str)
     parser.add_argument('--no-schema', action='store_true')
     parser.add_argument('--json', dest='json_text', type=str)
@@ -70,6 +95,12 @@ def main():
         else:
             pprint.PrettyPrinter().pprint(msg)
 
+    if args.list_families:
+        for filename in sorted(os.listdir(spec_dir())):
+            if filename.endswith('.yaml'):
+                print(filename.removesuffix('.yaml'))
+        return
+
     if args.no_schema:
         args.schema = ''
 
@@ -77,7 +108,16 @@ def main():
     if args.json_text:
         attrs = json.loads(args.json_text)
 
-    ynl = YnlFamily(args.spec, args.schema, args.process_unknown,
+    if args.family:
+        spec = f"{spec_dir()}/{args.family}.yaml"
+        if args.schema is None:
+            args.schema = ''
+    else:
+        spec = args.spec
+    if not os.path.isfile(spec):
+        raise Exception(f"Spec file {spec} does not exist")
+
+    ynl = YnlFamily(spec, args.schema, args.process_unknown,
                     recv_size=args.dbg_small_recv)
     if args.dbg_small_recv:
         ynl.set_recv_dbg(True)
-- 
2.47.1


