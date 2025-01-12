Return-Path: <netdev+bounces-157537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908EA0A990
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116221886E7B
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBE01B4F29;
	Sun, 12 Jan 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXUMYpU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F0199223
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688780; cv=none; b=H9p7+MVAM1OaRLbhZg8fWFnKetI6LZ3/kmnbxJXdkUQppOFjy3TYnfHYhoKeQnoooOWOaH1xvHg4s2PmafjvUlrCxAP4/aAZJ05T9z/d9m2tbcW2bvnDlJ81XZzyQZsG/yCzmiajZslfbPGwhmQk6dsH3REHMjd1Y+D3pLGKgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688780; c=relaxed/simple;
	bh=XKxgPXkqRoVDNfOxWtITwzSpA1j1CzTTW6TU8zpRG9Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V3Wn5lG1jp22rSMk2HtO08Y0EVa9YtVGFCiQKAo+G8IU5xraoghkBRWVk48xA6yi4MAG+cV9Nc5H+fYPuHbt8Wsk6c4yAZRF8EAda2/5aJzlzFYQjXcq6pn7KeYbYmHiJIwg4GYmyKasbYj2TYRICuMHy97007G6eykCkMNWy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wXUMYpU+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3be7f663cso642974a12.2
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736688778; x=1737293578; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qagkZ/LU4rtTQes27vALssH2ImJamgS/6MR4uWjQHuc=;
        b=wXUMYpU+iCR3dYD+Qdert08AnMf/LNarpbqtnMAgcV/h9UZfUNK+YVyJ3fTF5rHWRo
         321bNqyNLq8QF/ycDMJv8e3GX2gZVxTqJA/Wx5wJF2Lojh8bLQkthcN8RXfYW1MDHeJ1
         Y+JP72izfVU2F5VNOgmHAeHg0MK2GxjUUj4axO2pFPUjkr5JeUvlH9PgCn92DSiA6EvQ
         VfcCRzAV5IFTghjRCrBCdLdpdYcQ+SgOaI4e05fntXn3m/2JWfKjDX4GW05I9lCZZH91
         W7ImaPATKMvldNvYS2zRid2mPSyEqRj5Ql5nUme/iY2WU+2jrtKIeaDCXGrlsDQXqeQC
         imNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688778; x=1737293578;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qagkZ/LU4rtTQes27vALssH2ImJamgS/6MR4uWjQHuc=;
        b=uepMfH1qaruakdIUCXHqAw00J4XargjEx/TW5Fmza3ff/ZOueh6IxZ7KVO+Po0rQd1
         zjZm3PPcunrRDmlzKdaoJhRCDlflqJIpbNUblU3ud7sVgh+EPqvcsD/3kIq1q/0AcVvG
         5FzCCWw7JD43Fb7peuzDviaqERzXdF69RWF2TB4CmBj95imp5j8ShXaMV9DEqrQktUrM
         Zny1ujpVoyIfDZd4j4PhRfPXdpdn3TisSNz8yWTS2J9Y2wP+kMqXTNVz0NFAEUEMS9gm
         W2t6vOUwUeZ99ynCakuHG45bBBSN/3Zu6vN1F0+GxhYH+9s0qaUZFXog3QwaXoE1udMQ
         XO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtAheKp1QLTEjP20/0qBF5xHPpcxtxY31+LxKikctS6PXB17ZmOZLlfVqyiw00BpVJwZQFPDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JUjzxWQj5gvdj7/6NLTc1+Kv2EgW3HWhICNsDUxtPqam+BPO
	uhLVh0SIMzDXfWuSFRdx68mr2QEXrjXH0fqIDT5NXfRsZilDc3pcS+kBTdqH/x4=
X-Gm-Gg: ASbGncs8hIjdLuGlTcpEJ5zwrU1jeeMDPzYyzP2rgwl6EfLxNp58mvhLFbApjjamHJE
	LV4hZF0ZMyaaaNHAH5JPMCLCjCTcfLGKhfA9ocmthfByZcfS5JhDRHkU/gOzH0HtzPLMiHnC7jc
	UBTwe8+7I1Ca4vEfe6dsV5YbYxQsmwQ7ZKWy4Vr+RQMaPNEyaxFKKwUCb6yalrZ3I8pM2OE4Ajq
	mEg85BWZFvf7zYBamJLNXtsl1QNTSjyPWPSjYIKuuD438P073PEWwfTrjBijwgDSrphXoU/
