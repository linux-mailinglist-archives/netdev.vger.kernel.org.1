Return-Path: <netdev+bounces-247702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3033CFDA76
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BB17304569E
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8E3161BA;
	Wed,  7 Jan 2026 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRXN1+RR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF43161A8
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788536; cv=none; b=Cc9ffNEz1JTnkh/10Bo7/q17ctKty47ynyUqcXviIhjSEbnbjbxqr25Jue3z/rSz4A9DQYy4mELvwmgAfRJo9cCliifXiPXktQZ3nycYYxMcc4pBE9RH+x7cm91cxIL8b+pQF0EtJh+/DsExsnqKF6m0cKpj4Xk8o7gADZkngf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788536; c=relaxed/simple;
	bh=LXy2Ua1cUOSGWHBNdtUnsbR39WZkmXzM0hJK6m/a3KQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q45zemp5fy+LYYi6jtIys3DjPwSiGuWf1wbwVU2sMFHaGNgAqSjYzUXAOHv5xXlnV3V5v0HWGuZ+9vCTkCZy7MvtcbMD0gx/cg4l/S70d7KhWxG1Q410bjerElKr3SJRqse+K+aVv12YmZjtU/I0gH/6bEQLHhEQQOZ3sORE5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRXN1+RR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so1017173f8f.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788532; x=1768393332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uN8D9zqUx9hP6RtZocuSaBDdTng6nEw0sA37guFjwQ4=;
        b=NRXN1+RRNkQ7mKgu5WGlHn+4slocIXbevPh0nbkziTpQlR754cABtNinS36Fk5sTpM
         U/DnMNA79oC36nc2RwDgUQKU2/ymfL2lvcjg3rV4btX9ybityBBv0nT3CIgOMLf+PJrx
         Lj91wej5KBDuXSdihL1QHQhdiWQT2sp4lQiyY1cG8AaCD1p1GLr/3lnxAPpGoEl8gsz1
         AmFgfWCMFpnwMcGhv+fg+Ve453IWtxtyHaJp5CWsIJEtmdtqdAUNhJdp9CmBZePwvxCV
         4/lNTeBRKYeEUxFmaJD2FBeuI/1fgsXJSVIykkcbOgpfEI+JHFXjAatAZDT9B9tkllPd
         jm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788532; x=1768393332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uN8D9zqUx9hP6RtZocuSaBDdTng6nEw0sA37guFjwQ4=;
        b=NfSU1686G8zv9foTjY85wBHr0XilVIZX8VqtjXxoEHXWUr/EprssNe0Q8loZlJ8dbY
         jUG4TXOBQQBGPlDdHJTRzblfz0T7xtIhzOxv9MTxdAGnkZzIZEk3mnguk9lIEfTcnfK7
         m+W0jIpPuIEHKg+iRaiT3WmJMHpc2UyjA2QQU6FhvdAeMnEnmlmvDi6/4Jk1+ujEkvrj
         ArPxGp3K/3zRiLDhviudf7t2RMQ9Y/XZSN9sTJwrNqEZ16BSyd2pGI/j4HDTeBUWWb4M
         Zj9HLiCqvxQ4HxkIC7uGR5m0fit5IMqkmzIBYPRICvEwgrUIvw8TPv/z5NKfsF5un53o
         DbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4Jnh0HoOlSlBTPpf0AsG99A9hsK4rBvJYEexejykWokQtZHob/VR+q0cT7tqtd6ow8Y1VGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM65j7in+ttzhVgmRDJwadR6hr61RY1/TxrpTnrE+5ZWKlPaoA
	5HEWPUn+xsaUhpGUtNyQTdcnPb/Mp79iqRrs5G0saGUO+tKaXMmilj4Z
X-Gm-Gg: AY/fxX7znkjrXIIjDHs+cY83NLWRTO2f6U7z0zWvV/sdLLRokG9X03GB6cTKwu7+kBi
	RdD3O8fpHVfQuWQipl9WkYw0InNYoXr/r456zLwkTmGmMuGbsHXzb6UP5zrhdoWijHf+17inqvA
	/90DYqzFuvg7Rgjjcj5VnYCNw2kcreU1lkI2V3RLdT2xXTaNchrm/9w9A1ht0x7tw0LX6dmclmY
	yclzV90ukK/cXlfCy7la0X8IZNLSCyq4rwkHA0XKjx97rbvSoR/qXr/hQuHnwNzKV64dKvEm+L4
	zmeV3Nf583MNp/bNxs0+I0UCDH2tRlyKA9BF+od3DXULJmiEsC56hYuB8bYduVuNJzImInDMB5v
	GLKNmzpaeXPdQLO3WuIdxCg5NsH+uOcG7imZ19/4c0FGdPndxf9qJ03GYN6lXLmdD1Ll7x/AvTI
	1CEw4nBaRNrZs6MkE6VSu1Dc4jLr3b
X-Google-Smtp-Source: AGHT+IGr9TUwQpcofSbPB7NYJIiUrsvqauRvD/eEo4Cw0ZOENCc6OAYe73MHpEeICsPVDw5iyoM7jA==
X-Received: by 2002:a5d:64c7:0:b0:42f:b690:6788 with SMTP id ffacd0b85a97d-432c378a0d4mr3006796f8f.10.1767788532034;
        Wed, 07 Jan 2026 04:22:12 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:11 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ruben Wauters <rubenru09@aol.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v1 08/13] tools: ynl: ethtool: fix pylint issues
