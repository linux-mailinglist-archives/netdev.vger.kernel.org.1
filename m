Return-Path: <netdev+bounces-244053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E02CAE9F5
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 02:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5DF33005F01
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 01:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D804274FEB;
	Tue,  9 Dec 2025 01:28:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66F8F4A;
	Tue,  9 Dec 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765243688; cv=none; b=YOeTtYwsf0KMzv6cOolZMEhFwVIiNQLCa7ERnvRkau5gDa2XXyapZJJZiD8MjcPpuq7KlZxmUPPZDn4zBnMgGUfnd2bd4kXdn9BcTa6qL+usDL5haPBK+KI49fALsCqIyLJJkOUevf5+o+bjCtWZwx/30HMrZbD7W0su/tF+fG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765243688; c=relaxed/simple;
	bh=FNWiyVAivc4h5mni+Jy4YHK/2bOIv2EuXqauEPnm6/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=stP8tAIeXeZBdRq+gqHORtsH6y3cNB+IcD/3AVL5DG8Yucqpz87ADGV7rzifeSU1QbLnJpcybRR5F+NWJwi4FBXZi99x04e+WIMA05dLDD0Vn5ultCMCPu8WXFt7wtCKsp8MtEHzlEqLrIrabdOIvSTClt/WZzD2vJYFctJgM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vSmW1-0000000059X-2cjA;
	Tue, 09 Dec 2025 01:27:45 +0000
Date: Tue, 9 Dec 2025 01:27:42 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net v4 0/4] net: dsa: lantiq: a bunch of fixes
Message-ID: <cover.1765241054.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series is the continuation and result of comments received for a fix
for the SGMII restart-an bit not actually being self-clearing, which was
reported by by Rasmus Villemoes.

A closer investigation and testing the .remove and the .shutdown paths
of the mxl-gsw1xx.c and lantiq_gswip.c drivers has revealed a couple of
existing problems, which are also addressed in this series.

Daniel Golle (4):
  net: dsa: lantiq_gswip: fix order in .remove operation
  net: dsa: mxl-gsw1xx: fix order in .remove operation
  net: dsa: mxl-gsw1xx: fix .shutdown driver operation
  net: dsa: mxl-gsw1xx: manually clear RANEG bit

 drivers/net/dsa/lantiq/lantiq_gswip.c        |  3 --
 drivers/net/dsa/lantiq/lantiq_gswip.h        |  2 --
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 19 +++++-----
 drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 38 +++++++++++++++++---
 4 files changed, 44 insertions(+), 18 deletions(-)

-- 
2.52.0

