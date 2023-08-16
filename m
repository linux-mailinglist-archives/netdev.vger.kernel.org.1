Return-Path: <netdev+bounces-28162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF36777E6BD
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89301C211A9
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C45171DE;
	Wed, 16 Aug 2023 16:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCB1118C
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:40:23 +0000 (UTC)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [IPv6:2a01:4f8:c17:e8c0::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4724C2724;
	Wed, 16 Aug 2023 09:40:21 -0700 (PDT)
Received: from kero.packetmixer.de (p200300FA272a67000Bb2D6DcAf57d46E.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C0A49FB5B1;
	Wed, 16 Aug 2023 18:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692203600; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDr4ApcYiSq7b1LH4pTlLUo+yJYCl799b+ZbteyLDqg=;
	b=RNif1ElgLtX1XNgo34EMgkPcO5bvSJuM3smEAG7H32FxEb7chYcIVrae2OLivrI+qGX9K+
	qhSu5jlg0SDB3jzGGv9zQVtIF6d9PZn2Mb4pumvvyy32Q0GeE8z1pnHZD7z0fVSRRD2NuX
	boI/Cw6s1v3WsJgag07VuUl8bem2UYV1m9BbNEbtmiXHyHeyeSCvmmEtl53aYo6wE5JSnv
	HxyAsX+rYBmHMmDPMhUyxSRJxDUQGZFLh2ZZEljSTNna3a0TsSZRWKzWotkPSxe7t3zjhO
	1vheyMFebETNMepkbK1hCgtPedUky5vA0eR/oAcMXHRPYuimJs4LCRaV2iG62w==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/5] batman-adv: Trigger events for auto adjusted MTU
Date: Wed, 16 Aug 2023 18:33:14 +0200
Message-Id: <20230816163318.189996-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816163318.189996-1-sw@simonwunderlich.de>
References: <20230816163318.189996-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692203600;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDr4ApcYiSq7b1LH4pTlLUo+yJYCl799b+ZbteyLDqg=;
	b=lY2tZcU3Oc7gr3m4vR+VbFmStW3bKrvzjD0zoTvWkAJrLM9sXyA9lelui69YIzNxgIvv5a
	AWbZE4XLalZWSaM7KMvwVHaCFbSkh6u6D0MdzaAmnGKAOjR232tmJuV5bIFZAOvZ+Sa1Df
	nAYThj5auLs8M2WQb3nsyLajr9pPMPFYPd7Wsyfbm+hJGi2fRixPa2RuWQVkLHGs2OLugc
	THblU1YavYRkhedX9cGacj54kZtNhEEQ5CPMEmeJwz68si3mlYO41oG+Aods3gTMXcuZ2c
	iMTIp6k0zW5hCQB9hnPL5J+F/3LH0jJJHH2Sglx6LdnXucAiQMPBnWxagEg98Q==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692203600; a=rsa-sha256;
	cv=none;
	b=gi3BxAgYdVgaF7/GAmc3riqNqKa2RKe2eKZHU5kqbFwPdZ40JQlzZ+5RwZPzpr8HdHVhB3meZJ770phCT883HX7Z0rWSmrBTJAGLwq1ik7J4J6i3Q8Qzcj1LLdM6Q6lBwvYMALicQUDE221CxwCBteT7gZyLXA5xdb9Eekol5eOKRVMy8txqUFfQ61CvH4rqxxz637Ity0pdrY4M9lt/tWYzsOm2IBcifqr65LJoCWfkKSnBoCXaQGTXOnmArH/3P2gIMi4oMWJyOgNDwPJvGhgcUfTkR/x6jAP6invWK+fhJMxl0IvEA+vIBFrUCndlmlrQUl1c08KAl/SIKI9jDQ==
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

If an interface changes the MTU, it is expected that an NETDEV_PRECHANGEMTU
and NETDEV_CHANGEMTU notification events is triggered. This worked fine for
.ndo_change_mtu based changes because core networking code took care of it.
But for auto-adjustments after hard-interfaces changes, these events were
simply missing.

Due to this problem, non-batman-adv components weren't aware of MTU changes
and thus couldn't perform their own tasks correctly.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 41c1ad33d009..ae5762af0146 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -630,7 +630,7 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
  */
 void batadv_update_min_mtu(struct net_device *soft_iface)
 {
-	soft_iface->mtu = batadv_hardif_min_mtu(soft_iface);
+	dev_set_mtu(soft_iface, batadv_hardif_min_mtu(soft_iface));
 
 	/* Check if the local translate table should be cleaned up to match a
 	 * new (and smaller) MTU.
-- 
2.39.2