Date: Wed,  7 Jan 2026 12:21:38 +0000
Message-ID: <20260107122143.93810-9-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107122143.93810-1-donald.hunter@gmail.com>
References: <20260107122143.93810-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix or suppress all the pylint issues in ethtool.py, except for
TODO (fixme) items.

Suppress:

- too-many-locals
- too-many-branches
- too-many-statements
- too-many-return-statements
- import-error

Fix:

- missing-module-docstring
- redefined-outer-name
- dangerous-default-value
- use-dict-literal
- missing-function-docstring
- global-variable-undefined
- expression-not-assigned
- inconsistent-return-statements
- wrong-import-order

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ethtool.py | 46 +++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
index 40a8ba8d296f..f1a2a2a89985 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/pyynl/ethtool.py
@@ -1,5 +1,10 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+#
+# pylint: disable=too-many-locals, too-many-branches, too-many-statements
+# pylint: disable=too-many-return-statements
+
+""" YNL ethtool utility """
 
 import argparse
 import pathlib
@@ -10,8 +15,10 @@ import os
 
 # pylint: disable=no-name-in-module,wrong-import-position
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
-from lib import YnlFamily
+# pylint: disable=import-error
 from cli import schema_dir, spec_dir
+from lib import YnlFamily
+
 
 def args_to_req(ynl, op_name, args, req):
     """
@@ -49,7 +56,8 @@ def print_field(reply, *desc):
         return
 
     if len(desc) == 0:
-        return print_field(reply, *zip(reply.keys(), reply.keys()))
+        print_field(reply, *zip(reply.keys(), reply.keys()))
+        return
 
     for spec in desc:
         try:
@@ -89,11 +97,12 @@ def doit(ynl, args, op_name):
     args_to_req(ynl, op_name, args.args, req)
     ynl.do(op_name, req)
 
-def dumpit(ynl, args, op_name, extra = {}):
+def dumpit(ynl, args, op_name, extra=None):
     """
     Prepare request header, parse arguments and dumpit (filtering out the
     devices we're not interested in).
     """
+    extra = extra or {}
     reply = ynl.dump(op_name, { 'header': {} } | extra)
     if not reply:
         return {}
@@ -115,9 +124,9 @@ def bits_to_dict(attr):
     """
     ret = {}
     if 'bits' not in attr:
-        return dict()
+        return {}
     if 'bit' not in attr['bits']:
-        return dict()
+        return {}
     for bit in attr['bits']['bit']:
         if bit['name'] == '':
             continue
@@ -127,6 +136,8 @@ def bits_to_dict(attr):
     return ret
 
 def main():
+    """ YNL ethtool utility """
+
     parser = argparse.ArgumentParser(description='ethtool wannabe')
     parser.add_argument('--json', action=argparse.BooleanOptionalAction)
     parser.add_argument('--show-priv-flags', action=argparse.BooleanOptionalAction)
@@ -156,7 +167,7 @@ def main():
     # TODO:                       rss-get
     parser.add_argument('device', metavar='device', type=str)
     parser.add_argument('args', metavar='args', type=str, nargs='*')
-    global args
+
     args = parser.parse_args()
 
     spec = os.path.join(spec_dir(), 'ethtool.yaml')
@@ -170,13 +181,16 @@ def main():
         return
 
     if args.set_eee:
-        return doit(ynl, args, 'eee-set')
+        doit(ynl, args, 'eee-set')
+        return
 
     if args.set_pause:
-        return doit(ynl, args, 'pause-set')
+        doit(ynl, args, 'pause-set')
+        return
 
     if args.set_coalesce:
-        return doit(ynl, args, 'coalesce-set')
+        doit(ynl, args, 'coalesce-set')
+        return
 
     if args.set_features:
         # TODO: parse the bitmask
@@ -184,10 +198,12 @@ def main():
         return
 
     if args.set_channels:
-        return doit(ynl, args, 'channels-set')
+        doit(ynl, args, 'channels-set')
+        return
 
     if args.set_ring:
-        return doit(ynl, args, 'rings-set')
+        doit(ynl, args, 'rings-set')
+        return
 
     if args.show_priv_flags:
         flags = bits_to_dict(dumpit(ynl, args, 'privflags-get')['flags'])
@@ -338,25 +354,25 @@ def main():
         print(f'Time stamping parameters for {args.device}:')
 
         print('Capabilities:')
-        [print(f'\t{v}') for v in bits_to_dict(tsinfo['timestamping'])]
+        _ = [print(f'\t{v}') for v in bits_to_dict(tsinfo['timestamping'])]
 
         print(f'PTP Hardware Clock: {tsinfo.get("phc-index", "none")}')
 
         if 'tx-types' in tsinfo:
             print('Hardware Transmit Timestamp Modes:')
-            [print(f'\t{v}') for v in bits_to_dict(tsinfo['tx-types'])]
+            _ = [print(f'\t{v}') for v in bits_to_dict(tsinfo['tx-types'])]
         else:
             print('Hardware Transmit Timestamp Modes: none')
 
         if 'rx-filters' in tsinfo:
             print('Hardware Receive Filter Modes:')
-            [print(f'\t{v}') for v in bits_to_dict(tsinfo['rx-filters'])]
+            _ = [print(f'\t{v}') for v in bits_to_dict(tsinfo['rx-filters'])]
         else:
             print('Hardware Receive Filter Modes: none')
 
         if 'stats' in tsinfo and tsinfo['stats']:
             print('Statistics:')
-            [print(f'\t{k}: {v}') for k, v in tsinfo['stats'].items()]
+            _ = [print(f'\t{k}: {v}') for k, v in tsinfo['stats'].items()]
 
         return
 
-- 
2.52.0


