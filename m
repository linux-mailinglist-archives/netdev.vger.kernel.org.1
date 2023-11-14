Return-Path: <netdev+bounces-47667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D14A7EAF00
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0531828117E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB13E48A;
	Tue, 14 Nov 2023 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kX5BXEua"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B83E46A;
	Tue, 14 Nov 2023 11:29:09 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CD6D6B;
	Tue, 14 Nov 2023 03:29:00 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E88FC60011;
	Tue, 14 Nov 2023 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699961339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10SiBN/4Fj+hMV2c6j8AN3pqV9PZiveL87TjssWFLBw=;
	b=kX5BXEuakP80zkXB1Wo+QuoL8r+kM1cW+aefIK98bBhvLJMSosQHavmDq3e09P4HllWxNb
	4TRSSYMKpKf4FP5WEEtmSX9zfBFpijdKI8pTuVIkyaBThZEZ0FmU9h4j/ms6NhyiuKQJTc
	+nKVdDMD/G9P+W0XnNavlY5QLlaPiQxADQFaLIGHWUILied92JsK8LfUBs5tRsZRZgN4Pf
	2hSuEo8QXL4CMCGX9mI+HDCjPDGQHeL8c1gb25TXFtnDdxWqjyXC4894MeHWxvEcTB4h1U
	liJ/1geR+j5bLD153qeiB73bJRKh6mX+6U80y8EymPrIrwFIvf19wboU5aPOvQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 14 Nov 2023 12:28:35 +0100
Subject: [PATCH net-next v7 07/16] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-7-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Timestamping software or hardware flags are often used as a group,
therefore adding these masks will easier future use.

I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
not use at all.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/uapi/linux/net_tstamp.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index a2c66b3d7f0f..df8091998c8d 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -48,6 +48,14 @@ enum {
 					 SOF_TIMESTAMPING_TX_SCHED | \
 					 SOF_TIMESTAMPING_TX_ACK)
 
+#define SOF_TIMESTAMPING_SOFTWARE_MASK	(SOF_TIMESTAMPING_RX_SOFTWARE | \
+					 SOF_TIMESTAMPING_TX_SOFTWARE | \
+					 SOF_TIMESTAMPING_SOFTWARE)
+
+#define SOF_TIMESTAMPING_HARDWARE_MASK	(SOF_TIMESTAMPING_RX_HARDWARE | \
+					 SOF_TIMESTAMPING_TX_HARDWARE | \
+					 SOF_TIMESTAMPING_RAW_HARDWARE)
+
 /**
  * struct so_timestamping - SO_TIMESTAMPING parameter
  *

-- 
2.25.1


