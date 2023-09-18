Return-Path: <netdev+bounces-34631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6617A4E6E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F66B1C218FB
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4621923754;
	Mon, 18 Sep 2023 16:17:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CDB208D4
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:17:45 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13883BE;
	Mon, 18 Sep 2023 09:17:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so50473095e9.1;
        Mon, 18 Sep 2023 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695053856; x=1695658656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CANJvV/UmJ8+MnU+w/pR9h9EIL/YLrx6SrFgD3723Yg=;
        b=UbIaPyfVkuByfEsIpp/hhhNx1XM4O9H+NxC9+oJQP4AZqzh7keOhkMcZaRN0QKqE5V
         gzHEY87X97+HYab++WeNbasL/r6gtXumQxbuaRAQOiw+KgbnUNDNrBBe8yKR/6JSpQB/
         /7JIW8y/rU7FVrJYwhok44+Az0ebKGbjCgtoH017bEo61Of3eJj+2daXPprBIvvF9Nvv
         JBqXFoIzcZN0UJ7NqsrRk2SAKcQpAGO2FymwhXyJC9OS6b9wAWtl0z3+/+5VKhEu64o0
         roUZOS6FbbhY6ut199ljC6jnm9SlFrm61IedMFPWg8aJhhwqkGeh89CdI6GQNLxwbR83
         Wh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053856; x=1695658656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CANJvV/UmJ8+MnU+w/pR9h9EIL/YLrx6SrFgD3723Yg=;
        b=W9hufwtfDeieGhHtKSlK8URZERHm0B1zs3b9u/1A4+8VkEoBMpGqFwIPRAq+z33OHa
         wJyWOB5fU+APETQjk6DiD6JnhXyH8FNRkSNnOi3RSafd99F7Dp2ruo6SJAynGNu9F5kP
         UoroBbyvSsydLqtswn3O/mXAaWBkH63h04CFa8ztl0SsXkLMRhAdDQE8YyLpUr0adIzj
         4hUvADQzJok41+PeWn+2+aV724/SSqn+BC/COkl+LoUewTPcmmv71OmjDHWGsbrUYO/C
         0AXgHG7HTpIOnVjwa5cCq9m4PYyIT4CKfuCwqZToqlcES3NR3CXFg/IWQfzc9juOytpP
         CTMg==
X-Gm-Message-State: AOJu0YyMBxkgCXVDOp0F0XDQo9SjqPxcP1lZSASeRc29ieNwy937X83A
	+afDk0Mf3Gc5Sp5qobqJlAPGLU5MR5uDnQdG
X-Google-Smtp-Source: AGHT+IGI9gcwwPd99BrXutUFqVP6EWni7zFRDYdVplnOmPGUVdRaEi9ml0NcsG1K68WuDpLLsCxVtA==
X-Received: by 2002:a5d:6ad2:0:b0:319:7788:5027 with SMTP id u18-20020a5d6ad2000000b0031977885027mr7448298wrw.59.1695043305259;
        Mon, 18 Sep 2023 06:21:45 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c230700b003fefcbe7fa8sm12539395wmo.28.2023.09.18.06.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 06:21:44 -0700 (PDT)
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
Subject: [PATCH][next] net: dsa: microchip: Fix spelling mistake "unxpexted" -> "unexpected"
Date: Mon, 18 Sep 2023 14:21:42 +0100
Message-Id: <20230918132142.199638-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/dsa/microchip/ksz9477_acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz9477_acl.c b/drivers/net/dsa/microchip/ksz9477_acl.c
index 93cd46185e71..06d74c19eb94 100644
--- a/drivers/net/dsa/microchip/ksz9477_acl.c
+++ b/drivers/net/dsa/microchip/ksz9477_acl.c
@@ -353,7 +353,7 @@ static int ksz9477_acl_update_linkage(struct ksz_device *dev, u8 *entry,
 		return 0;
 
 	if (val0 != old_idx) {
-		dev_err(dev->dev, "ACL: entry %d has unxpexted ActionRule linkage: %d\n",
+		dev_err(dev->dev, "ACL: entry %d has unexpected ActionRule linkage: %d\n",
 			old_idx, val0);
 		return -EINVAL;
 	}
-- 
2.39.2


