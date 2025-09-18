Return-Path: <netdev+bounces-224432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B49CB84ADA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B887B4901
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3BC302769;
	Thu, 18 Sep 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FauBYyuV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723622FB60D
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199900; cv=none; b=BZNTVJg5xuHVTQFy5jAKYihG6DkLgZ4hrj52fcJzwH9FGi7oq6ZJmaK5B5BtKYXsghHYYygf3mfv0PYKiERF5uTVNISWDIWVCmhESvx4hQWKnOLBC4NAOArzg+gvD1uY9EYTevUVKH/UytWFz2QLzAXuSk3SZFqdE2nQPLuc47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199900; c=relaxed/simple;
	bh=kQvQlJ4Ntkejel7Bjw96+PBXVk0IMsnf/Ap3QHrmNCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cvPmNhd8V9zMsW9oj7+P9r1eYQ8mNO1UxY/9N2cDppFqy//Cgiws0y7XoIsywbvVstwwdZL8o9JJxl5o+huFNfCYipZOXVFGet/W4PJMSLGT5x7dCoGaq+2SEhODcNh4djKGWyTy+xkofauUm6yQ+7Dqs8NEa2oOoizFdxPZ3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FauBYyuV; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2681660d604so8594545ad.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199899; x=1758804699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgi+BTeRK9OMV3Te7iHLbRBW1UdG0wv6serJphMr1ec=;
        b=u4A8pqgZJf7fP5DrXnOTW21mhwhbcgn49IP8YOdli+/x1M81eFgwxjV85FkqFRUIuY
         N7f398R0+wgOLgp7dCBNXn4SlcH61FdR3ZNe3OhY/o9t2ZRY2T8jZ9aUYbKtJVG+wpm6
         rQuyixZUaoNk2H0Sp8IyBpSGFUBBlP9apPpmzK9yuLd1l96Ljos9d6MbNqzdTFScFhN+
         BPQyALdPeqAU2MfGyvqDEYjdL6MKa6VUlANElkj+eUR+G4Iqk7GvVEVSnAEJx94joYft
         +Pd2LCj7MxxH4ShPVPQNYhXyKIBQTihRsRDrSTbsyu3fMwJP9kec10ezG8nus1gnuLYp
         xthA==
X-Forwarded-Encrypted: i=1; AJvYcCU0FA2EzbdJ1F9s51HrWxCRzNsLrAO3o0qUwKy28Xp0mMp1EUjufxqlhopheVk7w/OpJhO5mQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCy5mDIgLeIGbE7AGf3kqO9tP8XTZSPj3WnZp+eB8ue98CCLZ6
	m6tnZVZpIdbdGV62bEPjjJxM9uK8k96/4m2GiEGHIABbFMxhYp4haKMjQ6LctZ8l8pM1ludTWxB
	6HlUjMioFm2eWIA/KBVKl/2ZoaWBJd0McM48ZfGJlv4PeETUz5Ol8nbMeO+xmq9QisMrSTcyVmn
	tU3V9IS5jGcU7QBYolrWSz8YeyDilhPvOojGpZ1JigCiXnhBiwrFFg8BxZfBIGb72Fk5oEWQQ1c
	TlvZVBSwBA=
X-Gm-Gg: ASbGncs3HYUcQbRP9mSq35XfeGmY/5fAFmLx8xET+CYDJg9w9ecX3IJBITCrrPyzoFS
	3Bu5hFl7ajngobUAytcfszmOXg4aSxEJMX2amHLDD8nCiKbDOLxU03kQbvEFFbQZ3V5kIRFgit1
	OrePpxjqxa38Swnh8eDf1RRdkzntB28qaLfRtG0bGCO1EgkmIt3yePmA7H4jR/LFvkUmB7co/bA
	VEXYD7OG8sLnvCgG+Y0me7mg2pZrCQQNf65/lr9PVwp0/t8+PlleSdS2fpisnFefS11y9aNdl+i
	9qnI28FhVIcnx4ZFhhkOqPKGioWJv2DqoffdwYpfZlmM+lsB3tl2GCcog/hvudVp+wRKp/pyFJk
	Xbc14Ih68x1XEMI04J0agm2ODzJJ+w6Y6mFmUijpI/ASMqkhIzESibMC/LuF//8mldZw/yQ2Y
