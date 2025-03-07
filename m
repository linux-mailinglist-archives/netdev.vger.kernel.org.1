Return-Path: <netdev+bounces-173008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4753AA56D5E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7308F172807
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731E423A9AC;
	Fri,  7 Mar 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOFNYEia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56019239584;
	Fri,  7 Mar 2025 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364235; cv=none; b=X0shrG/PwsTkWYh2TYnzTtzNUn33H20SFoZwR8mn1jSJcWq7AyOM3tvSyYD0SI0ukO9zJQJSEDfPa1ukhqflWjo5Xv3EaLHuTV0SQDJsJABQB7M84shoC6Sg18gTDKdu2cQvM6KJW+cIBSFv+smFRyTFXufzWraQMRSAzJdTMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364235; c=relaxed/simple;
	bh=CFLYJF+feSSaj+s2sN02KbOD/ritJwT0Nj7VDLl11d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7xWhwiZxLzjXUlUZEkUaaKmoxCOuR7TPRj+2xmQZJqC2qW2lztwewoUw0FWa9Aqe3YQOZruvfi/D8mCIizKFsgw3prvcW3qUmzjKvyMrFqKZKpVblB2HouC+aLdvn56Hb+lY9Q+mUBBo1Vxkj0Jv7UYIF3CiEaBQapryhwpFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOFNYEia; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30615661f98so21003791fa.2;
        Fri, 07 Mar 2025 08:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364231; x=1741969031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EtWFQkCXel9s2dN44z5xA5xB3UBPxFhvaOP5Z8Z62g=;
        b=bOFNYEiahQ1ian/gSuN1MOkXoYfqnSYWRCg+Vm3jHqyQP1RDpIoFfUtC7mpmZcYFEA
         zN3GhcRguTeqk59LsTcYDY1cEd7W7TRgP7J9X3yvJxkt9o1VR25ETMwwYdYPlgW1+DBx
         7pgII1wZwGR/K48GzQOdBO++FUWUtOaaonokbydzyOw/eKmrfRi3/z6uzOBSBJGnWA+4
         wizMJGzbUPC87TNL0LGbLZAWMHEtz5zSHYIJmuycejlvhuD+vAHCCOHXmxb2zpWHzWyW
         BRJb+OZV9EZNOyFfD0Dt45oaUaYEpcXip55Bqm9Az+HtW0kkeiArz7cQSRVLg1uzRFGb
         ZRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364231; x=1741969031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EtWFQkCXel9s2dN44z5xA5xB3UBPxFhvaOP5Z8Z62g=;
        b=NZ8hl843r6a8PmKDbIAkE6HMVIIIN8/hqL70I1ZhH0zx27My+gY404yN/koHJ94t+V
         KonFfi1B418F5P8jvf2FrFhi9BJiYGOfRKFUS1mZYTleMNGNUb+pM+T5IAjSvhCHrm/6
         NB2viKyr8TONTxHZgLPeaqTts9WR0O/J/P8WdecHUB9mN087sFOcINUKxTBATPCbFqiM
         7554CkiDRbKRWWPpHhItQGwMrM/87A4ysvcJBu8Ej9zSq6jLph/y2MeJ1Q9Y7lfRLdjq
         7WLO0hcZjQhCQfxDYarMyU916EUFJmilW7vtK8EIb/xJQRighcrSBub9QdbPRX6OfLlu
         UdtA==
X-Forwarded-Encrypted: i=1; AJvYcCVkODSKOsJapxXrEe9v7eMGkhpHv9DKFwL+Q61kEG71QlSTXDrTGtsPslmPLxnPOKlh7Bo7xa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmMNgU4lJfqux3sUwSoVpU4nzAdep6R1O71RxETrcq++AwfAwd
	3cnBdy5PGqvBgvyDUeNYdtDzL3jna74X/BiOdFs9MWouL77lwacr
X-Gm-Gg: ASbGncsx1i3SQeCxha8qjGLuvtRBF1NZFBZnRrqe+hW3mBQ0Ht9SH0pe6mEPjJbk+rj
	zWOIy+dbBQep8CIMt31MFeLnM81o3NpOJkFr+UrFDvRLI+/ar2Z3BwvVWvD4FJMcGeC97jKndoG
	PHgLKx4foNKJDAF77x5cfaKTa4KaQtIoaPcKAV22Zzg9LD/oNxkHRCQK8slPBAb/R/NO4OC+v31
	1nrvM+BVckeHl8M5uX32POheNFrF1UBTsjqqUL8QwtSEmOzDBLWHivbBkagGEMNvKiCCJdVZAc5
	q17sbiPYw+uVQGDYMNJAxE4uKG1+fT2urobh1oyldRW6/fWuKqVBJ6sK+pdUD6igwIE=
X-Google-Smtp-Source: AGHT+IHAscthoT4w93NULPpEHbceWu+EEeH6bxE6fcMpg+dLTt5zCiiacXYNhS6hInQEWpA0vUzWOQ==
X-Received: by 2002:a05:651c:220f:b0:30b:9813:b00e with SMTP id 38308e7fff4ca-30bf45f28b4mr14304731fa.24.1741364231001;
        Fri, 07 Mar 2025 08:17:11 -0800 (PST)
Received: from FI-L-7486715.nmea.abb.com ([147.161.186.106])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be98d0b35sm5739831fa.16.2025.03.07.08.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:17:10 -0800 (PST)
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
Subject: [PATCH net-next v5 2/2] net: hsr: Add KUnit test for PRP
Date: Fri,  7 Mar 2025 18:17:00 +0200
Message-ID: <20250307161700.1045-2-jkarrenpalo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307161700.1045-1-jkarrenpalo@gmail.com>
References: <20250307161700.1045-1-jkarrenpalo@gmail.com>
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
Changes in v5:
- Use correct define in IS_MODULE()

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
index 85991fab7db5..4ce471a2f387 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -588,6 +588,10 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 	return 0;
 }
 
+#if IS_MODULE(CONFIG_PRP_DUP_DISCARD_KUNIT_TEST)
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


