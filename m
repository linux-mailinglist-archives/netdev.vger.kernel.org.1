Return-Path: <netdev+bounces-246831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F405BCF19B2
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 03:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 714D13009F17
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 02:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EDD30DEAA;
	Mon,  5 Jan 2026 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHiu6se8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518A2BDC13
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767579008; cv=none; b=Xx2wHETaD1RTpPEIZxFiVhHG3Db5D+YFls+5lLQR2MSrW275T2nSYJ98PHMWI1NonEOYVTveDVVw0yV7cpgp895TQQ/87fvSSV5gEnkLKU46go/ceg6H9z2AZPjkMiasZwm+s/JRtzOsrlkOJWZDKFzvhZqUxvKiXQu8UVqNaJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767579008; c=relaxed/simple;
	bh=mHd5/FDiQ86yScP8/xKWBTcg+ow54G9KDtNwccSg1Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAO+FXehbvLRj8zUVEA2m4sOcpkbPUayrs5+wmEhvF6PKa2RMJK8RkSbXnvcvuphqpRHh0US6z58TnOAWsDWv43P9eEqG1uPeK+9cERVe+O6mutk0+HQLWOeJI+A9LaTEiXdIIltB2XzFGaJsM/xxJap9nkZqRxniQd4isl66rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHiu6se8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso787715a91.1
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 18:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767579005; x=1768183805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qykhmziqocBs83eOMsCXS+riegj3dQCRKqwsythsgqI=;
        b=aHiu6se8cpOvOqDc9GHV/ab3HTwsRuYtPOi6sJs0udSrqjXBXddSJ9XTx8qDx8gOz1
         JjH8/O8/ORqxIWSl26yArqg+yDm+A0UOI1lRHReNCxE18wtRJ5ONbudC+zPbO0YnZ5mW
         suGB3VCHhgW0P2dIMO4UVZgzo8jTZPrC6HE6RkRzuDBcCCpE5vmQqI5+mTm6g22pwYN9
         Zs3cwx3P9xrcPBIZSb9jPBk3cYGaF/ebv4Oxe2EkZLNFPVFPCMQSb1DadG5HrqZm34+F
         lcQT0rP7EKrMo2bVAXCkHDsw33uT5qIHbUIRFcLVACpwYPg560dYcsEVBlhXcHedON3G
         wfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767579005; x=1768183805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qykhmziqocBs83eOMsCXS+riegj3dQCRKqwsythsgqI=;
        b=nO2LMbwfLu8RjC5hz4olSWa0OJaSyRudeFQQ+lMzeV4zzWK36NKJHMW6Wr4ejIV7hc
         cnhZAM96mX8w89NGpfOqKrQ/4kQrnMZt3SnEZLPNsdeEUwWXyTfpnIgmJ/vkQn0GKFIj
         ihMqs+x4HbIBqhk7UyzWVaCc8GAA1na12oP/L+0DNT78K5ogugIUSMsDNrLcKC19sVLL
         LODFMMPLxUbMzU94iBRK6X9U/iskxO5Hs0Ogf6QPb25RlySVG+YgKXUgzo7UKT5WvwXE
         2L1FDf2lH015BTLI5IoRG9p855r1178C3wP4hS89YEo+TyXnWfkknuC8jRqeGnsouO2j
         BsNA==
X-Gm-Message-State: AOJu0YwgYtOwDUxGcr6u8zJqae93W12mWGA4mtUoqGeDjm/aG7GFIlHI
	mnMJ0vX5ceOQfNJt60rFZCFlJXA38tnJ8sCfmqrsYRAy7CFSU/d9LjKXa1csLw==
X-Gm-Gg: AY/fxX63UEiCgmUBqK1KYKjDHifO5fU7rWNDNfPVe5BvfGSgyqXJGjChEcc8RCBMIxi
	czb0j/zf8tkXpcetrEQXK3K+6Koif9OPXRAVUcsigYvHY6DLJx9c7hTScRB5ikLOqLdlqf/7sY6
	1XksTBDfHZC43CcTsFniP2YxgF3Kk7xQmfGw3g0yvYafEr1wm8Kva3x3+sn7fZTyPkcvdJGn7sP
	IqS8edxjsDLMJstFoiMU1LEdrOglQ+qnbJqFVyquIsOcUrsCXLoaMni0AOzA+zaURjuZvfPbH+w
	Ao7cRw31ptjmmp4nTQovEkNb5RC+uIvy4cmId0r9kU1h+iz4hh+56qWrqq8slLWnRqhCduE6TiO
	0Uls9okCvZe3FyAVqhf0b9wm7kbrgDi7yUGqRiUEL4Lf64LDRbppKvY5JVozHs6v7+4LE8IJK/k
	wsk7fhg+CMy/2oRbIuDAS708cvbWCLLoivV4vamjpCzAdyPvd1X1umEw==
X-Google-Smtp-Source: AGHT+IGOQour0NkX3syOiO+wHoNuBNONrZarwLKTvm0Dywz1DdFpKhVE2PPkSnu+G8zeuD1+IqheaA==
X-Received: by 2002:a17:90a:e7cd:b0:34c:2e8a:ea42 with SMTP id 98e67ed59e1d1-34f4537d9a4mr5221185a91.7.1767579005234;
        Sun, 04 Jan 2026 18:10:05 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476fb838sm4427102a91.7.2026.01.04.18.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 18:10:04 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next v3 1/2] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Mon,  5 Jan 2026 10:09:00 +0800
Message-ID: <20260105020905.3522484-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105020905.3522484-1-mmyangfl@gmail.com>
References: <20260105020905.3522484-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by the following Smatch static checker warning:

  drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
  warn: was expecting a 64 bit value instead of '(~0)'

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 0b3df732c0d1..5e4e8093ba16 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -682,21 +682,22 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
 		u64 *valp = &((u64 *)mib)[i];
-		u64 val = *valp;
 		u32 val0;
-		u32 val1;
+		u64 val;
 
 		res = yt921x_reg_read(priv, reg, &val0);
 		if (res)
 			break;
 
 		if (desc->size <= 1) {
-			if (val < (u32)val)
-				/* overflow */
-				val += (u64)U32_MAX + 1;
-			val &= ~U32_MAX;
-			val |= val0;
+			u64 old_val = *valp;
+
+			val = (old_val & ~(u64)U32_MAX) | val0;
+			if (val < old_val)
+				val += 1ull << 32;
 		} else {
+			u32 val1;
+
 			res = yt921x_reg_read(priv, reg + 4, &val1);
 			if (res)
 				break;
-- 
2.51.0


