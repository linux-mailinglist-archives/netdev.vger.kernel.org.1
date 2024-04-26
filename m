Return-Path: <netdev+bounces-91764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C078B3C9F
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A04FB27E14
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B015218E;
	Fri, 26 Apr 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hdyBAmFi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F777152DE6
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148285; cv=none; b=VPi37AcBmyM1DJRzmBOGscL152nMrQZ2MjbWUst+eeJxUnB/hc1pqch8thQF+Z7i+vxs4xdtr8I5JjhNR0ad7An9B9ktX1x7SJ5xMPGRNWaIdmVJsGZSds4uNv+CtC5Al+wLOnS+WH2hP7loobap5WixneNUn+O1ueIpLBXLzTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148285; c=relaxed/simple;
	bh=QfmJMkImlEbNNRuCKVo8CQkejG4Rt3mFG4EZqkkEe/c=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=BsKYpuSRvpgxHtwXuh0xFpSewgMa0cZDQZki5VJQUpmloTbt6k47rlHqFc4QP+ja+yCr41d9afghJ1GVdzq+Y+XH/5aoDjok4DoeJKV/4jghklwrfM+Qd95PdIQYpKtqC1PIbXfSJNXwFXpzAAJOXAbSSxlTdmAkgxodaSeBZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hdyBAmFi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CvvZNJdD0XzTW2P1ATMane+Hv0RNtIicX2dWTPkqCp8=; b=hdyBAmFixijD/e1BtWGCiTytMN
	jX7DbteBvRCoAkE9imNxETaximiz7+uKstGE1wq9NJHTx9YYq0qpNGwcbASmg/x6jNHtvvdMJvlSW
	O2IDbSYxqVntx3cWlpausH2Wdjj90x+kLSWsNrSJQBRSeIG6rHcqbIAfuSIcl9lmGDlCnFdkveEDn
	+Ml9iAUQCxs3YeuGw89VtIZo3Aj806EwgyTi/SExnWmniwaahIFvUISTiTN08IF0Y6sg9TVsdlaW4
	2+csULcZFzuTEwAf6+e/EbVxsNKFJqzFzO16SZZGaUwBDg/A4/fbsJPjsC5DEthuZTkzZyWRQTlH+
	MSVyrHhQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35638 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s0OGr-0000Vj-0l;
	Fri, 26 Apr 2024 17:17:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s0OGs-009hgl-Jg; Fri, 26 Apr 2024 17:17:58 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: mvneta: use phylink_pcs_change() to report PCS
 link change events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s0OGs-009hgl-Jg@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 26 Apr 2024 17:17:58 +0100

Use phylink_pcs_change() when reporting changes in PCS link state to
phylink as the interrupts are informing us about changes to the PCS
state.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvneta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 40a5f1431e4e..26bf5d47ba02 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3259,7 +3259,8 @@ static void mvneta_link_change(struct mvneta_port *pp)
 {
 	u32 gmac_stat = mvreg_read(pp, MVNETA_GMAC_STATUS);
 
-	phylink_mac_change(pp->phylink, !!(gmac_stat & MVNETA_GMAC_LINK_UP));
+	phylink_pcs_change(&pp->phylink_pcs,
+			   !!(gmac_stat & MVNETA_GMAC_LINK_UP));
 }
 
 /* NAPI handler
-- 
2.30.2


