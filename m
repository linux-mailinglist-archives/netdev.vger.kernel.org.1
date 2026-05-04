Return-Path: <netdev+bounces-283978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLeNHkDb+GnG2QIAu9opvQ
	(envelope-from <netdev+bounces-283978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:45:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201B4C21A4
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F04530189B4
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EABA3E4C95;
	Mon,  4 May 2026 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="aZvd5+BX";
	dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="Juzjj/lg"
X-Original-To: netdev@vger.kernel.org
Received: from out-ip0051.fra.mailhop.org (out-ip0051.fra.mailhop.org [18.193.30.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AC3E558E
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.193.30.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916663; cv=none; b=HPaL57tKA9W97VBFwJ6yKc2TExi0qu6rv6HWPucVaUBOqsFV8RSmLcaNIMA0qyZa7+ULQrhjIUgOvZ5BQfqM8epf+RE0z9t1u4+uGOC7omnjQYhtPOlyfg+LFH3CSkmaBP1cVLQNHu9Uem9MiLHXBXae5UD8urxx1U5mf1qSPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916663; c=relaxed/simple;
	bh=pgyk1XkkcAVDb93IMh8jK3qZMEbn5gs9m//IXWxJBWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nk1CiwSz9NqU7Fq1GSppPX32Yke9pv4sZMfaTgGBxc1FfRMAzLyOLK82piRLka8CahGqCTZqctadzmbrqXiY4RFuYV1IlcZ/AInIbTp3gYn/GV+InBCgSJ8t6xxmqA0MgZZa1iNqEeSjOEJQnP6JcPA3tECLBLVatDvfkCUS30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=aZvd5+BX; dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b=Juzjj/lg; arc=none smtp.client-ip=18.193.30.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=X3J19TUk0OReXY5Z/IXa99Q+WScavHAWc7VKN6O0XgE=;
	b=aZvd5+BXAJm1lfZnCC1OzeFBIms7xOprBxHPhmpyMYffLcs65F7rhhYGf/W6iO6YwBk0kkQm7mRl7
	 JZuz/9w5nGiEmnPcOXZRZpupO5EEJS3GoNkS1fdxFMYa0a6ufvoVGPO/wg2KCHlFIe1WnvDf2tk/0j
	 UosNl3jXOS/Dey+4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=X3J19TUk0OReXY5Z/IXa99Q+WScavHAWc7VKN6O0XgE=;
	b=Juzjj/lgGc9mC+8V6q34/F0PuU9MCH4XNa2VI+zmQnJEaR1pRbHvxJUKA783FIk3Gt8knh1IB5oR6
	 /+BDhtdzsybzQsYwd/vWPkgRnaL+4TB9nqilK3gs/qG/yUjsYUSGKciN2kC7ek3pU4DmQVu1720WCL
	 F5Rd8h1SRVnqbv3269gk4gjSL9bYBQ+GgDys/LseAujRk0WldIK1cz9yI3shlRjUOSlxrA09Ql9D6o
	 gId5veNMrjum1TOCojE8UCaqawnkur7myt9cN5Ft9WMOdyrsSBKG84SXeMo+EX3qI3waejJeXNGwhR
	 LVeqVBvgeWf+UK5a21Uw/DeKY5JDMJA==
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: daf647d2-47e0-11f1-8ef6-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: daf647d2-47e0-11f1-8ef6-f54febe22707:13
CFBL-Address: prvs=058485b737=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown [20.82.50.241])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id daf647d2-47e0-11f1-8ef6-f54febe22707;
	Mon, 04 May 2026 17:44:11 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with ESMTP id 99C25805244;
	Mon,  4 May 2026 17:44:09 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 76E5160B7D47;
	Mon,  4 May 2026 19:44:09 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH net] net: wan: fsl_ucc_hdlc: return NETDEV_TX_OK if skb was freed
Date: Mon,  4 May 2026 19:44:06 +0200
Message-ID: <20260504174406.2229693-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.52.0.120.gb31ab939fe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8201B4C21A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hitachienergy.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hitachienergy.com:s=duo-1630306886989-947ac67a,outbound.mailhop.org:s=dkim-high];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[holger.brunck@hitachienergy.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283978-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[hitachienergy.com:+,outbound.mailhop.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outbound.mailhop.org:dkim,hitachienergy.com:email,hitachienergy.com:dkim,hitachienergy.com:mid]

If the skb was freed in the ucc_hdlc_tx function and the packet marked
as dropped we need to return NETDEV_TX_OK. Otherwise the above layer
will try to requeue an already freed skb.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 7af558780bdc..6ce539151618 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -360,7 +360,7 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
 			dev->stats.tx_dropped++;
 			dev_kfree_skb(skb);
 			netdev_err(dev, "No enough space for hdlc head\n");
-			return -ENOMEM;
+			return NETDEV_TX_OK;
 		}
 
 		skb_push(skb, HDLC_HEAD_LEN);
@@ -377,7 +377,7 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
 			dev->stats.tx_dropped++;
 			dev_kfree_skb(skb);
 			netdev_err(dev, "Wrong ppp header\n");
-			return -ENOMEM;
+			return NETDEV_TX_OK;
 		}
 
 		dev->stats.tx_bytes += skb->len;
@@ -390,7 +390,7 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
 	default:
 		dev->stats.tx_dropped++;
 		dev_kfree_skb(skb);
-		return -ENOMEM;
+		return NETDEV_TX_OK;
 	}
 	netdev_sent_queue(dev, skb->len);
 	spin_lock_irqsave(&priv->lock, flags);
-- 
2.47.3


