Return-Path: <netdev+bounces-28158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5341177E69D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEFD281834
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA3168AC;
	Wed, 16 Aug 2023 16:40:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30E16439
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:40:08 +0000 (UTC)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAA71BE6
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:40:04 -0700 (PDT)
Received: from kero.packetmixer.de (p200300fA272a67000bB2d6DCAf57d46e.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 97F40FB5C6;
	Wed, 16 Aug 2023 18:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204002; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aowMFLZM7X2HepHolPQIe7EpcGzJaDXnHi+P/sor0M=;
	b=lV5p9bQiZs5uw9YhXxAdIBYSQRi9TQNzfgmvcXkc8vfyCVqRIcJFPOlwrtGYcioQf2XPqr
	iyA4FyKm551rS3fH9PBoC9iyzJB149Pyhz3gHRay8LXROX6uBLJMXhymGJUr/ijr2H/LcD
	fJFXOJTzcaqZErKtd7G0PgGcIjnqdfgZcrE/xjkWcmL8j/q8mQYZ1kFqJRDq2znldRC9Fz
	lvXgV1Ptikdv+hzHlP6ePhjUwzY2lR7TqpySmXmMq1uvqF8S1lEzMugxVizWZcLl0jOsZd
	Y/HiGFRPgotuDZqKH78ZmhXKyLVfRo980b2lsUiOTVXOKoKixVyWgozR8+7TfQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 3/7] batman-adv: Avoid magic value for minimum MTU
Date: Wed, 16 Aug 2023 18:39:56 +0200
Message-Id: <20230816164000.190884-4-sw@simonwunderlich.de>
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
	d=simonwunderlich.de; s=09092022; t=1692204002;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aowMFLZM7X2HepHolPQIe7EpcGzJaDXnHi+P/sor0M=;
	b=D3jg9HpRScAbHmU4fzYNsyqDBrLhJkWu2jp/8I6VZv8vKolum0b1g7okYPvoLR7qr6MxAv
	X7PQ5K5743sI5+Y6D3NNmEuaNZrNteQhCJGxk81/EBpnGPJo5uDJRBXqgXA26ud3omSqx9
	0GzMtfpcQCUyJ2bxjUiiwtbxdABnVtgNmzc6rWd6iT3I4gT8Iue7b4Bwj1aPpoitLnwEcW
	02juqOWlHXj1DfUjveaoIlbPomJLsyxuY7gQZTTyuXEBIXwDu7tip8aufzeuAhGmeSYzVI
	vwQ/8RmOhDSbCVzGPw/dCBdt+7tGFgRzOVHaET05G+ShT1egCQANKYNg6Gi1rA==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204002; a=rsa-sha256;
	cv=none;
	b=0bv9CU+vS79LbFiWF/Hp+8NyIdw1kx//W84joQFfSPCYewUimo3wPPW0mThM+qhVCHf7j/lOvHgrcxQbKaws9dN/dkjROLDyTdVVqxvTpNF8NHNqKzEFAsR9qt9ddEefKXZlhatEeF14mOrhPPrUSR/8k+WhsmMRR24LOdt4TmivYj1Xjt/NSe/Lt4oMpzsbXx81QYhNQFnS1kJMk4UB1ytCVRViHrmjLLtNGg958i6Vf8wywvgMwfP0/w2SVmOZWMjbOwJeBJ0NremwtkApuFRCLOHVHd8XHQerMj+nvEU0FWv+HPLVksG5seZ+fzid3FxEjvxQLo9EPumVLolGJA==
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

The header linux/if_ether.h already defines a constant for the minimum MTU.
So simply use it instead of having a magic constant in the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d3fdf82282af..f7947fad06f2 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -154,7 +154,7 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* check ranges */
-	if (new_mtu < 68 || new_mtu > batadv_hardif_min_mtu(dev))
+	if (new_mtu < ETH_MIN_MTU || new_mtu > batadv_hardif_min_mtu(dev))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
-- 
2.39.2


