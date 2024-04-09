Return-Path: <netdev+bounces-85986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F589D30E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FFF1C21F9F
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 07:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168187E56B;
	Tue,  9 Apr 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn8ZLU9v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A397E116
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647834; cv=none; b=A429GYNvUmB8gsrgL8lIEwWBLWx4onphNavGKJhrt8S9bivGqTyYb5XluFs32Iub8Iw9gDjQz6dhgid073pxXAVBOXjrraHoqGTDsmHrU6P/q0xnj+gW+/9/R5D+xFKIJ8gsF2DjfDrk81yINmnYGwunElz6guUIGPlINYDg9tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647834; c=relaxed/simple;
	bh=gIz7MdS/+GZwGdahnbu/fUAyMyBCexr2zybpIeHADT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0PWu/dNobXoXgazodQKi0Mdfjr9+qRUdFaEgiz+WQrvZuYASIq/3+nS11JTwGT/Dlg5wEjMKPLBarjGen0gm4/XE7rv0UDmkhhj4Xf8OpBzKJpzy50vJYK4oHwHhFW6GPUkB/djc7lLnwowwqThVxcypAgcVTNJ4eB92cPLK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn8ZLU9v; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51abd0d7c2so514740866b.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712647829; x=1713252629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDkw88b3lYtuDM0Po1l0W+9RfoTKioIBFPIWL2ETjQQ=;
        b=Cn8ZLU9vTohx1aDiofsJY7ebXX62QtHYyavEQiAHhYjL4Wk18nhXjuKU/Vb8BMhLbg
         bixcpiGH+PT3+ls8jlUAzwmbV/WTN33du8Ef8iQabu98KPHu7hMxurBcekuCXY8vmr15
         96e0CeIz2H469vlB/A4ts01QY4zjH5m9SpnSXmF/BMlkF+R6vRUHci9bU2fL7lR+cnd3
         jKrc4Y39S5dvAVG8JUhC0nN9I2eU2EfNMk+2PEH+ByIjby5o9TpUhFCgIf1wvNYJjvXI
         RhHoBXUGHl91xXaY5QvT5XTCcCd0Ried9jqQcNBmjos98+sh6flV4KhBd0rKmt8ClGgw
         yEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712647829; x=1713252629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDkw88b3lYtuDM0Po1l0W+9RfoTKioIBFPIWL2ETjQQ=;
        b=byWVRjMQCHUH6P2tXyoWulr4uI/HPMrrhSV96OPD0TM7Vj6XErdXFCS4qLrTCypKSk
         VyyXiYsi95wQ3XaoeUgmaxBqZoeA1fg5bI3xVE7tZ6A91z03P6E/VtItTyTmBXeSFuwV
         0W7IVkSs3Gn6BSf2dvL3IJQuulmXZ4v0wNyMDZU58ARRcMTVToxtr2SXfWCbQzj7stjo
         +sTdG1/Y80hW2cjmYh6uNqkA6ZuGp/s+6QJ9+0Jge2lJ//dZvcfqUfYFzj4YKO+cWZXh
         Y8zBo9wUTk0JsUdT4jf34mfVRIkW6gz5Bp7Kia1iMOGl6DAy3FWKz1Ao7EsEZus0hUOw
         w4Gw==
X-Gm-Message-State: AOJu0Yy03tXakWFse5H+N2RFSTYGF7SsNSzw6E07O2/ZWO24PuNWI2IE
	BUOAj3Qt1S3A1B0po4T16PP//fFEYFqO859sAYfSr5PT2FjAyIvaBtlJaVVo5gU=
X-Google-Smtp-Source: AGHT+IEJj4qTvawNrr/1mvzrgObjIkXXMzC0xE2m4ZuH1Iu2C5jjXms5vA5AA5SI2Jq722sfHhf7Fg==
X-Received: by 2002:a17:906:2e88:b0:a51:e5b1:6d4a with SMTP id o8-20020a1709062e8800b00a51e5b16d4amr1229036eji.64.1712647829602;
        Tue, 09 Apr 2024 00:30:29 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a473362062fsm5315694ejt.220.2024.04.09.00.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:30:29 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v4 net-next 6/6] net: sfp: add quirk for another multigig RollBall transceiver
Date: Tue,  9 Apr 2024 09:30:16 +0200
Message-ID: <20240409073016.367771-7-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240409073016.367771-1-ericwouds@gmail.com>
References: <20240409073016.367771-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marek Behún <kabel@kernel.org>

Add quirk for another RollBall copper transceiver: Turris RTSFP-2.5G,
containing 2.5g capable RTL8221B PHY.

Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/sfp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f75c9eb3958e..6e7639fc64dd 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -506,6 +506,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
 };
-- 
2.42.1


