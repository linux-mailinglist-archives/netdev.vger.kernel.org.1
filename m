Return-Path: <netdev+bounces-32298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D15C79405D
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 17:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95701C20985
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73E4107B4;
	Wed,  6 Sep 2023 15:28:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA103101E1
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 15:28:22 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626DE1717;
	Wed,  6 Sep 2023 08:28:21 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C94C6866A0;
	Wed,  6 Sep 2023 17:28:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1694014099;
	bh=juvUfxNm6RLKydd0BNfwpDvpkl5RSgEH+Mo6sHbohMY=;
	h=From:To:Cc:Subject:Date:From;
	b=Gk71eKVTgnNTXmwch5G7r67L1fo3ra2Xw7nbPZOGOlOQl4RXAva9eIKBPSeshkaPR
	 LATyWw254O7Y6pk7RhjVU+3bC++gqO29NFKcv/0uSGD2qBlxZGkGEoT4OeIHplLUvL
	 DbMwhVoS5Iu9nq1Q/26aRM5MtOsh7A65bN2J+sZEvFer6X04FogRqC29Bu5QQ+2xi2
	 V0OUoNLp1IIjQR+kPYV96zFowGnTGjQxHvpwnJnVXdo6ImmQRiSD0EgyJtjC8T3JrM
	 BVFp8f76L7F1MTMJdcqjZoGXrwKS1FlUGhFMscwNSctZWAYdxbhiQldcj/Kwkmuojn
	 mpbCt1MuOlfkQ==
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
	Oleksij Rempel <linux@rempel-privat.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW offloading for KSZ9477
Date: Wed,  6 Sep 2023 17:27:59 +0200
Message-Id: <20230906152801.921664-1-lukma@denx.de>
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

It is also possible to create another HSR interface, but it will
only support HSR is software - e.g.
ip link add name hsr1 type hsr slave1 lan3 slave2 lan4 supervision 45 version 1

Test HW:
Two KSZ9477-EVB boards with HSR ports set to "Port1" and "Port2".

Performance SW used:
nuttcp -S --nofork
nuttcp -vv -T 60 -r 192.168.0.2
nuttcp -vv -T 60 -t 192.168.0.2

Code: v6.5-rc7 Linux repository
Tested HSR v0 and v1
Results:
With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
With no offloading 		       RX: 63 Mbps  TX: 63 Mbps


Lukasz Majewski (2):
  net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
  net: dsa: hsr: Enable in KSZ9477 switch HW HSR offloading

 drivers/net/dsa/microchip/ksz9477.c    | 81 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h    |  2 +
 drivers/net/dsa/microchip/ksz_common.c | 76 ++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h |  3 +
 net/dsa/tag_ksz.c                      |  8 +++
 5 files changed, 170 insertions(+)

-- 
2.20.1


