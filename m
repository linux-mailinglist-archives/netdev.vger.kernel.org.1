Return-Path: <netdev+bounces-158149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE71A10962
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD9F188772B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDF315250F;
	Tue, 14 Jan 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUIg2GjV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170114A4F3;
	Tue, 14 Jan 2025 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865060; cv=none; b=nio2Ks/MZmtZwmSQFBPOb+5j1Eu4w6MuSrqaIL0ULDKEIRnnmIdYJd+vAzrFGAKJlaPBC1d7/c+J79IrxQPpjtLtH/c6CftcS+B/vE7ShG28hIBngH7Lsla6CatRG5Dn2Ug5GqMkYfeBjY4N7ayb8kd1beuzODeO82W4zvuzX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865060; c=relaxed/simple;
	bh=kH19/8G+ARXVXxG3Zsmf98ZfHUHinE6g2lyahxlFMK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jeJcSVYQatxjIBkfSABNDeMoflWmcWl+gYWMl3nj7dxASNbFzsX2ONtbwJ/sOzOY6NohRA5/oxFvSPCGsOwWjpcDSeGcpJ7ueSTDpNSUj7EkTzGL70XaihUuOQHTkUHowPQrZTC7V0LX7GOGGjDmciAECS9astQ9AOPYjlYYGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUIg2GjV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166f1e589cso117940745ad.3;
        Tue, 14 Jan 2025 06:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736865058; x=1737469858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmzLiqs3xurRkTvn6Vaf/B5i5AaWeH3iqyiYXY3lnJc=;
        b=AUIg2GjVFC/Y/FKM8nqnKxyvc2elMLG35MZz+2dC5Oi5E0BXpNcWPL2BkZ9/zy4EI9
         MgDWe76sv1lxaDqS8N0zGdOTsupKByR302JZMDrVbt9PwNI0EhoM9Lpv6lE3eYI9o2/e
         EF9mzgcNrNp8G7WLPDoQI0pKlAC4N91pUsrJPzokJ39P/vKvo57TIciM+VaD9FZFIk1q
         qD2UIcu0YPAhkXHqfS78BU2cdkvJOv9oysZ5UBxYHfDFp8QPXjfgadvFd849Ir4uSS9P
         Rvd3jQ3+/JdFMxTo2LUYrE7Vz2qLxUUdwNIjChoQNY1nF3CGCpq2C/H6kTq/D6lU72re
         vcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736865058; x=1737469858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmzLiqs3xurRkTvn6Vaf/B5i5AaWeH3iqyiYXY3lnJc=;
        b=Q42vgi6TkuoAzjauZ5hI2hj4zDcSiulLZ2RUfzjf7JVH7l+SB1UyaalXVUWZFTTZRN
         lWonq9WEeV0UtM+k9p/UqKh9QFM4ZxZt1ciaOVhPM7zKkIrYuxwoRbxm+hacaYdYASya
         hmsI7/menl7wtpGyQmzZh/H1Jdd0hFLMEskz5nD630rcK28/Yecbl5WdhV7FClS9Ih3D
         i+/vD/RE5jGSQd8CuLvF01ebb3eOfSKG3aYG5ajFAOaIb/tGc40aTrqqvhm/jmQi4NP+
         AEw0QhVgjEggngha4QC1r0qOilntTDiDZLwltZVFtW8y5HNMJxx1W0CPvnbS9ul0/guE
         DzWw==
X-Forwarded-Encrypted: i=1; AJvYcCWaq+1kQLYYnBWzhSF4qLJ4BcZE5A2iICiE+Dq7UmwB2svQJGwsJA08e8NGdBwZVBwihf/ZvPa+V4o=@vger.kernel.org, AJvYcCWe8iaaFy6UzLAjYRBYkv5FbBZv0jjHh494Ln0DV2/ZvbY9P3/Rv3D68Le9H3MrXx2umpqBIbwC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5q7Arigb9y/RRMRvBFIpHJOxxBKtoUc30FsF4HL4Gr70trtQS
	L530Eke9xNt8LTH79DMrnZfAODreJ5UMc0x9nhX4ImRoorcuS9fR
X-Gm-Gg: ASbGncu2kf0kRgeP5Zto986HUXhIGK24hIqrc+aYB/q3ODzheKjxO1HkzfEw77FXDYz
	M2gLyIOZ/8K6j/rqQCowEjKlZ2W94gGB27mW8zzAjY/P2QFbjJXsCu9nkfRH1qkcWDSZpOZSZX4
	N5Mh4v6QUesjlnneMk12n/KI9Ox8XGYKq35Bbt+KTttITAfSO+GeAIP9XqBP1UTg57P97XIt9Th
	YAvM5mgXp9oRP9xhhvbdx/X9a0ECE82pWTkh8OL+08p/g==
X-Google-Smtp-Source: AGHT+IGYSckeLtY6LvPnxNoHRuEEag34sM1JW1zzC+Q67vRnk5HpMTDgqip4uX0kaYvGw4IDrB1Afw==
X-Received: by 2002:a05:6a00:170a:b0:725:d64c:f113 with SMTP id d2e1a72fcca58-72d21f18064mr38564183b3a.3.1736865057673;
        Tue, 14 Jan 2025 06:30:57 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dfesm7474582b3a.156.2025.01.14.06.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:30:57 -0800 (PST)
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
Subject: [PATCH net-next v9 10/10] selftest: net-drv: hds: add test for HDS feature
Date: Tue, 14 Jan 2025 14:28:52 +0000
Message-Id: <20250114142852.3364986-11-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114142852.3364986-1-ap420073@gmail.com>
References: <20250114142852.3364986-1-ap420073@gmail.com>
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

v9:
 - No changes.

v8:
 - Use ksft_raises.

v7:
 - Patch added.

 tools/testing/selftests/drivers/net/Makefile |   1 +
 tools/testing/selftests/drivers/net/hds.py   | 120 +++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hds.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 469179c18935..137470bdee0c 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -12,6 +12,7 @@ TEST_PROGS := \
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


