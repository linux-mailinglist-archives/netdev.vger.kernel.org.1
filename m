Return-Path: <netdev+bounces-35219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FE97A7AAE
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB621C20994
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F37728E00;
	Wed, 20 Sep 2023 11:44:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C718654
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 11:44:06 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAA7C2;
	Wed, 20 Sep 2023 04:44:02 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 707C6868D1;
	Wed, 20 Sep 2023 13:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695210239;
	bh=wF48erZR6turOA3H1N7RgF/MSbbCoV3fPvoqpc+H5xI=;
	h=From:To:Cc:Subject:Date:From;
	b=axHObFBPvaEc0AggMBm0AhfpWgIJYOP92YPWpkSyIHUdBFcMG2PLWJxpcPXj67F+Y
	 hvUBa3RIOmpL4JeOY+E1huato09UzTIBPrhgEKpe5UPXgGU9UsJbs7ocYDUHpht4sg
	 mv1VuvKHZVkkDAEOz26HPNFIhHoRHKr9J+F+RD+UDjiCFqMq78kjvGLO98JmfCVevy
	 sEjEc776lZHEGfABbGLQPARtu07ujCSoRi8bczLJP1R+Us8j0ePcZK1Ho4TLzd9t4b
	 9LwcdNGy9MqcYkI5eQsiJ4cz8UcbjOzqZx5uwz8N6l5k7MAhv+RV/bW9uvmUqx1c40
	 mCmvwUjGUW7FA==
From: Lukasz Majewski <lukma@denx.de>
To: Tristram.Ha@microchip.com,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	davem@davemloft.net,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading for KSZ9477
Date: Wed, 20 Sep 2023 13:43:38 +0200
Message-Id: <20230920114343.1979843-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series provides support for HSR HW offloading in KSZ9477
switch IC.

To test this feature:
ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
ip link set dev lan1 up
ip link set dev lan2 up
ip a add 192.168.0.1/24 dev hsr0
ip link set dev hsr0 up

To remove HSR network device:
ip link del hsr0

To test if one can adjust MAC address:
ip link set lan2 address 00:01:02:AA:BB:CC

It is also possible to create another HSR interface, but it will
only support HSR is software - e.g.
ip link add name hsr1 type hsr slave1 lan3 slave2 lan4 supervision 45 version 1

Test HW:
Two KSZ9477-EVB boards with HSR ports set to "Port1" and "Port2".

Performance SW used:
nuttcp -S --nofork
nuttcp -vv -T 60 -r 192.168.0.2
nuttcp -vv -T 60 -t 192.168.0.2

Code: v6.6.0-rc1+ Linux repository
Tested HSR v0 and v1
Results:
With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
With no offloading 		       RX: 63 Mbps  TX: 63 Mbps

Lukasz Majewski (2):
  net: dsa: tag_ksz: Extend ksz9477_xmit() for HSR frame duplication
  net: dsa: microchip: Enable HSR offloading for KSZ9477

Vladimir Oltean (3):
  net: dsa: propagate extack to ds->ops->port_hsr_join()
  net: dsa: notify drivers of MAC address changes on user ports
  net: dsa: microchip: move REG_SW_MAC_ADDR to dev->info->regs[]

 drivers/net/dsa/microchip/ksz8795_reg.h |   7 --
 drivers/net/dsa/microchip/ksz9477.c     |  70 +++++++++++
 drivers/net/dsa/microchip/ksz9477.h     |   2 +
 drivers/net/dsa/microchip/ksz9477_reg.h |   7 --
 drivers/net/dsa/microchip/ksz_common.c  | 149 ++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h  |  10 ++
 drivers/net/dsa/xrs700x/xrs700x.c       |  18 ++-
 include/net/dsa.h                       |  13 ++-
 net/dsa/port.c                          |   5 +-
 net/dsa/port.h                          |   3 +-
 net/dsa/slave.c                         |   9 +-
 net/dsa/tag_ksz.c                       |   8 ++
 12 files changed, 276 insertions(+), 25 deletions(-)

-- 
2.20.1


