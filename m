Return-Path: <netdev+bounces-31551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7187F78EBD4
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A4B1C20A2D
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3A8F79;
	Thu, 31 Aug 2023 11:18:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C468F74
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:18:53 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1BACF3;
	Thu, 31 Aug 2023 04:18:52 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6BB688656A;
	Thu, 31 Aug 2023 13:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693480730;
	bh=A2k/yH77baFCxR56gOAv9ffVsTNiKhB2LNrgnC9TyvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xteUFZdD8ny2InDi7NrVUCgTtvr9EFCaiIAeLB+Wj229gIkU8dAYsng/o+6aveg+o
	 w11jaKydJkUu+MqFFROSwCgk+3ADQrZHqHEe2vq17RYqDKcJTGPr4tGM4KIFvGpvo/
	 XIINzkXNuY4lClnrekDwcYqNR5CdgB5dxcwHIt4Pt1W8hTvJrnsUcPefP2a2+ys2hA
	 gaXTREZcqgJvsmfCIzOP4p5WKqUZX8DuwrbwhXvtITX+RF3dBXUmNGvj1zYgZtE+10
	 +8hpGIl3GuY7q9sYCPJeqVISLZ37Hp0WRlKRbYpUCDBkIXjP52zvHbBpZT5L4Kr/fQ
	 VQC19uM7mxGNw==
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
Subject: [PATCH v2 1/4] net: dsa: Extend the ksz_device structure to hold info about HSR ports
Date: Thu, 31 Aug 2023 13:18:24 +0200
Message-Id: <20230831111827.548118-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230831111827.548118-1-lukma@denx.de>
References: <20230831111827.548118-1-lukma@denx.de>
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


