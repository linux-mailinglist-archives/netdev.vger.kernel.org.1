Return-Path: <netdev+bounces-264454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHDLBwSdqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:11:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA67E2143B6
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FB9D300E5AC
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE053BD653;
	Thu,  5 Mar 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZJRqTVq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A0B3BD642
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723402; cv=none; b=W9egpr7nX3AeV9XFZgkXKPzi/LLtQLyaclTn17NYEna2CcP0YyS0AjK+hGaA5w0r4aHgFwGTROWTJ4NU9EfjwJ894GiQ/1ATblal2GfnUdYa16+FtrWkU1I1ywGvC+of36ahCmioKrLMjle+DhmYRMzKFzauYKipmERarlEeIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723402; c=relaxed/simple;
	bh=1NS1S6/8Ze2Z0/M3844fFfkCENDcmedAZ/SnBm1J5h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFDlFS9gkGkgGS57HMnbhFobcymjdsWJkcKpvBL+7kiqqwS0SdtnLoq2X0yKN8tAjQNblqbLJBUX6oGyDGxFqVbKgxC4R9dRwlINjDZt3dnSFYCvNwxfE8qgFPFk9Pt6AesaNW9r3UZJn91/29vOwRC8efWRKxgZ3VGPUVZh2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZJRqTVq; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899fc9853b7so60202566d6.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 07:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772723399; x=1773328199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75guPzLnund8QIHTGwjGBLHPWaMv1GdwyGtIfQpeONU=;
        b=DZJRqTVqGm8XIMBBIrM19obpO+LrdXb6lfO4yyl33KFXH+Z67HcLti+fo8FUc9SkGR
         Bfo+EnQthsGd8ZuYx84ghbMcy196lCzayEQ7nQjJ5NIHQIJz70E+xlg9bVzinXvihADB
         bZnK+xR1hC6v6pZ5bW4Y73Iz5Hfpob9cuBEH3R6LsZUcnFi0/xyqnxLYi5900AvDyqA2
         YKJUbgSJZvywRN9/JLTjrElVjMsdMTz8loYTC56oynFwPc0iK7F0g8dBN15EHFffIU57
         MfPfNU0stwJpxKhDP+j6o3QpyawRw9KpqV/7nojoXi+2mBA0p+U8tqIp/3KvTtRap5/I
         uREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772723399; x=1773328199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75guPzLnund8QIHTGwjGBLHPWaMv1GdwyGtIfQpeONU=;
        b=M69Facor3+Ey1PocwWNlLsMlJaCv56rSwuzcrtE43kzvFZsYjXoGAdPq5F8blUlK0p
         G3L9Gkr55gOArHlcoS4y2vTAXg4bdsCWSM0+pDGPiW0zoUfrEpdUZil6HQQ6jqSP8S4t
         cz6c4gvd05vE+4DWyajyfP8QsHeqkDrXFWRUbIYcf1rm6gr09PbBWH9RCrRdueW7riHA
         4W9nDMLvl6HmCcWnR/EJZYkFtN4oIHb63B9ZMnIce9GbKfkQgOoU2aOXBdUvdE57Dx8X
         rIiYIT+lG8af90lo2ttbaSmYkqRjyrrY6I97n7EhSNIqgYS/L0gQxkCbRqceOOyazfFx
         eXxw==
X-Forwarded-Encrypted: i=1; AJvYcCV9bDi049EblHCKQG+2ne0RUnGI3QqsboyN0ex8OTFzJ7z1oPlpmhwiavCjLi/nUz6EVy5qZfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsT6xGO590KSIRpBefSBA3yeyqdesoenhbPgHoUs5IN9wvmWb
	yBkDdtiPJWSI6CWEAq+nVdXK0HoRb9o2K0ObwCzbQrRxA2RVFSRchy4Y
