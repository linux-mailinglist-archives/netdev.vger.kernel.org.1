Return-Path: <netdev+bounces-168464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38373A3F185
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C94019C3AA3
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FC205AAE;
	Fri, 21 Feb 2025 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX6D23X9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106222054F7;
	Fri, 21 Feb 2025 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132635; cv=none; b=HGtmAuiFwVPMduDJzAdvLGtWv1byqzeknl3E1xjWmfki4mOLFdkQ4fOM48eBfSVAqXQioj94TohG4wtcgCsI7AQGd1JBPRWP7T7Zm2T9EyPk1B73jg8sVT0ewT7/79yL9cRf8Bz1VAc9/e3zzU6DbRPw/ewtztsFF9Ep43wx1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132635; c=relaxed/simple;
	bh=EJ5REn1j/zOD3xphl44Y6YG5r9wqolLvkSDrzHsAkS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDBbxMUjL2cHLFH0osC2wAOYZtXhz/3PvbMWKCWX28xfBZJbs2nohCtexHr009b2mkNu6Cchljqc0nqpEWh64tPnvC5ayM3mMpP+DjNJIY7yQYrpUIZ+F7a+RzpEhc+apmJU0PgakiqXXMgyCcfpIby9DgFcnSCbt6BsWUTWLrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX6D23X9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-307c13298eeso22335061fa.0;
        Fri, 21 Feb 2025 02:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740132631; x=1740737431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf0AhW5ulGwVTYe20q3vWTE2QR1MrqOLrRUeZGC4r4w=;
        b=fX6D23X9Kuq/BjzhlT5r4JXCftjOetWdjsiUfHixLwlUWP65rFrbAOUwKF0AUCpULX
         hAHBHod/lniAgemjzHTK5Gap8e1SPCAGZ1JliE93KpWJv+MRZCr55nrxgPHHDtuYzI1t
         Kk7rsnwtCBbNFErVtzHwjGVuoR1yLB1BrJ8JmOiKHP5UMIBNPseeZMEIobgFUySQuWGR
         ypp1VVn6eoYfqmOA9pNAaHEEW/HkbcY4lTdu0i2KQRWQSGxM0mionj7IGhLumGS78Q5Z
         e9CLDGIg1vxTULuiT6h8Silok7W6GZLB4L/ca3A+UDJg3KghFS+EoRwJK8XO8wJovKob
         rf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132631; x=1740737431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf0AhW5ulGwVTYe20q3vWTE2QR1MrqOLrRUeZGC4r4w=;
        b=HhNq3qpFvsrLMnFlkTlQi5Zv7Qx1zjIZy0FYFTqxBVmvbOgysKk+OBreXCd1EZblMg
         0KRCkT0iDFjo6IdimNncUv4zFlc9XjXY/54hcXzBpxnA0ZA3E8+bm0Ac/i7A+4VhCqjR
         ZDW+1RNTZT4VXOEmdQAtKZRJD1s0E0EfRkOW5DoG3ySFpfIQWhNgSNCgFLf3Ib9jsyT2
         +ML/tzZfXDF5yNwFR4SMDtmItFUNtK4GZX5dqxCMppoSwzyolzHZ3g5JlJp0QpFqwS/s
         tXKu0MLpHYlI8a0MODkdrU6Al5F5jUvZOrBRBVShKDUgy9jdbv9oGLtXL6kGC1a5NUmq
         KSHA==
X-Forwarded-Encrypted: i=1; AJvYcCXIruoaWPN2CRt2nQ3E3tVmMauCs5hBZD9LTofmoLT4PL8avuaqGDBtjjpMetvroEgBSdl6rcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/23FrfcdG9o4GQD39oS/D+NPvS2c7xgF2NA70wsWd3EOkf2r
	Jp3dfbiqFufsldiP1D/je6hqK4RBNL/1fQeJjiKUIiT4vIZ+IKiy
