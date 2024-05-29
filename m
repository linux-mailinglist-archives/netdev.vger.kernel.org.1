Return-Path: <netdev+bounces-98898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFB98D31C5
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8A2B29773
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3889F16191E;
	Wed, 29 May 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K5/BTr/7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A915DBC6
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972052; cv=none; b=YXcCxdDstFMGiyzkRytYA/GKEH8LNKmqpjk4Q/GTA2WO/km3Q9dog2yxnrOd5+NIjlEzdRz0e8wv2t/QIzK23lba9JvhAAw6yLRHVr83NPNilYoanm4bZjcA7Wa2S0PIxp/ajs6eppQ5TO6z1I3RUbhBS8BJqAXKtv78MMBhGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972052; c=relaxed/simple;
	bh=PxiUHLK8s17IbytySXGXMDZwpUb8EE8ZOVbUFlc/nCM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=utbyKPY7G/sV5IoFFyTt3YSeEuQorCX3LDJhAluL38tnjQ11R7IYeLu5r9ZfkWPqkPzs59HD6IXLlCUy7CzXcCeQkgm8VVjxmqxLhfa8bLkkZhUD3IiZvh1RiYwioCTOOa3G+GBVPdZe+QYsFsFtCHy1HfUq8ma7M5RicqALgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=K5/BTr/7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GGqYkJ/tGZpnY/WgcnZmOQ8zKHDiDlrzu/r2xxt+ih4=; b=K5/BTr/741QYEBYxky6cl+xHGN
	w9QY8WJoG7BMs4m5ANlZFOW6P68m1ernMxAPLR8TaJT7IDDo/4axkjQ7mxXNWxRx6T5wQodzjiO3x
	qj9heWGrm/5b1I2mP4yZhS/PnfXkT+ssHY+/U52olcI319PLxyKeXiKy3W9ngO/oq8CrX1J7Q8gOW
	YuPmYw9zlZK+cLQNHtU9MaLdCiazgGi8tFCoT2L2IeOLwPi6/6Z7fuxC1lqJPiA4VhD1z1S+Q1IgL
	mNJkjSNgz+rCUjq3i9/K6lqJrlOA68xN41fgpnGkmRg2zkmjiXMQfSVXnIgu4CxzCIT8VCnaCNT4H
	PyXqct/Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51694 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sCErM-0005lk-31;
	Wed, 29 May 2024 09:40:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sCErP-00EOPl-IT; Wed, 29 May 2024 09:40:39 +0100
In-Reply-To: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
References: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 2/6] net: stmmac: dwxgmac2: remove useless NULL
 pointer initialisations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sCErP-00EOPl-IT@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 May 2024 09:40:39 +0100

Remove useless NULL pointer initialisations for "PCS" methods from the
dwxgmac2 code.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f8e7775bb633..6a987cf598e4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1554,9 +1554,6 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.reset_eee_mode = dwxgmac2_reset_eee_mode,
 	.set_eee_timer = dwxgmac2_set_eee_timer,
 	.set_eee_pls = dwxgmac2_set_eee_pls,
-	.pcs_ctrl_ane = NULL,
-	.pcs_rane = NULL,
-	.pcs_get_adv_lp = NULL,
 	.debug = NULL,
 	.set_filter = dwxgmac2_set_filter,
 	.safety_feat_config = dwxgmac3_safety_feat_config,
@@ -1614,9 +1611,6 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.reset_eee_mode = dwxgmac2_reset_eee_mode,
 	.set_eee_timer = dwxgmac2_set_eee_timer,
 	.set_eee_pls = dwxgmac2_set_eee_pls,
-	.pcs_ctrl_ane = NULL,
-	.pcs_rane = NULL,
-	.pcs_get_adv_lp = NULL,
 	.debug = NULL,
 	.set_filter = dwxgmac2_set_filter,
 	.safety_feat_config = dwxgmac3_safety_feat_config,
-- 
2.30.2


