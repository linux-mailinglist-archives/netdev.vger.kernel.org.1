Return-Path: <netdev+bounces-182936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E9A8A602
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6B53A8945
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC82222D8;
	Tue, 15 Apr 2025 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gsf0URvi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A4222565
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739342; cv=none; b=cR76Uq5mxZA3u3zwxMBSIghjnrCBxtKAX6Y1CFKcs2VqGYmu4DiOAdVv3wmILVugbajnVRiOMUVh6AacTAEkdjkmIXetaxXisvfOoSvh0wcOtJQKiOTOevPGDEgS6StGJ5zbDG8CHVpmPkoizAQn03GNTrRp0E+UDWL6+7/8b5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739342; c=relaxed/simple;
	bh=SL9PCqtts6Mv/ggwdLxgp+QFbDaOWxeKY8izfswvdWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lw/E3F5+tDh26GwgX/FNUFYYDqfYkVm6A5VLwvSLm/Gv2P7VTn8lV725Fm3L2PtYv9fiygAQQ3zRAHR5d/nc5VCnDqHjxajTvjNjH7uixus/5r37M9VLHmGwKeHTVYUDWWPklc+OTLNxinHxr/ofJjhwn7A6tX+1fQwAqbI15+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gsf0URvi; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-603ff8e915aso1664930eaf.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744739340; x=1745344140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9yHAaw/uQvwxq1qnIfTLfjQQMXVxIDQXkvOd3fiXj0=;
        b=Gsf0URviHyvI3QOMC9qmKeLFboIDHF0UPasE9idihZ+Goiv5rDr5BV/mri8Zc19hrA
         T2GrQ+vfVbnpym+bZUE2oSNL22pi3WNZjAhmD8XISggi4Dmtiu6LWuhvhaFXts3ws60G
         S70Pfy1YzTHz6uucvpiPKW970xh9XicK1kRcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744739340; x=1745344140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9yHAaw/uQvwxq1qnIfTLfjQQMXVxIDQXkvOd3fiXj0=;
        b=MC6L+V6EYZkpuA+bmnCFhRM/QaPYIeGTielHQLh6nq8QJ6abk0UTC5BjjC82rO4xli
         2E80FEOF7ci3qWSLS15uVa1Wij48dhgSIkBtcAjbcGKaOrkA1rzXHcka9jtuwrxWKTUF
         lSLmuXR1VppIsp0SQfPPtGdlKBrKrizYivY5XpaT/Q2+VEs3DYw97XiFTHUR2GbsPGVb
         3CEsjvDnXDLXXm+F4a7XsPrc9liBeCUKumFCAYR/vrCnoQeGLZxM94eX30n27KAfI1+e
         GvTtRHeuTkCrUH23huiClA8j294GccgT89PI5XSb4al+RRRMyA13fq3/eA99nt5PnCgj
         gMRw==
X-Gm-Message-State: AOJu0YyCTrSJnQWVrVxIIclsL9XA/YyhR0/nie98/wORVP4HQX4FBR1S
	kppef3y35L33sV1uaCkHnTnNZ3S+0kLVH/kbRR6vT1JpKU3uvqmmg8nhdNRQzQ==
X-Gm-Gg: ASbGncthJQnIFsFItmawV52tfBGtEZ05wp5Rcla54l4+RZpZCCBpKxhSKMlhsVjO4y9
	8bkTdvKEZyiGwPo0Cg19ggjv9q6z2WOfmZPnboaDif106dFfcIN3FMz1xT6Azs/r/e7xvE2oUI+
	wBVrxgV1lxb6C9E556B+fiaCcYb34bHcFwrwRUEoCyb0uA0epiTY8+n1E/7FrBQtndFT9Uj3mYF
	563A+06uShvicY4+KSbOafVBjpQGxJVpjY8xSWetQMMa8Sc+ZIRlzRoWgS3XcJpjszcLG0ztqQz
	30B1pirkSq7eyINreB+xG+SyNzEuS2odZKLl5u09JpVZ6ZvyMSgO54MWaSW8/VmW1LhMUxybRZg
	7jeIBbKzexwXfCCn0
X-Google-Smtp-Source: AGHT+IH6Gn0nrpeLJUhAuDgJnOIsUCmYyuEvycwFjavQIGdYNEZ6u80kcGtns44BQgDCyHUEkCFjfA==
X-Received: by 2002:a05:6820:4c01:b0:604:4846:78a with SMTP id 006d021491bc7-6046f4dcea9mr9400318eaf.2.1744739340126;
        Tue, 15 Apr 2025 10:49:00 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6045f50ee87sm2457073eaf.7.2025.04.15.10.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:48:58 -0700 (PDT)
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
Subject: [PATCH net-next 3/4] bnxt_en: Remove unused field "ref_count" in struct bnxt_ulp
Date: Tue, 15 Apr 2025 10:48:17 -0700
Message-ID: <20250415174818.1088646-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250415174818.1088646-1-michael.chan@broadcom.com>
References: <20250415174818.1088646-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

The "ref_count" field in struct bnxt_ulp is unused after
commit a43c26fa2e6c ("RDMA/bnxt_re: Remove the sriov config callback").
So we can just remove it now.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 5 -----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index a8e930d5dbb0..238db9a1aebf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -148,7 +148,6 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 	struct net_device *dev = edev->net;
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_ulp *ulp;
-	int i = 0;
 
 	ulp = edev->ulp_tbl;
 	netdev_lock(dev);
@@ -164,10 +163,6 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 	synchronize_rcu();
 	ulp->max_async_event_id = 0;
 	ulp->async_events_bmap = NULL;
-	while (atomic_read(&ulp->ref_count) != 0 && i < 10) {
-		msleep(100);
-		i++;
-	}
 	mutex_unlock(&edev->en_dev_lock);
 	netdev_unlock(dev);
 	return;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 7fa3b8d1ebd2..f6b5efb5e775 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -50,7 +50,6 @@ struct bnxt_ulp {
 	unsigned long	*async_events_bmap;
 	u16		max_async_event_id;
 	u16		msix_requested;
-	atomic_t	ref_count;
 };
 
 struct bnxt_en_dev {
-- 
2.30.1


