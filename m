Return-Path: <netdev+bounces-109049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4931926AC2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A3CB27350
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA6F194C9B;
	Wed,  3 Jul 2024 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7MTOPAN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F40194AFE;
	Wed,  3 Jul 2024 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043216; cv=none; b=s6gOs5wUM9rdmZle/sE4C29Mt8AU+6zsG3COOXNjW/sfxgBKYaVoHeS2xDHl6FLPxQGlKRMOZFWni4sU1gDXtJECMUr9y4zBEiM2xyr4cJeoaPrq5mDUnwbkzeBxtOxfeal3I+7kiJgNwPkodVcuz8e0m9ZZ5X5+KSGeWoBoNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043216; c=relaxed/simple;
	bh=TqqYwd9d+YYTEaJ3Hb+RHNh30zSbeM80XHxfUHUS+A4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9e10+/6s0BCgI4XhBBAURw7DFmlZBY+4Kk0mky4WQsph2SSHr9LDxK1eyCG+9+9oePc1dbSnGutHDA0rRxLFkp53HFzJOntjxlItcbTlL9/T/a7xSslWduDSx0seMIZBeZO20/VzLK0Wn1ywlPfgKk2PtQpWRWEZgCyZaMDz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7MTOPAN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4255fa23f7bso41732925e9.2;
        Wed, 03 Jul 2024 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043213; x=1720648013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZX5QuOeiGPzs72hiIcfMb49M5DXX4kyzDZ2bV2KJnA8=;
        b=X7MTOPANa0ew1Maek3pHuvKp2MPbf6jf/zT5VWclp8Qlttg+j1gfynYTZB/EEAh/k7
         ABH2kQl9vPWyeROkP0FwsA/Tblgjj5mAL5ZdChEHfm8jKo6gdT03XxsnaDzsu+bnk5UV
         5gQvwP1He3YKzqICpN2fRQIDSsks1pzq+9mp3uGon9K5oJdgz2tceeJvT/Xy3Ocz0rg/
         nS2uknb5sPq36Xc5ZqXwzkuT8e/Xk97B23Hwe10Vio8XX6HPApFd++c7hXZScWe540NN
         CNhMtyci7YyTjw19VDO9n2OTP6ioLcOEzvUa4rmVjYWSUThuq5EreZV6yo6s5wXHNspn
         pgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043213; x=1720648013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZX5QuOeiGPzs72hiIcfMb49M5DXX4kyzDZ2bV2KJnA8=;
        b=eKu2glqB9LLEA6xR5HzcfDRE4ewTpL0FKOFeMfs6/i8seQgSX2GfvS9skf0os88x6O
         bEQhpm8JakXdwQUEtj1lVgDKf3/3o/UEgefRWnmlhWjPXQz8h7L9EmtFxo6T7pRaT25o
         N/0/XYF0F9581jx9ZQqSw8ztyJKIWDrlDWov1HP/gSzch8jsiUTUWVQ2nHkRIyK55VKj
         NXuGtLme78REs9BRMjClm/bEXKFjK30Bkojen5EklRT1SQo1i85tyHJKQSE39syr3zIc
         +tJxaFp519Knh1ZmcmRZqmM+GPjHOhNNypXGMa2sQJbQJXa1ewVn+cg1sUH5D7Lk5Qvi
         M2qA==
X-Forwarded-Encrypted: i=1; AJvYcCVqRSuUfTBdTDBH3O2108rqB/usQkUpetaO7uY2+wmq0mfez0/lhyNqPwie8yDAcTZY5cvFGMDPTXD1MTr8KVStaSUsb4coWLzfMkv7
X-Gm-Message-State: AOJu0YwlbIYkOCPyjCNibHd2V+9t5A2byiZAfZ47XQUJNTs1WBagSUT5
	IshfMlXENG7T9+zaxdrixWgAK9vB3wcf501NM5YvKOPJoq8jTPsX
X-Google-Smtp-Source: AGHT+IFadoRKQNgnDNdrUcb/+eEl1uaAY0jFIVzWf1WzxiDNboC1scUUsRnJotR2TAM2bxb79HCYPg==
X-Received: by 2002:a05:600c:35c3:b0:425:65c5:79b4 with SMTP id 5b1f17b1804b1-4257a02b6c5mr90382265e9.26.1720043213180;
        Wed, 03 Jul 2024 14:46:53 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678fbe89cdsm3628068f8f.61.2024.07.03.14.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:46:52 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:46:36 +0200
Subject: [PATCH 4/4] net: dsa: ar9331: constify struct regmap_bus
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-net-const-regmap-v1-4-ff4aeceda02c@gmail.com>
References: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
In-Reply-To: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720043205; l=827;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=TqqYwd9d+YYTEaJ3Hb+RHNh30zSbeM80XHxfUHUS+A4=;
 b=sCCEmiWZsxe93jwseOtmSsLMWJQ42g2tAdOmtEVuX060VWAnURTf9DAk9BB1IiSFEXjBLmx7w
 C1xYlaTuhjOCoCdA9u49QNzn5eU0HkbaP2AODrPcWGjnUPedJHO2iwI
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`ar9331_sw_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/dsa/qca/ar9331.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
index 968cb81088bf..e9f2c67bc15f 100644
--- a/drivers/net/dsa/qca/ar9331.c
+++ b/drivers/net/dsa/qca/ar9331.c
@@ -1021,7 +1021,7 @@ static const struct regmap_config ar9331_mdio_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
-static struct regmap_bus ar9331_sw_bus = {
+static const struct regmap_bus ar9331_sw_bus = {
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.read = ar9331_mdio_read,

-- 
2.40.1


