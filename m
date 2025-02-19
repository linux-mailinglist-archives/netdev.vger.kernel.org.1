Return-Path: <netdev+bounces-167719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981B8A3BE83
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7CC16E5CF
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 12:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF01E285A;
	Wed, 19 Feb 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc7U4Ef+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5C1E25EB;
	Wed, 19 Feb 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969329; cv=none; b=aaWOKNTbDH6rFSjxafFvuBhoyaH0KFtP349JLBwnnHrteKIZNk8PVcrEL/NrRSiN303bSSq6yWJqQJE88IjfEe5MmfbvucRHahYtYMnC3gCH0z0uFqKkZDEc6PQRyGJdLeDN6hInSUCzYnwMwJOAqCushzgbG+TS60pypCxqHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969329; c=relaxed/simple;
	bh=0k00O3dedaXSkq8X71dtr6Gs0IkPdXHgP3eokPEhazU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTKNbwnObMAb0wXww1IY8KoiXsfvI2SHFjhchHCtrRrhNpzay0KXEAEuKvYKv+yok2i/d5WuFgRASnhHaHESr0vh5jybOcflhoouQ8SJ9rCgacTgydSrNj9tKdg4Ga5dwUNuGJmyvvPG7/0bn88d4Naim/LTj2fTqqaMe6UNceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc7U4Ef+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54622940ef7so3368365e87.3;
        Wed, 19 Feb 2025 04:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969325; x=1740574125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPUJe4F7NO0QNwPr6L/FNnvAtDpJ4vGmW7Xwi/oxtGU=;
        b=Mc7U4Ef+Tu6kkJyT5moBxXNbHUB5XTx2nyRc72GD0zcTCQ/Irr+qjB1PrUu9xmVQrX
         Ia+3UepzTk/LxsV5bS8B9je1wGasQs+49CFDQn6SKG4m6R+0e0+Th8RoSTlIUbTeLSTN
         Ra/NK0p7Ci5mN1mFxytlvBA/gJQTaBGUSYl3lXParA+0/c9Dc5S34UBGlu+6Cq4Q9SPe
         xQMIQRWsyPJEypdcvHTwpRW1WPQRDp0F/IMvm7aEAIzKPzQXnzBWpCNxnmmmRlDqr8+j
         UEPHgtIoFZFSk8c56SLWYzXzKvXHhEKrpm/17WCL53RBsQ8pskFOgmy2Y3VHTeRvm1dv
         PwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969325; x=1740574125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPUJe4F7NO0QNwPr6L/FNnvAtDpJ4vGmW7Xwi/oxtGU=;
        b=UkD7RkFaQFoqKXQ6ipOsGWkl3ZhRpIkucHfowJQRk0b6R54gl5Nclh/0kppusd6WaF
         gBJUOVho7vOYHq17YGdXCYBOsCFLqGs1jkup58WwRVs09edQoj2BgwQqHRsxbz0YPfHW
         sM4fVLSuNCmUxy1K5jjobzM5+IAYOleVgKTzuhKw/S6p82ryGddPz2ki0M5aTvhHvafN
         6WDNn06RGyJSwiNA1jX+0kdnVPyvlKsda7i4FMTJKPoiZzjcYp7UUi7it/23UlROnite
         QLGrJ5lUzkJaUw1CFsBoDqy+E9EAF7GEQbd1lp9sqPa1Oc0KfjLjVeIGRie/AujKeNu8
         AsVA==
X-Forwarded-Encrypted: i=1; AJvYcCVVyNU22NrBAa/3q4yWjXAlv0Q3XB2HaC4dRzEyoTczxjsa/uPn9e+YFIZgvzBJ00H4bsJ16ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDzPLXAQqbiIdmJVzqu8P3SjVoFZI9sC+BtjP1fqO65xmYHjj
	acBKyEut+Me7w1IlX1tSpVJxVuBoSC/Z3Ciw203+BGVfNlOziw7o
X-Gm-Gg: ASbGncvKRkqOtTd3mUdEh0/OOlbM0KuXS5h61mvPuct1wtx8xpxRsTyxaiqaB6HwkM7
	2SrxxYLb2vXU4qtui1PCPYzLsu1d4zFy2gCe31hSxsVNBxXbMc4HKNId+lTAaAj6HcKdf5mJHEu
	q8QKoHxhKgw8RCT/5pGVezTe0qlrdefCTiQD/SV+TUn3f5mX7YKVF+Tu/fSz8kVuqqVpqLp7wUq
	WQlnCAHqfM83K7Y9IEbkRVU3n+LM4GzOrA1AoyBY9FG9incqVqwgLnqppXmQF1s5fMvsAvqsVD3
	JbvFKlHT3AgxGHVThuxn3vlOENPscAVEPgbzEjmIpTCTsw==
X-Google-Smtp-Source: AGHT+IHtr0c6t4RY88x3YXdqbbjC9xNV9Tr8g0PeaxFCG9JzCy606WUl+z3oDN5IGfyHK3EdI+HuzA==
X-Received: by 2002:a05:6512:10d6:b0:545:1104:616a with SMTP id 2adb3069b0e04-5462eed85d5mr1225312e87.2.1739969324969;
        Wed, 19 Feb 2025 04:48:44 -0800 (PST)
Received: from FI-L-7486715.nmea.abb.com ([147.161.186.89])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452c937745sm1732697e87.243.2025.02.19.04.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:48:44 -0800 (PST)
From: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
X-Google-Original-From: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
Subject: [PATCH net-next 2/2] net: hsr: Add KUnit test for PRP
Date: Wed, 19 Feb 2025 14:48:31 +0200
Message-ID: <20250219124831.544318-2-jaakko.karrenpalo@fi.abb.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219124831.544318-1-jaakko.karrenpalo@fi.abb.com>
References: <20250219124831.544318-1-jaakko.karrenpalo@fi.abb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add unit tests for the PRP duplicate detection

Signed-off-by: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
---
 net/hsr/Kconfig                |  18 +++
 net/hsr/Makefile               |   2 +
 net/hsr/prp_dup_discard_test.c | 210 +++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
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


