Return-Path: <netdev+bounces-107225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9319B91A54D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D04BB23E16
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968D114EC7D;
	Thu, 27 Jun 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lr1Eq6lI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC2C13E41F
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487830; cv=none; b=s7jk5LXicJiSJnAYkH5SZ+1e39zqdcJ3rpxKxDz/kuj+Oq+2IXHZ7//o/M+32dCxgrEa0FmCqq0WcRKgfcpsUcKTdrY6Wmi1HNgSRmlvTKkufhbmIAWlAzLUGut2NdZXTJ7YZ8KYKTKOcNkrEkMJALwkdu3JjAzw8gqvQZdWDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487830; c=relaxed/simple;
	bh=V7r2h21rFTkzap9aygRNENNVZJFQU3oVk0zUaTf6w7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l90MT70b0F4/PjTc9ODjyJ/FMNlx427PBQ9B1KS47j8wpn1nnU/toB/eyoI7GUwAFdFAL7QodnH5oKKwAwkQPWXB/EJwDStLWWyv5dViJffZNHfe7wMV7aaGKHxDUIACxUTctlq8HHLv549W3Ui0LuJLpdhvGbJuXiLieFvnRhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lr1Eq6lI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3645e9839b3so5852927f8f.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 04:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719487827; x=1720092627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19tyJfMUE4DVOIgXmup8kim9fX5UU6ImAnNUuH8s+bE=;
        b=lr1Eq6lIphuTmEDaWXHvfdxxkCzm4V50A0T5G1cyI3niLKSvTvcyKkw+PfdvOZIgy5
         bULn7We22ZVC7gewAtkESbmUrlj6g1nxDvBrR3Hb8yar4SisT6dKoSQ6suIVhzM4CRCi
         LF5qoUC9yyXX2JAXA5X7PUIBytohD9B/wQf6B/y7X8zNIULmIfQoMu9WvExofQvigr3H
         kHfZlhM2RyivtQmKDsOI4XUWo511LEzC1dvhrOuQJNqYu2Qmb+5PuYRdtuWVnFyzVwag
         ZptaSUlIgYqVcuc9Ykrd8+sI848VXc0NYBN8gO93HcW5JR/AICvaKmcjs3WAnp1XNgXH
         7hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719487827; x=1720092627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19tyJfMUE4DVOIgXmup8kim9fX5UU6ImAnNUuH8s+bE=;
        b=W8X50+pZd0PVZkYb0UGfGiLeIgBN5PjqG4goCT1lvYWOMstiZk6HIDyeTg83ZSh480
         PwEgGXUrLpjLPkXQ69/soKfz3fHg2+noNj5ZDagZkVV3OzTHRLaURDISBX6RP5zBN/0a
         G9Kr0BLzYgwticzwYa+iRpmoAt26lDBOh/i/pZg1EJg8cpfXRVYFlpYsdVmHyZLObyYi
         83NnG62RC/1G+qk3yWdnjJo0frpYw6ibOnl/2U6et3tU6qZ1Thixcf2gzPTcieIKiAK5
         PDsmzJjHvwVzWpXoL7Uj2rsIFw1YR/5afR65j05+tVldnrhUK0icq9thaQzz8i0j88od
         uLKg==
X-Gm-Message-State: AOJu0YzIvhEwa6J9VqInOD0qq6dnPuaMThf/Ivs2GwLHU9ahNaUb4hOz
	xQhfQbkVF4Zug45NZvlknk7M04P6ix38RwhRVHd1jHSe7RD1g65BQf+KA51fVjQ=
X-Google-Smtp-Source: AGHT+IHSUpz5bBPpRgQwtkfsRytpc7pZaY3huimeERHs0j+GwTVHATRTX1rTfcNxT4paSJOr0EG8Gw==
X-Received: by 2002:a05:6000:231:b0:35e:6472:4390 with SMTP id ffacd0b85a97d-366e79fe9eamr7560475f8f.27.1719487827268;
        Thu, 27 Jun 2024 04:30:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36743699ae0sm1504111f8f.66.2024.06.27.04.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:30:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 net-next 0/3] net: phy: aquantia: enable support for aqr115c
Date: Thu, 27 Jun 2024 13:30:14 +0200
Message-ID: <20240627113018.25083-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This is a smaller chunk of the bigger series that enables support for
aqr115c and fixes a firmware boot issue preventing it from working on
sa8775p-ride.

Changes since v1:
- split out the PHY patches into their own series
- don't introduce new mode (OCSGMII) but use existing 2500BASEX instead
- split the wait-for-FW patch into two: one renaming and exporting the
  relevant function and the second using it before checking the FW ID
Link to v1: https://lore.kernel.org/linux-arm-kernel/20240619184550.34524-1-brgl@bgdev.pl/T/

Bartosz Golaszewski (3):
  net: phy: aquantia: rename and export aqr107_wait_reset_complete()
  net: phy: aquantia: wait for FW reset before checking the vendor ID
  net: phy: aquantia: add support for aqr115c

 drivers/net/phy/aquantia/aquantia.h          |  1 +
 drivers/net/phy/aquantia/aquantia_firmware.c |  4 ++
 drivers/net/phy/aquantia/aquantia_main.c     | 45 ++++++++++++++++++--
 3 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.43.0