X-Gm-Gg: ATEYQzy4aggGdGGL0rLHopGsGS2uwnTtv6hH1xJXkgWJioCc19vmzhDh32aCw6BU7qM
	fFvEzhRJl+5Ih/ZIUAnGxVuHkAwvBOVcJ34JVV7UVqmjylTmVdAUl8163+0zx0VoGeGK0IX0Ubl
	j30lD7gvOHgpuGEvet+D4BYgNXOGudgwpMTUdM+keZTLslTzQX5ZtUpL8b+MQdg9ixfyEbmX+V3
	DO2r4+4GPKIbgeqnz2g7EkI5WsXf0dZqCFRaP0vHkCY/gL6qqAvv4bmFs+h/L24wtl7YFR6D3fJ
	xG82iiA35kgbcZG/37276mzYC4fVCbjUto2Y2MlO34ZfVmya2vyiacPqdy6LBp7cn3c61f9JBc6
	cPol71ZeZVvRbjwupxpIn8bks+0VEwoV9KDD2MdpL7sFscwWQF1M4SdAKV593UUJ2EAGXxyeLXn
	r9zDsIgIrsNoIZYnk8wQMxZ/oNlCjjOftihYIKNErRkN1Jne155TvaxTXVjFhS7wam7pG6xOnUa
	eNe+CV5KKKxZsOu
X-Received: by 2002:a05:6214:2b06:b0:899:fad1:64e7 with SMTP id 6a1803df08f44-89a19d02056mr74295566d6.47.1772723399159;
        Thu, 05 Mar 2026 07:09:59 -0800 (PST)
Received: from PF5YBGDS.localdomain (70.15.25.19.res-cmts.sm3.ptd.net. [70.15.25.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0bb6e27asm64183176d6.2.2026.03.05.07.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 07:09:58 -0800 (PST)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/5] eth fbnic: Add register self test
Date: Thu,  5 Mar 2026 10:09:44 -0500
Message-ID: <20260305150947.16893-3-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
References: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA67E2143B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264454-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The register test will be used to verify hardware is behaving as expected.

The test itself will have us writing to registers that should have no
side effects due to us resetting after the test has been completed.

While the test is being run the interface should be offline.

This patch counts on the first patch of this series to export netif_open()
and also ensures that the half close calls netif_close() to
avoid deadlock.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2 - add enum for test return codes
   - place forward of struct fbnic_dev after include with a blank line
v3 - no changes

 drivers/net/ethernet/meta/fbnic/fbnic.h       |  18 +++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c   | 128 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  19 +++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  50 +++++++
 3 files changed, 197 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
index d9c0dc1c2af9..dc62d623e37c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
@@ -147,3 +147,131 @@ int fbnic_csr_regs_len(struct fbnic_dev *fbd)
 
 	return len;
 }
