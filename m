Return-Path: <netdev+bounces-263702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJKxA5MAqGnynAAAu9opvQ
	(envelope-from <netdev+bounces-263702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:51:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7309A1FDE60
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087ED30E83F2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3939D6E1;
	Wed,  4 Mar 2026 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PpHvG9C0"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE3369979;
	Wed,  4 Mar 2026 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617573; cv=none; b=F9DHs9OJScegP/5dfIigo6h/CpVIgMP/6Mpyj+D75G9GELfhCjDmsoaFRFqhG/E9g/+j02mBxPdlC8b3woo7hwQVwqpyDAx8N2vHIbEj+uyc/PIzndF+zQNr2CUI44g8DLJUepUVc++yZVaS/EiwF8a9tPTC5BFGgLwbOliNNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617573; c=relaxed/simple;
	bh=R39sf0YEzRe0hADL5r8yZRxlVaSblRzLSCZHD1OH67A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhJtBTFyo4pKUUGQM/U00Zw7vFqv/Q0cuFeKa6ZCWGzxjXx7sXbpIRmCyPYi6/AbqvnjiEln7/JvNz2Vx7McqQrXHzgjgz/7ytRsfKMQQOCKfcnlAsDoj6FXWRwkLeFPQX2xnQd+1iyiNvJV4I0d3YJV0VKfemmAlmFhaZBaEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PpHvG9C0; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nU
	dx8/p9S4XoNFcFnqMpZbOkEUTfhDwxp33GUWKLZ4k=; b=PpHvG9C0IKWHiaLiXe
	eq9HK7+7Vg1Ewq7IJm2nNhJtfzR/ANsJmC62vqGO1dorGu6uZ+Ra7Uu2+ZXdbRYx
	3dsSJPRUQ0qcXWlU6YUOkfQFGMOZlZSZ8+41j55EouhEyrLTVbAL168/ZYOA4X6N
	PzJjo2VCZDPO0URcjreJbFEYA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3f179_qdpB89zRQ--.55S4;
	Wed, 04 Mar 2026 17:44:35 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	posk@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangfeng59949@163.com
Subject: [PATCH v10 bpf-next 2/2] selftests/bpf: Add selftests for the invocation of bpf_lwt_xmit_push_encap
Date: Wed,  4 Mar 2026 17:44:29 +0800
Message-Id: <20260304094429.168521-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260304094429.168521-1-yangfeng59949@163.com>
References: <20260304094429.168521-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3f179_qdpB89zRQ--.55S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4rZFWkAr1Utw47Aw1kZrb_yoW8ArW3p3
	W8u398Kr4fKa13Wa1fCFW7XF4rtanYvFW5Ar4I9Fy8Ar9rJry8Xr1IkrWUGF93G3y8urs8
	Z3Z2qFy3ur48Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE4rW3UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzwNEvGmn-wNc4gAA34
X-Rspamd-Queue-Id: 7309A1FDE60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263702-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangfeng59949@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Feng Yang <yangfeng@kylinos.cn>

Calling bpf_lwt_xmit_push_encap will not cause a crash when dst is missing.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 .../selftests/bpf/prog_tests/lwt_misc.c       |  9 ++++++++
 tools/testing/selftests/bpf/progs/lwt_misc.c  | 22 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_misc.c
 create mode 100644 tools/testing/selftests/bpf/progs/lwt_misc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_misc.c b/tools/testing/selftests/bpf/prog_tests/lwt_misc.c
new file mode 100644
index 000000000000..6940fca38512
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_misc.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "lwt_misc.skel.h"
+
+void test_lwt_misc(void)
+{
+	RUN_TESTS(lwt_misc);
+}
diff --git a/tools/testing/selftests/bpf/progs/lwt_misc.c b/tools/testing/selftests/bpf/progs/lwt_misc.c
new file mode 100644
index 000000000000..aa638a4f2922
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lwt_misc.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("lwt_xmit")
+__success __retval(0)
+int test_missing_dst_call_bpf_lwt_xmit_push_encap(struct __sk_buff *skb)
+{
+	struct iphdr iph;
+
+	__builtin_memset(&iph, 0, sizeof(struct iphdr));
+	iph.ihl = 5;
+	iph.version = 4;
+
+	bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &iph, sizeof(struct iphdr));
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


