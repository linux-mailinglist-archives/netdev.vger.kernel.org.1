Return-Path: <netdev+bounces-306210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NA9zNjabT2qqkwIAu9opvQ
	(envelope-from <netdev+bounces-306210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:59:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A3F731521
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:59:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=UTltpLRG;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306210-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306210-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA2FF30B1DC3
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B2C40E8F8;
	Thu,  9 Jul 2026 12:24:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B24421A12;
	Thu,  9 Jul 2026 12:24:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599849; cv=none; b=f9IZxkmUxC3wTOlPwikX9NjjOP58IyKzcxytZtIOlQ3tCw03kgopqmDvpFuL2GftUGnvHHWaUvxSRJxQkrzzrWqlQr6yCI3QpuON5gDWXTUZQzqmQkScr4nBtKWLyQEOaAD2m98s8y9l3ICl3ClSsunP2U4tpqUrn62z/5aSIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599849; c=relaxed/simple;
	bh=Z2p6mTxexM5ayWvNEc+bvn3ualEgwR9TXegPvbYJdaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtnERQWOYyy5VjFQrAuvXzfZ/+zsNL3WkMHW0a/K4nhY532OcagT3PGzCkx/7nYQxk9aaRuk9WstX3soHBUGHqMponjkNlkMJBfuJcMaHUJ6LPnWnje4X+ewrHvQhSYIeFe/Xz4m3unCvcAKHk9InzzBTU346TLBUQyfU6WsWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UTltpLRG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7171F00A3A;
	Thu,  9 Jul 2026 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783599845;
	bh=otlFjEoj8m+amo7QVt6GIhwzNauV5M27a5j3zyxRS0I=;
	h=From:To:Cc:Subject:Date;
	b=UTltpLRGWJ19iX0BQYsrgpyppRlMSG+TIUgWW2knJjg2nKVbg44E2sRKvokfMQ5ad
	 AeheMyTTa3+nwxvuzva7vlgcw5c2i/JfUZJPHxbWBjLgmNKGRB2M/YerXqMKiGNjf1
	 XemSoFJ5YVTJz6SCZtFUoEpYOEyZaN06vCeibNms=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shaoxu Liu <shaoxul@foxmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH net-next] rndis_host: add overflow check in rndis_rx_fixup()
Date: Thu,  9 Jul 2026 14:24:01 +0200
Message-ID: <2026070900-denim-brook-52d4@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 49
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=FTegPm6uIQsGEinvailIqfu5TwgyFj6hWEU3lbCIQCk=; b=owGbwMvMwCRo6H6F97bub03G02pJDFn+kx58ehbpcXWdzz5V4d6Q84+E2q1TNx34Gq1zjEEq/ bjSBevnHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjAR3hUMCyb+T2bed3Fp3ruO G6ob/+rdef9sQxPDgg0LCkXuqd3gVNuYEqb9w81kfotCJAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306210-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:griffin@kroah.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shaoxul@foxmail.com,m:gregkh@linuxfoundation.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kroah.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,davemloft.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34A3F731521

From: Griffin Kroah-Hartman <griffin@kroah.com>

Add an overflow check to ensure that data_offset + data_len + 8 does not
wrap, which would enable an OOB read of the USB data buffer.

Assisted-by: gkh_clanker_1000
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Shaoxu Liu <shaoxul@foxmail.com>
Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/rndis_host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 5e39d05a2d7b..37d4865f5c5e 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -14,6 +14,7 @@
 #include <linux/usb/cdc.h>
 #include <linux/usb/usbnet.h>
 #include <linux/usb/rndis_host.h>
+#include <linux/overflow.h>
 
 
 /*
@@ -506,6 +507,7 @@ int rndis_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		struct rndis_data_hdr	*hdr = (void *)skb->data;
 		struct sk_buff		*skb2;
 		u32			msg_type, msg_len, data_offset, data_len;
+		u32			overflow_check;
 
 		msg_type = le32_to_cpu(hdr->msg_type);
 		msg_len = le32_to_cpu(hdr->msg_len);
@@ -514,7 +516,9 @@ int rndis_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 
 		/* don't choke if we see oob, per-packet data, etc */
 		if (unlikely(msg_type != RNDIS_MSG_PACKET || skb->len < msg_len
-				|| (data_offset + data_len + 8) > msg_len)) {
+				|| (data_offset + data_len + 8) > msg_len
+				|| check_add_overflow(data_offset, data_len, &overflow_check)
+				|| check_add_overflow(overflow_check, 8, &overflow_check))) {
 			dev->net->stats.rx_frame_errors++;
 			netdev_dbg(dev->net, "bad rndis message %d/%d/%d/%d, len %d\n",
 				   le32_to_cpu(hdr->msg_type),
-- 
2.55.0


