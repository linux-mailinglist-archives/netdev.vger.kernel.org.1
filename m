Return-Path: <netdev+bounces-190256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5922AB5E5B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 23:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F483A7F74
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59871F2B83;
	Tue, 13 May 2025 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XtrvhuWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1D1FFC4B
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747171242; cv=none; b=qCuIalXxuoT1sHEQRHVYGSiQ72NRz7ypMrdDfDrb5nQ/MoJy779rPMeEocCyZxXpxO8cjH3lSPaaxriiGdnxSrahyAd/FdeGAcJiW/l0Nz3G61Mi7i9+Eg9bLe6KjloblWZ6FjoQMWljUioweMx10m8LYBoWfWewF4m3Jlzx/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747171242; c=relaxed/simple;
	bh=M7pXAiXplMTRQs+4RjP4ptAizMSNn/X1Eyo/2bXfjKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGo9mK7GE4XfwlEKXNkw3Oda+RU0kDEvyQmAM6vfV/t2FvyjWdYMdJWrPutl2s+U3etTgbP9k80XR5Q2bKbZ3rfUIqvA1Vaf1UIfOlryQP73FH4v3HQUlvQMc4DceSJFP4JUfxtP6mA2yaWMp4TYY7Zl4lr7q+6a6cnlCkIvzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XtrvhuWY; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-afc857702d1so5184878a12.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 14:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747171240; x=1747776040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tktSgBWAVXWMwa5kK+nyg9pqAy3BG4YkGNfURyQ8YpU=;
        b=XtrvhuWYBMeAVtOe9U3FlBfFPA7lko16dESgQhZdxrNF+UQng4o86ciMe9MKwnG1Io
         E7rPDVogmk5jzjJDpmasUPgVeQGW7F0YqDyBK9hE220eeiKaDjo9CKbaR7xK5AI4QdCy
         fUXE4xwJ859LksdLM92vHC2seLteUDH21vQmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747171240; x=1747776040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tktSgBWAVXWMwa5kK+nyg9pqAy3BG4YkGNfURyQ8YpU=;
        b=aflawPO9koHYS/vGDLkfUKUEJ1PcyVNNhgjLHunN7bS0GlXcx06Rh8cGoseKGMoJ16
         8GuaTt6yB9jnYK6wastP2KX9m/gjIaymKUKiUsiXCwaJsJgbOlh56EfMZE74iea89Erw
         rZeZDxRB6KW8r0V1WXt0QEDJhrrJIgFcgHRQngrHQ6izUOZNgAUnmoR0aWJkynF1gJBF
         pAamSlShFwB1nxfUin+rD0ErAuauhxB0cy1iwjOEPvfWBzhFTySn2BPmnuK+GGWj7N1c
         GjTU5ztMLagqxhT40gjLcm0Q3ekuobwXegZg9vZHRdg6/mW+xr+WxNgSfXMjegSm7UfT
         GztA==
X-Gm-Message-State: AOJu0YxC6p3Tt/JRM/JsfP/M7FqR5P3lOnuFJONxhweoPP9X/U2tJwEr
	nNb6jdTbsKyncGSSh3ZxeLmV30G2F9iZP+Ei5eIUL/CQikxD3NiIf/0QvMkEZAxKPCKBEcMDFeJ
	KbHp+X9GWpGdWHtxshKa3k/y/Cao5omuHC8GtBIZnQgqCPo4/Dmtrs0T45/qxSqZW2XHg6UPuoc
	OQor7SMUn4CrW0g6+nRJpB1MJQi1nd34WUjuP/x2VsKw==
X-Gm-Gg: ASbGnct6RH/qa826rtokb69BYJKbEoA59m7xxt38vaiD4kDaDkUhXmaNcxHMiWWO9Qn
	SPcgqFzCnrZwCTKHWk38JL6N0EMM1f0gE+Fim4UU0MDBIM/27/4VRMKZEyn7G646PAbigrcifen
	A+tv8xxfdtkjFOoo9Iq0Qdy0GSBP9UZRBvdh7UMBVjpZKVO6suaIZFzK5HIDp/T65OkEo/pEObH
	7gzbpTsV+2NYXVEdeVzkJBzK5Br+EbBwCkXT5Oru3su6tkjf3iFRpVjhkSAWKKvVWkqa4f8lUCu
	kM5/1uST0Ohq8I6duV3GgmwsPbM1/qYkygJWg+ujOp4BPxG8FIsofxhsLXqx7fJHbyzHvOH8fvk
	f
X-Google-Smtp-Source: AGHT+IG6NMNP7O5vMscL8kEzMjj89CSjv2pzaVBWi4tL1mCe/KfuLBlCNoNKBpsS77XeTzHY9qPexw==
X-Received: by 2002:a17:903:166e:b0:224:256e:5e3f with SMTP id d9443c01a7336-231980e5929mr15136515ad.25.1747171239761;
        Tue, 13 May 2025 14:20:39 -0700 (PDT)
Received: from ubuntu.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82a4c41sm86671845ad.237.2025.05.13.14.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 14:20:39 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: netdev@vger.kernel.org
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	Guolin Yang <guolin.yang@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronghua Zhang <ronghua@vmware.com>,
	Bhavesh Davda <bhavesh@vmware.com>,
	Shreyas Bhatewara <sbhatewara@vmware.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] vmxnet3: update MTU after device quiesce
Date: Tue, 13 May 2025 21:02:40 +0000
Message-ID: <20250513210243.1828-1-ronak.doshi@broadcom.com>
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

Fixes: d1a890fa37f2 ("net: VMware virtual Ethernet NIC driver: vmxnet3")
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 3df6aabc7e33..58027e82de88 100644
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
@@ -3619,6 +3617,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev)) {
 		vmxnet3_quiesce_dev(adapter);
 		vmxnet3_reset_dev(adapter);
+		WRITE_ONCE(netdev->mtu, new_mtu);
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
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


