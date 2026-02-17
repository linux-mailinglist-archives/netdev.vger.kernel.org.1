Return-Path: <netdev+bounces-259116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKc8El2qlGl7GQIAu9opvQ
	(envelope-from <netdev+bounces-259116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:50:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A10B14EBC8
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 234CA301D6A4
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8DB36EABF;
	Tue, 17 Feb 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="ooIlxA//"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB33596F1
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771350617; cv=none; b=bmdYhSlvRrGEWRl8iiar/5bKz4DgiTVcHQp2ake4t3oZhlCePDMahQ1ind+qrolrmv27l1h327pkI9FIcid8Q78KV8xfKDIZCoH4JMLWvWJl/GnZ3teYoKZ/Nyr1l+w/rjgMXu5y7OqySGIilLNlM9OIC9YtQmLe22hMHKEKwFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771350617; c=relaxed/simple;
	bh=IJAhYnN8LRPGZyhkVx59hrOzpdCmz9BMmhTWUhgh22o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzlRB6lbPSwALpCXAaD8XLFx+1cgW35SKJ/+1IFi6uTXUbLtyJwmSsuMlk9gt2avKUqtaI/d6fgNkXnPSDpf0SPTRE/Hj+0Cy5sOO2DqlbJWWqG50vMCneTcgxseBpg440KjGSxez7e/8krqb62LSkxFCp6PXvpLR75cJMN9D4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=ooIlxA//; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506a7bbe9d0so34180311cf.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1771350615; x=1771955415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tg4p4mgVuyaqYrmRkJ0CRO2fk4lsHW/JKl6dW870fR0=;
        b=ooIlxA//Od+3hxkecOWHnTyl4pYvWkY/cwH4IDod5CQd4/bT3hRwRgqZt4aTNvLIuQ
         X+3Qv7eTu6en1BYAavLRNRzP4pe3DVhVkoIO/dcUTGTaI4dF/apYDzW4eq9ilzvQqJDo
         nPNB9MY/8MnGQDJPRhjAb96+vGfFne99Ei0NXL1l136KdXCa3egd+qKoLICnVTOPYlsP
         DCAL97/FOcgslq5DZHY8+nLItFmW4VXQLXxLS9CbWPb9QmygZtnjwrCXXuwI7898rIB6
         Ki/ypNU40N5Hw1OUfs+iOUNjHKDQjLq5iM28waFY1czu9mS3xxmAynTMlw0t8ZVWKO9h
         LM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771350615; x=1771955415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg4p4mgVuyaqYrmRkJ0CRO2fk4lsHW/JKl6dW870fR0=;
        b=DV9JK7UmUwvmujonrdaDqvamJiEKn308Cu1/mxI5AgdzFCN4vGB6I8j/4/Ggaw86bU
         kiUqOz4/GAxi2s8JKxljQS+iqq+2SdH6JRZDkkojxi9xHRS/UNwYxNFvBzZQgvEr/yH3
         2Uvt0RWmxupbHvzykW6x+xd53hiUnM16xDNclAFnb2Y+PB/CREMC/BSjODYJZNcyl5jj
         6+qgQdUMApZRlBTTFlVJA7XJu3Pt7RkV0hIaegtQSuLZGG87TIzu/GOv/mZKlOvz1MyH
         NjwVNq+WsgW/rzbw+rTHd4bHhI1tIaXUC+L1H7UNGE8t+sRa3kdWCQejoboGPbJws710
         oqvw==
X-Forwarded-Encrypted: i=1; AJvYcCVel/5b2YMa805koedYJjzdJVWP0FLtapWplxd5fXWw4qDqdN+MU/Ni1biXnNCHhkHwiHPiAcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv+GmujQ+WyuMVcdrBKmkOI1xSmpT547Sojk0jjnWg/xdYZeMC
	QmBNyHBpDiHw/ZreqXOuUHmiGqgbCQyk4jazoeuqGppBWSNrU6rKnXnlAB5cI6CJsc4=
X-Gm-Gg: AZuq6aL7DHbg28AcbYnQio+/At/cttSUg9WqVsJqOGGVOHHBRZMbjkWxp7NU30iJFlc
	0cXXeS4zQSIVDxXov8Qg2mBiVCGXz0eH3ypujbjHKYp6eGb1qubvdPSARQO/N+i9/LO6AU27Nuc
	N8lH5m7bn+KYFKKR/C12DSf54ns8FExBEjbefnMZWYhIk2DdzpOgiE8l0YJqMEYqh05t/09dyD7
	jWbNdpzFFxG2tTDVEeRCZCYVV856im3Ygco5YniLKR3akO9jvm9HA2snjzMU3C1sJ8AO80DwQhp
	X0LRHsa8PSCXX0SfUB5sGvPpYR46/1aQzCKmbxRMBRDq4sEN2a60jPL9EUhmOLRUUW+Pd15pNEK
	QVCUjPLFc5/tzSoGnmpQr9nlFLQ19STbpfp0ZwsQnQb1x8RALhIK83/Go7egPeNLe25MygYUw9q
	7N2H8pdLlXYRKHj7RkUPKVxbEhesp4oeHG4rbiYT0YkvZ8G9L9kTy+UOMeyM/e1UCFZ5sQg/1oZ
	FQGnl6QEbhyoo1IW22qbvgjh260WmQmxTgv/OS/q34=
X-Received: by 2002:ac8:7f44:0:b0:500:d108:275b with SMTP id d75a77b69052e-506a8261401mr189490801cf.5.1771350615435;
        Tue, 17 Feb 2026 09:50:15 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847d9852sm186225731cf.7.2026.02.17.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 09:50:14 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH net v2] net: usb: kaweth: remove TX queue manipulation in kaweth_set_rx_mode
