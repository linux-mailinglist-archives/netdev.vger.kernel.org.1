Return-Path: <netdev+bounces-143339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BC39C217E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16355B2609E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65075192D97;
	Fri,  8 Nov 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RZgDJgFr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA1193418
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081720; cv=none; b=vDLFvakFKMAHUNi6v8uD2c+3hk24rJzTx3ocdKYZ+qMcwGtXuTdhAG1WkRNvANYNwYB9pOHPQE3NqZlZTygmcXnYj13KbA8SeMSHPJmsUJfXw4XF6bNkFsM6ss/6oFjgw/qWtCt7ypbvMYXtSuoTzV2UcSjr26XI4CGNLNp9xg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081720; c=relaxed/simple;
	bh=maNas1tfLJCEB8b9DW/v/YrPgpROv/SgU2lqVryv6sI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=exxFzzBgAXM0SQ9AMIL79ymU0T6TyR15jvCXfzHMUkvzsq3gVtYkOrMxYnbQr8TFEJcV8kOayd9azxG8EKa/H0+pcdG9OtQaM0IQ10n1IwyOzq6hBbtbjx/qKOizKMM+bpAakIQlqZzZJ/KEUBmrN4SNWm9JWKvTErvltZgqEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RZgDJgFr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1NT/LhWJMH7TWi7wIvb1C5LvUuNirE+1aQT+miF+hOQ=; b=RZgDJgFrruPLt+ir3V+eEVvbG0
	jbURhL8ofDTRQDXojTygNT6yeEXwpLMatskIHktXXSnag399U0Lms2oZ4iAAQu20cp01JgaKKcD0m
	me8Uz2bj8xrBZL2ZEeyMVGEh/ASkHD3UFDNH9oW+957CpFpcyTuyjN0g5D6eiPS8E8X3X/Twsadwu
	xGPkUi6fjw3ine0G0DF45yWiTf7FXpDQwnItprg9N/qsrpvcAVH+kkCRwHgdMk3QZ35aRU/BlqfGg
	8UPZXnzNKq6VmL45ACSwRR4brJAn6kqIpl1OJ/VYWkYJNNLeTlRhCqKkl6c+YDmPSRxZKFpp86hXz
	0zHoVc1g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60874 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t9RQo-0005aC-2F;
	Fri, 08 Nov 2024 16:01:55 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t9RQp-002Fet-5W; Fri, 08 Nov 2024 16:01:55 +0000
In-Reply-To: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
References: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/5] net: phylink: move MLO_AN_PHY resolve handling
 to if() statement
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t9RQp-002Fet-5W@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Nov 2024 16:01:55 +0000

The switch() statement doesn't sit very well with the preceeding if()
statements, and results in excessive indentation that spoils code
readability. Continue cleaning this up by converting the MLO_AN_PHY
case to use an if() statmeent.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index bb20ae5674e5..3af6368a9fbf 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1466,13 +1466,11 @@ static void phylink_resolve(struct work_struct *w)
 	} else if (pl->cur_link_an_mode == MLO_AN_FIXED) {
 		phylink_get_fixed_state(pl, &link_state);
 		mac_config = link_state.link;
+	} else if (pl->cur_link_an_mode == MLO_AN_PHY) {
+		link_state = pl->phy_state;
+		mac_config = link_state.link;
 	} else {
 		switch (pl->cur_link_an_mode) {
-		case MLO_AN_PHY:
-			link_state = pl->phy_state;
-			mac_config = link_state.link;
-			break;
-
 		case MLO_AN_INBAND:
 			phylink_mac_pcs_get_state(pl, &link_state);
 
-- 
2.30.2


