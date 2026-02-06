Return-Path: <netdev+bounces-257595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFDkNEgMhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:44:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA24FFDC2
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39B4A3048038
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D632D94BE;
	Fri,  6 Feb 2026 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhkTVQMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A33B2D7DEA
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392571; cv=none; b=j71hCf4Etmu0ok8FuSr7U69S7WEFAmiED+PntikoxN3/87TdrSu0Wt9tYQdQ+toXNMbocSnsVbR7/wA7P45gOcnatlQprbF+c0KvbZYyhT/Vo4By7Tkm8jWQdO61GkwWTUZ8NjV9EkyyUpLeSbTXXp0ddrss5mhd6p8/13/f+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392571; c=relaxed/simple;
	bh=00tZ7hEKaVSKAGSZ3kjjf4Nu/LRjLj2wUt3oFw5KAcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDv/8Pi/WSFbKEE3XxkqGHOsnu1ub0vRfneHmHqkZ4LH+XQXb6RwjMbIDs3GSgm1dnyRu9CXWLrpq71LJMl5tT4vp/J8tpqa4RGhbQ7ro7feAvV+Rg1b0DyoO6+9XkJzgKiaMoloSazLmUd5du+nhzYyOxTZlImvd2+0rOaTfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhkTVQMG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ca01dc7d40so231275485a.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 07:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392570; x=1770997370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eYlMgeBfdVMTpRaGQ8tUVtwdsLeLniXT3Abva0RN7Y=;
        b=NhkTVQMGBryqOfrPlLlZng0BAcfGQiI46hpoAJveY6rFxUbt89rVSCP9Fo1rub3EJy
         cUUkdY1LrXY2CTorjrYNpF+oRRv0jwtHeX6/U4ikcb/p0XmDgmgvaosPuusqAyIcF+Du
         hk3aCiqVky3Xs9LizrBMPZtu+d0kbk7vuMsOjHFgB8WtSkRgYO7CFDMS3hylzOTmHgdK
         GPgDaqdGBuqxxrYVL1h/qzLKGvCr9dPD7XubB226IkGVL39uNAJz5ZTybIOljBe42/w/
         WeGjCFSt2dIlG5GyTjUnschyPDKJQ9rQwJgrkHIGKEkaRsbk6RZPWHDAQ4PcTpwDuRNQ
         pYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392570; x=1770997370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+eYlMgeBfdVMTpRaGQ8tUVtwdsLeLniXT3Abva0RN7Y=;
        b=NHTxxVvw+78v4uV7/Y83tsiFVyDgDDlISpShN+fogAymwyKrfI19jwlwe0Dpu+1s9m
         KleUs7B0Fx0SKYinUFgrCmSgqrq+00+kwHQyxm6eESyzfn2NuwNkX5fA1D3CHeAOHnFg
         03rts90gaUPKe1PeAs5i6YjPicdkVUAAGH4fbWa84VukMyWg8A32fYkd8mA5U2/DDNRq
         QAlIL+HfbYBODfltoyM5/TUjl9wlGk+weT5eKhhers+0FyeJ5EzjEA0zO5fj1BKiYEmb
         cyeDht6+OuWWYN32W0709qa4rizzcivdP4XMhwhn7Y5/4HQwWMg5mo4YIsVGh7ehWK8j
         togA==
X-Gm-Message-State: AOJu0YwPFDUbUYDXfjKeCohDxdX74cxK6Y14w1sk0U1xibpLexAdfN2X
	SpXmz0pgWbFBJ1e6ExpDb/Zx6dtT+rKHB5Pz30XrNn8NszN4yz0NsEBs
X-Gm-Gg: AZuq6aIJ6tJVWJHt0jD7FhCZ7x4jT805BkMlsNMBUsM5xUxhijpQ5IPAnUL6G4j8Q+l
	pVFF0JM3fQxwayErg2rEsQCEPnc8Gkp6iMEmD92VFM/y5lHB5EEP8+fLioMB9SZvjy9mX+eVl1K
	21SPyfox44kDZ1PngEOM9i2BU+PJLVw448E2loMxAw0LY9zwMhpZdK0y/iFDI/C4Q+ySE/FqNjq
	g6gVZDbbFhL+bAanZUKnxxgbQNs/vG6tYZ0mAEBwpG0EBBimgYsv2hamWyvI7digLEkF5uwrmdp
	rtCbYjaEGZxppbOFhUjq0M6NRG8wpQ5uA/058NGlAQAXpkA2w4BQ/d52Z1nZ+KRDgChLXXfJXEh
	qX4sq2f8Ke1loihlt0nlhz2uzHN+whTpeJ0zMhNlu9sNs8kQmYeAmSvzf1nx6nWhDjxkRSzxu4L
	SA6V/GOQoPBbPMsWRJsrRCfUaEEwpJmZJpASe/J1M5/KT0
X-Received: by 2002:a05:620a:bc9:b0:8ca:d5cb:6841 with SMTP id af79cd13be357-8caf1acb650mr389015585a.49.1770392570454;
        Fri, 06 Feb 2026 07:42:50 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9eea0c0sm181499185a.42.2026.02.06.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:42:50 -0800 (PST)
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
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Lee Trager <lee@trager.us>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v12 2/5] eth fbnic: Add register self test
Date: Fri,  6 Feb 2026 10:42:42 -0500
Message-ID: <20260206154246.814-3-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206154246.814-1-mike.marciniszyn@gmail.com>
References: <20260206154246.814-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257595-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CA24FFDC2
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
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c   | 126 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   4 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  50 +++++++
 3 files changed, 180 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
index d9c0dc1c2af9..c1541388d23c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
@@ -147,3 +147,129 @@ int fbnic_csr_regs_len(struct fbnic_dev *fbd)

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
+static int
+fbnic_csr_reg_pattern_test(struct fbnic_dev *fbd, int index,
+			   const struct fbnic_csr_reg_test_data *test_data)
+{
+	static const u32 pattern[] = { ~0, 0x5A5A5A5A, 0xA5A5A5A5, 0};
+	u32 reg = test_data->reg + test_data->reg_offset * index;
+	int i;
+
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
+	return 0;
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
+ * Return: non-zero on failure.
+ **/
+int fbnic_csr_regs_test(struct fbnic_dev *fbd)
+{
+	const struct fbnic_csr_reg_test_data *test_data;
+
+	for (test_data = pattern_test;
+	     test_data < pattern_test + ARRAY_SIZE(pattern_test); test_data++) {
+		u32 i;
+
+		for (i = 0; i < test_data->array_len; i++) {
+			int reg = fbnic_csr_reg_pattern_test(fbd, i, test_data);
+
+			if (reg)
+				return reg;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index b717db879cd3..633a29146617 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -1210,4 +1210,8 @@ enum{
 	FBNIC_CSR_VERSION_V1_0_ASIC = 1,
 };

+struct fbnic_dev;
+
+int fbnic_csr_regs_test(struct fbnic_dev *fbd);
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


