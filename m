Return-Path: <netdev+bounces-99059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 988D98D38D1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54858289884
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AEF47773;
	Wed, 29 May 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ouBbH0FS"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD01CFBD;
	Wed, 29 May 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991783; cv=none; b=n6wssLWy6s8XRnryQU1TROhgC50T1XNVE7Tlu+6+103CUZOn2tH8o7i5Op+JJVAjdKywVnE2xge9zpkTYKaxbfbmcPu8w5uL81Wb8ZaHymt7MZiYMovcLxfMnrOKzFtgCjndC6d4s6zG2PRhpmguhBiWOkYJC6UnuuuFvdTlN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991783; c=relaxed/simple;
	bh=2f/QLHGzuJUZ6zQvnX/Y4xjvJXn719xlzn0VYbhQgrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TcnnIVgB9xnFgwlveZknhcUTZgOCfkjTt1c+9Lg3BlHr0KmBEN+bEBqwtRHBnPPO+yU33C8eQ9+2ar2wRGqhNdYwzn2od189z6AjBoBZfFY2Y37GJPd9OD0NqogvCO0hekXW9hd84mJ+RUOUVV5OjlNd4mlDHKlzq//uEsFuxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ouBbH0FS; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64DCA4000D;
	Wed, 29 May 2024 14:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716991779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxIoAfqFX0T8wOLhLA9A2kck0mXlzlBcVMqS+3gO9GE=;
	b=ouBbH0FScl/DZnMpHD0sZqHtBM13Qz58++oJ4wGAkr5LHsXqEM8flO6eVFXhhG4zX1ddpb
	RUSxLR03XlPC6k53S4CPlJXTLqzLT75KfMtzd+pt2QkbKTqSHdVAl9lch9L9i7ser9vPUJ
	m+smJPHLhr/fNvbPAXix6ADUhFVM19xRxOEKRZOrBoBu/7sRKwr2+8rHYSnkSNY12OzJ16
	DII0C9IeveLaN0l0LS/s1cZ60krd+zMSURdDtrJnClwrELtEKBffGTJjvCjL7UsQ+OqMw5
	NWuUx8pFXECAcfxv0BKeDMa1B1ga75y7LHbYIYK9HvtvyDkivcnwRHuUmJsypw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 29 May 2024 16:09:34 +0200
Subject: [PATCH 7/8] netlink: specs: Expand the PSE netlink command with
 C33 pw-limit attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-feature_poe_power_cap-v1-7-0c4b1d5953b8@bootlin.com>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
In-Reply-To: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
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
{'c33-pse-actual-pw': 400,
 'c33-pse-admin-state': 3,
 'c33-pse-pw-class': 3,
 'c33-pse-pw-d-status': 4,
 'c33-pse-pw-limit': 17900,
 'c33-pse-pw-status-msg': b'2P Port delivering IEEE.\x00',
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
index bb51c293435d..40c679bddd99 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -934,6 +934,10 @@ attribute-sets:
         name: c33-pse-actual-pw
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-limit
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1626,6 +1630,7 @@ operations:
             - c33-pse-pw-status-msg
             - c33-pse-pw-class
             - c33-pse-actual-pw
+            - c33-pse-pw-limit
       dump: *pse-get-op
     -
       name: pse-set

-- 
2.34.1


