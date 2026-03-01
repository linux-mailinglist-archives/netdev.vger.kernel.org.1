Return-Path: <netdev+bounces-262387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDmfKh0epGlkXgUAu9opvQ
	(envelope-from <netdev+bounces-262387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 12:08:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD01CF450
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 12:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2668F302F38A
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A8530214B;
	Sun,  1 Mar 2026 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4dAbl8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96E30DEB5
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772363181; cv=none; b=lgFxibk8TrCVO8knnf/YzbwuDGrAbbKHnjMnBS0qKfGFrwcpSXaqfLCOEv1l75mYmlZy3Ckw4tDqKVPvSYBhuBR30xZrtUYBTQufF3D4c7kLD/bKp1MsWZFGf34nlVMi/xIrHgauEJaWthTwdre8z6jYOaEdNIjq8OErYgLoy78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772363181; c=relaxed/simple;
	bh=Gj06bO0OMwWVmneVnC7DfJp5XBDMxWz1rQJf8bYBpZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX6mXym6USI1rZt2v2XvPf1DxVIefhWjaE2yaIxCErB6PJEJGM//kR7NcuDk4OcfyvFybUeszc1bi3MHCgVY0f2EA77CteJUAneDilKqZAEutO5XiOWcf0ALpcd5no/H852fZ0263x6E3B3e/na53teTGsFTeE7CTgjVkh7WoO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4dAbl8i; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899c97c5afeso25126406d6.1
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 03:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772363178; x=1772967978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3DQslWRXY0aGN4VEznJUuz1rJrCKbc4YikrhGTaWls=;
        b=a4dAbl8iw2ii1Yhz/POxwQNoC8D19Abdv6MZ1d1KBxKInnAxIsqZBzFvkgSarDlLkk
         JdgGyHD7KOvEZDFGuG7UK4Eqo4gf42yiV5JkeB42hVaebCcs/PhxKoiVjj8FvsGHoXI3
         jQnWEvhdzBlCfoZHPH5bOJDoYftlQ72omCKTAWrF9+42A3DEASgYdwgxSFEtxZH07NE0
         BoR9eupP82th9JYQkK8L7svjqWTkKmDzostC1fOwgPHBb2fCRAYzwmyUDcMJu5aMcilP
         6Iurql9TSqPyckjKjE0LTxrxvb+6yK4aidY6CUX7bKzX/gKgtpXM92CaSbiNyqgwi4TK
         1vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772363178; x=1772967978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O3DQslWRXY0aGN4VEznJUuz1rJrCKbc4YikrhGTaWls=;
        b=dgEyIj+nJfq2dz80bCRZml2a09xwegK3KIPgZhx3j/NQ8qLzA1x6Uw9mACJ0JuYpeR
         69GczFAggRoTIHDDwhqI88NyG0A1X16xrUSHtUKFnFzTHNC848qYUGrXGAjU4Embdcwo
         VnarQ+1Ez08C5buxmcjnzrXSigtdRGvnyZmeUF/Z48+5YxtT+7UAsqaq9byssadF/39J
         hZ+YVMo4h582MNEFrAS1BPLFEYSd6WjdhNshNTUQk12CAumXNOVXimU6Hu2rLdHp68E9
         d4qELY2O+SBGLO5Bt29i74V0CTDggqxXLzJ0SU4abGH51buoVwfXjK/ZyRCAcLRwjHjR
         k5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWBKB3jTOOyI0GijxKDH2ciMobiN20Gj++xkZKjKZ8CnGowvWtzyG/jH4WAAgpzX1m+3vDKyJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbChCIxZ/6Mv8mRXLAFU6sGSiFb+cYM+VdzW/fyCqqDTKm8os7
	miWWFXMBZSLzeXjo92nyt5rNFBJQZSU2H8EQCBJeEF3WvnfdvyIJYaN4
X-Gm-Gg: ATEYQzz73BHGTztfvjRrvLdn5FxUie0KU3h6rydxu5wH9NxWdIwK30PF+2lTERl/0B6
	CwzW20uiOAqT7TOuGl6DpwJwHNHM+co/ivE22JY8RnDf1oFR5LS96KzC1PzdUukWCYkfLjo8CeA
	3cvFn/TAvCaj5Z35jwiw1Qwt1itkBu+thCFoNQyVGla0VTR/NxIvD3sjp7+1zUEcG1Mph6pvNV8
	shzxFkVONWBnBN8HHiO8ZZwNyS+7ZD0lts8V9+r7AJtV2LuSCTV7xTRoMzLHpDXH3cKoChdtQct
	bSSf1SlWb7lWJw8fJCDjlCiTxWSwHKe7++X9Z6XlRTsPaU/5CulPz2yIBnrjtmHhDUtjxhE0Dpo
	14AtHCGvwtdVEkAqOV3jeFDtwssjseJszSlGTAMSLlKL9/9i3nCPNMzGpIdiKrGDwQQyZP0CUKt
	VzUV9+mZQ7hqNdWssbW2S6AJxivOT0chkgMiF6vxveV4hRw/NM6N/S1OLPVEj5I7MeRJfDveXGm
	F6SRFmuMZipBWns
X-Received: by 2002:a05:6214:e65:b0:899:f78e:d73a with SMTP id 6a1803df08f44-899f78ede73mr8283726d6.20.1772363178320;
        Sun, 01 Mar 2026 03:06:18 -0800 (PST)
Received: from PF5YBGDS.localdomain (70.15.25.19.res-cmts.sm3.ptd.net. [70.15.25.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716caebsm83888876d6.15.2026.03.01.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 03:06:17 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2.2 3/5] eth fbnic: Add msix self test
Date: Sun,  1 Mar 2026 06:06:04 -0500
Message-ID: <20260301110606.3739-4-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260301110606.3739-1-mike.marciniszyn@gmail.com>
References: <20260301110606.3739-1-mike.marciniszyn@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262387-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BBD01CF450
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This function is meant to test the global interrupt registers and the
PCIe IP MSI-X functionality. It essentially goes through and tests
various combinations of the set, clear, and mask bits in order to
verify the behavior is as we expect it to be from the driver.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2 - add enum for test return codes

 drivers/net/ethernet/meta/fbnic/fbnic.h       |  18 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  28 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   | 154 ++++++++++++++++++
 3 files changed, 212 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 779a083b9215..092fa9ad93d0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -194,6 +194,36 @@ void fbnic_synchronize_irq(struct fbnic_dev *fbd, int nr);
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
+};
+
+enum fbnic_msix_self_test_codes fbnic_msix_test(struct fbnic_dev *fbd);
+
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
index 02e8b0b257fe..2099ee89fb51 100644
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
+	test_data = kzalloc(sizeof(*test_data), GFP_KERNEL);
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


