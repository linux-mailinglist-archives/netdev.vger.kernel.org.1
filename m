Return-Path: <netdev+bounces-302931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ix4oOWU3Q2oUVQoAu9opvQ
	(envelope-from <netdev+bounces-302931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:26:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A3D6E00D5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:26:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=hBGaOmjb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302931-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302931-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 070333001CF2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB543749FF;
	Tue, 30 Jun 2026 03:26:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90B1FC8
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:26:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789983; cv=none; b=Sx+eBWIj5uyjCUUePEZlvbrstAIAUsZe1kzzjFNM7exlZUiJ4gBwiUIVmuZCedAqntqplRDX0T7xuQ6tPoooyGmoYgugaF+lnluVVeAXILxRwOknvVKtIb+YxU0btRoaRxJXxwv377z+/qbgZVB/AiVLBf5/a8lowmvhG7Jf6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789983; c=relaxed/simple;
	bh=hm6o1/v6vLr/T+6ikCfkLuR5N/woSO7/x6eA+2IVqs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mMfWF+CXMwWisKIqVAs0lWwZ8RU8FA+1/EzhscQTaF4TYsrSYJBnyYpqpqMqUgm08xjPM1uvCv/qRTFfpELZai1uyJsLGGjoZam+02uWlWLQlmbbhhVjQp5QfRNFU6y9gkhm/2S7qtFI1MN31f5XKr+AINDtFC+gRLV5cETuxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hBGaOmjb; arc=none smtp.client-ip=117.135.210.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/S
	wNmCMjTxoLdqZnFpSJjNUEAyiVEzWIN9TdiRidF4U=; b=hBGaOmjbj7N6Dr/ioC
	r+1TQ0YrYoKS3e2LsbPSMhMxIQwtv3w5AsEnnreGabPHTuc2GuSRyrJiUum6ELLW
	24yjn3y7d5kFUpj1j1jZhiTjlr6IvgLHCSP6KBU6HdLbSZdtjC4Otkr4olLyEHxa
	fsbVZmKV2tgea0o+ES6ncQZrg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHShoyN0Nq1ZWKFw--.30162S2;
	Tue, 30 Jun 2026 11:25:42 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net-next v1] ice: use dev_err_probe in all appropriate places in ice_probe()
Date: Tue, 30 Jun 2026 11:25:37 +0800
Message-Id: <20260630032537.42605-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHShoyN0Nq1ZWKFw--.30162S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1rGrW3uFyfZrWUZrWUArb_yoW8Kr1DpF
	WDAFy5Cr1kGr45W395WF4qyr9xK3ykta45KFWDA3Z2vrn8Ar4ktr9FyF4S9ryrJFZ3Kay3
	XF1jvFWUCF4xXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hZGsWpDNzYhwAAA3K
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[clementwei90@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:weirongguang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302931-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clementwei90@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8A3D6E00D5

From: Rongguang Wei <weirongguang@kylinos.cn>

Use dev_err_probe() can conveniently combines printing
an error message with returning the errno and also
simplify the code.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 ++++++++---------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e2fbe111f849..81959eaec708 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5167,10 +5167,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	struct ice_hw *hw;
 	int err;
 
-	if (pdev->is_virtfn) {
-		dev_err(dev, "can't probe a virtual function\n");
-		return -EINVAL;
-	}
+	if (pdev->is_virtfn)
+		return dev_err_probe(dev, -EINVAL, "can't probe a virtual function\n");
 
 	/* when under a kdump kernel initiate a reset before enabling the
 	 * device in order to clear out any pending DMA transactions. These
@@ -5194,10 +5192,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return err;
 
 	err = pcim_iomap_regions(pdev, BIT(ICE_BAR0), dev_driver_string(dev));
-	if (err) {
-		dev_err(dev, "BAR0 I/O map error %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "BAR0 I/O map error %d\n", err);
 
 	pf = ice_allocate_pf(dev);
 	if (!pf)
@@ -5208,10 +5204,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 
 	/* set up for high or low DMA */
 	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
-	if (err) {
-		dev_err(dev, "DMA configuration failed: 0x%x\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "DMA configuration failed: 0x%x\n", err);
 
 	pci_set_master(pdev);
 	pf->pdev = pdev;
@@ -5246,10 +5240,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return ice_probe_recovery_mode(pf);
 
 	err = ice_init_hw(hw);
-	if (err) {
-		dev_err(dev, "ice_init_hw failed: %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "ice_init_hw failed: %d\n", err);
 
 	ice_init_dev_hw(pf);
 
-- 
2.25.1


