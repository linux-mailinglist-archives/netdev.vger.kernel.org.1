Return-Path: <netdev+bounces-57141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A801981240D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EEFB21268
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024838E;
	Thu, 14 Dec 2023 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmMgpd8V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA59A;
	Wed, 13 Dec 2023 16:45:40 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-33644eeb305so293361f8f.1;
        Wed, 13 Dec 2023 16:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702514739; x=1703119539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xkA8aX9W2l8y7Uc6nvmkEm2CKe+7epzMhiOOcqw7Ijs=;
        b=UmMgpd8VdyrArXjJbggI9HI7EPmxBYu0iUawAFA+4do1RwusWAs9Fqgq25jGUr9Nwh
         /S2LOS5DmwhVgEuASgm8R2TpHyDhKTGqdBaNXIlGhdldZgA08UjJATCv1z2gS3cFRIUg
         yvAFUvJG2LktOSbdqSs84KyoWdOwhtGXIqi3bgoxoD8UGIFTvnohVD/Buq8eB6Ci0m/j
         nCBq62iw6PSrOXOeO27CqDFv4o0CZBIuqa4C4eNemk0dApvAX7pUabPKeHaleHbVGnJ6
         3BY+HEiXnZNFmuXLBuXbwclkU9jq4DgR8GZEtIHRajbBRirNQe1mZK+xONuwAoMh0KZw
         SIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514739; x=1703119539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkA8aX9W2l8y7Uc6nvmkEm2CKe+7epzMhiOOcqw7Ijs=;
        b=EaiUHGZadRKGKJJkgrvWSKmTM6fVoMWdIMzwZqlnFWGF0cXSTB5WyRV4e+DsknYC/m
         Ze0XAAjjUv7UVFj7D6sXFOqiUwZfzZaGEVtQB1dk37dxa6FCSgV9A5OFbSgzW4PrM2A7
         McKbkQwqNQpz4868hQvUzDWTiAfZQPRXecqDL+zWeF+2aSjwgIaD2sjtIUEN38BYH8Zy
         44wugBxnNpINodr9orDzY+jK1JCAVyh4WLHonuLVC+hrcQHFEDuhECUArlK1vB+ZXin4
         Ooe2EXoP1EyAEpuiTiSfDoQ48tr0k8CZecacHzNnI1HSdJ7YtOfXTheR2/gHlllACiOl
         G1yA==
X-Gm-Message-State: AOJu0YwEIOR+9ksoZiC2NzMmhNN0pjZJmoviyr2A1esEkESG8nlolLZY
	uLuFEIZ2ODiIpO458tUWbbA=
X-Google-Smtp-Source: AGHT+IG2sog88JXDEZWuQus/TDdCLqQGrttTQCTdi6dN+bCXWawwvU4A1hNkOvdh7d3EdzBhoJ312w==
X-Received: by 2002:a05:6000:a8c:b0:336:4440:b94f with SMTP id dh12-20020a0560000a8c00b003364440b94fmr389862wrb.124.1702514738927;
        Wed, 13 Dec 2023 16:45:38 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g15-20020adfe40f000000b003364470f30bsm959013wrm.52.2023.12.13.16.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 16:45:38 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 0/2] net: phy: at803x: additional cleanup for qca808x
Date: Thu, 14 Dec 2023 01:44:30 +0100
Message-Id: <20231214004432.16702-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series is a preparation for the big code split. While the
qca808x code is waiting to be reviwed and merged, we can further cleanup
and generalize shared functions between at803x and qca808x.

With these last 2 patch everything is ready to move the driver to a
dedicated directory and split the code by creating a library module
for the few shared functions between the 2 driver.

Eventually at803x can be further cleaned and generalized but everything
will be already self contained and related only to at803x family of PHYs.

Christian Marangi (2):
  net: phy: at803x: move specific qca808x config_aneg to dedicated
    function
  net: phy: at803x: make read specific status function more generic

 drivers/net/phy/at803x.c | 92 +++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 34 deletions(-)

-- 
2.40.1


