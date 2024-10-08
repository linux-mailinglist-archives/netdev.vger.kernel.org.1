Return-Path: <netdev+bounces-133158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31AA995216
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00971C24EFC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876611DF27A;
	Tue,  8 Oct 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ik59nFVS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6221DEFC7
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398504; cv=none; b=mFxZGPzsRKylyVYB3JIj/YClpYW5dSBzMpESDH/pe7bkc1zItGVZ4Ion3RtCCyI7XhxsSSYqVVo9NLr0w7YvJnhBkZS2LS8/tiVjNlDpKhMzPAHeK8/ebKTBixmIjnaWZ7yTCqItlWvX1G+aU4VGENheTBXL0SzgU7iq8tPv9F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398504; c=relaxed/simple;
	bh=DmLPmLRaziza5ewwjphLPzMhIQDGOKj2U5ryKGjIm7A=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Xq/36gxE7ziwZk6lDmV9pNL7fmoqKVlSPea+zWQ2Nn6L++smBv1wWvMFgSmCI1XFETdigOkLpdBy5mh3tEZVY/ykbkKt8rdZq88Gx11kvDet3fYavbxXpoFpwCrl/5OUtv7oscvESH1YsxsprXR8dgYTQS8U8KniBt8xBys1eQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ik59nFVS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qlsgT3uh8K9k1PV5YZmeebJi1rGILfxVcCKMi1nm2lU=; b=ik59nFVSPrzkhdV9Ad1zs6HAgR
	Mgur03fznZuxKbMO4kwX10AWx3YpEiC8Cw/vV1/iV2UUjjc2U7AwiQ+PrKkDoZA5inXvz4VJPyVw4
	z/Xg/9hSCtlNDEuYKMFviz52dmojHhDJ0lDWJie9+7vv0AuuC2wpkM0Wp/qSW7ZhY68MtIzfFXQoU
	7Z0Y+0fZPb4/I8o5J4TfXIPjFMNlTFZGbzIOfIA6TKdsKxvT00oCCHHMgZ+QxFWcM2+x3pPyJAMBa
	scyEPh5JpXW2mYKN8AH+kfpqU7/eDnu15K0+0B7AArRnpaobpx2JZ+G5QxTWgiGjjADGjlrJ+SNya
	8MiHNUNQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40232 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1syBP6-0007cN-0a;
	Tue, 08 Oct 2024 15:41:35 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1syBP4-006UnV-Lk; Tue, 08 Oct 2024 15:41:34 +0100
In-Reply-To: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 1/3] net: dsa: remove
 dsa_port_phylink_mac_select_pcs()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1syBP4-006UnV-Lk@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 08 Oct 2024 15:41:34 +0100

There is no longer any reason to implement the mac_select_pcs()
callback in DSA. Returning ERR_PTR(-EOPNOTSUPP) is functionally
equivalent to not providing the function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/port.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index f1e96706a701..ee0aaec4c8e0 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1575,13 +1575,6 @@ void dsa_port_set_tag_protocol(struct dsa_port *cpu_dp,
 	cpu_dp->tag_ops = tag_ops;
 }
 
-static struct phylink_pcs *
-dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
-				phy_interface_t interface)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
 static void dsa_port_phylink_mac_config(struct phylink_config *config,
 					unsigned int mode,
 					const struct phylink_link_state *state)
@@ -1604,7 +1597,6 @@ static void dsa_port_phylink_mac_link_up(struct phylink_config *config,
 }
 
 static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
-	.mac_select_pcs = dsa_port_phylink_mac_select_pcs,
 	.mac_config = dsa_port_phylink_mac_config,
 	.mac_link_down = dsa_port_phylink_mac_link_down,
 	.mac_link_up = dsa_port_phylink_mac_link_up,
-- 
2.30.2


