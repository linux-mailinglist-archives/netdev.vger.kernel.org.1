Return-Path: <netdev+bounces-94808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30A88C0BAF
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E23B28487A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 06:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19E13B2BC;
	Thu,  9 May 2024 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zez3NFdM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9379BDDD9;
	Thu,  9 May 2024 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237428; cv=none; b=FrDZyYu7YvPUIPfozpePZQV0yrJ0qzHic1WF9irAG9NzLtdTjyAUo/n7Q8QhEWB1h1uDHmu0XPvwlcXpO+suDvDsTwM/rWHQtOeVcE9zmQdCHH0gjYi4/WnmLP1zGZUYToIyKliYHc1K/+U2CF0F3lrETr4frTY1c1ggF7Bf1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237428; c=relaxed/simple;
	bh=RSeqe6ed4ewdO4stMEjsqV83ww4odGvJX+LQ9kccDDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Nq5/uhK6jJ8zpow/53Lyj/0bQmBbXJCSXcG7vcSRQ7xZNfMsifxedsXSqQSEkt+CVUitWij3iI/FsUR1WI3u04TOz6nDkDfETzDHko3E+q2rMbjlJzGULLJit1yEVDWLRmi8YehmVPJ+gh/tEQUDJ+VNR2UvQcWi1OaosRghgiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zez3NFdM; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e4b90b03a9so6674971fa.1;
        Wed, 08 May 2024 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715237425; x=1715842225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2UOhhsJgb99pm27SXHK1pVf/ykOOg5LTm9pRGDO0Fjs=;
        b=Zez3NFdMeQnGYCiu7MmJe5nvUMEpBYbwDLmI/ZdVXg2qrU+MbE9/7u2BPsam9iPzB0
         kD/GdYtPlX1Jyy5rMA7ez0Bm3BFclvBm3/LEGSkpcIbtTilFfgXD3wz9pqMba273qCcS
         fHqtOC8RpJpOMhTiOM02vIMseqf4smHY6CWT8/Be4OoMWqRkgarc0yOvtcwrgud6pkzr
         /WXQU91iYi9IKcd2L4ATJTPLkhAc7AcTuEYCsR1c16vqqX17T7CGSVlyuvD5AfQnmnC2
         YpBOJHAfMN/w3Ms5tfvAKKNENqhZ+dU29dl1hLdwM3AtI8P8sggwQD0f39pH9FZlZaBa
         03dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237425; x=1715842225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UOhhsJgb99pm27SXHK1pVf/ykOOg5LTm9pRGDO0Fjs=;
        b=SPbGLQQ4l6fT5is9jtKcVwXdkWVu6cpz3iqO9+izVYRFsx+s1agge0ldT6dC4SoJ+U
         y6sahXsQxOn+ClmfPJo3i3YDSSlXJm8gBvcu1urkPh/fZEROmNX22Kcucj+9qpnc1/yg
         qxTJHn+hnbggCyNx8YYY6PteA97HTtEiyVDZSF3voztakY2zBiOlZXr/xoOBvKs6J6Uv
         Phmrem8iY3lxQwEQniCVmImIOm+E2/Ilo5uGkrp/4P59aFm6051nyOgkFXIj/QqODQj3
         1f7USZBnh94bGTuAk7CbECz6ZsqA/JmMm0BRI/pOYSXWUZbos01BmwcynC3Yx2m5LrMl
         am5A==
X-Forwarded-Encrypted: i=1; AJvYcCWMq3YRte85F4Smc8eWU+uQIRZGBjdnfNFe/S1NVJ+5n0PtcRsbHlYmNegbTJmgmBmGxwiBC7/2dl8s8drYCdiH0nYMl0FmeXMMOQJJLoB5JyrZYwd8H7K6LzEGAU0tFgk3keUT
X-Gm-Message-State: AOJu0YxiWMyJUAcWRFR9rrscM4/XrMqpDvFGxC37np7I0a5YSCwfl+iv
	MroaIu+Md0NvI4oKfAIzsD4xhX7W1HANSeQDr4oxb0QOAOjgQP//
X-Google-Smtp-Source: AGHT+IFdtu14ZmyI84Ks3pnhLvcdac1FmVj0U13JvxDP7AMPhUTOAmsM9uMthlsZwwvco4EdRUWDNQ==
X-Received: by 2002:a05:651c:b29:b0:2e2:db99:c35e with SMTP id 38308e7fff4ca-2e44738a829mr35982021fa.12.1715237424463;
        Wed, 08 May 2024 23:50:24 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa9dbab53sm31431165e9.13.2024.05.08.23.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:50:23 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: dsa: microchip: Fix spellig mistake "configur" -> "configure"
Date: Thu,  9 May 2024 07:50:23 +0100
Message-Id: <20240509065023.3033397-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/dsa/microchip/ksz_dcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index 5e520c02afd7..484945a9c5fb 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -220,7 +220,7 @@ static int ksz88x3_port_set_default_prio_quirks(struct ksz_device *dev, int port
 			return ret;
 
 		if (!(port2_data & KSZ8_PORT_802_1P_ENABLE)) {
-			dev_err(dev->dev, "Not possible to configur port priority on Port 1 if PCP apptrust on Port 2 is disabled\n");
+			dev_err(dev->dev, "Not possible to configure port priority on Port 1 if PCP apptrust on Port 2 is disabled\n");
 			return -EINVAL;
 		}
 	}
-- 
2.39.2


