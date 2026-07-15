Return-Path: <netdev+bounces-307687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kZsZJZE6V2r6HgEAu9opvQ
	(envelope-from <netdev+bounces-307687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:45:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 040A375B8F4
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:45:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=e9uH9aUF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307687-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307687-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B6AD302013D
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61B3C3C01;
	Wed, 15 Jul 2026 07:43:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1F3C3C11
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 07:43:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101432; cv=none; b=cutLYJqGdhKaUdUJEQqz+uGinCYOvUMVBa+ZKKg8PNAXNrWvad8fpgNxW0IuvCRTVubl3/XHmujH0SYSPtG6ULrCtH7xXG0DTBU3+P8PZVdlfuYUH6tJ/5bSJ6he64bRuGkzFWgvRAnexvq1t+XTduy7d4psAFPjRkseCGK5LAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101432; c=relaxed/simple;
	bh=y5Yr1gIyrfac17lZFE3ssHywNIUUJZb9Lgt4F4GeTqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bpG3ZboGEtQbMxNz45WmwTz9tPrFQdwNRynmKgI05ZWQCmlI5mEfUTpWlK40PMIDMqUDQhN4VZPqAfEPuCUIQ0uxSUGHWf2Qnt3vV+Ihk+vD0A4mDDD/A6W5dorfet9g38yEIyAqKCYHd3BwJSwI3iHV2C+6/LqFwXKcbtvNrmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9uH9aUF; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3811f512167so5828969a91.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784101430; x=1784706230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AYAlIbLB6X0GecHObbyrvXXBG7k1g/UCDRjvsUf6hcY=;
        b=e9uH9aUFRHosho0qNLXhLk8+qo/6EOEEGrPlCeR9GhxpQvOf8K4UPzjZgnfxsdih+U
         rzhHrl15gGa/JHfnL7/U7rqiNzdoAkjgElrcsOaDgJVd475qf8DaSFRAbdDAz2cKzLn7
         fNMfhNddR8RHu1tczWR43+3SXR02CUpIaijUUg0T6+Ve1K+LfIHXQ4nqhhJkZe/hn5M/
         CGXWrYoQbkaSXTfdlrivXnBrkzxT1OsrA8AXcJxs+oFy5ITlE5+j3CPu9Q/cYlFsRm9l
         udBu4YJEhslnH4GwJucnf5xEDXMGjgAPpgogg4kxwP3Jn0uRCclLRXuvKekv69nnNlIh
         LPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784101430; x=1784706230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AYAlIbLB6X0GecHObbyrvXXBG7k1g/UCDRjvsUf6hcY=;
        b=DInhzCNCLYpEEoBAGKlBHOp7/EH1vBoYmxlJdqFewXGRVtU8rTMBsmPN/BEax07hmR
         9OOm3qGLxHdLOiM34fsRGNR+T+P9J7S1NeiyKLujNNJnYFsCrsZ4R1zwpsW+dMwivAgr
         tE9IW9eFNw5YdHCuUD5JSs3YptHYVYPqLPeSESbui8ewajD/6kTudY5pthHTwiJBBZmi
         CzVRiPOQnuRnbIB7cY5eKTg8ZOd0vloKKqzyIMXNS57FLEorNMInZrI5yWhQBP8odR/6
         skQylNSfA4tyLeDax6DQSHLXNMlaKCr91sDAr8gCs7Gz/x8X0SNc7fOFm9eqNIHXLAaq
         rtyA==
X-Forwarded-Encrypted: i=1; AHgh+RqWY3D9VALGTXEFz4PAy67IjcyusJjdMGTjZtW+H06oH0dBq4JQUMJw4XbyuQFpcrQb3tJ5ync=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJRyofQ1MVHS/X6B5gOTpoEmU7ESI5BRESlg8jdbTmqGzAjq/U
	nHjJU97h7bZ1HjeHdT3mMqk1F214Wfnnu89YQDeg/O8yWlWgRhAD06w=
X-Gm-Gg: AfdE7ck0AfJM7imQjrsJscXcpOGluseOku6BUqkVugti1IG1EPR5GDco+qqQvQj3dAh
	h5kaEbt63GHzsMzAkTzsz2bqc3/tx03cNyXnYORwavafv1L19/ylWtKKJ0Eg0Z2A/vE1d14mEiy
	lx3c/b2vx6eBxQYJXzSz6OwCyszZSBUyfkHUN96ugWYyWrZGOR27BTTuMLDs2dmJpK5f/DORCr5
	gtCLDlh+xUFJpg98llSjTL2AO/dNPxSQo5jumBY+urxgZQxQPpCqZFxAZkITzjnuNaJtjshJp5l
	M52NZbglqULVXFzmw2KEmMNoud3vLDkIolEZfy4pmgPtJ6bQb03q9MvrTzJ1z3mw5U4Iv7CLkqW
	wsKWezKjHgzyGBLsLztrqZBmvnuvmGunEXt71VIEi6rCXkEtDDs6g6EwVwJ2fEtwz09iG6rNs8/
	fFU3nGVs2cF1WjtQKkIXTui5O9Ge8ndbaDTVwY/SxwJFrog5umGsZkBNUHbqDJAj1G+f5W0N2Zs
	COWkuSTmO3WiRDlz5IOxH7omg3t6JbnuM1y8dqj6NThzO3YIsP9POjVyRWM
X-Received: by 2002:a17:90b:1d52:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-38e1ae5f663mr5684089a91.4.1784101430164;
        Wed, 15 Jul 2026 00:43:50 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172fd17asm2707964a91.12.2026.07.15.00.43.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 00:43:49 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Milena Olech <milena.olech@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] idpf: disable PCIe PTM on probe failure and removal
