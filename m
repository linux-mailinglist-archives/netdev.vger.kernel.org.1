Return-Path: <netdev+bounces-177847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491AA720BF
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274F73BD62F
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EAC263C78;
	Wed, 26 Mar 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="oBlBfDc7";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="wbrd0Irq"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7F325FA31;
	Wed, 26 Mar 2025 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024285; cv=pass; b=YHW0ltpZfG6atwOvvu8JUP5OTBcGK/GqeVhUnwyqcS1xYKrNAZbT9Z0vhDaGxUt4kJXVDDt8HcgsAzEX3OL5Livlf+OgsZpJvaqETOkxRkJlehF3Gr3EliMB1wQLDbuwgU790pcsxOhdcPN08gIJ3vlA7Cf1KYstWv4TXeDSc8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024285; c=relaxed/simple;
	bh=EZzj8GfhRs6Y/tesFsPnu/VT+y24dgG6LsFxA2u6yE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8sZScm5EFHwURyiC4gsfoWE1og5FOR/exW5qheyOj3AdDVeuhKtvFkHWSgK+6x5uUjSg5rc1wOzcFDOc3AAghqWxdbN4ZjYbY7F6bFqBwuOmiXumSaxElWaNoJmXPMWvbj+W5ZfFpEfbb+CFqBaFrIM7Eabqy2U5Cw1SCuxJsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=oBlBfDc7; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=wbrd0Irq; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1743024094; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MdIeM9tS+A2F0cuy697DmxYZjPNB7JxmvaOgFdFD17QYi9RBqvsh1o4+37sdZnZSkc
    fePfmTkxjx+O6DnYYjNPXko7rhr9qeNOC3g8gUWERUpK3M3f6QTn0ShZ0d6c3QWerRTL
    woDCh266m9pSX311fx3s6X5D5cgKQl9bKuoQFEh1Sovivmq5RlvSvrzXknATzLRziNzN
    IvppzEpm/cP318+ycQZj+u6a+QIn+tsoPtCq4WfhN+oVPl9ocRJNVALJdr7pJh07llfp
    WqhynYAnq6fOeJHxMeG+CUxE0wCopid3FkLZ/mQagA8gXQ1FOj+G7eko0cpBI7kAd0Ek
    q6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1743024094;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=pFmcDmSQKkM+CI9mfKoKWcBh+gkKTmyRWMx+39HmNqk=;
    b=nw6KZmVV7HD8qT1anBbqKXbdzNBs55vptg/URAYa6RKpFvGMuGIxrkriU7drV8BWOP
    Oal4yA4uf0StXrcQ37TtQ6ZIwf8Oa+ZvM7qEje8yx4iDX04S3DAPG4HrqNSnEvVzd4xl
    QXxv0wY+g2u47wjSx2bHGZZhb6l6uvsYycfgniAgVbaXuap2pTAV0+Bz/pdP4fAd4Baw
    BrP0MSPpABA6s+qJMtmqoVjctS/kcjsMCovQKAaDhYIZvQT7ySJULThi1zigb7ZO4zBw
    xw39p+yQ3cDdevX4fHZsBJW+9/4wum9PS90/g8VT7FqhMaEDN5J0wpahT97iAkYDmvmV
    6EIA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1743024094;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=pFmcDmSQKkM+CI9mfKoKWcBh+gkKTmyRWMx+39HmNqk=;
    b=oBlBfDc73pneIFHeR8EupOBBWiY0t0I0ZqP5h9Kox0Wc9W68QQPz8jOyveGhPNSIXg
    Y/TlLhxxh9gYj40bZICwEfA00xT7eG9GFc3ijLYtuDV2qxVH+QbZe5TK38mUbZtV+EzV
    8Q1Byz47d3yntZAVtsioRz3JGTxst1iv/2LjmnBxkpn+VGYby3L14nrYAzVn9YKWnUPv
    uGfmKTo7wirPWgTKx1ux2ja0O/ft8j1DKpetTwNuQSKCNimUPBoEyb1VIJBw3n/Mzeeq
    +L0BfBvS6HXapTKnPMQS6fPBgv5H7cUwLYxzPkv3UtaNsRorWFRdmBpUri6EujevgDSM
    z+JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1743024094;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=pFmcDmSQKkM+CI9mfKoKWcBh+gkKTmyRWMx+39HmNqk=;
    b=wbrd0IrqogWMmE0me9+qPWF5Nxn5/5KMpVGebb4+K5anCJTSn/kmr6EwczrpJdgMsp
    zQ28vykFvziHz2oV7jCw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512QLLY1I1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Mar 2025 22:21:34 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1txYBp-0000ih-0X;
	Wed, 26 Mar 2025 22:21:33 +0100
Received: (nullmailer pid 100296 invoked by uid 502);
	Wed, 26 Mar 2025 21:21:33 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v5 3/4] net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
Date: Wed, 26 Mar 2025 22:21:24 +0100
Message-Id: <20250326212125.100218-4-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250326212125.100218-1-michael@fossekall.de>
References: <20250326212125.100218-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

rtl8211f_led_hw_control_get() does not need atomic bit operations,
replace set_bit() by __set_bit().

Signed-off-by: Michael Klein <michael@fossekall.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/realtek/realtek_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index e60c18551a4e..0fcc57ad777f 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -577,17 +577,17 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
 	val &= RTL8211F_LEDCR_MASK;
 
 	if (val & RTL8211F_LEDCR_LINK_10)
-		set_bit(TRIGGER_NETDEV_LINK_10, rules);
+		__set_bit(TRIGGER_NETDEV_LINK_10, rules);
 
 	if (val & RTL8211F_LEDCR_LINK_100)
-		set_bit(TRIGGER_NETDEV_LINK_100, rules);
+		__set_bit(TRIGGER_NETDEV_LINK_100, rules);
 
 	if (val & RTL8211F_LEDCR_LINK_1000)
-		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+		__set_bit(TRIGGER_NETDEV_LINK_1000, rules);
 
 	if (val & RTL8211F_LEDCR_ACT_TXRX) {
-		set_bit(TRIGGER_NETDEV_RX, rules);
-		set_bit(TRIGGER_NETDEV_TX, rules);
+		__set_bit(TRIGGER_NETDEV_RX, rules);
+		__set_bit(TRIGGER_NETDEV_TX, rules);
 	}
 
 	return 0;
-- 
2.39.5