+
+/* CSR register test data
+ *
+ * The register test will be used to verify hardware is behaving as expected.
+ *
+ * The test itself will have us writing to registers that should have no
+ * side effects due to us resetting after the test has been completed.
+ * While the test is being run the interface should be offline.
+ */
+struct fbnic_csr_reg_test_data {
+	int	reg;
+	u16	reg_offset;
+	u8	array_len;
+	u32	read;
+	u32	write;
+};
+
+#define FBNIC_QUEUE_REG_TEST(_name, _read, _write) { \
+	.reg = FBNIC_QUEUE(0) + FBNIC_QUEUE_##_name, \
+	.reg_offset = FBNIC_QUEUE_STRIDE, \
+	.array_len = 64, \
+	.read = _read, \
+	.write = _write \
+}
+
+static const struct fbnic_csr_reg_test_data pattern_test[] = {
+	FBNIC_QUEUE_REG_TEST(TWQ0_CTL, FBNIC_QUEUE_TWQ_CTL_RESET,
+			     FBNIC_QUEUE_TWQ_CTL_RESET),
+	FBNIC_QUEUE_REG_TEST(TWQ0_PTRS, 0, ~0),
+	FBNIC_QUEUE_REG_TEST(TWQ0_SIZE, FBNIC_QUEUE_TWQ_SIZE_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(TWQ0_BAL, FBNIC_QUEUE_BAL_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(TWQ0_BAH, ~0, ~0),
+	FBNIC_QUEUE_REG_TEST(TWQ1_CTL, FBNIC_QUEUE_TWQ_CTL_RESET,
+			     FBNIC_QUEUE_TWQ_CTL_RESET),
+	FBNIC_QUEUE_REG_TEST(TWQ1_PTRS, 0, ~0),
+	FBNIC_QUEUE_REG_TEST(TWQ1_SIZE, FBNIC_QUEUE_TWQ_SIZE_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(TWQ1_BAL, FBNIC_QUEUE_BAL_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(TWQ1_BAH, ~0, ~0),
+	FBNIC_QUEUE_REG_TEST(TCQ_CTL, FBNIC_QUEUE_TCQ_CTL_RESET,
+			     FBNIC_QUEUE_TCQ_CTL_RESET),
+	FBNIC_QUEUE_REG_TEST(TCQ_PTRS, 0, ~0),
+	FBNIC_QUEUE_REG_TEST(TCQ_SIZE, FBNIC_QUEUE_TCQ_SIZE_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(TCQ_BAL, FBNIC_QUEUE_BAL_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(TCQ_BAH, ~0, ~0),
+	FBNIC_QUEUE_REG_TEST(RCQ_CTL, FBNIC_QUEUE_RCQ_CTL_RESET,
+			     FBNIC_QUEUE_RCQ_CTL_RESET),
+	FBNIC_QUEUE_REG_TEST(RCQ_PTRS, 0, ~0),
+	FBNIC_QUEUE_REG_TEST(RCQ_SIZE, FBNIC_QUEUE_RCQ_SIZE_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(RCQ_BAL, FBNIC_QUEUE_BAL_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(RCQ_BAH, ~0, ~0),
+	FBNIC_QUEUE_REG_TEST(BDQ_CTL, FBNIC_QUEUE_BDQ_CTL_RESET,
+			     FBNIC_QUEUE_BDQ_CTL_RESET),
+	FBNIC_QUEUE_REG_TEST(BDQ_HPQ_PTRS, 0, ~0),
+	FBNIC_QUEUE_REG_TEST(BDQ_HPQ_SIZE, FBNIC_QUEUE_BDQ_SIZE_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(BDQ_HPQ_BAL, FBNIC_QUEUE_BAL_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(BDQ_HPQ_BAH, ~0, ~0),
+	FBNIC_QUEUE_REG_TEST(BDQ_PPQ_PTRS, 0, ~0),
+	FBNIC_QUEUE_REG_TEST(BDQ_PPQ_SIZE, FBNIC_QUEUE_BDQ_SIZE_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(BDQ_PPQ_BAL, FBNIC_QUEUE_BAL_MASK, ~0),
+	FBNIC_QUEUE_REG_TEST(BDQ_PPQ_BAH, ~0, ~0),
+};
+
+static enum fbnic_reg_self_test_codes
+fbnic_csr_reg_pattern_test(struct fbnic_dev *fbd, int index,
+			   const struct fbnic_csr_reg_test_data *test_data)
+{
+	static const u32 pattern[] = { ~0, 0x5A5A5A5A, 0xA5A5A5A5, 0};
+	enum fbnic_reg_self_test_codes reg;
+	int i;
+
+	reg = test_data->reg + test_data->reg_offset * index;
+	for (i = 0; i < ARRAY_SIZE(pattern); i++) {
+		u32 val = pattern[i] & test_data->write;
+		u32 result;
+
+		wr32(fbd, reg, val);
+		result = rd32(fbd, reg);
+		val &= test_data->read;
+
+		if (result == val)
+			continue;
+
+		dev_err(fbd->dev,
+			"%s: reg 0x%06X failed, expected 0x%08X received 0x%08X\n",
+			__func__, reg, val, result);
+
+		/* Note that FBNIC_INTR_STATUS(0) could be tested and fail
+		 * and the result would not be reported since the register
+		 * offset is 0. However as that register isn't included in
+		 * the register test that isn't an issue.
+		 */
+		return reg;
+	}
+
+	return FBNIC_REG_TEST_SUCCESS;
+}
+
+/**
+ * fbnic_csr_regs_test() - Verify behavior of NIC registers
+ * @fbd: device to test
+ *
+ * This function is meant to test the bit values of various registers in
+ * the NIC device. Specifically this test will verify which bits are
+ * writable and which ones are not. It will write varying patterns of bits
+ * to the registers testing for sticky bits, or bits that are writable but
+ * should not be.
+ *
+ * Return: FBNIC_REG_TEST_SUCCESS on success, register number on failure
+ **/
+enum fbnic_reg_self_test_codes fbnic_csr_regs_test(struct fbnic_dev *fbd)
+{
+	const struct fbnic_csr_reg_test_data *test_data;
+
+	for (test_data = pattern_test;
+	     test_data < pattern_test + ARRAY_SIZE(pattern_test); test_data++) {
+		u32 i;
+
+		for (i = 0; i < test_data->array_len; i++) {
+			enum fbnic_reg_self_test_codes reg =
+				fbnic_csr_reg_pattern_test(fbd, i, test_data);
+
+			if (reg)
+				return reg;
+		}
+	}
+
+	return FBNIC_REG_TEST_SUCCESS;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index b717db879cd3..7cfb42067327 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -6,6 +6,8 @@
 
 #include <linux/bitops.h>
 
+struct fbnic_dev;
+
 #define CSR_BIT(nr)		(1u << (nr))
 #define CSR_GENMASK(h, l)	GENMASK(h, l)
 
@@ -1210,4 +1212,21 @@ enum{
 	FBNIC_CSR_VERSION_V1_0_ASIC = 1,
 };
 
+/**
+ * enum fbnic_reg_self_test_codes - return codes from self test routines
+ *
+ * This is the code that is returned from the register self test
+ * routines.
+ *
+ * The test either returns success or the register number
+ * that failed during the test.
+ *
+ * @FBNIC_REG_TEST_SUCCESS: no errors
+ */
+enum fbnic_reg_self_test_codes {
+	FBNIC_REG_TEST_SUCCESS = 0,
+};
+
+enum fbnic_reg_self_test_codes fbnic_csr_regs_test(struct fbnic_dev *fbd);
+
 #endif /* _FBNIC_CSR_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 11745a2d8a44..2e882dbd408d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -126,6 +126,16 @@ static const struct fbnic_stat fbnic_gstrings_xdp_stats[] = {
 #define FBNIC_STATS_LEN \
 	(FBNIC_HW_STATS_LEN + FBNIC_XDP_STATS_LEN * FBNIC_MAX_XDPQS)
 
+enum fbnic_self_test_results {
+	TEST_REG = 0,
+};
+
+static const char fbnic_gstrings_self_test[][ETH_GSTRING_LEN] = {
+	[TEST_REG]	= "Register test (offline)",
+};
+
+#define FBNIC_TEST_LEN ARRAY_SIZE(fbnic_gstrings_self_test)
+
 static void
 fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 {
@@ -475,6 +485,10 @@ static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
 		for (i = 0; i < FBNIC_MAX_XDPQS; i++)
 			fbnic_get_xdp_queue_strings(&data, i);
 		break;
+	case ETH_SS_TEST:
+		memcpy(data, fbnic_gstrings_self_test,
+		       sizeof(fbnic_gstrings_self_test));
+		break;
 	}
 }
 
@@ -566,6 +580,8 @@ static int fbnic_get_sset_count(struct net_device *dev, int sset)
 	switch (sset) {
 	case ETH_SS_STATS:
 		return FBNIC_STATS_LEN;
+	case ETH_SS_TEST:
+		return FBNIC_TEST_LEN;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1475,6 +1491,39 @@ fbnic_remove_rxfh_context(struct net_device *netdev,
 	return 0;
 }
 
+static int fbnic_ethtool_regs_test(struct net_device *netdev, u64 *data)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	*data = fbnic_csr_regs_test(fbd);
+
+	return !!*data;
+}
+
+static void fbnic_self_test(struct net_device *netdev,
+			    struct ethtool_test *eth_test, u64 *data)
+{
+	bool if_running = netif_running(netdev);
+
+	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE)) {
+		data[TEST_REG] = 0;
+		return;
+	}
+
+	if (if_running)
+		netif_close(netdev);
+
+	if (fbnic_ethtool_regs_test(netdev, &data[TEST_REG]))
+		eth_test->flags |= ETH_TEST_FL_FAILED;
+
+	if (if_running && netif_open(netdev, NULL)) {
+		netdev_err(netdev,
+			   "Failed to re-initialize hardware following test\n");
+		eth_test->flags |= ETH_TEST_FL_FAILED;
+	}
+}
+
 static void fbnic_get_channels(struct net_device *netdev,
 			       struct ethtool_channels *ch)
 {
@@ -1893,6 +1942,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_pause_stats		= fbnic_get_pause_stats,
 	.get_pauseparam			= fbnic_phylink_get_pauseparam,
 	.set_pauseparam			= fbnic_phylink_set_pauseparam,
+	.self_test			= fbnic_self_test,
 	.get_strings			= fbnic_get_strings,
 	.get_ethtool_stats		= fbnic_get_ethtool_stats,
 	.get_sset_count			= fbnic_get_sset_count,
-- 
2.43.0


