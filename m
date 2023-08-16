Return-Path: <netdev+bounces-28156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739A777E69B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527E81C21183
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066C116425;
	Wed, 16 Aug 2023 16:40:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71A16413
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:40:08 +0000 (UTC)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3C1199B
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:40:04 -0700 (PDT)
Received: from kero.packetmixer.de (p200300fa272a67000Bb2D6Dcaf57D46e.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id E596FFB5C7;
	Wed, 16 Aug 2023 18:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204003; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UT5bWjQUXdZ8j9sjM7T/pgcycgN7Pea95gbAyeXlz18=;
	b=jPijjvC2lINWEf8VJ2UH43qa9m2yI32Mo8yEWbouwA+ycZYGXWlaylS/M67RdSg7QT/PkB
	e9IoceNZHto/2KRfdHJmc+HxMYeCKrhQ0Nw4Dw/7kwcF+vIW+1QnyITiIK0SsiNw68IF0J
	dAOFmSA6Rh/CJSEP/Ya4D+JqlOo1zW9mjUqsS7HI4jPF1PU2M62L4iw31Q+lP+h1SF8l4W
	DaFnm+I2b0z6PoCRy4LkYV3Ka3yYtv8b5BQptfc/Oll9QRr50TOy6CfCoPDcRsW0RHqpUB
	v+mnTQne3E8kzQmpOsQ81NSLyiCm1cZ6lkQRywNclsxSfvHVVri223Q+WJ2rYA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/7] batman-adv: Check hardif MTU against runtime MTU
Date: Wed, 16 Aug 2023 18:39:57 +0200
Message-Id: <20230816164000.190884-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816164000.190884-1-sw@simonwunderlich.de>
References: <20230816164000.190884-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692204003;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UT5bWjQUXdZ8j9sjM7T/pgcycgN7Pea95gbAyeXlz18=;
	b=pdII1L7HnGeer3jsLVCRxGz6O3JBiUaa2tm2Sv725tW7lEt95mKUXambiYyq6YStR36c0N
	sQYqFDdPN28+SwONWlFZi4zEI0oVk5Kz9a1FRWbB1l6k013Tv2WtAq05/aF2jrdhmfIgtP
	X5Ln2qF+P2Qd9R8TKxBayLoC0VgZ2EF6NDI3yFJpjpJPoeeOikNqIgJVH+MAKLwmBngGVi
	7Lw3oLOVRE7bEhw+PT3DGY2f+0iYxWvhrdQJc5GR/9HRuMXxFnS8yVHG+PObStcRBddyhU
	O9d/LEQWerDTXWH79cfztVZV2B+eP3t1krpj5f5vkrSwtRflZxc93HOoBOJvLA==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204003; a=rsa-sha256;
	cv=none;
	b=QmDh7NbewUDhQFdQwRC2neGjevGDJcSpO9TcUG0Ebi0w2Iarc+ncXk9SRkTTrMZpOEeq9cusoonxe3TI3QgH/KnC9aKiJbVtBsC4TMnYapzvAL1U6U0D4x1nBNYOTjTNIPHPGIreUzf4RItJbiYY21NK8yUPf48FA2bHKIMOO8eMBBdgJsv0qSFRyksDBpttOt0otcTvhf3kWQWpFEvi6P+mf9XEzj1cQ11qUrhHn+xa2jttyXpWn4JfWEKzene4Fg89oG6p3/E4PHY+zgiWXSZm2su9Gx1Xu1mf+1BRlmc5r04D4kFGrW/3pCGH/++2AQJNYulX8QSX90JjE9s2dQ==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sven Eckelmann <sven@narfation.org>

If the MTU of the soft/mesh interface was already reduced (enough), it is
not necessary to print a warning about a hard interface not having a MTU to
transport ethernet payloads of 1500 bytes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 41c1ad33d009..5a4ff9a81e74 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
@@ -699,9 +700,14 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	struct batadv_priv *bat_priv;
 	__be16 ethertype = htons(ETH_P_BATMAN);
 	int max_header_len = batadv_max_header_len();
+	unsigned int required_mtu;
+	unsigned int hardif_mtu;
 	int ret;
 
-	if (hard_iface->net_dev->mtu < ETH_MIN_MTU + max_header_len)
+	hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
+	required_mtu = READ_ONCE(soft_iface->mtu) + max_header_len;
+
+	if (hardif_mtu < ETH_MIN_MTU + max_header_len)
 		return -EINVAL;
 
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
@@ -734,18 +740,18 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 		    hard_iface->net_dev->name);
 
 	if (atomic_read(&bat_priv->fragmentation) &&
-	    hard_iface->net_dev->mtu < ETH_DATA_LEN + max_header_len)
+	    hardif_mtu < required_mtu)
 		batadv_info(hard_iface->soft_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to %i would solve the problem.\n",
-			    hard_iface->net_dev->name, hard_iface->net_dev->mtu,
-			    ETH_DATA_LEN + max_header_len);
+			    hard_iface->net_dev->name, hardif_mtu,
+			    required_mtu);
 
 	if (!atomic_read(&bat_priv->fragmentation) &&
-	    hard_iface->net_dev->mtu < ETH_DATA_LEN + max_header_len)
+	    hardif_mtu < required_mtu)
 		batadv_info(hard_iface->soft_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. If you experience problems getting traffic through try increasing the MTU to %i.\n",
-			    hard_iface->net_dev->name, hard_iface->net_dev->mtu,
-			    ETH_DATA_LEN + max_header_len);
+			    hard_iface->net_dev->name, hardif_mtu,
+			    required_mtu);
 
 	if (batadv_hardif_is_iface_up(hard_iface))
 		batadv_hardif_activate_interface(hard_iface);
-- 
2.39.2


