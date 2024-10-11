Return-Path: <netdev+bounces-134693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219C799AD47
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEBD1F289F3
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDED1D0E3F;
	Fri, 11 Oct 2024 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHr/btNx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1C1D0144;
	Fri, 11 Oct 2024 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676799; cv=none; b=TUBtbG+Hkt+STLw3rR0LScE36dTmpWGUmIxuV4SUGlvaZk2xgNIbxn3DLuZJCRkf5eWH1zR9q7rAqa/xS2DQ4pmxjra7dR7IrjYqO/2KZhqWtPkboyeIldmCQF4tuSHQRMuaRVXnCcLUt1jbaJ64KJlbQaa5B0lZjAdzY/1Ii9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676799; c=relaxed/simple;
	bh=vVCVoCLAV8tDG1vrmL20knT7+oenmQWjvXusuYrvcQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tzjq36uwK+YBq8x8JerrByTZR1PrQYMbDXGvldjE6t4EQ6+Q+OAdnv/nQgNPUAQkQPB8zEQMq3EpaYfw5dzE1XBZ2eOK+XsfOpLjWL5wN77Rj7Fm+xWZk3iehPXiLXS834b/p+7iU2ARy6ng+HHVzOEqx9a2YHjV/Hlc9yAhJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHr/btNx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso1574255a12.1;
        Fri, 11 Oct 2024 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676797; x=1729281597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=roNqdHIBerBblm0SB/SPGUSzXG1uDPhqyUKFuMAssw8=;
        b=cHr/btNxrDhufSzBrQlKcF4JT3RyObCibn2amSkz0TVuGCImRZb982nbJpVR0CeNL4
         FENbEISTbWtYqPTNJyhWMiTzQkLwId6lDRtAuBTviaMqVCRviq9htlmPpOhjlGlawKrg
         uq6VITrFAKG4LrVxPQIebDt++sdRfF6wg3Mr3yRsJyQdFPgODYAZizJOFirXeBmclYBH
         RwXfG7jXwWw+ibWC3KGZ7ZueQVzNGLTZDLrj+SxaJGqfsaLJ07fh3388TMYU0qbYehBL
         1FC5vH2riu7d7qL2zj2nlnfIgUetHcWbw4T0pXfHbAWt72KVQfWhQ3WHxl+MFa0j4ZqU
         68yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676797; x=1729281597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roNqdHIBerBblm0SB/SPGUSzXG1uDPhqyUKFuMAssw8=;
        b=c1yDspgIAos18a20mPi5Bp04XeqsrPfG0mkzBZVUTJ1zYIaLTs31qoqTSrWeqQKGl4
         x88gewNRmUbpFexDXhCGy2IyNDbUNm1qhS+Z0nOgMx8XzlSVZX660qKiNn0Ni2D1oqlr
         VcvZfj4Dn+hyps6wEJKatnvG6qoRv+yHmpE8jpNo2MvfINkvG4X9r98E47kTaeFf62g9
         Pl6RJ8Jbvftka0EG6eD2vHCOAQo38QJO/NJNjwyg9plLVjNerC3fh44dEn0u+ujBN3LQ
         iJYMnsf1GDvKE35mEfj2kbqjjd9IqLMbgpI38PieRx08Lw8Nym1/obJ2rOARon/qXvyz
         Waig==
X-Forwarded-Encrypted: i=1; AJvYcCV0JKhJEABno7Mj5O2r84gCeWfp61MwF6cnETzk9UyOUuOcjMAeKdOXuopinGui2zBcdwZ5cqblniyxMQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZuQUJoO3yc3/+CPNRmgbSfNZCR62yMA2iip//Mjs8X2+FIffD
	E4ihd0GsXej4KsaLrDvcyiPhvCWHWTEYunCM8FtS7w6SPxpFn1xc9UgyKvx1
X-Google-Smtp-Source: AGHT+IEE119MsCw3EbNt2UyGkiEU0LPU2ECsFp8kEDcIBoCpB/almBfsIhdvAl2eOSQNMyE2OGyQ7Q==
X-Received: by 2002:a05:6a21:3514:b0:1cf:31b6:18c6 with SMTP id adf61e73a8af0-1d8bcfc7f96mr5635301637.46.1728676796947;
        Fri, 11 Oct 2024 12:59:56 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4868e657sm740684b3a.67.2024.10.11.12.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:59:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: mvneta: use ethtool_puts
Date: Fri, 11 Oct 2024 12:59:55 -0700
Message-ID: <20241011195955.7065-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows simplifying get_strings and avoids manual pointer manipulation.

Tested on Turris Omnia.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index fcd89c67094f..7bb781fb93b5 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4795,11 +4795,9 @@ static void mvneta_ethtool_get_strings(struct net_device *netdev, u32 sset,
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       mvneta_statistics[i].name, ETH_GSTRING_LEN);
+			ethtool_puts(&data, mvneta_statistics[i].name);
 
 		if (!pp->bm_priv) {
-			data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
 			page_pool_ethtool_stats_get_strings(data);
 		}
 	}
-- 
2.47.0


