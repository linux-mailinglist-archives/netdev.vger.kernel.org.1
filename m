Return-Path: <netdev+bounces-247704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5914CCFD9EC
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A9D6300A9B7
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1773161BF;
	Wed,  7 Jan 2026 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3+G9jnD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDCD314B9A
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788538; cv=none; b=sqYOEGdIHcM52OL8Ce9QXKkog6L54nVQAqEuWAHiTe9xW29KBITruHhsNfLXBuWqMgJim8OfZryPg9rBf3YQLobrn8lVvByxO9IqAvEI1kClocwc60HCEmkY9Pr3NWrF6aDPwAGjG9cszdb0O407bBsV/ixloDyWmuKw4K7/1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788538; c=relaxed/simple;
	bh=Q4ZqUeHdxj8w0kNEPzoysqUJgGoxPgA1XB5F+ofXapY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYuYUJzbUTDfUg812Fsby/SOjIDl2dcV+r4KrmRMW645jptKHjCXMjXb6uAkT1diRtVxuat23Nx3Z4cr5alnT50yE5WJCZ3MbINOWhc+7thA6lDuqtKdTzEFykjNwoLIqdbTcIIbwhrjdN6+otQlaJ27bgi4PCBrrlm2XvI4j3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3+G9jnD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so1180084f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788535; x=1768393335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2Lat8SdX+02TbmLDhXK9YgQomayPj4Tjy+cMyjwyFk=;
        b=e3+G9jnD6SyE+1ipEAjcougs9hqzvu9iQZ90we/e61pbNkHiwJuKugTViHBbEDuDOW
         22obTnkjGzPHpWibpWHI5cWoihazSkJx7nF93Fc8xwzQZ7NlEVR7ht88XC1KVphfTgpP
         R0HmbRgavlAHVOE3TKfbwgRzuPemeVbY9SikcRViLIRecgJXa1Ke5LhxPnSOqbjRzyMv
         97BD36v+Qirqi21vhQSkEYMMVd6ohyEIP6CXr6g+/Cl1iC9J1eqBLxLi+7YE82HrNQCq
         zTpakHWDBgYt1x7fW4tDoccF6fxGvKfZS89ka855GoDCRAtshEY8q5e5w84Kz3TQgAQ+
         pjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788535; x=1768393335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+2Lat8SdX+02TbmLDhXK9YgQomayPj4Tjy+cMyjwyFk=;
        b=w3bzRyxa7tYyJDsl4K+qHuxRid5UZDUT++MT+Upysn8Ek3mxPEyN+GYXxrXhF8s6UD
         s4Xs9KHTlz3xBN0ddDZRQmGm+DRmKdP9f8GRMRbgucjo0K4DEkh8twt0plbf6bsi3m7i
         Dxhcftk5vcUXjmVnzTRz8XnHv4U2FM+YKrlBREhVA+po4Jmu99+Yo4ShDd2QNP+jczrh
         JzBjRWf7Xfx0Q3Q6NAHfTW9lvgo65QEuSHp0jGdUI46KLfgk05+lOjDxBHS86nVl/xzb
         VDYQuGqt1k1P4zySgxEuzBAsTIgJJ+M0KlJ4fnjW3S1HX0saCA9WkB8Q2ObGdH60ADMU
         r77Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDSrkp0uCSObRaxswmHZmqvIL/GXGWKtI7vv2E+BFGas6MmXo8l3OQst1FPdHJ+MDVbbALiL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaAk8wwxzpMCoJnaoYCFLuTAG6jg89HdpAkhiWkfae8mFxt1w
	FAGA4WG63Xs4CMvuXebOT78xINyMcldX1ICI00KsA7i3I20O1ClfaD5i
