Return-Path: <netdev+bounces-131099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3044398C9AE
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0661F24609
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68541E00A1;
	Tue,  1 Oct 2024 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vvSlo9Ee"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4761E1E0B9A
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826845; cv=none; b=U3aKFdfnSlwFtBlMlvFSymFO7kTfjLee12ns8TaHTohummRdnqXpvHGanJ/5t/fTdYvlCeXx/U5ObVyze0Z46qwIctGTwY/VzSKpM4DFCMr/SeoKk5DIAI179vtJC0sCDYfJILdwroc+yHP2lqlwedM4NTJXrkUGaxxhNQlbOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826845; c=relaxed/simple;
	bh=o3D87lP+KNy+Jir/fY7fvLsBvMyy9THUtqA+9zYkCpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IbqTYYdNvolBTwpIBmkXRbnNXZYZDWCKpzf2KfcgdW8axjBl4RfDwbBAx1rZ786RIRmyhYQ1bsxwj/lYz1llU7900s1xOX1cvzJDNBR7x1+xtisITGZHfSh+3KN0bWyKxTqRlc14sPvYzQ8IBDJNEJNZqBUheNoPqKmeNMx4Sxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vvSlo9Ee; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e109539aedso2675855a91.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 16:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826843; x=1728431643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLF63g3UxuFOgNadANGg2+qqv3YqiRQyKEar+/98gi0=;
        b=vvSlo9Eelee5097/8c3VFUiWk5vJI1GPF+ur0suqFmVXNp4IQa68jwxMIzjarE2L2p
         /gSLra0OAbxh4K4QH4DPjMiUbE/q0nRGq5uyN5t2DKLzC5vHRNSfc1q0ldj8l6RnfqdY
         1/DRSiviWHyyHh7JVOO+HeZSZ9lFKBRCu4iBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826843; x=1728431643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLF63g3UxuFOgNadANGg2+qqv3YqiRQyKEar+/98gi0=;
        b=W+l7j9TREQqkPnWkZOgh4HLy4hqYWY1/qNiBCTQFaubUWqJyNte6m9vQYda3Nq3+zX
         to8OMQ8kt/1K/FvQRNbabBbH0f6hwDCoAqHQfSCrtcz63oSbkAdWYNpHGnxrmjBiqN0j
         6aB8lbo1/PR06dh4Ujn9FKILs4RJJqVaVF6rXlFc7Pkt44nEizcuu6fu3FT/Mqj89+U9
         6Ba58DycAeGouhZ2YtF27uw0ZtMhylfNeTS6ss/Q8gMdtJLHEOiCTEXvIfq2E3pISoJS
         MLnyIi+l4kC63oz1ZyJQz4UUJ6t3LeXpd4MEgeqKipomTJ9M1U78wV60WAe/hDYWL85I
         oFXQ==
X-Gm-Message-State: AOJu0YxF5TiwHHvu3ZDFfkULGMQGZDtfp8CppVyOkKMCyLc7lqW4AqVW
	lt34pFmZammOtW58qyUNirLOC3R9fGpTGy3VOVRDJQA/GwCTXWCke964nQCh7YQ7NxhPJZzW272
	hHKFhamw8/xotyB241UOzCb1fl74BTS044vgPUzxXxn740gtTIfDmfqNedW48DLTPGnMnRfenSG
	WDqr6X6mRZNlChPBFYgB3J2YsGtfxCkEdqNXs=
X-Google-Smtp-Source: AGHT+IEziOa7A+MAB9R2Y08fOCLGpcavYwRLkZ94iRWB4+/kdOklKsQcBgrXg0q1p/jteWgh+MwIQQ==
X-Received: by 2002:a17:90a:1b89:b0:2d8:89ad:a67e with SMTP id 98e67ed59e1d1-2e1845511e2mr1931370a91.1.1727826843241;
        Tue, 01 Oct 2024 16:54:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:54:02 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v4 7/9] bnxt: Add support for persistent NAPI config
Date: Tue,  1 Oct 2024 23:52:38 +0000
Message-Id: <20241001235302.57609-8-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001235302.57609-1-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..f5da2dace982 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10986,7 +10986,8 @@ static void bnxt_init_napi(struct bnxt *bp)
 		cp_nr_rings--;
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
-		netif_napi_add(bp->dev, &bnapi->napi, poll_fn);
+		netif_napi_add_config(bp->dev, &bnapi->napi, poll_fn,
+				      bnapi->index);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bnapi = bp->bnapi[cp_nr_rings];
-- 
2.25.1


