Return-Path: <netdev+bounces-242280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AFFC8E46F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3C6734E6D9
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63A331A72;
	Thu, 27 Nov 2025 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgZPGHs5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC83314AE
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246929; cv=none; b=E8z34Noisvc6Xr36uOWW0tt75F5QDH5NKXqfxnFrLyBECUQQv9Vu2n9Vlw/3t1n5/ISXfFHSieVp9wS+PE15RYFkXeVCdPNwvnhIDwuyiFyGEoxcxq/p7D1Jfy61FbqmIBxvOMFaX1lmojI6Ad0UbkYrOa2x9umtpo4FQHlnWPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246929; c=relaxed/simple;
	bh=mb7drmhTSTpp7WC4xjdhsaHPj5ZBAbfT0ENp4pkV7ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqylDrlN7PGUsPjbke5siipW5zBLUu4WFLfr6skJiUt2vL0eu19bEQnldaipt7B18l0E180ep8rp/aJdhm/i+19OXIHBoFQYR5C8F2B0INnzD4KTIymdzt59ZVwBbZbqmyAjE4kUYar6fMJAsdIVwNTNdTgDhzpng27bWA8ab8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgZPGHs5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so387588f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 04:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764246926; x=1764851726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+gXz/CH4Pv1gx23xe74dERW313MnXcOXvNaurzXXT4=;
        b=EgZPGHs5fGXI1lBRBBNMjN1D/tnnFdgcq86svDQRgxJW5FM5tAIo4UxN4vjs0WzfgY
         mGe22BEModImO0mX7le1BmtWgn3t9R85+sgeO9fZL9GsDV7hIrtrYhaQvbfvCBD+Wlun
         Z9J/oZ1TiqHrK+SDUfPxoWci2pPMFnyLZAaf5GyMCWKFccW9AdFAg73tTo0mUu2Kzryh
         H/MYJfw2f3m3PT0kEyDZ9o3usUs5ryV+JSWx384cwGuLgMy08mEKOE4+sbtu9mEVzBvH
         4EUXaCdPYFWPohczSFIeEv/UhUUczVQqIFZ/od+e/xHSX5ADTKnJnMrh9i1agGcti8w7
         Pv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764246926; x=1764851726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+gXz/CH4Pv1gx23xe74dERW313MnXcOXvNaurzXXT4=;
        b=pwCdz1VtYAo0j0en59vY3weHY8lMHZc/zzw3oCuWZUy+VdpJqCFao8XhT1tI2Iirew
         QbKl3hKIEKNRVjSFOeiRpaDl/FmeS3pyCugEpHzjECGYHCCPDYQ0uLdzYI30H37Ip5y9
         kb+ZThb5mARmIJ9qqYHPrHryuDdt1v6WaxVPnRwVuKmB+xvGiiL/mzIUWcxdw7Z5Fz04
         vjhOKn47aVn8AWW5q6phFnyC18gm/3T0CA9lgnbxW9ry0g4u6TCXGzYlkjvPbwj74QyV
         M5ur28FCxDEOYu6DrERf+/ekPGgI5nF+yiE11oiuGhD8wC5ZuMqoEw46eL9rO+vtHJmV
         T+qg==
X-Forwarded-Encrypted: i=1; AJvYcCUIX69mzCRk6ZUhJV1TEmStrT2veeMnXBZgBvWjntS2aeZ4zKeYx+ngaX6LZ6FTdk4xsfWiODw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdOGLQGIrauULz0g3PB2ALFkSzta0BXOEvM3QOEOXAEOgY4fm
	jX76f3yykjqDjWwLStWLOHf046ZCRoxKJRDqBS/86kAOB8g2GC/WZ7dG
X-Gm-Gg: ASbGnctRyaKJzxI8RUoGoCQ+fz1WwIm4vXs1zqtIgBAo1zJKcZWr4n63mUaFS3FPglX
	z3CYdKPEdkPqb/wgYnnpd/uM9rSx+PtbD323eJVoIMYj2gZWQ9d643/9B/W4yGDeWi4QCfpAdga
	TlBwFP4znwyHuWDdspteZShKyFPqJ1tGO8l+7+xpMahXbcgMwzuCagnD50HypnxnuW6vvJiDq6l
	z3FJ80YL24XU+FBV3WkpQuCKSHCBfkS+vtBD+xBSF5261AzrgG8jtbkb9CX1L9VxX/gVDg2PeLU
	tt/7Gz6UAIMDOCcoN+0lL6HVPccFg/ElHJl1/2O3mT3W+SR6ey10UwOjZVyyNwBTVE8IFbziLKF
	qPmI3Jv649pI17K+xhglUVx/SVKbdV3vLrjX7TLTztpeOy66630PXZaniu5SeibYH0skpo+zPGm
	pUQ5jYo9Wwq16R87E5PQ9n3pRbOQ==
