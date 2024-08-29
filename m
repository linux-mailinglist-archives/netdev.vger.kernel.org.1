Return-Path: <netdev+bounces-123147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED3963D66
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EDD1F24609
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899DA18952A;
	Thu, 29 Aug 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="JnMLiy8L"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7615B57B
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917455; cv=none; b=d9lzKVAg+yKUx8b0bkN5VtutJF8iniip8p7RGRZsp1StKxHQnlD3equGnqAMQgVdQieRILTaSp95Vm1AOizCEGAFE39twJdvIl50azv/LyhRcxspxWdTPtHHR5FaA3AYAbOl+awl+9u5mlPYxTWN+YRhi7o5zj/Yp7lnQLe5vtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917455; c=relaxed/simple;
	bh=+q3FPFGuibajnWuWX2jfk+fkSlj/QYdHqZdDZG49eSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8m4Z4/F2lS0zDRlTBQODbQI8e+iSTJEuo3KhJD5BzEWWh+GbWB8r03d27z1JvxRm6wqyAoG7ZHahY63OVSGQ93arIqksDm123TkFDiLwuYaJhcPuHhXq5pEIUQ0/MuEMT7xpkY3GZnhz+MY8asR+RT0vfnLmUlryloH1195g2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=JnMLiy8L; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724917445;
	bh=oo9yf4gSE/8aMfaF4REYuX4jPX28pDgBkc1JnnrYsHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JnMLiy8LwcBuLZOHFeMjyXa6WWWfWXeYUpc06xLYtCVBVjwLjODWAT4DL+LXgh63d
	 kLrqiW5iKzBValQyPIB1lihtS6p4xwxo8O3CHB4EQLxGzwy1/ixj98S7UT/rtFR2yc
	 0PfnxWrObXvzgJLeRrjHRwUz7xGiGfXyeGBJI9+q/kZ0udxEk86Hclg7GXS1cBkPnT
	 ncKfpNGupMBNrMwSI2VXw5xTYygrdldrOI58y3orT8eSHSHmUjQowW0Yh4KOaU1QFw
	 osTMULOQTogKstK0H78+yai2JntWN4AVDRC9722frVu73bbKYQFieEvJDac7Acsh36
	 1ZT86/itgyIlQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 585D067507; Thu, 29 Aug 2024 15:44:05 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH net v2 1/2] net: mctp-serial: Add kunit test for next_chunk_len()
Date: Thu, 29 Aug 2024 15:43:45 +0800
Message-ID: <20240829074355.1327255-2-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829074355.1327255-1-matt@codeconstruct.com.au>
References: <20240829074355.1327255-1-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test various edge cases of inputs that contain characters
that need escaping.

This adds a new kunit suite for mctp-serial.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---

v2: Fix kunit param const pointer

 drivers/net/mctp/Kconfig       |   5 ++
 drivers/net/mctp/mctp-serial.c | 109 +++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index ce9d2d2ccf3b..15860d6ac39f 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -21,6 +21,11 @@ config MCTP_SERIAL
 	  Say y here if you need to connect to MCTP endpoints over serial. To
 	  compile as a module, use m; the module will be called mctp-serial.
 
+config MCTP_SERIAL_TEST
+        bool "MCTP serial tests" if !KUNIT_ALL_TESTS
+        depends on MCTP_SERIAL=y && KUNIT=y
+        default KUNIT_ALL_TESTS
+
 config MCTP_TRANSPORT_I2C
 	tristate "MCTP SMBus/I2C transport"
 	# i2c-mux is optional, but we must build as a module if i2c-mux is a module
diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 5bf6fdff701c..7a40d07ff77b 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -521,3 +521,112 @@ module_exit(mctp_serial_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Jeremy Kerr <jk@codeconstruct.com.au>");
 MODULE_DESCRIPTION("MCTP Serial transport");
+
+#if IS_ENABLED(CONFIG_MCTP_SERIAL_TEST)
+#include <kunit/test.h>
+
+#define MAX_CHUNKS 6
+struct test_chunk_tx {
+	u8 input_len;
+	u8 input[MCTP_SERIAL_MTU];
+	u8 chunks[MAX_CHUNKS];
+};
+
+static void test_next_chunk_len(struct kunit *test)
+{
+	struct mctp_serial devx;
+	struct mctp_serial *dev = &devx;
+	int next;
+
+	const struct test_chunk_tx *params = test->param_value;
+
+	memset(dev, 0x0, sizeof(*dev));
+	memcpy(dev->txbuf, params->input, params->input_len);
+	dev->txlen = params->input_len;
+
+	for (size_t i = 0; i < MAX_CHUNKS; i++) {
+		next = next_chunk_len(dev);
+		dev->txpos += next;
+		KUNIT_EXPECT_EQ(test, next, params->chunks[i]);
+
+		if (next == 0) {
+			KUNIT_EXPECT_EQ(test, dev->txpos, dev->txlen);
+			return;
+		}
+	}
+
+	KUNIT_FAIL_AND_ABORT(test, "Ran out of chunks");
+}
+
+static struct test_chunk_tx chunk_tx_tests[] = {
+	{
+		.input_len = 5,
+		.input = { 0x00, 0x11, 0x22, 0x7e, 0x80 },
+		.chunks = { 3, 1, 1, 0},
+	},
+	{
+		.input_len = 5,
+		.input = { 0x00, 0x11, 0x22, 0x7e, 0x7d },
+		.chunks = { 3, 1, 1, 0},
+	},
+	{
+		.input_len = 3,
+		.input = { 0x7e, 0x11, 0x22, },
+		.chunks = { 1, 2, 0},
+	},
+	{
+		.input_len = 3,
+		.input = { 0x7e, 0x7e, 0x7d, },
+		.chunks = { 1, 1, 1, 0},
+	},
+	{
+		.input_len = 4,
+		.input = { 0x7e, 0x7e, 0x00, 0x7d, },
+		.chunks = { 1, 1, 1, 1, 0},
+	},
+	{
+		.input_len = 6,
+		.input = { 0x7e, 0x7e, 0x00, 0x7d, 0x10, 0x10},
+		.chunks = { 1, 1, 1, 1, 2, 0},
+	},
+	{
+		.input_len = 1,
+		.input = { 0x7e },
+		.chunks = { 1, 0 },
+	},
+	{
+		.input_len = 1,
+		.input = { 0x80 },
+		.chunks = { 1, 0 },
+	},
+	{
+		.input_len = 3,
+		.input = { 0x80, 0x80, 0x00 },
+		.chunks = { 3, 0 },
+	},
+	{
+		.input_len = 7,
+		.input = { 0x01, 0x00, 0x08, 0xc8, 0x00, 0x80, 0x02 },
+		.chunks = { 7, 0 },
+	},
+	{
+		.input_len = 7,
+		.input = { 0x01, 0x00, 0x08, 0xc8, 0x7e, 0x80, 0x02 },
+		.chunks = { 4, 1, 2, 0 },
+	},
+};
+
+KUNIT_ARRAY_PARAM(chunk_tx, chunk_tx_tests, NULL);
+
+static struct kunit_case mctp_serial_test_cases[] = {
+	KUNIT_CASE_PARAM(test_next_chunk_len, chunk_tx_gen_params),
+};
+
+static struct kunit_suite mctp_serial_test_suite = {
+	.name = "mctp_serial",
+	.test_cases = mctp_serial_test_cases,
+};
+
+kunit_test_suite(mctp_serial_test_suite);
+
+#endif /* CONFIG_MCTP_SERIAL_TEST */

