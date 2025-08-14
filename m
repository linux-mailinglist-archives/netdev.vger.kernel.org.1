Return-Path: <netdev+bounces-213595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C39B25C44
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D55097BE3BB
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 06:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A1425B662;
	Thu, 14 Aug 2025 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRQYIAUW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE325A659;
	Thu, 14 Aug 2025 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154453; cv=none; b=dpP0BO9JkEZDhb0cvFme2m3h2u5eM6neRT9O+2WUWvmvA76KFqTkT7uu7r53ajuZHPCEi6kKyrpppWCCv06svvDKraBPvEzwL1K8mWcl6Yw0+jn+X55tETVnTuMMbB/f7qWXmGh9zCzjrUTSgHNaIqTmiCSvQ07x29ckMWKnXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154453; c=relaxed/simple;
	bh=qPOmF8X+ul9sI1+kUi3Z22jKR/UPA0yF9QOUMlyATrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVYuj6MmO7gKL4zh7QqJ+TC+9NW9WPMVU1x2z/3v4e7sq3bIIyxbyyD83UwTNKTFT1OvHSTyWbtLKzA8Jl91iq+NQR9TwZAybWVTg/6HaFMDUBa5Ch25CP3faFBGAKMmzz9nz3b8Cec2VF3MOUTrbps//+cKEABaDMsrRw5t5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRQYIAUW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so615289b3a.1;
        Wed, 13 Aug 2025 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755154451; x=1755759251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNO04ueJ7GsEZkZjnNMgZ2lJUA+CBUcH91RVHrF05lU=;
        b=iRQYIAUWHgmWHMTkuoWvnU1E6vwPT9TGQ7f81RkFUAvDQFdfvSRCLeL1Is3NILAH5a
         q6DzXtXW2yHGo8wCb+EOiHVWRgv+d7mR6nAVZ0Lr+AFXRjYpu5TeO9HBEKY/ti9iy0+X
         Sy2OGeKxg2cVqNQK9ZgsvDMuvV8+eC2/uNDzFoQpwinSW4NTgURQ8PTz3+muavoa3ER2
         pLDwIiDlfSM1TEvHx8QgSVNNsTuMfa0Kb6BNcyRGQKY0LoiwIfCOg4qMqeVJZeGE5/5h
         q4C4mFHVF4ij9jTiv+nN4difh55ArlWeL268G2AhYkd51sgG8ZRjYQ57GmK636/coK1I
         ySng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154451; x=1755759251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNO04ueJ7GsEZkZjnNMgZ2lJUA+CBUcH91RVHrF05lU=;
        b=N0BFsadF0+NEBz/1XZ+dmvwMEmRvI2bSCrYtOQtK3poxRy4nkn0sSkxWN4ESGIVi1c
         TagT1k5z5UVo/KiXkbMh3Dz33U1wJ0+sEa2upBzDy1kfiOfYbxPqsuL7aEfLxo5TnZnY
         ncWTSCBaSFq8vGRhVpIDxGqUxc2T5tTtQGMnl75bHPbG5B3+0dbLpan1qCHJZ+Bd+LND
         9Mm9z2L5PYhXi1hNkgXhCUnUsN5K5V2iTpLAakGALoL4uVm9xgvu5JXXhb6GMINGHnk/
         Wb0CCfJJgjsV+Mvr1lHPS+68QU/mBxbAQxz3twE8xuGveEYZ7Xy2NvFdxvhLvGNfMP3G
         i2Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVI5k1Rl3y/g1alXzJQHB0reGXQZ7Ex6FLpPyCDV6p/yCKYgVmMllo8uz5jrUvDvtnLMhD3EE6Gp5jiRXpd@vger.kernel.org, AJvYcCXE4qrUMQDQhm8u0c8vn+vuSDvrJTPUGY9j4QC2INNF9lRamI9MoDDngHcngNZaSJPvaCs2Dl9F6X/n@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfksOElMw6UPNCO/RAD44l5aEq4IDMZiSOUXeMuFzrBBJtvzN
	Dw+OKVooN/FHRc+ZuAFmUAZL8jScGErErxK3ueAnBEqA7hwmIxdkfy1AdqCb0wdPw8s=
X-Gm-Gg: ASbGnctzRUxcD/FaCaqlQnWhbz9+m1gB2QhQsoQz+ndjR5yMjfu6xL388CftzsoGHKH
	ESCf2aNSMJutolhTtVbx4ZuAeaBrsQdHRKz7qQtzySd+pH3jkhIZkr+q75iSvwKiIlt2rMsq5m1
	I+aOWPm/ksKcu57Rmw9WLyrNz04JhtL86kTWlHbaG18gGJ+zUF0pNsZF/+nMLHMEPmiEHLUXsjk
	cwUD8gV1b21xMxMoxm2iMIwpvAhiWYbAV2ZpYp5CFHzKhqMNc+Za9dUipRcGAAuX2/XkHk43dW4
	ouV/k/+czF9Qjqd8ytyS4jQusSFc2CCqAeTKTanzWD2UHM2UAChfyjX2/k35exUy/YQdKF1Z8o4
	eyn3T2d6wDz+DNXfB0BOz7xl3ujdPQV202B+kJMu/
X-Google-Smtp-Source: AGHT+IGzh6LO4OUxlGinO7bGeXKlcn4rCkGKpKOlANYir7w9Z3SXX3ZxSgbnv7zVkQVUCHR5/ROmog==
X-Received: by 2002:a05:6a20:1611:b0:240:1e63:2dfd with SMTP id adf61e73a8af0-240bd24145fmr2945624637.29.1755154450748;
        Wed, 13 Aug 2025 23:54:10 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([89.208.250.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7bb0c0sm28425078a12.20.2025.08.13.23.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:54:07 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 0/3] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Thu, 14 Aug 2025 14:50:19 +0800
Message-ID: <20250814065032.3766988-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motorcomm YT921x is a series of ethernet switches developed by Shanghai
Motorcomm Electronic Technology, including:

  - YT9215S / YT9215RB / YT9215SC: 5 GbE phys
  - YT9213NB / YT9214NB: 2 GbE phys
  - YT9218N / YT9218MB: 8 GbE phys

and up to 2 serdes interfaces.

This patch adds basic support for a working DSA switch.

previous rfc: https://lore.kernel.org/all/20250808173808.273774-1-mmyangfl@gmail.com/
  - fix coding style
  - add dt binding
  - add support for fdb, vlan and bridge

David Yang (3):
  dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
  net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
  net: dsa: yt921x: Add support for Motorcomm YT921x

 .../bindings/net/dsa/motorcomm,yt921x.yaml    |  121 +
 drivers/net/dsa/Kconfig                       |    7 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/yt921x.c                      | 3390 +++++++++++++++++
 include/net/dsa.h                             |    2 +
 net/dsa/Kconfig                               |    6 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_yt921x.c                          |  126 +
 8 files changed, 3654 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 net/dsa/tag_yt921x.c

-- 
2.47.2