Date: Wed, 15 Jul 2026 16:43:42 +0900
Message-Id: <20260715074342.49281-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307687-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:milena.olech@intel.com,m:emil.s.tantilov@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhun512@gmail.com,m:ae878000@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 040A375B8F4

idpf_probe() enables PCIe Precision Time Measurement with
pci_enable_ptm(pdev, NULL), which programs the PTM control bits and sets
pdev->ptm_enabled when the bus/controller supports it.

If a later probe step fails, the error path releases the allocated
workqueues and adapter memory without disabling PTM.  The remove path has
the same imbalance when a successfully probed device is detached.  In
both cases, the PCI core's software PTM state and the device's PTM control
bits remain set with no bound driver.

Add pci_disable_ptm() to the common probe unwind after the PTM enable and
to idpf_remove().  pci_disable_ptm() is a no-op when PTM was not enabled,
so the non-fatal pci_enable_ptm() failure remains safe.
pcim_enable_device() only arranges for pci_disable_device() and does not
undo the PTM enable.

Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Disable PTM in the probe error path, as requested by Emil Tantilov.

 drivers/net/ethernet/intel/idpf/idpf_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 0dd741dcfc..f08ce13c20 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -159,6 +159,7 @@ static void idpf_remove(struct pci_dev *pdev)
 	mutex_destroy(&adapter->queue_lock);
 	mutex_destroy(&adapter->vc_buf_lock);
 
+	pci_disable_ptm(pdev);
 	pci_set_drvdata(pdev, NULL);
 	kfree(adapter);
 }
@@ -266,7 +267,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		pci_err(pdev, "DMA configuration failed: %pe\n", ERR_PTR(err));
 
-		goto err_free;
+		goto err_disable_ptm;
 	}
 
 	pci_set_master(pdev);
@@ -279,7 +280,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!adapter->init_wq) {
 		dev_err(dev, "Failed to allocate init workqueue\n");
 		err = -ENOMEM;
-		goto err_free;
+		goto err_disable_ptm;
 	}
 
 	adapter->serv_wq = alloc_workqueue("%s-%s-service",
@@ -366,6 +367,8 @@ err_mbx_wq_alloc:
 	destroy_workqueue(adapter->serv_wq);
 err_serv_wq_alloc:
 	destroy_workqueue(adapter->init_wq);
+err_disable_ptm:
+	pci_disable_ptm(pdev);
 err_free:
 	kfree(adapter);
 	return err;
-- 
2.47.1

