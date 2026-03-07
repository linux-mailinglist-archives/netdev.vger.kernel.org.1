Return-Path: <netdev+bounces-265124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDtaIxMFrGkxjAEAu9opvQ
	(envelope-from <netdev+bounces-265124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:59:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDC622B416
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E99573021B8E
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5941934B661;
	Sat,  7 Mar 2026 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REmYbhE6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB134EEFB
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881140; cv=none; b=his0lfL3OJw/gZNoJtvKgI9AzS16hycsaUGoFNy+x+jCi8/ZvgZnwEsd9LM0/Nal1EIjlERrKRtJ0jzcVlyop7kTcwa0aD6MOAQRlDHc8XJwtQgfBvmYXchRfgwKGyTnVngw/c0bN4M/XX+HoVwAV0OEXk2iLIbisc19cRAwS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881140; c=relaxed/simple;
	bh=l4n/YqP3KyhSn3VlED1Yu/syKa2SVWzzb0PFHGXJ+D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVuPTAdkQXGC93u4KD5MRZm++kRLHgFzHC6eQ0ym1cbDG7uHQBeSwi2jqiD4tI5tdDtt+g21LqEPGDfltju0RiKR5a5CefDuDucynqv6Z8KjGm/of44LaPMWrYRJ+kdbgFpCNcwqF/zReqeK2K3hj0ZaCmDbBzKKE+45/EVZFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REmYbhE6; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd759f502dso81455385a.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 02:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772881135; x=1773485935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nthtvmm8w9C5mAQ8p8js3NflR5wHb3y3LhcZm7H7OQI=;
        b=REmYbhE65xu0Oxt2hFattYZ6xVquye8nWJgfx3tnl0oJiQqoqE14hdiRxx/vuW+wRn
         zIg3FiB849Tx+lDGsU/DamfoYO4H19Rg5hTgUHe9HMyMHC0Ywn7Co9W4yYm9P5Ucj8ju
         clAZ5wFEEQ7YTnoXTX1MLfuTcioYggeSw4x2M7oPycpMwo8mPCvMqG9aLZsdgMCKgVtk
         FSoiUJQmUGaJhrGInQqU5oMBNG3JjG4TmUjAZ+r3B0c/+/ZAgV4tY9tRJTQhuWAQSBRf
         YWBMQZKUxd6Am8E9EXTH4XchYnBdA2KxouGocSwQPF6yycL7j+VzkkGZ+RCwfdyx2rol
         BROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772881135; x=1773485935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nthtvmm8w9C5mAQ8p8js3NflR5wHb3y3LhcZm7H7OQI=;
        b=OvgJHqtoQ1JKdlPwTtsjngc3sSuH0kWtYlB4ouMzNxsEppeV3eUen5tBnxnfXBfGhX
         cfAUbwp1R/CtSoSXsWhtQmPrds0QWf2YPeySNjmBFJ/uO5mi2iPDF1e4wn9x/DT5UG2l
         B10lXJ+O5xAp7XzhydAq8AWff/bpSMWnJLLA4d6iQGYdA3lu1vj5uJZYh/gQzNTX2l9n
         OI4oVu12Bo8q5kp6OdGKFRmzayU+9zT/+/VEvfy6jhssKxTuhxvOZL4+gAuDdOCi62pi
         ZUvPJBAaWBr4ACoc9XE5RmBgM1bJevy4TZ/wWNyF5zT6TljBjYKW6xXLSKgLgzf2e3xS
         XwHw==
X-Forwarded-Encrypted: i=1; AJvYcCXBZGt2Ay2svgyP4hSDx/Ju891r41EB9JCtqqdkusXi0MdWaQiTyZGiK/yhszFaQY9RIPYJ0cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNfQwW8Nikvlsqb1H1v2b9Pzw4Qdt/WYJUGmkPqWGQaiPYV1ys
	x8gr+ww419meudbQLgN7TGf49WY/RZJsMO1yKGb4Wv3Z228tCVWwGK/u
X-Gm-Gg: ATEYQzzQR8AWO3+ZlGz6LNfLtdy7s+9mEeeOhW3pTNO1okzVNeM9nE2DkKGWHwvxiX+
	U0CKCbSy6R82YIzs2vyzFAHqKkSwh77t73wvG/MkCBI9mhK1JqX6SYbWy9ohxB7Wohqy4npSEJs
	l5S/9NIg1yRNUxQhCHDR8iyKn1EKmMgXImT7/opXZxNojLLdYarjci6532yUW8nrqejoAj9uLt3
	Vg+ZpoxImh20sN8i5+C9KDGOyVtBSEpmYSKSw9DNzz/0gS5/+GWpTZFrDz2efUZu03wnG72Rafp
	nTk1W68m1o2zHMmoFEseJHYbcnpJfMPcLzKz7vRdGhudAh1bmasrnKl/etCJGI/Cbi6WYt6RUkl
	gFmYmi0IAbzqLFeODMBrNWf+BvZmVl2zkW4v5TvfCWX8RhTdn4+ClbonHLGGV5RMT4lJQKaEOLI
	zjx/jGE8Ynud9dx1XucJ8VqlyLpYGDbCAIBieVcEun6xFIKr1JiGAwth5e
X-Received: by 2002:a05:620a:454d:b0:8c9:f996:81f2 with SMTP id af79cd13be357-8cd6d3d9388mr655004785a.17.1772881134776;
        Sat, 07 Mar 2026 02:58:54 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f4a2fdasm293278485a.17.2026.03.07.02.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:58:54 -0800 (PST)
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
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 3/5] eth fbnic: Add msix self test
Date: Sat,  7 Mar 2026 05:58:45 -0500
Message-ID: <20260307105847.1438-4-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307105847.1438-1-mike.marciniszyn@gmail.com>
References: <20260307105847.1438-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4CDC622B416
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265124-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This function is meant to test the global interrupt registers and the
PCIe IP MSI-X functionality. It essentially goes through and tests
various combinations of the set, clear, and mask bits in order to
verify the behavior is as we expect it to be from the driver.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2 - add enum for test return codes
v3 - add missing enum
v4 - use kzalloc_obj() vs. kzalloc with sizeof

 drivers/net/ethernet/meta/fbnic/fbnic.h       |  18 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  28 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   | 154 ++++++++++++++++++
 3 files changed, 214 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index a760a27b1516..f7df5302e91a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -197,6 +197,38 @@ void fbnic_synchronize_irq(struct fbnic_dev *fbd, int nr);
 int fbnic_request_irq(struct fbnic_dev *dev, int nr, irq_handler_t handler,
 		      unsigned long flags, const char *name, void *data);
 void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
