Return-Path: <netdev+bounces-257596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IwtGyQMhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:43:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A1BFFDA5
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34AC730151CF
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3322D2DB7B4;
	Fri,  6 Feb 2026 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2Lvmerm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12F2C0F95
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392573; cv=none; b=nxGGgyGyIf7NXW2MVJfgySB6SLtEq92XxXcelI2+oJ5ueSrf6PoXdMWNObKwqaWX95NJErwxaieZ7EdEGSDaXvtXo/MBrAvXMXWejaSI6l1kKaaIFUHRkEdvKpp67WTMWGhxE7OWW318dWgjQR/y6VXmpS6L8RNwuBhVSo9KaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392573; c=relaxed/simple;
	bh=ZZPuiaJN8FG3TNv8aa90NTIEfkFlAIEJgSyPdO5+2gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbbSOKfpbltYeSvr3RudbaVKWfQsk+mOjB2MDHz3UljkM4Jvc0vcpGw5+SVuphc937cnF+DguWnL587l/5TgKvljS/kBADFPtZUr0PMRxao5jr4MV3j3oafXdOms1AOwb4WH++3oSii8J1y7rsyKF7OYd03/GzwI088rpCcs2xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2Lvmerm; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c52f15c5b3so211577485a.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 07:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392572; x=1770997372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwGlkP6aevqDFVvTI7GTZ8sDS3yQCcy2dagic+cTK0I=;
        b=E2LvmermzvzIDZeSFNhoiCFIqa628lqXugywudIcOGeYEAUT7yKR8OWvzyWXRilDWO
         qZzgz0GZ61aoQ0P9F6TA6JLpqSJmPEl8do706f8ZGTidFMxoVg2coTH75edrr+NCyvgR
         L1M8UsgGtBg7HGHnmJCC0bsH5UjWIiUEgaG2Q3TbFrT9+E37Hajwu+DWZM6ecGdzOp5J
         ZoP1GfdYve49xOd0zKHfTqDyB0EGjfLYOj0uGz9aABhkwzy5VhPydRTdJTwsmx6SgD0J
         d89UrGPJLjIN7/ZdakHLFDiBOmRg7aOwLsUSM63UtBX7T12SqSuiXVltzyX3HQQ1vGUt
         dZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392572; x=1770997372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xwGlkP6aevqDFVvTI7GTZ8sDS3yQCcy2dagic+cTK0I=;
        b=f3v3PlAciJihGpc1po40PIds3t6zecM7wCIs4+MVNEeTmIPmrQ124LxTkY0/FZJc6i
         JbdoexjifQp61ZUtv0JJ8Sa56WCJ6nnrhPFOw2VxuCqD5Irlfl+YBnQXLvZKHDOvmjT7
         jLVIM73wRx45EgFLLMOZTtMkD8U8D1QCLU5TYUe3pCWyF4lu5gUFDlTTnVsxS3ZAnfq7
         hC2PhLWBHKfPJ2tGpWtIr8SNbdpREpwcmgJtuh1V7vLj+nFyyOKNCmvJdrV5lhGXHiuo
         Vv/6TMrPPpwo3RzYP75hMxQ/w3j3io2I3IMORXrRfwvTEzJeQpkzzuJW8wL3RNrcgIo6
         WqaA==
X-Gm-Message-State: AOJu0YxYjIJIZNKdkYHN1KCSj2AtHpTbP0vEp24b6PDCOj4vTuha2wo2
	4ZpeErMKiKO0/UqgW22W8XRMZ7ou92q8gmOZ/pZwECtLFMHudA4qhxpO
X-Gm-Gg: AZuq6aI4CYfHMXLC1mqR/5G5faoJTw8J6OD33s40kk87EDldT9Xcl9pf9VOc6jJljXE
	OJh96Oa0qbO4bL1rRQHSJuwiVJOikyRH/rpeeHQOkZr4q5Gxc65wXRIFzn5s6L10rHOSmSkRk93
	2LXvmySVrNiJxMGiSKlLwagTs/vlsGnhDpt5GFPo+wCj1D3Vkl8VXxQ7ngXOGFRJz0LuzMLTKrK
	RQmz+uHB8RjDvRZ+ZO6H40cVJB9eCmxRKgSkY64r+NxV8XUd6UTWE8BiKr/zWrK9OqEpccDVjer
	sh4uYL/J08Qc3wSGgjjxNI08nXdUuzMpHvFyFO5jxPkp0HBpUHStaXCiCHowuhbDX1P2t5GBSvg
	csVWoIOQkEee2zs6B+jjqazHqsg/T7VNVjmlHXKxR+LpDWNsL0e1RJRTbOi/gTXBomsYT8FP4Z1
	uHXUn1Lwo3hho4noW9FzAgu8Pb83TkcY6xqufSikECLObm
