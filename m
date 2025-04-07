Return-Path: <netdev+bounces-179852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4FBA7EBFC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D2344525C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5444C25D55E;
	Mon,  7 Apr 2025 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="mzIasaPF";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="iFnOqnCz"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B3F21ADC7;
	Mon,  7 Apr 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050514; cv=pass; b=k6jB1rQlyzJmnvxaej8eBHxNaVE4mp6awlDbXCqDW8IqHCVfsLz2eyg6yfLauHgINOJpefm8B8nNwivogLf7rJkfXydQcVvX3MO8Y0M9OsfYSxwXO5wqdfwdzJwcaRtCFQBU7dovNVKnUK+Viq/nlzWt5XAAZfcsNlOUFbtq/Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050514; c=relaxed/simple;
	bh=EZzj8GfhRs6Y/tesFsPnu/VT+y24dgG6LsFxA2u6yE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWnlSb0Oy/614u+Rpx3Ab15EY3Cfo5QqcpFm7DdZyqArO2AFCuhaueDlZKpZPM6GL6gBJYCIFl0pw1degqOaWetv1ZIdIImiNCZ6S3ECoPWTBe3GLnZEKNXI7SDiaucQ0jjbu7kVVt6kialtiPcLSgGbIU9XLJpefriF0OMKZf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=mzIasaPF; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=iFnOqnCz; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1744050146; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LwjfKUrCTR/Fcjo/lU1bbGqOwEwlC5AV15VUnae6+42bhL9TvkRH8CJ7JsFYA3/FWf
    LGYeNLx6SjPL1LMJJO1Qse/FApn3aeo/YVoZ9pkpQFamWRVtUouOneAbe7fML+XTGdHn
    HqYiUxggL+UC+PdT9ufC1JSlG2xKOODDweK656DU7sjcQ57X+zmmeon8Lpk8Ah8osXIh
    PhZkDxpfkLslVJTAD0GLrmYo0tTTBfjQevtM9eNrMoypYkyqVg6MPfyq90lAvF/Crz1f
    /5e1fdF27wTDD9fqb2XsrOhlTFSmw28D/Bqjj5oLQcLsNYPA1ZAtQukuCJOrSfPx1koH
    v1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744050146;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=pFmcDmSQKkM+CI9mfKoKWcBh+gkKTmyRWMx+39HmNqk=;
    b=hokXuCPCOtSP5fQ1XMPh4SiGxtEBhijJzvC4WG0jilTqD4Bfzq2u38guB0Tbn+SpNf
    JzVZSL/XY3US+K61QMA/zHAl+mzxA1307eLtpJqj93P3HaHR7M4c9znqi5YrJnQ1Zsj3
    1n9d0hbR2fxO5PQcKVwav1JZQ1gJqGklk6jk4Ra9sUPe7hfaOQ3L9pVfSf8DPCeY/wDs
    gHrq6LPk0iArcIs3G3aLJ1y+ky5oQELig1dGovP3yr8iFZuvoukFdDTVEr9DcUTwi7/N
    YDbT0ikw1qhohcl3Y0ZEz/et/8r1PiIA9E2Xrk9twGTAZHj+O3YKrYDbbcw9/KbRpCAk
    tJxg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744050146;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=pFmcDmSQKkM+CI9mfKoKWcBh+gkKTmyRWMx+39HmNqk=;
    b=mzIasaPFbqz86bcyWDskLkYhzrEhmww6nELJcxxE7vnwDa8Za5aJBHwTkyNQw0N0nn
    EHOQUYCQWZtYL5uNFuGIScSjuqRsQY84BYTI9Ce+5YElORujJjP7Su22QR8Mw+WMaVVR
    JXc5XtYCVUofgGjArUjOQad3qbsqJHCrKxB1L86eR98sapLec1ban9rnGmQtq54AfHO4
    XFzMN0hNcQJJm0cEBJPC71KCy9qyFRI+dyYsQkeFI3accVoax3gQcVUSv0EevKHxXlRZ
    jBqcmSITMXrKwfcP72NpWveZmi4S50S0RuBYmerjGgN0hN9S/2tkeRzg9xtN4WTP+gop
    1rZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744050146;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=pFmcDmSQKkM+CI9mfKoKWcBh+gkKTmyRWMx+39HmNqk=;
    b=iFnOqnCzgFJYkqRFYF2Hajo3SaNW07a6LniQLxxDUUsSYhlJVQvpCtmZvD+3xZPtJS
    dzmBhvGjf+P8ZSLoMvDA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35137IMQyOr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Apr 2025 20:22:26 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1u1r73-0003yQ-05;
	Mon, 07 Apr 2025 20:22:25 +0200
Received: (nullmailer pid 15065 invoked by uid 502);
	Mon, 07 Apr 2025 18:22:24 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND net-next v5 3/4] net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
Date: Mon,  7 Apr 2025 20:21:42 +0200
Message-Id: <20250407182155.14925-4-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407182155.14925-1-michael@fossekall.de>
References: <20250407182155.14925-1-michael@fossekall.de>
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


