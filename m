Return-Path: <netdev+bounces-241021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BDC7DA57
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 01:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CF05352171
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB1A20C48A;
	Sun, 23 Nov 2025 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="VBtO1Hus"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839161FFC6D
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763859079; cv=none; b=JlB2Q3xJSWJkJBxbi2H7ORK/n33h6qu173/+53m0D9IJ6BN7iRacQnvCmPc0nU8+4b3EafcrA0u6/jFhTU7j9+EhaPTqF6W+LI6i2YkLmlua/SdqDRkoktxRhfLHMA6jdp65iRBa2eg0mPn8UMfbKB1Xyj7h8M0iJYpb7433rWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763859079; c=relaxed/simple;
	bh=plPjQjzSm4CsjzhvxhNf96HVNc3sus3tTa8I9P3oq9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qP1bywdMDeHz0J0n3Aj0OEr0hCl4AVRVfc0umDobpS7nZoB5VwJ0KMVIGgxd3va3SH006rXNe3PNPTG7dG52PWM1RW1XjPC0efhARx+qSgw1oJHnnBm8oF806aeqs75j6ea9mz3IDsPfH4X0ra2oKOwJSG1+vnYcVWdV/7NwNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=VBtO1Hus; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c6cc44ff62so2201225a34.3
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 16:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763859076; x=1764463876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK0RuD/pi4a292fzx9qFYujf5c/UgUgZIYtMqF70Xlk=;
        b=VBtO1Hus0pf0s8S/YDWRAf8KoW1VsT7MDjr1Bgxkfa6CTmLoKaHf4Zx526R5ELlrWx
         e9uWluzsjq03dATY4LnWDJvdFMB4jkgb/10jdgSlSJhj+XHxRqspUe20idgY8SgxOAOi
         1bkNWNoOJgVASknFLIGetsjs8qP52b4MYmF1oKIdbXbwDcklDQjtZVXPMmIhPmd8jJRh
         +NaHwzF5s1iJp8XbwHmtfGii1kSlllLwRC2YBXTbHriSRzm5hFXelm1VZWFWXNxiRtba
         uq1ySzAKju20jjmS5fuSxCk6haH3mWITP9WWRXm53vRfpd+edJTSuB7VAspC0MPAEh29
         TUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763859076; x=1764463876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hK0RuD/pi4a292fzx9qFYujf5c/UgUgZIYtMqF70Xlk=;
        b=Jj1nklL3Ymr3DlyhA+id1f/qQbzEv40FMdkF6O8JEq9QgmQAtiDXOUyXMUQamWORhN
         8xyedlNAoQ+gGet8BaXqtr2xagnuW8w8nEUbnJh6LAoXc47sIVgfhoT967ORagNI+iff
         4zXjKN3PNqaYB5Hjekbe3UOaJbxb150EI2Md/4I1ZZdwnN/95cQ/wK1sS5luqGp9DF+1
         pou6xzxhU5625Q96qiIZHgWiyketaHrQc2QgjQQQcxd30aLDj2YUa5Vyv+uZfUHXrmT7
         3geLsUqZcoaR4lnJ1SGSOPvd4rsDjh/MzSHzQb4MigvaCRckmUq+NMsfHkJILjo1CY5Z
         UiPQ==
X-Gm-Message-State: AOJu0Yy6mOSFgwAs5/PHHf0x/d/awnsVM5CI9+WIrZv/Khq4fwWvX0bE
	W35FAe9bK/Pgk8t8+sLIDPvntgkNK55SWkKNKQr0B3DDsTjH3nudq6PKSNqO+v4s+alVFdIEZLM
	XrMu7
X-Gm-Gg: ASbGncsbsxyeqkOGftwNvNyuDocb4lunZ3aAa20TwNWboexGCv7+Ys8Xx3rnYtWX8Jl
	Jrd7s68iIXkJs0X7NTrswEvfRfIgNC/1Wh+XHThwFwSLudZDwbHeIn2SfTbpa+IW95rzm7VaqLK
	1sFpH8WPQUZE/zX8L+G5AnQqkYbMiKQ03Ih9iVT2iClpwjnRR/m1sGcumN09Y7vzaQyn9J5kJFj
	43taI/iAat6F7HE8Q2YYBJgE0OnAi8ETUgqNoQqTUkjH8CK2pcSDc9+QIqGPcrZAaW8V1RCh+8b
	4ljmkda/PpNBLAUZyge2PcKuBygYlPTyIH5Mttux9QEls6zVrcNb+TV1AyVyS7hbyd+gfUMJ/eI
	y86EsttiiHWpgZ6R8xsuQGKFQgsUhSRnT6pTspRryBuL5M6FMFkrvCbuusQrubnnvME64z9/hn3
	byv22fpAhIaLezmhXHxY4Aev/dDy0LWJ5tOFW7QIpk1A==
X-Google-Smtp-Source: AGHT+IGggPgG0Yh9FzKLfk5rh9Gnc0ga/O8aZxaDIbrwVw5pPh1rsEhZ8UZF79jdExFjZIz28ACIQA==
X-Received: by 2002:a05:6830:442a:b0:7c5:3045:6c79 with SMTP id 46e09a7af769-7c798b58613mr3363931a34.1.1763859076746;
        Sat, 22 Nov 2025 16:51:16 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d42801fsm3823848a34.27.2025.11.22.16.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 16:51:16 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v2 5/5] selftests/net: add a netkit netns ping test
Date: Sat, 22 Nov 2025 16:51:08 -0800
Message-ID: <20251123005108.3694230-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123005108.3694230-1-dw@davidwei.uk>
References: <20251123005108.3694230-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set up a netkit pair, with one end in a netns. Use LOCAL_PREFIX_V6 and
nk_forward bpf prog to ping from a remote host to the netkit in netns.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/nk_netns.py      | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 1760238e9d4f..9a7a0d7a1b6d 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -19,6 +19,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_netns.py \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/nk_netns.py b/tools/testing/selftests/drivers/net/hw/nk_netns.py
new file mode 100755
index 000000000000..afa8638195d8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_netns.py
@@ -0,0 +1,23 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import NetDrvContEnv
+from lib.py import cmd
+
+
+def test_ping(cfg) -> None:
+    cfg.require_ipver("6")
+
+    cmd(f"ping -c 1 -W5 {cfg.nk_guest_ipv6}", host=cfg.remote)
+    cmd(f"ping -c 1 -W5 {cfg.remote_addr_v['6']}", ns=cfg.netns)
+
+
+def main() -> None:
+    with NetDrvContEnv(__file__) as cfg:
+        ksft_run([test_ping], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.47.3


