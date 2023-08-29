Return-Path: <netdev+bounces-31229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D61278C3F1
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 14:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECC81C20A0B
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B317156F8;
	Tue, 29 Aug 2023 12:12:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF28156CE
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 12:12:18 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEE7CFE;
	Tue, 29 Aug 2023 05:12:07 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 741C8864EC;
	Tue, 29 Aug 2023 14:12:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693311120;
	bh=VAoeU7O8/fkULslv3ij+9rb59cf4x0cLF43dhevDXc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=as/LkYK0MZfyvH3067Who5fLB+0Id5KfdzruMjysc35CMI75oyAqKUBML/dgqWwNY
	 ys8CNsIh87QxZUnuR4GiDMCkLG9oEg5p1bhPKS8S0FXSAZLSeXrnvJLLwHEsg5HWrY
	 f69XbKDyjO3m0QrNYqkYOrlCJpKusmV7F21sjZ28ecy8nF7p36NmgNcvI9nyVLfU43
	 E0jso0Q1JOxkKgXp/0SXqd91R9RBt0rN7Xu06v6sXC6LLM/gr3ew759bPrypjODWDw
	 ZTy7w50wRFKxrZ/VGsZc+GAW3e+QyMrXmQ0g3QFq3P5Vr9DvUJ1ZZeKUrEvSyRTHgG
	 JFJzpdane8mmQ==
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
Subject: [PATCH 2/4] net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
Date: Tue, 29 Aug 2023 14:11:30 +0200
Message-Id: <20230829121132.414335-3-lukma@denx.de>
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

The KSZ9477 has support for HSR (High-Availability Seamless Redundancy).
One of its offloading (i.e. performed in the switch IC hardware) features
is to duplicate received frame to both HSR aware switch ports.

To achieve this goal - the tail TAG needs to be modified. To be more
specific, both ports must be marked as destination (egress) ones.

Moreover, according to AN3474 application note, the lookup bit (10)
should not be set in the tail tag.

Last but not least - the NETIF_F_HW_HSR_DUP flag indicates that the device
supports HSR and assures (in HSR core code) that frame is sent only once
from HOST to switch with tail tag indicating both ports.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 net/dsa/tag_ksz.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index ea100bd25939..1410e7ed0f9a 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -293,6 +293,11 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 	if (is_link_local_ether_addr(hdr->h_dest))
 		val |= KSZ9477_TAIL_TAG_OVERRIDE;
 
+	if (dev->features & NETIF_F_HW_HSR_DUP) {
+		val &= ~KSZ9477_TAIL_TAG_LOOKUP;
+		val |= dp->ds->hsr_ports;
+	}
+
 	*tag = cpu_to_be16(val);
 
 	return ksz_defer_xmit(dp, skb);
-- 
2.20.1


