Return-Path: <netdev+bounces-55575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52A80B6E3
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 23:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABC8280DC5
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 22:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ABB8482;
	Sat,  9 Dec 2023 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZH7WmInz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B8F100
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 14:37:41 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50be24167efso3772524e87.3
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 14:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702161460; x=1702766260; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyWPxiuF7yNfDwTd55yLH1zdDQu39KIowhnapiAsCiI=;
        b=ZH7WmInzCnwCFJYb3J3o3u96EYuyCld1oe1xdwQvXnJNTt64jykrJwHeZ0VIBTsbiU
         d1oCIvAXNOZ02aUZHfTYFdqKDl4bfIekZ4CjrzLGiYbPr8c59XAk9WqAqSRCP1JnXEUC
         LT7VA6PJKvAw9jsCPSdHl/XL4Q4+dnekaDmvPlE4iXwAUuKpSGg+zGI1B/es2nkriHi2
         B8iGEanEge4QG0WLyVzFARSkRkuLgZ5bGm7eQsuIVbmBvqOUVcdEeFfGH5oAwh8/UX+0
         RDBsDO6UXY9186q//9X/dlwkEnLSZ8JeDG5LnKeAOFXatdhNHRfAO/ZncJI5KPLBAsUs
         h3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702161460; x=1702766260;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyWPxiuF7yNfDwTd55yLH1zdDQu39KIowhnapiAsCiI=;
        b=mWUqjgrPzrd3hUMbsyyK2jlu8Rkp6XCZ5IQ+wGT65CYW97+6z0YPitYUSByBpa6wXn
         CFhykUHIRhWtmOTFcgN1jS6t2PeyGqb27TfaMQhT9MOCUIHpW8J2fWkyeMlHzc2cZZdR
         Bf5wiHYfmNLr3Y15Ez0pAqmmoQfTZrwt+tPAhfDXav/qIKkiPp5nbTwGqSduPkvHG2tP
         ZCS5Msl9umYRD5WhFpoFuxQZXT21uf5Wn4hQ9aLLPnVfgS3miFIDfOeQw0Mqm/50MbrN
         Q+bGu56b1JEw7PTwNBEM7df85vPNto5S9MltSw1zsgMvLJjKvXPzgQ5fYk8iq/YwqjnV
         1y7A==
X-Gm-Message-State: AOJu0YyT2PbBL4je7JjoKQVDrjPG8/PHrP78auyiIoBCUcla1QAicDIk
	xQbcfzDYRiNh/OVqSMdL5PjZJg==
X-Google-Smtp-Source: AGHT+IHsbx0fIRDUMzBwy9O4kHJKOYx4qz0nVvI5OrWT0TeykPJ+AAOdiyD+yc5gWVnssggluBgHOA==
X-Received: by 2002:a19:675b:0:b0:50b:ed6f:8911 with SMTP id e27-20020a19675b000000b0050bed6f8911mr460724lfj.107.1702161460000;
        Sat, 09 Dec 2023 14:37:40 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id dw11-20020a0565122c8b00b0050c0c46e1desm634885lfb.33.2023.12.09.14.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 14:37:39 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next 0/2] net: dsa: realtek: Two RTL8366RB fixes
Date: Sat, 09 Dec 2023 23:37:33 +0100
Message-Id: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3sdGUC/x2M0QpAQBAAf0X7bMvhdPkVeXBuscXR3pGSf3d5n
 KmZBwIJU4A2e0Do4sC7T6DyDMZl8DMhu8RQFmWllKpR4mqqphGLWzxx4hudMdqQ1bWzGlJ3CCX
 9PzvwFNHTHaF/3w+qizyFbQAAAA==
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

These minor fixes were found while digging into other
issues: a weirdly named variable and bogus MTU handling.
Fix it up.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      net: dsa: realtek: Rename bogus RTL8368S variable
      net: dsa: realtek: Rewrite RTL8366RB MTU handling

 drivers/net/dsa/realtek/rtl8366rb.c | 59 ++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 23 deletions(-)
---
base-commit: d3e61d377ac8cabbf24d17b2421191cb81019614
change-id: 20231114-rtl8366rb-mtu-fix-d8858eb54db5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


