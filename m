Return-Path: <netdev+bounces-170032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6895A46F55
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 00:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF41C3AC988
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CAB25DAF1;
	Wed, 26 Feb 2025 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il/syCvH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A84315573A;
	Wed, 26 Feb 2025 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612227; cv=none; b=kn3lARYYA0KpRAG4BS7uWFOzqTRSOU720DMMn6sZJakbBVYEor/zfRdjeegBotbUxdVd70UiFbatF1h5iX/VG4e/de+xKWuSq3eoAj6RT0HNDB03Ada6ARx0GezKmd/SB+xwLV0y282s8JQW9VLrjcOr9LZDt3E+6l0IXh6hlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612227; c=relaxed/simple;
	bh=NS1U6w0kHkdvmIq20iE8adLqx2agJBYWUsJJbrc1VOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTWX6jlk/5UNFWfVgmA7dY/d0LAsafJpE+5I+kYapCpHEThssL4fK+24wlWgErDpl/uLteiNjz1fdIoIljVb8ti78XhULfRbS433hIVanh4L0l+O3P+iIeShD6eZoQo8dDNwWkE1DMlJeRAPF2VH/tIrE6rjTkQdBjNq83ccZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il/syCvH; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e897847086so1251096d6.3;
        Wed, 26 Feb 2025 15:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740612225; x=1741217025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ybFFMG2SumuDeFcEvYzcDXHRApRA6j0FZMG4qQ5XA8A=;
        b=Il/syCvHKW1O8zRCocqEhRPvEP1SF8K2GVB8FqAJ2DkErwzPN4Zbnxobv5wgVwzvLT
         KTJgV45iuZ1hxK+BPeuFDpEQWOeXoOsdsicblvfB1wfMmW8qgo/7ZNHG1xkzpu5O5bTu
         zwwFBGG/cOD6Khl7wdz7Z2sb+0Ox1aamZeLXAuDXEFmK1bL7axZqkwKNTQQqo2OZOabW
         M7H2iUd229Wav5OsQliIPiERzWFX1zRYBuxZmYvdE5StfoMBWbI+5/VGw/QRXIJhjmfD
         +Cc3Ymbz+NsvU+BRfBVkAHVt9IXbZq7w4P0fDW0T7MBBk6r74Am/EpMVlRYhvFtVlIrg
         I5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740612225; x=1741217025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybFFMG2SumuDeFcEvYzcDXHRApRA6j0FZMG4qQ5XA8A=;
        b=cAYoYSwU1itm15WottVkMe4XVxFHVH4WWwk9aLPNCXaFPlXGbGwPXWeDbvRY8LP3De
         /jwIMWb8yGygVPfDw6V4VH7SwwvFUKksPOTjXpysuZs7Z/sTehGx3sujEEaxkU69C8Nr
         INe89icjFePOYkZ3g3Z0a7PLheAQ/b4yqKb7f92jtzek1SetWba07SQ959LUZj9mkde3
         G0SPjiiu2xxduNGMU9aAugKw9m+SeHxWWfHOROsrf/QpT02u/brG/T4GyuS/kwdz7jwC
         u9qT2VDJVSW/0Bnkg8V5ehPJipgG9+a7MWvMxYb/q3ies7m8iQ40WCf/nsSt1zUiGEot
         Z/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWq4Dm+l2sdHDKrBsjkpJoGKvsfLu3I59oujjeGkQwG94lCA2QG3tMIzm3W+9NrH4U/x2GO6vkUANV3M3I0@vger.kernel.org, AJvYcCXP9R0HsJKX8drNnP31ZIrGGOWNVrzj3Tgxz3n+OYmGSfKoV1kSz0JF4WRwL1tfj3YqR5Ivnmns@vger.kernel.org, AJvYcCXvvunRiZlsSKg9NWyBMBBXVObUVxsnO5lZKUBx2pkxp60hjvyyzqsT0p1HYinltOgiwj7xCYy1sbDJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwgZUK3TFx/D2zNx4XmazMvqKYZWWeLuq+vYnkU2AywtPX5IoQP
	I+BuSiYO4p4EFUrWoX2UCBk/EZZKJHDi2ULKxHE4zfNNkcbu4JfSOVCbyg==
X-Gm-Gg: ASbGncvJFj3e0xjFv/zY6QSiE+TZOmitkQXf411LCTlO265pXiSMV9k4C5W8wC+6TVP
	l0aFLFH52nqs0Is8xuinlEWp8jz/n+BUQ+ErhBo3FGYczRSmWZZYo/2Rg3JAhTjW0uNarCs8KaE
	lue9FJ4/Gm7BXxhdsgBqV3QNKexiwB+jFAWjYA8uXKYzbLk3P3jAJAJCHvqGYkKTjJMueZQl6jG
	I+yaNysPdyOxYpLvwlBZoe4KYIfCklxBjfqrVN0p3lFDiMNMKINQk+EN8HE2n3m3bbFhLYd27AD
	bQ==
X-Google-Smtp-Source: AGHT+IF7cAYgeZFCIwEduu3hnNA9l8ESzsaaMKaj+MfGgWzkHkWX96Oowim500RK01tBq3mq5C+HwQ==
X-Received: by 2002:a05:6214:400d:b0:6e4:3de6:e67a with SMTP id 6a1803df08f44-6e6ae967571mr246610626d6.30.1740612224915;
        Wed, 26 Feb 2025 15:23:44 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8976613cdsm2287886d6.56.2025.02.26.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 15:23:43 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 0/2] clk: sophgo: add SG2044 clock controller support
Date: Thu, 27 Feb 2025 07:23:17 +0800
Message-ID: <20250226232320.93791-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock controller of SG2044 provides multiple clocks for various
IPs on the SoC, including PLL, mux, div and gates. As the PLL and
div have obvious changed and do not fit the framework of SG2042,
a new implement is provided to handle these.

Changed from v2:
1. Applied Chen Wang' tag
2. patch 2: fix author mail infomation

Changed from v1:
1. patch 1: Applied Krzysztof's tag
2. patch 2: Fix the build warning from bot.

Inochi Amaoto (2):
  dt-bindings: clock: sophgo: add clock controller for SG2044
  clk: sophgo: Add clock controller support for SG2044 SoC

 .../bindings/clock/sophgo,sg2044-clk.yaml     |   40 +
 drivers/clk/sophgo/Kconfig                    |   11 +
 drivers/clk/sophgo/Makefile                   |    1 +
 drivers/clk/sophgo/clk-sg2044.c               | 2271 +++++++++++++++++
 drivers/clk/sophgo/clk-sg2044.h               |   62 +
 include/dt-bindings/clock/sophgo,sg2044-clk.h |  170 ++
 6 files changed, 2555 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
 create mode 100644 drivers/clk/sophgo/clk-sg2044.c
 create mode 100644 drivers/clk/sophgo/clk-sg2044.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2044-clk.h

--
2.48.1


