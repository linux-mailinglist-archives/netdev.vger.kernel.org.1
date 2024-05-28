Return-Path: <netdev+bounces-98686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58858D20FF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACB71F24BE0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D07171E53;
	Tue, 28 May 2024 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="jcQXp7B/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA962576B
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912083; cv=none; b=srklFDamsuTUIxJi0YhtTh5DavXdwQeZtH92Cj9xci7HmyFhL+SARtUWrIITNhsVxxol977SNoeEgUrgng2f21jdYmkqnmZDu1aqEnewRvewnLqjfJl0SxbJYJjfVW52ybGRUYatJ/CZ5jjLxObY0XHXULGUM5bIQ4a1Xqa8rZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912083; c=relaxed/simple;
	bh=XLoTvNeTfS0Z+Xmo5LFQXXdmRX9EJkbbxeer+BFVM1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFevRROHbHQs1sswchEncQtWeOlz2tCYegokeNnQVJ06S8L48n9OgxT4bt3WFlah2XmcTG6ekQNBlbbB/DDpOwcO646PEGYXjRIgrdsGnVZEFQ7GF8aBWApsROu+qg8NScg8nV+wTMBu6v2FksgeIYjMddHgYDOZmOSmPFzmq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=jcQXp7B/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5295f012748so1306310e87.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716912079; x=1717516879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jw0FtTciCXQX3h6CcIOAWgqPfMRJPygWAg+dmYzhfxo=;
        b=jcQXp7B/vlttlCNFS+XMQ5wyb/JVYufPy8pc4EN5syxlBRFTkfBCpBCUSlnmv/4pxe
         TyREqBghByK7bJw9Uwn6SVqQIF4XYzO6JCw3ihWTIuxOqXqrZxVuemnCIcqaJkoDdN7t
         58F0PfcJLFWfb5/DGsT4E4TPneyNp8h6nIw6nRe+SKht1fO9P3qvPwOQC1G1PjZL0o4Q
         jTMBz8Qa49m0kbbxMeupw1yJwgRzSNhZgvHuRUEJgalhBF8/xZ1x7+YM3o8dFP1fjW3I
         71L7QqdTXR8QkojLWDrNoHTsP7Ocaijbj7UqL5e4PlhPCrmzvLuOQJTuZxTVndczlImm
         +nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716912079; x=1717516879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jw0FtTciCXQX3h6CcIOAWgqPfMRJPygWAg+dmYzhfxo=;
        b=i5gPHFnC/kmrXtTjH7JP+eWVTrhOupUnfL4Qte3vD4e5/mJ7/qtLdXwfSLi+Dc6eLQ
         ZOb7hPk6lsZ6LCLLkQfiiEpdfQLev6R4BwJUa/nCdKbuP/0ldl1aGOoTgu9/QwdbIpP2
         manMxiZ7GyMT5eD34efZhVPa2i0SgEn98qbHcM6zXC6t6+YXY0CbJs0WiZiCgMWZegmn
         CG33Da46Dn2uIPs5iWOEJTPVUennhQNDHPYiaMm0UqCHDz9mmKxlrqJY0veeYkKRdICI
         S+iuUYwedHxlqHKdQnKXy00hfqUKAzuy+p13YD9KTzvEne3fiRndgAqcuat9D6fxN1HN
         F89g==
X-Forwarded-Encrypted: i=1; AJvYcCWSD4jP5rMk2xM/QGXyj+8RG3FpFNxD8rU4Z2ZWWgfYzAbxqZ/Rn22Q4h/rxbVZIdmV7hXmrlK3maHO27A4l3kPCkDsVbqp
X-Gm-Message-State: AOJu0YxqLRaHb2aDaIuHNwF1AoE9neumarlmdBKNtakTB9Ozwv1jI2l4
	0goqPVONBd7yQiRFMyes6I97iBXUT53/yZH3t4ZhphPpUOIu6xRTqxxZQ5wRESU=
X-Google-Smtp-Source: AGHT+IEyQ11RRAiPP9QgNTCWBO2LMoWgZ5tDLIEbBtOI6wcxJ4QNn4AUbE6uD+dbnOOySm4vCify4A==
X-Received: by 2002:a05:6512:3b8d:b0:520:85cf:db7f with SMTP id 2adb3069b0e04-52965479b50mr10969426e87.28.1716912079313;
        Tue, 28 May 2024 09:01:19 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4f465sm621137866b.120.2024.05.28.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 09:01:18 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net-next] net: smc91x: Remove commented out code
Date: Tue, 28 May 2024 18:00:37 +0200
Message-ID: <20240528160036.404946-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove commented out code

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/net/ethernet/smsc/smc91x.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 78ff3af7911a..907498848028 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -1574,12 +1574,8 @@ smc_ethtool_set_link_ksettings(struct net_device *dev,
 		    (cmd->base.port != PORT_TP && cmd->base.port != PORT_AUI))
 			return -EINVAL;
 
-//		lp->port = cmd->base.port;
 		lp->ctl_rfduplx = cmd->base.duplex == DUPLEX_FULL;
 
-//		if (netif_running(dev))
-//			smc_set_port(dev);
-
 		ret = 0;
 	}
 
-- 
2.45.1


