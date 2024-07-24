Return-Path: <netdev+bounces-112799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A9A93B483
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 18:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E8B1C23501
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E0E15CD64;
	Wed, 24 Jul 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9Wnsf14"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057615B0FA
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837304; cv=none; b=TaRm5jlRTSPISQv/RlfcSQTsN60k22+dUXUY7wcVNl4XPclXGcsMEy40zJFBivL37lsvzJ4mV1wu98X078AcgujvE5740fPFdyspL4wvmhsLdvKfokK5idHESUHl/u1HN1WpHt0SY/ejt1SboaibJEj6UYTz/QEW+tsJp2kzgYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837304; c=relaxed/simple;
	bh=ndst8U0aqaVE2fCttziktT33gS2XO754m38Daa0sVJE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DCBtKEvbhUUIVxtnptI4J/8o3w3wohizCAvx77MuvUpZV9ekdRAHUWpYZmpi3ujmZ4n9OHn01me86vWSWYniHW4/BUjZWGS5TvDA7djyjQf+UFki7KQ3qSq4ux55/lgmsTSgxIbjKwiPMnbrm4ZvYrn9mA670yr3908rVUoWr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f9Wnsf14; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-708e75d8d7cso3943740a34.3
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721837301; x=1722442101; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFUzCqXp4LUYgYIMte0bv+Giz/nJSTprZA6Id25g/X0=;
        b=f9Wnsf14+8RNf5DFBVCTGS6nrgD132ljg/NnkdUOEZRVIrxcITpu7gAPBRzcMGB0/e
         0B1E/Sa0fQdyIu6Dpi4x9SVOYtJiKaAIfH3Wzib/tJG5oopRT3Px1prNzgllOPjOVzBC
         tKh6zcHVLHDTUAWOyFriX3iG013piNqzLMK2xYnttWnnU7wANhQlm1558UmfLbAC6QFJ
         DdVdX59rq45+vYo3MClp9u2LlQKnJAXDZp+7N4CJVQ0rRLkN057iDxnPJqP9Qx3fv5Ge
         gnEtHPWfaSBuAKrbVpDnKKDF/GLVWSYr42aIHIF6QHMLEhzcYzp1NOKpWHamc7flfgyF
         5Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837301; x=1722442101;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFUzCqXp4LUYgYIMte0bv+Giz/nJSTprZA6Id25g/X0=;
        b=ofCRSBvVpbg+R2WUESRIWgUBDuxTgEjvbGAYp+IZP4dM2bLhOkWsQc8aMNTBt+ZAbo
         KVkyFV7Qn0aPa/3ty/EQYd6vhN4Xkox327K/VmpyxzoYlEl4Ch1vIitZlU5llRhNAo1m
         gv28qTk6t8JsLZQYJPOzhJUy+TvySHIRaYS3TJMwQeHjoGFoCgTqACQaLFjHk5ZMD0bS
         jhKoESauXOnVDJOQ0RzbmZrzk3k3TKCePfpytQmTbTiZWQZtEn1EnCIu2dHsPslVOqXy
         GEAcydknzgeKjAt6TcIgk4bbX+AWmFBJYxWkv1t50tGqDpeX51KiMCVCKg10M7ud7b1+
         GyEA==
X-Forwarded-Encrypted: i=1; AJvYcCWLRioKpTb3P+Qynb4VvkhzBQ3Meb6qK0qgrLYGOe43ZBj02r8BbBI+CX0sy1cmCXQlduTCXbEA/3OWGdUgBhQ8ZOwlbqGL
X-Gm-Message-State: AOJu0YwZt6L5NIThTt81VMfR91h5XdgqpokVMohOU4CFRph6PW7Y5tk+
	kzUUjJs4XwFAxUdmKg8ObAy9hHEKXxTZIOWT+BtN1keDry+yRdfANYK8KAH3ahc=
X-Google-Smtp-Source: AGHT+IHowiqFMAkZdXvPHkV21jBtt7drxbOHtZgKOU668QUsqbER2NYAajL3QZ8PPG0U73SMiNfNXg==
X-Received: by 2002:a05:6830:488f:b0:704:4658:5d1 with SMTP id 46e09a7af769-7092e6c664bmr239202a34.12.1721837301140;
        Wed, 24 Jul 2024 09:08:21 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:23ae:46cb:84b6:1002])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a501csm2469880a34.5.2024.07.24.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:08:20 -0700 (PDT)
Date: Wed, 24 Jul 2024 11:08:18 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Karsten Keil <kkeil@suse.de>
Cc: Karsten Keil <isdn@linux-pingi.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-XXX] mISDN: Fix a use after free in hfcmulti_tx()
Message-ID: <8be65f5a-c2dd-4ba0-8a10-bfe5980b8cfb@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Don't dereference *sp after calling dev_kfree_skb(*sp).

Fixes: af69fb3a8ffa ("Add mISDN HFC multiport driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/isdn/hardware/mISDN/hfcmulti.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
index 0d2928d8aeae..e5a483fd9ad8 100644
--- a/drivers/isdn/hardware/mISDN/hfcmulti.c
+++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
@@ -1901,7 +1901,7 @@ hfcmulti_dtmf(struct hfc_multi *hc)
 static void
 hfcmulti_tx(struct hfc_multi *hc, int ch)
 {
-	int i, ii, temp, len = 0;
+	int i, ii, temp, tmp_len, len = 0;
 	int Zspace, z1, z2; /* must be int for calculation */
 	int Fspace, f1, f2;
 	u_char *d;
@@ -2122,14 +2122,15 @@ hfcmulti_tx(struct hfc_multi *hc, int ch)
 		HFC_wait_nodebug(hc);
 	}
 
+	tmp_len = (*sp)->len;
 	dev_kfree_skb(*sp);
 	/* check for next frame */
 	if (bch && get_next_bframe(bch)) {
-		len = (*sp)->len;
+		len = tmp_len;
 		goto next_frame;
 	}
 	if (dch && get_next_dframe(dch)) {
-		len = (*sp)->len;
+		len = tmp_len;
 		goto next_frame;
 	}
 
-- 
2.43.0


