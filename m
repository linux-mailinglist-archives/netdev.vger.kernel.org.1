Return-Path: <netdev+bounces-183859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAFEA923EC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1452819E82A2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B5D2561A9;
	Thu, 17 Apr 2025 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RHJLbwtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94626255258
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910734; cv=none; b=hampoX4g5tCk4gywaNgqo3jZjHmpb25KqVLvfKXHYi7mXj/X44uP/hy2Gw3Ps8KlU/KFWQNtRh1zhAcJH0vol66eJ88lrrEZaQDq7qXvPhcEWkXhxWoHIswhsT8FZCxjwVtgRAjdOuMH0hn5L7KQYM1Hzj27KNuRq027UF68SV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910734; c=relaxed/simple;
	bh=SL9PCqtts6Mv/ggwdLxgp+QFbDaOWxeKY8izfswvdWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piFWFbnvjIX4Jq2cbfIDDT6nqPppt8gJ7NQjVdd9NPVbuOXuxyaz1XIlUbmWAn9fxJoIUP5ibwOm4UV+7egZW8lRgmZIax9wMFO9S4I0im+qbEYm4GojtEFDfxi72P91uibRBb7W1DYz/v1RaR2pxY0GPvElui4C7NUQDxMTLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RHJLbwtq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73712952e1cso1109448b3a.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744910732; x=1745515532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9yHAaw/uQvwxq1qnIfTLfjQQMXVxIDQXkvOd3fiXj0=;
        b=RHJLbwtq/SyF0ZOturZ+9AkjRbFHzEEKFlZ2QZrNFFIjA585/yW+UOwvnIfTtbVLCw
         kvGQk1U3y8B83sWoWE2xhrKVOFiJN0i4tQi7f9hEdRJ82aoS32JOiOoaTsWXx9G30ehx
         gaAAJFDRkkEa80jyaxkPto9A1ssBQDRrfLY7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910732; x=1745515532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9yHAaw/uQvwxq1qnIfTLfjQQMXVxIDQXkvOd3fiXj0=;
        b=nyGrEv6X/KapUkwZzvQMP60YPLSfsy8nvE93STuH65RSWNw/VkvJlilw984SMz+EZ6
         CDNB8Dn3TP8IzfvM47/t8PMKMhJIDukTMlVSqH9LppfBcUn+GqShkUlR5wZFCi5A2DpC
         Kk6O2+rjS0lC33srcb4jcMqQfp85sCqYT9enwSM3SGhyEYNrikk9XT8GXMlXUIYXcxMT
         gVdRWr8mXl6Smf+5qUwBTsIiEwE8W4c9rjGTo4SRFk5RhLqxoZAFx9M6t34F3mwjPBVM
         XCJZL3DeiFJUckI+8gYOKU4ElmLH9g+iUdtV7oiuJtGKZ/Pbzez/6jrSAVD6VqAg1UvI
         EZAw==
X-Gm-Message-State: AOJu0YwlADvQG7q8GG+x7nrxMpcq927qh42vbu6GkNgnd7I3RFq5zw+Y
	dFkEKyD9UnfkvKtVC9eCjF31Wpr9c677uECC2go558xOFOvfJBMldV5KWJ1ZmA==
X-Gm-Gg: ASbGncvZAp0aruFagDUBXf2R91VGLfEW5LJY4pMaSN58OfJ2jzqytzytOgqAqKymmIK
	KmTLrspOXn/YKHimQ8C+YGPHZOLS/WYSURlCwozYUT6IobF+bZdVfpA3TGeh7wq6Fjk3jNhbDe7
	XXtLgkTV0ldK5BiKOFaJavKObhMFWq1XZ3g73eDNjIgM06L+ZSHxlcZSI6gtozzGAhxFVRuql0e
	wrDrjhUOzqMjzGJ2bs5gNUOoda+mNrWrqInDE8zsQV100tJM2Wd6S0/ZsY+lBXS44gLM9/C3te9
	V1biWAk9hC9DyNjEL31X4Bb5TC7kq2ef1piHKb/tQ7JIXn0Pe9lOm0vxVfON8mNpFqw9oB7pdt+
	j+zOuy9Yvr4pQWro1
X-Google-Smtp-Source: AGHT+IFk4jwFBrsca8R3CXEMJkJTSj6F8Gn3J/VDBrkNzWEknghynyJIy32lhDgsZmMsXbsoOojVXw==
X-Received: by 2002:a05:6a00:23c1:b0:730:9502:d564 with SMTP id d2e1a72fcca58-73c2672479bmr8908636b3a.14.1744910731723;
        Thu, 17 Apr 2025 10:25:31 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8ea9a4sm109879b3a.41.2025.04.17.10.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:25:31 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/4] bnxt_en: Remove unused field "ref_count" in struct bnxt_ulp
Date: Thu, 17 Apr 2025 10:24:47 -0700
Message-ID: <20250417172448.1206107-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250417172448.1206107-1-michael.chan@broadcom.com>
References: <20250417172448.1206107-1-michael.chan@broadcom.com>
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


