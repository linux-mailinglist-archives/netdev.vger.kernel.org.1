Return-Path: <netdev+bounces-119325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B4955261
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 152F8B21695
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526561C7B8C;
	Fri, 16 Aug 2024 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H3etuSNU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54B7F460
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843763; cv=none; b=WWhN4MmdygRCd8uiAAC+ChxPJBbrvFTtakGVZ5iMzKhUJ4jM4EaH9jGjP/4JDYV53U3nNgLGTq2jTQjv7jfKnkzCXcfN1RHSaA1OAeGCsfpchc9mFzMYtNbQT7Tr2YYpdBnuX7jUVMzKR6hxhNBOs5OEpQMnlMxcO2VE88wu+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843763; c=relaxed/simple;
	bh=hH9Y7/JeY6R4A6e0y6SlIed+6faiNm05g2RQpE+1Vts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRk/EmIHDe65MFLf5TH5xKEE+BwgxclCzuMaWgUm+3O05i0ePscRddN8+lwwvRKfRsKJDyT0qntjbUuC2Ex67QgpGXWHVBVDVdza6Vc4fQSinnPh8NtRGwr0AufDyhAVIVOvj7bumN7Q6bhOspSvclHGgd8gYUFXS0NRgsTWbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H3etuSNU; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-451a0b04f6bso15198041cf.2
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723843760; x=1724448560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpdcMYzLhy1ANz15Ap65NGpAKNJ0pXRsyTGjNNNtlQM=;
        b=H3etuSNUtyLH04VtdlWSPG4FPO2k4rXOXoAHo6ciTJa3oLfJWopnnnZWNxEmhfAEhE
         uAYO3rLYZ2pze7osCHIN3pVVMFML+AF7BJOSOq6QJ008Fge6L3CQbh2C5Is9qOBGLtPQ
         ypHT3Hp6aQiHjWYp64CCK1wDvGUJXAdnVcifQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723843760; x=1724448560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpdcMYzLhy1ANz15Ap65NGpAKNJ0pXRsyTGjNNNtlQM=;
        b=E3xaoTkBExIhyINWStsNdorB7riNDUUs2yUSLY98j+PYoAfXVF6FgyazdEgKvjoQWZ
         0zdaiOcSOHlFgcmWfNKcgPHvr4Crc3+X2e5pjUP95IupNDNTIyFfWPGhKWp76G72VPYw
         QkvedpdjqzbFrA6DYQUi4zUNxbeeWMDnEGimJper1xYJEegWmdrvRVZ3qGVm/dM1N6VJ
         szuHDOHZ6JL+XkWkXFjfslpipwcm3ZO23mSSZ8EH0VuFVhjMylUEaNob/Kh2+BeOIjfJ
         HJGxHWiFKaJrEPQQnJwrIp3hsBWv5/AM2Y5R4Efdd+7d97rObSKZMy9AWfWmDn08uDzt
         R5Fg==
X-Gm-Message-State: AOJu0YzQiKnVw8mZ0sROO7wDhP/OA4fdXKo2B/IuP/Eq3rYm4ws7NU3J
	DRhcobnsZsb42MCiUIIhA25t0IqUo8Bc1KaLvEjY50om3woK/rW8RHPdEZP/Kg==
X-Google-Smtp-Source: AGHT+IFBwVhdUgX1a4V9IkrHPJbXc4eUMoGOUChnuw8uN0gNsB5+cEfWE7LrqbCZh4VflZE0Y9a0wA==
X-Received: by 2002:a05:622a:a13:b0:44f:ea67:1012 with SMTP id d75a77b69052e-45374207271mr54412991cf.13.1723843760676;
        Fri, 16 Aug 2024 14:29:20 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd72aasm20752221cf.9.2024.08.16.14.29.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 14:29:20 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org,
	helgaas@kernel.org,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 8/9] bnxt_en: Allocate the max bp->irq_tbl size for dynamic msix allocation
Date: Fri, 16 Aug 2024 14:28:31 -0700
Message-ID: <20240816212832.185379-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240816212832.185379-1-michael.chan@broadcom.com>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If dynamic MSIX allocation is supported, additional MSIX can be
allocated at run-time without reinitializing the existing MSIX entries.
The first step to support this dynamic scheme is to allocate a large
enough bp->irq_tbl if dynamic allocation is supported.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Fix typo in changelog
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5d0d40d78c37..b969ace6b4d1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10724,7 +10724,7 @@ static int bnxt_get_num_msix(struct bnxt *bp)
 
 static int bnxt_init_int_mode(struct bnxt *bp)
 {
-	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp;
+	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp, tbl_size;
 
 	total_vecs = bnxt_get_num_msix(bp);
 	max = bnxt_get_max_func_irqs(bp);
@@ -10745,7 +10745,10 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 		goto msix_setup_exit;
 	}
 
-	bp->irq_tbl = kcalloc(total_vecs, sizeof(struct bnxt_irq), GFP_KERNEL);
+	tbl_size = total_vecs;
+	if (pci_msix_can_alloc_dyn(bp->pdev))
+		tbl_size = max;
+	bp->irq_tbl = kcalloc(tbl_size, sizeof(struct bnxt_irq), GFP_KERNEL);
 	if (bp->irq_tbl) {
 		for (i = 0; i < total_vecs; i++)
 			bp->irq_tbl[i].vector = pci_irq_vector(bp->pdev, i);
-- 
2.30.1


