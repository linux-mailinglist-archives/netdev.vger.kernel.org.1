Return-Path: <netdev+bounces-115881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3781B9483F0
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688811C21F54
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3543E16EBF6;
	Mon,  5 Aug 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/KV4Of2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085316EB47;
	Mon,  5 Aug 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892286; cv=none; b=fFTlcoI5xmxzp4GaAwqVLQn8Z6vvx8u5NefXbQQhi3WhMkI8ufhXX6pNa7Mp8iIBgqPKkE0Yqi4g1Y7ke6d48UmHK8UC2zudYT4iWI8q7ZB4bMlwyAn5/8EhGR8lUXjnU9mdUV8bDWBTNOzUu8udmbzaBdKGD4H8pWIgWQd3Mg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892286; c=relaxed/simple;
	bh=1gQxs+UNOGqF6wBReqyL+fF7+isnm8hfuCRfNCWQbMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qW2M4jbqPc19u1Db3zeN4Xll2aqbBQ3EhTi+0a+t6uyDEfjave8hHmMNTe+pPoyrkq9egK6Ke4I8+X7joSZoBRJhcoNgH3uclxiDOvhZWdbvCIBItkUNIu/4GtMjES2FOOLWgIXhgeRbnSVHPhtsSQdsUzZPnQ4zLMZ1NpLNgMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/KV4Of2; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f025b94e07so136966521fa.0;
        Mon, 05 Aug 2024 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722892282; x=1723497082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JzCWfQFKUp8i2Cztl/TZyMNMAdsn3odVdeh7PxquhA=;
        b=E/KV4Of2r7OdSkzLX6dtN9OuwZtVAVKZsfIJGKHrhWSkvXx0Qams9rEczHPA1Z2SI5
         ek+AjanTjfr0cjx9sprc8jIr9iIlAGNW+jaoGzVuk80hJ57xjemwJ/mbBXelvTCjOBB+
         SNRi3MSpaB50+n9AYZ+Rw6pI9Vn1uvU5V+p1+czSj+dFYuj7+RUabs+J8bTrGGQlu2T2
         jmaEr+X04poMsC56dtwF9wVS6GaWz8a59XMG4NZmyrRMznJjYO9L8shoxOhuUmH215M6
         QfkdN7leziElJghOBs+qnp/NjSHaUL4TagWaErtUgCEGGNBrsIM+IfjsH/1isBdWLjgW
         NsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722892282; x=1723497082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JzCWfQFKUp8i2Cztl/TZyMNMAdsn3odVdeh7PxquhA=;
        b=sCCWvr9C2gsDeMrH5a9ZhLMCftJ9GHivKn6Kc+jbbc+8yitOrgf6//fB1qVcSYllgI
         UkR2Sxc6xzLPaSywJp6VmHqaIlXq74YFrQ0y5GnryKr4ZhS3lmg1toBefa+0lf6XHg1W
         Pt4fxR80nwbpeg0HE9eXE5G2E6GvAMYOBSaiO1p7O/6FnK2mZaigIz2H5VlDlRmjWeS1
         nBZ6U1GkHZRq5vrPv3TyaOz+JpVHbnZnTXy3ziQbGSdrrvMwNi4kAKZ3UvgQM4mBwGSy
         JylsXGMZLRfihzqg6WwAKoxeWmQYP3xHBkcmZS1BqjazzbGGlndEoyh9TtGocl5onSdY
         ZcmA==
X-Forwarded-Encrypted: i=1; AJvYcCVvqj9T29M9iH9PXh/pdp2gx0y1PGRYKp9ldbzG8SfK1s1ianR6nTt36AL8/yyvl0VeGqgzd3bAbkAjez3owfBvHxRTRPVGtgUQlmIf
X-Gm-Message-State: AOJu0Yw9EqekwfdWMS4mch+E0X18OaR0Uch1bxET+m4axs0O3QS1xgDn
	VvCtdBpk+SzOlHAYElMkkqqIXCYouStLnUH7lpSnd2O5vUxgmG/kv740tqXU
X-Google-Smtp-Source: AGHT+IEyGfRvxnmQKGmshzanHwVFvWNSoJ/eZpMp+F5CX54ffiFmAeCefDmKcuqaZmzIiVNK6MtjIA==
X-Received: by 2002:a2e:9b4b:0:b0:2ef:1f51:c4ee with SMTP id 38308e7fff4ca-2f15aa85f8emr91992901fa.9.1722892281835;
        Mon, 05 Aug 2024 14:11:21 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:1688:6c25:c8e4:9968])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1c623csm11875291fa.63.2024.08.05.14.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 14:11:21 -0700 (PDT)
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
Subject: [PATCH net v2 4/5] net: dsa: vsc73xx: allow phy resetting
Date: Mon,  5 Aug 2024 23:10:30 +0200
Message-Id: <20240805211031.1689134-5-paweldembicki@gmail.com>
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

Resetting the VSC73xx PHY was problematic because the MDIO bus, without
a busy check, read and wrote incorrect register values.

My investigation indicates that resetting the PHY only triggers changes
in configuration. However, improper register values written earlier
were only exposed after a soft reset.

The reset itself wasn't the issue; rather, the problem stemmed from
incorrect read and write operations.

A 'soft_reset' can now proceed normally. There are no reasons to keep
the VSC73xx from being reset.

This commit removes the reset blockade in the 'vsc73xx_phy_write'
function.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - improved commit description

This patch came from net-next series[0].
Changes since net-next:
  - rebased to netdev/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index a9378e0512d8..ac02927a153b 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -599,17 +599,6 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 	if (ret)
 		return ret;
 
-	/* It was found through tedious experiments that this router
-	 * chip really hates to have it's PHYs reset. They
-	 * never recover if that happens: autonegotiation stops
-	 * working after a reset. Just filter out this command.
-	 * (Resetting the whole chip is OK.)
-	 */
-	if (regnum == 0 && (val & BIT(15))) {
-		dev_info(vsc->dev, "reset PHY - disallowed\n");
-		return 0;
-	}
-
 	cmd = (phy << 21) | (regnum << 16) | val;
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
 	if (ret)
-- 
2.34.1


