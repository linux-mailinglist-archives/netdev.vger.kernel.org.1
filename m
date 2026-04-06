Return-Path: <netdev+bounces-275576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KZmGpOc02mrjgcAu9opvQ
	(envelope-from <netdev+bounces-275576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:44:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C255A3A3214
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30713300EAAD
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B593195FC;
	Mon,  6 Apr 2026 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="ZDUb8o7V"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D392DB788
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775475856; cv=none; b=Tg1RJByhJSNnjb6jyR6nVmDxArnRfNKgDh1Tp9dMFbwJMRLPgmysKk2da2Y6Zr3M2EbQpx1/RvQY24A3OOlVZL8V1aTJneX738nMpg5egXGxJtWx1WEqrU3pBpKTaiX6ptaE8xMKxryexZVmvnbCZxdg8BEiXNSYezOrqdhPA5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775475856; c=relaxed/simple;
	bh=WhpS/KP8N+h++LNKoLk4eu5ll51D156G/Un8Kyiwxkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2coJAc/4Da+BhZu5uDEi7PFlPUdFl+vLVWoMEFMIjmMhLWUgjsvwacMyyNqWFRQjnBY+AR7bI/9JKbq9iDhE6MY/oXNBgQPyRU80QfIm/zgo44nsFM9H7sesnzDdDiCvdhpuSjsqtXZ3sNhpblUCFn7X6PiZ4jV/W3qiBZ/jmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=ZDUb8o7V; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 01173240029
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 13:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1775475846; bh=LZtkpNfc7eXlrOjhYAu2H3N8qUxWCwLGFLDfIsl33OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=ZDUb8o7VDCq3kVPBPZJ/odFr9LcPjwKYrRYdPmfDawDboWktu2VV+X3iIeBeE1xO5
	 9SXHqGCZ8wL98crCjQVCFWUoZYDZsWaD1x+6DfIp56+/4/KC/W7K3Pv9/zAR7Qu6Ej
	 F8OpF2tW6hwiPaj5PBn+f+SnHgrXO346FQ3y4fiRhekkxdr35rVBVLKUek+ZZSCefl
	 bt/DTYNySVkD/Cyh6Upk/hvGDGFHDrydJolBp28m0M/cJEQJtIZv1cc8kglzZiVN9V
	 TnU4xtqWOs0LtDL40C/yyt5sxFgK7lt1USBsEwZeg7M611u/W+1BRuwckTDas35AVv
	 cLzJ1kbZkRhog==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fq6tC26qYz6tw1;
	Mon,  6 Apr 2026 13:44:03 +0200 (CEST)
From: John Pavlick <jspavlick@posteo.net>
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Pavlick <jspavlick@posteo.net>
Subject: [PATCH] net: sfp: add quirks for GPON ONT SFP sticks
Date: Mon, 06 Apr 2026 11:44:05 +0000
Message-ID: <20260406114352.69168-1-jspavlick@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275576-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,posteo.net];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jspavlick@posteo.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[posteo.net:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,posteo.net:dkim,posteo.net:email,posteo.net:mid]
X-Rspamd-Queue-Id: C255A3A3214
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Several GPON ONT SFP sticks based on Realtek RTL960x report
1000BASE-LX at 1300MBd in their EEPROM but can operate at 2500base-X.
On hosts with serdes fixed at 2.5Gbase-X (e.g. Banana Pi R3 / MT7986),
the kernel rejects them with 'no common interface modes'.

Add quirks for:
- Hisense-Leox LXT-010S-H
- Hisense ZNID-GPON-2311NA
- HSGQ HSGQ-XPON-Stick

Each quirk advertises 2500base-X and ignores TX_FAULT during the
module's ~40s Linux boot time.

Tested on Banana Pi R3 (MT7986) with OpenWrt 25.12.1, confirmed
2.5Gbps link and full throughput with flow offloading.

Signed-off-by: John Pavlick <jspavlick@posteo.net>
---
 drivers/net/phy/sfp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f1070eb0a0bb..bd970f753beb 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -543,6 +543,22 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault_and_los),
 
+	// Hisense LXT-010S-H is a GPON ONT SFP (sold as LEOX LXT-010S-H) that
+	// can operate at 2500base-X, but reports 1000BASE-LX / 1300MBd in its
+	// EEPROM
+	SFP_QUIRK("Hisense-Leox", "LXT-010S-H", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
+	// Hisense ZNID-GPON-2311NA can operate at 2500base-X, but reports
+	// 1000BASE-LX / 1300MBd in its EEPROM
+	SFP_QUIRK("Hisense", "ZNID-GPON-2311NA", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
+	// HSGQ HSGQ-XPON-Stick can operate at 2500base-X, but reports
+	// 1000BASE-LX / 1300MBd in its EEPROM
+	SFP_QUIRK("HSGQ", "HSGQ-XPON-Stick", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
 	// Lantech 8330-262D-E and 8330-265D can operate at 2500base-X, but
 	// incorrectly report 2500MBd NRZ in their EEPROM.
 	// Some 8330-265D modules have inverted LOS, while all of them report
-- 
2.53.0


