Return-Path: <netdev+bounces-149982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE759E8609
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBC22815A5
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A19156230;
	Sun,  8 Dec 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="uPlzO+lH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E1F14F9FF
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673166; cv=none; b=T2CueBYWa838hNrrTUWYvQqLsqJNXiuqZto/vDWkgCTRzVxDTHZj8kaKXnYAZAYrNLUs2HMAySEQ0paguj9/me+qsyrWMDYeb45Mbw3JGSFzm54ZqDTFJnvXdfC+cNnz1SR7niTS6fNlN+dbHG5XHCZG1oM27yQXZvKyCkiufNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673166; c=relaxed/simple;
	bh=VD4Qw9f43PomdEuM/V+nuiBCc7OvB7jTuKobj+KPUAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=muF/ZlWuco2KuvPpNrhyu2d99cWK2vU6z1DFiweNNY0ZXjFyGunBe7IzHCbdQPVXLPytvTK4NanfHe4QFQpef/bFagjGRqQLmCNlHKGDoE/gVhAqeGRIhhMxlLGefXNq8AnvBb4irrOtA7LsihwPqt/OlsGwgymCWk2BZVZ7NG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=uPlzO+lH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so793474e87.0
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 07:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733673162; x=1734277962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUDshE47cNUIOHz1m9AcokVYqibtX3WeQ/bCIvMGGYE=;
        b=uPlzO+lHyH4SvDo+Xfmhyo/JWYmQkkRgCAcYbtTtHhzpsPcz5qabTBIFJvF8Z7TeEA
         P0jAn4kUrTC/HVYC5mwRJSeeBTSkT4MIBlT3KykkuOfpE4/JMIF8PP+Coxxloba6BqGD
         8AKpVtcF7wKgOOjQL5QjwGIYej6ox8Kba+5rmhuOoyNR0MqVWvi8p/UuBnq9q80OFrcY
         qahTDdNvQCjs2o+warcVYOE6uF/8GuPsRJDUo/92sKNySE6tU7z4LA9OyRFYdWysZEDI
         l3gbO5eFT8R7GSZ8gt3mgy9jhTGYONskVUcuqxJ81BrGZnjxPyKlzV8hQfEgY17zTebd
         opMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673162; x=1734277962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUDshE47cNUIOHz1m9AcokVYqibtX3WeQ/bCIvMGGYE=;
        b=FhYQbxv1AEazwhtvrXckkqub2nVewwsjKASNf8MDYqkCdUzlTs9UxGezvSnZqMSmzI
         4Tmu6KPcLyn9pWFQMRNwcUgsUAL9cgF98R9RMJoJD/15LYoyzhd6NLzi/9Wvfcx7hEKs
         oSCqnbPvhAZ+VKY5j1+r6utPrK/UFzOMBvtgG0+7CreY5ujCS6vuC//xOKc2gByG2+ai
         qw5Bi4782Yr0eGVK7BJ+FHNd1+5r1Zk/q1kLEPUxZ/GmfcrioW7OLwZmmsPi+CXKCqh3
         MeqoilTFFfmVDVBdbC1y9grUiBS3rtvFbbrAztpmssZHHZ/yJBe11+qNtEAW9OA1LD9f
         jKaA==
X-Gm-Message-State: AOJu0Yz/DA6ZbfuZuXKBzrnQNX5LQulHc/5fHTtJP2VrG5qokcJ5+WdD
	gGOhmcIsuP0xr3TqQFcc7cKPAiI8RFgi3rupkgBHa8ARYdUQnlB4KIXhJtSe4Vg=
X-Gm-Gg: ASbGncvKTOdyGN3qOLDqkHqfPF+S1NCAUiIkVn2br5D9cOIM+duFv6PABZB41BNm/AK
	K6znHH3mdPYt4HADhLYZr1P0tWRtcC+ccoFco9Z0oaL0BxNpRmZOafmKvc8joxx8jhCNcApo3Pr
	FChQno9gtbyPcl/gSB2Yey3ga8yWeRrdk3M2qu5Awv5kZ1Os6PKPRnUEZiZjdedEv+TJ7RLkcb+
	Bp41vZRznu+irPnMIWnqYyTpiGSIeNL/lhhAHj0R4U01jHZMxyWGbMJHph41wwz
X-Google-Smtp-Source: AGHT+IGHghPkOlkqc7UHPyf5HGz9Q3UJ0RZJYXinXIsqZJ5152lIi0r99E53/dB07JBNiLX9eei6Sg==
X-Received: by 2002:ac2:5b0c:0:b0:53e:350a:7290 with SMTP id 2adb3069b0e04-53e350a7447mr3078080e87.51.1733673161613;
        Sun, 08 Dec 2024 07:52:41 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a1ce70bsm580882e87.66.2024.12.08.07.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:52:41 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next 0/4] mdio support updates
Date: Sun,  8 Dec 2024 20:52:32 +0500
Message-Id: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up rswitch mdio support, and adds C22 operations.

Nikita Yushchenko (4):
  net: renesas: rswitch: do not write to MPSM register at init time
  net: renesas: rswitch: align mdio C45 operations with datasheet
  net: renesas: rswitch: use generic MPSM operation for mdio C45
  net: renesas: rswitch: add mdio C22 support

 drivers/net/ethernet/renesas/rswitch.c | 79 ++++++++++++++++----------
 drivers/net/ethernet/renesas/rswitch.h | 17 ++++--
 2 files changed, 60 insertions(+), 36 deletions(-)

-- 
2.39.5


