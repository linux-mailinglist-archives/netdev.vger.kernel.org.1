Return-Path: <netdev+bounces-146869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4459D65E1
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A044CB2198A
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062AD184549;
	Fri, 22 Nov 2024 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lf5LcwO2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E219C555
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315598; cv=none; b=KTamoXwc+CG7W/vPyBRzmVjNR6WV+fYkODXabVsV95Fa8knCjQY3OZf1r4rPKv9H3hOjIS9uukbmr6KoiOkpeAoHD8XlswPaQzhpoeJbKwC3K23H0YRd9nVc8XoMHrphefnohoMX6bWitbqMBIhq3/NbuOeY3TiR4vZ2yokXqew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315598; c=relaxed/simple;
	bh=gK99FJSKcrUNP7J/Y0KefNeorx8IYmUiKjnMCCaUCqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFeTbdAligb38laULfeoGITSl/B7s6iA+mBWNSnWXPws/NoA9rC0GyJPvJjsD012oKdYrw52nr1TTGOE+1OTB7cJHNSnlZpHpMNeKDzhycRBvpOrJNJpKtNzEldSsfgh4+gOsI+uMsjnrDu3dWutHmzypgRHaXl+Gw9HyHF4cSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Lf5LcwO2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b14df8f821so191671185a.2
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 14:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732315596; x=1732920396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd2TbHC3KR6JxQsGWET9eP39oCusBe1UWk8/8R8NPco=;
        b=Lf5LcwO2Dn0ES/EX8v4h7EDJMHJhZJv7Nm9De7gjrPCKsLKbrVashwtZKkmYXnXQJH
         JXrHlzS1zS2iEdp+cg/7knObqaLY+lO4J/D2Kci3m2t6bUCacuBytCGSQRYcuxjy/cjN
         Bw8bvEp8K4qJAH1k+QjLF0QbU3+L4IfcZ/5zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732315596; x=1732920396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kd2TbHC3KR6JxQsGWET9eP39oCusBe1UWk8/8R8NPco=;
        b=phhzKtaghhUhuIDvHFNcQiIh9vC0E8KLbNL5mkNxZfjwe1EmVJ0OV4y5/gOeG8nsQu
         p9/0ixyjckaUMjFuNkOd+ZAezXGS+im9d/TBRGwcos4KJ8ArLIjskQz09vPUJj06eS0h
         CKYPogeTF0KuaYd1bDsBqgv5N2CUEjP0ylQauTIhaHcEz25jVC6pu6UkIGQt3Y0AZj18
         qNNc17WwNvEXZy6pdX6yJTK/ym+pdMsgTmSvnba1LEdhUuHQJkvUvR7m0FXkPs/J7dUW
         FjPN2r2FjNE3kNAJYglUWILpf3XOQ/ahBRnY0+hgsSGmoXYfA8EFamDUNzkMd+tW+gAa
         WZeA==
X-Gm-Message-State: AOJu0YyaxW7uq/8a5Fh0L5hOhkx2b0IugNsL359FrOejMn1EYsLNpHPf
	FX7h23uktsunhobgk8cpgBND14tyhUk3SBvomX7AkTBg9kpbgThj7XyIgbQ0Ug==
X-Gm-Gg: ASbGnct7f7JOA8drudetIup8mY+O4JJf5q8zXbH0ebz/muuFttrBkZX03TBxnre5r+B
	iLIgh9hTWpNB/6sw7MG2hVzNWW7v0kmoI8jitqX/gFzW80Ht3AL63bA9T/7tkBVLAk3jGfoL9Ap
	k4NOcGfhsgT1dC/N3aJ4E5FosvAwFdHrtLSRSDtLk87pY78VtOgbiIZxkiiD2RCwNtVQm4BWQ/s
	ahH8YuS5eCUdD3MB4vzem1Mt5Ik41vqDYb78xYwrauM2dJVHl7PNmmAhQuuJCLkjEZiv1rAGxUc
	8kQHV7TThHNKs/GIcN3ivS3aKQ==
X-Google-Smtp-Source: AGHT+IGNFBPdurPdlzfNvnYZ/c2/XGIV54bFpwCTGj/7wbhhchMtbmjePciWDmwcyCyQnxsxr3TJZg==
X-Received: by 2002:a05:620a:2982:b0:7b1:35a8:774 with SMTP id af79cd13be357-7b51459a49bmr647945785a.52.1732315596106;
        Fri, 22 Nov 2024 14:46:36 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b51415286esm131270485a.101.2024.11.22.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:46:35 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	David Wei <dw@davidwei.uk>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 3/6] bnxt_en: Fix queue start to update vnic RSS table
Date: Fri, 22 Nov 2024 14:45:43 -0800
Message-ID: <20241122224547.984808-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241122224547.984808-1-michael.chan@broadcom.com>
References: <20241122224547.984808-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

HWRM_RING_FREE followed by a HWRM_RING_ALLOC is not guaranteed to
have the same FW ring ID as before.  So we must reinitialize the
RSS table with the correct ring IDs.  Otherwise, traffic may not
resume properly if the restarted ring ID is stale.  Since this
feature is only supported on P5_PLUS chips, we call
bnxt_vnic_set_rss_p5() to update the HW RSS table.

Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
Cc: David Wei <dw@davidwei.uk>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3eeaceb3ff38..3bee485b50f0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15477,6 +15477,13 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
 		vnic = &bp->vnic_info[i];
+
+		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
+		if (rc) {
+			netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
+				   vnic->vnic_id, rc);
+			return rc;
+		}
 		vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
 		bnxt_hwrm_vnic_update(bp, vnic,
 				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
-- 
2.30.1


