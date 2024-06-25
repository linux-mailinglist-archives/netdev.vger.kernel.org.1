Return-Path: <netdev+bounces-106464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E49167F6
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236C81C23C8C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA2158D75;
	Tue, 25 Jun 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KcE8tkG1"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE3155CB0;
	Tue, 25 Jun 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318844; cv=none; b=PxFrEyr+UV5aIUFtpzcZJdS786H8LDe0Hq/1vSzxIxTvuVzxS4Beh/rOadyO/YWb4dkraZ4Epc2vT4RVWBOlAYKNVOzofv8KN1JQiDIBf+WvgGoYV++xE2psXXnAhJDgX77PKxJrcUp1Rh3bmTcjx2/Y57NorCR+EtTrwGU+FAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318844; c=relaxed/simple;
	bh=Vstn0lUPp1UJFhkhsxXrGDVz7OCH+xdIBjsvRGsXGf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o7g7pRTT/NZf2I5LZHDPO0nO5Fp3Kb5mKYafUD/8P4Muz4aYwkXdrU2e8bp7mFUQlhzEB8wL9M61YMxRRDkh1Q4+ApS0My6lFSMbJ4OlGzSk9YrdXpRi8e8PLouCbdzu9mtqQqSZajwKJk3vBUUDg/+w1kU9LXkts3qdTmlFmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KcE8tkG1; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E471B60007;
	Tue, 25 Jun 2024 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719318840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVy8zfvFuchZXTADt9+Utfhtzyk/IMrvLbt/U7ybOn8=;
	b=KcE8tkG1xXbsminqQp9xy2/Wke2J1hqs3oQ6JnOTh2FZZJIER1xat3UyNHjbJBPlMMWAjO
	+qa41ddwhS+iVlZEK+hcay9hWdJjTnJo86JEnxWsl24ws++DNKCBHoE7MJ84+6Frjezp+C
	cLHLz65OZl8vUMZxBlRp0iDeZK8/bHI68pxgBnuIt4ACJxqatfUaCXi3dkgoFkBQdttfl3
	rpS3vOC/uxbZgc+UcJGTPo6fAlhVuu2IAgnFmGRVmNksTx0YOcZrDpwYAsCopbVMALhlhr
	C/Y2ypADmdCZ/ZHEO/AdxCRugfUQCw7hvWOmgRrt2p7EhgNoDLvTGn1I201zbQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 25 Jun 2024 14:33:47 +0200
Subject: [PATCH net-next v4 2/7] netlink: specs: Expand the PSE netlink
 command with C33 new features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-feature_poe_power_cap-v4-2-b0813aad57d5@bootlin.com>
References: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
In-Reply-To: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 linux-doc@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Expand the c33 PSE attributes with PSE class, extended state information
and power consumption.

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
	     --json '{"header":{"dev-name":"eth0"}}'
{'c33-pse-actual-pw': 1700,
 'c33-pse-admin-state': 3,
 'c33-pse-pw-class': 4,
 'c33-pse-pw-d-status': 4,
 'header': {'dev-index': 4, 'dev-name': 'eth0'}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
	     --json '{"header":{"dev-name":"eth0"}}'
{'c33-pse-admin-state': 3,
 'c33-pse-ext-state': 'mr-mps-valid',
 'c33-pse-ext-substate': 2,
 'c33-pse-pw-d-status': 2,
 'header': {'dev-index': 4, 'dev-name': 'eth0'}}

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- Update c33-pse-ext-state and c33-pse-ext-substate to u32
- Add enum for listing c33-pse-ext-state

Change in v4:
- Add name-prefix.
- Use hyphen-case instead of snwke_case.
- Use yaml list format.
- Updated substate list.
---
 Documentation/netlink/specs/ethtool.yaml | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 4510e8d1adcb..492fad73bf75 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -20,6 +20,21 @@ definitions:
     name: header-flags
     type: flags
     entries: [ compact-bitsets, omit-reply, stats ]
+  -
+    name: c33-pse-ext-state
+    enum-name:
+    type: enum
+    name-prefix: ethtool-c33-pse-ext-state-
+    entries:
+        - none
+        - error-condition
+        - mr-mps-valid
+        - mr-pse-enable
+        - option-detect-ted
+        - option-vport-lim
+        - ovld-detected
+        - power-not-available
+        - short-detected
 
 attribute-sets:
   -
@@ -922,6 +937,23 @@ attribute-sets:
         name: c33-pse-pw-d-status
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-class
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-actual-pw
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-ext-state
+        type: u32
+        name-prefix: ethtool-a-
+        enum: c33-pse-ext-state
+      -
+        name: c33-pse-ext-substate
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1611,6 +1643,10 @@ operations:
             - c33-pse-admin-state
             - c33-pse-admin-control
             - c33-pse-pw-d-status
+            - c33-pse-pw-class
+            - c33-pse-actual-pw
+            - c33-pse-ext-state
+            - c33-pse-ext-substate
       dump: *pse-get-op
     -
       name: pse-set

-- 
2.34.1


