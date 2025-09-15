Return-Path: <netdev+bounces-223244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA28B587D0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613FE2A3D3B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C1E2DCF62;
	Mon, 15 Sep 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alz8IKJp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981B2DC32C
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976489; cv=none; b=CUdvpQrEnO2/2so5WCN5+8Sa7aVbwd1kucGXLRTc62bzl926YgVkz8YN9y3fdpEwPrkNG44i0qYbqJfS21w0U/maKMm6wJLHxvCxmAnhQnOyl49wK4js8MDLZ1yO8PDbx+d4ZHz+q2u9FbpN5Ph9I3kPe6sI7n00LGPApEOk9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976489; c=relaxed/simple;
	bh=YheyGT5j/rl1uSZyPyfRiFzODU+vUEbEDN4g2xZ2c+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLU6ChlKQAhhZLd804vRBUOO+sT6QtfXXMjS74xswqGWpB/Ea/vF9/pES97rNlncFYlXluL9drv6zm5ywppKhOpX0i0EuE/Pdv1I47boUZS2V64wo0W9VSXwqAgYC2gevuvpsss2JNrq9buqEdmNrk+PH7sR5YuQveysURYERgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Alz8IKJp; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b523af71683so3916807a12.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976487; x=1758581287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+Lgk903Q/7VLXveN4Bv02inLdGggTWKBTviyoOcsS8=;
        b=Alz8IKJphhhKhwEyXBZ6ZWfvBWiCq1sUMUvEfLa8nuEDxsLM49ZJ6YW0DtSZkdB9fE
         5GX0xKVTkoHZBUxzS5xt+voLT76wx7Bk2cWPKDv7Ykt0YR2ra6dWTUEv4wmCie0Wsuhw
         WmqX+jHJF2o9fLnyKdz74XvR8XB1yBt/vPNLcjUIHsUTTZ76objKRy4K+34BVq+LRjVi
         aveg4SeBJ70wqWI3Bn8M97t6dvHoSAl0WQpoYqCd+R6qtAbBnYTK+R1iOa3HcvB+R+o6
         wYQ6SwPw4np4HpsgPGqeeNqBTjRT14fo+nMILF18yrx9q8M+7CqMRnIvlc/iD9B3O9bc
         U0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976487; x=1758581287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+Lgk903Q/7VLXveN4Bv02inLdGggTWKBTviyoOcsS8=;
        b=TGBf0Eq9BXl+9oLpc/MIRE+KBGFTALn8Nxy1K0Kt7VYzaS6eGWGNAHP9cey4MF+fkK
         oPHKg7z/mhR+moIr1rEr5aGUi+6cQ1PpYxeh9z1vBjK2v3kwi8zPp+wILlzeLqKNDr30
         yScztJ+sh1Jm43Y2zTc9timUB1/Oo02qRoe9YE03Nb3SKz/YoQnjELYi0iRAvV7M/xDa
         oGyc1i/gQGuALP1U03FkmVrQEa8vcuQtQbPm/OuZPgI+GSGn56OBiuNb0zqHtJEYYdEc
         qkeFGDO8aVDj+IPPq6Y5vI0Nyo88un8QNyMgX6sfXFCQ/JCv8DcUjoE7grdpXq72EDkk
         K2Nw==
X-Gm-Message-State: AOJu0YxsPcPDyZN9m28j/ECgSetuvsuJljPakpYR8r3lgVOe1N8BoRnu
	mNsWJMkrTmrvP1rWsublcIXyCOkQRsTeSQk1HFLS8JNKHMNHWoz6zHLE
X-Gm-Gg: ASbGncvOJbWbp59OREn+tQxFPyyr/HcMNFrJo7fvnzCKLU8QjyQ4o/GQpEh3ipH+Z/2
	wpAKveHs33bhqA+PeiDQpoJ0tOXRN9/aCEbYPf+/rU2TyLjRaO3wkkTU7T9qfeNKsyQ+yEdchk2
	q97I2CSfmDlLwufXd6h9vG0Zd+BRJlOfc2uG1zve9hnQKVs00LPCtxV2NZ1BvDpQZmwvFkhiJSj
	SHRbmlXgjGgD6SPYYlETzXeVKBZDJqgYYiUPqGc8mu4kBCmYB1j01hLCK6hlhPfks1eQsu4blwi
	8vP5NCaXJwC4RBYlcvgQpCkEh/BJZu7cMT/4mVCGkXmqbt+0T3CXMw5a2yF3Vvfb2e/pod3CuOe
	xTtQCj1cJaw3d
