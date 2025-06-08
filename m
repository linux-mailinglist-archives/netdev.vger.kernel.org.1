Return-Path: <netdev+bounces-195592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77767AD15B7
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3814F168C02
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3F5266EFA;
	Sun,  8 Jun 2025 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkSbGoEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922E288DB;
	Sun,  8 Jun 2025 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425385; cv=none; b=Pqx8nO5/t7Asa0MclylIifIFQhTNHvEPsTLrBLKB36/3QHaYz2PJgAbO3bG8V3qahDjPc4WtbDqsADDxyAKLDk4To6JRERCWMLbTY28kFYeclyMV2mb2G+qc88y3xBM2ji53cKYDAAftF7/cmdnODdWBkcHzjjzFmkVOOxK2YU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425385; c=relaxed/simple;
	bh=afKw2RLAsHkx4z7Ink9JdbmTDsPPLL5SsmxRARZhi4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SM0dTulxK/YCogDtbpgwKea23/DahWD+wubIOt3WQgE96OEj2ykdByWdlJOoAY/CuyynUJL5Hrs0ZEB//bIUUDRrjLdSm+4UULFntGIgjTbaHaLrbuQCWbGL1vTZNgbsv6FTA/XEEgXcaa3oR+rixNCIDwgHkgOAnnfkp1nvaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkSbGoEN; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6facba680a1so42493886d6.3;
        Sun, 08 Jun 2025 16:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425382; x=1750030182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SU8RawjSZdNZIx5mCZErc6Hx9E5djpvdZZjZt5itdtY=;
        b=lkSbGoENEnE8LutZLSmIB6Q037ZzzwuUaQpA06WQPVnJv78fIgrlXa13+xHllXDdwk
         lgGBP5R4vcdWcl3rEnnNB1ESQKVWaDPNZvBjwIaOh1zYaAb1I4ILnLx/JwGn6SOim1KK
         zBkwAsDfp1Y7cNVE/Vx68k2tzrz5LAuo/qQaeoTzmn+PEtzbYP45F548zQGGLg+Fw43c
         BM7MX08FgQ6Tdl1CsRyyhuDQYkLgPs9BRWXj6Dg+ddpd89iHBkPHY/vu0HTQbfQQiQPO
         qbr+lqN7VZGdMuhJwbTlp3fpjSjllm5LW4/Afa/IVKie0xAxfliEh8zvvzhGbXMQev/3
         JN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425382; x=1750030182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SU8RawjSZdNZIx5mCZErc6Hx9E5djpvdZZjZt5itdtY=;
        b=u5J3GvEuG0O3p9kQBeti69cERKWHV1JT9WWjetz9uXAxnEC/hqrAVIrxD3Jb6N6qG6
         Q0l+9p+lsJwXKtcNxycLtNHOnGVtble/h2D9J/G4LqxWTJZlFbs/MY4nbgu93wJNI2pE
         3wTNkIXTTnwSKiHZ52s4VocMtH4QRzmufz7FRw3rWZd29KdoUA7KSC8VaWunlmzmBCeB
         NP+2P6stLGw00+bAzmhTWOm0iOIHrgQN66qZ4pTOba0IQlL3pWr6+lBNTXQeleyC72OF
         BsmIq+bumId+wfNpV64tv7/nIChiLf5hVyDVPKlhLv9RgEKTmxNzfMvnoxgDMXaGFjNp
         ExrA==
X-Forwarded-Encrypted: i=1; AJvYcCUAePaSPd96Ig+PW6iqhPHs1AvqZmSNrOZ7KbIZ6SqeI+lCtIynoQWNX5sSpAgO1SwObdZJpQ7uUR1b@vger.kernel.org, AJvYcCWVRwnQZtTvi/iVQvYnnNOSfl3zwqYNuZmEOsyQPe/FAPex9rKSfG0mDymc0/3E5qf52k4j+1fp@vger.kernel.org, AJvYcCXsWzWP3vYu5thkoaFz8qvlyojpeRDBfYqbO2rAws4RYRE04GpPxi01b4IYqw7D4pgBuCfFrm5Et4ZiyFze@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4459CYh80HwvH/kB5zHvvpv6z3EnFrQImnT/mQ46d3nOoRlK
	33EYmunwvsBJ2hfynny2u9JQI5b/WBJw0iVWFhtRGw22OT7Iwiczawrg
X-Gm-Gg: ASbGnctVipoTvYsnA6ItZIGADUidFP6tHlB2zT2XR5Vi09xb/GcR0b88+O3CohTDID0
	VI/2cfl6ipewagAnz+Xg+lHBFMnm/jaZqYPxRC6+2NlR7TEIiPqRP+h3oA66vOx4Z0rOTv7vnqK
	BipcVi0MmG2j7J4Guf8KNt1JXaZ4jJLanvDEWHFtovfYpeIvnIoku0Z1P2h31XvPmhyeSBszF2q
	B4Fmpuua2B9XdlxkhIE15a2ONv4720opZUPSIiKp0/woBZymkfE3WqkMAVAhaIXhlqqPtKEn0F9
	pXT14PUcYpYBlZ++KF2Uv8h0dBtJ5IDLkC2JFw==
X-Google-Smtp-Source: AGHT+IGptkGsilp0rjRsjr4k4/JNTYB2bLGg6xQxJeSBP2iNfrPSLopfC8ZXQso4Bk3xGJqa+Kzo+A==
X-Received: by 2002:ad4:5ded:0:b0:6fa:fc96:d10a with SMTP id 6a1803df08f44-6fb08ff86f4mr198607016d6.27.1749425382538;
        Sun, 08 Jun 2025 16:29:42 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09ac85a8sm43748866d6.35.2025.06.08.16.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:29:42 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Longbin Li <looong.bin@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 00/11] riscv: sophgo: sg2044: add DTS support for all available devices
Date: Mon,  9 Jun 2025 07:28:24 +0800
Message-ID: <20250608232836.784737-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the clock driver for SG2044 got merged, it is possible to add
dts node for all support devices of SG2044.

Inochi Amaoto (9):
  riscv: dts: sophgo: sg2044: Add system controller device
  riscv: dts: sophgo: sg2044: Add clock controller device
  riscv: dts: sophgo: sg2044: Add GPIO device
  riscv: dts: sophgo: sg2044: Add I2C device
  riscv: dts: sophgo: sg2044: add DMA controller device
  riscv: dts: sophgo: sg2044: Add MMC controller device
  riscv: dts: sophgo: sophgo-srd3-10: add HWMON MCU device
  riscv: dts: sophgo: sg2044: Add ethernet control device
  riscv: dts: sophgo: sg2044: Add pinctrl device

Longbin Li (2):
  riscv: dts: sophgo: add SG2044 SPI NOR controller driver
  riscv: dts: sophgo: add pwm controller for SG2044

 .../boot/dts/sophgo/sg2044-sophgo-srd3-10.dts |  48 +++
 arch/riscv/boot/dts/sophgo/sg2044.dtsi        | 313 ++++++++++++++++++
 2 files changed, 361 insertions(+)

--
2.49.0