X-Google-Smtp-Source: AGHT+IGs4gFYZBIVV1fjTHGphZnXYlgKzD+a9aYDimjlZ8q8xO5xME7rPi1k4V6dDmNpf4vWRqsscg==
X-Received: by 2002:a05:6000:24c1:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-42cc135db5amr25344539f8f.18.1764246925540;
        Thu, 27 Nov 2025 04:35:25 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:7864:d69:c1a:dad8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm3220718f8f.29.2025.11.27.04.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 04:35:25 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Florian Westphal <fw@strlen.de>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 1/4] tools: ynl: add schema checking
Date: Thu, 27 Nov 2025 12:34:59 +0000
Message-ID: <20251127123502.89142-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251127123502.89142-1-donald.hunter@gmail.com>
References: <20251127123502.89142-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a --validate flag to pyynl for explicit schema check with error
reporting and add a schema_check make target to check all YNL specs.

make -C tools/net/ynl schema_check
make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
ok 1 binder.yaml schema validation
not ok 2 conntrack.yaml schema validation
'labels mask' does not match '^[0-9a-z-]+$'

Failed validating 'pattern' in schema['properties']['attribute-sets']['items']['properties']['attributes']['items']['properties']['name']:
    {'type': 'string', 'pattern': '^[0-9a-z-]+$'}

On instance['attribute-sets'][14]['attributes'][22]['name']:
    'labels mask'

ok 3 devlink.yaml schema validation
[...]

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/Makefile     | 20 +++++++++++++++++++-
 tools/net/ynl/pyynl/cli.py | 21 ++++++++++++++++-----
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index a40591e513b7..b23083b2dfb2 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -12,6 +12,8 @@ endif
 libdir  ?= $(prefix)/$(libdir_relative)
 includedir ?= $(prefix)/include
 
+SPECDIR=../../../Documentation/netlink/specs
+
 SUBDIRS = lib generated samples ynltool tests
 
 all: $(SUBDIRS) libynl.a
@@ -54,4 +56,20 @@ install: libynl.a lib/*.h
 run_tests:
 	@$(MAKE) -C tests run_tests
 
-.PHONY: all clean distclean install run_tests $(SUBDIRS)
+
+schema_check:
+	@N=1; \
+	for spec in $(SPECDIR)/*.yaml ; do \
+		NAME=$$(basename $$spec) ; \
+		OUTPUT=$$(./pyynl/cli.py --spec $$spec --validate) ; \
+		if [ $$? -eq 0 ] ; then \
+			echo "ok $$N $$NAME schema validation" ; \
+		else \
+			echo "not ok $$N $$NAME schema validation" ; \
+			echo "$$OUTPUT" ; \
+			echo ; \
+		fi ; \
+		N=$$((N+1)) ; \
+	done
+
+.PHONY: all clean distclean install run_tests schema_check $(SUBDIRS)
diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index ff81ff083764..af02a5b7e5a2 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -10,7 +10,7 @@ import sys
 import textwrap
 
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
-from lib import YnlFamily, Netlink, NlError
+from lib import YnlFamily, Netlink, NlError, SpecFamily
 
 sys_schema_dir='/usr/share/ynl'
 relative_schema_dir='../../../../Documentation/netlink'
@@ -127,6 +127,7 @@ def main():
     group.add_argument('--list-msgs', action='store_true')
     group.add_argument('--list-attrs', dest='list_attrs', metavar='OPERATION', type=str,
                        help='List attributes for an operation')
+    group.add_argument('--validate', action='store_true')
 
     parser.add_argument('--duration', dest='duration', type=int,
                         help='when subscribed, watch for DURATION seconds')
@@ -168,15 +169,25 @@ def main():
 
     if args.family:
         spec = f"{spec_dir()}/{args.family}.yaml"
-        if args.schema is None and spec.startswith(sys_schema_dir):
-            args.schema = '' # disable schema validation when installed
-        if args.process_unknown is None:
-            args.process_unknown = True
     else:
         spec = args.spec
     if not os.path.isfile(spec):
         raise Exception(f"Spec file {spec} does not exist")
 
+    if args.validate:
+        try:
+            SpecFamily(spec, args.schema)
+        except Exception as error:
+            print(error)
+            exit(1)
+        return
+
+    if args.family: # set behaviour when using installed specs
+        if args.schema is None and spec.startswith(sys_schema_dir):
+            args.schema = '' # disable schema validation when installed
+        if args.process_unknown is None:
+            args.process_unknown = True
+
     ynl = YnlFamily(spec, args.schema, args.process_unknown,
                     recv_size=args.dbg_small_recv)
     if args.dbg_small_recv:
-- 
2.51.1


