Return-Path: <netdev+bounces-214687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB145B2AE06
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCD41676AF
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD3B322546;
	Mon, 18 Aug 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT8BXXzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE2E2036FA;
	Mon, 18 Aug 2025 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534298; cv=none; b=USHoPd8UxH/LC9VlrlJ83uIfrwvYnkHQr8zv47sU5cswWbFB2krRKEFuZXS4Arrnoaz6D9q8htzgSakyykvwzuCGluVJvhO0hFuFAMGmza5zqNs7xdvpBDltyCkRXwaGo2pTi2vWTHaGW6RQX7OySSbjEKxdKw2JYvwGnCJCRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534298; c=relaxed/simple;
	bh=nXTmw6GWAifVFllg4i7eRnp18EwWbIQWsgfxOdRjgko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFM0p323i0ULxiDciHqghCO84wXWSUbb0xkSasnHBQrhbR6KE0KotLAYzKjStJtvDlkdGMebKFYlBjD2n1jDJl/CQzuUbC4l4vE4aPGfJwJyK7jgF2sW7zQU1E0bCCyxoacCReGDNL2dg8zrL3CdC/9hEN3v34JVDigvTzLitEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BT8BXXzJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea887f6so3229120b3a.2;
        Mon, 18 Aug 2025 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755534296; x=1756139096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aSXlHGeeKSrofwlWB1Y6c+z1FWhUEYFHATYlF4EGv2Y=;
        b=BT8BXXzJ/0keu43rcDrx9lMVlsbBIM8BWc+l4iZVMy9blxNUmFyxKiSp/Vwouw94cD
         pY6fNvT35Wj6HVYdbI5B6JUs49VzVd1eps/VdWhZ+iZ0NnKqdNU4WNgxAqCMsk9WQSJA
         rVDcW+m8/YvJ3vCLc64T4ZNkscrKj4vXf0WSh1x/zBsp2D+hqrVX6Au7BIr0KriEGuUn
         JhJf1rKnnmhTg/rJV0yzi2s0JvZSJgjjJS5ZTSoDfdWEHDHtql0z+idYu8FTHjC6MstG
         xWZvVpxpfrMw3S/hnUn2QXCvCjqqzJMaJkB+2HWmSkfzudoo9MyWgEov5q395m/zfoi2
         uzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755534296; x=1756139096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSXlHGeeKSrofwlWB1Y6c+z1FWhUEYFHATYlF4EGv2Y=;
        b=pXxUgL0+H8fdhqILCsxDojiDg1m20dYoMdeBhXhlIVIzGMstsmjPwreL7akO0LvW6B
         E8kNC7g8UpZQX5kqzL5akh0tlQO2nnukE3Us1+rRHsmW4atSa4AVwfZUHA/vqZrNDwIL
         Rr+UtOHtgKlWOJuDSBw2D3jWEHx7adDRfdINo113pIxD+w9G5I6x61nyBUFGn17Mk3PV
         EmJI/XPDCCLcM9olk/LaFd2POHFkjFJj3SCRS8l9LtWf7UdzKAS6WPAQNARaRamWr00I
         00DHBwub9W7JZNTwWxKuomiMlajl4Xj1Z+25OOSID+hCMwqdQGgXu+ndzPoqpYcYpdTI
         69DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGqugvbrTAdGCb27B1p2mj24KTjykAfO3P/0Le5WBvfMSwwYOhkQzpusDqPxu5DLS8BCBijenzpafQ@vger.kernel.org, AJvYcCWA3/Qo5/vXnUQn7uRBS764Bgc/6FhBikIFhBneDpwo3ZMG+oKVIhoeEnvtM796taiBEizqnP1uyLQ/8AGX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+6HzsIGhWi0x5HJ8SsvcMHJPXw7yC5Z0e1rQENYmQadLQDNx
	LO2qPyRAFggDEUQH1Q8H5/GOJfxb8TFmtkIYM+qb5EBHCyIRI7zrKeZmNS4+Mfji
X-Gm-Gg: ASbGncthZpa2wc8cDO2vUYxXUpVEh+KNdTKnMiVX8qXIFCw0w1Sar77lmssh9KruQ23
	uMkX+gmlRCLc/08eItBQhTj30uj8rGT9e21oUw7ajTvYrBc24TQ0XlMVSTtQiTMyqnIZYBTWLHz
	OFf/BEJm57xhbZ3FzEe7Uv7ClnXya3i0QQdDSmVx1ITQqZuTFvJt4YcBlsgLqAn26xSBKRlRvy7
	hKFKi+n1WA69sBwNSzaKVhLCcciiTxxa7DiFb7nzrjdjQifFMW6oug3cOlsJa9lpgt9ZwQe6r8F
	SXEFR8yrN/O239N5hJ6mH0kAIcHH+BUS4StDaii2qNlugvFo0Rf/j/f9AY+CSjxFCHtwgPS+Ntq
	Ji0OhXbdpBbolWjNa2/ZBDDMqIFQaGA==
X-Google-Smtp-Source: AGHT+IGpa9v9EDsid4cuzBx+iPblfKHBj/+fcaU5IaPaD81ST9mn0Oh6AVj2cQqzv4LWosc1MIRaDQ==
X-Received: by 2002:a05:6a20:3d1c:b0:23d:491b:76a6 with SMTP id adf61e73a8af0-240d2eccf42mr19052674637.20.1755534295886;
        Mon, 18 Aug 2025 09:24:55 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e400e8dsm382656a91.22.2025.08.18.09.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 09:24:55 -0700 (PDT)
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
Subject: [net-next v4 0/3] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Tue, 19 Aug 2025 00:24:39 +0800
Message-ID: <20250818162445.1317670-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
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

v3: https://lore.kernel.org/r/20250816052323.360788-1-mmyangfl@gmail.com
  - fix words and warnings in dt binding
  - remove unnecessary dev_warn_ratelimited and u64_from_u32
  - remove lag and mst
  - check for mdio results and fix a unlocked write in conduit_state_change
v2: https://lore.kernel.org/r/20250814065032.3766988-1-mmyangfl@gmail.com
  - fix words in dt binding
  - add support for lag and mst
v1: https://lore.kernel.org/r/20250808173808.273774-1-mmyangfl@gmail.com
  - fix coding style
  - add dt binding
  - add support for fdb, vlan and bridge

David Yang (3):
  dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
  net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
  net: dsa: yt921x: Add support for Motorcomm YT921x

 .../bindings/net/dsa/motorcomm,yt921x.yaml    |  162 +
 drivers/net/dsa/Kconfig                       |    7 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/yt921x.c                      | 3584 +++++++++++++++++
 include/net/dsa.h                             |    2 +
 net/dsa/Kconfig                               |    6 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_yt921x.c                          |  128 +
 8 files changed, 3891 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 net/dsa/tag_yt921x.c

-- 
2.50.1


