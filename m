Return-Path: <netdev+bounces-171578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C59A4DB3B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210CE3B4E57
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806D71FF1BC;
	Tue,  4 Mar 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUXLZKoW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8821FECC1;
	Tue,  4 Mar 2025 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084845; cv=none; b=beRZmjemiPWiga2E7her6IqHDcTOSjvdMr3WUP1Ynr19mE+mIXEFd9DZ8rIwS/ksCv1vXLaZdHIV5wsSFkXDqG1g7+dB1s1z5yvUzrHAKuZK5GTV3WK2iskHZlmsCV+DLvW7XXykjee0eGqDWGCinCbpYBTZHyApmjev+7YlGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084845; c=relaxed/simple;
	bh=BC9Up8a5jXBAnUNDOrFn7GSDxWP4u6ft0EmYiwWAwm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwF7UjljKVv/OX67HpxcMrESkolWmV4MOJwCkGOa+B1oD/8h6/n3N7PF8N2xycY/ELYhjUv7IzT9OneBlpdUDPyawv22PIW0bMaWPNv/LHeJSl/QcAFaEnTHWGq34MI+bJpzpfCKZcgpZQfK/X7zj34S/GoVgZ+z8g47zSKweQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUXLZKoW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5494bc4d741so4769453e87.2;
        Tue, 04 Mar 2025 02:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741084841; x=1741689641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ou368VWi85gAeSM0ZRDpJ8qYKNlqWqagH2aug2FfN9g=;
        b=fUXLZKoW4xdtWfuBsLaQViUzbCULjxbaqXrDW4BPyLlMhdzf+rYWymY/tGhvZVJum7
         WCeX8hOilfqpPlCepLl9Lqyiyei5cCJ9/NUK9bxx18D+CJwj78zo0eeJrh09SxOba27w
         Kd7oD9MRYSZbhc4EGOCRiS7OCCAEdfSvbUG+X0QjhM5KZzs1hLVkvRYKHUsTMsuVhgQs
         2v8BjrkJ3us0GVZSdKN4VHMcjjseT8BZUiiQB0lH/cOSUptMu5qb5g4sSKmV09z+uBxZ
         ccI2TImU67j5HVa0XxhIPYu3e0VzvZdSFZpZiaT98iNP3Y3pfYfN0KKlWtHbVSlVDotd
         Op3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084841; x=1741689641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ou368VWi85gAeSM0ZRDpJ8qYKNlqWqagH2aug2FfN9g=;
        b=Kbzt0y2oI/2hq6wA7WegHVpWF1sBcd+ylxT9Nk+lIGzqh3KprGji3P5H3cpJgbMmt2
         9asWnuR+Rr+6VEQ/nS4yINnyiHD4v190AeYjQr6o4ukTaZYBvZ3uvjqi1j91BLj0Te+9
         wzKvP+1ja9TgGfDwojR+axyAJ/qQYLfpSB5hSXUxSy8qxtsrPEtuBzuLttPe8hfQWCmH
         4I6Xu5I07QsQo45GVNxchWKiM8paFXWqjqf6d0ZbSsSy62bgLONbqk/7boYklpZC2gl8
         u7KUAm+h8bGQBL4yCI3BPvADwUQjaQQOQnKZZzv4DA+8Gk91+znspX9a8CUJsD7i8J8A
         tr6w==
X-Forwarded-Encrypted: i=1; AJvYcCUQfnZ6jpDVPNGI5vh56G47kDNsDNuJoa9gvqJ72wbAFZejJynSo2Y69c6CdVfGwzDGtE7kuK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJaPVLTQBvP9r82YOruVkOu11pWcjaS+Bz93x1PHJOL595hytu
	elmWet7EpEf18LUpwrKFPke80B7Zz3BZqlbkD33IN6IkHENcVoUM
