Return-Path: <netdev+bounces-51576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E60D7FB384
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9A2B20B35
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00A154A0;
	Tue, 28 Nov 2023 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="U+csMIZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FB6C5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:04:43 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9b77be7ceso1589271fa.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701158682; x=1701763482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GaCi7MNIPGT9+tD1rM21toDEAvF+iDVLhsRo7ZOX2i4=;
        b=U+csMIZujBDPysW/zmszUJjRh4s0vrfg9Kx/9rW/o3+h46v4hR0riLxhqHDAOfn/5x
         z+5usbueUC0ZqL5CfKctquJoMOJaKzBjEJlaXEVxwJSQtWu7MQX87TMi9kz4e32Yshn1
         zBQnWxR98fPJsJ/omGh5cEcF7QeJJ+Si4YbQQM/ZA8CBc6NsWmY/mztGuo3LV6dkHgCL
         Gw3nTKzYiwaXEYxTIjm71J+ZW7nOHppzwQOjYCTDujOfyMG7lGEpBsJTSkn0ZtH6hBqp
         M5hKvljo9Xxh6e2pq75egmc8Z4RSLiJ7fF5tnux+doCNwcCZ0zPi1zKZT6RGmQ83ZBxm
         9OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158682; x=1701763482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaCi7MNIPGT9+tD1rM21toDEAvF+iDVLhsRo7ZOX2i4=;
        b=h9102wcThtTRSJnpJzWr5HYDgcP94Y3FgqJzTxcK+2lAnIq7lAvv9HUvlsvguqJisE
         nQwzo6kViww/jMTsLk7lTy9dtKNAdL6vhiTdq9MH+pD4OOy2pvgWfQqvE7HtXlGkxNHh
         AFk8v6aRQw6u8eMF/+lMJ0Tk6qY/PCW9eZ7/GSHk4NOZOBfeqVytZV15nwfhjnn9vHrb
         1a1zvLCtilFF1gFKZ42UgKWKnk/ZQB51yPfzznfDRnP7hP/f9VQdwa06tx/znG6ZVQVj
         568JGYYxX/pkK3/LgNvMAtRY0WjginqeI3dnH6rwWNZTZ42ITC4VVpwFh5Bq9gXNlETo
         KPTg==
X-Gm-Message-State: AOJu0YzLmgOQCuQbgYjPvXanVhTZyM7bIQOpEgGRIOl02fpqYLyyvRMf
	xDZ/038uR4xsWx9RLBJ7df6t8w==
X-Google-Smtp-Source: AGHT+IFupqCloqdm4FE8Tx5uAcS4dvEx98WbGIFZN7Av0v5UdK2HaqKN22m3rm9Y1YXwBSX0CyEHVw==
X-Received: by 2002:a2e:9c92:0:b0:2c0:21b6:e82e with SMTP id x18-20020a2e9c92000000b002c021b6e82emr9739886lji.4.1701158681562;
        Tue, 28 Nov 2023 00:04:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b0040b4ccdcffbsm1127534wmq.2.2023.11.28.00.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:04:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	renesas@sang-engineering.com,
	robh@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	mitsuhiro.kimura.kc@renesas.com,
	masaru.nagai.vx@renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] net: ravb: Fixes for the ravb driver
Date: Tue, 28 Nov 2023 10:04:33 +0200
Message-Id: <20231128080439.852467-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds some fixes for ravb driver. Patches in this series
were initilly part of series at [1].

Changes in v2:
- in description of patch 1/6 documented the addition of
  out_free_netdev goto label
- collected tags
- s/out_runtime_disable/out_rpm_disable in patch 2/6
- fixed typos in description of patch 6/6

Changes since [1]:
- addressed review comments
- added patch 6/6

[1] https://lore.kernel.org/all/20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (6):
  net: ravb: Check return value of reset_control_deassert()
  net: ravb: Use pm_runtime_resume_and_get()
  net: ravb: Make write access to CXR35 first before accessing other
    EMAC registers
  net: ravb: Start TX queues after HW initialization succeeded
  net: ravb: Stop DMA in case of failures on ravb_open()
  net: ravb: Keep reverse order of operations in ravb_remove()

 drivers/net/ethernet/renesas/ravb_main.c | 58 ++++++++++++++----------
 1 file changed, 35 insertions(+), 23 deletions(-)

-- 
2.39.2


