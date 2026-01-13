Return-Path: <netdev+bounces-249547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9930CD1ADB4
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 640683021769
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB4315790;
	Tue, 13 Jan 2026 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IU/ZDKOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A6288530
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329282; cv=none; b=me8xSObo8EWSsT+uu7ow4iRw9I8vE+1t2jS/EbTKOqTenP/yxAKinD0VjuD1t031AjPkYOrUGCpD7Z0J0P14nFA4KeHwNShQvVB2kdl3Cl6CYvqrGulM9XIyPgpVGviwDhu8KQI6sUexIYdylNdCQaznJv5eIqoSRv0dGdtWzMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329282; c=relaxed/simple;
	bh=BX3x6zKVJRBpHlY6BUmjbGL21wQ4tAvl3ZBtrNdk1oE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8nOXKyAKpTMLhDOsAjVu+035CUCxrXD4e0SBf5FdUYvc3FeMqKt08tKUObIyR8UleRPOrihRLQmydCtWDZP+fso5B91PekHnTCC/xpwi1J2z2QVacKZ/1oYeuRU6UNpCgM4RdjsrRf80/muFCAg3aeEmE5FLvVQH4j0utKiA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IU/ZDKOJ; arc=none smtp.client-ip=74.125.82.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-2ae38f81be1so8487224eec.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768329280; x=1768934080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFzFHQi4UXYKQN1BLdELhGHxeb+rkLahqxSjjcBn4/4=;
        b=xO1+HukJ7zs8t/DidIJFTLos094UOU5TnSDxjC9Ao/9SN9rkUtue81LE0KrnSg7vU4
         4pAKaXi8HY7VSjFq3MNHNVskdWIBtnDiNjtjM2Ndn/KVIkDRiESkEw4qYXnPDLk/MpsX
         PZycl10tbztzFr6XnyE3M5LhVXR1JrRGGAeEGeYwOVqRdz8804sg89NkiVq+Bh9W2s6f
         mnovtCQNKHsARZuxMzbAXSLedipQa3wk0wZXQvA+pdeoAl4v56P5xulibPk5ErQBD0WY
         DTbahiLIzWrvcEH4lw2GuRO+PsnnoyokAcLgQ2Z9AYUO3Zp9rJkoNHUYfkO2fgE3F625
         I+Dg==
X-Gm-Message-State: AOJu0YzxisNSAw8/k3InE1uE38bNzpxbnWhL52hoSmGKHLeSVQ9P6MAk
	lA1Mta2rdxX7oUPTNUcvJfbtDkfR6ynaN5khc5vmiKb3kW93S4CZFYBEWV8QdToEJmXGRIrKqi2
	bVye5wy+RkoqPMq+f0fMpAgR7KwlE5Ai4l2QUHl91lOoS3kuYLXooKJWLYG6tz2z1h2YJhg6gTB
	5964oIsvDGL+6etIIGIU8fnMSEPmKhQA9sM+7SOWDEDvmX8SuPiVxO8WPL4xFWWI7iTCEohY6wH
	FZSzVIoSng=
X-Gm-Gg: AY/fxX40VKB1Nr4fP4FHhM3e4/0Q0T3xELk+m1smzbBnGWm1sD+RS2CWFRVwEHgVxEW
	AmqYThla78kJwZtZEkgUiaSrC+J9PBBu2n1iXY6PwfnOBeTqRjHctGo5JHzz81aAt+U/3e696js
	CyFguDjUvclApijOyixzkeWBYmmyXsuGkn2j6jg2KAkjSeEcKFyZWvuxPKfMeWKhTUnWtJosKXc
	mg32CDcqlyHFKuMT85KsMeBHM7eTAT+rb8D2fUe/U53GJQJ7Ap7SktF9UdWATF17p6FF/g0BqFn
	P4WlzsQtD2kHoMtZTD+ZbqHE7jJebBnMtwrAnXTrU7qNCVGpeYudDBlcrdr0CCvvl0OLAUdlE8m
	sg7uEXhf9+HPsUCQV2co+dXQD+gm93Bis3JHMOm641HrSEXqUS5pp+fdxuVbXUYACPfTXHnT3wq
	bhIAPhq6R8vmlE9ZSXYNebhlHcWIFmAdESoQfuIy1EnuwAGzg=
