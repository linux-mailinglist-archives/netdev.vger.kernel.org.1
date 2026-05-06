Return-Path: <netdev+bounces-284777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHFALX8T+2lLWQMAu9opvQ
	(envelope-from <netdev+bounces-284777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7924D9276
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20820310A1AB
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 10:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F6440242B;
	Wed,  6 May 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6Eg62y0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E03FFAD6
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061691; cv=none; b=EUrn11IsBvRtvnjN4YzDUFTQxeVosAjN/H6AHFRTHi02V19iLQQ8prYY5sGQSNVO61lp/igmos2uPPFTZcfavCDcq4aE1WOw6EIxx1jspRtmBIyjlyqEaN/ShlogQblUBOn6wag7QkTC2o2TuV/TA9FprnmfSJ7IXAyemz4XDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061691; c=relaxed/simple;
	bh=vB+hpqwAuJSsSh1PVEzvz0BztCBRmFa72QGJZzXSVsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tt77UNfUSnjk0saVJKsgZ3gjPHpC2CdKtf8prJP+biEYOi0oufJhjqDxMiTjHE0K8w9YEnLsYQeQBqLktz0k3zBHZlh40EWIzOv3iKYLFLzLydCVKcJIPNCgDfStG0p+oSMLrWl+Eu4OYATowjS1lx7D5RQsuk0yncEa4X8GeaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6Eg62y0; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12e332315a8so1772299c88.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778061671; x=1778666471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hD4J81dj9SOxPXQuOmqvf+HfpPOudwaP/8n72hj3Yi8=;
        b=N6Eg62y0OI6AgS8s6dkddZnybCoDWPMb+Gef3i+FJNbTe9dVfyCjXfyw470MwwUKnU
         VTLAb13oylqaGSPtJrO/ycWtejD09q4kcWELnUDa6xjnomiMpXPbBtvQhBbxz0+zovk9
         ZRn9wxB/YYV+Aq00QrlSDKGb/TsrfzYNp8s9OfEb3DyxOUyzLeeJgDP3uDYyfsEM/V61
         foRsKyRNXHjhfmjcBw0bi5FodRww86vWGemVp/rsEe47bWORGqou5wIKb12BlsBcDcYQ
         lfLOFjsIj/2DBHUW0+XubEhPtjPM6paP6bhisXFA+FlnwFlYnlc72x3/RjsdYNsH+KD2
         V0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778061671; x=1778666471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD4J81dj9SOxPXQuOmqvf+HfpPOudwaP/8n72hj3Yi8=;
        b=aYpSfV+u7mRmVHbO248HrlfufRiSpe11Bzjd8fM7EwGjlwklJFHNQghoO/0WRxrPcX
         j4G1qLyXgjeoY3n5Tr7Le37kTTWoRGKkZJJJ28lBZ9n1gFRjWv7WuScaoMBHtg2uE5m2
         tqqSjofLxDi8qddLkza5Lw6KCsJbRAaV5OZEpwQgU+BeUMuZvbvI4NOLUrdwaEdoYDyu
         C3NHT8i+BOw5bUFftAPZrkRuHvuRV3QbbXSE7aBi+gPpxNqXt2sn+C6tynXDo/6L0u2+
         tHPmalP22lW+Krq4WohvoM8yzoPDLcXb6W6S1UtIaULnh/f7g4GaVqdVdZol1D6sC0G6
         E0nQ==
X-Gm-Message-State: AOJu0YyzZ+F/mJvhq+2Ju/Cx7IDjgocWKSuRu3qSJTshpL/6w5r0a0XU
	EHvO3YvHq6G51qm8K/vWYtLldPNNw7aIYbv3gOeCA2ojgTLMiCKg1hti
X-Gm-Gg: AeBDietNjfHtd0rsgFlANx/wNnY/IjaP/cGbkuhp9KrlXoei2ETaHY3iv107tqinOrj
	zxZdKIXzd+o7IAy04VdZsxuhUZ1jvMW6TQmQpNLD+fSZFuXagnqYg9HplvVe15hd1AjfHLvqGt+
	ZXpyusc4synxq1Dc6QVn0tTFvp7F7q6iLobeu2Vqv5hzpjHNz26Emwx3POkf440aPvWVC42DyaB
	qYPDisq6MUCGsD7hJxemdxtaAtwrx3yM8E6J5qynOfLACOdKa6xeThkNzsdHOGUT4yVRYA47WEy
	S+duokrkftr2A5HAtkJBmh4ubdim9KpIasuIi+wXeGS+zC2Iwnc9jtD7nVOVYMSgv+2a38ZuGVt
	IBx5c48yU5cB1Dx783McW7qPrrJky0w3sHzXZuQ+EAwJKbtq9DdsRjga3Xf1sdWtY95zL3T47j0
	dCrLOlKbAMRhOSLUVdYMVJUt0CuIKZWdy8IBBUkzCkww83Qw==
X-Received: by 2002:a05:7022:1a83:b0:127:33e0:ea44 with SMTP id a92af1059eb24-1318e8185c4mr1567525c88.29.1778061670732;
        Wed, 06 May 2026 03:01:10 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f9679db9sm2608829c88.1.2026.05.06.03.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 03:01:10 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shenyangyang4@huawei.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexjlzheng@tencent.com
Subject: [PATCH] macsec: defer RX SA cleanup from RCU callback to workqueue
Date: Wed,  6 May 2026 18:01:07 +0800
Message-ID: <20260506100107.388184-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E7924D9276
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284777-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:mid,tencent.com:email]

