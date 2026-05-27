Return-Path: <netdev+bounces-292257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GaLLybcFmofuAcAu9opvQ
	(envelope-from <netdev+bounces-292257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:57:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE8B5E3BF4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C714303F7F0
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD65400E1A;
	Wed, 27 May 2026 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HaektoMj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83253F6612
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882946; cv=none; b=Ib6Z69WiBHkPnLQxTm8+mdzdOkkI1jyQtyf4vs3nClBNGLMo/GrrJKHeYQsiQqDbgbziyYMOgd5cbvIWrkeDsIGBL2BZHLEOQ3R1eVnwpuK59pmip8NYsDPtlLkikGgVy1ETgzkHjAqYOfZlTQmpag/rEEEFTJhbCXkUgdczaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882946; c=relaxed/simple;
	bh=GAApqeCRjQK3CN59WuzG4AK8wYM3U3jG5QMMu3Zh/j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5oNikbTm/Cu031HO/tnmbW6+9oqkh8kJAkCb7wHND49YN/0Xliwy6XWbItKVRPk9UGZroO0wde+vABFqqpfk0tZYoj9iweL2cllHLMjfayee3DUTSyUnNrOrLTD7YfZ9jsuaqblEe4s2pf0BANT5/Y97VyP5JI7E2bo8gdKws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=HaektoMj; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-132830d8281so4334823c88.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 04:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779882943; x=1780487743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rrJTIz+SLJ7Rrnm7gwuGykMXj+faWEwAmsB52W+eYH8=;
        b=HaektoMjnt48XvtkRiauq1TZKy/KRWQD/T08okNCW9mImPS7uDTkVrWikUjt570j2z
         7UZH7tyYFAEzZWoGCc5Tjet7RjgqrRDQvMD4XkjiIochE/zJT+igrkv+vG/Stochnym5
         PLbX5DlVMuzXiFb35oQEnS1xMKPgnLyeNWWSjnGPmNqVOyxmf5yMm8a2igLlvGgyt/ey
         Ep14YI3IJW6tKkeH46mFg1FHGVtt4B/1EV3VOOEBCoAhUCLP0WOBYkyGhkJBniLC6DpG
         TJ5NmYlLWYFJnpDIE/2EJ4rx1v4J2npKDX3ty15Cn/SHt3NTAVMLC4lifOaGULFaUSQR
         64bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779882943; x=1780487743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrJTIz+SLJ7Rrnm7gwuGykMXj+faWEwAmsB52W+eYH8=;
        b=RtpQ0pgrK4XVxP1LklJ8Fm+xNBpiZAueENyRYCqpqulEV8Jgru3/cCfy7yrwjlz8aR
         k3fVX47Xm6HPmd1oZfFYHPqnIqEvM4PYpFze+0/Uv/6WqZQRfvoMl5+7K4W6uAHzJnAN
         WW0LnmChghEDru5wWSAMNCs2RcD8ua7iOhn75it5TdeT36T9Fw4PNkE03QMjzYKr9yeK
         s5iWrOjDUOU11ZcorAFDDO5/epxBNUTtzCfR4N8GazQ8TbibQBr9pUU0510EpoiCz3eY
         qhsp1uXa9FqUiqnfbmpvnBw/qHgpIKBVRe7uOasBQuPVpxztzL1afoZLhh2HY0YeL4+t
         soQg==
X-Forwarded-Encrypted: i=1; AFNElJ9d+hXAyOK4ZIPapIPxFwi0lt+nxxN8wgIZZ9/nDvQrkE4HZ6CIn0xy1E8GrgctlHvjufhhozk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTlnm1o9LO8gXkrxv3RctINGTA6F/8qGeYcsKUNz3e8YX+9j+5
	KOaxR65UtdN5I99loVnt6UCdySKut9FZiNF6L7KJ675dy+JFqGk22eFABE8lD7lgJw==
X-Gm-Gg: Acq92OGviwx/6X35Z8t+lBBcOkjYDtt27iRay0lpt70oE6RId9U2xoVDWtxe0EdmH5n
	sYmFWB+KTC+IVdjP/uXoXP2RiH3NmhyyKhhhFR6VUFkTCG08L0pKn/31TRL2Pg6mB05lHu9yuLa
	ZlCnBi1veBkAnhtyV0fJCJvulDhcQDigy+xRB+8LK29cBSrdO6rH2QJ0imehvdbmtVXkUZdXFaD
	zl4z0CoA+ZwQbFTyTNvlX7FBVTCGLEHru9NpASfhm7VhonMoPEsAcAs5fNI1HSjXxe7rk+MlaR6
	0ip617JKWAyCDQfu1FzpXwvMLriwtRyk+cMdpLUIOBBHgVCPlxEao0QS/k3+LQSjhhPVwskTE70
	PYqLkrNM97JE1rg1P+T2LyfvEFM43G5ATHV6IMPr0+9JAMfxslN/lR3l7c4+tph6hCLEoPCydKf
	R01OrhcrQzS1NwQYabXp9lxaJa7MRadts0e/gi+olqtjFlmpBMZjPg0iHnJdXB7X8t0KDPvrdoe
	LWE
X-Received: by 2002:a05:7022:ebc5:b0:12d:ce34:3f92 with SMTP id a92af1059eb24-1365fb622e6mr9412986c88.31.1779882942567;
        Wed, 27 May 2026 04:55:42 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a2e672asm12917022c88.3.2026.05.27.04.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:55:41 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: pavan.chebbi@broadcom.com,
	mchan@broadcom.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Murashka <yurypm@arista.com>
Subject: [PATCH net v4] net: tg3: guard napi_disable and pci_disable_device calls
Date: Wed, 27 May 2026 11:55:35 +0000
Message-ID: <20260527115535.1686932-1-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[yurypm@arista.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292257-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[arista.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5EE8B5E3BF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During PCIe hot-plug events, uncorrectable errors can be reported and
AER recovery for the tg3 device is initiated by the AER kernel driver.
The tg3_io_error_detected function is the AER error recovery handler.

From tg3_io_error_detected, we call tg3_netif_stop->tg3_napi_disable->
napi_disable and return PCI_ERS_RESULT_NEED_RESET on non-fatal error.
We expect that during AER recovery tg3_io_slot_reset and tg3_io_resume
will be called. But AER error recovery can fail. For example, when one
of PCIe devices on the same bus reports PCI_ERS_RESULT_NO_AER_DRIVER.
As a result, tg3_io_slot_reset and tg3_io_resume are not called, PCIe
device is disabled and NAPI is disabled (pci_disable_device and
napi_disable are called from tg3_io_error_detected). Then we can try to
disable PCIe link and napi_disable will be called again:

  napi_disable+0x1b/0x1b0
  tg3_napi_disable+0x89/0xa0 [tg3]
  tg3_netif_stop+0x37/0xe3 [tg3]
  tg3_stop+0x30/0x160 [tg3]
  tg3_close+0x2a/0x60 [tg3]
  __dev_close_many+0xad/0x130
  dev_close_many+0xb2/0x190
  unregister_netdevice_many_notify+0x19d/0xa00
  unregister_netdevice_queue+0xf8/0x140
  unregister_netdev+0x1c/0x30
  tg3_remove_one+0xaa/0x150 [tg3]
  pci_device_remove+0x42/0xb0
  device_release_driver_internal+0x19c/0x200
  pci_stop_bus_device+0x85/0xb0
  pci_stop_bus_device+0x2c/0xb0
  pci_stop_bus_device+0x2c/0xb0
  pci_stop_and_remove_bus_device+0x12/0x20
  pciehp_unconfigure_device+0x9f/0x160
  pciehp_disable_slot+0x67/0x100
  pciehp_handle_presence_or_link_change+0x77/0x350

This is not expected by napi_disable and a thread can be locked in
napi_disable forever. We have pcierr_recovery to cover a similar issue,
but for fatal errors. We cannot reuse this flag because it is reset in
tg3_io_resume, but it is not called when AER recovery fails.

Similarly, if an AER error is reported and tg3_io_error_detected calls
pci_disable_device, a subsequent device removal via tg3_remove_one or
tg3_shutdown will call pci_disable_device again for the already-disabled
device.

Add a napi_enabled flag to struct tg3 to track whether napi_enable has
been called. Guard tg3_napi_disable() so it returns early if NAPI was
not previously enabled. Also guard pci_disable_device() calls in
tg3_remove_one() and tg3_shutdown() with pci_is_enabled() to avoid
disabling an already-disabled device.

Fixes: b45aa2f6192e ("tg3: Add EEH support")
Signed-off-by: Yury Murashka <yurypm@arista.com>
---
v4:
 - Rebased on the latest net tree and fixed indentation
v3:
 - Removed netdev_err() log from tg3_napi_disable() guard; silently
   return instead
v2:
 - Rewrote commit message with full problem description and call trace
 - Added Fixes tag
 - Added "net" tree prefix to subject

 drivers/net/ethernet/broadcom/tg3.c | 14 ++++++++++++--
 drivers/net/ethernet/broadcom/tg3.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b..86995e689 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7398,6 +7398,11 @@ static void tg3_napi_disable(struct tg3 *tp)
 	struct tg3_napi *tnapi;
 	int i;
 
+	if (!tp->napi_enabled)
+		return;
+
+	tp->napi_enabled = false;
+
 	for (i = tp->irq_cnt - 1; i >= 0; i--) {
 		tnapi = &tp->napi[i];
 		if (tnapi->tx_buffers) {
@@ -7420,6 +7425,8 @@ static void tg3_napi_enable(struct tg3 *tp)
 	struct tg3_napi *tnapi;
 	int i;
 
+	tp->napi_enabled = true;
+
 	for (i = 0; i < tp->irq_cnt; i++) {
 		tnapi = &tp->napi[i];
 		napi_enable_locked(&tnapi->napi);
@@ -17718,6 +17725,7 @@ static int tg3_init_one(struct pci_dev *pdev,
 	tp->tx_mode = TG3_DEF_TX_MODE;
 	tp->irq_sync = 1;
 	tp->pcierr_recovery = false;
+	tp->napi_enabled = false;
 
 	if (tg3_debug > 0)
 		tp->msg_enable = tg3_debug;
@@ -18099,7 +18107,8 @@ static void tg3_remove_one(struct pci_dev *pdev)
 		}
 		free_netdev(dev);
 		pci_release_regions(pdev);
-		pci_disable_device(pdev);
+		if (pci_is_enabled(pdev))
+			pci_disable_device(pdev);
 	}
 }
 
@@ -18257,7 +18266,8 @@ static void tg3_shutdown(struct pci_dev *pdev)
 
 	rtnl_unlock();
 
-	pci_disable_device(pdev);
+	if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
 }
 
 /**
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index a9e7f88fa..34fb771e8 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3429,6 +3429,7 @@ struct tg3 {
 	struct device			*hwmon_dev;
 	bool				link_up;
 	bool				pcierr_recovery;
+	bool				napi_enabled;
 
 	u32                             ape_hb;
 	unsigned long                   ape_hb_interval;
-- 
2.51.0


