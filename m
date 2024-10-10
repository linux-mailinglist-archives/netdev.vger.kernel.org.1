Return-Path: <netdev+bounces-134357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8AA998EA7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47ED728634A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66711CF7C3;
	Thu, 10 Oct 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCzEWcJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A761CF2A5;
	Thu, 10 Oct 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582276; cv=none; b=LHSE6frcmfo/XI3IYiC3mKfPtt0IGKBP+QM3wrQb+8LwpUoD4gj1aRNS5PyE7uK0To3aJGMmFUyn9EepF9bCOrPzwJUCEU1Vw+b7LxhZIFPv1QnebBJr4H8R7VYKnXgqCGUA6GHjTEoHASv83dmwT5X7JIr1GZnvpoKAqctgsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582276; c=relaxed/simple;
	bh=lNeanO6FjGs6OMbM0mJk22206OtOXjWZSQs9VsCFo1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCW0vD5LGqeQpDxuca6bQobb+/5bHo1utNn2MoFaTVLyNbBuEq8vFMX2PrLDXjj7FJjFr3qNLdue+tvFHxG7KPY6BB4kgDgIiPWRylGlHzMh0UuNaARIi22j6XjN2rbxDn797/vj0FKOXz3/1hlBJcjCZ6+k4LJVdT/4LW5K3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCzEWcJL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-207115e3056so9370665ad.2;
        Thu, 10 Oct 2024 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582274; x=1729187074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+jlGybBZxdqFMaVmSrBN0CYjTmN1Z4Nta9bwH1E2Xg=;
        b=mCzEWcJLCvX/aukPxv5HHExG9wh+rDGHQbLiEVXxajLN2nhilZdBfrkxma8CBsnQnl
         hgcsvgiegWEBNAYt3A3SuSdM8PdA6HVSckUQxAAK0mb7aDTKBjuElcG35WLK488zEafa
         GVobXqjyNjdZ3FlFIo7jUxTzCKdMqy6UOMId2ZHFxE+qJMmBfkUdOZy3WfCa+x77YM/p
         Eh4qAkE/mm6rzqeDE7wBdB8qGL6UEctTilFyQjjGtuVWm/bWk8ygaSs3FAD6rFKQfI6p
         HNI6KFWEiej/tbsKOJIcVYkYwwun+VphV6TUVDjRj+kJ2CD/JDjG4plh8y+iBXKPMIuO
         n2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582274; x=1729187074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+jlGybBZxdqFMaVmSrBN0CYjTmN1Z4Nta9bwH1E2Xg=;
        b=GEEsP/GL7tFDvNBFOciE1z1ElY4Zzw/G0grb6iYKxRlVb2YksrGgphNLWocyxoMeSc
         z930KgGrVxcdRUaE6++LEA/ep+szcvPBzANrTCpYO9/WLX3033En/Y07Pa2kIgEs0yf3
         g24r8mb+519l0WsUmggmhp8oF+SnipDIqdI9CSXCGJA6PLNYOelmz1VSVplNJhjkDW3t
         RcTGK7tLeoNF0djiBBDHfXb6G82o55YDq+STJxBw+SiYGB9e3Eia7T01rc9Hl4aoHwX7
         LtrxDc2NYu8EchAPJQKP5KMGlufyVpMGGPMF7fCxShYHtbEI6fibb9IzqNd0i6jrPTkM
         xOqA==
X-Forwarded-Encrypted: i=1; AJvYcCX9WJowAD1sqr0liMqQOVzMYohyZz0RkYxj6e2DrsbD2e76I4fNSQlpWwaCEcb992lZ9jwLxFVfyTnDldU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBZMXsUroCUPMuZSNwItPZy9/6SRv6ZwP6oBmSVQvCUJDsga3
	QaA//BT61WspLIZ9Oi/o/an4j/IvzxvD39L9KsIlrq3XOD+R9H28UB9Hw1J1
X-Google-Smtp-Source: AGHT+IFX7bS4F7RJ8uOszGGrmUetDxkHmycvZd45t5y7AS4HAIPXd/I4hBzF1uervJe26Tx83c0ilA==
X-Received: by 2002:a17:902:c952:b0:20c:5508:b64 with SMTP id d9443c01a7336-20c6378003fmr89663725ad.47.1728582274310;
        Thu, 10 Oct 2024 10:44:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb470sm11826495ad.126.2024.10.10.10.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:44:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv5 net-next 5/7] net: ibm: emac: use devm for mutex_init
Date: Thu, 10 Oct 2024 10:44:22 -0700
Message-ID: <20241010174424.7310-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010174424.7310-1-rosenp@gmail.com>
References: <20241010174424.7310-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems since inception that mutex_destroy was never called for these
in _remove. Instead of handling this manually, just use devm for
simplicity.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index f8478f0026af..b9ccaae61c48 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3021,8 +3021,14 @@ static int emac_probe(struct platform_device *ofdev)
 	SET_NETDEV_DEV(ndev, &ofdev->dev);
 
 	/* Initialize some embedded data structures */
-	mutex_init(&dev->mdio_lock);
-	mutex_init(&dev->link_lock);
+	err = devm_mutex_init(&ofdev->dev, &dev->mdio_lock);
+	if (err)
+		return err;
+
+	err = devm_mutex_init(&ofdev->dev, &dev->link_lock);
+	if (err)
+		return err;
+
 	spin_lock_init(&dev->lock);
 	INIT_WORK(&dev->reset_work, emac_reset_work);
 
-- 
2.46.2


