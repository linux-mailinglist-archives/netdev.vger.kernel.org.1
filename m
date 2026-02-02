Return-Path: <netdev+bounces-255795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEPDFPtsgGl38AIAu9opvQ
	(envelope-from <netdev+bounces-255795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:23:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A195BCA103
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 681393002F85
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80A2C21F7;
	Mon,  2 Feb 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A74BCzbh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5F2C08CB
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024085; cv=none; b=LdhDZNBhxcs0/wWxp1+DAs9ASrjZJ7vYBUD0tttTBz7nU9HaP1UEqtV3L0HMO60ykAFXFGWNt/spM3Ah3elgFqbaV8q6XgH2gJONf4gywWp3lEGcDr6OzorPJSeQomjbbRXCLnGwyAMuexK4FdQi/ARqft7eMZZbT6yyB3p6JNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024085; c=relaxed/simple;
	bh=fFtqSMHXb9fNhsIfufDnR1QvTKYu6ig+lcJhqVNRf+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ljVlI3qyBgZkWL3cawTl6UkPE00iaqR2zcwiakKEbXx1zcgEiTbFzd7KPUY7vkK4Q6pjDpxbCylMDvjpG7zvH07huYZKiLEIuwpKK8eTjQ89NG5YBaWFN6Jx0G2P1fJ2kWT6/h5lZMG2qPJXalWoc0nyPLqR1PSPXp0swvaaVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A74BCzbh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6581327d6baso5997000a12.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 01:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770024082; x=1770628882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=naVjf+oFoEPGbCcN7OBJPZpgIFxQpMICtFGQ99z2yDo=;
        b=A74BCzbhBSg9/nZaAETyOxSicTLoHOEZubPjgL1U8PK2HGaz7Gokyn88vt2MBsK9B+
         y768u1lQIDcM37EvqamYyvpR3lCpTHzkRSJuiUc1WLgUf043mMa9GvA13APqOuAFQ2m4
         XI6zRPt1v6989xcDJaFolPSZ4AV4zeOc1BxcgV9iw3qxD7xrhtd8zbxcXK6jCwUIRkBC
         Q0cPVuck8WtWhARXsGpalAIqoAJDdg7Gcy8JDJPJJZOtEE8RkLvJU/zOJ+GJVUiQmdkf
         68ifs5K6TUTGfUGq8sBldqb0rv11TMFA3NVMRE2pm6HsZRnfcSyZo6AdA7odW8upWsMN
         MP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770024082; x=1770628882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naVjf+oFoEPGbCcN7OBJPZpgIFxQpMICtFGQ99z2yDo=;
        b=N41mh/rIxaoD28yPSqNg73r2P23/8aws7DuzXhy96ZpV1V6xFSOWGw5c1j6OhnPky1
         0TBDzxehWML2NtAFlxgay1IOTH2ASj6ypwRP7OuItkR/b8i0ULA7fk2ZoO7RzUUPi5ur
         fWdwRWTe8s0NiTDUqjPZa0kVUMdIt42LhGsggSZVkiLeaEAa7oOb4CD4EvjgYAwWp1FQ
         2ORfLLXW5KFG7sXHYvooCkobZEdI9dfPaV2H3vUoLf7zGnvd0DlJNVad85EjtWAxoyl1
         F7Ata0MF6Vh6q61CdQUyIlyN8Q2s+s48NpmjyYCqfIRY77lxTiuGXc+8TDiP/UFs6QJc
         NRdw==
X-Forwarded-Encrypted: i=1; AJvYcCU4gafD1uXFmi8D9CqbJb7ZdCArsR4W4qVYWm7JVi7110kfqymgfQjxB7xM50wkDVBhXEU3hNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz134yuIoNHNwYpEVPLFyQUVlWzqdREhZgy+tqRc29Ts/zgbTY9
	ioXZwf9Yt++r3LqRvAQ4mUNZFR8YBKpJ1dJgZmWeSlIw5N+fhGBw3rlH
X-Gm-Gg: AZuq6aIpIDZrPZvIPUrixUki0ME3Jt9vAvX1x+wIa4dhUmwmcX1szTqIT4NJCZ5BNn0
	Idw6yHmPKE8E8BBhBmmmDC9y+L/qcYUVXzZOk3bo/L+eynrm+r+mJDuIN2U60TLaxg9pPhW59HG
	IPDQwqOF1tBseXPi+kdhYnNXoQ0nwzoqkm63opECgrAWkCbA518XsRDMAfOfVZ6QYQrBQ8egJiR
	U7kx7NzJn83TXWtr6RHs4kZ8BRT6gb+m67qAnqPdtENTexBoPzIAUa4FNdeMXarsZbZvHeu7FHM
	ZHNrMs6M4ymMnVM7u09CPZOmi6frNmgHqOqQ78FeQnC7i4V+nHlLc7Orh9Pd4Q2A+5Barf/oOzd
	kH1XjjEvBHYExCEGKcvk6EVKyavgvPOILm4lxewPXEZqGV5kBEe3gxrIZi4XhfdsRmg==
X-Received: by 2002:a17:907:ea6:b0:b8a:fc17:56e1 with SMTP id a640c23a62f3a-b8dff56b0d8mr752769966b.6.1770024081936;
        Mon, 02 Feb 2026 01:21:21 -0800 (PST)
Received: from gmail.com ([2a09:bac5:4e22:26fa::3e2:4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbeffedd3sm823213166b.29.2026.02.02.01.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 01:21:21 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] ppp: remove ppp->closing check
Date: Mon,  2 Feb 2026 17:21:15 +0800
Message-ID: <20260202092116.266568-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255795-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A195BCA103
X-Rspamd-Action: no action

The ppp->closing flag is used to test if an interface is closing down.
However, when .ndo_uninit() is called (where ppp->closing is set to 1),
dev_close() has already brought down the interface, and
synchronize_net() guarantees that no pending TX/RX in the network path
can take place. Thus, the check in the network path is unnecessary.

For file operations - ppp_read(), ppp_write(), and ppp_poll(), can
normally still send or receive skbs. ppp_read() and ppp_poll() are safe
because ppp_dev_uninit() sets pf->dead before waking them up, causing
both to exit cleanly. ppp_write() does not check pf->dead, but
ppp_push() verifies that ppp->channels list is not empty before sending.

Remove the ppp->closing check.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2: explain that the race against file operations is safe.
 - https://lore.kernel.org/linux-ppp/20241104092434.2677-1-dqfext@gmail.com/

 drivers/net/ppp/ppp_generic.c | 38 ++++++++++++-----------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index f9f0f16c41d1..c24a2721ac9b 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -142,7 +142,6 @@ struct ppp {
 	unsigned long	last_xmit;	/* jiffies when last pkt sent 9c */
 	unsigned long	last_recv;	/* jiffies when last pkt rcvd a0 */
 	struct net_device *dev;		/* network interface device a4 */
-	int		closing;	/* is device closing down? a8 */
 #ifdef CONFIG_PPP_MULTILINK
 	int		nxchan;		/* next channel to send something on */
 	u32		nxseq;		/* next sequence number to send */
@@ -1566,10 +1565,6 @@ static void ppp_dev_uninit(struct net_device *dev)
 	struct ppp *ppp = netdev_priv(dev);
 	struct ppp_net *pn = ppp_pernet(ppp->ppp_net);
 
-	ppp_lock(ppp);
-	ppp->closing = 1;
-	ppp_unlock(ppp);
-
 	mutex_lock(&pn->all_ppp_mutex);
 	unit_put(&pn->units_idr, ppp->file.index);
 	mutex_unlock(&pn->all_ppp_mutex);
@@ -1652,23 +1647,19 @@ static void ppp_setup(struct net_device *dev)
 static void __ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb)
 {
 	ppp_xmit_lock(ppp);
-	if (!ppp->closing) {
-		ppp_push(ppp);
+	ppp_push(ppp);
 
-		if (skb)
-			skb_queue_tail(&ppp->file.xq, skb);
-		while (!ppp->xmit_pending &&
-		       (skb = skb_dequeue(&ppp->file.xq)))
-			ppp_send_frame(ppp, skb);
-		/* If there's no work left to do, tell the core net
-		   code that we can accept some more. */
-		if (!ppp->xmit_pending && !skb_peek(&ppp->file.xq))
-			netif_wake_queue(ppp->dev);
-		else
-			netif_stop_queue(ppp->dev);
-	} else {
-		kfree_skb(skb);
-	}
+	if (skb)
+		skb_queue_tail(&ppp->file.xq, skb);
+	while (!ppp->xmit_pending &&
+	       (skb = skb_dequeue(&ppp->file.xq)))
+		ppp_send_frame(ppp, skb);
+	/* If there's no work left to do, tell the core net
+	   code that we can accept some more. */
+	if (!ppp->xmit_pending && !skb_peek(&ppp->file.xq))
+		netif_wake_queue(ppp->dev);
+	else
+		netif_stop_queue(ppp->dev);
 	ppp_xmit_unlock(ppp);
 }
 
@@ -2218,10 +2209,7 @@ static inline void
 ppp_do_recv(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 {
 	ppp_recv_lock(ppp);
-	if (!ppp->closing)
-		ppp_receive_frame(ppp, skb, pch);
-	else
-		kfree_skb(skb);
+	ppp_receive_frame(ppp, skb, pch);
 	ppp_recv_unlock(ppp);
 }
 
-- 
2.43.0


