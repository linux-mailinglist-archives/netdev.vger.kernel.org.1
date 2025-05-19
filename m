Return-Path: <netdev+bounces-191635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4163CABC892
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4803B8041
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E05219312;
	Mon, 19 May 2025 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MHxGZ48o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5521770A
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687410; cv=none; b=J6p3bH66YgCMC83SW0wlFU4xn8Dnyd5ZBnaIrfLx+jd2z3iBY8R36ZjdKiVQZ/p4xGzveX7kiNuI5jJMPy+JNDhGWxGA9ILcZ03jicVn7bQ3o0/tIZb05Ia5k83hlE0Ct6dwS9mygJU+AvgVlnaYqtVTmpN1BrqKFj+KL6c3wTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687410; c=relaxed/simple;
	bh=3hjPadwlL3PCgjsxZoLqYlIrnYAmc5mUyW0z7WgqEzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0/21rvCON1PrjNdPNZLTlMWEPuToN7snJ06UsvAnn37raKJ7pk5YD4hvHbJThTwhz2r5cn32WMUvOkyHSJGkrZChjsoYrCt3TpNmDTOQ+t8ytKjVVyNbO8cYYEIuNMqjy/b8vs7fjjAVwD709zQ6DdmjMTTMc5FxAAvjgiKXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MHxGZ48o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2321c38a948so21192525ad.2
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747687408; x=1748292208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HAvMqhHAQU0g9GLZUYKF6snwwfzBXZnPpy2x2Oz1do=;
        b=MHxGZ48oVD/6H8E/wdn+FRCD8/kGbfw78de37W5ss3itMzfe8oPwh0Wi8FfBzj6D3z
         iUl0Ah/HEu5LzQXot8mkre/Wgy4m5PnGvK8kkyMyALHecaUofmP/SlaMH0et2GzrfUF4
         xyb3t3FOTqEICn3WT4feSQfOz/dnG3BH2Yyrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747687408; x=1748292208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HAvMqhHAQU0g9GLZUYKF6snwwfzBXZnPpy2x2Oz1do=;
        b=jzzYv1NLxLJYOfK0flmISuNSjJ/eJN5tqT2U31zjpm3zCLET4R5Go2n7c0QqIa3OLf
         suMMD9fFf6TUr+g1eBo/EZytQn4+56MYEW1nOi7HzV4kUJrrygyLwfbCLKhtHRqNX7nz
         q0dYuYXfhMMsffTdENFvx4Fkf7r1hXfprk7nYKvFRBOYF2fIoPaLWRVSWr+hqBWxC+Ty
         gWkVyRfr9O1iS7y5clI6S/U8wc4d67Jt2aPlGwFCgdEwr7pwZiWXbeN+B7iNOcEZeroL
         eM7vjjmD+hAxh0JUJrpVYQxBUsINYpslCjJ4sOYUrgaUYL1zfzhxwfKb5QTpoDJ9QP2K
         07Qg==
X-Gm-Message-State: AOJu0YybJZCby+7gT/PHWUqzyqstgwOgUuNMyBkoQnspz3l61P6nJ+Rb
	dWpHjag54UcP91aO3rdNZ5CPg1TRfgInPbYjcIyLr1TdokX+g+M1xdj0+8vn3W60XQ==
X-Gm-Gg: ASbGncv05y65yx2US7POpf5f0GR17kN/s/keDNKoO4uGci9he2nUKZRWnNooxBCV5aQ
	ZeT5A0HMTd0CTrbOoinRKTmKAYe7DADg8i2376aFs9I57IGFSt9f8BqI9M29wejWijXulj64LNL
	vB/xPYTOMfp5FxIJb+Iz4SHNjyuhI0xQpSQTHd6bxLfOESnsJ2ivEPCgth7B/SdtCArecOwV/ra
	gdESEkz7Y3iXrGpQArhiMQNEPXs7oP1d6JIipwqv00YmZbaeWKLcrt9ETGGYctd0qk3So6aYfow
	lTSzg2I7cywwbL2CjNZTmIXdq0cCFEtfaONA9mwFL6q9HVAdDm9R+fhYiQCC4bYuaoIYH2yyTb1
	j72Yb613uP033KMrTVlx93IlJ9gM=
X-Google-Smtp-Source: AGHT+IFHWP6NgNFO68HL66MbV6kxN9tB7yIxdP345TaJQNw1ESD2MPmjLROgISr/9pUC/c0iweLi5Q==
X-Received: by 2002:a17:902:f551:b0:224:1ce1:a3f4 with SMTP id d9443c01a7336-231de35154fmr186455585ad.1.1747687408037;
        Mon, 19 May 2025 13:43:28 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe887sm64190955ad.88.2025.05.19.13.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:43:27 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net 1/3] bnxt_en: Fix netdev locking in ULP IRQ functions
Date: Mon, 19 May 2025 13:41:28 -0700
Message-ID: <20250519204130.3097027-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250519204130.3097027-1-michael.chan@broadcom.com>
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_lock is already held when calling bnxt_ulp_irq_stop() and
bnxt_ulp_irq_restart().  When converting rtnl_lock to netdev_lock,
the original code was rtnl_dereference() to indicate that rtnl_lock
was already held.  rcu_dereference_protected() is the correct
conversion after replacing rtnl_lock with netdev_lock.

Add a new helper netdev_lock_dereference() similar to
rtnl_dereference().

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 9 +++------
 include/net/netdev_lock.h                     | 3 +++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index a8e930d5dbb0..7564705d6478 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -20,6 +20,7 @@
 #include <asm/byteorder.h>
 #include <linux/bitmap.h>
 #include <linux/auxiliary_bus.h>
+#include <net/netdev_lock.h>
 
 #include "bnxt_hsi.h"
 #include "bnxt.h"
@@ -309,14 +310,12 @@ void bnxt_ulp_irq_stop(struct bnxt *bp)
 		if (!ulp->msix_requested)
 			return;
 
-		netdev_lock(bp->dev);
-		ops = rcu_dereference(ulp->ulp_ops);
+		ops = netdev_lock_dereference(ulp->ulp_ops, bp->dev);
 		if (!ops || !ops->ulp_irq_stop)
 			return;
 		if (test_bit(BNXT_STATE_FW_RESET_DET, &bp->state))
 			reset = true;
 		ops->ulp_irq_stop(ulp->handle, reset);
-		netdev_unlock(bp->dev);
 	}
 }
 
@@ -335,8 +334,7 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 		if (!ulp->msix_requested)
 			return;
 
-		netdev_lock(bp->dev);
-		ops = rcu_dereference(ulp->ulp_ops);
+		ops = netdev_lock_dereference(ulp->ulp_ops, bp->dev);
 		if (!ops || !ops->ulp_irq_restart)
 			return;
 
@@ -348,7 +346,6 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 			bnxt_fill_msix_vecs(bp, ent);
 		}
 		ops->ulp_irq_restart(ulp->handle, ent);
-		netdev_unlock(bp->dev);
 		kfree(ent);
 	}
 }
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index c316b551df8d..0ee5bc766810 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -98,6 +98,9 @@ static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				  &qdisc_xmit_lock_key);	\
 }
 
+#define netdev_lock_dereference(p, dev)				\
+	rcu_dereference_protected(p, lockdep_is_held(&(dev)->lock))
+
 int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 		       void *ptr);
 
-- 
2.30.1


