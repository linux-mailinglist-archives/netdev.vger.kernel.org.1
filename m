Return-Path: <netdev+bounces-87441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981C8A3222
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8CBB23352
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C57149DF7;
	Fri, 12 Apr 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gdK6tgxm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E40149C6C
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934920; cv=none; b=evkyIc48dUyDS5i6esrr3c6REeVNodane6vjJQJGVW2mzQJc9B9u+4E9P+xXeOZyFEzXDOfmZhr6v8Grz3bE9rpODTpislYY45YkFH/1EciKXfzPw6EuSTQ3ZUjCSL889RV7qg1+N+FuFgeBvNWbguOL1cdy0XNj8OrylEydcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934920; c=relaxed/simple;
	bh=fmEorI9pfcxlJrK9k/mi2zbeS1fZ02gd22peJrdyEaA=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=qRBARU4/QcuyWToqK0vkIqPphZrm17HrFI20ZjQZevzVP0ejOSCear5rDSuiNxNLx8o8ztWsTI6OH8dWIccYhloL4htHfX/u9ExRnUrI/ZQO32x1JWljsIb1SiKEuqcg+LraTFh3BVjwLa5BUPdm5W5bnsylvutZDMlY5Wuiuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gdK6tgxm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UJXPHShpCAbGPQKd0Y1p+AscoZJeLsEs/+RFxrl9k3I=; b=gdK6tgxmKl2GQoGs0Dm/ilnzfq
	+TlYSydfbHvofywQzsNFzTFu7dVV8J2kzFY7lh0Q+ckm67/UBjDp7eYjbqwf3EPr0iNhtsg/rrKnG
	gPutx14Q0oonKOCJNE+X3JDaW7M2BJxik8VR2IDr7SeZYJ5ImbPGuSA+BUBXwmvR8e1QaLIb2gY0H
	g9qlElZU84m8tji7wDPUQnjRPglJq8J1B0DRWSh5waEaGhRuHgnuXK4dIoZkPZAGkj5N8ktSoqECc
	E9wYGmz+QeKEDZyj5l80Z11l189i6Jrh9jCMe1ao5/+luG+ktcgD1BriZ2CXw0ZrvJZvK1iIsAM1E
	3WM/DBgA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42492 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rvIcI-0002bi-2M;
	Fri, 12 Apr 2024 16:15:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rvIcJ-006bQK-Hh; Fri, 12 Apr 2024 16:15:03 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: convert dsa_user_phylink_fixed_state() to
 use dsa_phylink_to_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rvIcJ-006bQK-Hh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 12 Apr 2024 16:15:03 +0100

Convert dsa_user_phylink_fixed_state() to use the newly introduced
dsa_phylink_to_port() helper.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 16d395bb1a1f..c94b868855aa 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2445,7 +2445,7 @@ EXPORT_SYMBOL_GPL(dsa_port_phylink_mac_change);
 static void dsa_user_phylink_fixed_state(struct phylink_config *config,
 					 struct phylink_link_state *state)
 {
-	struct dsa_port *dp = container_of(config, struct dsa_port, pl_config);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct dsa_switch *ds = dp->ds;
 
 	/* No need to check that this operation is valid, the callback would
-- 
2.30.2


