Return-Path: <netdev+bounces-242083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3824EC8C21E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B68654E77D9
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1096341069;
	Wed, 26 Nov 2025 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YqneIubz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393C125A9
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194265; cv=none; b=rt+pzO39o1IXJWieHCEIhn2+tK+vRSHni0n85fFVLfrnNo6PCzdrju74i7m8N3er2wQswi6skcshcyLjlJ+XBeE2+UrLaVVQba7DDRRQhjyB/28mUUl5XU9++ILoQyyqDkTobOaGtb7KiljocQkhQeemUeHEYd1ranrvWMCTflk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194265; c=relaxed/simple;
	bh=sfXjPRLnrHpyjhzlDDn1XTB2qSy04fE3XGlcEXbyzgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaGuVp9yrR39IpOThNftlH/ujvz0cXQIkG8pFSxrx+1PpYiEQlGf/r0uJhV7ElUCNZNxLkCpA7oFI2oI/mLpJK/rRC5j3GxSbrYLR3iHsKgDQSIYo+vsnzGy3EtZTFLvgdMm8tJPsZDKwyOQ5hNaWU1uBv6qQNCwH1OpA+5uvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YqneIubz; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8804ca2a730so3211486d6.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764194263; x=1764799063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sap9H6YgvjxCIoxgxSVBa1/9wfMCReUfC10ClsIIPoE=;
        b=gFekEyUgrZf9auT+xCgju4of+GDR2FyFFWutR8165GTR3jyk1JNP2zqDHWGcDtTYbk
         V7XReV3HQ5jt17vze/hA/LEe8ZCRyI3lcaLDbJyRH8iT/ZXof+4mRZlwTeU1MO1JxzYe
         RWzcc4YQcARtCGU67FpIMqZTsCyhfCjIWDCIkr740uss6SOkIwfUBaZUpxIF9Pp/t90W
         rIlrgaNJ1IqnRgTLfEtxG8mkur+JOSRzdyHSTxlCwZXHV9VS6T68BjcIjxzmNABU6FRv
         WoE7+5FKjcfJk6Isyd92ICyZL0rDczu0z5nbxtMTv3psGaDCKiDyqz6FJtckPO9SF61a
         AJXQ==
X-Gm-Message-State: AOJu0Yw0w5wYEMFP7ccNnoqjWV73QC96QA0YWvV/boZisJHpxk4HMrlr
	KgLrHUvdlFHyYTxCxjyTVa3Is/NoQ6AkYBQRY8vfzNPv35gTpw2y4uA4v3m4nLQTK9Hh8VgRvof
	tzDgBQUvGySTlDi9UgCKaBJkr8WTF4S39L6w5H6YQ0YJtC/hYrTTohh1h40GDBSJ6Kov4+s2M2D
	Zoi3XQd8hbjO4SMnIcJWGK0I4HFoo0uDyCw27Puf8Wyf4ZCk/6ySqbHJ4R4PtmsvDTVBExmHhwA
	Ges7zsgVmc=
X-Gm-Gg: ASbGncsigJ9UyzXavXdfUQbhIVGh5bHV3F15k1In0MpS7kVDUhgGQeUCHepm+2XkGg+
	p3QKbam9A8sKxZIjmy/6yM/pOZ1FVt3CtDYOK1WxtwVRe/RzExpuftVBsHHNHAyis01SJLPWKpV
	FiNt30J9ibLT5+93knVZjqfNlKfV/we1l1fIfyUm0zgMlkxSdlLrN2hmEFyrczytOy2XUE9HIom
	0H+KX8+BRd3YGt+wDKQguKT6m0vQh7Gyk1oLETQpNXb2h7i1zdvOftT53iIyryI7hHm4pzn94U+
	PfrdhqCZ0wPs3SuvnuCd08YjBv/0Q4Usuqh+H9wYcJh5UXMaApcyoG9I5Wfyw6ShtSkBUso+QBl
	iQXekpd9+7R2goe7cGU2T9qF1a/yPfhMVTcoOsH2LqZHvkayNgRQhWvQUJa3j0zVvp9cMKvKoFD
	pmoJwDV2Vc3sJKo+lrvfGzLvKIaeJkdVGE1g2Zo34fBdJP
