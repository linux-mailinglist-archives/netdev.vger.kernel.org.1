Return-Path: <netdev+bounces-145591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 008BB9D0048
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA3DB21311
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6886D1917D0;
	Sat, 16 Nov 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oC/LTyTj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF1A47
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780191; cv=none; b=GCWBwi6DG4wZR4+gS9ycgI9CqDodikYnFrNhsDD1sjblSB+RCqHqsPf+BgUSvEIxZwytwkO2ghEFOgY8E5+cOvlCallBewu6FPBZqLiLg/Fgw9ofJsmVj3hFm6Xj9Q4kAlSm1oZZi2W26dUHIC1UHgTH2mBKyyY4POOZSGID3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780191; c=relaxed/simple;
	bh=3fmsZVtcET08j6sLy4Df00S5MnbnA34nvqPE7UPj5hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZdTFC6eDQpiTW53/0akzHtNBMqZoDiqH3ghh08z6Q6I7iMh4aUIQpertQZvqFJWW97zJTk8lPJsZ5cXqPUKu2GyEl0gzZMyk0fEcwcN6D5Fe3Zc8V2V6+GnafkA8HF6Rtrnrhrh47WBnLBwBSG76c2gIcRoOyIV+kUrPULfaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=oC/LTyTj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so101688666b.1
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 10:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1731780188; x=1732384988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aGohF+muowKkt4fdau+AubKELBZgZqyCJ8OaVgT7H9o=;
        b=oC/LTyTj/72ySlTJfLnuFL5lK1WaRqdZ9aYrdNW1KNbYDIm/KPdg6SwzY3yQ7Yh3zs
         7oetmFgbetS04KmrljW3+mmv3jrEfbrcrfpuZi2wz5/NcZs2FfaFaWv9/pqoO2lLDC64
         NsNWBnylr+tyrZwGZreC8THfj+Rj+X4NW4Zow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780188; x=1732384988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGohF+muowKkt4fdau+AubKELBZgZqyCJ8OaVgT7H9o=;
        b=Zmf8IkpiJ9QzMlrLkxb8800EESSG9sJCTXvV3jS7NXXFZJ/4Y2onXND+fAQcPlZct4
         wu03QHxyU4HNzo5AUspK1qW2LFVjZ0860DFae86wU5XQxalhmSjVDw6doK+hWhAqovIu
         U3irdyDJa4v3opjOZRz5NAgVJZLFR+0iCMieq+iqqzFCbm3Hbo3ZLRknPTAm4YZg0khx
         secXv8sOArBrkA1Y2TqqDoNatytTZ2eIl9YTUc/vPPCCS6+XlvCSxF65YzRzJoR4LkL9
         79RPkkqtvSbsteqjfBjh1cuh+Ajf1S+nGhQiZn7x17RlFCD7lQP/g4Y/8UNIpSxB7rOZ
         L9tA==
X-Forwarded-Encrypted: i=1; AJvYcCUVE157YPmqEOkCWHV4nONTCS5BNlAD7ZP5sBz0Uxvc5kDHi6FjiNST5DCCLjgjSXISWBY6Vjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyai0vO3e/UC6coeGb5rpuidYoxT26ZzZBVcUaihYrkq1+23hO0
	vIcYJShtfq0zDS2uAnAVdH7nHeIYb+P1APKhWqEZF/bB2tmwgGesVILGSSpFwcc=
X-Google-Smtp-Source: AGHT+IG2ObGwiCvfIl++zWd9qF2zaGLlhIycmyruL6/OHxRiEVmPAs5MlD90c/NhVLeiofEJ0atIOw==
X-Received: by 2002:a17:907:9413:b0:aa3:722c:cc8a with SMTP id a640c23a62f3a-aa483525d25mr654985366b.40.1731780186523;
        Sat, 16 Nov 2024 10:03:06 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dc6d364sm329549066b.0.2024.11.16.10.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:03:06 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dong Aisheng <b29396@freescale.com>,
	Eric Dumazet <edumazet@google.com>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Maxime Ripard <mripard@kernel.org>,
	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>,
	Sebastian Haas <haas@ems-wuensche.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Varka Bhadram <varkabhadram@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-can@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH 0/7] Fix {rx,tx}_errors CAN statistics
Date: Sat, 16 Nov 2024 19:02:29 +0100
Message-ID: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the patch 4d6d26537940 ("can: c_can: fix {rx,tx}_errors statistics"),
already merged into the mainline, to other CAN devices that similarly do
not correctly increment the error counters for reception/transmission.


Dario Binacchi (7):
  can: m_can: fix {rx,tx}_errors statistics
  can: ifi_canfd: fix {rx,tx}_errors statistics
  can: hi311x: fix {rx,tx}_errors statistics
  can: sja1000: fix {rx,tx}_errors statistics
  can: sun4i_can: fix {rx,tx}_errors statistics
  can: ems_usb: fix {rx,tx}_errors statistics
  can: f81604: fix {rx,tx}_errors statistics

 drivers/net/can/ifi_canfd/ifi_canfd.c | 29 +++++++++++++++++++--------
 drivers/net/can/m_can/m_can.c         |  7 ++++++-
 drivers/net/can/sja1000/sja1000.c     |  7 +++++--
 drivers/net/can/spi/hi311x.c          | 17 ++++++++++------
 drivers/net/can/sun4i_can.c           |  7 +++++--
 drivers/net/can/usb/ems_usb.c         |  7 +++++--
 drivers/net/can/usb/f81604.c          |  7 +++++--
 7 files changed, 58 insertions(+), 23 deletions(-)

-- 
2.43.0


