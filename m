Return-Path: <netdev+bounces-54300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B32806818
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 08:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F831C20A91
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5CB15487;
	Wed,  6 Dec 2023 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="orh0/fxn"
X-Original-To: netdev@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC65F135;
	Tue,  5 Dec 2023 23:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=+H62xYUVYv9m4br7cg0DgyNn6m4JbUs5+N/PVPX56JM=; b=orh0/fxnE4NeMLDDyd/Te3IbWW
	3OIDv19m9XNBLLmL0BneUzz1K1wcODjswD+O8g1TI5nfiL8G74Ecn0qqfJ1aAlb6CA9YsmdrocFF0
	SV2GiVg/oC5O5vpiNs2ySi8VsBrEcyCPbQ3OO75FMiCtek4cCNvPyyg5wo0uGtER7HKLoH1BjRL/H
	v5zul/3wD5U4Umggmj+8L7EugVxamtCHJyUdpKWu+SVBzEZieqhRr24jcB0eVq/6rfmjvn/bWWgbN
	IOYobp8jH3LXpOmqZJaAisFBLHExOV8LLv8Vf7lWKW3nX0rYk1P14FuoiQWbCOLxMtNc6CjuIpXw6
	LXdH5vGw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1rAmA7-0009kh-21; Wed, 06 Dec 2023 08:17:39 +0100
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sean@geanix.com>)
	id 1rAmA6-000Kzf-CG; Wed, 06 Dec 2023 08:17:38 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Christian Eggers <ceggers@arri.de>
Cc: Sean Nyekjaer <sean@geanix.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] net: dsa: microchip: provide a list of valid protocols for xmit handler
Date: Wed,  6 Dec 2023 08:16:54 +0100
Message-ID: <20231206071655.1626479-1-sean@geanix.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27114/Tue Dec  5 09:39:00 2023)

Provide a list of valid protocols for which the driver will provide
it's deferred xmit handler.

When using DSA_TAG_PROTO_KSZ8795 protocol, it does not provide a
"connect" method, therefor ksz_connect() is not allocating ksz_tagger_data.

This avoids the following null pointer dereference:
 ksz_connect_tag_protocol from dsa_register_switch+0x9ac/0xee0
 dsa_register_switch from ksz_switch_register+0x65c/0x828
 ksz_switch_register from ksz_spi_probe+0x11c/0x168
 ksz_spi_probe from spi_probe+0x84/0xa8
 spi_probe from really_probe+0xc8/0x2d8

Fixes: ab32f56a4100 ("net: dsa: microchip: ptp: add packet transmission timestamping")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
https://lore.kernel.org/netdev/20231205124636.1345761-1-sean@geanix.com/#R
Changes since v1:
 - Provided a list of valid protocols

 drivers/net/dsa/microchip/ksz_common.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 42db7679c360..286e20f340e5 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2624,10 +2624,18 @@ static int ksz_connect_tag_protocol(struct dsa_switch *ds,
 {
 	struct ksz_tagger_data *tagger_data;
 
-	tagger_data = ksz_tagger_data(ds);
-	tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
-
-	return 0;
+	switch (proto) {
+	case DSA_TAG_PROTO_KSZ8795:
+		return 0;
+	case DSA_TAG_PROTO_KSZ9893:
+	case DSA_TAG_PROTO_KSZ9477:
+	case DSA_TAG_PROTO_LAN937X:
+		tagger_data = ksz_tagger_data(ds);
+		tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
+		return 0;
+	default:
+		return -EPROTONOSUPPORT;
+	}
 }
 
 static int ksz_port_vlan_filtering(struct dsa_switch *ds, int port,
-- 
2.42.0