X-Google-Smtp-Source: AGHT+IGPzeXFeFGyY6wufFuA3HdIdmCKfcc+BzMRSR2W5wmMvKSPGPJpb7OqsnD+TUjBQxnwNk+Djngzzy4p
X-Received: by 2002:a05:6214:1d23:b0:882:49f4:da1e with SMTP id 6a1803df08f44-8847c52b3f9mr340680516d6.54.1764194262996;
        Wed, 26 Nov 2025 13:57:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8846e45feb9sm24392366d6.4.2025.11.26.13.57.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:57:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b24383b680so56312685a.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764194262; x=1764799062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sap9H6YgvjxCIoxgxSVBa1/9wfMCReUfC10ClsIIPoE=;
        b=YqneIubzAoVNupvDy/eWudxVvPTwBKQQ1Ck41nGG9bvVwT08W8MTJxt02vfgpo3urX
         DxvSaZHKdNLld1y5QLNwPh3ofI3R0pY++sd7UBgxIDjPQDlnYNhCCREvww74i7vWaUsE
         PEdAZPMRAVsQhwZ8rw6ewhnNh43UKianQZogw=
X-Received: by 2002:a05:620a:199b:b0:8b1:426d:2b87 with SMTP id af79cd13be357-8b33d22a4damr2754493185a.21.1764194262325;
        Wed, 26 Nov 2025 13:57:42 -0800 (PST)
X-Received: by 2002:a05:620a:199b:b0:8b1:426d:2b87 with SMTP id af79cd13be357-8b33d22a4damr2754490385a.21.1764194261832;
        Wed, 26 Nov 2025 13:57:41 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm1473933185a.37.2025.11.26.13.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:57:41 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 3/7] bnxt_en: Remove the redundant BNXT_EN_FLAG_MSIX_REQUESTED flag
Date: Wed, 26 Nov 2025 13:56:44 -0800
Message-ID: <20251126215648.1885936-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20251126215648.1885936-1-michael.chan@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

MSIX is always requested when the RoCE driver calls bnxt_register_dev().
We already check bnxt_ulp_registered(), so checking the flag is
redundant.  It was a left-over flag after converting to auxbus, so
remove it.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 7 ++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h | 1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index f8c2c72b382d..927971c362f1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -142,7 +142,6 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 	edev->ulp_tbl->msix_requested = bnxt_get_ulp_msix_num(bp);
 
 	bnxt_fill_msix_vecs(bp, bp->edev->msix_entries);
-	edev->flags |= BNXT_EN_FLAG_MSIX_REQUESTED;
 exit:
 	mutex_unlock(&edev->en_dev_lock);
 	netdev_unlock(dev);
@@ -159,8 +158,6 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 	ulp = edev->ulp_tbl;
 	netdev_lock(dev);
 	mutex_lock(&edev->en_dev_lock);
-	if (ulp->msix_requested)
-		edev->flags &= ~BNXT_EN_FLAG_MSIX_REQUESTED;
 	edev->ulp_tbl->msix_requested = 0;
 
 	if (ulp->max_async_event_id)
@@ -298,7 +295,7 @@ void bnxt_ulp_irq_stop(struct bnxt *bp)
 	struct bnxt_ulp_ops *ops;
 	bool reset = false;
 
-	if (!edev || !(edev->flags & BNXT_EN_FLAG_MSIX_REQUESTED))
+	if (!edev)
 		return;
 
 	if (bnxt_ulp_registered(bp->edev)) {
@@ -321,7 +318,7 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 	struct bnxt_en_dev *edev = bp->edev;
 	struct bnxt_ulp_ops *ops;
 
-	if (!edev || !(edev->flags & BNXT_EN_FLAG_MSIX_REQUESTED))
+	if (!edev)
 		return;
 
 	if (bnxt_ulp_registered(bp->edev)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 7b9dd8ebe4bc..3c5b8a53f715 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -58,7 +58,6 @@ struct bnxt_en_dev {
 	#define BNXT_EN_FLAG_ROCEV2_CAP		0x2
 	#define BNXT_EN_FLAG_ROCE_CAP		(BNXT_EN_FLAG_ROCEV1_CAP | \
 						 BNXT_EN_FLAG_ROCEV2_CAP)
-	#define BNXT_EN_FLAG_MSIX_REQUESTED	0x4
 	#define BNXT_EN_FLAG_ULP_STOPPED	0x8
 	#define BNXT_EN_FLAG_VF			0x10
 #define BNXT_EN_VF(edev)	((edev)->flags & BNXT_EN_FLAG_VF)
-- 
2.51.0


