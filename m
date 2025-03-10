Return-Path: <netdev+bounces-173474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B06A59258
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 244627A17FC
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B506226D08;
	Mon, 10 Mar 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NkRJk56m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA528EA
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605078; cv=none; b=YMKacGjZ3/DMPZawwf+oYX1r9vRsebelkVMdi8IAoNwRaXCQG7bME/+VkKBAkM8uHHeIpWO0k4LBTTiSYXe0V6VVUkFRykBtVEEWqZcEl1zkeJvBvqup5qTuWrxVKAjomWUqudZ/lOkpCxsqXUMajyxLANVAvFE3b6X1sAoxU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605078; c=relaxed/simple;
	bh=oEgwJBS8hm23gTzRxKjged6M6tViIIasZJAzbzN6jf8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=YLM3FQwWp+SCvdVPTKrRIluMcRsbUMFKtBQDL6SZaJCqKyUDi5RlyfTyetegMfSJ85PFz0a6OjvmulNITeowTGWl19j1PCE1/VCJ4QpW7ecWwVlx2LgMW9ESB16dW/1MoS6cHgs5suD/5froAjmVQVwepvyJUH12YS/dvTzNDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NkRJk56m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TKQ0+qNWdJImNUcrdlLYtYjgcSWuwBLBpOwrPuSEM+w=; b=NkRJk56m1VxFZ5brWsFzgGRKtZ
	kZ745RbKMqxA45C6WxopaGES7xf6df5sFU97KtrLfgsosGCtKT3Uz4a20KWnzugZVrzAz+t2dfFWb
	nPB1syLBpCmQBS3u5qT2Lx+B+Zmu+bjV42VsGvAj+M8AbO1KkmLILBLliWX7IBoqJ27beTayGIOzs
	oWslzWqALPUkojgTNeRL0HLX2PW4p80Mkoyef5dcN6kuwDPPbTewcqoc9RbVIshyecf5/tOsjvC+f
	+14ZGDELfJMA4ggEOfj8/nsLK3CySVpnqLZ3XJoBMJhUpC07thVBqu2F3m614znuoToHdCCA4mKfk
	IMyzQlTw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37202 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1trb2O-0002Ry-2a;
	Mon, 10 Mar 2025 11:11:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1trb24-005oVq-Is; Mon, 10 Mar 2025 11:10:52 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] net: phylink: expand on .pcs_config() method
 documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1trb24-005oVq-Is@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Mar 2025 11:10:52 +0000

Expand on the requirements of the .pcs_config() method documentation,
specifically mentioning that it should cause minimal disruption to
an established link, and that it should return a positive non-zero
value when requiring the .pcs_an_restart() method to be called.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/phylink.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index c187267a15b6..79876c84ae81 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -595,6 +595,14 @@ void pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
  * The %neg_mode argument should be tested via the phylink_mode_*() family of
  * functions, or for PCS that set pcs->neg_mode true, should be tested
  * against the PHYLINK_PCS_NEG_* definitions.
+ *
+ * pcs_config() will be called when configuration of the PCS is required
+ * or when the advertisement is possibly updated. It must not unnecessarily
+ * disrupt an established link.
+ *
+ * When an autonegotiation restart is required for 802.3z modes, .pcs_config()
+ * should return a positive non-zero integer (e.g. 1) to indicate to phylink
+ * to call the pcs_an_restart() method.
  */
 int pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	       phy_interface_t interface, const unsigned long *advertising,
-- 
2.30.2


