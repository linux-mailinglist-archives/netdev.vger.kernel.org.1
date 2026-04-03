Return-Path: <netdev+bounces-275268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCFqETtI0Glu5gYAu9opvQ
	(envelope-from <netdev+bounces-275268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:07:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C12F398EDE
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC62B300A253
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55152389E1F;
	Fri,  3 Apr 2026 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da8e4PIV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039238A703
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257645; cv=none; b=CERjSzqhVEQvRvc23dkl8hnAYFpCXvSYfxwn6xheCq8Ftrv0zROmYnrhY8QjK3IPtdWPnFunW2gddqoNMWnjJHnU3lxAcbAh1fW31HTbtaskTABKDUVYj5vYPBLtbOS78BMdjh8KiGFcPYkqifptKlSmPYejz2QJn4/nad6PTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257645; c=relaxed/simple;
	bh=6XTjPc1Lb1fLIVViZE6tdIzfmgnICDpV2y3bO3Ij+cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua1E9M98K6U2B9Qii59HAHMVduL1KdYNgbWFnEkUKl8si+Md67jRYMFAfk+TX2Q7arSJHxo0TMmxYr1tvGvlbNx1u5pqWQV+2/IwVw9qaNL5LFFpLQCnt3IK/eaUbcL/4rnK/Du4FpMIHiWevyvq/ApnBTjG1ZPmqPGRT10TsXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da8e4PIV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso2273212f8f.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 16:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775257641; x=1775862441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOEofDb75q5DY4mpfrtmz9omvpmNusDfp4+owj8UO2I=;
        b=da8e4PIVnCwmwSTT/jl6K36s9yumduItM3wWLz2KwqoHEJ2K4Q0/gZBNbEMFfuBSYn
         ZKXRy0feNjWR/wXq5DncIeG/+94WeYDhgOgPwIPq34ZgkVT/9JLgfUiUnKJ+5AWqvXmm
         zJTNExZdGOGUF+Ef5RjpFk6TdquITTE0PV3dSmUptRY4uQouX3L//wEL/ghiUtkiLgtJ
         husDtx+n6XMq5id4VVVunWJXXaY0Aby4DlrFjOrYnd3gXzQ45z4xdNJP3UUuWGY4IihM
         NJaw/nJrLPynqtXm0b2arh9UA49sgA9yBr0EQdkrXqzxGxNoH0OO0vPkkQiMDZxPWHbW
         DQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257641; x=1775862441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOEofDb75q5DY4mpfrtmz9omvpmNusDfp4+owj8UO2I=;
        b=PdDo29lmwgKnas/C/EdYazfbRtLnV52vl9qI+J7VwnAk1yUt54tFZNcAWXZmtQJb9m
         aP7sXO1Z/dQoNNcWSUGGc715lXEuxZ3ey+aJPLAtvSMiWcx2SR8s5GDiF0NZp0rmAPO1
         kwdPmxR0M6801yn4q7zEd6W2agwwFCDy4c3Tb+aLbQ3syyWsTmllS/gy9mR+nGB9bT7N
         8jeWfqGLrZGxHJaaIzlILsMXIb+kp1OvfAnS+YmC2+dO7MFkPZ+ciXw7oaAm5ZbIknbg
         Yh8ak1rquyIeBObloDYhtp9fNPzurKvcDMi8pKG0f09KJf/5Elz+HiPTaOUbReZLSvQz
         jF9A==
X-Forwarded-Encrypted: i=1; AJvYcCUsexI0pk51g+oiAEC8yMyhxvevdjYxnVf4j/zzD3MBhpzFjNuBxthWl8+keF3O4AoJNfl6z6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5qSF3GAKq/7jnYX+4aKq/mCwprjC9037Qa5XYQ7ulaSzbMeB
	EH2zplcWChLKaJ41AcSHLSjuYHb3efuc57Q9fO+kV/o0mFOLS2WhgbH1
X-Gm-Gg: AeBDieu9RhOxUIl6p4MTyKqhDSAMRDlsPBWJLVWO4rZIgR5AXHI4JEK3k3tNvromQre
	k6GgIbPE/vVVE/Ol1UPXeImhJZZH1Yk+Omh+fiQnyT3AmC60ixhDVQujdMHGbg3zGp8nJ/PpmAb
	44WRofqbK1YycgeyGyg3OAPnUu7GhoL26yaWkVCcRgvDF5AEEghN+8wMPmDLOXXvkiN9xqP1IM6
	RGaON7c6X03jUS8SKZ7aBSmeD4tsl0jMgxnl3oEfsGsKwjnKgCH46nTukiOsDKMKR5jt6hXp+Mm
	x1IK09EA7ZYZlWt/uOn2xVHcmc5Ltg6g+9jdo3YX9fBdBlSZ0KogsSrfUViNRJyrYGRmxuIkjUY
	23G/ILo3QK3rqoEDvoZ8tlIBb7Ubnc4Fw5HOAp5v1czo7mFCKKj9RPIytYx679N4JA1rUoXUAVW
	mAjX0GsTihlnaVArIa4AzLTAQGxv3+ZInQbvM6gGmQ5HqZdVcz+5Vw3g19P0da7KfJzVWimA3hU
	GcvQtbYuXAx
X-Received: by 2002:a5d:588c:0:b0:43c:fbde:310f with SMTP id ffacd0b85a97d-43d292e40bfmr7213997f8f.36.1775257641423;
        Fri, 03 Apr 2026 16:07:21 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c60a2sm18830924f8f.10.2026.04.03.16.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:07:21 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2 2/3] net: lan966x: fix page pool and resources leak in error paths
Date: Sat,  4 Apr 2026 00:07:13 +0100
Message-ID: <20260403230714.10667-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403230714.10667-1-devnexen@gmail.com>
References: <20260403230714.10667-1-devnexen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275268-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C12F398EDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

lan966x_fdma_rx_alloc() creates a page pool but does not destroy it if
the subsequent fdma_alloc_coherent() call fails, leaking the pool and
leaving a dangling pointer in rx->page_pool.

Similarly, lan966x_fdma_init() frees the coherent DMA memory when
lan966x_fdma_tx_alloc() fails but does not destroy the page pool that
was successfully created by lan966x_fdma_rx_alloc(), leaking it.

Add the missing page_pool_destroy() calls in both error paths and
NULL-out rx->page_pool after destruction to avoid a dangling pointer.

Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 34bbcae2f068..b985ce64bb50 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -120,8 +120,11 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 		return PTR_ERR(rx->page_pool);
 
 	err = fdma_alloc_coherent(lan966x->dev, fdma);
-	if (err)
+	if (err) {
+		page_pool_destroy(rx->page_pool);
+		rx->page_pool = NULL;
 		return err;
+	}
 
 	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
 		       FDMA_DCB_STATUS_INTR);
@@ -958,6 +961,7 @@ int lan966x_fdma_init(struct lan966x *lan966x)
 	err = lan966x_fdma_tx_alloc(&lan966x->tx);
 	if (err) {
 		fdma_free_coherent(lan966x->dev, &lan966x->rx.fdma);
+		page_pool_destroy(lan966x->rx.page_pool);
 		return err;
 	}
 
-- 
2.53.0


