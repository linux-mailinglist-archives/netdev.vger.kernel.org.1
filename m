Return-Path: <netdev+bounces-170113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4414EA47510
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 06:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6074F188B6C6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C281EB5F9;
	Thu, 27 Feb 2025 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTauy4o0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3791EB5E4;
	Thu, 27 Feb 2025 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632978; cv=none; b=RnJBY+kxrRHFDiUzyuOf/tKAxQ/xOZM5cJb7zGAnYtMTwADLDColdW7TZwBKKW4PGEFFA2C4Ei1BT90tPF9i6Q/mWk0YJKUmGqKnAo3SF4CEPibiT0li6QEhA5cxp2ZbtV/DKoaO7J/Mz8jjLj0KcbO4Ggytn26X3moNI3HQ4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632978; c=relaxed/simple;
	bh=3P77Ed2u6ebFpkQXjWAygr9kLCn79mmOWfLm3Bb7DDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVNIPKnStXYTLJ25sDLB9qZF6nxS9wcgwhP7ykG2fffD0qPK7EdACM9lu82a78NBQeVP49RklINV7325m5nNuA831al3JDNvO91rXI/3aG4HNjYDB68FAF066qlUOa6yYbohTzffWnbXek7hwRHNNo2qOM66pS4U2+fmpBQ851I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTauy4o0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5485646441cso517609e87.2;
        Wed, 26 Feb 2025 21:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740632974; x=1741237774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghfn4+Xg7hgsshvbiQ/zs+VWb3CYl/DNEJ7fYjzlr94=;
        b=iTauy4o077DOOyQQXzfJe9DUDhtxED5adadP9vY7Qs60QnQA78ULAVnpbcbLMeTv1b
         lRGSM83js+PEkYI0+pmmFxLTqVudngPyBIzxgLwL7dVw0a/lwoJlrpMtvj3cSH1YGd85
         7mC1QsnD4vtfBqdE4F9AKVQ99EC74eo9Q7UKaezuQKppfWoEIkXZJssZZzSp8UEmuT4O
         lpWHHL/up/dgrTFmxXSQBrOZGTISHctEUXLBdpbbDiNvmVOUnBGehnQK0Zia9bC281xs
         A3KaZ0negPbyY3zauHddY8DEz2SggKwvgwwuIxdpM8iAA244kOPf7fhC2kPvcRqafhIe
         0yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740632974; x=1741237774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghfn4+Xg7hgsshvbiQ/zs+VWb3CYl/DNEJ7fYjzlr94=;
        b=Yzsq0hPqZ8I1AcMo0f/FLGl3caKiLyNNNN4zDe4rR4rlo9iXz+/f4kwweUrQ/abB8H
         jYjBbBZfB7zctfZ5KjwPAvWSGJmboFln4jRBqTyDu57Ytq1IwW98ZMImUuBzBMHeHt1o
         VPPGNKfUHHPGoE0Nn1oUVrosMkt4oHcJL6hIFu+xLbLhwGvBcHi0myFBsANgSuU3GpV8
         m8d1p7vEQC27nBiF8LD1b0uuYa/W02x7WRff+bo96ZBBeqqaDXTDyyG+cSridrmvfC+n
         nuB2Mk2DPhRIDyKkAuLSVwbk8L8jpo/GJVuk3Vzmg3LO4rL6bt4X7lDuvlRqF2S//1u3
         Nnfw==
X-Forwarded-Encrypted: i=1; AJvYcCWa7hac6zMgnIbVLhLL9ZjxXLsfJCFJknaX50AHa84lxcTkZmNhqsxIcyfqSLOTrKhTpne2zDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1G3DiF20eZJhE+yx7oZf9N4QCIeCQ7f59urwM5AOjpUPuddO
	eITlAbjfdGFdaLAD4CtWYzKIMPf1Amf81gqb5+MJdJizRX7nk+h1
X-Gm-Gg: ASbGncvXnzneF4ZbSAbgUJBBLoPgAX8dKWlwyWxo6tO36o4xwdFIY2Cb1HQ26Tn/xbp
	PUm0HlGQ4+sDZelaIDlaIqzpzaGximsd9jDGMd1OR5GvyceR6Dq8DqwxoGF1gJ7jshsoXfcLKh0
	YpV598NK8d+pusLNwOKb7gOccz3etT7YZFCJjacsslc76Bi3kRFbzZud74i/O58LNSCufbmgMwg
	xVYCRkwkcx3HbES0DM7y41iOlsDY6GqEOsDypWJhwryK7vXu9kH/P6S5a8NCbEXOQFx3AAY6T22
	zHgwj10nJPqZxsgVmIOLLudu/yxq8780cmBQQRcu8gTDvSyW
X-Google-Smtp-Source: AGHT+IFgruQ0c5Yle6UgviWuKeKKrCUmKU6I4FHTT0v9WkwOjPJYRPPOuPZMXnQDz2shZ/BsyW09MA==
X-Received: by 2002:a05:6512:3ca9:b0:546:2ff9:1539 with SMTP id 2adb3069b0e04-54851109cfcmr5746238e87.52.1740632973727;
        Wed, 26 Feb 2025 21:09:33 -0800 (PST)
Received: from FI-L-7486715.nmea.abb.com ([147.161.186.106])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443cc9desm68509e87.221.2025.02.26.21.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 21:09:33 -0800 (PST)
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
Subject: [PATCH net-next v3 2/2] net: hsr: Add KUnit test for PRP
Date: Thu, 27 Feb 2025 07:09:23 +0200
Message-ID: <20250227050923.10241-2-jkarrenpalo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227050923.10241-1-jkarrenpalo@gmail.com>
References: <20250227050923.10241-1-jkarrenpalo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add unit tests for the PRP duplicate detection

Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
---
Changes in v2:
- Changed KUnit tests to compile as built-in only
Changes in v3:
- Changed the KUnit tests to compile as a module

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
index 79e066422044..3192e1253715 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -588,6 +588,10 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 	return 0;
 }
 
+#ifdef CONFIG_PRP_DUP_DISCARD_KUNIT_TEST_MODULE
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


