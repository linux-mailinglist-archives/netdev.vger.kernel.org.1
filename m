Return-Path: <netdev+bounces-98172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6438CFE6F
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 12:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E2B282A0E
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99813B783;
	Mon, 27 May 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="KGfrfms1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE14013B5A8
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807398; cv=none; b=VTbhaLhEd04A4sAanjVjon8Nki1X85rjlpMLCgbq3eqSctUaR2PMMZbfxcpbR7aLRPGp+3HnPncB1KGRLf29C92Mlyw8RnSstdNK2QasEN51R2o8kiraxeMwQSEkArb9a5UC230yYswiPH+8U1n3gzGqcO7ff50kbOhA+XgZm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807398; c=relaxed/simple;
	bh=XLoTvNeTfS0Z+Xmo5LFQXXdmRX9EJkbbxeer+BFVM1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrDXlG7TqLDNt8lWfLZ3MHVj5mtnaXb3bndNyPn+k8Nw1ahWSndW76fVz+HbjaQJjT3nH8idXpx1K0U0Dn/8/8YQCvuLaSCypdvuWZIcZTJ+lDuCi7cRDdQSRFstJY9xD/vkuyXfueMWxfAMX4EjcJcpyy+Vs67NRZVapie0TzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=KGfrfms1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5785d466c82so3274695a12.3
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716807395; x=1717412195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jw0FtTciCXQX3h6CcIOAWgqPfMRJPygWAg+dmYzhfxo=;
        b=KGfrfms1X+UnFUNtYLi7jq0LzIB6HwvfbrnrsNhHzO2IefNMb+LXLDt4+d9uQqUmht
         GrmD2no50wAJHFO8h5JHJDq4MGcfuO3fzz6LdZEyTzZ5me7z3ZNeJRj78wv3JoArZiig
         bG3exEjYdmQmFh7SAOVJFkgATQ3YCYLvMXmWSjWqmYiLhFUgqDd6qv0b7z4IldTxTJ41
         sdnTEPLRW7eShK+v+KxqEySx8O9O3fnc/2QKJqJ66fpSK99syNKX21adnVilgg8q80dS
         v+R774ONG0lF3BdRLiAbQwZMSJ+gy0ubEXAh+bG1nekEgedbqAS0mE4FksYVYlPy5lv6
         ovwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716807395; x=1717412195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jw0FtTciCXQX3h6CcIOAWgqPfMRJPygWAg+dmYzhfxo=;
        b=QsZx6tpsltO4Ynl91bkaJUHBHKqiz7WSdJ2o4lwtN+Eh/AIb0L/6XRANZCz6PpTjRl
         fvRDgPAQlPtoCyvqXuUhxJ9/tHWiDBAElpqSLkIVEfIqEcjWWvDlDmasQaOSKcoW4dLl
         kZ7llk+dhW6vh1LNhBFrpDTBHAogwIFvxkUDLF66MVHiYHc4ETWdAkTrPG/RoVKzDcMM
         UfrDbNuLAx/8A+X0oqzaTVxAXxOdTDSSZUoQzqq/fa1GWzqa/tPWHyVvG5ue6do/Ja12
         UPW1wL1L26/kImxuR4wYXs+FE1hoZwXNDWV/xytCumZgquMYlLMBC1AsJj3Hn1D/GUg5
         UpHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNQoXrkGtuEVkTh4/mv7R5U8sn2LvaEmC0A4NheCZincN9WuuPx9UMyOUjTPmXkuTrQvFHz0/QekrFDRm+2ySMlP6eYYG5
X-Gm-Message-State: AOJu0YxNcgpplV4uZYdaJUgDu1fibhkrMwOhf2O4gOReAHv5V3KWgMb8
	ExyEZaC5ZoTcr8aEw/N+VHeGZqUL32zn+NikmA0NomgoPzavzcyTTOqP9soJsIM=
X-Google-Smtp-Source: AGHT+IGlBr+lrKmneJwsXJDybFQCF1UdYP1AaUzjy+aTvC1Qzbd1hN/9MnflALOBxAmHv0rcPKwLZQ==
X-Received: by 2002:a50:9e4d:0:b0:578:5105:5ecc with SMTP id 4fb4d7f45d1cf-578519b7ee2mr5364221a12.37.1716807395099;
        Mon, 27 May 2024 03:56:35 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524bc547sm5624412a12.96.2024.05.27.03.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:56:34 -0700 (PDT)
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
Subject: [PATCH net] net: smc91x: Remove commented out code
Date: Mon, 27 May 2024 12:55:58 +0200
Message-ID: <20240527105557.266833-2-thorsten.blum@toblux.com>
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


