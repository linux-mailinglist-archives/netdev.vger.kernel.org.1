Return-Path: <netdev+bounces-262497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKQJE3shpWnd3wUAu9opvQ
	(envelope-from <netdev+bounces-262497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:34:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCDF1D3209
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 978653008D25
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 05:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332813164D6;
	Mon,  2 Mar 2026 05:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="isJfDSFj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC031716C
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429685; cv=none; b=hRrogcJydh+gqioeRF1QxOJjfQE6m5LjqyxB4QvcWyq2bphxQ5BBW1VkojVNPr7xDeXIvma82eW85Wz5XmeP+tVB0BMyBICp0MEWsmKues/RvwEKJ/q/80vLK6wIWAKujeMvy7WeDCZIiBDo/ydKYS7TW1tW0vbjQoltoqmZG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429685; c=relaxed/simple;
	bh=icHZY2wqQ9jqRK4LJNunuA+NRbPEqtIg1aKitJDaEGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA45wToAMcaR+UUe+VpGzQhbm4eBwT4xnIYUCXUuPOzK8Pzkc8JwwiRiRuj/zOxOoodOhqTCD7/F/T1Xeat2LY0GavcynDkHuIh4YQE8gmcz3UGh4SUOJ+B79m1TngW3x24iUxl0nJL4Evzh/gMABj8lWu8bz+D9iDof2elKwNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=isJfDSFj; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c7d04890so3817000a34.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 21:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772429683; x=1773034483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pdi5TfqHB20Phx1gxNlcCaQkHXP3aF10Zkb2EJi23sI=;
        b=isJfDSFjcLkXV/Ktsws31QUQELuDOI+Fc+3i78PzcsejfzoEZcuQ33gsy+vZJTNpCc
         YOcGp8OVnIGNRWWC42ddZs0inrP7t597xbMY/igYZ09A/lnTvIqhL3/vb8m1ooDSP/Qo
         9GG6WihJR7awfCsYphJ/6mzDfjyIyb0epCcBo9BBEjS/S4h3JgNe9huJJuCRbe3P0hRN
         cTnNysMgRpRKpElsH4wX1T8roCit8P43+NOxty1AUZyrBxCpCG24+VSgMmi4jcsmiiaD
         PYcWpjylyNjrcGTt8FBm7nXOlS9Pz5NBz50FQBoSG7oRJbWJlBxeryYUHDT2iQTTKZQx
         17hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429683; x=1773034483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pdi5TfqHB20Phx1gxNlcCaQkHXP3aF10Zkb2EJi23sI=;
        b=xIOSYRSN5YZGLb13+Pa7l4w76uuw1y4lGXYsE52ybryJ611z/dQJmZfYMW+qZGWCsx
         ci04EQA9f6kK66ij0d1x1Kwd21XArxzKha0s0/hgOdhgRc/HBEeXVgYyeu4S8KfBvRR2
         rKYgmmAWH6asWVmZrnp5tNBc4B36NVctZY5bD5T7rT3pazFn0Rhio+axLxtiEuQrxqjM
         dZN/JjGrUR5Y4GNwao9CAu5YWF0HlDXLe1fwpV0sWeE2eC1Stbm3hLP2BreZpJDibviZ
         kwQlqPT/H1QoFO1Ug1K+RvZRrtmdd7Tuj3ioV/TPR5dFiJ7dKefe/xWN5pA24EPmndwy
         pHYw==
X-Gm-Message-State: AOJu0Yxen+CnD5G40jehjq+gS1zw10TZCTX3wxJT2kV8K1smQWatZCmP
	vOMXv8Bu+oeSi1TmegEtOfb+d+mo+vKk8aiyj9amyWkd5K3O4G/R6Qs1YQxekEiPoaX8/Ww2PQp
	QqcPX
X-Gm-Gg: ATEYQzylhT6+4xQ+VUJ0VgG5pzBd12cTdRTLZOeEkpm5UujzAui0cXGAp77fs8a2K4I
	oDg/MmnYQke3HHuS365dxeR2n7gI/SOtdokdGvwGeEWTgI0iTo5vxE3HQQ2J6hq4HaUPhy5YBoA
	Af51o3fVhOdFQwyeP1rBsE3ydLAb4+QZefkmwZRLZoY2Q1L3BLkjcyN7mBW9nId3melsBAk5mXX
	uA4ZOP68SXXWW6b7h9NVi+SIFTLtVdRruhb83vx76ThK+xzMGjqsTqeFB/h8kPD8Aj5FxaI2ptL
	0yMk8IV6EYFcz5jNJk55ReuCNOHaFytZpO7w+u2CcPzViG1Y+NtLkCt2C7bYtOuJ91VSgbuEyuB
	mbrXTwv18qPFhwcXnadpxsjvPryaQhuZfISq75yxJN882Nj9NCN66omMSgsV476jJgrMgo+oo+O
	B6GM7i8E/N65t7wBm6DE84GYE6FLQ3fva8nMrkKLue
X-Received: by 2002:a05:6830:3808:b0:7d1:9cdb:f499 with SMTP id 46e09a7af769-7d591b1af81mr7632220a34.5.1772429682800;
        Sun, 01 Mar 2026 21:34:42 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586474d4csm11240809a34.9.2026.03.01.21.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:34:42 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>,
	Wei Wang <weibunny@meta.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v2 4/4] selftests/net: Add netkit container ping test
Date: Sun,  1 Mar 2026 21:33:15 -0800
Message-ID: <20260302053315.1919859-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302053315.1919859-1-dw@davidwei.uk>
References: <20260302053315.1919859-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262497-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei-uk.20230601.gappssmtp.com:dkim,davidwei.uk:mid,davidwei.uk:email,nk_netns.py:url]
X-Rspamd-Queue-Id: 3DCDF1D3209
X-Rspamd-Action: no action

Add a basic ping test using NetDrvContEnv that sets up a netkit pair,
with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF program
to ping from a remote host to the netkit in netns.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 tools/testing/selftests/drivers/net/hw/config |  3 +++
 .../selftests/drivers/net/hw/nk_netns.py      | 23 +++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index a64140333a46..91df028abfc0 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -32,6 +32,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_netns.py \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index 2307aa001be1..b6524040418e 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -1,3 +1,4 @@
+CONFIG_BPF_SYSCALL=y
 CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
@@ -5,6 +6,8 @@ CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
+CONFIG_NETKIT=y
+CONFIG_NET_CLS_BPF=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_UDMABUF=y
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


