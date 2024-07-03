Return-Path: <netdev+bounces-109045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC86926AB4
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91421F23A2F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4855190694;
	Wed,  3 Jul 2024 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/UnTiZw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62918E74F;
	Wed,  3 Jul 2024 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043210; cv=none; b=Q2R/USzNeLpQ0lNsHKLyJVcxJsy3vf6jQbU2VFlQQXVVgNcrYszIa68yi+Cxjx7Ye826N7EgGeLcu8hxo7Kzg5TcbKxNXQ1x1QE4Q+aCLyChSAsR3P38LxnZVJ7c7sx2OVywgIX3W/caq90WRAIpJHwZTRhF5iD+rUOiLngSSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043210; c=relaxed/simple;
	bh=R7RUOpKxFR0kt7YIGnbpUIAx3fX39u3f3fnlbrS8Z7w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fye/PnV3szH20a0evf12zp+GAYRq343q1yYyMoRNNfrHJjisBKgmlP3dewhf8m/DC8PRUZ+IHHVc8deYc1BU+47itc0xyEX2hB4kB//3Dz/ncpvKgXBroR8b1CsEhdfnwWLkyc/HCxUhriUqQgv/iUk2gm2ImaOTxtDDqOM+7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/UnTiZw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36796d2e5a9so5061f8f.3;
        Wed, 03 Jul 2024 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043207; x=1720648007; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNCGvOqBa5Gzc1I8BSCA2IUK04BEtRznQJXQC8w03Do=;
        b=E/UnTiZwKFKO9/Co2LzqbYkz8FdSf8Z9kwask6m9O3DU8TexAXZQxf+I1pT75ycv6w
         /7u4GJo8yybApkwAT8I4ZnHX8HurchYLoUfOoqsGgJlpCqd5q8QhvCP1aTK1tnp86v+1
         yD21vwSMUUFuenTUZxGg4SNvu3orLJ9/7RalUthoXZ1FWV1ofGllnY/QBxVXFtI9Ft6W
         mkrb0i5YpFgpUc7hiBYl24MC0fG62TAXHNyRp3TiT878JOEWhyz4rSE4Ip8QEl9N8tby
         IxS9gPOrfzzIHf3UtqjA272Va1iWRl5C0Vs0IcuDZRU/7wzeCC+prb6XwJWUqnMBL1sP
         HcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043207; x=1720648007;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNCGvOqBa5Gzc1I8BSCA2IUK04BEtRznQJXQC8w03Do=;
        b=ctO4BdVKhQBQbbGRpDCqazoBxEG68JtUArmRxu8M9zjZ8FX/VgbZxKiUfjZo3VZtVa
         4pwJtqRYexrEVgNJtJPUEDlx/BHlM4pjZ1dwgJzbFYoox2vr8UHiXXLEDNxLgpitu3mH
         sK47ZZHNpwJqqRjciNdy1k9lmh4bglmFS3Fbij8G3IQlTtKNREwKVucAorWdKYpt8nLF
         94jonlI6uBANzdrh/jcEDQrA0xnKaKjNfW+S+sP4WeGPOMJtj3GneFC1TVIO1n8V0lRz
         PK2V4rRxk3sTHyi4RHNYEVOWzhJVUcmcu9uH4K5FLMi3Z4VioHHLk58/kwiW30dod96s
         FXQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsHmyPcQZ802NwYGYp1xlIL1ApSGNmHIJB5X6nCegBgXJ4xqxLZYjJbEfn4+BE7jkPy9intas28NnL/joQcQ65n84QhxaGtqk57L6W
X-Gm-Message-State: AOJu0YxsRgcLMZMBf+u0Beu04j2J/6bWQRYPw2NiOUIe4JsOqJLlDMS2
	tJJy6b+cgxU2XTAOp23qpMsV21Bxi/IzaLjaV0E5aK99hZ+lrkLQ
X-Google-Smtp-Source: AGHT+IEoq0PBihEbtJmQBKy8bfRT5DtacUrBxx0e4PXAHXB0vG6l5LA1YIJBD/5wo6vlrJ/azH8QeA==
X-Received: by 2002:a05:6000:2c2:b0:366:ef16:2694 with SMTP id ffacd0b85a97d-367757258ddmr9175297f8f.48.1720043207324;
        Wed, 03 Jul 2024 14:46:47 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678fbe89cdsm3628068f8f.61.2024.07.03.14.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:46:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/4] net: constify struct regmap_bus/regmap_config
Date: Wed, 03 Jul 2024 23:46:32 +0200
Message-Id: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALjGhWYC/x3MQQqAIBBG4avErBtQi4KuEi3E/mwWaWhEEN49a
 fkt3nspIwkyTc1LCbdkiaFCtw253QYPlrWajDK9GlXHARe7GPLFCf6wJ2unMfQwrlOWanYmbPL
 8y3kp5QOf0wZnYgAAAA==
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720043205; l=1028;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=R7RUOpKxFR0kt7YIGnbpUIAx3fX39u3f3fnlbrS8Z7w=;
 b=7LSdqVto16KqvEq6FFr+JjHprzru6ficc0Gkg1sk0fsOE1gRo+iulAg3MGSw6UOCYn1EzR+/h
 80JEFsyJ8JcDVoFdMjv0PqrHD7vxpaJ3Oq9HFJIDYL9AWEy0HHMcTUq
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds the const modifier to the remaining regmap_bus and
regmap_config structs within the net subsystem that are effectively
used as const (i.e., only read after their declaration), but kept as
writtable data.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (4):
      net: dsa: qca8k: constify struct regmap_config
      net: ti: icss-iep: constify struct regmap_config
      net: encx24j600: constify struct regmap_bus/regmap_config
      net: dsa: ar9331: constify struct regmap_bus

 drivers/net/dsa/qca/ar9331.c                       | 2 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   | 2 +-
 drivers/net/ethernet/microchip/encx24j600-regmap.c | 6 +++---
 drivers/net/ethernet/ti/icssg/icss_iep.c           | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240703-net-const-regmap-1c1e64e2c30a

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