+
+/**
+ * enum fbnic_msix_self_test_codes - return codes from self test routines
+ *
+ * These are the codes returned from the self test routines and
+ * stored in the test result array indexed by the specific
+ * test name.
+ *
+ * @FBNIC_TEST_MSIX_SUCCESS: no errors
+ * @FBNIC_TEST_MSIX_NOMEM: allocation failure
+ * @FBNIC_TEST_MSIX_IRQ_REQ_FAIL: IRQ request failure
+ * @FBNIC_TEST_MSIX_MASK: masking failed to prevent IRQ
+ * @FBNIC_TEST_MSIX_UNMASK: unmasking failure w/ sw status set
+ * @FBNIC_TEST_MSIX_IRQ_CLEAR: interrupt when clearing mask
+ * @FBNIC_TEST_MSIX_NO_INTERRUPT: no interrupt when not masked
+ * @FBNIC_TEST_MSIX_NO_CLEAR_OR_MASK: status not cleared, or mask not set
+ * @FBNIC_TEST_MSIX_BITS_SET_AFTER_TEST: Bits are set after test
+ */
+enum fbnic_msix_self_test_codes {
+	FBNIC_TEST_MSIX_SUCCESS = 0,
+	FBNIC_TEST_MSIX_NOMEM = 5,
+	FBNIC_TEST_MSIX_IRQ_REQ_FAIL = 10,
+	FBNIC_TEST_MSIX_MASK = 20,
+	FBNIC_TEST_MSIX_UNMASK = 30,
+	FBNIC_TEST_MSIX_IRQ_CLEAR = 40,
+	FBNIC_TEST_MSIX_NO_INTERRUPT = 50,
+	FBNIC_TEST_MSIX_NO_CLEAR_OR_MASK = 60,
+	FBNIC_TEST_MSIX_BITS_SET_AFTER_TEST = 70,
+};
+
+enum fbnic_msix_self_test_codes fbnic_msix_test(struct fbnic_dev *fbd);
+
 void fbnic_free_irqs(struct fbnic_dev *fbd);
 int fbnic_alloc_irqs(struct fbnic_dev *fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index cad963a3d825..b5012601b102 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -128,10 +128,12 @@ static const struct fbnic_stat fbnic_gstrings_xdp_stats[] = {
 
 enum fbnic_self_test_results {
 	TEST_REG = 0,
+	TEST_MSIX,
 };
 
 static const char fbnic_gstrings_self_test[][ETH_GSTRING_LEN] = {
 	[TEST_REG]	= "Register test (offline)",
+	[TEST_MSIX]	= "MSI-X Interrupt test (offline)",
 };
 
 #define FBNIC_TEST_LEN ARRAY_SIZE(fbnic_gstrings_self_test)
@@ -1504,6 +1506,28 @@ static int fbnic_ethtool_regs_test(struct net_device *netdev, u64 *data)
 	return !!*data;
 }
 
+/**
+ * fbnic_ethtool_msix_test - Verify behavior of NIC interrupts
+ * @netdev: netdev device to test
+ * @data: Pointer to results storage
+ *
+ * This function is meant to test the global interrupt registers and the
+ * PCIe IP MSI-X functionality. It essentially goes through and tests
+ * test various combinations of the set, clear, and mask bits in order to
+ * verify the behavior is as we expect it to be from the driver.
+ *
+ * Return: non-zero on failure.
+ **/
+static int fbnic_ethtool_msix_test(struct net_device *netdev, u64 *data)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	*data = fbnic_msix_test(fbd);
+
+	return !!*data;
+}
+
 static void fbnic_self_test(struct net_device *netdev,
 			    struct ethtool_test *eth_test, u64 *data)
 {
@@ -1511,6 +1535,7 @@ static void fbnic_self_test(struct net_device *netdev,
 
 	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE)) {
 		data[TEST_REG] = 0;
+		data[TEST_MSIX] = 0;
 		return;
 	}
 
