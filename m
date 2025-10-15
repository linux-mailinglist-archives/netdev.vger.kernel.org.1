Return-Path: <netdev+bounces-229813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62007BE0F2E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895171A23E88
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C3730DD23;
	Wed, 15 Oct 2025 22:33:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56330DD0D;
	Wed, 15 Oct 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567630; cv=none; b=CToOGGjlmb1xhZvrmFMZjw1Vx5zHnQaMhLmHALO5sIkErL/BANT4lA7dLNtuok36trrPSA/PDfXXRNUmaLrILAn/TuH8/djN1mvqoywq35m+9wrLhvrRGyI8qeEirM0AFx/cdL51fO/uBuRgfM2NcCpPwUVJ/8t/FuOTWtGbiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567630; c=relaxed/simple;
	bh=ydN0CQk9eCQObKh2zNgXLlMg5I8r3uoaYzkJUDBSmDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELKmOukqdhKyUngU2b79IKsCRGtN3rAT5pQ19HlmfjIeDDklQ1iaCk43ouJmparcBz/IhlYR68MhwYn5Dh4DRw4vFMPS/XpckQ+P31X5te5QYXH45RAZ8ml1xOB4POHiOpW/Bpl70b+sKkevoIG5ilsuN6Sw//wBcfeeG3p7DZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A41-000000006X2-160l;
	Wed, 15 Oct 2025 22:33:45 +0000
Date: Wed, 15 Oct 2025 23:33:41 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
Subject: [PATCH net-next 09/11] net: dsa: lantiq_gswip: put a more
 descriptive error print in gswip_vlan_remove()
Message-ID: <abd4ec58e0f0f53eb3d7027097a20af0bd7b1d6d.1760566491.git.daniel@makrotopia.org>
References: <cover.1760566491.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760566491.git.daniel@makrotopia.org>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Improve the error message printed in case of a port VLAN entry not being
found upon removal.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index d9a7a004f9eb..cfdeb8148500 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -875,7 +875,8 @@ static int gswip_vlan_remove(struct gswip_priv *priv,
 	}
 
 	if (idx == -1) {
-		dev_err(priv->dev, "bridge to leave does not exists\n");
+		dev_err(priv->dev, "Port %d cannot find VID %u of bridge %s\n",
+			port, vid, bridge ? bridge->name : "(null)");
 		return -ENOENT;
 	}
 
-- 
2.51.0