X-Gm-Gg: AY/fxX6F7IrmL5nH2znjCWnx3djq6X98TasCKRd9/4EozugYOLmWnW/ofEKpQHRZ1Ee
	fa2DXdAEHTfWc9swX8ZYe05ogtbcafLzzGu1nxClXZBYsjYGXRBM2OZmE+yc6BzuMAwvFO9sNmk
	PGFN/SWUGNkQGjyDubeMu21KfiFafNC4DFSHA+rQt+x8a6zKjRPt5AcYVgk36YMIGP0XpdEsfKY
	iaIFbcfLXAHtk1DSkryI1VL4toc+pYMe6wd8GFSJoqUL3VMrHn1MsPZIZAHuoyNT2SThFhWg/SW
	azuv2tu3piqBKnTZOKAvG7aqI/IBN9kPKOE0zj0N65z3OqIIboE0XFNz0GjM02uc72a+W799/Cl
	9u9Y5D5Bt4bOoRkjnXXds5adqhqw/tn1COm5b9+VxFNzwMavcVVVhnQtb0LHpFZM5bpLW7CnI1j
	cbDOzc9Jox6OThwWfKFEzzRtO6dr1x
X-Google-Smtp-Source: AGHT+IEAEEOMloGtBWAWlq//SXxp8JdbjV1Xe8Xns3g8sq+4RlTi3G3ATBwUL+bMJLZKOmriMZD/VQ==
X-Received: by 2002:a5d:584c:0:b0:42f:9f4d:a4b2 with SMTP id ffacd0b85a97d-432c3775a07mr2858945f8f.19.1767788534546;
        Wed, 07 Jan 2026 04:22:14 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:14 -0800 (PST)
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
Subject: [PATCH net-next v1 10/13] tools: ynl-gen-c: suppress unhelpful pylint messages
Date: Wed,  7 Jan 2026 12:21:40 +0000
Message-ID: <20260107122143.93810-11-donald.hunter@gmail.com>
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

Disable pylint messages for too-many-*, too-few-*, docstrings,
broad-exception-* and messages for specific code that won't get changed.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index b517d0c605ad..14d16024fe11 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1,5 +1,11 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# pylint: disable=line-too-long, missing-class-docstring, missing-function-docstring
+# pylint: disable=too-many-positional-arguments, too-many-arguments, too-many-statements
+# pylint: disable=too-many-branches, too-many-locals, too-many-instance-attributes
+# pylint: disable=too-many-nested-blocks, too-many-lines, too-few-public-methods
+# pylint: disable=broad-exception-raised, broad-exception-caught, protected-access
 
 import argparse
 import filecmp
@@ -11,6 +17,7 @@ import sys
 import tempfile
 import yaml
 
+# pylint: disable=no-name-in-module,wrong-import-position
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, SpecEnumEntry
 from lib import SpecSubMessage
@@ -183,6 +190,7 @@ class Type(SpecAttr):
         for line in lines:
             ri.cw.p(line)
 
+    # pylint: disable=assignment-from-none
     def arg_member(self, ri):
         member = self._complex_member_type(ri)
         if member:
@@ -280,6 +288,7 @@ class Type(SpecAttr):
 
         code = []
         presence = ''
+        # pylint: disable=consider-using-enumerate
         for i in range(0, len(ref)):
             presence = f"{var}->{'.'.join(ref[:i] + [''])}_present.{ref[i]}"
             # Every layer below last is a nest, so we know it uses bit presence
@@ -414,6 +423,7 @@ class TypeScalar(Type):
         if low < -32768 or high > 32767:
             self.checks['full-range'] = True
 
+    # pylint: disable=too-many-return-statements
     def _attr_policy(self, policy):
         if 'flags-mask' in self.checks or self.is_bitfield:
             if self.is_bitfield:
@@ -1650,6 +1660,7 @@ class CodeWriter:
         if out_file is None:
             self._out = os.sys.stdout
         else:
+            # pylint: disable=consider-using-with
             self._out = tempfile.NamedTemporaryFile('w+')
             self._out_file = out_file
 
-- 
2.52.0


