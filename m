Return-Path: <netdev+bounces-109786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CE0929F28
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB1E288076
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7AF73459;
	Mon,  8 Jul 2024 09:33:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FF6F307
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431239; cv=none; b=V/0mBUfbxCkuKAsjCWmD4oyLgqI17XbOeshbUiAOtpAi7Yd04BaJLKDDr0rNyjB0Ey8zgFwBLo44vO7ZlIS5QG0LMMDVYl49nXolc65UjLVOcPBXNWGuy/EvhOznl9GE3TEWe/PpK0GRgTs+40GyLL3SoLlaPHBKkeN9NKB9xvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431239; c=relaxed/simple;
	bh=ppUNgjj43Hrr5dD4flMVjDKYYKFJP2NRCWZ3YA6Pe2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SN3NFz5Q/LJIaOhFNOvm9a3jiAGvQNsdAYg777X6qjiDXpcXxrtIy8sHe93XglCBrySZxfaiYhq08JDZnHcbp4XrtX6YWtoaC98h2aXxH7N9sP6kzX355i/2qaNEzgyo0azl5BF4HK42OnfXAj3HsTz92dHCbPKvBBLUA0Xtnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4WHdyF3z0sz4wyy9
	for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 11:25:25 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by andre.telenet-ops.be with bizsmtp
	id kxRH2C00F5NeGrf01xRHKX; Mon, 08 Jul 2024 11:25:17 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkcL-001PIg-GG;
	Mon, 08 Jul 2024 11:25:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkcX-009RLR-Bp;
	Mon, 08 Jul 2024 11:25:17 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net-next] netxen_nic: Use {low,upp}er_32_bits() helpers
Date: Mon,  8 Jul 2024 11:25:14 +0200
Message-Id: <319d4a5313ac75f7bbbb6b230b6802b18075c3e0.1720430602.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the existing {low,upp}er_32_bits() helpers instead of defining
custom variants.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested on 32 and 64 bit.
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
index 2fcbcecb41d17a34..fef4b2b0b1f268dd 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
@@ -571,9 +571,6 @@ static u64 ctx_addr_sig_regs[][3] = {
 #define CRB_CTX_ADDR_REG_HI(FUNC_ID)	(ctx_addr_sig_regs[FUNC_ID][2])
 #define CRB_CTX_SIGNATURE_REG(FUNC_ID)	(ctx_addr_sig_regs[FUNC_ID][1])
 
-#define lower32(x)	((u32)((x) & 0xffffffff))
-#define upper32(x)	((u32)(((u64)(x) >> 32) & 0xffffffff))
-
 static struct netxen_recv_crb recv_crb_registers[] = {
 	/* Instance 0 */
 	{
@@ -723,9 +720,9 @@ netxen_init_old_ctx(struct netxen_adapter *adapter)
 		NETXEN_CTX_SIGNATURE_V2 : NETXEN_CTX_SIGNATURE;
 
 	NXWR32(adapter, CRB_CTX_ADDR_REG_LO(port),
-			lower32(recv_ctx->phys_addr));
+			lower_32_bits(recv_ctx->phys_addr));
 	NXWR32(adapter, CRB_CTX_ADDR_REG_HI(port),
-			upper32(recv_ctx->phys_addr));
+			upper_32_bits(recv_ctx->phys_addr));
 	NXWR32(adapter, CRB_CTX_SIGNATURE_REG(port),
 			signature | port);
 	return 0;
-- 
2.34.1


