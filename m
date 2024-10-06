Return-Path: <netdev+bounces-132436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0485991BF0
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09401F21F40
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D52C15383A;
	Sun,  6 Oct 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfrgKt6/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC81EB3D;
	Sun,  6 Oct 2024 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728180381; cv=none; b=Y3VGifI3FrJ2wu6KDX57aml76FFce0VE2ZlwPzgl6gPb59+KIX2scgO4u3qWyTVH0zSqdBbIRzc5WaYiIi/obvRiOefNEXbUmMcgX7aAn8/OTHEf2t7zq6ajvHdEM04P58Lg+Tl8W7alThGAfaTix4aDqD5VYE5ncUkUIC4lsvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728180381; c=relaxed/simple;
	bh=jRRdndmoUKYjBD9WMzLfMCSoghPj+XCZoiO035+iekM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nR0OKFXpN6tQGv38op+e+AGdRLzqud7rVAtrk1HjKPmsGrej1mix68gHEQ9kjMiYgtTEzwTMPxplUfyqC+/Ag2sRjt3ENXjGRV5D+9WVGiunw35BC7WzG+rudB9fHXztmoFoqBpkUYR20tDDrdDIez54QrYNzzzE7JyCEM+7rTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfrgKt6/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71df2de4ed4so504630b3a.0;
        Sat, 05 Oct 2024 19:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728180379; x=1728785179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XAibBfhUKhCccYl2NiBTUdEjgCWCGtQ5sFxnGr8oMlw=;
        b=GfrgKt6/ma3xPSMteGJKUkKpHHnSUG9edRrv+8sNQzuUdGmR1O6CSjJWcjvQpat5AP
         O8i3G48K0x/h5CDQCt5tmpZKrJU5/LEJkPsX6uI5hO0uevKyEYm3/mf2dLsF4+GQgJx9
         ftGgMBQfVScHHVkFv5zw7CxQbjAjHxo+/52ulfyIgkZwquGJJM34kNGieQpiHOhWpYVg
         Pd8rSjH5sKvW9DUwaHHyshu4FpMpVLz+h4vIwJWrv6gpeWhYo3mGmN/Lv9zw00bQyOVd
         33aw41OQAMRU2ES/kFABOp0sJkDnZqXZmGzcKQvnLnqTW5o9jt73ljjNcKaQMR46SCVd
         /fDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728180379; x=1728785179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAibBfhUKhCccYl2NiBTUdEjgCWCGtQ5sFxnGr8oMlw=;
        b=AQ4It4u7J0s8abJJLX7oTRIWInAGn5b5nMZpt5OifNQKTGFSidyRi4Mu2AR0SCjjZl
         r1fmHV88w8SopsAsIGzfzB3ZEiWbHHxXcdPtlL4mwiP0v3hin6nLzq0fH6V7Yp+OjNnF
         l5IZvI0+ZnJNaY+LtmhIVWpLiu4YnkiAWQp5MtcpZsPxYYkTBhmQfZLquO+2opLAtj7y
         plm7Xh2+6LVjrqlbkwcpUtf5s10UJHdNlm1uFh9GBhI+Ellbktc1dLtDjSkMPTMULNXB
         yz20lzpxDKkTXlvlyCL9ykvusBL2l8hTow1C6/2filjUy/VZfEnhnJMBcF67IrBhQLtv
         r2WA==
X-Forwarded-Encrypted: i=1; AJvYcCVhswIDdihsv8PKtyw09Oc7w5WYV3hUh3bevaMNjH5kV3HUibeBfF8/UNrfTN2KV+K65cAWfZbWvgA06o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyajj72pfvuuXhKTWNyHqbdImrGcTiHI1mIdb5BFiCyvlkEWep5
	t4RkE0hAf+69xwAGbUGznqCCw7f63DzlRX7AzvGGWr8VIFXxMeAdIJWTlA==
X-Google-Smtp-Source: AGHT+IH5gVgQThNKSMO5b1amVkcTE1ZAvicMEmeoAzs6j1coxAz2zlBCBFfp2035efOhwNQymUjfKA==
X-Received: by 2002:a05:6a00:3a14:b0:717:8b4e:a17f with SMTP id d2e1a72fcca58-71de22b52demr11013411b3a.4.1728180379125;
        Sat, 05 Oct 2024 19:06:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683153asm2034212a12.50.2024.10.05.19.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:06:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv4 net-next 0/8] ibm: emac: more cleanups
Date: Sat,  5 Oct 2024 19:06:08 -0700
Message-ID: <20241006020616.951543-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on Cisco MX60W.

Added devm for the submodules and removed custom init/exit functions as
EPROBE_DEFER is handled now.

v2: fixed build errors. Also added extra commits to clean the driver up
further.
v3: Added tested message. Removed bad alloc_netdev_dummy commit.
v4: removed modules changes from patchset. Added fix for if MAC not
found.

Rosen Penev (8):
  net: ibm: emac: use netif_receive_skb_list
  net: ibm: emac: remove custom init/exit functions
  net: ibm: emac: use module_platform_driver for modules
  net: ibm: emac: use devm_platform_ioremap_resource
  net: ibm: emac: use platform_get_irq
  net: ibm: emac: use devm for mutex_init
  net: ibm: emac: generate random MAC if not found
  net: ibm: emac: use of_find_matching_node

 drivers/net/ethernet/ibm/emac/core.c  | 91 ++++++++-------------------
 drivers/net/ethernet/ibm/emac/mal.c   | 10 +--
 drivers/net/ethernet/ibm/emac/mal.h   |  4 --
 drivers/net/ethernet/ibm/emac/rgmii.c | 10 +--
 drivers/net/ethernet/ibm/emac/rgmii.h |  4 --
 drivers/net/ethernet/ibm/emac/tah.c   | 10 +--
 drivers/net/ethernet/ibm/emac/tah.h   |  4 --
 drivers/net/ethernet/ibm/emac/zmii.c  | 10 +--
 drivers/net/ethernet/ibm/emac/zmii.h  |  4 --
 9 files changed, 30 insertions(+), 117 deletions(-)

-- 
2.46.2