X-Google-Smtp-Source: AGHT+IEWN2zG01yODPeLyaHs98l0LzGxGSdLLxg1RS7toE2ftzLjjkkrZMMXiHq4M1bAeafTG3NzG4P/9h+z
X-Received: by 2002:a05:7300:7f0a:b0:2ae:595e:83bc with SMTP id 5a478bee46e88-2b17d29cedamr12730096eec.28.1768329280388;
        Tue, 13 Jan 2026 10:34:40 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b1706abb67sm2928027eec.4.2026.01.13.10.34.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jan 2026 10:34:40 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-501473ee94fso9397181cf.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768329279; x=1768934079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFzFHQi4UXYKQN1BLdELhGHxeb+rkLahqxSjjcBn4/4=;
        b=IU/ZDKOJGKczRq3aRnQKOKsgbZF28mfxmKFyCbdp64v1o1iUmQ00e7oaM4IIJ6WROe
         DC8B+OvwVpQjz+5bDt3WWvAE6sZKoh3WUFyTfj+RLCXoehjhJbuH2XavoWXZI/kedStK
         P+94CJd4xLyPHLoMmgJ/lytJk+gtiig+P4UMc=
X-Received: by 2002:a05:622a:1309:b0:4ec:e1aa:ba4a with SMTP id d75a77b69052e-50148229b9bmr1237411cf.1.1768329279129;
        Tue, 13 Jan 2026 10:34:39 -0800 (PST)
X-Received: by 2002:a05:622a:1309:b0:4ec:e1aa:ba4a with SMTP id d75a77b69052e-50148229b9bmr1237211cf.1.1768329278716;
        Tue, 13 Jan 2026 10:34:38 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e4bf3dsm157738581cf.23.2026.01.13.10.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 10:34:38 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	sfr@canb.auug.org.au,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next] bnxt_en: Fix build break on non-x86 platforms
Date: Tue, 13 Jan 2026 10:34:22 -0800
Message-ID: <20260113183422.508851-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Commit c470195b989fe added .getcrosststamp() interface where
the code uses boot_cpu_has() function which is available only
in x86 platforms. This fails the build on any other platform.

Since the interface is going to be supported only on x86 anyway,
we can simply compile out the entire support on non-x86 platforms.

Cover the .getcrosststamp support under CONFIG_X86

Fixes: c470195b989f ("bnxt_en: Add PTP .getcrosststamp() interface to get device/host times")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601111808.WnBJCuWI-lkp@intel.com
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 75ad385f5f79..ad89c5fa9b40 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -882,6 +882,7 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 	}
 }
 
+#ifdef CONFIG_X86
 static int bnxt_phc_get_syncdevicetime(ktime_t *device,
 				       struct system_counterval_t *system,
 				       void *ctx)
@@ -924,6 +925,7 @@ static int bnxt_ptp_getcrosststamp(struct ptp_clock_info *ptp_info,
 	return get_device_system_crosststamp(bnxt_phc_get_syncdevicetime,
 					     ptp, NULL, xtstamp);
 }
+#endif /* CONFIG_X86 */
 
 static const struct ptp_clock_info bnxt_ptp_caps = {
 	.owner		= THIS_MODULE,
@@ -1137,9 +1139,11 @@ int bnxt_ptp_init(struct bnxt *bp)
 		if (bnxt_ptp_pps_init(bp))
 			netdev_err(bp->dev, "1pps not initialized, continuing without 1pps support\n");
 	}
+#ifdef CONFIG_X86
 	if ((bp->fw_cap & BNXT_FW_CAP_PTP_PTM) && pcie_ptm_enabled(bp->pdev) &&
 	    boot_cpu_has(X86_FEATURE_ART))
 		ptp->ptp_info.getcrosststamp = bnxt_ptp_getcrosststamp;
+#endif /* CONFIG_X86 */
 
 	ptp->ptp_clock = ptp_clock_register(&ptp->ptp_info, &bp->pdev->dev);
 	if (IS_ERR(ptp->ptp_clock)) {
-- 
2.51.0


