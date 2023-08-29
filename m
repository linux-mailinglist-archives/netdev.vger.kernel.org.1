Return-Path: <netdev+bounces-31228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9707978C3EE
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 14:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF251C20A0B
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5632D156D3;
	Tue, 29 Aug 2023 12:12:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842D156D0
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 12:12:17 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72EFCF9;
	Tue, 29 Aug 2023 05:12:06 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0B53B864CB;
	Tue, 29 Aug 2023 14:12:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693311120;
	bh=ADYR/SvnENrM6v7m6lyKJdcVab4GVu+H0i7PWs7Pe58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qdw+JAK5FxLLQJGk3YiSotQuhnpVwZInqoi8yJq0s14JNcAdDVfeVDuZmy15kPoN/
	 5xBT1+AIsGBa0RP4o1fScYnhEwWRd+Ok5xMFIorX9hGSw+Ew2pvZmIosUsgJea/VlC
	 hSUrK4i2jBkje1fwZn1MbiP6EsjsOhpT8L07x4MPhpOniCmtAuRHm15ZXl/drVs7DS
	 NYPba8rS/1gosuKftiKQ22y5XG7rDolavJayOJIIPLA0u05rPcAUZEWuTN8eNCNyav
	 LbCKcpuXmIo5BdG2ratBdkNYIFCFsjUVk8JxhhLaFcubJ5+WueAfD6QkXkgoJPEfD8
	 mMXMDCmXr+bcg==
From: Lukasz Majewski <lukma@denx.de>
To: Tristram.Ha@microchip.com,
	Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/4] net: dsa: Extend the dsa_switch structure to hold info about HSR ports
Date: Tue, 29 Aug 2023 14:11:29 +0200
Message-Id: <20230829121132.414335-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829121132.414335-1-lukma@denx.de>
References: <20230829121132.414335-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Information about HSR aware ports in a DSA switch can be helpful when
one needs tags to be adjusted before the HSR frame is sent.

For example - with ksz9477 switch - the TAG needs to be adjusted to have
both HSR ports marked in tag to allow execution of HW based frame
duplication.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 include/net/dsa.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index d309ee7ed04b..15274afc42bb 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -470,6 +470,9 @@ struct dsa_switch {
 	/* Number of switch port queues */
 	unsigned int		num_tx_queues;
 
+	/* Bitmask indicating ports supporting HSR */
+	u16                     hsr_ports;
+
 	/* Drivers that benefit from having an ID associated with each
 	 * offloaded LAG should set this to the maximum number of
 	 * supported IDs. DSA will then maintain a mapping of _at
-- 
2.20.1


