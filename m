Return-Path: <netdev+bounces-168041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF34A3D2D2
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5749B189B81A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F481E9B2A;
	Thu, 20 Feb 2025 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbi2F9jZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03524179BC;
	Thu, 20 Feb 2025 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039084; cv=none; b=qJqnJkhyl09WRBzNvHvjwZVdKd2EUHqNh+FCCoMsIvK39LypQnFDgneOc+Ft153Q0mcVDucxmzdvM9fOB3+X3ERTSSystdN4crvg1pckSjY+Od6cd7sHShBB67S3UQaNoV77CRm20IigiWEyMGSrXp5n2A+9VTCcZ2qqmyjeFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039084; c=relaxed/simple;
	bh=FOWTmQqu61BL8q2wqlpQusEtE6I3dQYZyJ0fpEShzLw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=maNb14vBmBR31zqW2CHxDbOazDCXzTn5OpHg2LIZK5e4IQvEEmCbUfMcSUnNM0KFUV/SRqmRD8H/KqAIJKE60ltt5HAumPvweNq/O6yqyPxDhZ5KEbGPi7r8oPPJYvnF0FwjbCjMxvwsfePY51JrZrUO1gErqBClf4YycfBfBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbi2F9jZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso841965a12.1;
        Thu, 20 Feb 2025 00:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740039081; x=1740643881; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kt9UMsrBOeE0Yd/p8MWxV7HIMA2w30ST5vazQFTSGKY=;
        b=Nbi2F9jZC0KQjdXGsM/dQlukV0CF9vsF5fYY2dAPSa0gleaGN1rLCGSELeWUDQ06lb
         m7Tb35aFr5JkrBIJMhKxCgLhvU71frQS2mYFCOR3v5l/qGsDfgtX9Legx4+eFs84s9oS
         IB4Cvco2JE/3owDtoSGqOIKUHVw2B1LIoYSraMGJ3dB0+TrXpjOKbgkWEqM6yEZPgYJR
         y0k6zHxqUvTBHBLV5dm3dXhPEOlZqJ2es+UaCdjvk4H0I/i+T/7SQEbOooSlJ55V1vsz
         +qbEzLrsIfRcmbJwuRviQA3lurWprRxpYn5IXAES7rBJwDLBIJ5mW5gonSEWktGXNLFA
         xL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740039081; x=1740643881;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kt9UMsrBOeE0Yd/p8MWxV7HIMA2w30ST5vazQFTSGKY=;
        b=YkfC018CaxlpyPkd7CMH+gsMiqR3gH1sUCVGp+BOQZSRnsE1nY5Zr/COKHRMLYZr6U
         X1WacDwofD9K/hW3KW1nuC1lguZfe2IqprNbYoRRwlOUCSjbA9fqxwN/qfab5C3hI3P0
         KGSmSxSiWngRInfNzSWtJKLMR+sjwyrjz2f2z/THY8OXoZn1+1EsDR6oGlS2X9eMYIUt
         C68LKMQw+E2ukReL6B2Eq2P0l05WA/fjNiu9HMaCraY3YFY2PytBTyOEej0276JhuH5N
         +lnOVrc5UBS+qWWWnpJnZlTt9vmOv4hlOOF+qRpg+jSQ7TBNN4/oVLN/uHSQx9G+CgNr
         up9g==
X-Forwarded-Encrypted: i=1; AJvYcCWWizTL11DnuBxj31NxeOwm/uErJvXf56tmSdkxW0HA6/qQCqNVY+iHiAgJpxgAPse3U6pstCNGv3lgmho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqcgc4oEkUpRmq17E4L8wJK5xMZT6xSk15xWB15vRLyEeX4aPd
	6kIbh09iUM1Uc63Wvj9UiY/ZPsxv+t5nUXg65r575eyYm0MXjW7f
X-Gm-Gg: ASbGnctzXh5AjO5oa8Yd8QM9ARTfXaxScx5zNuOJC2meIS+NI2eccD7wMRGJnmgqMtN
	qk9PMRvsIdL6+E8AkjHcRw2E2YzSl8rXPrvu4K85qKZzemsVo1Zp6Ef4foe/aQMU9dER0XXOXBe
	aYbJ68OCaCm4JONKhM/FM6kxX1BX8qUN3kmCHt0GHgjq/TGgmDaGjtW8mVIaSlvZCGnICEsvrfh
	V/PntY1WU4ig6NbVxeRaHO/yStNc/iFDQpWYOPl7Dfcxt0zC0nIObW9nGdNpLAv9hLgs13OijxF
	tldNRJ/CE7V7TldrIr0=
X-Google-Smtp-Source: AGHT+IE/U5FVXH5xi8v3V55Rt+UY0k7Y4UrxbimDIHPhKbRrLC9F4kh4WVgVx87sIJW0FlSoOs/rIA==
X-Received: by 2002:a05:6402:5246:b0:5dc:db28:6afc with SMTP id 4fb4d7f45d1cf-5e035f306e8mr23084825a12.0.1740039080955;
        Thu, 20 Feb 2025 00:11:20 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:604:ea00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270967sm11636298a12.55.2025.02.20.00.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:11:19 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: [PATCH net-next v2 0/2] net: phy: marvell-88q2xxx: Enable
 temperature measurement in probe again
Date: Thu, 20 Feb 2025 09:11:10 +0100
Message-Id: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ7jtmcC/42OSw6CMBRFt0Le2GfaItg6ch+GQcGnNOkHW1JrC
 HuXEBfg8OQk99wFEkVDCS7VApGySSb4DcShgmHU/klo7huDYKJhgp/R6ZjJWpTyJUopOL5d8Eh
 e95ZQzzjF0BMKLdq2rUWjZAPb1hTpYcreuYGnGT2VGbrNjCbNIX72A5nv/teSf7YyR4ZKKV2z0
 yA159en08Yeh+CgW9f1CxW7WPTkAAAA
X-Change-ID: 20250217-marvell-88q2xxx-hwmon-enable-at-probe-2a2666325985
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

Patchset fixes these:
- Enable temperature measurement in probe again
- Prevent reading temperature with asserted reset

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
Changes in v2:
- Add comment in mv88q2xxx_config_init why the temperature sensor is
  enabled again (Stefan)
- Fix commit message by adding the information why the PHY reset might
  be asserted. (Andrew)
- Remove fixes tags (Andrew)
- Switch to net-next (Andrew)
- Return ENETDOWN instead of EIO when PHYs reset is asserted in
  mv88q2xxx_hwmon_read (Andrew)
- Add check if PHYs reset is asserted in mv88q2xxx_hwmon_write as it was
  done in mv88q2xxx_hwmon_read
- Link to v1: https://lore.kernel.org/r/20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com

---
Dimitri Fedrau (2):
      net: phy: marvell-88q2xxx: Enable temperature measurement in probe again
      net: phy: marvell-88q2xxx: Prevent hwmon access with asserted reset

 drivers/net/phy/marvell-88q2xxx.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)
---
base-commit: 13260df23f5c0097f632c36fcd568ee33aa6a621
change-id: 20250217-marvell-88q2xxx-hwmon-enable-at-probe-2a2666325985

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