X-Received: by 2002:a05:620a:1a20:b0:8c6:a341:ac1a with SMTP id af79cd13be357-8caefeb4d98mr414420585a.52.1770392571736;
        Fri, 06 Feb 2026 07:42:51 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9eea0c0sm181499185a.42.2026.02.06.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:42:51 -0800 (PST)
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
Subject: [PATCH net-next v12 3/5] eth fbnic: Add msix self test
Date: Fri,  6 Feb 2026 10:42:43 -0500
Message-ID: <20260206154246.814-4-mike.marciniszyn@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257596-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 00A1BFFDA5
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This function is meant to test the global interrupt registers and the
PCIe IP MSI-X functionality. It essentially goes through and tests
test various combinations of the set, clear, and mask bits in order to
verify the behavior is as we expect it to be from the driver.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  27 +++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   | 154 ++++++++++++++++++
 3 files changed, 183 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 779a083b9215..26597a2cc3c4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -194,6 +194,7 @@ void fbnic_synchronize_irq(struct fbnic_dev *fbd, int nr);
 int fbnic_request_irq(struct fbnic_dev *dev, int nr, irq_handler_t handler,
 		      unsigned long flags, const char *name, void *data);
 void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
+int fbnic_msix_test(struct fbnic_dev *fbd);
 void fbnic_free_irqs(struct fbnic_dev *fbd);
 int fbnic_alloc_irqs(struct fbnic_dev *fbd);

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 2e882dbd408d..b0c8d1b069e2 100644
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
@@ -1501,6 +1503,28 @@ static int fbnic_ethtool_regs_test(struct net_device *netdev, u64 *data)
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
@@ -1508,6 +1532,7 @@ static void fbnic_self_test(struct net_device *netdev,

 	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE)) {
 		data[TEST_REG] = 0;
+		data[TEST_MSIX] = 0;
 		return;
 	}

@@ -1517,6 +1542,9 @@ static void fbnic_self_test(struct net_device *netdev,
 	if (fbnic_ethtool_regs_test(netdev, &data[TEST_REG]))
 		eth_test->flags |= ETH_TEST_FL_FAILED;

+	if (fbnic_ethtool_msix_test(netdev, &data[TEST_MSIX]))
+		eth_test->flags |= ETH_TEST_FL_FAILED;
+
 	if (if_running && netif_open(netdev, NULL)) {
 		netdev_err(netdev,
 			   "Failed to re-initialize hardware following test\n");
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 02e8b0b257fe..925be05b329f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -238,6 +238,160 @@ void fbnic_free_irq(struct fbnic_dev *fbd, int nr, void *data)
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
+ * test various combinations of the set, clear, and mask bits in order to
+ * verify the behavior is as we expect it to be from the driver.
+ *
+ * Return: non-zero on failure.
+ **/
+int fbnic_msix_test(struct fbnic_dev *fbd)
+{
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+	struct fbnic_msix_test_data *test_data;
+	int result = 0;
+	u32 mask = 0;
+	int i;
+
+	/* Allocate bitmap and IRQ vector table */
+	test_data = kzalloc(sizeof(*test_data), GFP_KERNEL);
+
+	/* Result = 5 for memory allocation failure */
+	if (!test_data)
+		return 5;
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
+		while (i--)
+			fbnic_free_irq(fbd, i, test_data);
+		kfree(test_data);
+
+		/* Result = 10 for IRQ request failure */
+		return 10;
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
+		/* Result = 20 for masking failure to prevent interrupt */
+		result = 20;
+
+		fbnic_wr32(fbd, FBNIC_INTR_SET(i / 32), mask);
+		fbnic_wrfl(fbd);
+		usleep_range(10000, 11000);
+
+		if (test_bit(i, test_data->test_msix_status))
+			break;
+
+		/* Result = 30 for unmasking failure w/ sw status set */
+		result = 30;
+
+		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(i / 32), mask);
+		fbnic_wrfl(fbd);
+		usleep_range(10000, 11000);
+
+		if (!test_bit(i, test_data->test_msix_status))
+			break;
+
+		/* Result = 40 for interrupt when clearing mask */
+		result = 40;
+
+		clear_bit(i, test_data->test_msix_status);
+		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(i / 32), mask);
+		fbnic_wrfl(fbd);
+		usleep_range(10000, 11000);
+
+		if (test_bit(i, test_data->test_msix_status))
+			break;
+
+		/* Result = 50 for interrupt not triggering when not masked */
+		result = 50;
+
+		fbnic_wr32(fbd, FBNIC_INTR_SET(i / 32), mask);
+		fbnic_wrfl(fbd);
+		usleep_range(10000, 11000);
+
+		if (!test_bit(i, test_data->test_msix_status))
+			break;
+
+		/* Result = 60 for status not cleared, or mask not set */
+		result = 60;
+		if (mask & fbnic_rd32(fbd, FBNIC_INTR_STATUS(i / 32)))
+			break;
+		if (!(mask & fbnic_rd32(fbd, FBNIC_INTR_MASK(i / 32))))
+			break;
+
+		/* Result = 0 - Success */
+		result = 0;
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
+			result = 70;
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