Date: Tue, 17 Feb 2026 17:50:12 +0000
Message-Id: <20260217175012.1234494-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259116-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u-northwestern-edu.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8A10B14EBC8
X-Rspamd-Action: no action

kaweth_set_rx_mode(), the ndo_set_rx_mode callback, calls
netif_stop_queue() and netif_wake_queue(). These are TX queue flow
control functions unrelated to RX multicast configuration.

The premature netif_wake_queue() can re-enable TX while tx_urb is still
in-flight, leading to a double usb_submit_urb() on the same URB:

kaweth_start_xmit() {
    netif_stop_queue();
    usb_submit_urb(kaweth->tx_urb);
}

kaweth_set_rx_mode() {
    netif_stop_queue();
    netif_wake_queue();             // wakes TX queue before URB is done
}

kaweth_start_xmit() {
    netif_stop_queue();
    usb_submit_urb(kaweth->tx_urb); // URB submitted while active
}

This triggers the WARN in usb_submit_urb():

  "URB submitted while active"

This is a similar class of bug fixed in rtl8150 by

- commit 958baf5eaee3 ("net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast").

Also kaweth_set_rx_mode() is already functionally broken, the
real set_rx_mode action is performed by kaweth_async_set_rx_mode(),
which in turn is not a no-op only at ndo_open() time.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
v2:
 - Add fixes tag, net prefix and Suggested-by tag.
 - Add explanation of safety of removing netif_stop_queue().

 drivers/net/usb/kaweth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/kaweth.c b/drivers/net/usb/kaweth.c
index c9efb7df892e..e01d14f6c366 100644
--- a/drivers/net/usb/kaweth.c
+++ b/drivers/net/usb/kaweth.c
@@ -765,7 +765,6 @@ static void kaweth_set_rx_mode(struct net_device *net)
 
 	netdev_dbg(net, "Setting Rx mode to %d\n", packet_filter_bitmap);
 
-	netif_stop_queue(net);
 
 	if (net->flags & IFF_PROMISC) {
 		packet_filter_bitmap |= KAWETH_PACKET_FILTER_PROMISCUOUS;
@@ -775,7 +774,6 @@ static void kaweth_set_rx_mode(struct net_device *net)
 	}
 
 	kaweth->packet_filter_bitmap = packet_filter_bitmap;
-	netif_wake_queue(net);
 }
 
 /****************************************************************
-- 
2.34.1


