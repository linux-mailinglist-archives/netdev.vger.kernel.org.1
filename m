Return-Path: <netdev+bounces-278710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MGxLCFM32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:28:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0866401F42
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B5AC303650B
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE53D410D;
	Wed, 15 Apr 2026 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be3d7lCg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC53AEF53
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241689; cv=none; b=D3ZZNHNnYLpMAycbVMA8txwmPeTiJ5VXPzHVPVWsgp16Kca3prSwAdozkpyojOklGVB4qpWfUaU3inxIGEVdIGXi9AL/tIi7ZdLnNeMUZYhDT/DQQaB4TZK5spLMUXEv1zFbNhn0Z4VPqh4i6KLFMc1VTz21/TckAAOwUmwcDYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241689; c=relaxed/simple;
	bh=mfGH8PXsgNGoAUVak2QkX9SmpnxShRY1KKH0A84oZTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fm+bGW84LKGBSsN+IV+USK4HHp0DQ2ttKjHHcXSy2UuyKh5Ag4nPCmu03wPuBubAqbV1Uj85RPsnXsKSthibjLNvvomLs2N5o4gEfCvtAuklWu/Tc3fr8yywN6i8FF9by1s79m+sID9bUiJK/IEjxWK6DqD4a6lWkBu0HiL3Aeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be3d7lCg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so43473355ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241688; x=1776846488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z76sQ1pIrwnQrnT/9DZ6xoWkdfsEI4At+20OGeyJlFw=;
        b=Be3d7lCgmuC7a03gDDnjsknYdnjtRbsTTUXyJ2EeNX2YipTgl5AyFnvvfIvztLvd/Y
         xTGWm7L3s4J7Ijew2KMzmaZI0IdONp1bUdZDvgDKuX59uowyELKx8Wz8n1AmmdJ1uRK2
         P+clLG5z+WJh+2MY0V9V3rOkzSZlj/AuX+LhX4NBL0xUuIZMVH01Y+cf59Pej2GO3ujd
         np6T9gHLXEuuxJzps9bme9KYC4ONF62vnCv1RqYWsINWiVvfT6/Vr8cYnWsHqIWimWg8
         BdpVuXoYWz/iJ43FwSXE9OSNAV4UsQGTQMb9tqBPdYr5rnb1tKIACbwV+FivoKofRpvw
         7sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241688; x=1776846488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z76sQ1pIrwnQrnT/9DZ6xoWkdfsEI4At+20OGeyJlFw=;
        b=kmcBhFlWc7Wm8JKjySI/xeFhYesMN4zRYVQElxRkWt53oJMBt6JE7Q3cm6AOmM1W2D
         xWOQ3h01G5obkfvxv4YV5ZnWXKJp01ZTz8bf+vFVtwg6fRFJCrrgrT+H3+p2AnNz+VrD
         9RnFNIBPTA8xTYhojPaqVEd2mR1fG78fvn6wPxlBdhcteOPkPEKkcCZgMk6Hbxcq+RW0
         pxS05QfG0EjvB/fN0oIVdpat9ErzES50xtRDxUNY0YOrUabVTD0+In86zMKVO9ZuV3L3
         Qz7GqDe6/Uui4q1/QnrwtFnzs50ubgpeNFi2RaLYCnZGU5rZGbo9Qeu2gb98MwgW2uPZ
         yGJw==
X-Forwarded-Encrypted: i=1; AFNElJ9/prQZAL/8xZbsQSfw6cp6lv+CPGipN6r1V8oY2Xbx+yQdGqJP04UjvOWWwWNOoxp20Xm+wtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4r8ocQz8DIH0ZljJRvMUhsyrszC0suUOZlVozXazD08rX7td
	n6BwXrXER1ZR0XtCQMpYOTXN0CDrP6/PSljigv/7bqgqntWOw4VoLsp6
X-Gm-Gg: AeBDieuA4fPjhfyXroFwQAgh0IadnwJ4Y5IaKywOwLr0GsSGcyhSjhZe12PKvX3IUDf
	/CiXkQj1YhSa6kOLO4tYOWkmRixd3OdtOVf8HUMHuvBSvw19/2YGY1kVp4lXODAZDIk8dcpQyra
	3XxcZr4fIEDDRRmXiu0i0Gd9uHn41ZD+NzKgV4j2XSeta6ozHvN1MWUPmoC51svldi5Wqp0jL3w
	/E3DDNnoJZBfl7GrE9aHaL3yfwjkldbgj+9i6bUeZiuvWqDX92AJC8TuHiPlX0hIYI5qJoJMltv
	0K4Fc0zYBNnZf8l+KIE3DZv30u2JmHPzq1ph3vVZmU7kS8aDpWqKAdCTmOKUHSFbrn29f8CltcH
	1qN4y6NpnoUmeKarOW0xpMbgA/++ACCC4jLlA3C7k/Ka9g+1rP5+AWLofX1/28GcelxiDp9PHPg
	6d+FZ2ch0BLigC9nj4bYCZQYY+7BV80eI5iTVu3oMDepO0TlU7bvS94H0MFBKZCoJKUypujpSY0
	fK1Eu2W
X-Received: by 2002:a17:903:2596:b0:2b0:9101:1b77 with SMTP id d9443c01a7336-2b2d5965babmr136700755ad.17.1776241688093;
        Wed, 15 Apr 2026 01:28:08 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:28:07 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 10/14] xsk: extend xsk_cq_reserve_locked() to reserve n slots
Date: Wed, 15 Apr 2026 16:26:50 +0800
Message-Id: <20260415082654.21026-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278710-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A0866401F42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Previously it only reserves one slot. The patch extends it to n to cover
the batch mode.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c       | 12 ++++++++----
 net/xdp/xsk_queue.h | 12 +++++++-----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6cd2e58e170c..c26e26cb4dda 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -546,12 +546,17 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
+/* The function tries to reserve as many descs as possible. If there
+ * is no single slot to allocate, return zero. Otherwise, return how
+ * many slots are available, even though it might stop reserving at
+ * certain point.
+ */
+static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	int ret;
 
 	spin_lock(&pool->cq->cq_cached_prod_lock);
-	ret = xskq_prod_reserve(pool->cq);
+	ret = xskq_prod_reserve(pool->cq, n);
 	spin_unlock(&pool->cq->cq_cached_prod_lock);
 
 	return ret;
@@ -947,8 +952,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_locked(xs->pool);
-		if (err) {
+		if (!xsk_cq_reserve_locked(xs->pool, 1)) {
 			err = -EAGAIN;
 			goto out;
 		}
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 354f6fe86893..34cc07d6115e 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -413,14 +413,16 @@ static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
 	q->cached_prod -= cnt;
 }
 
-static inline int xskq_prod_reserve(struct xsk_queue *q)
+static inline int xskq_prod_reserve(struct xsk_queue *q, u32 n)
 {
-	if (xskq_prod_is_full(q))
-		return -ENOSPC;
+	u32 nr_free = xskq_prod_nb_free(q, n);
+
+	if (!nr_free)
+		return 0;
 
 	/* A, matches D */
-	q->cached_prod++;
-	return 0;
+	q->cached_prod += nr_free;
+	return nr_free;
 }
 
 static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
-- 
2.41.3


