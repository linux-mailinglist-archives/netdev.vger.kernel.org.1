Return-Path: <netdev+bounces-155027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C610A00B1F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A191882E1D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15241FAC57;
	Fri,  3 Jan 2025 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imTu2s/m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503251FA140;
	Fri,  3 Jan 2025 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916710; cv=none; b=RhRiErTzW4296RAT4L9dideMu5EuWv6Gfs4jWVy2hDPnkzkn+4s9iund16NU8F/lse2VNjDTWdeLpGzM5SQ/FRBfFw3QaVewHo5zCFtqmCTOYSCVPkC0BdkW0Vv3lzbu/yBoBoBrgn5vGO5if6wPhfl+CrHl2RaE4H62SpVb/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916710; c=relaxed/simple;
	bh=g+xedStwdu7vqJHteeHoaifSNpz/JPjXv9xm04kRPn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLVdRW7AqidA+/ahCkB3ulZVLX08UGMHW5ug6JHGmQA1/ZKRMWEQo4nfPPu97YxN0l3uukNk7ogCOUx4GhptCJhiAw8/BhNG9/tC7FvuS+BLfI0jHQf/LDm8FIXSqGR30Bxc8tJDsEEy/yl7eUWhXmuqmiy+CD8NRcwVPy/oXAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imTu2s/m; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so17680573a91.3;
        Fri, 03 Jan 2025 07:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735916707; x=1736521507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HL+ntJjREdI9rDbxoGOYSFvSnek5hf/Fz0N6hXv0ew=;
        b=imTu2s/mIWU4rbq0XcbvCQvdTUEtQsvCmx074uG5mel4jAXHSC2pAff3LAiSnVkzPz
         FPlVrFRD2D/TzC4qj9pAivfPZ5plnM+dcdz3LqURLElcT4xllU4doU67TjfE4UFDEHgy
         +STCkCp5hMJgQePrl5KrHv0u2j15XpsTGex8izRCWRjFpVk80NWAsUSrwXZsVY63G73T
         4TaeClN09GF9IEIcG5c1pk3DzCe4Zh173SmIbdEOF98UtuXwUECWE7oMPkKnklUOzBSN
         GKJr9NJHeDMgC/prVxl3HWP3k/IhxhLWt8ItJrpbx3THZkxBcoBCleudraZJ7WhFGmE2
         RnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916707; x=1736521507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HL+ntJjREdI9rDbxoGOYSFvSnek5hf/Fz0N6hXv0ew=;
        b=opQZPS7fVFkxLX6o3CfExSXBtXGdHMixoN5l8VsCMAy1w1mKTHyxiBUlSC7ZPcAS1z
         Zh7q2nHqvOtqdU9JzoZPDinrhSCzWmJNmZ6QtTq09eXxO77GYQD+dGeiewb9MZKBHhcV
         WsH4u7+928+gBZumNnlt6rXIFaH/aG7108Fd0c6x0QMaI764ZUk/iXkLGyYa/dSMfrKy
         +6V5PTBO/leSrL7acA9x+I2ubtM1ND8hs1ISHs5bsayDUWgbpCwf123Sla5+77+cb6Pa
         tAplddrOBJC1GQOZb5uorM/Qg7YAxhkMjwLLtZtprisokihjhlXv1U5+DU/A+ZoCmx2E
         vy4g==
X-Forwarded-Encrypted: i=1; AJvYcCUap9Of2FAActr4KD0UNBmePoWiUhYVA7BYusAaJqJMk5lq9bakWrxPke9glSQkk7cNlgXeZOxHzto=@vger.kernel.org, AJvYcCVCUpCEsIZ4+CIb8n1aiebCXRn2PPDIWkBvuub8QAFQhuzDLY3dZmpL58k9pMlm244hTdAVVroL@vger.kernel.org
X-Gm-Message-State: AOJu0YyuT2kwFCN+UL86hQmh6MQwq4K9h5Z39ILpzPJPba7AnLaCippy
	q9HYfwgpb5UB3CK9E9tBhLRjlsOgNllpWUQRh4VGNxExnTCRazsD
X-Gm-Gg: ASbGncvlLZq82RGZ65r6vus6Vkr21kwNVcmLZIjn8RHj7IjGBNdYUqrDwK5lZb7hj5X
	x7i+7f46tYPZz7yI01MF04ebLOmMT0xMo1TxV5Nm9gdVemCH4v+Y3HRzbCQe1pkkq7M+oiZZ+oz
	bA7Zxt2RG97sJ08hqmNiPmlpRlyZDI/V7ASVw6E2BmxtDRGBApO9GRXcVNigO/crnzxjj1C6gzF
	p1Ik6KtKlGwWfT3sgrkPpcLIJt0kJ5aeICel7KferYVmQ==
X-Google-Smtp-Source: AGHT+IFjMExgn79GILTUWDI+IttGXsuWX87E8XDfkKQxOQrTRs9cFV/F0fmm9JsGRsUA12UNI9SynQ==
X-Received: by 2002:a17:90b:3d44:b0:2ea:696d:732f with SMTP id 98e67ed59e1d1-2f452eb12a3mr73835660a91.29.1735916707402;
        Fri, 03 Jan 2025 07:05:07 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629d0sm247047255ad.41.2025.01.03.07.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:05:06 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v7 10/10] selftest: net-drv: hds: add test for HDS feature
