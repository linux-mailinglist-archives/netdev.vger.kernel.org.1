Return-Path: <netdev+bounces-31550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBADB78EBD0
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3253D28149C
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146968F70;
	Thu, 31 Aug 2023 11:18:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069958498
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:18:53 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE4CCE4;
	Thu, 31 Aug 2023 04:18:52 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AC3AA86543;
	Thu, 31 Aug 2023 13:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693480730;
	bh=/BhRQsoKKcsBxIN891WmVmYVvmccoziVwKlYtaPCEsg=;
	h=From:To:Cc:Subject:Date:From;
	b=j38EttfrKVCwkrFm6s1KejyGiOuvodXcE1Az31JiC61FEGJxqOTLEPOp2ntcnV2YR
	 lRcJTRVDJBumhxzTgPcyDodWr+pEyxFS2KDZDm5m/D1P81YXL3yiMjf5eTjeUGcHhK
	 plNOktGjI/HJd+7JJgrhmvhNMoQvDxZQ/I7t74X6PiTrbzMPQDcwacT13LfOuDpW8l
	 NW0PFSgAOANmdSLjNQYcdfVAwzopmE+KwuEKcHu+GYAxj2MnhpLEUyi4GqVLYz0yCC
	 spq4GSBDt5+QfntdeD8koktXRWSF6AE2M4EmF8DLbPnMj7029lDRlND61rRMawKHR2
	 UkxiIAfssLh6g==
From: Lukasz Majewski <lukma@denx.de>
To: Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	davem@davemloft.net,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	UNGLinuxDriver@microchip.com,
	George McCollister <george.mccollister@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 0/4] net: dsa: hsr: Enable HSR HW offloading for KSZ9477
Date: Thu, 31 Aug 2023 13:18:23 +0200
Message-Id: <20230831111827.548118-1-lukma@denx.de>
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
ifconfig lan1 up;ifconfig lan2 up
ifconfig hsr0 192.168.0.1 up

To remove HSR network device:
ip link del hsr0

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


Lukasz Majewski (4):
  net: dsa: Extend the ksz_device structure to hold info about HSR ports
  net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
  net: dsa: hsr: Enable in KSZ9477 switch HW HSR offloading
  net: dsa: hsr: Provide generic HSR ksz_hsr_{join|leave} functions

 drivers/net/dsa/microchip/ksz9477.c    | 96 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h    |  4 ++
 drivers/net/dsa/microchip/ksz_common.c | 81 ++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h |  3 +
 include/linux/dsa/ksz_common.h         |  1 +
 net/dsa/tag_ksz.c                      |  5 ++
 6 files changed, 190 insertions(+)

-- 
2.20.1


