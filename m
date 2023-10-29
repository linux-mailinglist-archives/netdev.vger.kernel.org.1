Return-Path: <netdev+bounces-45063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709E17DAC1A
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 12:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2A1B20DBE
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67695BA3A;
	Sun, 29 Oct 2023 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="uKov8Epv";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="c0S7U11d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64B9469
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 11:14:17 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA6AB;
	Sun, 29 Oct 2023 04:14:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 26A3C60182;
	Sun, 29 Oct 2023 12:14:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1698578055; bh=dD433RcfZMXumHsqDGuyG1IGuMidDi/U8xCKI0ffmTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKov8Epvhl8Kxt60aShiUCdlHhiA5MYBeGSrMpoJ9kxoqqIaarwaU75cVWLKy6+Xd
	 gtMdWqi2t3B54q2vyFRY4x35tS7/zbKe5cb6xFtA/Hl55bFUEzDVJdURlTeCK0mqm1
	 kM4f9ZbqdNajfyQnMDDUCfw4YnVqTtFa7FCrWZ/RcWNa4VxBoBPCVkURU3tn8leJzD
	 Unz26dDpwbah/nCDge7ECepBXj0dPIGnLOANkcBrzY6HRqyfpHuQNlmPbvkmV9o54I
	 PGoIdAU5xbHDMn2uKYgWWxUlrvKPgiVmVeb9XIAEavPOSU/ibRTyRmacHsappwD1UI
	 S0xAOOWHV490A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sKHw8ZPIZR9j; Sun, 29 Oct 2023 12:14:12 +0100 (CET)
Received: from defiant.home (78-3-40-247.adsl.net.t-com.hr [78.3.40.247])
	by domac.alu.hr (Postfix) with ESMTPSA id 68D7F60173;
	Sun, 29 Oct 2023 12:14:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1698578052; bh=dD433RcfZMXumHsqDGuyG1IGuMidDi/U8xCKI0ffmTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0S7U11d+DXzFtzA+nyfBY+QzUPznh86Pv2iE543t7CyG3iR+Mm2pdQMzwmSqbNF1
	 93gHpqhYQrQjK2CuiXXCDDFBVrgHyw7EqvJzALlkI3VgzI3QxNH86f2hcjtLOhOOhk
	 bIF99GeZN2QxKYa8RPG/UfJJNBvbZT16viauVYrOjWDwDs6RLmsMeHzm4TObjSip05
	 KK4VZR7QOTumOq/HanP+ZUUy48mvyov/Xa7bLADww4eFF3kNyRfDQ0uYh4L5EgaGBM
	 06oaJC2KEiQQMOA/m/BNY1z25mxkwLmgJr0aDdCmpWJIw9MNSJXFMAV65yY4OwHQx/
	 XqKhLhbVxNtcw==
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
Subject: [PATCH v4 5/5] r8169: Coalesce mac ocp commands for rtl_hw_init_8125 to reduce spinlocks
Date: Sun, 29 Oct 2023 12:04:47 +0100
Message-Id: <20231029110442.347448-5-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
References: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
the init sequence of the 8125 involve implicit spin_lock_irqsave() and
spin_unlock_irqrestore() on each invocation.

Coalesced with the corresponding helpers r8168_mac_ocp_write_seq() and
r8168_mac_ocp_modify_seq() into sequential write or modidy with a sinqle lock/unlock,
these calls reduce overall lock contention.

Fixes: f1bce4ad2f1ce ("r8169: add support for RTL8125")
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
v4:
 fixed complaints as advised by Heiner and checkpatch.pl.
 split the patch into five sections to be more easily manipulated and reviewed
 introduced r8168_mac_ocp_write_seq()
 applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B

v3:
 removed register/mask pair array sentinels, so using ARRAY_SIZE().
 avoided duplication of RTL_W32() call code as advised by Heiner.

 drivers/net/ethernet/realtek/r8169_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index dd65e0384ab3..8dce08d90367 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5070,6 +5070,12 @@ static void rtl_hw_init_8168g(struct rtl8169_private *tp)
 
 static void rtl_hw_init_8125(struct rtl8169_private *tp)
 {
+	static const struct e_info_regdata hw_init_8125_1[] = {
+		{ 0xc0aa, 0x07d0 },
+		{ 0xc0a6, 0x0150 },
+		{ 0xc01e, 0x5555 },
+	};
+
 	rtl_enable_rxdvgate(tp);
 
 	RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) & ~(CmdTxEnb | CmdRxEnb));
@@ -5079,9 +5085,7 @@ static void rtl_hw_init_8125(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe8de, BIT(14), 0);
 	r8168g_wait_ll_share_fifo_ready(tp);
 
-	r8168_mac_ocp_write(tp, 0xc0aa, 0x07d0);
-	r8168_mac_ocp_write(tp, 0xc0a6, 0x0150);
-	r8168_mac_ocp_write(tp, 0xc01e, 0x5555);
+	r8168_mac_ocp_write_seq(tp, hw_init_8125_1);
 	r8168g_wait_ll_share_fifo_ready(tp);
 }
 
-- 
2.34.1


