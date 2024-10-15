Return-Path: <netdev+bounces-135606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D699E545
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59027B272A0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5851D89F3;
	Tue, 15 Oct 2024 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtOzurZd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6FD1D89F5
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990752; cv=none; b=FUU/kuo3Tq8NdCVBbsNOzcg62L6Bc1bHkPHMfmup/Ouffn2xYFSwGFlWxbNuM/syNB5BKDFfSDRBvYSe76qwaU4m9WUClV45HtR3OP/JzOuTEsGDstMGOoX2VSgfVpd+jm3SWSUBZf0cGIo7IY3H2nEhbSMj7Ea4fTCf31x4uNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990752; c=relaxed/simple;
	bh=dT9hpcl8Vj5/LM2hagh5dH40epqV0sohjSTAr1dgtfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mqFbzlr49wDmrMebj0sDujlL1csyFEcsLJuuOcLTo0w7EYkiwu+66Jrq1TjwlkmRt3wrcMlQ2CX4J5IO87bp4JazX5blK7AhgqVh3hcRZJhVbvni84WzDOeyjvRVnjbyuH3zDNOM71rLAaVECB+E9psfEUWHRuYdG7tSm/WJ6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtOzurZd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728990749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A2jbNmsLktPbk4ow5hOVnlhPUm3jOtLymoFqsYAJr3A=;
	b=DtOzurZdltDaJzFam8ZGAgx2r2zQWXT7pew1L32j3yAErJnZqnrVoSOfV8om214BgB23HJ
	UYHsrXSOfNhzYkkAj9w/0hOvPKB20fPHbnxBwn5Ei3ym5SL0+iQFf6/RALtW8QqMD2dcAr
	5ZuFyLfRiX1trZT8zAFPcnEY5W/oF48=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-7vB_j6t2NGKLR2MbB03h7Q-1; Tue, 15 Oct 2024 07:12:27 -0400
X-MC-Unique: 7vB_j6t2NGKLR2MbB03h7Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d662dd3c8so1254261f8f.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 04:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990746; x=1729595546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2jbNmsLktPbk4ow5hOVnlhPUm3jOtLymoFqsYAJr3A=;
        b=FnEEzu9sPEcmrW8LBml/4xmrkxzKBcT7yO9MMdDD35P6KeLbRgUk5BWvtyWXb36IMO
         3ZomCpbCKOGUG2NYo8fEzYhHjYlYn0tiIu7GQjCrOFEkKseguLxk7cz7E6tCq25rWfc0
         qWdrD9oFwoRvP/6USDhR1m0kaLIWwY1fu+SLUEafE/209y5zSrKoEtd71kXwe/Wzigj5
         XeCDlw/us7L2+M0cmXc6zTIwgZWXbA9Zl+wfQq+Ssh6d6ZhS6Bh7NW9JAoZTeSteQ5Im
         6+pF2MJ61OHUCukT/zKdCMHeZUNe8QvKQgP/+Hz1PKHRjN7R/u/THqTuQYTUkzpiSGIT
         jJ8Q==
X-Gm-Message-State: AOJu0YxFwyLsHxop4qZg4PxisrWMvMCLbIuKtid2A5OHH1o8OWFX6mur
	/U9JrWV+GDf2HP66CaUfOCJ4YY3vq0Vq2hkuNqBChN9+WaaBQfgJdQ9e8o7+K6qzwJHxnoAMfIg
	D8mSMniyOBUVVlrdUVn6uULhMpJz+66tDXQOe/ISIPbKfVSepFmfkZaj0mGGLJBplHePTj5hehK
	sfpLy8TnXb8Piw5HV9mgg8fii0htTz9yAONtXGjg==
X-Received: by 2002:adf:ec4d:0:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-37d55184d55mr8932038f8f.2.1728990745982;
        Tue, 15 Oct 2024 04:12:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJVtPy37P5l4pwBAnpmBjBSOwVZPSBzL4MuRt4z/OZyH5c+k3dr1usKtuBc6aZWqAGjbOaYg==
X-Received: by 2002:adf:ec4d:0:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-37d55184d55mr8932011f8f.2.1728990745422;
        Tue, 15 Oct 2024 04:12:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:a105:b900:7e63:fa61:98e3:21ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc42160sm1286041f8f.112.2024.10.15.04.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:12:25 -0700 (PDT)
From: Ales Nezbeda <anezbeda@redhat.com>
To: netdev@vger.kernel.org
Cc: sd@queasysnail.net,
	kuba@kernel.org,
	Ales Nezbeda <anezbeda@redhat.com>
