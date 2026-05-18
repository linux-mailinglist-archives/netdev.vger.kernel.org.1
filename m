Return-Path: <netdev+bounces-288791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLX4I5JmCmq60wQAu9opvQ
	(envelope-from <netdev+bounces-288791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:08:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B948564AB1
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E76F3001FD2
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 01:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C6E1E0DE8;
	Mon, 18 May 2026 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdnEwHIn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CBEACD
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066511; cv=none; b=bguLU5IpJ73FK2rJZwOj1YO8Pe3x2P2n8xQA4XYh6sH2S+GynTH221jgyB4nd7RSQ52sImIRViV2owluavuiBtubUoXJcTTwI2kQxAPNp4ybPrauh9ICNI4EytiZFp/mY2yFAAF5OFwFRkP4uya6yD8yuNlJ8e/yQb3rqbj4vl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066511; c=relaxed/simple;
	bh=sP88QMBkB5WFeA9rGvVYUSHloFGHJ5YYBpExVoA4Bog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2wcoSMKUjEJECeGvQQohy+1C05My0wjYEnNJclA7WXiMBdVEi4l8Dkb7KtgBBAtI3L5YgVfAtMeqBntx3J+RXbj7+nJuMusU994ChBAouiGAAMFmHwNghtBTVQyYOcQ+SMriWnmvYdlI7lYydN1HaF+cT7dY50YBqG3qgc4prg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdnEwHIn; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1353c2f35cfso6941945c88.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 18:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779066509; x=1779671309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaqSbH53nnDwnuyvIsMb4KYjYHN14JziBMff4wFVy4A=;
        b=AdnEwHInhRDnBB7o+7e7Vk82z3ulbXnOJWi6jTztOI3xOKZsSdERUjFnT4B9lbdWIr
         RWDJAoiEy95Hab1qvMIu/9BdZboehRtNncsEHfI5zRUYgsYqrf6DXuXiiuwoAYbSzmau
         dycobeCg/2lQBO8/btPzP6ewbZOtzPXndlvwZnKw0zGaJUP+SsAC3zEnVXk8+PqjVJZw
         HTgU6s4If6xcsh0SKS+xCrcPjYvAcoylHD8krJH9va62Z9Jf0k61IpVC2Fdso9ZgwLsr
         afTtHLbWhpElsj/0X4yF8I3JkjP4BFVFC3/6BcOqP0kU56KhCz5Kf4ExyP9zXxXBDL8H
         tY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779066509; x=1779671309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DaqSbH53nnDwnuyvIsMb4KYjYHN14JziBMff4wFVy4A=;
        b=dqAqUlaVxKQr1/NSPHoYUkll8FNnwwoCk4uqpv80+tnUv8dbAtp+lcbAZCW6EWCvW/
         lbKt+JxyQdaR+tSxV6P63JfJajE4Rewo5QOGPwWp7Jm7CcXNt+F8OTuy3X5bKt+FOLZF
         O3fKTcxJCTqRs3l2OI+YzKSOq/9D3JwPIzC/ExdHk0gPfbQCVU/Zg33IKl7eBY42yq0Q
         FcWGod8FJTBK+1ZTzSwdME+CNv+My/SyioZzTWwuqzxrW16bDAs4jPUW8ZFykK+Woo42
         JRUCZO1hyixQnxBxenOp6p68HMs/8BZVM27IgQ6HlYUzloPPNWNt+ziyScwW8HIShTm5
         YhPQ==
X-Gm-Message-State: AOJu0Yz1DhV9b37dYm+B/r9pouvLl3SIobTqB4x+cSiecmghMS+s5752
	CppZUNVeXqMyfz4xVa51c1tamS+1ufCtNpQKa45uA10usmjQJvqQSFj69H3YbMP4La8=
X-Gm-Gg: Acq92OHGDGTLV1mDh3uInVET+j/eVGFY0dP3ratOXZQ6yuCYFswwTxoFFr6zTGQkkMO
	i0fCULDGn+6rb4Jf77pzDrTuHZeom3wUXxjDVgbkcZy2ZyTQ5tjMKV+8mqnnmWLDdoIJmrEBVH/
	abT5ExCaUy6IjMwPWc5tMU4zPv0DreyLzNM939GnQFOEHMCXCleUDgA8xB/oDP1gkRpNyi+hISO
	uZNyz9539dj+xQ+rIwdZgFCTga/tbmgq//OKHl544nILZPU+lEYxUAHpPojHfeV3OVWgrQ8HJzu
	Oz+8eZ+KX8mVqFuCHKOaEeI4K8jitUR7KfsTzBN+gOAGNHmCnhGZFSv7nCAAgZGAmDBkxiVK9/2
	wnnPbLBl+o8pDpA1+b1HI08RQn+oqqVg6RlWgYyMLoqfaZKdmlgN2nSDo1UH5JlFV1kLbTSldwN
	dHDjdPey/qP0mf5vQs6lfEbCxUGi5a/frCKnSi6gSWYorz5a4Hs0zO58pttBKAR2qeiEIwXcyxM
	qeLtjKedhPRUROmwGRjrAszCfnL2mNDgSQDyPecgAKbR2TfEqJtELdOHOOqhWPaj4Y9Nxnljvd/
	vzfJyZyH81pYdcLoog==
X-Received: by 2002:a05:7022:e06:b0:134:a710:d8f3 with SMTP id a92af1059eb24-1350473b10cmr6120759c88.19.1779066508697;
        Sun, 17 May 2026 18:08:28 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm18891372c88.0.2026.05.17.18.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 18:08:28 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RESEND 1/7] net: arcnet: com20020: remove misleading references to multicast