X-Gm-Gg: ASbGncs6f3/ewZyrk9NK3C2QTmChAjXmxEvAaoyaTdlwCrtQjh5XMXhQh9BTtCmJle0
	L0v9RJgOU8WUyK9bhlSnb2G1oFqxaaaeYwuiH1hbUrXEi1DfYBL/2jFwCh2pyM9jnkWrMlgOODX
	16ODGnRB3u3CBSmMU7SRgosspbS0e7/XYTo6JnzDQLc8Y7FSfmmbrNuTRxm/YXF8SWkg8MdKsCC
	KDeD4AMuSoxjOVMk6U9B8BZA+sfMj+7zpix50Tq3aPtuE94FRsG8F5HGilh/WqB+J+VZP8YA1sp
	qe7RL2d+bCT3y8S710qRKl18R4R+vjzysGJ7jPYJNRDIIII=
X-Google-Smtp-Source: AGHT+IH3fj4aoBHUWr73QuSlmVwXB1ezvVw90aJfpYfUs3rARwmjQP8qOPo/B5D5dtHxgcCx+0M6cw==
X-Received: by 2002:a2e:9f10:0:b0:30a:cb8:6de7 with SMTP id 38308e7fff4ca-30a505bbba6mr24240031fa.1.1740132630682;
        Fri, 21 Feb 2025 02:10:30 -0800 (PST)
Received: from FI-L-7486715.nmea.abb.com ([147.161.186.94])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3092bc01c45sm21255401fa.1.2025.02.21.02.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:10:30 -0800 (PST)
From: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>,
	MD Danish Anwar <danishanwar@ti.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Subject: [PATCH net-next v2 2/2] net: hsr: Add KUnit test for PRP
Date: Fri, 21 Feb 2025 12:10:23 +0200
Message-ID: <20250221101023.91915-2-jkarrenpalo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221101023.91915-1-jkarrenpalo@gmail.com>
References: <20250221101023.91915-1-jkarrenpalo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>

Add unit tests for the PRP duplicate detection

Signed-off-by: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
---
Changes in v2:
- Changed KUnit tests to compile as built-in only

 net/hsr/Kconfig                |  14 +++
 net/hsr/Makefile               |   2 +
 net/hsr/prp_dup_discard_test.c | 210 +++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+)
 create mode 100644 net/hsr/prp_dup_discard_test.c

diff --git a/net/hsr/Kconfig b/net/hsr/Kconfig
index 1b048c17b6c8..07fc0a768b7e 100644
--- a/net/hsr/Kconfig
+++ b/net/hsr/Kconfig
@@ -38,3 +38,17 @@ config HSR
 	  relying on this code in a safety critical system!
 
 	  If unsure, say N.
+
+config PRP_DUP_DISCARD_KUNIT_TEST
+	bool "PRP duplicate discard KUnit tests" if !KUNIT_ALL_TESTS
+	depends on HSR = y && KUNIT = y
+	default KUNIT_ALL_TESTS
+	help
+	  Covers the PRP duplicate discard algorithm.
+	  Only useful for kernel devs running KUnit test harness and are not
+	  for inclusion into a production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/net/hsr/Makefile b/net/hsr/Makefile
index 75df90d3b416..34e581db5c41 100644
--- a/net/hsr/Makefile
+++ b/net/hsr/Makefile
@@ -8,3 +8,5 @@ obj-$(CONFIG_HSR)	+= hsr.o
 hsr-y			:= hsr_main.o hsr_framereg.o hsr_device.o \
 			   hsr_netlink.o hsr_slave.o hsr_forward.o
 hsr-$(CONFIG_DEBUG_FS) += hsr_debugfs.o
