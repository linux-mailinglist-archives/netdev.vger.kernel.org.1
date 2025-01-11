Return-Path: <netdev+bounces-157434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE26A0A478
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 16:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815A01889B1F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F02B1AF0C3;
	Sat, 11 Jan 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebX7pH8u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89244372
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736610496; cv=none; b=gtDGlQUIH0eOMHS3V7uZAjbwk2slx5cCvQZExWsreRwf5mvo3SnkPaNLy7EFzVhlWLlpm19cguBLm1jDpI+NhXr2xRpQ+dEA6L74hJXSnQ9LEFVysoeRNPvjmHzHGpiM4Ib7b0hXdbV4Cz2cdq7gx79IiIAx93RtZi3YJ2A/W4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736610496; c=relaxed/simple;
	bh=ddzNH3CYelEdSNrfULqlbj0pprV9AP0il8O9YXAScOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8CUkd5Qfi64vFT88CR4UDiDCKmivZHpNYdV60vIPq8wh9UtGddfHOAG7tVMLHanVRn3uYmwzZxFtJ2nyxnO3pGjyymg20FUa/mrvbvMulwrCDLV1W5Q0wCy1B5XrqEnm+7hcFB3E48H/YKO5Gbc5lfKH7IA4aZISgwd/GH2N3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebX7pH8u; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so21604795e9.1
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736610492; x=1737215292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZAVpDFNtwm/2z60hXDNEvobavgjr4cCFBLJThJU6pc=;
        b=ebX7pH8uKOIZ5axUITYOH5RI9PKqD2upFx6jSCjydHkcrCsN3ePsTrzaW3YHnIbehv
         Q4siM5i2E7//cW5c45OYQPy+VBJ/yLBwIzHEuJvHnjy2+4FwVfvQdTXXuIEbPbdo5g+7
         A3gIL9Sf16vDmndV9vmLKblnUcAOB9K1iwaTxFIc0swaIR0ivkntcqH6NlT0RTE3kN1s
         tGVrY5hZA07X+fsqT/UdFcNDPfpKPwSIoOkkHRH2XYoIaDH0UwwB0pn+6MRm+9Qqa7zG
         pFF7/E+bwTecvB5ezKhI87kQZ3SeXlogzBSIa0vof8CW0w4mFj8TGL2/vGMhSBn90kAt
         Lz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736610492; x=1737215292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZAVpDFNtwm/2z60hXDNEvobavgjr4cCFBLJThJU6pc=;
        b=DOAVTuMbkPITkq6IQlcmWgsvcDTBkg2LIOYqPvqc58Psj1HGHUVy7gU8H8YWY3g2mT
         qZn9iRlV3KvMVzgAawgeU842/FrR9l7ZPAIzxGsmlmG9JKGXCiIANk8AyR8hZZOgj+4J
         8BMttGm5AG0EBaPypz+SQwpVHr7BGe0mzHrdJxw3wo+zvUkbHCsB50EL8WTFIcHzVgtR
         jvPfyV6QR/26Cbg3CLyYjQCXN17Y8ZxAOAB5BfAHVfKoIfjrhyxvajeUUQtFi1Gp1qPD
         znkg1eYQ4EMzRh6FInFFciqQ9j9FmocnSlBF2HJ4ylWKzexB4DHyrvg6SHkHU34ZooSF
         ON1Q==
X-Gm-Message-State: AOJu0YzUe6u25y8nPIPJ6vRfTbPEkY+2Gny5gwx+2grebdFbgM0WJG5n
	s5Ff4qa0sHAABlXdhO/KvYubah74miIGyF25iZOG1eXFs47IxZAxT0HP4A==
X-Gm-Gg: ASbGncuaETAQUgx/BLDlPny5mCRVSI8LObxSpX5O8S+yvH40Al0I2r31Y8pBnFOshXZ
	SUWZFagmJtsTkHsaq2nJCXoC0G3zJEhui0nDsl3V4Ss6sCY8nryN7ciAB1WTOrq/+R2fyn0c+wg
	SAJy/yb0ORkG8AhoJ/2e0QhMsheXljUtI5RcbSEdtuoUh7UdYClhcWG30JL4Vb/snIJ/Lv84Uuu
	k9hbawXfJHEVPmmYE+NX8/f3XcW8xrbDf7b7tSHC2geF05KP2lvhD4qJ5Co/XCxjim/obh2Tg==
X-Google-Smtp-Source: AGHT+IHnF5yug5wDoWyVIC8EYnizatqaWC5yEwjlg0OWRr4VYWgvpNssd/xMt4u7v6ba5vniGaOttg==
X-Received: by 2002:a05:600c:3143:b0:434:fbda:1f44 with SMTP id 5b1f17b1804b1-436e26a8c09mr123882315e9.19.1736610492180;
        Sat, 11 Jan 2025 07:48:12 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:5ca1:6cf:d2e5:5941])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e62116sm85083245e9.35.2025.01.11.07.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 07:48:11 -0800 (PST)
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
Subject: [PATCH net-next v2 1/2] tools/net/ynl: add support for --family and --list-families
Date: Sat, 11 Jan 2025 15:48:02 +0000
Message-ID: <20250111154803.7496-1-donald.hunter@gmail.com>
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
Changes in v2, thanks Jakub:
 - Change help text for --list-families
 - Only disable schema check when installed

 tools/net/ynl/pyynl/cli.py | 45 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 41d9fa5c818d..794e3c7dcc65 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -3,6 +3,7 @@
 
 import argparse
 import json
+import os
 import pathlib
 import pprint
 import sys
@@ -10,6 +11,24 @@ import sys
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
+
 
 class YnlEncoder(json.JSONEncoder):
     def default(self, obj):
@@ -32,7 +51,14 @@ def main():
 
     parser = argparse.ArgumentParser(description=description,
                                      epilog=epilog)
-    parser.add_argument('--spec', dest='spec', type=str, required=True)
+    spec_group = parser.add_mutually_exclusive_group(required=True)
+    spec_group.add_argument('--family', dest='family', type=str,
+                            help='name of the netlink FAMILY')
+    spec_group.add_argument('--list-families', action='store_true',
+                            help='list all netlink families supported by YNL (has spec)')
+    spec_group.add_argument('--spec', dest='spec', type=str,
+                            help='choose the family by SPEC file path')
+
     parser.add_argument('--schema', dest='schema', type=str)
     parser.add_argument('--no-schema', action='store_true')
     parser.add_argument('--json', dest='json_text', type=str)
@@ -70,6 +96,12 @@ def main():
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
 
@@ -77,7 +109,16 @@ def main():
     if args.json_text:
         attrs = json.loads(args.json_text)
 
-    ynl = YnlFamily(args.spec, args.schema, args.process_unknown,
+    if args.family:
+        spec = f"{spec_dir()}/{args.family}.yaml"
+        if args.schema is None and spec.startswith(sys_schema_dir):
+            args.schema = '' # disable schema validation when installed
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