@@ -1520,6 +1545,9 @@ static void fbnic_self_test(struct net_device *netdev,
 	if (fbnic_ethtool_regs_test(netdev, &data[TEST_REG]))
 		eth_test->flags |= ETH_TEST_FL_FAILED;
 
+	if (fbnic_ethtool_msix_test(netdev, &data[TEST_MSIX]))
+		eth_test->flags |= ETH_TEST_FL_FAILED;
+
 	if (if_running && netif_open(netdev, NULL)) {
 		netdev_err(netdev,
 			   "Failed to re-initialize hardware following test\n");
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 1e6a8fd6f702..5e383d40abc7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -240,6 +240,160 @@ void fbnic_free_irq(struct fbnic_dev *fbd, int nr, void *data)
 	free_irq(irq, data);
 }
 
+struct fbnic_msix_test_data {
+	struct fbnic_dev *fbd;
+	unsigned long test_msix_status[BITS_TO_LONGS(FBNIC_MAX_MSIX_VECS)];
+	int irq_vector[FBNIC_MAX_MSIX_VECS];
+};
+
+static irqreturn_t fbnic_irq_test(int irq, void *data)
+{
+	struct fbnic_msix_test_data *test_data = data;
+	struct fbnic_dev *fbd = test_data->fbd;
+	int i;
+
+	for (i = fbd->num_irqs; i--;) {
+		if (test_data->irq_vector[i] == irq) {
+			set_bit(i, test_data->test_msix_status);
+			break;
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * fbnic_msix_test - Verify behavior of NIC interrupts
+ * @fbd: device to test
+ *
+ * This function is meant to test the global interrupt registers and the
+ * PCIe IP MSI-X functionality. It essentially goes through and tests
+ * various combinations of the set, clear, and mask bits in order to
+ * verify the behavior is as we expect it to be from the driver.
+ *
+ * Return: See enum fbnic_msix_self_test_codes
+ **/
+enum fbnic_msix_self_test_codes fbnic_msix_test(struct fbnic_dev *fbd)
+{
+	enum fbnic_msix_self_test_codes result = FBNIC_TEST_MSIX_SUCCESS;
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+	struct fbnic_msix_test_data *test_data;
+	u32 mask = 0;
+	int i;
+
+	/* Allocate bitmap and IRQ vector table */
+	test_data = kzalloc_obj(*test_data, GFP_KERNEL);
+
+	/* memory allocation failure */
+	if (!test_data)
+		return FBNIC_TEST_MSIX_NOMEM;
+
+	/* Initialize test data */
+	test_data->fbd = fbd;
+
+	for (i = FBNIC_NON_NAPI_VECTORS; i < fbd->num_irqs; i++) {
+		/* Add IRQ to vector table so it can be found */
+		test_data->irq_vector[i] = pci_irq_vector(pdev, i);
+
+		/* Enable the interrupt */
+		if (!fbnic_request_irq(fbd, i, fbnic_irq_test, 0,
+				       fbd->netdev->name, test_data))
+			continue;
+
+		while (i-- > FBNIC_NON_NAPI_VECTORS)
+			fbnic_free_irq(fbd, i, test_data);
+		kfree(test_data);
+
+		/* IRQ request failure */
+		return FBNIC_TEST_MSIX_IRQ_REQ_FAIL;
+	}
+
+	/* Test each bit individually */
+	for (i = FBNIC_NON_NAPI_VECTORS; i < fbd->num_irqs; i++) {
+		mask = 1U << (i % 32);
+
+		/* Start with mask set and interrupt cleared */
+		fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(i / 32), mask);
+		fbnic_wrfl(fbd);
+		fbnic_wr32(fbd, FBNIC_INTR_CLEAR(i / 32), mask);
+		fbnic_wrfl(fbd);
+
+		/* masking failure to prevent interrupt */
+		result = FBNIC_TEST_MSIX_MASK;
+
+		fbnic_wr32(fbd, FBNIC_INTR_SET(i / 32), mask);
+		fbnic_wrfl(fbd);
+		usleep_range(10000, 11000);
+
+		if (test_bit(i, test_data->test_msix_status))
+			break;
+
+		/* unmasking failure w/ sw status set */
+		result = FBNIC_TEST_MSIX_UNMASK;
+
+		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(i / 32), mask);
+		fbnic_wrfl(fbd);
+		usleep_range(10000, 11000);
+
+		if (!test_bit(i, test_data->test_msix_status))
+			break;
+
+		/* interrupt when clearing mask */
+		result = FBNIC_TEST_MSIX_IRQ_CLEAR;
+
+		clear_bit(i, test_data->test_msix_status);
+		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(i / 32), mask);
+		fbnic_wrfl(fbd);
+		usleep_range(10000, 11000);
+
+		if (test_bit(i, test_data->test_msix_status))
+			break;
+
+		/* interrupt not triggering when not masked */
+		result = FBNIC_TEST_MSIX_NO_INTERRUPT;
+
+		fbnic_wr32(fbd, FBNIC_INTR_SET(i / 32), mask);
+		fbnic_wrfl(fbd);
+		usleep_range(10000, 11000);
+
+		if (!test_bit(i, test_data->test_msix_status))
+			break;
+
+		/* status not cleared, or mask not set */
+		result = FBNIC_TEST_MSIX_NO_CLEAR_OR_MASK;
+		if (mask & fbnic_rd32(fbd, FBNIC_INTR_STATUS(i / 32)))
+			break;
+		if (!(mask & fbnic_rd32(fbd, FBNIC_INTR_MASK(i / 32))))
+			break;
+
+		/* Result = 0 - Success */
+		result = FBNIC_TEST_MSIX_SUCCESS;
+
+		clear_bit(i, test_data->test_msix_status);
+	}
+
+	if (i < fbd->num_irqs) {
+		fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(i / 32), mask);
+		fbnic_wrfl(fbd);
+		fbnic_wr32(fbd, FBNIC_INTR_CLEAR(i / 32), mask);
+		fbnic_wrfl(fbd);
+		clear_bit(i, test_data->test_msix_status);
+	}
+
+	for (i = FBNIC_NON_NAPI_VECTORS; i < fbd->num_irqs; i++) {
+		/* Test for bits set after testing */
+		if (test_bit(i, test_data->test_msix_status))
+			result = FBNIC_TEST_MSIX_BITS_SET_AFTER_TEST;
+
+		/* Free IRQ */
+		fbnic_free_irq(fbd, i, test_data);
+	}
+
+	kfree(test_data);
+
+	return result;
+}
+
 void fbnic_napi_name_irqs(struct fbnic_dev *fbd)
 {
 	unsigned int i;
-- 
2.43.0


