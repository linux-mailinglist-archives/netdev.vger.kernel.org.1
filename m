Return-Path: <netdev+bounces-101709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7508F8FFD2A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F7C1C21807
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044B155C8C;
	Fri,  7 Jun 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TzrLoCrA"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A50A15534C;
	Fri,  7 Jun 2024 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745445; cv=none; b=NiXde4qiH3iU3SoB+QcJpsw+ANTiPLZrO3wAXwOfbwnDzE++Ebp8fX8Sljjglf7oANj/S3WW3RnrDQtxUjyPMYdzyObXZ4vWX6tj6nqrhInCOJkU3Z+VGinV6gD0Qe9jexGAramSslrqCke6wox4elW5+C2gNNjWl9S6sqgkrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745445; c=relaxed/simple;
	bh=dbwN0DIVgxMiq7n4Al8s9wVs8QGy4On0EgzbsGsk4bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpbIqjEWWffc5JBHB+DI1nOyd0ixQiPwd1DiUCDirgUmWOAUUzyq7ezabKWtwSFkB0nEM17Zc0DLCvzDlqcRh7GlRNxYwW/Ar88RUcKqRqut0FIAE/JIHMiR1eI6GP8NIqzhBAhD40V+CxGZiE86wGMO4fGMAp5MtsANjhlzu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TzrLoCrA; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C4F740012;
	Fri,  7 Jun 2024 07:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717745441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETcQo3/lCpjKaBqd4qw9hp9h/4mN/7uO4H2vg+CP6hs=;
	b=TzrLoCrAflV9u844zNVt1YqWjGwpLlIqz3LYdcdTH0k+fH+G/WM57A/cw8flZx2CK4Vf2x
	lOUSZJ3PVDz7DC8f6y2MXFRk5TeYLVOotOPfVIYuh/uH21sPfnCPccbuxjtO5TQYHXCOsb
	IaxGbll9JdOKzPH2gzWDNtxvvfHkpEhvf/j8eQqW67bmur0SWaIc2RJVkyepjeqfJryb+G
	Guv/wGmCpmYiu6xv0fCypYe4yhXvgYSkrD5HF55yGCnZ7a6hot0U02ZdsYaeru+jF1bUwE
	F5kPDZeEdXsc+J3iN527QyAV8+4r0y8wAxCTfP2TBV6vZwm37MGcZr073zUShw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 07 Jun 2024 09:30:24 +0200
Subject: [PATCH net-next v2 7/8] netlink: specs: Expand the PSE netlink
 command with C33 pw-limit attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-feature_poe_power_cap-v2-7-c03c2deb83ab@bootlin.com>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
In-Reply-To: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

Expand the c33 PSE attributes with power limit to be able to set and get
the PSE Power Interface power limit.

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
             --json '{"header":{"dev-name":"eth2"}}'
{'c33-pse-actual-pw': 1700,
 'c33-pse-admin-state': 3,
 'c33-pse-pw-class': 4,
 'c33-pse-pw-d-status': 4,
 'c33-pse-pw-limit': 90000,
 'header': {'dev-index': 6, 'dev-name': 'eth2'}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set
             --json '{"header":{"dev-name":"eth2"},
                      "c33-pse-pw-limit":19000}'
None

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 8aa064f2f466..1759b42975ae 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -938,6 +938,10 @@ attribute-sets:
         name: c33-pse-ext-substate
         type: u8
         name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-limit
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1631,6 +1635,7 @@ operations:
             - c33-pse-actual-pw
             - c33-pse-ext-state
             - c33-pse-ext-substate
+            - c33-pse-pw-limit
       dump: *pse-get-op
     -
       name: pse-set

-- 
2.34.1


