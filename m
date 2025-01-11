Return-Path: <netdev+bounces-157427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AA2A0A446
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC8216A546
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C71AED5C;
	Sat, 11 Jan 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej+oP8at"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B41AA1D5;
	Sat, 11 Jan 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606843; cv=none; b=Wpcv4f9YHAgug7F3G0TKow4ToO5bJ0p7iGuxZoD6qta4Fcqh6aDVbEM87DlMLtj2qGf9oE/MyYOYLavpO7AW1ce3b15OModJQolgwB5NqACxmiBSClrfkApNjS2oIBGdyFpLpCRkHWHR3flpHwYz4da98OY8Ym+ldpFAeKUa0Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606843; c=relaxed/simple;
	bh=JmAGQTkukDDimWXHhCgRtGxrqjNAOsiaA0lMqKcmRYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZRv1PRLERXiSBKDKpDVuLGH1FD2BzdUtLIod8IoGMZZreTrxQYnpiFaTHtFQVrRhwcU11mydOEcfvtGhp9ws4ZdVdhkhhKlax6evjsAtgda31HKCbr6y+4WdjOWKh0jpaca2HczdUCCm1lG6SjHrcsgnfpxFa87kHaZ9RomWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej+oP8at; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2161eb95317so50102795ad.1;
        Sat, 11 Jan 2025 06:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736606841; x=1737211641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srPGR2762tzMufhIappCTxxPpiqvApN8ZVTAHeK3Y+w=;
        b=Ej+oP8atWUckTWrmiEjmhY+hbv0jvzZQ0tOxhIO9C8cLcd1eTWru0DlU2YijKuNgcV
         TxBhIHkyX9XVtJ0TWlTmkXdIUC6JuBesMa70kUKM6hwX3alYkct451yxAe0oI0EhvJV+
         ZUBzgRk5L7+RAUYTNiD+iL3SalgHsm+KQSSVb1rkUhyJHCiFN4ks9CiR/9wg2b/PxMOG
         z2Lyc9iSG+f2bxEUHO3U8puENpu1gsuKWoCoA4mGQZSnicnRBvSahHmbFJMJdZsCOd5R
         FIAV8FEPm8Kcp1eQaJUtDrK5Xk7a+dpw6alZ1HZ4AhYUiQ/HzPeWhAKKatabRf2cB0+V
         195g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606841; x=1737211641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srPGR2762tzMufhIappCTxxPpiqvApN8ZVTAHeK3Y+w=;
        b=UWkMgMMgBg1yt7u+JEr4I9TpY/kCv848rh+8we+DgWuNUgglwAEULSevkNPdubKpJL
         zLDk5ggFosoJrrk6Nw5Ui90wFf0Ss6GtJjU8TObonZs/sJxuqTfI93NCmYsalHALmR74
         Yef18w7Te7dJRcb4D4eZwv3XboZm4zHzgE9pVui2x0cvS2o6g/X6Z9ASy7gMiGeBbm2j
         Qr2Nsja00CUOmNJx1Cl/V23LFjyY2HiMQIRmZCDQ/YWY0fCHSTqXQnnL0Z9l+QghtWPL
         evajW5fo48XUA0CUSnMjaBz2IEL/EIYjUJiYIoNWC8iBpWYaImClQWq3LQSmDk7ftNc0
         qvWA==
X-Forwarded-Encrypted: i=1; AJvYcCXO5LHvhBXOafJKOuka/Mxl9uRg8P4Igp+ZtcqpHBVtXP6WqfaJEDkxddWY1+ORFD2BR7oAeKIZ@vger.kernel.org, AJvYcCXks5j9NmBGzJC1E30NLIpEkz4Df5tmRAr35mlA97KWvPmyHh/BNZmrHJHwDqJTbeuRwzWz8Ho3fUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws6xNQJRKVok98zsJDMug+FuMDYcCHBPQ83jITqgjmYTzwNDXv
	rETeENIiZ6F0Fwp/buR6gyZw1lPSrC5t82KVYpSR1NqiLvep8Cj0
X-Gm-Gg: ASbGncsYl5y4fohRuVuHtFh80aZHAGGi+iomuQa9HlYYBS56wyqKgTx4Ui7pque7/cR
	KMMYXMfnzDWpvKDR6eIXLUSOBuDaQNElPUzqJCQ7W2moyJl7NnZGWNTqv0a0+nlFnbScCcqWO/Q
	V444cfyXIMD3+umOWlflBG7tRQzBqDX1Qg0HJmY10OTxzatmWjdoFAHxLm829dTMsKIw7YJe0C6
	4/KRcPpjd6v/CIuH5gn8whP56P5+LojECmc/y/fLwtoLA==
X-Google-Smtp-Source: AGHT+IG2xo7ONGH/g5V8MI8GwF7wwP8i/mUQoZTRaDIl1M8rkfJBkZZXBR7kGaC+C8JA6emWVkcxJw==
X-Received: by 2002:a05:6a20:c703:b0:1e3:da8c:1f3b with SMTP id adf61e73a8af0-1e88d09d877mr24054953637.28.1736606841139;
        Sat, 11 Jan 2025 06:47:21 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40594a06sm3097466b3a.80.2025.01.11.06.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:47:20 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
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
	linux-doc@vger.kernel.org
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
Subject: [PATCH net-next v8 10/10] selftest: net-drv: hds: add test for HDS feature
Date: Sat, 11 Jan 2025 14:45:13 +0000
Message-Id: <20250111144513.1289403-11-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111144513.1289403-1-ap420073@gmail.com>
References: <20250111144513.1289403-1-ap420073@gmail.com>
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

v8:
 - Use ksft_raises.

v7:
 - Patch added.

 tools/testing/selftests/drivers/net/Makefile |   1 +
 tools/testing/selftests/drivers/net/hds.py   | 120 +++++++++++++++++++
 2 files changed, 121 insertions(+)
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
index 000000000000..394971b25c0b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -0,0 +1,120 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import errno
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
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
+    with ksft_raises(NlError) as e:
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thresh': hds_gt})
+    ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
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