+
+obj-$(CONFIG_PRP_DUP_DISCARD_KUNIT_TEST) += prp_dup_discard_test.o
diff --git a/net/hsr/prp_dup_discard_test.c b/net/hsr/prp_dup_discard_test.c
new file mode 100644
index 000000000000..e212bdf24720
--- /dev/null
+++ b/net/hsr/prp_dup_discard_test.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+
+#include "hsr_main.h"
+#include "hsr_framereg.h"
+
+struct prp_test_data {
+	struct hsr_port port;
+	struct hsr_port port_rcv;
+	struct hsr_frame_info frame;
+	struct hsr_node node;
+};
+
+static struct prp_test_data *build_prp_test_data(struct kunit *test)
+{
+	struct prp_test_data *data = kunit_kzalloc(test,
+		sizeof(struct prp_test_data), GFP_USER);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, data);
+
+	data->frame.node_src = &data->node;
+	data->frame.port_rcv = &data->port_rcv;
+	data->port_rcv.type = HSR_PT_SLAVE_A;
+	data->node.seq_start[HSR_PT_SLAVE_A] = 1;
+	data->node.seq_expected[HSR_PT_SLAVE_A] = 1;
+	data->node.seq_start[HSR_PT_SLAVE_B] = 1;
+	data->node.seq_expected[HSR_PT_SLAVE_B] = 1;
+	data->node.seq_out[HSR_PT_MASTER] = 0;
+	data->node.time_out[HSR_PT_MASTER] = jiffies;
+	data->port.type = HSR_PT_MASTER;
+
+	return data;
+}
+
+static void check_prp_counters(struct kunit *test,
+			       struct prp_test_data *data,
+			       u16 seq_start_a, u16 seq_expected_a,
+			       u16 seq_start_b, u16 seq_expected_b)
+{
+	KUNIT_EXPECT_EQ(test, data->node.seq_start[HSR_PT_SLAVE_A],
+			seq_start_a);
+	KUNIT_EXPECT_EQ(test, data->node.seq_start[HSR_PT_SLAVE_B],
+			seq_start_b);
+	KUNIT_EXPECT_EQ(test, data->node.seq_expected[HSR_PT_SLAVE_A],
+			seq_expected_a);
+	KUNIT_EXPECT_EQ(test, data->node.seq_expected[HSR_PT_SLAVE_B],
+			seq_expected_b);
+}
+
+static void prp_dup_discard_forward(struct kunit *test)
+{
+	/* Normal situation, both LANs in sync. Next frame is forwarded */
+	struct prp_test_data *data = build_prp_test_data(test);
+
+	data->frame.sequence_nr = 2;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
+			data->node.seq_out[HSR_PT_MASTER]);
+	KUNIT_EXPECT_EQ(test, jiffies, data->node.time_out[HSR_PT_MASTER]);
+	check_prp_counters(test, data, data->frame.sequence_nr,
+			   data->frame.sequence_nr + 1, 1, 1);
+}
+
+static void prp_dup_discard_inside_dropwindow(struct kunit *test)
+{
+	/* Normal situation, other LAN ahead by one. Frame is dropped */
+	struct prp_test_data *data = build_prp_test_data(test);
+	unsigned long time = jiffies - 10;
+
+	data->frame.sequence_nr = 1;
+	data->node.seq_expected[HSR_PT_SLAVE_B] = 3;
+	data->node.seq_out[HSR_PT_MASTER] = 2;
+	data->node.time_out[HSR_PT_MASTER] = time;
+
+	KUNIT_EXPECT_EQ(test, 1,
+			prp_register_frame_out(&data->port, &data->frame));
+	KUNIT_EXPECT_EQ(test, 2, data->node.seq_out[HSR_PT_MASTER]);
+	KUNIT_EXPECT_EQ(test, time, data->node.time_out[HSR_PT_MASTER]);
+	check_prp_counters(test, data, 2, 2, 2, 3);
+}
+
+static void prp_dup_discard_node_timeout(struct kunit *test)
+{
+	/* Timeout situation, node hasn't sent anything for a while */
+	struct prp_test_data *data = build_prp_test_data(test);
+
+	data->frame.sequence_nr = 7;
+	data->node.seq_start[HSR_PT_SLAVE_A] = 1234;
+	data->node.seq_expected[HSR_PT_SLAVE_A] = 1235;
+	data->node.seq_start[HSR_PT_SLAVE_B] = 1234;
+	data->node.seq_expected[HSR_PT_SLAVE_B] = 1234;
+	data->node.seq_out[HSR_PT_MASTER] = 1234;
+	data->node.time_out[HSR_PT_MASTER] =
+		jiffies - msecs_to_jiffies(HSR_ENTRY_FORGET_TIME) - 1;
+
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
+			data->node.seq_out[HSR_PT_MASTER]);
+	KUNIT_EXPECT_EQ(test, jiffies, data->node.time_out[HSR_PT_MASTER]);
+	check_prp_counters(test, data, data->frame.sequence_nr,
+			   data->frame.sequence_nr + 1, 1234, 1234);
+}
+
+static void prp_dup_discard_out_of_sequence(struct kunit *test)
+{
+	/* One frame is received out of sequence on both LANs */
+	struct prp_test_data *data = build_prp_test_data(test);
+
+	data->node.seq_start[HSR_PT_SLAVE_A] = 10;
+	data->node.seq_expected[HSR_PT_SLAVE_A] = 10;
+	data->node.seq_start[HSR_PT_SLAVE_B] = 10;
+	data->node.seq_expected[HSR_PT_SLAVE_B] = 10;
+	data->node.seq_out[HSR_PT_MASTER] = 9;
+
+	/* 1st old frame, should be accepted */
+	data->frame.sequence_nr = 8;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
+			data->node.seq_out[HSR_PT_MASTER]);
+	check_prp_counters(test, data, data->frame.sequence_nr,
+			   data->frame.sequence_nr + 1, 10, 10);
+
+	/* 2nd frame should be dropped */
+	data->frame.sequence_nr = 8;
+	data->port_rcv.type = HSR_PT_SLAVE_B;
+	KUNIT_EXPECT_EQ(test, 1,
+			prp_register_frame_out(&data->port, &data->frame));
+	check_prp_counters(test, data, data->frame.sequence_nr + 1,
+			   data->frame.sequence_nr + 1,
+			   data->frame.sequence_nr + 1,
+			   data->frame.sequence_nr + 1);
+
+	/* Next frame, this is forwarded */
+	data->frame.sequence_nr = 10;
+	data->port_rcv.type = HSR_PT_SLAVE_A;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
+			data->node.seq_out[HSR_PT_MASTER]);
+	check_prp_counters(test, data, data->frame.sequence_nr,
+			   data->frame.sequence_nr + 1, 9, 9);
+
+	/* and next one is dropped */
+	data->frame.sequence_nr = 10;
+	data->port_rcv.type = HSR_PT_SLAVE_B;
+	KUNIT_EXPECT_EQ(test, 1,
+			prp_register_frame_out(&data->port, &data->frame));
+	check_prp_counters(test, data, data->frame.sequence_nr + 1,
+			   data->frame.sequence_nr + 1,
+			   data->frame.sequence_nr + 1,
+			   data->frame.sequence_nr + 1);
+}
+
+static void prp_dup_discard_lan_b_late(struct kunit *test)
+{
+	/* LAN B is behind */
+	struct prp_test_data *data = build_prp_test_data(test);
+
+	data->node.seq_start[HSR_PT_SLAVE_A] = 9;
+	data->node.seq_expected[HSR_PT_SLAVE_A] = 9;
+	data->node.seq_start[HSR_PT_SLAVE_B] = 9;
+	data->node.seq_expected[HSR_PT_SLAVE_B] = 9;
+	data->node.seq_out[HSR_PT_MASTER] = 8;
+
+	data->frame.sequence_nr = 9;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
+			data->node.seq_out[HSR_PT_MASTER]);
+	check_prp_counters(test, data, 9, 10, 9, 9);
+
+	data->frame.sequence_nr = 10;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
+			data->node.seq_out[HSR_PT_MASTER]);
+	check_prp_counters(test, data, 9, 11, 9, 9);
+
+	data->frame.sequence_nr = 9;
+	data->port_rcv.type = HSR_PT_SLAVE_B;
+	KUNIT_EXPECT_EQ(test, 1,
+			prp_register_frame_out(&data->port, &data->frame));
+	check_prp_counters(test, data, 10, 11, 10, 10);
+
+	data->frame.sequence_nr = 10;
+	data->port_rcv.type = HSR_PT_SLAVE_B;
+	KUNIT_EXPECT_EQ(test, 1,
+			prp_register_frame_out(&data->port, &data->frame));
+	check_prp_counters(test, data,  11, 11, 11, 11);
+}
+
+static struct kunit_case prp_dup_discard_test_cases[] = {
+	KUNIT_CASE(prp_dup_discard_forward),
+	KUNIT_CASE(prp_dup_discard_inside_dropwindow),
+	KUNIT_CASE(prp_dup_discard_node_timeout),
+	KUNIT_CASE(prp_dup_discard_out_of_sequence),
+	KUNIT_CASE(prp_dup_discard_lan_b_late),
+	{}
+};
+
+static struct kunit_suite prp_dup_discard_suite = {
+	.name = "prp_duplicate_discard",
+	.test_cases = prp_dup_discard_test_cases,
+};
+
+kunit_test_suite(prp_dup_discard_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.43.0