X-Gm-Gg: ASbGncuKPqDCYimOSoZbZjH3floNwxIzowdoi/AgGY/359PU/YcfaJ34RyOgCtN0ozF
	QGWR1fKDVwqC6QqM70WURB2w3s1khl/ChtoQEGnkad6vikGzgf3TZIzhSorEQjPbyrUtb28PLro
	cjlFMB0s2HfiXPuwHqz8FgPW+JQ+yee4Pn/177Cm++A3c5Od7Bb5JvUD/U+fXSRgOOJH5fLkdxr
	O1np7RTtBMDR07tWWDEx7JHADecj9RL/XAvjrqXvN9mZ8BqcKBlu1wsSzmxj7blYmrXWyRvx3M3
	CVrv1KUzfthdeUcBVnvf08RlIdX8Byw/RHSQeroDZl9J8Lfabcd+5m6FOW5uRn7wLmY=
X-Google-Smtp-Source: AGHT+IHiBwV8eMcmPx18KfNmZrGZF5YFxUnMFNgWjueSm6lcs+wiRrPHpYRCQjQE05cHU5cZeqn0Nw==
X-Received: by 2002:a05:6512:281d:b0:545:56c:36c7 with SMTP id 2adb3069b0e04-5494c3521famr7132450e87.41.1741084840973;
        Tue, 04 Mar 2025 02:40:40 -0800 (PST)
Received: from FI-L-7486715.nmea.abb.com ([147.161.186.106])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495f4c36d1sm798824e87.52.2025.03.04.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:40:40 -0800 (PST)
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
Subject: [PATCH net-next v4 2/2] net: hsr: Add KUnit test for PRP
Date: Tue,  4 Mar 2025 12:40:30 +0200
Message-ID: <20250304104030.69395-2-jkarrenpalo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304104030.69395-1-jkarrenpalo@gmail.com>
References: <20250304104030.69395-1-jkarrenpalo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add unit tests for the PRP duplicate detection

Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- Changed KUnit tests to compile as built-in only
Changes in v3:
- Changed the KUnit tests to compile as a module
Changes in v4:
- Use IS_MODULE for checking if the unit test is compiled
  as a loadable module

Thanks to Paolo and Simon for reviewing!

 net/hsr/Kconfig                |  18 +++
 net/hsr/Makefile               |   2 +
 net/hsr/hsr_framereg.c         |   4 +
 net/hsr/prp_dup_discard_test.c | 212 +++++++++++++++++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 net/hsr/prp_dup_discard_test.c

diff --git a/net/hsr/Kconfig b/net/hsr/Kconfig
index 1b048c17b6c8..fcacdf4f0ffc 100644
--- a/net/hsr/Kconfig
+++ b/net/hsr/Kconfig
@@ -38,3 +38,21 @@ config HSR
 	  relying on this code in a safety critical system!
 
 	  If unsure, say N.
+
+if HSR
+
+config PRP_DUP_DISCARD_KUNIT_TEST
+	tristate "PRP duplicate discard KUnit tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT
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
+
+endif
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
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 85991fab7db5..1404f71b9e3f 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -588,6 +588,10 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 	return 0;
 }
 
+#if IS_MODULE(CONFIG_PRP_DUP_DISCARD_KUNIT_TEST_MODULE)
+EXPORT_SYMBOL(prp_register_frame_out);
+#endif
+
 static struct hsr_port *get_late_port(struct hsr_priv *hsr,
 				      struct hsr_node *node)
 {
diff --git a/net/hsr/prp_dup_discard_test.c b/net/hsr/prp_dup_discard_test.c
new file mode 100644
index 000000000000..e86b7b633ae8
--- /dev/null
+++ b/net/hsr/prp_dup_discard_test.c
@@ -0,0 +1,212 @@
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
+MODULE_DESCRIPTION("KUnit tests for PRP duplicate discard");
+MODULE_AUTHOR("Jaakko Karrenpalo <jkarrenpalo@gmail.com>");
-- 
2.43.0


