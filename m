Return-Path: <netdev+bounces-107108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A09919DAC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 05:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB508B2264A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 03:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE0E17BB4;
	Thu, 27 Jun 2024 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="soTfrs9X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0A134BD
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457337; cv=none; b=Te/y+G3p2ny7fc7X+HSPUgJmEsMa+VIOHfzo3AcJno5cVnbejgRL7HJNAjxa/awhjk1/qBF6aD8FZ1a3CcDNQT+vXVJbiZCnUDCTSwWHpS6S/KHv8zM2NsZ1MuQOLJaDunOsje1FqRBsZAyTquGzGHlgt7874QFdhvmkJxgj+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457337; c=relaxed/simple;
	bh=ukiXBXPebzE7x/YVpirVjYpMkEmGIksawxjTpJ5lF9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6VOF62/010AVi88tnBFX9G/og+iM8+MAWEYtUxbPZxZK689bzg0Q28wVLIZBrr8u+dBfDd4IMKuScIMoPsKWCxMKOxQKqPpODrfbsYm2nSZErbZYMnar3nvW9ZXqHfNZ/l9ysaFIdSvQwegx13sQ73PU2RKuqKws4rJxmrfNUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=soTfrs9X; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d5d7fa3485so84131b6e.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1719457335; x=1720062135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IaNM1I4HWXrCUY0pwVSIP2cf06bnBq/uV3Ey6JNr98=;
        b=soTfrs9XAk0NgvU4hqXeMgDiXawtHuBBu3+lWGkLRRhhZb+LMkM/0Su66SUBCOWibB
         B9ncfOjE2VYOSzHCi3zgo8elx0dgouHMmOMoiO+UVDufQGqb5HkBJ84eCFiYUeIkKg7M
         yNLu1HYWFT9FWKZ1Apr4sPXZPTgJ4QslgNamFzKX4xkbrSYqtFn6niNc038e82vuF99C
         ZySYY/3EU2UOswRn/aP4fUSPnl7YNWN741NxOGsfrvRnHV9t2xUx7e7VHRLqmJs1BWjt
         CPXcJ7v6WjpaLPDYEDecRFlqp66fW88Vj5MOqOhPaUquN0VfVkgW40kWvZ7L7rlIq21D
         87MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719457335; x=1720062135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IaNM1I4HWXrCUY0pwVSIP2cf06bnBq/uV3Ey6JNr98=;
        b=Hczoz+9/11FQFd/PTQqvCnFDVXMuKwjXERBCLNt4gyAtxegm9fnD2GwcE+OjVdNI+u
         UGQk/irrLzmV3yfIq92pzzxqd2qMr1p4Ac0av9X/aUYD5YygPsKwPhEyudc6zmj6KTuj
         gB0A0MUUmrFscs+LFQmpSMTSr9iNNQBQ9ehRO1t+lewSpDlPUnx3xp7y9Z4QRj39QiDk
         QdHS97t26iortM+2LkGzbnLK601Uac9pUoF1ipAgJXjbn0Eq4dYd+/3+2wgPJ6yfWQJZ
         J8PvJLwrP6jTEVdjo17jWhkf3SRkOQFeTFWgH20q4X9PG9/p05nTau9OsULFWSjEsYfO
         AseA==
X-Forwarded-Encrypted: i=1; AJvYcCV4JKNdz2PRNDbzUC7j9mjHmHXgk7gb3Phnw9ZVcxNSJ2Hpat3rvq6YYyS5jLQyOqV7TTAPgFaqfn+8ueFQiE9ZE5WKpkau
X-Gm-Message-State: AOJu0YyvPIk8VwMI7vghp2Z99TUj00g2912pUlh1SeeRsea8lt4XrZpU
	jvzgRMWXc/liYj0vhf2FlHslHOLP4Wnq92MvjPIKEygMxCufrQBAP0AwpUODbyk=
X-Google-Smtp-Source: AGHT+IGOccmshDY1oomeaabWin1q3IFJIcB+Lgb25MOFL1cmDmBrjZ4xXKxAm1zczIAraF3hwpTovA==
X-Received: by 2002:a05:6808:1b23:b0:3d5:63a2:6030 with SMTP id 5614622812f47-3d563a262c9mr3827836b6e.46.1719457335388;
        Wed, 26 Jun 2024 20:02:15 -0700 (PDT)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4910258sm219644b3a.56.2024.06.26.20.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 20:02:15 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 2/2] bnxt_en: unlink page pool when stopping Rx queue
Date: Wed, 26 Jun 2024 20:02:00 -0700
Message-ID: <20240627030200.3647145-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627030200.3647145-1-dw@davidwei.uk>
References: <20240627030200.3647145-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have bnxt call page_pool_disable_direct_recycling() to unlink the old
page pool when resetting a queue prior to destroying it, instead of
touching a netdev core struct directly.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1bd0c5973252..18ff747a57fb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15049,11 +15049,6 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	bnxt_free_one_rx_ring(bp, rxr);
 	bnxt_free_one_rx_agg_ring(bp, rxr);
 
-	/* At this point, this NAPI instance has another page pool associated
-	 * with it. Disconnect here before freeing the old page pool to avoid
-	 * warnings.
-	 */
-	rxr->page_pool->p.napi = NULL;
 	page_pool_destroy(rxr->page_pool);
 	rxr->page_pool = NULL;
 
@@ -15173,6 +15168,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	rxr->rx_next_cons = 0;
+	page_pool_disable_direct_recycling(rxr->page_pool);
 
 	memcpy(qmem, rxr, sizeof(*rxr));
 	bnxt_init_rx_ring_struct(bp, qmem);
-- 
2.43.0


