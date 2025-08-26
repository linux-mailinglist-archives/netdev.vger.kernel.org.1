Return-Path: <netdev+bounces-217085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D058B37538
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E53360FD0
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B32DF6EA;
	Tue, 26 Aug 2025 23:06:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1F2D8DA9;
	Tue, 26 Aug 2025 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249594; cv=none; b=OPAY4LqOV3veMmScMQCqs5JVlgoiIdVsydRrLipflBcZZnticdnxL5VzKKTbVOGDlb5G0/SKCtwMHRaTooPUWQUfki278M4s5qPWd4ndw+6sLjmLiZIMbs+WAqdAQs9c5YNixmzV6dFAL3S9tCiT+hH25Gn9+8ab2g3ayZOErPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249594; c=relaxed/simple;
	bh=gPW8/s2OSqyRhSLj9Ov1snpbX2gPu55ctTsANI6JoUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeuMaf94sx1SCay/ZGUl2e90oRpw3aK6Z0ODqUMT41xDgXizzjmb9g0oPXlgYepcCgiZDp7ywUh5yVVcT6LdGxTpxUYoX9e7Lt19mM83L28WsZu05AKRv7eu7dGCuIcje9HPdZMrE9lQfF6Yrn2/XWKRjpngs+pgRcsG1XExEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ur2kG-000000001to-1ACB;
	Tue, 26 Aug 2025 23:06:28 +0000
Date: Wed, 27 Aug 2025 00:06:24 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v2 5/6] net: dsa: lantiq_gswip: support standard
 MDIO node name
Message-ID: <c8c3b44fd5d81d86dc771df522088f4cc3bc9296.1756228750.git.daniel@makrotopia.org>
References: <cover.1756228750.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756228750.git.daniel@makrotopia.org>

Instead of matching against the child node's compatible string also
support locating the node of the device tree node of the MDIO bus
in the standard way by referencing the node name ("mdio").

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
v2: no changes

 drivers/net/dsa/lantiq/lantiq_gswip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 64e378852284..9fd5e5938384 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -286,6 +286,9 @@ static int gswip_mdio(struct gswip_priv *priv)
 	int err = 0;
 
 	mdio_np = of_get_compatible_child(switch_np, "lantiq,xrx200-mdio");
+	if (!mdio_np)
+		mdio_np = of_get_child_by_name(switch_np, "mdio");
+
 	if (!of_device_is_available(mdio_np))
 		goto out_put_node;
 
-- 
2.51.0

