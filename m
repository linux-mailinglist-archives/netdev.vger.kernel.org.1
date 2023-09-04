Return-Path: <netdev+bounces-31918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838637916C1
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 14:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4A81C20823
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0867471;
	Mon,  4 Sep 2023 12:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFC442D
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 12:02:34 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8748E1B8;
	Mon,  4 Sep 2023 05:02:33 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 82CEA863A8;
	Mon,  4 Sep 2023 14:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693828952;
	bh=iKsz3lXVX1mLkg6/Pm1nXTQDpxA82A/MCK7KumwAcc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM3iLUvMB0LL+EzPaFrZsQocW7uhF5+V9DYP1giThZsaYQWLsQd9xHyoNEB4yJ4n+
	 TZg0LbNeoQqQ1gAxIn5QEDxSOsm/9uSEWxXyn/TiQGgENeX02D8VQXXYEemlrBxi4S
	 /G1l5yTTSvHv7im0h0tfwwjdSaZOcK1JOnCCjjlbxjVmecCqBwp8JR+oyU8If2i0Qo
	 GLSALHmYKlQDafe9WQIzmgf1d5JdKgfoPyMEYPfnC2CbljgNYzXCSceXSdrW7YYbrL
	 1z2EpGlo8Hq0cReY9zMJwggpx/yHY5QivZ8u90ruP7zTGRmc9eJvY84OT7lGW3yMy9
	 muF2geObJbzag==
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
Subject: [PATCH v3 RFC 1/4] net: dsa: Extend the ksz_device structure to hold info about HSR ports
Date: Mon,  4 Sep 2023 14:02:06 +0200
Message-Id: <20230904120209.741207-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904120209.741207-1-lukma@denx.de>
References: <20230904120209.741207-1-lukma@denx.de>
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

Information about HSR aware ports in a DSA switch can be helpful when
one needs tags to be adjusted before the HSR frame is sent.

For example - with ksz9477 switch - the TAG needs to be adjusted to have
both HSR ports marked in tag to allow execution of HW based frame
duplication.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Use struct ksz_device to store hsr_ports variable

Changes for v3:
- None
---
 drivers/net/dsa/microchip/ksz_common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a4de58847dea..9fcafff0c01d 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -158,6 +158,9 @@ struct ksz_device {
 	bool synclko_125;
 	bool synclko_disable;
 
+	/* Bitmask indicating ports supporting HSR */
+	u16 hsr_ports;
+
 	struct vlan_table *vlan_cache;
 
 	struct ksz_port *ports;
-- 
2.20.1