Subject: [PATCH net] netdevsim: macsec: pad u64 to correct length in logs
Date: Tue, 15 Oct 2024 13:09:43 +0200
Message-ID: <20241015110943.94217-1-anezbeda@redhat.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we pad u64 number to 8 characters using "%08llx" format
specifier.

Changing format specifier to "%016llx" ensures that no matter the value
the representation of number in log is always the same length.

Before this patch, entry in log for value '1' would say:
    removing SecY with SCI 00000001 at index 2
After this patch is applied, entry in log will say:
    removing SecY with SCI 0000000000000001 at index 2

Fixes: 02b34d03a24b ("netdevsim: add dummy macsec offload")
Signed-off-by: Ales Nezbeda <anezbeda@redhat.com>
---
 drivers/net/netdevsim/macsec.c | 56 +++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/netdevsim/macsec.c b/drivers/net/netdevsim/macsec.c
index aa007b1e4b78..bdc8020d588e 100644
--- a/drivers/net/netdevsim/macsec.c
+++ b/drivers/net/netdevsim/macsec.c
@@ -46,7 +46,7 @@ static int nsim_macsec_add_secy(struct macsec_context *ctx)
 		return -ENOSPC;
 	}
 
-	netdev_dbg(ctx->netdev, "%s: adding new secy with sci %08llx at index %d\n",
+	netdev_dbg(ctx->netdev, "%s: adding new secy with sci %016llx at index %d\n",
 		   __func__, sci_to_cpu(ctx->secy->sci), idx);
 	ns->macsec.nsim_secy[idx].used = true;
 	ns->macsec.nsim_secy[idx].nsim_rxsc_count = 0;
@@ -63,12 +63,12 @@ static int nsim_macsec_upd_secy(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in secy table\n",
 			   __func__, sci_to_cpu(ctx->secy->sci));
 		return -ENOENT;
 	}
 
-	netdev_dbg(ctx->netdev, "%s: updating secy with sci %08llx at index %d\n",
+	netdev_dbg(ctx->netdev, "%s: updating secy with sci %016llx at index %d\n",
 		   __func__, sci_to_cpu(ctx->secy->sci), idx);
 
 	return 0;
@@ -81,12 +81,12 @@ static int nsim_macsec_del_secy(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in secy table\n",
 			   __func__, sci_to_cpu(ctx->secy->sci));
 		return -ENOENT;
 	}
 
-	netdev_dbg(ctx->netdev, "%s: removing SecY with SCI %08llx at index %d\n",
+	netdev_dbg(ctx->netdev, "%s: removing SecY with SCI %016llx at index %d\n",
 		   __func__, sci_to_cpu(ctx->secy->sci), idx);
 
 	ns->macsec.nsim_secy[idx].used = false;
@@ -104,7 +104,7 @@ static int nsim_macsec_add_rxsc(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in secy table\n",
 			   __func__, sci_to_cpu(ctx->secy->sci));
 		return -ENOENT;
 	}
@@ -122,7 +122,7 @@ static int nsim_macsec_add_rxsc(struct macsec_context *ctx)
 		netdev_err(ctx->netdev, "%s: nsim_rxsc_count not full but all RXSCs used\n",
 			   __func__);
 
-	netdev_dbg(ctx->netdev, "%s: adding new rxsc with sci %08llx at index %d\n",
+	netdev_dbg(ctx->netdev, "%s: adding new rxsc with sci %016llx at index %d\n",
 		   __func__, sci_to_cpu(ctx->rx_sc->sci), idx);
 	secy->nsim_rxsc[idx].used = true;
 	secy->nsim_rxsc[idx].sci = ctx->rx_sc->sci;
@@ -139,7 +139,7 @@ static int nsim_macsec_upd_rxsc(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in secy table\n",
 			   __func__, sci_to_cpu(ctx->secy->sci));
 		return -ENOENT;
 	}
@@ -147,12 +147,12 @@ static int nsim_macsec_upd_rxsc(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_rxsc(secy, ctx->rx_sc->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in RXSC table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in RXSC table\n",
 			   __func__, sci_to_cpu(ctx->rx_sc->sci));
 		return -ENOENT;
 	}
 
-	netdev_dbg(ctx->netdev, "%s: updating RXSC with sci %08llx at index %d\n",
+	netdev_dbg(ctx->netdev, "%s: updating RXSC with sci %016llx at index %d\n",
 		   __func__, sci_to_cpu(ctx->rx_sc->sci), idx);
 
 	return 0;
@@ -166,7 +166,7 @@ static int nsim_macsec_del_rxsc(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in secy table\n",
 			   __func__, sci_to_cpu(ctx->secy->sci));
 		return -ENOENT;
 	}
