Return-Path: <netdev+bounces-282118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNBoF0E58Wm/egEAu9opvQ
	(envelope-from <netdev+bounces-282118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:48:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E29E248CCE3
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4FCE30BA41F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A193A5E71;
	Tue, 28 Apr 2026 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGfmujBj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE73A4527
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416149; cv=none; b=XpZwa3j9pN24hWj3ZmxFXLfJjEAish+4bLuDn7XDkZW3GIupGJoV78gWQwgzDo2i7hoMFqcJGUl5ByEMAAkt17hs+6RPVTgI/ocDqJnxcyU9S+W32VQWsc4AxYbYNWONsUWtVKgYB1LSavb8yDPOSb9v9gnzGedYzK3Cxr2+Pq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416149; c=relaxed/simple;
	bh=9CfxHHUrdkC2HOcb/TS/DNlnMmhpx5XoMYQJ/X3bIM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGJ4+IZiw9kEyhWpk1ZfaVNfp3/NBumoRD3xFY48jhWUmG6NYAbTOFwXh01fzKC1/NHTlZdu7shouOOvkse32IMjYcplrs+lxD54C+FfzEPmUGFAPWQ1oG55OGxhSWCPib5411dirZuRANjT33+WPkx66os6qDgACStLT7FgAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGfmujBj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f33d28c1dso6583669b3a.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416146; x=1778020946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zt/Ht0RhxHPOrumBmtiIhgjoCgVfyyPmVo07gYfbsYg=;
        b=hGfmujBjsi0UAKT5A5kn25OWHhAw/fm3DjX64xC4UnCz3jAyX5jh4JWEgFH5t0MzTf
         eajqeA9H5ffJbcCpdVL6uLHgsNotDrLRYznyCJL12e/ZMN8SLF9cYh9vPLymTCcJobuo
         mJUPdI7UU7q1xOt0hYXkf8Ru/V9n2MZWXr5NLPVkm1xHLciBqVTYLL1tnBsQqoaCKx8X
         WgOngXUC6m7ngdctRG5Ci1gJBNUF5QV+V4rYbK7Oqxn+l3uMmC8FBPbQzTonmXB5HruU
         7tZQcDrDh5e8xb0jLA7yjlDwr5xvc4VJAbuBV5K7lK+/ADlF2rjpF7yrQQi7r49OGhSp
         UTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416146; x=1778020946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zt/Ht0RhxHPOrumBmtiIhgjoCgVfyyPmVo07gYfbsYg=;
        b=VWR1SU0MyH3ovgyblxRpUbJWH2zVNG+CL94lJVffv/pl1/O3SolMi2HgoPu1FrRXDy
         bm1PhKEZ09e7ramATLhjMYKm7Q6pSfxV/bsEnsqad9MrIL+TiZZSo5wvkjzpG85QsApg
         1hvEOF6daVMIdqTHFl/i1WDwAZylWbFhMtZQS+tGjbhQfmq0O2gI7pwxCwi2IrIkRY5r
         3K2J+9v2oqQ/7qqBJtUIKXdD4FgoySQpIrrq+ywt6d+6k2AmJ+3XkdEJwBpHcuZrf1xE
         1DM8VIrCTvSLqqlP3IRArXUakQVZgGoqr4ezmt+NdO5HIaH0QqlYYwNe41rLlBWLMtJK
         +jBw==
X-Gm-Message-State: AOJu0Yy7ntKiya7KhyE6mMBc3Iq5qZ2NTq6Q6J6e21x7a1wyheoSUC8r
	Q//p3LV1dv4Lk/+X6CJejy65jmTF0eGeByTTJI+NUpkGBBBjpbXT1FEz
X-Gm-Gg: AeBDietEcAx0iZHacaOEQSIKc4XrgXLkNKbipo2+S+LukapLrcatUKo5Xsmn/hdsj/f
	STwFECF2W+U8duiKSDad8wTmW2ja+xNYXHUhaCjcg3hM7U3RyIO5RjWkMdF8dIEss1WSd+m1zIq
	JRtV6850g5N1XmDGNqjqurc8NhdqzQEyS9d/vrcr2/MQTj6RNu3zwZ1zpfBAGelYm9lsxZyuwqu
	9p9ELTwFNU9aU6x1pyGbvC37mAB/AXyl82RlgbaHd/BCxIQLbgErciFwLs+p8biGgUqJREAVV4r
	iGW9hWAirtO/AhgnwIWoPkQteAWoM2LwI6nUVsvhj4AY8GG7lVKqlyCU/U7UB8nICvRw/uIDgT5
	7dPH/uTbC/yUnT9491FmfMSVwjvn9beVUNZUVT9rhwlgQR05X+c2KaMwWvL3X5/5G3Tr4PeJsFB
	iijc2LUxEZAbxgyp4tKSeZk+i1RaL1Sg==
X-Received: by 2002:aa7:88c1:0:b0:82f:1973:4b96 with SMTP id d2e1a72fcca58-834ddc14602mr5517283b3a.26.1777416146426;
        Tue, 28 Apr 2026 15:42:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80f906sm96681b3a.60.2026.04.28.15.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:26 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:08 -0700
Subject: [PATCH net-next 11/11] selftests: drv-net: add netkit devmem tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-11-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: E29E248CCE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282118-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nk_devmem.py:url,lib.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:mid,meta.com:email]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add nk_devmem.py with four tests for TCP devmem through a netkit device:

These tests are just duplicates of the original devmem tests, with some
adjusted parameters such as telling ncdevmem to avoid device setup
(since it only has access to netkit, not a phys device).

Each test uses NetDrvContEnv with primary_rx_redirect=True to set up the
BPF redirect program on the primary netkit interface.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
new file mode 100755
index 000000000000..c069d525798b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
@@ -0,0 +1,40 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Test devmem TCP with netkit."""
+
+from os import path
+from lib.py import ksft_run, ksft_exit, ksft_disruptive
+from lib.py import NetDrvContEnv
+from lib.py.devmem import setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds
+
+
+@ksft_disruptive
+def check_nk_rx(cfg) -> None:
+    run_rx(cfg)
+
+
+@ksft_disruptive
+def check_nk_tx(cfg) -> None:
+    run_tx(cfg)
+
+
+@ksft_disruptive
+def check_nk_tx_chunks(cfg) -> None:
+    run_tx_chunks(cfg)
+
+
+@ksft_disruptive
+def check_nk_rx_hds(cfg) -> None:
+    run_rx_hds(cfg)
+
+
+def main() -> None:
+    with NetDrvContEnv(__file__, rxqueues=2, primary_rx_redirect=True) as cfg:
+        setup_test(cfg, path.abspath(path.dirname(__file__) + "/ncdevmem"))
+        ksft_run([check_nk_rx, check_nk_tx, check_nk_tx_chunks, check_nk_rx_hds],
+                 args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()

-- 
2.52.0


