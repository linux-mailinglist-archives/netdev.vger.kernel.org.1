Return-Path: <netdev+bounces-248157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2576D0451B
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15824307A973
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B431A26B95B;
	Thu,  8 Jan 2026 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDBcptIS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0FB26159E
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888856; cv=none; b=WW9RsegQrzGLzPOa9TvYCSK1cpUgKkHZB5OtbFXOMyt7VPD7yZ8MQ3XcOknIRpG9eMKl/zjwFm4h44eaol4PvhXR93zbl3qPzq4lhD3xxQMo2Fmu+tlXvdqnqPhFwBc89Jnba5KX6700ISIR4g4Ct9bFYcYkfgNGSapV+MQO7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888856; c=relaxed/simple;
	bh=LXy2Ua1cUOSGWHBNdtUnsbR39WZkmXzM0hJK6m/a3KQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8g7HWasjZMlaEv7IUdUZiIJstNdX5QvxEhBByjtigc12r6Hj8xUDoqVEZtlLbk31J9zLO673umANcoivGFhxyRDZ396hCDgTAgKULZW7WgeMxmZA2TY4gY/65zRkfKBJxYY5d5SvhpZA/OKRZRW82lgjiDZGw+Yslh5tUf8OHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDBcptIS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so1725404f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767888851; x=1768493651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uN8D9zqUx9hP6RtZocuSaBDdTng6nEw0sA37guFjwQ4=;
        b=eDBcptIS0VRNduzrOJvCI6whOOG3jjMrsWJGLlnve4D+JdpEErS86ORdy09C60N+zh
         HUYnKsraUq/dYo08TyGyTGrmanUyapA1dun9GbGUlhA1bmmnRBlx3Usf5QVprSC2GsNt
         5S6UdHJ/R1Cvs7p/qIS+8mgjTGe6U1xNmdEG5Y6+xU2Ta7QFwxrj0VGxnL8rhE2RD5D0
         QLp3YuGMTnZoj+jKosM1sbrlBwwpMYWEu606TDIalOdl8/zLB2F4s0u9d8GkKZAjDnYY
         UVB08APgD/BCPyGeTbmu46ON5m8u9JfFU3DcD5MYXfBPJw1BbbXfk5wcA8aMf8qI24mY
         fYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767888851; x=1768493651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uN8D9zqUx9hP6RtZocuSaBDdTng6nEw0sA37guFjwQ4=;
        b=XT9IVeWns6Q8joCmCBfZzWVHw7lL5Y8dtvTzJS8PcwxO8W6B8M8RIyiEk3oT9zjE2x
         pSkxKf948qr9m8PXEu1GrVw3RFcAEF3V4Z0g31qyG8pBygu0rygJVYBHvfo3pXImYwiG
         Wc++MOlvyFzwjVPycbIhZuiet1SPYY4B8g/Hl5fVvklDMP+xzhGieSwzb1LVcVyJ2sdv
         oJkRgk2r7Znc82VnRriSpcrRtqEzUwebfhn5Nujj8zIXOqDRdqR1GYnVFcjJwS0z/GNM
         cHjks6papfzmim/c6TuxKtT108RA0S5205mbtjfogBiDc76XrX1GvfPKySZtuxrTMN+m
         ygQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTcE8OBprcjo754YPcHoGnQgRzuA2jH1TAsNaVfRtvcblBjG1IHFb4mhwRU6n/OwVNov3FntE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykzXphsIguuWNcY+F2zd2Qo/iDG0QUcSyKUbN3blA6dwO2YrXp
	Or86jQ+B+O9M63Wrl+MBFapVdMZIoqwwFi2jtuAMae1VOctVbQNakPLJa+x9iA==
X-Gm-Gg: AY/fxX4LVeZv1TS+SPiqQmPTg5XRjxQ9S6kqjU2WudanfZddH8iLaN0zyiIlE0F2n0m
	jEf6QVT3KQ7zO5gupg+mrTlIvRvOQ+I2jpl+Ol0mWoBWh/HCzIHVMCiamHsc8D96tOd440EBjZz
	7N7qzXMa0LgCSP4kTmUpMgDCYkbO9axp5PPO5uBwZ16mrKXo/YALEAxMe0wr3yQaLwT3hkL37Ku
	CHLdMuG3E1tMQNkRQpx6f8O3qW7liTnRJ8pKLV7U6kt84Sw5PXsauiEP9qN2N08+SLP+O8SMaTA
	CpyOG4jBdyGbKAHB6STsqQDqYNOp3lXrrIpgfcKCaWV8QEj9eHpOXG4vbINt7ObngccYClp0ZS0
	moff5+cnTEvCo9R1csqwCi00fc1h93rt+LUsuFys2+D5VdbGDaqE6GCOFLH0f/FvfhDFS1djeuf
	QU6SGMLXBzilysMzImbRlgRKvV8AkM
X-Google-Smtp-Source: AGHT+IFWuMKAlw7vAFoR/06p1Ty8iS62arXcBSiWcP9P0l+zbna8uaAvmkxQD38fb3oGMEha5w4Ccg==
X-Received: by 2002:a5d:64e3:0:b0:42b:3dfb:644c with SMTP id ffacd0b85a97d-432c3628287mr7819387f8f.10.1767888851369;
        Thu, 08 Jan 2026 08:14:11 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm17140039f8f.29.2026.01.08.08.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:14:10 -0800 (PST)
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
Subject: [PATCH net-next v2 08/13] tools: ynl: ethtool: fix pylint issues
Date: Thu,  8 Jan 2026 16:13:34 +0000
Message-ID: <20260108161339.29166-9-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108161339.29166-1-donald.hunter@gmail.com>
References: <20260108161339.29166-1-donald.hunter@gmail.com>
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


