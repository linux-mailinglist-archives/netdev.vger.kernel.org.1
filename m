Return-Path: <netdev+bounces-166504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909BDA36329
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6E43A5C26
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DB82673A5;
	Fri, 14 Feb 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alp97icn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F87E0ED;
	Fri, 14 Feb 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550747; cv=none; b=uEAi9oiYi0dfwtj7q5Z8lcc3TsKoxF1XvYCwa+RWFiHPS0n9mTwR+dRPVR1MEIMDgJnaDBQ7DuLXMce26t/Bkz7PYenXcT3t426hNwvAFZ82qUSdavtmO+rEhlpaaDWKKAX8BVpuYHFnEYBAJWug4YRzlREXdRPK/yOO/WGdppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550747; c=relaxed/simple;
	bh=drCTzU1zvQdeA9D5nZxD1+elUhAkSOezcDF4EV4gtUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GMhwBH3PfN8woSoyK/fsV2qzZwYksfR7l3Nl9woc+DXvwInYSAHOqaCQWB6KzVZ+Yp+z1wwnz4WOxl6T6o0MPT8RGaDqqhYqYuqmOLCYTkU411sYy73aAJ7gSeT5PpbKWo2yfBar/foIHKrAjbh2muNH0bkaTs7gU4VP16HVDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alp97icn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso417260866b.0;
        Fri, 14 Feb 2025 08:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739550743; x=1740155543; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jv4ywDFx5P+Ul/SmDQMfb9n5TaX/3v/GZEibCjq9vQ=;
        b=alp97icnjYzD4xspd2SRA5yqeC6AXIW1qr7+YLGoxURU5PgHjlKXNMURsnkezGxgrF
         QqmQXdffDcNp9n1mBYHlrgr0DgGJBp0/KlRO/zNG8TM8IW5Tcwr90hS5+TC6xhYJODJ5
         7B1aw8pLfnKP4+thnRd+k4gPIHoCp5OQ/2cfKcwdqYxCfjAyCMQ0F1G/DBDSrs6N5LUo
         3/k7fcr5qpIKma5UJkHFNPLXUPpBkuvLYUqF9yEz2esTlXynlLK4ytwOWiHDrBOLR++y
         ZrlJXhwVOgmztpZiQtBDlOQt6LbE4V7biWy8wOKF6hgMl4wG7oPiaQJ3D4OfJuy5FJoh
         mRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550743; x=1740155543;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jv4ywDFx5P+Ul/SmDQMfb9n5TaX/3v/GZEibCjq9vQ=;
        b=SXA6+ywtJrpfedcPjc9Ky83ld2TczxKbSIoRxvTROzr97YTZ2vTzKM00Blh4Hs6+76
         MMSGFHKRFHMp87n+b8ck0J9Ai4CO625VFGKcJZFvi06sWrHUiiBExGZeaMaVO7YVAUok
         bVgqFjTdLx/su0ECtllpljuKkYV0usGek7Wvz3wpYt0eGt8grXAHDICusODLC0T0mRgT
         Cqtg3HYu4EvryXdoSqb+D/sQsu7qSoIpcJG9VO++naVTQq6XnHoctIv34vYYvbCxto5l
         hAyHxkx67N6WiKb39ohCIzMR6S5ByHz3OD8Zi0Qi8ozXX1FGNAYTM42r75kPAQD2No2N
         9KkA==
X-Forwarded-Encrypted: i=1; AJvYcCXBafT3uo9mLtpcyZ6pdcUIE5D5U9betDtXBs2yUoW/1SLGWCmU8PzZLbUwAeW49XbvUqL9mUEPTeVVcgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7YRnCLNJ1fc04JwsfXVi+Y8632RIi/ckPI24I1zpAJk1xgzXM
	345s7cRGx9zfmTY8uAgm1g927ei7pVQLr4M+7SzsThQV9R38aWL6
X-Gm-Gg: ASbGncvjMuzFxc632XfDOrPfjI8U0aCcz1P7Iw3d4Ha4g7MwuajW6AkqgU3wE1B1ChV
	XO/zU+4NYop0l2y7y/hVdUT7URgozKsd1gABtRsw8+3YGc87Q6yESKBR+cy/0PV33CM2NXmnmeg
	LIpfRAsza8Pi7USJbgz3RlqdCcCIl781nOsXxorCIVS/b8RUIaPMk4Ca4VaevEcQqizhZ1QfIZY
	KScCTgLCE+QM4eZmd4EaI0gZ7hEB+eT1NKartf4f6cHpZ4+Oiu6vuKxBk7Bp1oliI55n4mqRwVI
	0VVi2SO5Jzyr0jbUwFE=
X-Google-Smtp-Source: AGHT+IETGMdbtCy/UJeOfDePQ6WfGtYqMnw/UcbG+CjOxqVWScars1aSmQbqPSohpxyzuXqLGKi9eQ==
X-Received: by 2002:a17:907:2d21:b0:ab7:d34a:8f83 with SMTP id a640c23a62f3a-aba5149c80amr819711766b.17.1739550743178;
        Fri, 14 Feb 2025 08:32:23 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:653:f300:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323202dsm370716266b.6.2025.02.14.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:32:22 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: [PATCH net-next 0/3] net: phy: marvell-88q2xxx: cleanup
Date: Fri, 14 Feb 2025 17:32:02 +0100
Message-Id: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJwr2cC/x3MQQrCMBBG4auUWTvQDBaDVxEXsf3VgTjWpJaB0
 rsbXH6L9zaqKIpK526jglWrvq0hHDoan8keYJ2aSXoZeglHfqWyImeO8SPuzmNGsu/MUSDxNsg
 pTKBWzwV39f/5QoaFDb7Qdd9//1sCu3MAAAA=
X-Change-ID: 20250214-marvell-88q2xxx-cleanup-82e28b5271de
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

- align defines
- order includes alphabetically
- enable temperature sensor in mv88q2xxx_config_init

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
Dimitri Fedrau (3):
      net: phy: marvell-88q2xxx: align defines
      net: phy: marvell-88q2xxx: order includes alphabetically
      net: phy: marvell-88q2xxx: enable temperature sensor in mv88q2xxx_config_init

 drivers/net/phy/marvell-88q2xxx.c | 77 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 40 deletions(-)
---
base-commit: 7a7e0197133d18cfd9931e7d3a842d0f5730223f
change-id: 20250214-marvell-88q2xxx-cleanup-82e28b5271de

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


