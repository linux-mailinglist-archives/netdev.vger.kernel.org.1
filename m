Return-Path: <netdev+bounces-177963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508EFA733B4
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0AC17C1EB
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872E216396;
	Thu, 27 Mar 2025 13:57:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF8217F56
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083836; cv=none; b=fLrzBdt1xGmEW6FU7FHMCirfzMK6z8ssMokszwpOFkGU2OfGSoOtFCrd1/cYFJmN5OgorZSI40WIklnQJuPw4p58/PVtuVlxsf0twrV6EjktVzC5gseCm6RWhwnZeDDvgnWPf+7wDYXC+PMtZAlv1EGI6HLJKTXz7osey82lBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083836; c=relaxed/simple;
	bh=rycKGXFoqAeC5tPx/73rvy9De8EwBoLt/+IT2SfEVXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLEUwB/b6RUTAamDKQ/xD4cSlHcjPCSLESHOlygHc+g1NBUkOKL6m9MLwoizlCkL+L3G9103InWlvKKbP5O0sa8IflgVGDyLafiic3ekWDhcbdYnLsBEk4QwvnKPwcZiWk69yHyKKXHmYxG8Aa1qJ2aFe0afxFLIsD5AqvNkTdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso3276423a91.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083833; x=1743688633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aE5CppWR6I6v1fz3Mt2HH1HdiF5SrnQoNwkZhPjynWg=;
        b=YAn3Lwrh6A1Ut22innZeyYuegERvBBtBTA4jYKPsjvz2TViKgLSeMGkgKBfEp0ddua
         TiNlRC7ruN+nS49dWwjqE8zP7U3pC9FAJxAkn3oPwT0fEF2LobQAhroU7nbq3EQtfh1C
         A/a4SdPqv7ar24CeEVBP/SPxYdeOM2TdPFH4yv0N8z2ljdmSppbguZJ14yWKp+vCO/MF
         WiabjPlZJBLUcE2gVLcOx7aCXrN0Gb2cT6VU7GE+QYJIXhrhwyM5Obp7Lwl0lvCcvwZ9
         9tCrm/8TOlIEAQ9YSX1k5BqX0elNDuMM4Xy58vFz88osl4fojB4YVpRHXiP+0hr+6Bi4
         LyaA==
X-Gm-Message-State: AOJu0Yx4V1V9t85+rnQeXDFjL1PV0Ax4p192l8/AH8DP9l8lrYyN5hlK
	aWLK/5ObfBwP7f/Tt8D/kLK1QrbvbDHAW6l9dYU6J3mGkvA9qJgz190yAae6HQ==
X-Gm-Gg: ASbGncukWFf+wqgy8cmajoIRXkPEWAdj1+4Ucr66cpdZXAVCTsc5fCTuEw0TBNgKk/z
	oUHkDMDOaTETnKVXdVCt0b7nTVlO44Hmoq0lUskavCmuOWehitI3+c6WtZRq+lCOJymitwaWpDk
	XIx83s9bR82oQ3N7h+EAHRBGdqX6zFzmS+sjFtCHacgNe10SdlISL2AImPF6Q4Vjr21bTSd0hUu
	pSTTp/fg8CcqN89xSSNxWoPsSu6gbGZk5pzz0TucewJ4R2MMJxXMZN9THfxElE87qnEbInGt0Hu
	vkxk5NPAHT3XY3Dkb+YITRakkpGBeRGPEEAaES0Wo9dQ
X-Google-Smtp-Source: AGHT+IFptf22dZ+GwYUqkOeig0NbyZF2M1/LTtyae6cL703lhQmHjSqNbQZEofmIi5vZCinZlcKGjQ==
X-Received: by 2002:a17:90b:3bc4:b0:2fa:603e:905c with SMTP id 98e67ed59e1d1-3050bcdab54mr376346a91.2.1743083833174;
        Thu, 27 Mar 2025 06:57:13 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3039e60bfd6sm2197782a91.41.2025.03.27.06.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:12 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v2 09/11] net: designate XSK pool pointers in queues as "ops protected"
Date: Thu, 27 Mar 2025 06:56:57 -0700
Message-ID: <20250327135659.2057487-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Read accesses go via xsk_get_pool_from_qid(), the call coming
from the core and gve look safe (other "ops locked" drivers
don't support XSK).

Write accesses go via xsk_reg_pool_at_qid() and xsk_clear_pool_at_qid().
Former is already under the ops lock, latter needs to be locked when
coming from the workqueue via xp_clear_dev().

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h     | 1 +
 include/net/netdev_rx_queue.h | 6 +++---
 net/xdp/xsk_buff_pool.c       | 7 ++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b2b4e31806d5..b3d1c1922ec0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -688,6 +688,7 @@ struct netdev_queue {
 	/* Subordinate device that the queue has been assigned to */
 	struct net_device	*sb_dev;
 #ifdef CONFIG_XDP_SOCKETS
+	/* "ops protected", see comment about net_device::lock */
 	struct xsk_buff_pool    *pool;
 #endif
 
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index b2238b551dce..8cdcd138b33f 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -20,12 +20,12 @@ struct netdev_rx_queue {
 	struct net_device		*dev;
 	netdevice_tracker		dev_tracker;
 
+	/* All fields below are "ops protected",
+	 * see comment about net_device::lock
+	 */
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
 #endif
-	/* NAPI instance for the queue
-	 * "ops protected", see comment about net_device::lock
-	 */
 	struct napi_struct		*napi;
 	struct pp_memory_provider_params mp_params;
 } ____cacheline_aligned_in_smp;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 25a76c5ce0f1..c7e50fd86c6a 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -279,9 +279,14 @@ static void xp_release_deferred(struct work_struct *work)
 {
 	struct xsk_buff_pool *pool = container_of(work, struct xsk_buff_pool,
 						  work);
+	struct net_device *netdev = pool->netdev;
 
 	rtnl_lock();
-	xp_clear_dev(pool);
+	if (netdev) {
+		netdev_lock_ops(netdev);
+		xp_clear_dev(pool);
+		netdev_unlock_ops(netdev);
+	}
 	rtnl_unlock();
 
 	if (pool->fq) {
-- 
2.48.1


