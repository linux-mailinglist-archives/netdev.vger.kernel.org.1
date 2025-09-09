Return-Path: <netdev+bounces-221312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD534B501CC
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA9B4E7058
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286B72BE629;
	Tue,  9 Sep 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="M6MlEpkT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B32741CB
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432765; cv=none; b=f283Zfuuknj71tcyX7mKfkYXIqNHhQ/IfFrOpEh0h52EyfOf/icqpj5olx5TVAH/DTVefbqtlabY9g3HqVDPpyUKhzXrwq6+zrZv3Tax03hC/uA8rqyKmXqWbXIyBWntWSfDB1lnKXrlcLUe1VGBD47PaZSGOPj+ovtg00/+cGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432765; c=relaxed/simple;
	bh=1ik2+BOb5CtXspTnkOnATV0GexyV4LjzehAivqeCUvI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=X3drcRmmK86j6DAFw6X9+0ia6tV3Si+LAMh6mJhONtmFwQhsh3oYIDRV7OG5J0PluDZRVGDH0AIL3OwTrm3MuuWWDKGYw+2+fqZsqBI7rDKTYUCA8UflkySmDwWKoLzVnO9KGe1khOM/ZHtzuxRi4R3uZ1UajPcRpjOysuaro6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=M6MlEpkT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6dFrsXGhUkEa+YJJueEOu8qtTIlgZpnKYWWVXObhov0=; b=M6MlEpkTgGEysPQ83o584zyM/w
	VOMbVCOz/NqxK1Dp945reKfhUjfi395OzKsThV2Ve7g6GKj4ds+VsT7tdkBg3WDMmakV4kzhTym8L
	Fji4Ek1L3rQJO/fdQXqi+awV43AfLj738n7A2wEGWhGo8wIRMbjmjalbGm4+6dfiuoU4CaRhmiK8m
	NpEoPt55YL5TDs83Nuq9leQqF20RXfwMe+Ld7VboSq+/IeLrcIkwZYz9YBjp92z4C69Xzev1lZeM6
	WEZDryRSIwqDJ0JocsZc+MnnZhrXjOjvH/WTyLM8/MM0HQvc7+GUdTUaCr5lu3oLjyBF2IKbrBMoM
	fTp2BClg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51912 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uw0Xf-000000008PV-3nNR;
	Tue, 09 Sep 2025 16:45:59 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uw0Xf-00000004IO6-0l5Y;
	Tue, 09 Sep 2025 16:45:59 +0100
In-Reply-To: <aMBLorDdDmIn1gDP@shell.armlinux.org.uk>
References: <aMBLorDdDmIn1gDP@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 2/4] net: dsa: mv88e6xxx: remove chip->trig_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uw0Xf-00000004IO6-0l5Y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 16:45:59 +0100

chip->trig_config is never written, and thus takes the value zero.
Remove this struct member and its single reader.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.h | 1 -
 drivers/net/dsa/mv88e6xxx/ptp.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index feddf505c918..9beaffb2eb12 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -424,7 +424,6 @@ struct mv88e6xxx_chip {
 	struct ptp_clock_info	ptp_clock_info;
 	struct delayed_work	tai_event_work;
 	struct ptp_pin_desc	pin_config[MV88E6XXX_MAX_GPIO];
-	u16 trig_config;
 	u16 evcap_config;
 	u16 enable_count;
 
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 62a74bcdc90a..402328b9349b 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -184,7 +184,7 @@ static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
 	if (!rising)
 		chip->evcap_config |= MV88E6XXX_TAI_CFG_EVREQ_FALLING;
 
-	global_config = (chip->evcap_config | chip->trig_config);
+	global_config = chip->evcap_config;
 	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_CFG, global_config);
 	if (err)
 		return err;
-- 
2.47.3


