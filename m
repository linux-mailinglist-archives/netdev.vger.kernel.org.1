Return-Path: <netdev+bounces-187577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47553AA7DFC
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 04:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6F03BD356
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 02:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D2CEAC7;
	Sat,  3 May 2025 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAMCny6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E6182
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 02:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746237712; cv=none; b=iuq83NfXTuuwMRMjck+Oq4wEO1DGSnTv6481/EicRqAy4mZ/FpNGOajQf9kVy3hx8tjtGlOjOVWWQXNEROfjt8v3qOKlOHtYOes7+mJltaoJI0YbmJLa1IdfIL+TyOvX2fS1z6UoMIXApSps7VDX1vyXHBSVsyOPdIYa1xUn3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746237712; c=relaxed/simple;
	bh=FWj1JkwBdH+nrTChjqS+uMyEq1fAU0UzOsEVP+2NIr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qy/eptL3eoTMI3HAmcxd8f5uNEx7/e0jF6FeaXIJ4vUSlUSSZfJNiNkQoRD0X4PuZwAr+BQAN9PB6bDCrFhUMYMumvOmCbZF/x6njp1es2bvAEgearnd99PHn8P0t5vjlnmPXb+/BcR2tDiI3kEjMDDmaa0lXdxZMWEORkqYMvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAMCny6S; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so16204485e9.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 19:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746237708; x=1746842508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0eqMEPy3e9QNCJtb437YHvBhLCL8kTk9X60hM64Xgd0=;
        b=HAMCny6SmEI3vnUsUu5BRDdDfiRV7PRtStuP06DCMnziPDp42ax84CO5qB7svGWawN
         wUOhCxRfvU1Om/lcgDY/Vg8r5KTx5qAO+Hs9aYz4yITQ6XiwOjwZZCjxASpkcX/IPYTg
         jLIC3Ll3KOSqde9WlUq6ZlOmGFkr0bz+XVN1cj4wKoz3fU0RXQuBCCFi3NC8sVywPtQ7
         m4RtiYanGi7wyDzyROgV/5paw7YDm1DwzNRMG1Yx0YnmrC2OAvWtyUdeur4uOjD3IYtr
         9yPcVcEZBxDzAg4/NV7r2WJ2SOMT6xUBpCYVtnJlc99c4sYWr9ce5AGZ459CA1+qqsSV
         cZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746237708; x=1746842508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eqMEPy3e9QNCJtb437YHvBhLCL8kTk9X60hM64Xgd0=;
        b=HbbUuWaAlR89/DMij3CfZkjNwTrm80t096wVZTkZXsk+PpSC8iK3iNat1vPg0LK/T8
         S6mIA4uEmZ6SnwSw0q9KRok0wh5vDT5GRpWW3egfNILb3F0q/E7x/rZzC1GCwDpHyJeM
         pGx7m6XuqgQpcLpZAASAGvrY39XaAZ8Gfzk6DSGZ522crrHU5mPnWMVYHvcuKhciULaW
         h9LpEBps78afTWzkg8Uw0WHDWSXI29WnUHOe44LgUF11m5gqDYIL9XtsZk473V0JbkXB
         6LC9Lmp6H0v8fEFEuUjGq/blNPFAFW9v7kDEuNy42w07LyTFd8FaNPv7G/yCdRC9Quhe
         GtxQ==
X-Gm-Message-State: AOJu0Yx5RJK75x+WLUvWfXrpW3dMr9DobtQLyZcz9F+J2sPF5kphE3zR
	dScxnoFKZatNBgneOzTL0yKSXqCe0VaBV2oOPV9fo1KBh1qiiVhApd7JFnaU
X-Gm-Gg: ASbGncs39brZib8vTwQdk6Ktxefcc/6yW4F2HNKHnqytmAmdt+oNkhiJbOCHyCMaZe1
	kegTQfl80PR4b8tfWYYJ3QVCh5InkF40sVdUzJRQAQjY9qkb0xy3fOu8YqOHE7viIe09MU5Y0yD
	4rlanNE8dzuRhlWPl9xJRsoJ1/1BYRzvyCVDO9zahKib5evYRHIbJOV/HR8PFGHRruThR9WakI3
	VHAaZZXh/Dg8f2nveQba4+ODsGK35XjwuZ5qjyWZNJMMzVAHEbSGqjadpBd1KJSEP6tYRom4yQv
	18O4aEA6o7U0LofmnLLnSvMwPrYrNEUfLtVv+w==
X-Google-Smtp-Source: AGHT+IGlXfcH0voSkXqF80u5MoAM4m6RfiRUz+ixH9MMaBJnTS3S+RK2SNpUfmkQfvMvQ+mAzn5MQA==
X-Received: by 2002:a05:600c:37ce:b0:43c:fa3f:8e5d with SMTP id 5b1f17b1804b1-441bbea1268mr46535395e9.2.1746237707809;
        Fri, 02 May 2025 19:01:47 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af306bsm106879045e9.21.2025.05.02.19.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 19:01:47 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	sdf@fomichev.me
Subject: [PATCH net-next] eth: fbnic: fix `tx_dropped` counting
Date: Fri,  2 May 2025 19:01:45 -0700
Message-ID: <20250503020145.1868252-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the tracking of rtnl_link_stats.tx_dropped. The counter
`tmi.drop.frames` is being double counted whereas, the counter
`tti.cm_drop.frames` is being skipped.

Fixes: f2957147ae7a ("eth: fbnic: add support for TTI HW stats")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index d699f58dda21..f994cbf1857d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -425,9 +425,9 @@ static void fbnic_get_stats64(struct net_device *dev,
 
 	/* Record drops from Tx HW Datapath */
 	tx_dropped += fbd->hw_stats.tmi.drop.frames.value +
+		      fbd->hw_stats.tti.cm_drop.frames.value +
 		      fbd->hw_stats.tti.frame_drop.frames.value +
-		      fbd->hw_stats.tti.tbi_drop.frames.value +
-		      fbd->hw_stats.tmi.drop.frames.value;
+		      fbd->hw_stats.tti.tbi_drop.frames.value;
 
 	for (i = 0; i < fbn->num_tx_queues; i++) {
 		struct fbnic_ring *txr = fbn->tx[i];
-- 
2.47.1


