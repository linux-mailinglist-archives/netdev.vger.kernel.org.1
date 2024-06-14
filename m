Return-Path: <netdev+bounces-103634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322B908D81
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43E3B26635
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E1C3A1BA;
	Fri, 14 Jun 2024 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CO0J5ohb"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE3617BA9;
	Fri, 14 Jun 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375614; cv=none; b=NjdSjruhBl1ah3B+Il11ld+pCqBO/9aAXQjHXGeDCmtoNM62bPw502bGGy5+sbup/Vnu/HUaWxn98f3+XLT9bvHSk0q1IbAj/bfCWVJ9liLaIUYq3s9jZAcCbD4HVB4hxn1xa6K+HRMzFK1exULnTGEWL08/Q4T+xB6ZbdzDz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375614; c=relaxed/simple;
	bh=e5zYsTaJrk4SUYcjlDEypMWqkh919gIld7NRsaQ1M9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G68Ea+hbi20cGDNEkPtM2RG5pCMWB3sar3hXyiFYhqrW2JbTq8VmwoqEPKMWYBlhpcX88JIEbGWrk3vKEY1N4OGPcff3T4tGtJtQEt9zzzMd4PeukmWtUOk1lw0Ik+R09atWQd9o5nF+tfXeeGmVI78owc5lyMRy55UvY5XB3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CO0J5ohb; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52B431C0004;
	Fri, 14 Jun 2024 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718375604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QkG6RpZbzfXvfICRvD13tiB6Kv59EFMrLUsvNmv+uIg=;
	b=CO0J5ohbjq5yzJlGTqxHJLhQZY5o8ZEObuvS9ruKAdrIMPG5oyHDio1QDCgtHvzGt2SDDi
	LkUTWpB2z2FKGmiGRZpAUmHLCkuU9nJFMuB1TDdYvmtV/k/1m9k3sgpiVybpLDmSbhRkmf
	mA0o/2IW/e3qAqTh2LHbKimPsRUvMKSd5wZ8YDiPTsQVdd285x/O6kNPOgXOlLkDoj9n+Z
	6ZBLJ0MiWFYxT5u5yPrRod3mhtiVpl7y4fW8VZVvMGaMrwCHHmKj5Cwnzbds/YBNtdpQeS
	A+k/z36Jzr0mRhEFu1qz1DDE4AUQ3scPTdRdbWDxIBjXWADlbJcNLau+76eDIg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 14 Jun 2024 16:33:22 +0200
Subject: [PATCH net-next v3 6/7] netlink: specs: Expand the PSE netlink
 command with C33 pw-limit attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-feature_poe_power_cap-v3-6-a26784e78311@bootlin.com>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
In-Reply-To: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
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

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

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
index 0ff27319856c..d5a91265cb85 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -953,6 +953,10 @@ attribute-sets:
         name: c33-pse-ext-substate
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-limit
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1646,6 +1650,7 @@ operations:
             - c33-pse-actual-pw
             - c33-pse-ext-state
             - c33-pse-ext-substate
+            - c33-pse-pw-limit
       dump: *pse-get-op
     -
       name: pse-set

-- 
2.34.1


