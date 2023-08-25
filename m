Return-Path: <netdev+bounces-30739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B7788C7C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E7228154F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5DE107A8;
	Fri, 25 Aug 2023 15:31:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE0101CA
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 15:31:40 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7355D2134;
	Fri, 25 Aug 2023 08:31:38 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1082786A2D;
	Fri, 25 Aug 2023 17:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692977496;
	bh=g/VNauoDXetVsPPtplesS+rVsh45l3BezBkVgWV4Yvw=;
	h=From:To:Cc:Subject:Date:From;
	b=IwNzAse4SKZrxJ8kqO3hN+dzy/KzrE+jGzg62/DD6PujT7pMldqU5xJJGqh/YpDAH
	 GQFaZpT7a2c/8ePMSWOgXwUnkd1gl5QKthYxTF4jG7FN9Wnrbn0r9oKGkjLFHgA+//
	 qfCiO7p0E1m4q6b1FWHJpi5cdhVrM/G6RIZ6XoMF1nY6QWYjLF3cTammu1H56+efl7
	 vBJfqZXVkPNGV1xiP0pzZ/yQYczTI9i4RKUKDbRZtnGOvilSHJSxeqbqV1cUHpd4eW
	 +JnMDn3zmSTlU93GT9KWhi0NUx4SIMsE27L5zETNGCQU8vfMrZlxCdDZPQdA/HHs7t
	 WNM7OCcKx16CA==
From: Lukasz Majewski <lukma@denx.de>
To: Tristram.Ha@microchip.com,
	Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames decoding
Date: Fri, 25 Aug 2023 17:31:11 +0200
Message-Id: <20230825153111.228768-1-lukma@denx.de>
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

Provide fix to decode correctly supervisory frames when HSRv1 version of
the HSR protocol is used.

Without this patch console is polluted with:
ksz-switch spi1.0 lan1: hsr_addr_subst_dest: Unknown node

as a result of destination node's A MAC address equals to:
00:00:00:00:00:00.

cat /sys/kernel/debug/hsr/hsr0/node_table
Node Table entries for (HSR) device
MAC-Address-A,    MAC-Address-B,    time_in[A], time_in[B], Address-B
00:00:00:00:00:00 00:10:a1:94:77:30      400bf,       399c,	        0

It was caused by wrong frames decoding in the hsr_handle_sup_frame().

As the supervisor frame is encapsulated in HSRv1 frame:

SKB_I100000000: 01 15 4e 00 01 2d 00 10 a1 94 77 30 89 2f 00 34
SKB_I100000010: 02 59 88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000040: 00 00

The code had to be adjusted accordingly and the MAC-Address-A now
has the proper address (the MAC-Address-B now has all 0's).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 net/hsr/hsr_framereg.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 80fc71daf7ca..85abe052e0a9 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -300,9 +300,24 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
-	/* And leave the HSR tag. */
+	 * And leave the HSR tag.
+	 *
+	 * The HSRv1 supervisory frame encapsulates the v0 frame
+	 * with EtherType of 0x88FB
+	 */
 	if (ethhdr->h_proto == htons(ETH_P_HSR)) {
-		pull_size = sizeof(struct ethhdr);
+		if (hsr->prot_version == HSR_V1)
+			/* In the above step the DA, SA and EtherType
+			 * (0x892F - HSRv1) bytes has been removed.
+			 *
+			 * As the HSRv1 has the HSR header added, one need
+			 * to remove path_and_LSDU_size and sequence_nr fields.
+			 *
+			 */
+			pull_size = 4;
+		else
+			pull_size = sizeof(struct hsr_tag);
+
 		skb_pull(skb, pull_size);
 		total_pull_size += pull_size;
 	}
@@ -313,6 +328,19 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 	total_pull_size += pull_size;
 
 	/* get HSR sup payload */
+	if (hsr->prot_version == HSR_V1) {
+		/* In the HSRv1 supervisor frame, when
+		 * one with EtherType = 0x88FB is extracted, the Node A
+		 * MAC address is preceded with type and length elements of TLV
+		 * data field.
+		 *
+		 * It needs to be removed to get the remote peer MAC address.
+		 */
+		pull_size = sizeof(struct hsr_sup_tlv);
+		skb_pull(skb, pull_size);
+		total_pull_size += pull_size;
+	}
+
 	hsr_sp = (struct hsr_sup_payload *)skb->data;
 
 	/* Merge node_curr (registered on macaddress_B) into node_real */
-- 
2.20.1


