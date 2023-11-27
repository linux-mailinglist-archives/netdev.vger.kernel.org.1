Return-Path: <netdev+bounces-51260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 664947F9DD4
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 11:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA068B20DA9
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 10:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C3101D8;
	Mon, 27 Nov 2023 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="w6tzQNXG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26D2EA
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 02:41:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507a98517f3so5452962e87.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 02:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701081693; x=1701686493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Bz7cy7fsWSGJfZCOmSedyPyZ8/Gr6/t5cUFclA14ic=;
        b=w6tzQNXGEWX1yM6BeqEBmxIiaVEvRagr6WV3WRBZE7t4raIyQCYbhZhsIXB1X034y7
         Z4PFL45Khlgw88jWMQgQE2AEgnGicjcTGmBpox14uxZMh8jCe08WADRYUVGYhUIahJ0N
         cNeuX316ewE/xRsywo51WR91TtpbIsHWig8uJOedIkTpBoTYP1w+G2for4q3osdXcn2I
         VHvK+KoyltiWSsKe8Svv+wII+pJsf94ZFoZk6RtWD/831ND2Ljkve7DZGUpJSBagSkoh
         VX34nPdxtwT9uLCkl5AmmPYLmZyot6MWBC2ArNy7pK68TZfDe/sCC6jMDEzyypMNvp5a
         7gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081693; x=1701686493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Bz7cy7fsWSGJfZCOmSedyPyZ8/Gr6/t5cUFclA14ic=;
        b=CDFT9KqF6qe1QjwHdeIgzc9WtWRKvoyYeIm0c2JfyFKRnI9WhHxmvN2wlQx/UYab58
         x3xbtxe9Bxu+SdKc2x083XPxzDmtqUSPoB/Afo04VHEkH6i6fFoL6UXYdr3IKM6wbrok
         d5oYkC8yjEQi6h5FoQtTuxm9ayAWt62uUrC6lYvl4UlHEwyHBcUZTmu4nsEHa0jMPIbx
         rKXLg3rWLC+dbDTIsJWCAcuvQkoDLUElcN4Cfkg/5TpDpFfpV3zvz49mX3BagEsv14Lt
         3QGpFMR2E1pBCdG1fSEKPTtK03rlGYv/4G2X5YgZQxjL4iO+HYoGMu7eE9lDJYjlxDzh
         oJbA==
X-Gm-Message-State: AOJu0Ywz++4QifdDjySisd4zSRIQuoIJaRAQT0A9TZColq/fLT7bwD5h
	pCMWILDGul4P0eCrKAWqvZ7zbg==
X-Google-Smtp-Source: AGHT+IHGEuvFLago8dQro1dPB7kAiAWUyo25/xL7wd8A+uZZcz1NJALUcf8xhoQvr7KTqzDtAoO4dA==
X-Received: by 2002:a05:6512:280e:b0:507:b17a:709e with SMTP id cf14-20020a056512280e00b00507b17a709emr9065716lfb.1.1701081693072;
        Mon, 27 Nov 2023 02:41:33 -0800 (PST)
Received: from localhost.localdomain ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id l6-20020a19c206000000b004fe1f1c0ee4sm1432070lfc.82.2023.11.27.02.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:41:32 -0800 (PST)
From: =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
Subject: [PATCH 0/3] net: microchip_t1s: additional phy support and collision detect handling
Date: Mon, 27 Nov 2023 11:40:42 +0100
Message-ID: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patch series adds support for LAN867x Rev.C and sets the collision
enable bit conditionally on plca enable for LAN865X and LAN867X phys.

The addition of Rev.C support is pretty straight forward (but weird), it 
follows the recommended magic and unexplained steps in Microchip
Application Note 1699.

The second change, conditionally setting collision detection has a
significant impact on link performance. Having both PLCA and collision
detection enabled led to a lot of dropped packets in the setup I've been
developing on.
The datasheets recommends disabling collision detect when PLCA is
enabled.
Took me a couple of weeks to find said footnote, hoping this series can
save the next dev some headache.

Following is a brief description of my test/eval setup:

LAN867x Rev.C
This was tested with Microchips usb eval board, the only testing I did
was that I got the driver attached and got a link.
No performance/stress testing has been performed.

Collision detection
This has been tested on a setup where one ARM system with a LAN8650
mac-phy is daisy-chained to 8 mcus using lan8670 phys. Without the patch we
were limited to really short cables, about 1m per node, but we were
still getting a lot of connection drops.
With the patch we could increase the total cable length to at least 40M.
Electrical properties play in here, both cable types and how the
termination is designed, so these results might not be reproducible in
another setup.
The only testing that has been performed has been a best effort of
estimating dropped packets on the linux node, with low frequency traffic.

Ramón Nordin Rodriguez (3):
  net: microchip_t1s: refactor reset functionality
  net: microchip_t1s: add support for LAN867x Rev.C1
  net: microchip_t1s: conditional collision detection

 drivers/net/phy/microchip_t1s.c | 135 +++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 3 deletions(-)

-- 
2.40.1


