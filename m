Return-Path: <netdev+bounces-264511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBEYDDjJqWkAFAEAu9opvQ
	(envelope-from <netdev+bounces-264511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:19:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB69216EAA
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F89F309E29C
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 18:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806333DA5BA;
	Thu,  5 Mar 2026 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="HLDumEut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653328F935
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734708; cv=none; b=NFL7QTOZui5uAE4pS/94zXZtWpxnMElzrCd8JJLker2gTve+npni9T4lLHYt1Fnx5LCzKTGbELuKWYebJtjlGOYl0vEr1UYO9eXAmi85/kK3aOjQFdZURqy2ChgEZptg7eEzQXrI+iFCl4MZY1jZcxpTnCueKkY7JntGbIadPeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734708; c=relaxed/simple;
	bh=DZlHhnMH1ME1r8sEy6MQ8qu6lknInnq3sVq2QyebVRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnAUUcMItE4irbenlKlHFc+4Rbtb3gPiC+kGIJutljaizFUFiC663VxxPzhnYNxOqw6Sgwozf8eO34lOXO587UJIZRM4x0RkrEkFRcrEc9kIiaI8EBpq6RX8ikcygxKadGP9QP5kolD8INATTwcxfGk1+BVJQ/BbnUcSQ4NwmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=HLDumEut; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4648447e29bso3372441b6e.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772734706; x=1773339506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYiAN5Qt4jSNj64cnayEKa4FB/KDNltUucYorvFw6JE=;
        b=HLDumEuttKjxINYrn7eXuxwJdJ2Q5XVRQJnhY/Eqw7KsUCFANgqUu3bBi6UKqMFK9j
         LTXc9XDOAZyJODV/8UxUSy5zfKpDp7CAf20Hw29yEROD2f52YN1ZQ5WQtF6yE3X1Wwsb
         DC2P9M2S6qcwCVVFy/dgehF3sNzfrgx8KSxjvjZRb5YFX9OlusAPJ1ycBENdZ4X2xlhU
         a7qoWojx/xsQVrCDCmPde6a4c5Dq2MT3cPPS6fhCmMQvYHr4A6eZWQeC+3dtoKQ2ij7G
         2l+PCATar1XcBQ9t01sC84BTCgNQd4E7JY2F8LjW6i9ks/rXp6xIEi2JH1YNHo0Owbgl
         1EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772734706; x=1773339506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sYiAN5Qt4jSNj64cnayEKa4FB/KDNltUucYorvFw6JE=;
        b=oNGb3Oc+k1/5SgXSCAv7uMEcsy+RJPOuS7sp3WBaYPqMFKYmIy8NjSzcoQbMGHyF2X
         FwdYUsT1XzWgEV1z0AhymlMGmibLUcRbMSaU3QZ+mGn+VZxLdzyB55WKXJ8J5yFxATl1
         JXvNu1/Bhq4iayS1HQuqCGlVma1XCJF9CHZC8anC4W3CCVwxASYSI03oZXTYJtZ4ipUm
         Nt9TochjsDWHeAbsAqqWFXf9YlDe/MdHpRVbiAbZnsSLTioOeoYLpKTIZfZK9H9YGzdG
         ZcR4yJGcAmt/xT4u9FTfAYD2jqQRCaISyiKl4aIzffxMoId5EcaPLyrVn63yDk2F5IBX
         rt8Q==
X-Gm-Message-State: AOJu0YyhzfAvk+vep93egnmMYjBOUfG3yvgpOXQ6u+/BgDvcoENX8teY
	rAxD7CY/hhb4WFVv/2mp0DKf6okKi9j4cKhG5CKc8Oebytc40VFpeoQHmooixNxLAf69wN8Tl3c
	BSGwB
X-Gm-Gg: ATEYQzygw7dB+NPhUor7hMcd1l68+IczBf9vqeeIF3qW871M8jRCPgOfyxLWhfksJVI
	QZwoMpXGaqL0PItfNcKBWgg47UgkJRzYUL3o/m08718zGWwJ7ahjEgwLXfLf+nQU9MJjwWFNuOR
	eTSmTZniiowUg9ksTTS8MSUv604GH2zjhwTp/a8IzHCwyWWIl/swxxM6UE7QByxNyIG0SvzMNYR
	7PjmYgacYAfstibpA3xB0wg7Ou4aqY7OrLEogIYKKUeqYxsNudKKpEYLxT97QgVMXY5Z2pF5+96
	ILilGbXWW/w1cJg0AG6RypTurQs/qDeLSg6HrrwB8bPXYwlmzSKcUIVvoGePIc3gCYEdRVUEmIK
	Cp3dLy/3IiByDxVnTYI+pj2WxYdCzbKQbduzG3XfE3Nbe+6FWQule1D/2sMLk3ZxUifXlqKuGzB
	BwUN1eZcOAkpPy0wjY2caZLD6l4mVAqlqixhR2mnx8+A==
X-Received: by 2002:a05:6808:221b:b0:450:d056:e0f0 with SMTP id 5614622812f47-4651ab1f3fdmr3196043b6e.2.1772734706159;
        Thu, 05 Mar 2026 10:18:26 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b240sm20938620fac.8.2026.03.05.10.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:18:25 -0800 (PST)
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
Subject: [PATCH net-next v3 4/4] selftests/net: Add netkit container ping test
Date: Thu,  5 Mar 2026 10:18:03 -0800
Message-ID: <20260305181803.2912736-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305181803.2912736-1-dw@davidwei.uk>
References: <20260305181803.2912736-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8CB69216EAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264511-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
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
index 2307aa001be1..235c0a1cd21e 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -1,3 +1,4 @@
+CONFIG_BPF_SYSCALL=y
 CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
@@ -5,7 +6,9 @@ CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
+CONFIG_NET_CLS_BPF=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
+CONFIG_NETKIT=y
 CONFIG_UDMABUF=y
 CONFIG_VXLAN=y
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


