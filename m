Return-Path: <netdev+bounces-305633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xyeIH8m8TWqM9gEAu9opvQ
	(envelope-from <netdev+bounces-305633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 04:58:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1303A72144D
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 04:58:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eiUenpzF;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305633-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305633-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C572B301D31D
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 02:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45A3BA237;
	Wed,  8 Jul 2026 02:58:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF983B893B
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 02:57:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479480; cv=none; b=VTRfeU5vX+MW/ctPK53gYmkMCqssB5QXmVmUk7ZZDBiafAlTv7cwFChvTFR1P5luiLqqEzFGI1W9qltfUpcTSlQZlq8o2E/RI90GfjZVO0IrbflA0S4dU3r/0z/k9QkKVQC/81BbW1IUu99apaxQGwDXu7H8GNXftrNN0Nku6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479480; c=relaxed/simple;
	bh=3aBIeFzxjG5hLOVJxWC8DtcQqIoZzqgdSPM0MbUrphM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiPuohbhlraogBZWy+DeZ+OjIKXj0ZiIVD4o/uzRiLr3kxKt+Elu+KAEvCFirjOR5FlphKeDFY4iG6Us5B00XzAxgmEVXnuPoP3kAqnFYyji91gD4FsrmZJmLwQ6MGfCM7cK7TSxertlyNbkb6FyEKmOPyxQSY0zrEqtisk24yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiUenpzF; arc=none smtp.client-ip=209.85.219.44
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so1637556d6.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 19:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479478; x=1784084278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RGIUqyeZoqmDFWmO4W/wGNuga+EJTtkIgRxdOVhDU04=;
        b=eiUenpzFlT5fcVQlHrZ/RUhG1ygCmdmAxEr1r1yD47x3Bto48VQtIZtbn2t9ZMRHIE
         dIELj9rLiVFXEdOChEYenlTSQbpUNtCNcv10UEv7jewTG31jRuAAe3iy5T8J8GyPpx6K
         UXgBg2Ps/b4ObdlzYr2NYV9dXKrsxqbkp1sIFfgTqgy9VeS8asJSdElQX7yMjFRb4dYL
         c7akt82HuFBaJKrgsM8tkRVvpHHHPL6LD+ySp0Yhr9ChTq0VS8eeuSaiQCyIuDYsjqK1
         y+BRlT4u3xtAf2p6A2LimxBAX1HqtT4cBcA6WmowVVvk0tioc4gaQeX/C4VSLWxAf3Ws
         82og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479478; x=1784084278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RGIUqyeZoqmDFWmO4W/wGNuga+EJTtkIgRxdOVhDU04=;
        b=Tf9ENwgGL+iPFIk5YXW7xBfRSx/g3b9W1Di1LGhCOVx0Sy/OY5JABfnK/2MOO1n2GH
         DD9OuTbIG51pewdNIWScBha5rVKrD1sSVc6KEv0k++2rmS+1ucybV+dTSiANKxydUnOJ
         vDCfEijEYucwfd5+ueRZn9yQtLhuXTmugED7LGd/0Y0ExftfPlF6y1d6ATD0R0Oskodt
         4vZNtdmhkMyxcnXdFDZhhUvgNIIeWdqDqjcEFkiprWuBjKi0WD+7GGooVBIBBItPcxZy
         Kv+gsXMz6MXrkXu/meWliKXbugI6qQEorQvHWmJquwu01ql/WiLTbMbK88FISYX6rO5e
         3wBA==
X-Forwarded-Encrypted: i=1; AHgh+RpHqbu0O8QjTWXdQV1HOYqOHipUmI1eN6tzMNdQlR0sJbRnqF0XSf/vw02l2MeKoAkniIV58rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6RG4rekir/R5Sb1OephmHh04OsFs+/vsahQqOWzRjC5Nu3kr
	nlT0bp2eHDyRiJ2TpjghV9hcGRSe7xwTc8VaJK4HGrv2zQSjNV0AWRw4
X-Gm-Gg: AfdE7cm7rYOeiJiSYHy1hnzvawTicW7wbB5cM2C+T7lKma1OSscsBi5O2N7Hd/gdrWB
	VeBymAekFKFFypyvD1pbwlujO1EgjXA4lhB8A+CqAzBgizuapIadmWhL7oVp28PBZ5JKGio/FAE
	rKgm7Gi8gkXN1vx3WAmwkBUhl0gnNUE5s5ZYVKwWW4Fxk0MdOS0OhGgkeskhbi6swQvu788DF91
	6jTMA1goVlKLOqQMDNvPIYYICqyW8nGfIqmsseOYdcurPPSAwezaDi6GzDLp7tCve4BjnXUjqVI
	09pa5MELOBY0fUyDTRo/tar5NyA3X7S3l58R8QU9KWS9vBBbXHOHvUTcWRMibiM1kms6MQ/i7iz
	DaVeOp0EzqNGojPWvUgqhugmMzA6KKuisHjbx/Xdfr/oXiLh6CdF3HapQnE1XQrBpYDd3KKfCO8
	wxP73Z7zfucU+wP0QNTU+3liuSOfdci5mC/SpfJuuL3MvNeYWkAktMrXxZ39G+3OMdyjCo6p8c7
	n7A+VByN/yif3w=
X-Received: by 2002:a0c:f40f:0:b0:8f1:505c:1d2d with SMTP id 6a1803df08f44-8fea11c8be7mr8129896d6.14.1783479478388;
        Tue, 07 Jul 2026 19:57:58 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de83f8sm175762936d6.33.2026.07.07.19.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:57:58 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Add XDP dispatcher FineIBT regression test
Date: Tue,  7 Jul 2026 22:57:56 -0400
Message-ID: <f6df1bf381517f7ff6927d82de7680e7826adf94.1783479101.git.dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
References: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305633-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[dwindsor@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,redhat.com,alien8.de,linux.intel.com,zytor.com,davemloft.net,fomichev.me,infradead.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:peterz@infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:dwindsor@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1303A72144D

Add a regression test for the x86 BPF dispatcher's indirect-jump fallback
under FineIBT.

This test can crash the kernel on an unfixed FineIBT build and so should
be run in a VM.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 .../bpf/prog_tests/xdp_dispatcher_fineibt.c   | 47 +++++++++++++++++++
 .../bpf/progs/xdp_dispatcher_fineibt.c        | 18 +++++++
 2 files changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c b/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
new file mode 100644
index 000000000000..2d3fc4034eb9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 David Windsor */
+
+/*
+ * Regression test for the x86 BPF dispatcher's indirect-jump fallback
+ * under FineIBT.
+ *
+ * WARNING
+ * -------
+ *  This test can crash the kernel, thus should be run in a VM.
+ */
+#include <uapi/linux/if_link.h>
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "xdp_dispatcher_fineibt.skel.h"
+
+#define IFINDEX_LO		1
+
+void test_xdp_dispatcher_fineibt(void)
+{
+	struct xdp_dispatcher_fineibt *skel;
+	int err, attached_fd, unattached_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+	);
+
+	skel = xdp_dispatcher_fineibt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	attached_fd = bpf_program__fd(skel->progs.xdp_dispatcher_attached);
+	unattached_fd = bpf_program__fd(skel->progs.xdp_dispatcher_unattached);
+
+	err = bpf_xdp_attach(IFINDEX_LO, attached_fd, XDP_FLAGS_SKB_MODE, NULL);
+	if (!ASSERT_OK(err, "attach_prog"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(unattached_fd, &topts);
+	ASSERT_OK(err, "unattached_test_run");
+	ASSERT_EQ(topts.retval, XDP_PASS, "unattached_retval");
+
+	bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
+out:
+	xdp_dispatcher_fineibt__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c b/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c
new file mode 100644
index 000000000000..b49b84f01c8e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 David Windsor */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("xdp")
+int xdp_dispatcher_attached(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_dispatcher_unattached(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0


