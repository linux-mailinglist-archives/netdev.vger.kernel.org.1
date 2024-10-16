Return-Path: <netdev+bounces-136134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6064A9A07EA
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 12:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002C3B2344B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5442071F7;
	Wed, 16 Oct 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Tg5Ifmn6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485F2076B1
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076282; cv=none; b=W98G/3GIQe+IJd1hEPl+EfAkycY8JQc2sVbLmuO6SDqieUbDYH0NohOdMblhdGZyhUzXaKnjcHeaCMb6E+3Zt9lB22wn29VYd17fPMZdQJx6hqjNKz/2/Oan38BAXRIhp33Di5JHGuymOITCe7GrMwS1ahWLQLtd9BuLjiGJxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076282; c=relaxed/simple;
	bh=IMeAA6Z6OmV3xkxhs8q0OhNEiDxOqMCJjRd91kjtNYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oWo+oOxd2Obztg2vbPxx11Fzctd2MmY37CZSv9x54wkdAxcqr31i0RVlPJuFbInttPX7iEWGhFHiOYa8PJTd43FhGitm5reNgS2dzv76j7sulyC+oWn+qx5bn5yKzsPweGHfZ3Vz8Jtr7rXi6wUMZoFedOHEfX7q3d3rSQky/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Tg5Ifmn6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729076280; x=1760612280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IMeAA6Z6OmV3xkxhs8q0OhNEiDxOqMCJjRd91kjtNYc=;
  b=Tg5Ifmn6rhfPymEozv9I05C81pD0Q/XYRowzaGqfSMXqDU3+LbnGrxZb
   zBngHxrey7WwLpAJD8tu3nUawlQxrTuEwwO8Js3LPPjBshrdIFgKkXhn/
   htCDIthgXSArgDoNry/ZcsSDPI9enOpek7EfQRz+PKM65fBuVH3vyI20l
   Zuy6cBuIP2OVbnVoqtg/IkeWuOyrIt6LtkvN2SFbNk4749jiq/ylYk/VT
   IZ4QRbjXF1DsRkW5OFnd+z7b3ybp7eJBZet3/I9o5S3SlO67jwGQdfcTS
   hz6U/dan5ArrYOGp71RvVvx4DqEwDnR8bdof9ApZj13TjraYEf6ZpkZRG
   g==;
X-CSE-ConnectionGUID: O4Pn7NtkT3uWy5mnoknAqA==
X-CSE-MsgGUID: WeP10gc8QXSyZwp+e9FUsQ==
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="32887428"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2024 03:57:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 16 Oct 2024 03:56:52 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 16 Oct 2024 03:56:49 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <f.pfitzner@pengutronix.de>, <mkubecek@suse.cz>, <netdev@vger.kernel.org>,
	<kory.maincent@bootlin.com>, <davem@davemloft.net>
CC: <kuba@kernel.org>, <andrew@lunn.ch>, <Anbazhagan.Sakthivel@microchip.com>,
	<Nisar.Sayed@microchip.com>, <mohan.prasad@microchip.com>
Subject: [PATCH ethtool] netlink: settings: Fix for wrong auto-negotiation state
Date: Wed, 16 Oct 2024 09:28:47 +0530
Message-ID: <20241016035848.292603-1-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Auto-negotiation state in json format showed the
opposite state due to wrong comparison.
Fix for returning the correct auto-neg state implemented.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 netlink/settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/netlink/settings.c b/netlink/settings.c
index dbfb520..a454bfb 100644
--- a/netlink/settings.c
+++ b/netlink/settings.c
@@ -546,7 +546,7 @@ int linkmodes_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 						(autoneg == AUTONEG_DISABLE) ? "off" : "on");
 		else
 			print_bool(PRINT_JSON, "auto-negotiation", NULL,
-				   autoneg == AUTONEG_DISABLE);
+				   (autoneg == AUTONEG_DISABLE) ? false : true);
 	}
 	if (tb[ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG]) {
 		uint8_t val;
-- 
2.43.0


