Return-Path: <netdev+bounces-216577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31781B34989
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA95C2A617A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC4C30AAB0;
	Mon, 25 Aug 2025 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A4Jm63Ih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D45309DC4
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144809; cv=none; b=kRoulE71vBLvm10xT4OHld14azfwuGPQEgHTFtNEaLf9Uke828EdE18myzLcEl9qU2n3W4TTpdJTg/mdqCbXBKLEOUtrrrjcCh3yPrRZUqmP57C9K8bSyuEGgSf079PVHGTdMUwVqGTtQ/hC3DoT0YXev7dvH0c5ZN4VNA5hbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144809; c=relaxed/simple;
	bh=YdDI80dN3zJRi78PNrVEmad28zLV1yKcuAR5e5nSv8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAfBApJzXuZEv1rrPq8WQEGIpo1zHyWD4xhzKu20JGQHgZ06NrQonWkCHzMRPh1zgqYvsaBshJxK+UaJaA0HVyGaK1pnu0JU6bW+ps0QX7HeP4W6opsJIOhQRvvjxgSHs1XcsA6fC+Lz8nSm4i6eLOmjA+/C0Nmd/xOPSCkc9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A4Jm63Ih; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so4428588b3a.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144807; x=1756749607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUjmk3ILmi/3BT07nMra0hBjLzFKOui17RVJzVWPl0U=;
        b=go6uvvWf6RNN7sHYT5CVSaCBveHX4qDxRhqD3zWKoSj8eViv7rNv5Ykr45yyN+W+H6
         rYQ6AtuScMJkLCFqubAYatQjG/pBJKETMyqkLo9aifLoZdFcc9dbVqx2lRYQU7QPjSTC
         66ONhHxlv4ki+1DKglIM50GcIck4A/BLLkDvX2XTlROi+D+LMhQ+mIyUg1vONNB99cbX
         Lu/7e7sMRC2zzJEvIHStAolW4HS0XFX6lrUwOgYhxUbsy8E5foGXqlX2piTPiTyjt+Lh
         iQ55U86+rXd0zYLi16OjjgdATN5Pr5j1lN+tlpwurFQi5fwYKdOlRaZqyIeMkj+3Qk/N
         Kpow==
X-Gm-Message-State: AOJu0YzZhKVv+GvFGDVO2EzNQttWqjKER4VpfnNSh8YI1Hv06JkfCqUV
	7NdLPJBNbJPX3+FcronSGq7dpZomv6+5aD8MKPBNGK+coDoPO9F20/18vIueOuATOxDSu8JpMMi
	4KuHxXE487uzwHrK4507ERaFpAFjoMGmEuXLzPg/snOwpg/ukiuNvzs/LBLSIJceAnLSCaak3Lk
	qkyb2d57+uzWqivE24ixvq8haX/w6j6C5cNRKfWx1rI7gW/rbcz3AUmrCdbcyq0Q9qQYJKc7OBH
	ooaFKmlwcw=
X-Gm-Gg: ASbGncunAITbuUbFv87MfbDnCvpfCFjj+y/a8tlJ71auq6PoY2qWqDTWwyydf0aVwLa
	EM39qQ1WJQaWlLZZGu64QGunjhz/iM2OtlQlzwm8ZKGQl+0rkkTZzc7KdQlCJxhAUYRfegkH1Qj
	94VVA21wk6kVA2Z34m4vEPYIplXyLmyzKhOBF2YXdmyz3JAz7ycueDxNOTgcHAhqbYSu71I2FSN
	EG62PCqE66D/I2MVGz3hvYoxxTAKRFf6dbbIl04tN+NWrQWxy4lOqwUq6Ol0qUPqc1SK3VMrR1t
	TWtxivVzG587qilC0Nod3JhrA3dZiY8lHF3mSpTxoLYz3K24hgasBRvC00ThUj063FY5u3kkVCh
	y/eM1u6nv+i9EQCeIs7QBBvxs9vLDHHQmE0Fyu9hUGB9NknMHS2I4o1DN3k8izj8j9nfAlhnIEs
	Y=
X-Google-Smtp-Source: AGHT+IF39b/5IBX7q25o0YNluchQDhTV1D/jWWr8IuniBN6yTCDW/mDQkw/9nuWL4hkr7eq8Vy0amJ8d6IjJ
X-Received: by 2002:a05:6a20:3ca5:b0:222:ca3f:199 with SMTP id adf61e73a8af0-2438783c8ccmr551015637.18.1756144806730;
        Mon, 25 Aug 2025 11:00:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3254af5964esm604405a91.6.2025.08.25.11.00.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 11:00:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b0fa8190d4so143118341cf.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756144805; x=1756749605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUjmk3ILmi/3BT07nMra0hBjLzFKOui17RVJzVWPl0U=;
        b=A4Jm63IhqnhdQZU6AUKb+oD4PNi7lrHPGtV4KJikeqgUFF5iIrwskgvWN1obVgPqfX
         FZ7svx5ePVZJZVdX2b0YI5y9HVjZ7HC4nA9Y8iZfiMEmQ/n0Id8j56wgRvs+ZKtZndRk
         ntig7dfeB+/QHEnJ8AGcSLham7Q+g2chPdTXA=
X-Received: by 2002:ac8:5701:0:b0:4af:bfd:82bf with SMTP id d75a77b69052e-4b2e097cb21mr6246731cf.17.1756144805287;
        Mon, 25 Aug 2025 11:00:05 -0700 (PDT)
X-Received: by 2002:ac8:5701:0:b0:4af:bfd:82bf with SMTP id d75a77b69052e-4b2e097cb21mr6246171cf.17.1756144804639;
        Mon, 25 Aug 2025 11:00:04 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf36e7640sm527498585a.59.2025.08.25.11.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:00:04 -0700 (PDT)
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
Subject: [PATCH net 3/3] bnxt_en: Fix stats context reservation logic
Date: Mon, 25 Aug 2025 10:59:27 -0700
Message-ID: <20250825175927.459987-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250825175927.459987-1-michael.chan@broadcom.com>
References: <20250825175927.459987-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The HW resource reservation logic allows the L2 driver to use the
RoCE resources if the RoCE driver is not registered.  When calculating
the stats contexts available for L2, we should not blindly subtract
the stats contexts reserved for RoCE unless the RoCE driver is
registered.  This bug may cause the L2 rings to be less than the
number requested when we are close to running out of stats contexts.

Fixes: 2e4592dc9bee ("bnxt_en: Change MSIX/NQs allocation policy")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 86fc9d340dab..31e3d825b4bc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8016,7 +8016,8 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	}
 	rx_rings = min_t(int, rx_rings, hwr.grp);
 	hwr.cp = min_t(int, hwr.cp, bp->cp_nr_rings);
-	if (hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
+	if (bnxt_ulp_registered(bp->edev) &&
+	    hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
 		hwr.stat -= bnxt_get_ulp_stat_ctxs(bp);
 	hwr.cp = min_t(int, hwr.cp, hwr.stat);
 	rc = bnxt_trim_rings(bp, &rx_rings, &hwr.tx, hwr.cp, sh);
-- 
2.30.1


