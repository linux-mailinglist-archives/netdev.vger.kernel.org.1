Return-Path: <netdev+bounces-190825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D78AB8FE9
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 21:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14801505A9A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6958227EC73;
	Thu, 15 May 2025 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NTN7XkdW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11225A646
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336979; cv=none; b=Ty0mNGHcm9Y/+YtVBE0ltsJ6RxwECB8ffA3dGJatuAu5zcF4l+TBq/kck56XEleo49hOZcYdbCZRcAj8+pjYwFwmH6oFoL1rb0BuPHc7TxEve3tLztDISWt+ub9Dn7Jguin3mX1puMV921QgeUpTN08NYkK+ZdQGoqGT3ZgrRVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336979; c=relaxed/simple;
	bh=96N46iqOIStqCIhFVpc7U2TEDGtEL6hnmfMs56TVuk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZhR5At+LnngRWODn5fyp4xkGd2pW1YLAR91fPwNAamy4DeUR7iujQSlNY7VqoxUcfnb4UcATeapNRk72WJdprBJt2KF2q6SjO4O6PGHATbwjeE3vq0SAqN65f46xLttxWnLSO70fnnBOi9tDudQWtSmKfRnCMdHpR1zKYO+aNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NTN7XkdW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74248a3359fso1486023b3a.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747336977; x=1747941777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fyWm0rF9eCaDvUShSNc7s++hP2H/Glv+MtPcJ7Ax5f0=;
        b=NTN7XkdWAvzW+LjgSPmy8TAIulTrUPQ1iIPFbitU1uXBpF6HdV/I3f0Xyq05zCF4a1
         jiwPBNpDekTsf6i9+vdtMCenuGsljisrJqxMyFPBprkP1Qz8wWFeaJGW79OSSLROVmrv
         iqnB1OkPv7Gk/Y42VHucbClG1D/9D1xoI2q5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747336977; x=1747941777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyWm0rF9eCaDvUShSNc7s++hP2H/Glv+MtPcJ7Ax5f0=;
        b=jNeTWpwgjPOFxjMEvepYrd3bkglmJ0DOfYMnNWey2DcYMWvEG+cyri7LNOPDc0k413
         /58ASnNTW5yRLN5+kQA8bvgcjWGSu8KTtPq5FZHb+/gNM+Fxf9CTGdC51MnsZnbhrPEK
         KxfqlTGbawX0akEMla5H9CmpyfcIFVUzsPYHGufowfB0/0OtRp9PqNu6xYtPR8UBkwjb
         QDHGpNSlZKJLsu5LEpZPwoUuTV//F+bxPnfU+hiW7VPTBEOfqXmo3lwjmPiNfXzGHXAM
         W0FJ4hndDK875plgQ8CQ0N9Y/IjLW5Lss3Z/+bUmJ29OIaQV6/JCgy0AEseoUcu9Y6mI
         1GHA==
X-Gm-Message-State: AOJu0YyV/PshIKCcAZt2ju2UsIo1m1fm/cW4MSvD5bpSGqHUht1LxV8Z
	QaGbrXxvNaUPjqHxDhPDlbFkqYjO+A3ppvR0oRLU+qrmwW4SEJeIIP2zl1+pwC5ZWxuw//yetQA
	hTCkccRRfiUUJsNlsmUNC3k38t5IsO9g0WMHMcwvO5PoA8tE6I4tvRXfyVTVpwjhg46ELER9H8Q
	cFu8DA9euTWLXVWXv0a7r5PftPO8lr2Z5k3mCjdz9lZ5o=
X-Gm-Gg: ASbGnctH5w1C/eEYdoPUW18TPXB6tod799HlS4NoJfezb+S3bTuHKUDbt39GcxGXXHA
	HFQ54iSe6mRAnblKf9oVwn12LleU25Sn+HXU79Nj+B+WzqF20TuL9wtPzTLCfIyqDxHAhFlUv8M
	Ig7+NF7rdIaHnEHOtplZQCL9V9EVf7bYIj8NPTZQsuFVhRBXt7luBle8J+xtCDI+kuGclstDOzB
	WqqIHffFH5w7Hi1iPz8nvXxDknd6G2MNnzis/NlvH2wJ+xUr9o6zLsi5Fl32u8pQ6CkPDo/zc30
	Om74J6D7M6I/iZp3sSZkyuWrDsd5+ur1rLjbO52Z8+x/QQhx+DLqYY2TQEmfL2lA1ZE43WD5qKv
	9
X-Google-Smtp-Source: AGHT+IGjWfUdXhgZL/hXJdI9mgEh2fOX9YaRz+9pHCBuN/jVr88KABTo2oYP+8cK+POae/uJK9WdVQ==
X-Received: by 2002:a05:6a21:3289:b0:215:df3d:d56 with SMTP id adf61e73a8af0-21621902575mr851830637.21.1747336976503;
        Thu, 15 May 2025 12:22:56 -0700 (PDT)
Received: from ubuntu.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a0b19sm255222a12.74.2025.05.15.12.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:22:55 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: netdev@vger.kernel.org
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	stable@vger.kernel.org,
	Guolin Yang <guolin.yang@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronghua Zhang <ronghua@vmware.com>,
	Shreyas Bhatewara <sbhatewara@vmware.com>,
	Bhavesh Davda <bhavesh@vmware.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] vmxnet3: update MTU after device quiesce
Date: Thu, 15 May 2025 19:04:56 +0000
Message-ID: <20250515190457.8597-1-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when device mtu is updated, vmxnet3 updates netdev mtu, quiesces
the device and then reactivates it for the ESXi to know about the new mtu.
So, technically the OS stack can start using the new mtu before ESXi knows
about the new mtu.

This can lead to issues for TSO packets which use mss as per the new mtu
configured. This patch fixes this issue by moving the mtu write after
device quiesce.

Cc: stable@vger.kernel.org
Fixes: d1a890fa37f2 ("net: VMware virtual Ethernet NIC driver: vmxnet3")
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
Changes v1-> v2:
  Moved MTU write after destroy of rx rings
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 3df6aabc7e33..c676979c7ab9 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3607,8 +3607,6 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	WRITE_ONCE(netdev->mtu, new_mtu);
-
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
@@ -3622,6 +3620,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
+		WRITE_ONCE(netdev->mtu, new_mtu);
 		vmxnet3_adjust_rx_ring_size(adapter);
 		err = vmxnet3_rq_create_all(adapter);
 		if (err) {
@@ -3638,6 +3637,8 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 				   "Closing it\n", err);
 			goto out;
 		}
+	} else {
+		WRITE_ONCE(netdev->mtu, new_mtu);
 	}
 
 out:
-- 
2.45.2