Date: Fri,  3 Jan 2025 15:03:25 +0000
Message-Id: <20250103150325.926031-11-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103150325.926031-1-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HDS/HDS-thresh features were updated/implemented. so add some tests for
these features.

HDS tests are the same with `ethtool -G eth0 tcp-data-split <on | off |
auto >` but `auto` depends on driver specification.
So, it doesn't include `auto` case.

HDS-thresh tests are same with `ethtool -G eth0 hds-thresh <0 - MAX>`
It includes both 0 and MAX cases. It also includes exceed case, MAX + 1.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v7:
 - Patch added.

 tools/testing/selftests/drivers/net/Makefile |   1 +
 tools/testing/selftests/drivers/net/hds.py   | 125 +++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hds.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 0fec8f9801ad..a3bc22b32f2e 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS := \
 	queues.py \
 	stats.py \
 	shaper.py \
+	hds.py \
 # end of TEST_PROGS
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
new file mode 100755
index 000000000000..94790dbb0eeb
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -0,0 +1,125 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import errno
+from lib.py import ksft_run, ksft_exit, ksft_eq, KsftSkipEx, KsftFailEx
+from lib.py import EthtoolFamily, NlError
+from lib.py import NetDrvEnv
+
+def get_hds(cfg, netnl) -> None:
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        raise KsftSkipEx('ring-get not supported by device')
+    if 'tcp-data-split' not in rings:
+        raise KsftSkipEx('tcp-data-split not supported by device')
+
+def get_hds_thresh(cfg, netnl) -> None:
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        raise KsftSkipEx('ring-get not supported by device')
+    if 'hds-thresh' not in rings:
+        raise KsftSkipEx('hds-thresh not supported by device')
+
+def set_hds_enable(cfg, netnl) -> None:
+    try:
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'tcp-data-split': 'enabled'})
+    except NlError as e:
+        if e.error == errno.EINVAL:
+            raise KsftSkipEx("disabling of HDS not supported by the device")
+        elif e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("ring-set not supported by the device")
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        raise KsftSkipEx('ring-get not supported by device')
+    if 'tcp-data-split' not in rings:
+        raise KsftSkipEx('tcp-data-split not supported by device')
+
+    ksft_eq('enabled', rings['tcp-data-split'])
+
+def set_hds_disable(cfg, netnl) -> None:
+    try:
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'tcp-data-split': 'disabled'})
+    except NlError as e:
+        if e.error == errno.EINVAL:
+            raise KsftSkipEx("disabling of HDS not supported by the device")
+        elif e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("ring-set not supported by the device")
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        raise KsftSkipEx('ring-get not supported by device')
+    if 'tcp-data-split' not in rings:
+        raise KsftSkipEx('tcp-data-split not supported by device')
+
+    ksft_eq('disabled', rings['tcp-data-split'])
+
+def set_hds_thresh_zero(cfg, netnl) -> None:
+    try:
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thresh': 0})
+    except NlError as e:
+        if e.error == errno.EINVAL:
+            raise KsftSkipEx("hds-thresh-set not supported by the device")
+        elif e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("ring-set not supported by the device")
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        raise KsftSkipEx('ring-get not supported by device')
+    if 'hds-thresh' not in rings:
+        raise KsftSkipEx('hds-thresh not supported by device')
+
+    ksft_eq(0, rings['hds-thresh'])
+
+def set_hds_thresh_max(cfg, netnl) -> None:
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        raise KsftSkipEx('ring-get not supported by device')
+    if 'hds-thresh' not in rings:
+        raise KsftSkipEx('hds-thresh not supported by device')
+    try:
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thresh': rings['hds-thresh-max']})
+    except NlError as e:
+        if e.error == errno.EINVAL:
+            raise KsftSkipEx("hds-thresh-set not supported by the device")
+        elif e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("ring-set not supported by the device")
+    rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    ksft_eq(rings['hds-thresh'], rings['hds-thresh-max'])
+
+def set_hds_thresh_gt(cfg, netnl) -> None:
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        raise KsftSkipEx('ring-get not supported by device')
+    if 'hds-thresh' not in rings:
+        raise KsftSkipEx('hds-thresh not supported by device')
+    if 'hds-thresh-max' not in rings:
+        raise KsftSkipEx('hds-thresh-max not defined by device')
+    hds_gt = rings['hds-thresh-max'] + 1
+    try:
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thresh': hds_gt})
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("ring-set not supported by the device")
+        ksft_eq(e.error, errno.EINVAL)
+    else:
+        raise KsftFailEx("exceeded hds-thresh should be failed")
+
+def main() -> None:
+    with NetDrvEnv(__file__, queue_count=3) as cfg:
+        ksft_run([get_hds,
+                  get_hds_thresh,
+                  set_hds_disable,
+                  set_hds_enable,
+                  set_hds_thresh_zero,
+                  set_hds_thresh_max,
+                  set_hds_thresh_gt],
+                 args=(cfg, EthtoolFamily()))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.34.1


