Return-Path: <netdev+bounces-115879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43979483E9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB3283AD8
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBA116C69D;
	Mon,  5 Aug 2024 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5IfdMbs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4814D70B;
	Mon,  5 Aug 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892277; cv=none; b=nvh6FFfPZ2NHJyE4HGkA6m/PMwc/qHF4ijlp5HPEGhwzz6+lHz7Np2qlprYQ2S6F97frpSuU7EMtvS464FOiPa82+fdDb79NPjrup/w16+FyF+XR60VqKiIjczS9HLLPEyzPiYLiBjs2F77n1lcjG59D0l5+bHLXIKuol2Flf0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892277; c=relaxed/simple;
	bh=hQabHMy4psBrvHis0F1B4A4EiujC5bZfg6VXIHoK8y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jiLCZdNgxQ8hvHCME2U3TzEUmkZ7Xozjm6lSeXVuRas8OmcpLItcrgoJnRUE2rQ5ndyJLEHlx9O6bJkg8NemyS9+rcXpwXhMYTq9kl8TnKkT/hmjuh3aN3Jc2AxYq3iIpxxRkamMO9ShAVohpSmixU6gvkZYTff5Hy6Yhyl2Pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5IfdMbs; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso134605711fa.2;
        Mon, 05 Aug 2024 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722892274; x=1723497074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Zwqt8/bLbfHdBJF+3oP5YWVcy5Uz7uXtijFz/7numo=;
        b=M5IfdMbselnrZdF7eFXi4frZS+tl+1rCVPikPwJ/taxbUAn5/tsK4PSSyPpUHtlT1e
         JLRf7PAEQGzEsZHiX02koKUb4Tc7zxouSvYh+5hMxLGLkaW8irdtTDrNgBwB/dw3fGTG
         dUUO8nDqhBewVo1tiQVLelTjOytxis/WEbdFwih2NFxYoz/awIB67qab3peLi6jgkSO9
         Blf9PzdtYEdSFFQQdmxfRUtZVbxAfi1pM+vNfJGNp0LSXxzFNSwYxhMEjVpyKwfjJhuw
         cGbyOYn/el0qy2bay8ZmNxYnFucEIDYfOhmnl3rcM9QbPLhu6rNyvm8bVBeli8xAb7A9
         BE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722892274; x=1723497074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Zwqt8/bLbfHdBJF+3oP5YWVcy5Uz7uXtijFz/7numo=;
        b=NvEkfEnlhzcP2Ph0ckvLKbWcV85Tndl5WV6Iksx/9yb6z5bEHhc6LwpaewWL5b6UW/
         aISiblRmNnVES8bvp1dhA/F/jFL4bEtCPfRVWzlOBZkTrUFigWAaHW5P/YnkoMoGuXGm
         YRdsU2O/RoXpvahVINUT8CjhUmoDCeUvM6ywbrRHCQC2Ft45L8ZlQbfuF778wlXoYA9q
         9423qFPwh88uH0CTilEAkYUMXUS+ke6mmIegLPRvrSQi5zz2l3BMR7Evwc1HBsAW673q
         5l3BArcXhrc/U19RzPCTloU5tw7zW1M2/bYzMfxBz+5c//QJ2eUnrA9rZXVlZcfnhrHm
         vHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3r0nwq6fFoEjqMUO4YH7ln+hadZNl0r0Lwa9DyNETU9SSRhY5wZD0dANm+cj8t+R7D8vKZ05PhFbqzp6nJElsB/bTp6AsrFpSlgvO
X-Gm-Message-State: AOJu0YyeNSycBfCkP7ElQ8KFgmylo5DnM41H9BCHp4RmoBECHAu5LU+J
	gB6KwE8yobI4ULl0PVuuvPFSI4UFwfu9t9fSFrM39B8HAcN0bcn8mMew+JUX
X-Google-Smtp-Source: AGHT+IH1N3csSwDvdb5NczVAwknZFRFz0o8ZQMFvrp8o57hPR8tHdmUoQZyC/PPxeMVR3WZbrXwM2w==
X-Received: by 2002:a2e:91d0:0:b0:2ef:1c0f:d490 with SMTP id 38308e7fff4ca-2f15ab0c2a1mr92199911fa.39.1722892273644;
        Mon, 05 Aug 2024 14:11:13 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:1688:6c25:c8e4:9968])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1c623csm11875291fa.63.2024.08.05.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 14:11:13 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/5] net: dsa: vsc73xx: pass value in phy_write operation
Date: Mon,  5 Aug 2024 23:10:28 +0200
Message-Id: <20240805211031.1689134-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805211031.1689134-1-paweldembicki@gmail.com>
References: <20240805211031.1689134-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the 'vsc73xx_phy_write' function, the register value is missing,
and the phy write operation always sends zeros.

This commit passes the value variable into the proper register.

Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - Fixed 'Fixes' and added 'Reviewed-by' to commit message

This patch came from net-next series[0].
Changes since net-next:
  - rebased to netdev/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index f548ed4cb23f..4b300c293dec 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -574,7 +574,7 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 		return 0;
 	}
 
-	cmd = (phy << 21) | (regnum << 16);
+	cmd = (phy << 21) | (regnum << 16) | val;
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
 	if (ret)
 		return ret;
-- 
2.34.1


