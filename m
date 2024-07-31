Return-Path: <netdev+bounces-114507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7A2942C3B
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B181C22FFB
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F981AC427;
	Wed, 31 Jul 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKLVI+dz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EBA16D4CB;
	Wed, 31 Jul 2024 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422631; cv=none; b=JFAi53t55yeLT31bs3lxLtfSj4cqUVuX216V2z/f1TWjqE1sT54Y7HMRT92myPff3j22M+51WmtO8wUKynQ1Iw7FoKGgxKqxb8dvNeUmxXNju6jPJopQjoqH77lXC3HHMrE74l7qSTqoB4tavExYS7rOE31oevlY60Hnyx13Szg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422631; c=relaxed/simple;
	bh=CZpbxjYakAqKKHm1+a5euY33QbkxnqhBmouUV1qwPtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sXfY7Ct5B0BgqEGtqDBxFgvJJqcYcMmdKzoN+NTgPdU5FRTFwMAPXCaArNBEZwAf+dnpT93joXiAwRHWHpycvTy0ybgQX7ib2S/0Dj3nX8HXko2XXq4Czg5NVlg5qgZfHFg7HrsTN8xLCWaKSFkDoaTsAcI//Ai/lEszUKt1r/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKLVI+dz; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-704466b19c4so3384836a34.0;
        Wed, 31 Jul 2024 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422629; x=1723027429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yITlV2EmP04/pdfMm5rgZ7lDN6+U5nqKkJKbXuYj7Jg=;
        b=eKLVI+dzX0C1j/rdMaQawA48KeHpvPWaPAh1JP7dbEOAXK/8XZ6S2XzvqPn5koecNR
         fMLsYD4NiZ5yBvojw576YYjK/Kfxp6n9fpXf4aMaggXNuKy/2NrLKQwzv5tN+zhLjpt3
         L/0fsvDszsSLAQcP9g8KWQmkWcGZm2jSjgHm08pvZo2L/P604Wn4Cjz+KDuyn7vNCXAN
         ZpRM6Q1h8djed5LXKm1JHhXzQe8UblbN40eAH0s3JfyZTKgsDnDNcXzjX2YtzsqJ75fW
         mqhOX2h3V8y0721xfzb1AdlA7vs8r05284UAsnQfADRn7W5RfG9XTDs/9bAkmnqmO3ut
         3fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422629; x=1723027429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yITlV2EmP04/pdfMm5rgZ7lDN6+U5nqKkJKbXuYj7Jg=;
        b=jqVCUQe8NPM5LkaqWRZL04Pq+HqxKFPUPnIS7uZP4PgMlzfruwq21E2EpLvXGNHDCL
         7OQ6cd3hISLsp1GxRj49f89pInrW1abZe2VzcBRf74OBtL4XXaU87GFVeH1bRJ3DMWQX
         lIyFm4e+h3L8JJ9/F7SG7e8Nmhr/Ak6VcFrxMEhsi0bMK0+b7mLeDG4jHQKegKH4EDaM
         edhd+akUAPyUGK7qvY2fM+9SJJC5zASheFJc3p08Vve4QKZTGHuFm1LXp9/MKHMR8WCE
         qHH8fqebI0wKjfBB2780bcAG0B3BySN1AzBuXdLen/Ti9/akTg8cGH/eya4ETy0+Y2k3
         tAvg==
X-Forwarded-Encrypted: i=1; AJvYcCWDqHvxpQs8KvswKBT7vouY7j5wydK343Fnyeq9yzGvKfvzsGDor3/8n5/g3zPRtMaMUcS2nl331wjKS4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBaMLVD4GAwVB1gjbYEXIa3lCX4xv+QFjLJy6rIkpYwEaOLSQb
	QREevZRt8Wfxoriz1SDdjhB10vNYTsvFzGm8SnUoLlQvZsv9FTme
X-Google-Smtp-Source: AGHT+IF7lo5715caiO5yQuVUS/Wxz7nFOFtJwBaZnI797vwpaHgFj3G+ha2rUkQ1l3bkOpJG6N5crw==
X-Received: by 2002:a05:6359:b97:b0:1ac:f3df:3be1 with SMTP id e5c5f4694b2df-1adb243f94amr1301149855d.4.1722422629214;
        Wed, 31 Jul 2024 03:43:49 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7a9f816da59sm8791375a12.29.2024.07.31.03.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:43:48 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 0/5] net: stmmac: FPE via ethtool + tc
Date: Wed, 31 Jul 2024 18:43:11 +0800
Message-Id: <cover.1722421644.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the Frame Preemption(FPE) over to the new standard API which uses
ethtool-mm/tc-mqprio/tc-taprio.

Furong Xu (5):
  net: stmmac: configure FPE via ethtool-mm
  net: stmmac: support fp parameter of tc-mqprio
  net: stmmac: support fp parameter of tc-taprio
  net: stmmac: drop unneeded FPE handshake code
  net: stmmac: silence FPE kernel logs

 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   6 +
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  37 +++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |   7 ++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  14 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   3 +
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 111 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  25 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |  95 ++++++++++-----
 include/linux/stmmac.h                        |   2 +-
 9 files changed, 248 insertions(+), 52 deletions(-)

-- 
2.34.1