X-Google-Smtp-Source: AGHT+IEM5Ynho/bQHxtQLj5H7tikw61wD60is+WwDrtp9iSgro3ENKTlZG6ivnUNQsEJMjuoVS667tSGS3bK
X-Received: by 2002:a17:903:1a68:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-268121808e6mr82125815ad.23.1758199898694;
        Thu, 18 Sep 2025 05:51:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2698029dfcfsm1900455ad.56.2025.09.18.05.51.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:51:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8178135137fso194339585a.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758199898; x=1758804698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgi+BTeRK9OMV3Te7iHLbRBW1UdG0wv6serJphMr1ec=;
        b=FauBYyuV9RU3PYdBbhT/xbRKdmsvPRJY5jeIF2P1+iA28OnnPvQOPbf5azb6HNYg1o
         RP9t3pwCs3pdwDb2SMQd961YZdOTfkLdKHfjnQW9u7IP63dgEj7F2GhfwfI9DoS+CZzS
         uNO1Q5WMPI2CmP+xTUgeh+DVYPVKYw+A1Ri/U=
X-Forwarded-Encrypted: i=1; AJvYcCWMZKoSxxmgt1Cy7NVHo3AGaRlUJoMlSY6q4InT4pVCLwrcAg18DozFmbUrjZkJfRP9YQQG2HE=@vger.kernel.org
X-Received: by 2002:a05:620a:2685:b0:82e:6ec8:9899 with SMTP id af79cd13be357-8310ef30b26mr617477085a.48.1758199897529;
        Thu, 18 Sep 2025 05:51:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2685:b0:82e:6ec8:9899 with SMTP id af79cd13be357-8310ef30b26mr617472985a.48.1758199896971;
        Thu, 18 Sep 2025 05:51:36 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836278b77fasm159592685a.23.2025.09.18.05.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:51:36 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pv-drivers@vmware.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	sankararaman.jayaraman@broadcom.com,
	ronak.doshi@broadcom.com,
	florian.fainelli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	tapas.kundu@broadcom.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6.6-v6.12] vmxnet3: unregister xdp rxq info in the reset path
Date: Thu, 18 Sep 2025 12:37:32 +0000
Message-Id: <20250918123732.502171-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>

[ Upstream commit 0dd765fae295832934bf28e45dd5a355e0891ed4 ]

vmxnet3 does not unregister xdp rxq info in the
vmxnet3_reset_work() code path as vmxnet3_rq_destroy()
is not invoked in this code path. So, we get below message with a
backtrace.

Missing unregister, handled but fix driver
WARNING: CPU:48 PID: 500 at net/core/xdp.c:182
__xdp_rxq_info_reg+0x93/0xf0

This patch fixes the problem by moving the unregister
code of XDP from vmxnet3_rq_destroy() to vmxnet3_rq_cleanup().

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Link: https://patch.msgid.link/20250320045522.57892-1-sankararaman.jayaraman@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Ajay: Modified to apply on v6.6, v6.12]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 6793fa09f9d1a..3df6aabc7e339 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2033,6 +2033,11 @@ vmxnet3_rq_cleanup(struct vmxnet3_rx_queue *rq,
 
 	rq->comp_ring.gen = VMXNET3_INIT_GEN;
 	rq->comp_ring.next2proc = 0;
+
+	if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
+		xdp_rxq_info_unreg(&rq->xdp_rxq);
+	page_pool_destroy(rq->page_pool);
+	rq->page_pool = NULL;
 }
 
 
@@ -2073,11 +2078,6 @@ static void vmxnet3_rq_destroy(struct vmxnet3_rx_queue *rq,
 		}
 	}
 
-	if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
-		xdp_rxq_info_unreg(&rq->xdp_rxq);
-	page_pool_destroy(rq->page_pool);
-	rq->page_pool = NULL;
-
 	if (rq->data_ring.base) {
 		dma_free_coherent(&adapter->pdev->dev,
 				  rq->rx_ring[0].size * rq->data_ring.desc_size,
-- 
2.39.5

