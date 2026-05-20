Return-Path: <netdev+bounces-290012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJhADEYODmo35wUAu9opvQ
	(envelope-from <netdev+bounces-290012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:40:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C235598976
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71AFB3708B85
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F9B3546D9;
	Wed, 20 May 2026 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TsdWpPVI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D03DE451
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294934; cv=none; b=YtzF6GUea3P5WxC7P5emidRVykEymkkTCdme2XURFpD4iFxJjve81eOldSls3maRcX0nTwa2qTDIfI6qyUsfR/f6DhIO75ARNaVNMe4EMlYQ4srZDdIx0jgYzGDHvghzPQtd4YmTY/IhZJF34VHaVcXTexx9S+M1RMgCb/lykEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294934; c=relaxed/simple;
	bh=8jEkkJubtXEaeLZQ+pYsHFV4qq1QXHCrTGtNi8vqZmA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=BDm4EPNVDk2+4o3jf45kshF/8WKIFMwIo4yt6X8BUPkwG/3ZLUzbX6M+Y3g9CtU0ztMuK/Vr4aIHGT3iQ+i4DkkbSbVdEA9kk9Ay7aU0XGa5Hr1Cj20ehNGcZq1yi9NXGqVmrGK3Ycu7Mafo8e4+8RbffGW0O5TjVhw+iECHNK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=TsdWpPVI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45e7c636e74so2649773f8f.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779294930; x=1779899730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5m4belQIBg7Mn7sCkneyV4rbMVW1Gi36YS0PWnsWsEQ=;
        b=TsdWpPVI859z2Ndq64Y66oZWBs/yYAR794a4lj9tpEM8wFHMYNTXB3+OWNrHb7ANH+
         rD5igm/bpQcPRpUCOCDPZ8mnagjLrvNz5hhUV5+dDyAXIMeu28j4k8/me+xeQ+u3oPww
         NqvYkwZRmGfvr2hZSUbhAPZEjf47GrbPDR93FnX2PV6RRbfV2q1BewvmfB0bWvXzY7A1
         c10F6CFOoOIyuvvYd6bJ51EVkZJoo02N7wWu9U6JcI/zxwrSes6eziHW65+RCFYsRCIV
         gop77/f1BR7UvcmMNgmDAA7biAQwZVhFw4enOc07WKG0w0ngIcf5901OKlUXg0i/oRH4
         9ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294930; x=1779899730;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5m4belQIBg7Mn7sCkneyV4rbMVW1Gi36YS0PWnsWsEQ=;
        b=M0nHDXYtjaor3agKXjJgA2uhXHJFpZKII41HOXk2UYHaLtI+MGrRHJNdVkAyQMlgDB
         JP7UBHCIp0VqX872LcbOK2514dR8s2G9zByytAF/3BheV/tndCQqNsEHHEcYRnHt0ewx
         ZKw24TMLqW3R8uQjHew6thQ/uftz5ZF2HhYydpKpOjJ7y9hS/rGP5EDv/gsiTL+AP44v
         KS5aulJFUaCTiIWelczE6XT1Y7CaLfUVqFFlYHMAWJ32md+WBmkN+FEczt0TeA1i2pOS
         tSaK8BRD8bWnLw+UDVD2w0qzj/Pt7dTuIhCcRYF6FiK4HJv2vrzqY+K+5TOCyxGxWT4e
         xGWA==
X-Forwarded-Encrypted: i=1; AFNElJ/7nbwuYC5PaIINdflr7UevEWXV+Qz4JdysRuwIRuEaOK4CvWkOPxTIBQnhmOSo6i9wjO1apfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIiCkegYg2CxQORAa9PbyYHW9B8wM8xccCvbgYST3xxordQH2G
	cWX5ud+eK7XIqfCw0zH7mK1FifjeONohqfPp2VYgzalPqvLr/lB1wk0j2GQcOrm7sBQDAAf5FYk
	OKYQciQ==
X-Gm-Gg: Acq92OEzxVZDoQX2w+KaIbyBtZyiKHO2hGTFTpoxWJvwZJuNfJ1UHBgMB15LzZgT8Sq
	OnkRVVfvEydNysBM6pJ7bPDKlPhvtdnhoxZF9RDWPrsbgpiWlJpYZVoP+ktHPhhqOv4d5PRpgYP
	cA8SvuJHwMDgOT9/EmMdRX7wV3sGEut7YPC3eSpZQgpBW55U9pAyZ1WOv5E+oob05dZ5uLjyRBN
	uxbKi0GT9kIq9xjTN2VtsCwF34LYBdGdQ5tgYeXBX2iEQ+5mrSM5JilXc0lyDrTAst0nh8J8Wzb
	raKdMeVcnMLQm68ByIyvAGP5oH12A6kiUT1uXWghYR/61xCZBFwWxU4FUioIsgG1vKL40We/rxJ
	ddDzD3ckGmr9/cfR5m0GKCxMc3lQ72rSOPFdNNrkvYlBYO8UkdMfQelO0lf02xrVUxXT1GNucix
	V98SHg2nZCvsr1rAynxx2V0WM=
X-Received: by 2002:a5d:588f:0:b0:43d:733f:aee6 with SMTP id ffacd0b85a97d-45e5c5aefe4mr39349312f8f.10.1779294930382;
        Wed, 20 May 2026 09:35:30 -0700 (PDT)
Received: from [10.83.43.186] ([159.134.255.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm55863651f8f.8.2026.05.20.09.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 09:35:29 -0700 (PDT)
Message-ID: <591b66a1-4b20-40d5-b454-9eecbabfc832@arista.com>
Date: Wed, 20 May 2026 17:35:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Yury M." <yurypm@arista.com>
Subject: [PATCH net v2] net: tg3: guard napi_disable and pci_disable_device
 calls
To: pavan.chebbi@broadcom.com, mchan@broadcom.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yury Murashka <yurypm@arista.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arista.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290012-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurypm@arista.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4C235598976
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
been called. Guard tg3_napi_disable() against being called before
tg3_napi_enable(), logging an error if that happens. Also guard
pci_disable_device() calls in tg3_remove_one() and tg3_shutdown() with
pci_is_enabled() to avoid disabling an already-disabled device.

Fixes: b45aa2f6192e ("tg3: Add EEH support")
Signed-off-by: Yury Murashka <yurypm@arista.com>
---
  drivers/net/ethernet/broadcom/tg3.c | 19 +++++++++++++++++--
  drivers/net/ethernet/broadcom/tg3.h |  1 +
  2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c 
b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b..500b6f7fa 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7396,8 +7396,18 @@ static void tg3_napi_disable(struct tg3 *tp)
  	int txq_idx = tp->txq_cnt - 1;
  	int rxq_idx = tp->rxq_cnt - 1;
  	struct tg3_napi *tnapi;
+	struct net_device *netdev = tp->dev;
  	int i;
  +	if (!tp->napi_enabled) {
+		netdev_err(netdev, "%s() called when napi_enable wasn't called 
before, netif_running=%d, pci_enabled=%d\n",
+			   __func__, netif_running(netdev),
+			   pci_is_enabled(tp->pdev));
+		return;
+	}
+
+	tp->napi_enabled = false;
+
  	for (i = tp->irq_cnt - 1; i >= 0; i--) {
  		tnapi = &tp->napi[i];
  		if (tnapi->tx_buffers) {
@@ -7420,6 +7430,8 @@ static void tg3_napi_enable(struct tg3 *tp)
  	struct tg3_napi *tnapi;
  	int i;
  +	tp->napi_enabled = true;
+
  	for (i = 0; i < tp->irq_cnt; i++) {
  		tnapi = &tp->napi[i];
  		napi_enable_locked(&tnapi->napi);
@@ -17718,6 +17730,7 @@ static int tg3_init_one(struct pci_dev *pdev,
  	tp->tx_mode = TG3_DEF_TX_MODE;
  	tp->irq_sync = 1;
  	tp->pcierr_recovery = false;
+	tp->napi_enabled = false;
   	if (tg3_debug > 0)
  		tp->msg_enable = tg3_debug;
@@ -18099,7 +18112,8 @@ static void tg3_remove_one(struct pci_dev *pdev)
  		}
  		free_netdev(dev);
  		pci_release_regions(pdev);
-		pci_disable_device(pdev);
+		if (pci_is_enabled(pdev))
+			pci_disable_device(pdev);
  	}
  }
  @@ -18257,7 +18271,8 @@ static void tg3_shutdown(struct pci_dev *pdev)
   	rtnl_unlock();
  -	pci_disable_device(pdev);
+	if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
  }
   /**
diff --git a/drivers/net/ethernet/broadcom/tg3.h 
b/drivers/net/ethernet/broadcom/tg3.h
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


