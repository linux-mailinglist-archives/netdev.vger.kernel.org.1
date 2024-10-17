Return-Path: <netdev+bounces-136586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CB79A2387
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA5E1F2889F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D4D1DD886;
	Thu, 17 Oct 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4dxnMUK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03B1DD54E
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171232; cv=none; b=Eoq/+TyYJkXtKGrTAz4fi1IrH4SYfGcoQn2x2QkI4/K+s3S1q1IqXYbi8dNDn/sBS5PQHjARQv/wZk0XJEuIRdIFwV4B5Q4MTUW4+TJ4eqfr5gXih6oZ6KAYQnK4l6D0TsUZHyRPoRVoFKg2OFpemDIyIdWjB0ZSDNWiFKIn2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171232; c=relaxed/simple;
	bh=Y1MyfbaSvo3UpadiZG1QVQRivbd4tAGDPLTAaVua4+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RI9xGbfL7nk7HDkFU3jJhAQTGeb2Fm2QGHll0SBMF0Zgdgo4Mcd+s0gBe39NFx0osLf4Qe2X5iMiOmfdpC8/WDs1ZvtY/sAiVLrlga7Ctc+B6AC/ohfVccJ+p98azUYsqJQGEGHISefxFGPXTfzwkewZiN+kWJUUEOJuOtuXXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4dxnMUK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729171229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9w2pDQq7fJ7XpgU7d/9o8+BozWN2Ms9tCiu8Uq3bgLo=;
	b=J4dxnMUKet8p1YavVVjZYS/izSsOfqwnTMVqYJdoaa7Hih0W0lugYb2Ei+OtBy179hOd9x
	l4P31gd8GT6lbAt5sMqg6t0kpaogfh/YwMYD3LcqGPynn0e/cu+vpYfJtJ8m8vWt50wvlB
	hifyEZ1rqWWfwUoG4iJzd8biHr097Lk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-zDuCCtzFMMmgMY70bu6VEg-1; Thu, 17 Oct 2024 09:20:27 -0400
X-MC-Unique: zDuCCtzFMMmgMY70bu6VEg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d533a484aso986491f8f.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171226; x=1729776026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9w2pDQq7fJ7XpgU7d/9o8+BozWN2Ms9tCiu8Uq3bgLo=;
        b=NQBhpsBDIYK3mX69wjsNOsrPqxb3NXtCS63mzzcM9Mo0D+c/m/YfdMY6WDEFyQLoEj
         O1oUjiZgJDQ6OW0TMAGEby02lfjUPq7PH499N785dn8TOG+uIK3EJvTEJjwquQWbREcL
         aM71ZLKjXMRzOJwvsLMNXjJxiEKz3aLUj4M8s0kmKuV3gYhIHCCVFrsVRZWUk//0IFZN
         8BCxVvS0A6HOU/AWZEGXjnpSueQU0CSQGlgAY3wZ9j1031Ub/iPG4cLFwbB4KNvW4F95
         pFmbFMqbC4lVCcpg+9R9gwxFPeonNuNmd3Uvq3RydwBlcNwfM/7IByg1GLOp5iyRNlbk
         l2bg==
X-Gm-Message-State: AOJu0Yz9bqTFQMZZQCuxOGfCsoSmeEavVidDtnkYoZHVkvwBpiMNe2un
	ysr4OKL1tKbXd3Renbt2Zr04RrtOE9paORbUqcwVwdCADSzjyzS6GxE/GnUKw2SYBt5GugArNnY
	+1UB2oCFywzA6iY+Mpdjir48I1TsaKi8AHQk8Xk56e+6LFazsmd9ijXpAZMdK0McK4om7IUW7Zu
	a5DVlL+nAT1tpQSJh08Is1kk2pPhoXFBkRf5NRww==
X-Received: by 2002:a05:6000:144:b0:374:cd3c:db6d with SMTP id ffacd0b85a97d-37d93d43e12mr2023077f8f.6.1729171226329;
        Thu, 17 Oct 2024 06:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0RybWHnXYRiEPGB/nFOfbI2sIKqI/Yx9D1OMnzhbcbS3ynaJVg1g68vnP34Hz7Za68w6KHQ==
X-Received: by 2002:a05:6000:144:b0:374:cd3c:db6d with SMTP id ffacd0b85a97d-37d93d43e12mr2023046f8f.6.1729171225802;
        Thu, 17 Oct 2024 06:20:25 -0700 (PDT)
Received: from fedora.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87c7dsm7195789f8f.42.2024.10.17.06.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:20:25 -0700 (PDT)
From: Ales Nezbeda <anezbeda@redhat.com>
To: netdev@vger.kernel.org
Cc: sd@queasysnail.net,
	kuba@kernel.org,
	Ales Nezbeda <anezbeda@redhat.com>
Subject: [PATCH net-next v2] netdevsim: macsec: pad u64 to correct length in logs
Date: Thu, 17 Oct 2024 15:19:33 +0200
Message-ID: <20241017131933.136971-1-anezbeda@redhat.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 02b34d03a24b ("netdevsim: add dummy macsec offload") pads u64
number to 8 characters using "%08llx" format specifier.

Changing format specifier to "%016llx" ensures that no matter the value
the representation of number in log is always the same length.

Before this patch, entry in log for value '1' would say:
    removing SecY with SCI 00000001 at index 2
After this patch is applied, entry in log will say:
    removing SecY with SCI 0000000000000001 at index 2

Signed-off-by: Ales Nezbeda <anezbeda@redhat.com>
---
v2
  - Remove fixes tag and post against net-next
  - v1 ref: https://lore.kernel.org/netdev/20241015110943.94217-1-anezbeda@redhat.com/
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


