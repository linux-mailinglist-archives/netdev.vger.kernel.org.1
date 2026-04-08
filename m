Return-Path: <netdev+bounces-276283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCbFBxzo1Wmw/AcAu9opvQ
	(envelope-from <netdev+bounces-276283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:31:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F97E3B72B2
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F38D30182AC
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 05:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C8359A8E;
	Wed,  8 Apr 2026 05:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8ZWPWMq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851F3570C8
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 05:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775626257; cv=none; b=DAc7q5OyH52Gpfp4BAdRrZbpswHjFhbVzAcH3VqmtEdMXm2su3i5W5TOzcHDa9FF5T+kSoRkpgEkRtrb8I7mWITSVT4r2l4y+GU/BHYuBJyI17xTHDMM0hqK+MyA7rkr4RzJGKIuYKpauMuarWmpSDv/y8OT3ziZC9BhEIjZJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775626257; c=relaxed/simple;
	bh=2bvutzs7rtzWgmeamR13PJ6ItU9+5Cs+DqdG83Mabhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bv3Z57GdrzFlTmVhWMCvz8XZvptaN7buLxP5jG8y83Y+O0m1NJcqvHExagEN1om7+J45fzbCXYfP6I3oNgML0jZUPrXRBTlK4ukWEn9UGVwnPRQx/CNWi5FMDusGzfKoQbxxKhmtMx6VZgwldm/Mt23o4d3/bcSMp6lbf7dvEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8ZWPWMq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2ae8a0103so10252235ad.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 22:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775626255; x=1776231055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G261iPgwxdDm9fBlFNsCEO8KxZODyeiwStlQ3uz07JM=;
        b=V8ZWPWMqIM0a1pIwCeYyr7S7yp7Dco1DstdcGm8g9rxA29Efde1Roj1i5rcE4iBJPn
         fsHLZhnXE8c5cggjmHM42eT3uoMXlTw9pZqUvlB3J4qUmJGuMa8PihJgxOtHA7TJKbWq
         iczR2H/A2QgWbT1TY4Px2AKvigew9sNEWySTDTHoYPFVuKUmjdfKRNzOoAee4afwiNHW
         p2NCoIgnkBIC9MQKNROYRzF+hy7M35Rt4B4StKYoRWTerL4bCioqceGnedGlFVb1zLiy
         RA1vi4luuCyS44b25VMz0M6Q1tLapccjDStg10ebjYnZvPar3u5zqJ6xshcsqGpBIk6e
         8Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775626255; x=1776231055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G261iPgwxdDm9fBlFNsCEO8KxZODyeiwStlQ3uz07JM=;
        b=Hk9FI1hJrJkYGkI1ht2HD48RPwmcG+dcb2r7vVygcrQg6UXFzVGKM0aaBeWn1UFdVT
         YZC4hKiSgKJLEJdtIbMxjlfe7k0vKCNf7PojSMu9g8/MTomkmg+OptmwTDHNLlbbPfe2
         kgGKtk5bd5z38f9VmtlDnC4XbeXlI2VFcGhhRjVUsv3ZjzREhCoQYy3DbCsULHo223vd
         pk/4kBlRoSF9Vsfgx4txFE5R6JOI/ONhy8VR4ezXwcb6SmbtqRzP/xkGFSIuuefUDGZ+
         XYn3DVmunCaSMLW57dT14IIwLxupfcjN1hnMc3Pqr2U/JOeTvRNq6UMH94ZcBx5Ont5G
         Itog==
X-Forwarded-Encrypted: i=1; AJvYcCUzCEFOKJbErdqqGFbuelRE2OxpyQHJoWIXXK5mxbX2UtTkakwnI0RuR8XFE55B50kOnR0Dh1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC3uDEEUhaLg9ItLuHd+ChN7jFTgSmdMmE7qqgQ8fIqE1N1Esy
	cgYkUN/wOyLXDjsWtBE2ZXDL+GLoIY0MDGYDDwLtYZWfU9/bElR7L5Yh
X-Gm-Gg: AeBDietOKRVqZ1bbVgzpfX19GnZLRDrhkVP1GJovMVkZd2WxC8pQq9dtNeKNqie1UTO
	dOkk9NOKm6M68y0Ooiv1o2snw/f5XcYkxynPfrhztfhuv76qZ0nk3QG9JhrgKxKpCGUk/YZQCe/
	YyWdBHlLo2bzWehac3StAmyWKVORUTkK4+sGSvR45tQyFRNcJ9rZJyHwDE0AN1kODvPCjKOnY5A
	Ig0g867T/mVujqWcblGQPx9Bt/5kXdFONWtwlG0CPoaDUCz11RBO+f54fTLjPA1Q1gtTL7DqPIh
	AVxoF1JpqXf5wDFFbfRj5BbhuoroJHrxUlczJkWt0FyS6fCKYHtvat4aS9kPjR/NTX5Vric7Ssa
	EacwvvS+/JsHvuRNRUUbvtO8gtygAMeRX8rIfsGwQrDBQElZ9ZFJH4yvwqpuZ4St3A/bwmVi+nZ
	0opTjMvfellQFohCQe71onnYw4T8zkMCslOHSFzOxYKFfh+S4Wi3IIrdkp+worcFietOGTdpNCT
	ffX
X-Received: by 2002:a17:902:e78b:b0:2b2:57df:264d with SMTP id d9443c01a7336-2b28178c3b7mr208603985ad.33.1775626255168;
        Tue, 07 Apr 2026 22:30:55 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d098sm181673475ad.13.2026.04.07.22.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 22:30:54 -0700 (PDT)
From: a0282524688@gmail.com
To: tmyu0@nuvoton.com,
	linusw@kernel.org,
	brgl@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	alexandre.belloni@bootlin.com,
	wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>
Subject: [PATCH v2 0/2] mfd: nct6694: Refactor transport layer and add HIF (eSPI) support
Date: Wed,  8 Apr 2026 13:30:35 +0800
Message-Id: <20260408053037.1867092-1-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-276283-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0282524688@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F97E3B72B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ming Yu <a0282524688@gmail.com>

The Nuvoton NCT6694 is a peripheral expander that provides GPIO, I2C,
CAN-FD, Watchdog, HWMON, PWM, and RTC sub-devices. Currently, the
driver only supports USB as the host transport interface.

This series refactors the NCT6694 MFD core to support multiple transport
backends and adds a new Host Interface (HIF) transport driver that
communicates over eSPI using Super-I/O shared memory.

Changes since version 1:
- Reworked the Super-I/O access helpers.

Ming Yu (2):
  mfd: nct6694: Switch to devm_mfd_add_devices() and drop IDA
  mfd: Add Host Interface (HIF) support for Nuvoton NCT6694

 MAINTAINERS                         |   1 +
 drivers/gpio/gpio-nct6694.c         |  26 +-
 drivers/hwmon/nct6694-hwmon.c       |  21 -
 drivers/i2c/busses/i2c-nct6694.c    |  26 +-
 drivers/mfd/Kconfig                 |  47 ++-
 drivers/mfd/Makefile                |   3 +-
 drivers/mfd/nct6694-hif.c           | 634 ++++++++++++++++++++++++++++
 drivers/mfd/nct6694.c               | 180 ++++----
 drivers/net/can/usb/nct6694_canfd.c |  18 +-
 drivers/rtc/rtc-nct6694.c           |   7 -
 drivers/watchdog/nct6694_wdt.c      |  27 +-
 include/linux/mfd/nct6694.h         |  57 ++-
 12 files changed, 814 insertions(+), 233 deletions(-)
 create mode 100644 drivers/mfd/nct6694-hif.c

-- 
2.34.1


