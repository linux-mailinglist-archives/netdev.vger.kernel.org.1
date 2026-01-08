Return-Path: <netdev+bounces-248159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3799D044FD
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C1893000098
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6370B2DAFD7;
	Thu,  8 Jan 2026 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJV2aMoc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC032D9784
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888858; cv=none; b=MEP3iD4rF7RbHnRkVYHncx9zjRy04f7rYAMXy2H0Uj3JTRT9KImPhYtu99Af2pKjUOSR57OXA1Ro89idGKOcxIs3y/Yml797iLHrvHuP3JLfJBz0vGPcoTQySk3P6XJLe6DxjYFQIom8X8OyeMu96sbbjHD0xWQFzJZW0GGnf2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888858; c=relaxed/simple;
	bh=Q4ZqUeHdxj8w0kNEPzoysqUJgGoxPgA1XB5F+ofXapY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoIY8k/9cmt2FSuBX/Ba6lEVUjUrTtE63dBrkCSsnLvtuueAhxQ/mOjz2llCDunxUj+TnQep7pCQ4NmIveJ+GsuKUiYnrMUVhJ37QsO5Q4HpDMKkX2DyZzZnV9lulTiGMw7ht0qDAZvPVE7nea3h8n/uiL6s8FhZyqhEkESuvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJV2aMoc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so1725428f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767888854; x=1768493654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2Lat8SdX+02TbmLDhXK9YgQomayPj4Tjy+cMyjwyFk=;
        b=YJV2aMocaEDevN6qUL/PWkBKxC/1o+WtCN8nPokdfoZnARAwXgLf0nHnkLtBCcDpDN
         reUdBHUCmhlZSFyXLsO7ZNkAOujARnaLkH71Po+hQIkGhN+J6At07hqzDUwpIKCe4hIq
         qvLIow33xGnmgJSSv/07Qux/d3sYo5WLokQUiXBBoq8rwz3BS6lYQzW5nl2TsKT29oIL
         min2AJUvaleehWRJtMoAt4jsKNNf8s8lkZEdLR982rzYuU3YIGL2XNH+EPRuFWWSsmPg
         1awFYW6qEmmrB+uPQWqIrMbJVn3TsAbKT6dPyq13KanvpJmEdAmruquKF0iXQYD64D+U
         3VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767888854; x=1768493654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+2Lat8SdX+02TbmLDhXK9YgQomayPj4Tjy+cMyjwyFk=;
        b=jupa7m29TB95UWDp0/Am0O06XNC/tWq+Dw1zSAw2HFIcMjo/EnWQijrTvOikPS06Oe
         USUX4fsr2i7wc0QvvOummu96mXbKuY/zMEViDcGNIlI3AgV3s3b1IqMT9MbneuWrU2tq
         kCkv7gIRGEA52Kha/d6FzXracOtsag++po9+9M1YbdUWKzEdSzPpaP9wB92STGdkYIkl
         0kdj+YW5pwvUfsNf9CEgbkJAfwh5rAErnYqFQlOh/27wgfw59L0m9xCuhM80FwaCXWQR
         JesgwLE2V1UUYPmSNnjmyw76l5OM+FRiWw7DQcbUE1w0fW7Hrn2hGQsTIfRWyXJ10eqV
         F+NA==
X-Forwarded-Encrypted: i=1; AJvYcCUFG9Imxr7FzDoHo+G7n1RlVwzaWZhdR98jybw+i+mvt9l9p6HtGHoSUx3CPw3lnViImsTVi6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcIEp22f3G3oPN4s2FzDU+0mCywy/ERKliKDO6NRkni5irG0U
	ttR0W2yGbubq6vTQYfHAyuNpo6m8Ca4ASBkwDpVxnvt8Uk3xyNdAGozI
X-Gm-Gg: AY/fxX6MKGn1+ONRGf18U7KUpf3IMjA/+n1nKf2+t+ikPj8zytZNW2sh1K7zDcLX+0y
	5gTxFtx6/oshljkJp52/Ynea/RgMimnrSmmOSvt4bKBbT1lDvcTyjhq3+PsS4K1jcPDkRk6F09I
	R74Xute+StmAbC3BtgaVHo93R7URfcmQyiB+PKjahdNCoWqqAUmkIHwdeDsEouBNS1tg04moXnf
	kY3tme+UtrFWO2VirmQjTNHsOfyCPwO5//r5RMPlJ7qWrKps0nmQSIxJFlnn51gA0ZIFVZZ4q/s
	KKayYa8wufl/er3Y5oRdP0t/wuTTmMabAhsOKyzzVI2bFz0m4z2H0oNEJR7Ro6bYQnwhfI2DtjW
	sMX/DFBIRlEXFZuQbIFq7dqbzZE1w6Ocba8lEstwKz13W8dlc+HcfVhz70ODugp8x/3JcNPlZUp
	ZZCrtikAuJhoIElg/RxOj7dMXxpKaEbt8yAbPNoxI=
X-Google-Smtp-Source: AGHT+IG1vgvpzx0rhxyfmBwtGJ+0oxYBD/K8EASvXCLfiOLuS6bmIi+Y2CjqHx/QQTzroKTX0qFSeQ==
X-Received: by 2002:a5d:5288:0:b0:432:c37c:d83b with SMTP id ffacd0b85a97d-432c37cd9bcmr7538529f8f.20.1767888853988;
        Thu, 08 Jan 2026 08:14:13 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm17140039f8f.29.2026.01.08.08.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:14:13 -0800 (PST)
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
Subject: [PATCH net-next v2 10/13] tools: ynl-gen-c: suppress unhelpful pylint messages
Date: Thu,  8 Jan 2026 16:13:36 +0000
Message-ID: <20260108161339.29166-11-donald.hunter@gmail.com>
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


