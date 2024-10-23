Return-Path: <netdev+bounces-138419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06839AD737
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B320D284C4B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219A1FF046;
	Wed, 23 Oct 2024 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wZEuOYl5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1271FDF9D;
	Wed, 23 Oct 2024 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720961; cv=none; b=Awpq2RIROjvXzLYp8ga9xJS0Zt97N/j1MMWdUF5iKib/++xlIvBcQ0TApzUBSHiluWl+sYvQqGeqge0qJLO1EDiMJ+Kft8ap1mFnlUwxzwQhDXiOL1mS4OU156oMUqCXKAlKKRqQFYIE0fXghRs7MM1X0tYbdc3i5IyvxSYgdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720961; c=relaxed/simple;
	bh=TvHR8qKlsEZ/gYU9wdk5E7vu890MusslQxca3KuHjs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=O3LQsFP9P2m60ehs5i2ITtphIv9rRmQeta7eyRLXEwnYlLtu1hqMdWwjrgCaoTwMbslw2vukbmihkjexpD2/8MXD8gjH18m8kuZRDkvwcfG+GS5H6PFdc5iP0EVHi+v7r15fEW8HJtop1u+x5gmG/kIWB0B/+FHY2DXwuYnFATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wZEuOYl5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729720959; x=1761256959;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TvHR8qKlsEZ/gYU9wdk5E7vu890MusslQxca3KuHjs0=;
  b=wZEuOYl5Df0R+ncvQCoYKYaYhBVuaYXY2sAKN/Xe4ultkdG4CT2lKxte
   vntwt+9Hs24xkGp8DrkUBcRWXYemcFc4oM7CAYZxz4YBX3yRq8oi7OHMC
   xEzMEV9DX/zF02lJwkQfcWvPhtJB35SD340CPR1CpXV1MFRKcBQt9g4n3
   2XgVlhMZJjYh0qjtPZPk2nSc99vYGHi5B4mD00C2dRRRiFnyqdBOpuWxE
   EnZvWvV43eHyLpEqrmQpwMGGIK/L5fimFE9MP7JLX3winBdHG+++mE06z
   ubLiBWQqjjbHtxahVa526QHGJDLE8LHnbpaizoW/n0gAHsKEk/5+MwFOF
   w==;
X-CSE-ConnectionGUID: wd8IJW4NTJ64cR86gqDN2Q==
X-CSE-MsgGUID: KM0LWttpTwaDnBlVitA/WA==
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="200831269"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 15:02:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 23 Oct 2024 15:02:12 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 23 Oct 2024 15:02:08 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Oct 2024 00:01:27 +0200
Subject: [PATCH net-next v2 08/15] net: lan969x: add constants to match
 data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-sparx5-lan969x-switch-driver-2-v2-8-a0b5fae88a0f@microchip.com>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
In-Reply-To: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Add the lan969x constants to match data. These are already used
throughout the Sparx5 code (introduced in earlier series [1]), so no
need to update any code use.

[1] https://lore.kernel.org/netdev/20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com/

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan969x/lan969x.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
index 0b47e4e66058..19f91e4a9f3e 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
@@ -103,11 +103,32 @@ static const struct sparx5_regs lan969x_regs = {
 	.fsize = lan969x_fsize,
 };
 
+static const struct sparx5_consts lan969x_consts = {
+	.n_ports             = 30,
+	.n_ports_all         = 35,
+	.n_hsch_l1_elems     = 32,
+	.n_hsch_queues       = 4,
+	.n_lb_groups         = 5,
+	.n_pgids             = 1054, /* (1024 + n_ports) */
+	.n_sio_clks          = 1,
+	.n_own_upsids        = 1,
+	.n_auto_cals         = 4,
+	.n_filters           = 256,
+	.n_gates             = 256,
+	.n_sdlbs             = 496,
+	.n_dsm_cal_taxis     = 5,
+	.buf_size            = 1572864,
+	.qres_max_prio_idx   = 315,
+	.qres_max_colour_idx = 323,
+	.tod_pin             = 4,
+};
+
 const struct sparx5_match_data lan969x_desc = {
 	.iomap      = lan969x_main_iomap,
 	.iomap_size = ARRAY_SIZE(lan969x_main_iomap),
 	.ioranges   = 2,
 	.regs       = &lan969x_regs,
+	.consts     = &lan969x_consts,
 };
 EXPORT_SYMBOL_GPL(lan969x_desc);
 

-- 
2.34.1


