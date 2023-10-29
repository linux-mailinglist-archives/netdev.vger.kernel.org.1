Return-Path: <netdev+bounces-45092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F67DADC0
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 19:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062D12814B9
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779BB101E6;
	Sun, 29 Oct 2023 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="sujq5HcF";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="WbPLYZpf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB928FC1E
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 18:43:30 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7956CC;
	Sun, 29 Oct 2023 11:43:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id C63F160187;
	Sun, 29 Oct 2023 19:43:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1698605006; bh=C0fbJhCelN3HUXSd6OtmKYAgitc2PZFM3gqVXrhWFL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sujq5HcFHVcb7rJtKdra3UexWxdEQgN79FBkZ+idn+zw2xm6JOSgenw1eP83f3riX
	 KhCvgni8iSzh+xU6lR/K+v3YclDPzE2UbQ66SGX1z0s2bo9QJKkH3w4gThuk2EDPEQ
	 wFNWb+rJs3QbJq6V1Diu8hYcctdztxeEINeTAjROffMrcPc5K3DXpvkRGkq5ewnQ6a
	 0jIm6/5Rl6AYdVlP4Ofqw8q+/L+TmAE6XPqcXl+dtEuywrVz3ulXawRFixKc4ykgXH
	 ojH5pt19eoc/AdH2b15c9f5t7mc0LDbmZYipZfwMnwW1CpOsGBjyt3skBib7jyU/Xm
	 7FiRBNZlWyF9g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjd0BdmdBeQa; Sun, 29 Oct 2023 19:43:24 +0100 (CET)
Received: from defiant.home (78-3-40-247.adsl.net.t-com.hr [78.3.40.247])
	by domac.alu.hr (Postfix) with ESMTPSA id 3B5A160173;
	Sun, 29 Oct 2023 19:43:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1698605004; bh=C0fbJhCelN3HUXSd6OtmKYAgitc2PZFM3gqVXrhWFL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbPLYZpfeA7P3IpyqtWcs4mD1SaB6HjXHzCX6Az/u/OHJzb1XUQJ1Z8jeSIFQ7N9M
	 VgzqnObyyJ2XVZ2sJO1zi7dzpNcsrSwAHI5jiFWu/GQoBgl0HDrHGZ93KlOYhmE67I
	 aohbFwCw87xblI9OjJh5/04S51hNfH3PX/gzOPuQP5tFWgXidKdf6kYmrI1Q9MQePU
	 vj/2WCItMuHbmZ+pFqxolcDateFkM7To0U2wczC4tCzqly5U06uUxz7HXCCKoFLbWV
	 TjNvAM0lKT2afVbWRbeHLGp7i1p8Ar4dwiV8FZDcX7bquCyamnZ7KNoqztUea+p6sE
	 Tf/xOZJoMlaHg==
From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Marco Elver <elver@google.com>
Subject: [PATCH v5 4/7] r8169: Coalesce mac ocp write and modify for 8168ep start to reduce spinlock contention
Date: Sun, 29 Oct 2023 19:36:01 +0100
Message-Id: <20231029183600.451694-4-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
References: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
the startup of RTL8168ep involve implicit spin_lock_irqsave() and
spin_unlock_irqrestore() on each invocation.

Coalesced with the corresponding helpers into r8168_mac_ocp_write_seq() and
r8168_mac_ocp_modify_seq() with a sinqle paired spin_lock_irqsave() and
spin_unlock_irqrestore(), these calls help reduce overall spinlock contention.

Fixes: ef712ede3541d ("r8169: add helper r8168_mac_ocp_modify")
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Marco Elver <elver@google.com>
Cc: nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
v5:
 added unlocked primitives to allow mac ocs modify grouping
 applied coalescing of mac ocp writes/modifies for 8168ep and 8117
 some formatting fixes to please checkpatch.pl

v4:
 fixed complaints as advised by Heiner and checkpatch.pl
 split the patch into five sections to be more easily manipulated and reviewed
 introduced r8168_mac_ocp_write_seq()
 applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B

v3:
 removed register/mask pair array sentinels, so using ARRAY_SIZE().
 avoided duplication of RTL_W32() call code as advised by Heiner.

 drivers/net/ethernet/realtek/r8169_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 29ee93b8b702..27016aaeb6a0 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3326,6 +3326,12 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 		{ 0x1e, 0x0000,	0x2000 },
 	};
 
+	static const struct e_info_regmaskset e_info_8168ep_3_mod_1[] = {
+		{ 0xd3e2, 0x0fff, 0x0271 },
+		{ 0xd3e4, 0x00ff, 0x0000 },
+		{ 0xe860, 0x0000, 0x0080 },
+	};
+
 	rtl_ephy_init(tp, e_info_8168ep_3);
 
 	rtl_hw_start_8168ep(tp);
@@ -3333,9 +3339,7 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
 	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
 
-	r8168_mac_ocp_modify(tp, 0xd3e2, 0x0fff, 0x0271);
-	r8168_mac_ocp_modify(tp, 0xd3e4, 0x00ff, 0x0000);
-	r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
+	r8168_mac_ocp_modify_seq(tp, e_info_8168ep_3_mod_1);
 }
 
 static void rtl_hw_start_8117(struct rtl8169_private *tp)
-- 
2.34.1