X-Google-Smtp-Source: AGHT+IEg+C6x67dqePRqmPFzF1wQNAnCsNY9oO7cNg/8ybOBRA1K36lQf95DCixSUJWTTXvjlznvTA==
X-Received: by 2002:a17:902:d512:b0:263:b8f:77dd with SMTP id d9443c01a7336-2630b8f7bedmr117657035ad.57.1757976487153;
        Mon, 15 Sep 2025 15:48:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2635c79cd21sm66945565ad.49.2025.09.15.15.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:48:06 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 5/6] selftests/bpf: Test bpf_xdp_pull_data
Date: Mon, 15 Sep 2025 15:48:00 -0700
Message-ID: <20250915224801.2961360-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915224801.2961360-1-ameryhung@gmail.com>
References: <20250915224801.2961360-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test bpf_xdp_pull_data() with xdp packets with different layouts. The
xdp bpf program first checks if the layout is as expected. Then, it
calls bpf_xdp_pull_data(). Finally, it checks the 0xbb marker at offset
1024 using directly packet access.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 174 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
 2 files changed, 222 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
new file mode 100644
index 000000000000..932b33a71b17
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "test_xdp_pull_data.skel.h"
+
+#define PULL_MAX	(1 << 31)
+#define PULL_PLUS_ONE	(1 << 30)
+
+#define XDP_PACKET_HEADROOM 256
+
+/* Find sizes of struct skb_shared_info and struct xdp_frame so that
+ * we can calculate the maximum pull lengths for test cases
+ */
+int find_xdp_sizes(struct test_xdp_pull_data *skel, int frame_sz)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct xdp_md ctx = {};
+	int prog_fd, err;
+	__u8 *buf;
+
+	buf = calloc(frame_sz, sizeof(__u8));
+	if (!ASSERT_OK_PTR(buf, "calloc buf"))
+		return -ENOMEM;
+
+	topts.data_in = buf;
+	topts.data_out = buf;
+	topts.data_size_in = frame_sz;
+	topts.data_size_out = frame_sz;
+	/* Pass a data_end larger than the linear space available to make sure
+	 * bpf_prog_test_run_xdp() will fill the linear data area so that
+	 * xdp_find_data_hard_end can infer the size of struct skb_shared_info
+	 */
+	ctx.data_end = frame_sz;
+	topts.ctx_in = &ctx;
+	topts.ctx_out = &ctx;
+	topts.ctx_size_in = sizeof(ctx);
+	topts.ctx_size_out = sizeof(ctx);
+
+	prog_fd = bpf_program__fd(skel->progs.xdp_find_sizes);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	return err;
+}
+
+/* xdp_pull_data_prog will directly read a marker 0xbb stored at buf[1024]
+ * so caller expecting XDP_PASS should always pass pull_len no less than 1024
+ */
+void run_test(struct test_xdp_pull_data *skel, int retval,
+	      int frame_sz, int buff_len, int meta_len, int data_len,
+	      int pull_len)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct xdp_md ctx = {};
+	int prog_fd, err;
+	__u8 *buf;
+
+	buf = calloc(buff_len, sizeof(__u8));
+	if (!ASSERT_OK_PTR(buf, "calloc buf"))
+		return;
+
+	buf[meta_len + 1023] = 0xaa;
+	buf[meta_len + 1024] = 0xbb;
+	buf[meta_len + 1025] = 0xcc;
+
+	topts.data_in = buf;
+	topts.data_out = buf;
+	topts.data_size_in = buff_len;
+	topts.data_size_out = buff_len;
+	ctx.data = meta_len;
+	ctx.data_end = meta_len + data_len;
+	topts.ctx_in = &ctx;
+	topts.ctx_out = &ctx;
+	topts.ctx_size_in = sizeof(ctx);
+	topts.ctx_size_out = sizeof(ctx);
+
+	skel->bss->data_len = data_len;
+	if (pull_len & PULL_MAX) {
+		int headroom = XDP_PACKET_HEADROOM - meta_len - skel->bss->xdpf_sz;
+		int tailroom = frame_sz - XDP_PACKET_HEADROOM -
+			       data_len - skel->bss->sinfo_sz;
+
+		pull_len = pull_len & PULL_PLUS_ONE ? 1 : 0;
+		pull_len += headroom + tailroom + data_len;
+	}
+	skel->bss->pull_len = pull_len;
+
+	prog_fd = bpf_program__fd(skel->progs.xdp_pull_data_prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_EQ(topts.retval, retval, "xdp_pull_data_prog retval");
+
+	if (retval == XDP_DROP)
+		goto out;
+
+	ASSERT_EQ(ctx.data_end, meta_len + pull_len, "linear data size");
+	ASSERT_EQ(topts.data_size_out, buff_len, "linear + non-linear data size");
+	/* Make sure data around xdp->data_end was not messed up by
+	 * bpf_xdp_pull_data()
+	 */
+	ASSERT_EQ(buf[meta_len + 1023], 0xaa, "data[1023]");
+	ASSERT_EQ(buf[meta_len + 1024], 0xbb, "data[1024]");
+	ASSERT_EQ(buf[meta_len + 1025], 0xcc, "data[1025]");
+out:
+	free(buf);
+}
+
+static void test_xdp_pull_data_basic(void)
+{
+	u32 pg_sz, max_meta_len, max_data_len;
+	struct test_xdp_pull_data *skel;
+
+	skel = test_xdp_pull_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
+		return;
+
+	pg_sz = sysconf(_SC_PAGE_SIZE);
+
+	if (find_xdp_sizes(skel, pg_sz))
+		goto out;
+
+	max_meta_len = XDP_PACKET_HEADROOM - skel->bss->xdpf_sz;
+	max_data_len = pg_sz - XDP_PACKET_HEADROOM - skel->bss->sinfo_sz;
+
+	/* linear xdp pkt, pull 0 byte */
+	run_test(skel, XDP_PASS, pg_sz, 2048, 0, 2048, 2048);
+
+	/* multi-buf pkt, pull results in linear xdp pkt */
+	run_test(skel, XDP_PASS, pg_sz, 2048, 0, 1024, 2048);
+
+	/* multi-buf pkt, pull 1 byte to linear data area */
+	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1024, 1025);
+
+	/* multi-buf pkt, pull 0 byte to linear data area */
+	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1025, 1025);
+
+	/* multi-buf pkt, empty linear data area, pull requires memmove */
+	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 0, PULL_MAX);
+
+	/* multi-buf pkt, no headroom */
+	run_test(skel, XDP_PASS, pg_sz, 9000, max_meta_len, 1024, PULL_MAX);
+
+	/* multi-buf pkt, no tailroom, pull requires memmove */
+	run_test(skel, XDP_PASS, pg_sz, 9000, 0, max_data_len, PULL_MAX);
+
+
+	/* linear xdp pkt, pull more than total data len */
+	run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
+
+	/* multi-buf pkt with no space left in linear data area */
+	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
+		 PULL_MAX | PULL_PLUS_ONE);
+
+	/* multi-buf pkt, empty linear data area */
+	run_test(skel, XDP_DROP, pg_sz, 9000, 0, 0, PULL_MAX | PULL_PLUS_ONE);
+
+	/* multi-buf pkt, no headroom */
+	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, 1024,
+		 PULL_MAX | PULL_PLUS_ONE);
+
+	/* multi-buf pkt, no tailroom */
+	run_test(skel, XDP_DROP, pg_sz, 9000, 0, max_data_len,
+		 PULL_MAX | PULL_PLUS_ONE);
+
+out:
+	test_xdp_pull_data__destroy(skel);
+}
+
+void test_xdp_pull_data(void)
+{
+	if (test__start_subtest("xdp_pull_data"))
+		test_xdp_pull_data_basic();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
new file mode 100644
index 000000000000..dd901bb109b6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include  "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+int xdpf_sz;
+int sinfo_sz;
+int data_len;
+int pull_len;
+
+#define XDP_PACKET_HEADROOM 256
+
+SEC("xdp.frags")
+int xdp_find_sizes(struct xdp_md *ctx)
+{
+	xdpf_sz = sizeof(struct xdp_frame);
+	sinfo_sz = __PAGE_SIZE - XDP_PACKET_HEADROOM -
+		   (ctx->data_end - ctx->data);
+
+	return XDP_PASS;
+}
+
+SEC("xdp.frags")
+int xdp_pull_data_prog(struct xdp_md *ctx)
+{
+	__u8 *data_end = (void *)(long)ctx->data_end;
+	__u8 *data = (void *)(long)ctx->data;
+	__u8 *val_p;
+	int err;
+
+	if (data_len != data_end - data)
+		return XDP_DROP;
+
+	err = bpf_xdp_pull_data(ctx, pull_len);
+	if (err)
+		return XDP_DROP;
+
+	val_p = (void *)(long)ctx->data + 1024;
+	if (val_p + 1 > (void *)(long)ctx->data_end)
+		return XDP_DROP;
+
+	if (*val_p != 0xbb)
+		return XDP_DROP;
+
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3