X-Google-Smtp-Source: AGHT+IHGPI5G9xAGCnu9erfmrPb75d7mnwukM12RbyFiKbkogF5yX4joUi45dN7aTJobJQAhBKZ7tA==
X-Received: by 2002:a05:6402:1e8e:b0:5cf:f39f:3410 with SMTP id 4fb4d7f45d1cf-5d972dfaf04mr5579529a12.2.1736688777399;
        Sun, 12 Jan 2025 05:32:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c4477sm3584609a12.51.2025.01.12.05.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:32:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 0/5] net: ethernet: Simplify few things
Date: Sun, 12 Jan 2025 14:32:42 +0100
Message-Id: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHvEg2cC/x2M0QqDMBAEf0Xu2YMkoi39leKDJKselFNyUhTx3
 5v6OOzsnGTIAqNXdVLGV0wWLeDriuI86ASWVJiCC63zPrAdFhfltYzpAx7yZKzYuHl2ybUIMT1
 A5b1mjLLf5Tf9BcW+UX9dPyiJad9zAAAA
X-Change-ID: 20250112-syscon-phandle-args-net-386d05e2cd7e
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 imx@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=XKxgPXkqRoVDNfOxWtITwzSpA1j1CzTTW6TU8zpRG9Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng8SAA643Zo2cp/l+bcjvA4yh2jmRGdEETJsAm
 Enhfy8ebEeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4PEgAAKCRDBN2bmhouD
 16MrEACXZ72WUcShffV++I09qMxK0HXHtn8vUtnKitu0FCIocOPj/7yXCn5UNkwMiowlUD/SJU2
 eJcDaunCkjH8J0KQfk7GFxGX5vk93eYQxv0HlD+RMRxaKnL9IJJFTwy7UCU53xCeMtLDPVo/iO8
 GHcTw4W6rf9JhAdFzQAzZCXIyih19x9F+wejqS6Q1gbhTzpQdH0zpZ2eA5iOE9U/D1m5rfzBZDk
 B4CBqgq+Km8WkZvkDsFtGQLV8vHiL8OxkQa9UFtrUOzVTyLmgh4iuCLXVz4qgeO/AoojroJ6UD9
 UqyQTPPbEevML2onTmd6zO8u8P35sCy5mei8XuP6tTx/9xY4zj8vUBmIgNnDJTd1cdWIRpCaG2j
 ASmSe/phuj/0Yn7KYirpKOECOZkvSWcwS0ScdA4DTLxpnwGyacg3B+7MZc2TcaLQiNtfKO26d5j
 vaQiFJ75DmoCxwQabf+RYQ9umr+3c6yKY+pO7BC5z5DTLPv/NXBa8xTJNI03dK8YQMIC0dDCkpl
 qxGQp/Vb4x8lv1ftODbrjU03Z4MWTeI6ahuBLX5mJC+L20oY2fVmZ1vIL6n+9noDROXO/WrRhD0
 DlJiC2bxqKx7hcdSoCThDAzy30sDLBihn08oRSXZ0t9wxIhbCZYyeVSq539LUav3T/PLQgdIMwh
 6aN+wRTr39PFWGA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Few code simplifications without functional impact.  Not tested on
hardware.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      net: ti: icssg-prueth: Do not print physical memory addresses
      net: ti: icssg-prueth: Use syscon_regmap_lookup_by_phandle_args
      net: stmmac: imx: Use syscon_regmap_lookup_by_phandle_args
      net: stmmac: sti: Use syscon_regmap_lookup_by_phandle_args
      net: stmmac: stm32: Use syscon_regmap_lookup_by_phandle_args

 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c   | 10 +++-------
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c   |  9 ++-------
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c |  9 ++-------
 drivers/net/ethernet/ti/am65-cpsw-nuss.c          |  9 ++-------
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  2 --
 5 files changed, 9 insertions(+), 30 deletions(-)
---
base-commit: 8a7b73388d7ab9aed82d5b81f943cc512ee54e9e
change-id: 20250112-syscon-phandle-args-net-386d05e2cd7e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


