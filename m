Return-Path: <netdev+bounces-119596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046259564AB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60242819CE
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D515B0EC;
	Mon, 19 Aug 2024 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7WWMirO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7874115AAD6;
	Mon, 19 Aug 2024 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052402; cv=none; b=bYgnZg4UoNwzPiAmo6kw2DMiw77oI4TYJ47RsO7A4tQohGa33dNbAppsYPgZHsjdNsOA3Bs51bhfgj/eyJ9m9IqinBkTqNs/u7L4EwbRk/tVMIIQTR1QkDt84twJcRpTpZExcRnkeAzxLLPF/XSJZN7Jx2qkvkW/5puZRfkZYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052402; c=relaxed/simple;
	bh=EIGbzcgwScE6AbghS653jf3cZ93S/GClvOAWlZuAcx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZ6VNhsQk3rHvdDirAy39eGwORfIYndwnUjXNeTPEQh7ixGmnK054tJ6Wvf/IRXHEU1Fl7RaFdccTaiHIN8PJY7SytTuFR3+1qq95kcSk2Z0iKXDNTo5aQGrOg89Urg52WDML8nlt6CAUoFrHXourZy72LLjYycmDYIleA3UMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7WWMirO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c9a2b339a6so936726a12.2;
        Mon, 19 Aug 2024 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724052401; x=1724657201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Udk+s3Obbj80Cans5TjOJ2DULPf1NEhrOug0bVeCQAQ=;
        b=Z7WWMirOx3VdEBTk2A03BsUpkcbdgzh9s6sBiOovo+mB5JFciqyKFjnIXHvEvyvryx
         QkSy7QbZjzTbYTEgzsWOZ8Q5IPRIjOhYdM2w/KOfIDl3X4spSp43wJs9kIteHJTg37r9
         kB48/GshMrB6XLxzFnRgVkpvzVr+6JmrgvL+GIPBOA0nfKsyjMj/8XSowdzxEDGgME0D
         25HxJy95uhQn9LP4SEnGNHCRMwQ5w9/tlb4ogdauFayNyTaxk099EeF9ezY0bLeK2AZK
         93baaHo6MJgWWkaAUEnTFgdACwq8duBFr8LGFhzU9z0w1gtQLDEy/TbOeXI3yXAu+cr0
         +ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052401; x=1724657201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Udk+s3Obbj80Cans5TjOJ2DULPf1NEhrOug0bVeCQAQ=;
        b=obddsF50eypUVsrzXUxoOt8/5ddGvUy9oOh8IBXjX8hNkyqYWx4xUVg3KgLD916EEg
         692hJ9qe+gRaRlORDjoBT1Bkr507QYrpeLRV5E0sgzq05NVXShp2VoElefVTDJQVj++U
         SmcFl/j6uzojrI3zK92ykxMwZp0pCq+7j+f1ePhnQ21PGsSkRRTvgwbLzAlWR5f64VEl
         imp8xDyJY3wsQkahjRY+s+bgLkZ4bKwqJcZq5k0HaN2clD70m0PtR1LjZ/uagrx2hpxO
         rcSTQ5GQgaqRgO56bN0VCEM7hVmaBeXtIQV2e67FcWLRfNEo5NVyURdbDdYfoL4LV/oE
         8tGw==
X-Forwarded-Encrypted: i=1; AJvYcCWlFseWK08HogPivp6eZbD+k2ow7sP2MohDQLmMWEsdRDAk4DuzTbpjIcNe0CNSylbsf7FjjwwuiaoIrkLzdPS2sndQmKwvRsxCjn7f
X-Gm-Message-State: AOJu0YyqtvEEzcCsy9sK2/Jx2IAtZ6x+o0kly9Wf2duU49VBSC70rIcy
	FBKdLID7qpB25BGyUqri4OBtt8m1kP6TZJ11sPb2FMjO553reCKrkN5RRg==
X-Google-Smtp-Source: AGHT+IGIrHqMvl9AmE+Jvkoggw+jp0THIJUSZAYGIWSoj/Vjl1XvI9jSe7HM5SVRQljCKll/m9DsNw==
X-Received: by 2002:a05:6a21:1693:b0:1c4:b927:1ffb with SMTP id adf61e73a8af0-1c904f91af0mr8704520637.17.1724052400562;
        Mon, 19 Aug 2024 00:26:40 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f02faa5dsm58340855ad.2.2024.08.19.00.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:26:40 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3 7/7] net: stmmac: silence FPE kernel logs
Date: Mon, 19 Aug 2024 15:25:20 +0800
Message-Id: <375534116912f13cb744c386e33c856c953b258b.1724051326.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724051326.git.0x1207@gmail.com>
References: <cover.1724051326.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool --show-mm can get real-time state of FPE.
Those kernel logs should keep quiet.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index b6114de34b31..733163c52f97 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -620,22 +620,22 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 
 	if (value & TRSP) {
 		status |= FPE_EVENT_TRSP;
-		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
+		netdev_dbg(dev, "FPE: Respond mPacket is transmitted\n");
 	}
 
 	if (value & TVER) {
 		status |= FPE_EVENT_TVER;
-		netdev_info(dev, "FPE: Verify mPacket is transmitted\n");
+		netdev_dbg(dev, "FPE: Verify mPacket is transmitted\n");
 	}
 
 	if (value & RRSP) {
 		status |= FPE_EVENT_RRSP;
-		netdev_info(dev, "FPE: Respond mPacket is received\n");
+		netdev_dbg(dev, "FPE: Respond mPacket is received\n");
 	}
 
 	if (value & RVER) {
 		status |= FPE_EVENT_RVER;
-		netdev_info(dev, "FPE: Verify mPacket is received\n");
+		netdev_dbg(dev, "FPE: Verify mPacket is received\n");
 	}
 
 	return status;
-- 
2.34.1


