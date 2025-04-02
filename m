Return-Path: <netdev+bounces-178805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E308A78FF1
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987ED3B31A3
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9926C23E356;
	Wed,  2 Apr 2025 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrRqlp7y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B2523E33D
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600695; cv=none; b=SeuHilM/fAYBa1KHcMqNNpuojpo5zzD742LUD+sncQlsUy8s9OermYSFyJjv06PIHcyw3crCmo1bgpHdbIqK9b0EzGbg8NKgC3KzxyoXSVzX0yZRCFamke2FVbjqwR0LWzCsbGDyIEKbHkaLji+a6TLO/ZwNMSyKjIaQ+5tBGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600695; c=relaxed/simple;
	bh=yDZR42HPk5t3XGlaii4rSo5H0OlJoJuB3EG4zKua9x4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jNU9hA6frx2tX9tnBLxqwgv8PoA1epBICZ7HTsDhX87im8LfQHwV9ZcuLt0g01rMr66UMQv26DX2+0uC9V6sKK7JRx2WhSMv+QL9kwMAoFNBTuUXxKkGleZLqJoBh7GWNJihkkA36fuLBb0E/9NUD05JyB90+54VjHjYgvR190Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrRqlp7y; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3014678689aso9364273a91.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743600693; x=1744205493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJp2HmO6VR7nnxE0K3ARZ/Z/D8XXT78jfcbISS4FFAo=;
        b=hrRqlp7yDRUCRwPRnlcxQr3ddUQLzJzFRPlXFC61IWdC3GJoxVVojj8m0cPrzZUNRl
         nNB/BDWmd/MALjnYQJ02mq+T0dFbucQMXykInZbnPp5NSVzjVcLlh4G0fuCDTIRBrD+C
         qRU8gLk/SCWoZ7+YzEbuWRAsfSQYKWj1rdUZ433jhiLcAFaapL1W8jza0dvFSggHdYe+
         VfM6E244seiCos7qahcCjc3G2fIbwY0e7vs51BQbYzP6ty+bl6QKg9Kf9k/fyYdgT99U
         7M3WpE4krx4BVMX+PyRAUwACgIAi3Qjkc/pifgX601BrMHECaYHeP/07WwILspEl8TKj
         AtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743600693; x=1744205493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJp2HmO6VR7nnxE0K3ARZ/Z/D8XXT78jfcbISS4FFAo=;
        b=FET6XCCb9AK1j2B+9GGyT05eiiy08OE0KWfjijH3T8biNw5QuQNStxvWwKlCUtgjUS
         /iuFWlp39Z4sz4QFtfFRdxIWSnYZUaZW5KWnAACjK25hJB6id2K7CDvKUF+GH8XoiQDf
         pzkz7ApO2skmpi4n0fyhob9NifeUVS8xDhMxsBp0y7afWNd4f1b6kQlmBxuPZVez1wKS
         1hOdvr7sac3+0bsg5U7JvA+VrWOBZOh22ZJ7pnjs9oq93LLjsXLXpR9FfRqQZWBf8qRT
         mXFFf+DnaPbrkMDFKvioOF4EpDmXsQ1wZ0+33bTectJXYsuorESq60rKWNecJG5cYJXL
         YrkA==
X-Forwarded-Encrypted: i=1; AJvYcCW68Uec8VHsoX7g/4wL99hwAULToHyJwLHzCFIDpVzMlr6QKrRyu8+tNKoSBile5+uzTM6Dlx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwrDBCJTXLpAefL8T+Ac4pwaqKQIirkAM1J8GhG1bUuSixfqA
	oC5KLW22ctgu+cM+8UHru/v7RzmnNhUoVfIjGWxqKb/7PZTT3OKA
X-Gm-Gg: ASbGncuJhmXGK9XL/oC+2DJk1J8IotSIwlH+YMzPJobxjC0TMTKZuEs2xNcCKW0qVsE
	EYdxp2h4SfUFXk7iNzEjh0NvZU7dtKS4d34G+hLaLSy/PdkMcJsokVfv0WLCOU3pVSbcjgLr2CC
	ZpCsYxQtiskXC+Vroud1vgjps3oZUzmAWeeITHJTPndxamURklmTDkF+a4ptG7sr4Olg1yj+5AY
	qUIRG/jiMyY+2JibHoEArJ/1C0UKsCN0CDwRwWQnKPl5IeqqwXfMvC3f4MjsM/eN4/4g/qYPBh/
	PZWudg8hTK+DdeKSAdHg4AfYB7BCbc1zUA==
X-Google-Smtp-Source: AGHT+IHgM+0i26O/qXHsn7EVkX+rwjcOfxRmKNgrjtCu/YN0o6QNIo0WumuQAm/+LNYI3QRurMsA6Q==
X-Received: by 2002:a17:90b:2ed0:b0:301:1d9f:4ba2 with SMTP id 98e67ed59e1d1-3053214bcfcmr25126521a91.28.1743600692920;
        Wed, 02 Apr 2025 06:31:32 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3056f8d5f06sm1541580a91.42.2025.04.02.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 06:31:32 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	romieu@fr.zoreil.com,
	kuniyu@amazon.com
Subject: [PATCH net] eth: bnxt: fix deadlock in the mgmt_ops
Date: Wed,  2 Apr 2025 13:31:23 +0000
Message-Id: <20250402133123.840173-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When queue is being reset, callbacks of mgmt_ops are called by
netdev_nl_bind_rx_doit().
The netdev_nl_bind_rx_doit() first acquires netdev_lock() and then calls
callbacks.
So, mgmt_ops callbacks should not acquire netdev_lock() internaly.

The bnxt_queue_{start | stop}() calls napi_{enable | disable}() but they
internally acquire netdev_lock().
So, deadlock occurs.

To avoid deadlock, napi_{enable | disable}_locked() should be used
instead.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1a70605fad38..28ee12186c37 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15909,7 +15909,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 			goto err_reset;
 	}
 
-	napi_enable(&bnapi->napi);
+	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
 	for (i = 0; i < bp->nr_vnics; i++) {
@@ -15931,7 +15931,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 err_reset:
 	netdev_err(bp->dev, "Unexpected HWRM error during queue start rc: %d\n",
 		   rc);
-	napi_enable(&bnapi->napi);
+	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
 	bnxt_reset_task(bp, true);
 	return rc;
@@ -15971,7 +15971,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	 * completion is handled in NAPI to guarantee no more DMA on that ring
 	 * after seeing the completion.
 	 */
-	napi_disable(&bnapi->napi);
+	napi_disable_locked(&bnapi->napi);
 
 	if (bp->tph_mode) {
 		bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
-- 
2.34.1