From: Jinliang Zheng <alexjlzheng@tencent.com>

crypto_free_aead() can call vunmap() internally (e.g. via
dma_free_attrs() in hardware crypto drivers like hisi_sec2), which
must not be called from softirq context.

free_rxsa() is an RCU callback and therefore runs in softirq context,
causing a kernel crash when the underlying AEAD implementation
performs DMA unmapping during tfm destruction:

  vunmap+0x4c/0x70
  __iommu_dma_free+0xd0/0x138
  dma_free_attrs+0xf4/0x100
  sec_aead_exit+0x64/0xb8 [hisi_sec2]
  crypto_destroy_tfm+0x98/0x110
  free_rxsa+0x28/0x50 [macsec]
  rcu_do_batch+0x184/0x460
  rcu_core+0xf4/0x1f8
  handle_softirqs+0x118/0x330

Fix this by splitting free_rxsa() into two parts: the RCU callback
now only schedules a work item, and the actual resource release
(crypto_free_aead, free_percpu, kfree) is done in a workqueue
handler running in process context.

Add a destroy_work field to struct macsec_rx_sa and initialize it
in init_rx_sa().

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 drivers/net/macsec.c | 13 +++++++++++--
 include/net/macsec.h |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..dabd3d2598ae 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -174,15 +174,23 @@ static void macsec_rxsc_put(struct macsec_rx_sc *sc)
 		call_rcu(&sc->rcu_head, free_rx_sc_rcu);
 }
 
-static void free_rxsa(struct rcu_head *head)
+static void free_rxsa_work(struct work_struct *work)
 {
-	struct macsec_rx_sa *sa = container_of(head, struct macsec_rx_sa, rcu);
+	struct macsec_rx_sa *sa = container_of(work, struct macsec_rx_sa,
+					       destroy_work);
 
 	crypto_free_aead(sa->key.tfm);
 	free_percpu(sa->stats);
 	kfree(sa);
 }
 
+static void free_rxsa(struct rcu_head *head)
+{
+	struct macsec_rx_sa *sa = container_of(head, struct macsec_rx_sa, rcu);
+
+	schedule_work(&sa->destroy_work);
+}
+
 static void macsec_rxsa_put(struct macsec_rx_sa *sa)
 {
 	if (refcount_dec_and_test(&sa->refcnt))
@@ -1407,6 +1415,7 @@ static int init_rx_sa(struct macsec_rx_sa *rx_sa, char *sak, int key_len,
 	rx_sa->next_pn = 1;
 	refcount_set(&rx_sa->refcnt, 1);
 	spin_lock_init(&rx_sa->lock);
+	INIT_WORK(&rx_sa->destroy_work, free_rxsa_work);
 
 	return 0;
 }
diff --git a/include/net/macsec.h b/include/net/macsec.h
index bc7de5b53e54..aeacd361f686 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -9,6 +9,7 @@
 
 #include <linux/u64_stats_sync.h>
 #include <linux/if_vlan.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/if_macsec.h>
 
@@ -137,6 +138,7 @@ struct macsec_rx_sa {
 	struct macsec_rx_sa_stats __percpu *stats;
 	struct macsec_rx_sc *sc;
 	struct rcu_head rcu;
+	struct work_struct destroy_work;
 };
 
 struct pcpu_rx_sc_stats {
-- 
2.39.3