Date: Sun, 17 May 2026 18:07:21 -0700
Message-ID: <20260518010739.80979-2-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010739.80979-1-enelsonmoore@gmail.com>
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B948564AB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288791-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ARCnet does not support multicast, only unicast and broadcast. In spite
of this, the com20020 driver contains several references to multicast
in a comment and a function name, including a FIXME that it should be
implemented. Adjust the comment to make the lack of multicast support
clear and rename com20020_set_mc_list to com20020_set_rx_mode.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/com20020.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index b8526805ffac..f2fa26626a06 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -56,7 +56,7 @@ static void com20020_copy_to_card(struct net_device *dev, int bufnum,
 				  int offset, void *buf, int count);
 static void com20020_copy_from_card(struct net_device *dev, int bufnum,
 				    int offset, void *buf, int count);
-static void com20020_set_mc_list(struct net_device *dev);
+static void com20020_set_rx_mode(struct net_device *dev);
 static void com20020_close(struct net_device *);
 
 static void com20020_copy_from_card(struct net_device *dev, int bufnum,
@@ -194,7 +194,7 @@ const struct net_device_ops com20020_netdev_ops = {
 	.ndo_start_xmit = arcnet_send_packet,
 	.ndo_tx_timeout = arcnet_timeout,
 	.ndo_set_mac_address = com20020_set_hwaddr,
-	.ndo_set_rx_mode = com20020_set_mc_list,
+	.ndo_set_rx_mode = com20020_set_rx_mode,
 };
 
 /* Set up the struct net_device associated with this card.  Called after
@@ -362,14 +362,8 @@ static void com20020_close(struct net_device *dev)
 	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
 }
 
-/* Set or clear the multicast filter for this adaptor.
- * num_addrs == -1    Promiscuous mode, receive all packets
- * num_addrs == 0       Normal mode, clear multicast list
- * num_addrs > 0        Multicast mode, receive normal and MC packets, and do
- *                      best-effort filtering.
- *      FIXME - do multicast stuff, not just promiscuous.
- */
-static void com20020_set_mc_list(struct net_device *dev)
+/* ARCnet does not support multicast, only unicast and broadcast */
+static void com20020_set_rx_mode(struct net_device *dev)
 {
 	struct arcnet_local *lp = netdev_priv(dev);
 	int ioaddr = dev->base_addr;
-- 
2.43.0