@@ -174,12 +174,12 @@ static int nsim_macsec_del_rxsc(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_rxsc(secy, ctx->rx_sc->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in RXSC table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in RXSC table\n",
 			   __func__, sci_to_cpu(ctx->rx_sc->sci));
 		return -ENOENT;
 	}
 
-	netdev_dbg(ctx->netdev, "%s: removing RXSC with sci %08llx at index %d\n",
+	netdev_dbg(ctx->netdev, "%s: removing RXSC with sci %016llx at index %d\n",
 		   __func__, sci_to_cpu(ctx->rx_sc->sci), idx);
 
 	secy->nsim_rxsc[idx].used = false;
@@ -197,7 +197,7 @@ static int nsim_macsec_add_rxsa(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in secy table\n",
 			   __func__, sci_to_cpu(ctx->secy->sci));
 		return -ENOENT;
 	}
@@ -205,12 +205,12 @@ static int nsim_macsec_add_rxsa(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_rxsc(secy, ctx->sa.rx_sa->sc->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in RXSC table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in RXSC table\n",
 			   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci));
 		return -ENOENT;
 	}
 
-	netdev_dbg(ctx->netdev, "%s: RXSC with sci %08llx, AN %u\n",
+	netdev_dbg(ctx->netdev, "%s: RXSC with sci %016llx, AN %u\n",
 		   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci), ctx->sa.assoc_num);
 
 	return 0;
@@ -224,7 +224,7 @@ static int nsim_macsec_upd_rxsa(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in secy table\n",
 			   __func__, sci_to_cpu(ctx->secy->sci));
 		return -ENOENT;
 	}
@@ -232,12 +232,12 @@ static int nsim_macsec_upd_rxsa(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_rxsc(secy, ctx->sa.rx_sa->sc->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in RXSC table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in RXSC table\n",
 			   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci));
 		return -ENOENT;
 	}
 
-	netdev_dbg(ctx->netdev, "%s: RXSC with sci %08llx, AN %u\n",
+	netdev_dbg(ctx->netdev, "%s: RXSC with sci %016llx, AN %u\n",
 		   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci), ctx->sa.assoc_num);
 
 	return 0;
@@ -251,7 +251,7 @@ static int nsim_macsec_del_rxsa(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in secy table\n",
 			   __func__, sci_to_cpu(ctx->secy->sci));
 		return -ENOENT;
 	}
@@ -259,12 +259,12 @@ static int nsim_macsec_del_rxsa(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_rxsc(secy, ctx->sa.rx_sa->sc->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in RXSC table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in RXSC table\n",
 			   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci));
 		return -ENOENT;
 	}
 
-	netdev_dbg(ctx->netdev, "%s: RXSC with sci %08llx, AN %u\n",
+	netdev_dbg(ctx->netdev, "%s: RXSC with sci %016llx, AN %u\n",
 		   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci), ctx->sa.assoc_num);
 
 	return 0;
@@ -277,12 +277,12 @@ static int nsim_macsec_add_txsa(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in secy table\n",
 			   __func__, sci_to_cpu(ctx->secy->sci));
 		return -ENOENT;
 	}
 
-	netdev_dbg(ctx->netdev, "%s: SECY with sci %08llx, AN %u\n",
+	netdev_dbg(ctx->netdev, "%s: SECY with sci %016llx, AN %u\n",
 		   __func__, sci_to_cpu(ctx->secy->sci), ctx->sa.assoc_num);
 
 	return 0;
@@ -295,12 +295,12 @@ static int nsim_macsec_upd_txsa(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in secy table\n",
 			   __func__, sci_to_cpu(ctx->secy->sci));
 		return -ENOENT;
 	}
 
-	netdev_dbg(ctx->netdev, "%s: SECY with sci %08llx, AN %u\n",
+	netdev_dbg(ctx->netdev, "%s: SECY with sci %016llx, AN %u\n",
 		   __func__, sci_to_cpu(ctx->secy->sci), ctx->sa.assoc_num);
 
 	return 0;
@@ -313,12 +313,12 @@ static int nsim_macsec_del_txsa(struct macsec_context *ctx)
 
 	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
 	if (idx < 0) {
-		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+		netdev_err(ctx->netdev, "%s: sci %016llx not found in secy table\n",
 			   __func__, sci_to_cpu(ctx->secy->sci));
 		return -ENOENT;
 	}
 
-	netdev_dbg(ctx->netdev, "%s: SECY with sci %08llx, AN %u\n",
+	netdev_dbg(ctx->netdev, "%s: SECY with sci %016llx, AN %u\n",
 		   __func__, sci_to_cpu(ctx->secy->sci), ctx->sa.assoc_num);
 
 	return 0;
-- 
2.46.2


