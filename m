Return-Path: <netdev+bounces-257891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8bEGDTFWiWlQ7AQAu9opvQ
	(envelope-from <netdev+bounces-257891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 04:36:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C96B10B644
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 04:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7912630056D2
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 03:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCC71E1A3B;
	Mon,  9 Feb 2026 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRp5hS9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A9145348
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608173; cv=none; b=MqQ+mIvOWGB4JEdARiADBgdc/PKgzQ8h/Q5g+ARP/d137dBkOqDx83i6f7NrsPope/ZuV6IxsVJeY/bSSrT8Pyp9SvTnmNDKFEcfTlMMPjFO+PXTeljVKfGBL3/j9Vyu99S3siqjvdGVaTEPNDyv2/GHDFjmlWgK+bdp7PP3BxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608173; c=relaxed/simple;
	bh=Zc5a2hdfGUaainCZYIazPgdSK5gsg+YgecuE6y5Wj48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1Nf0YSP48AAfVV2pLiEj0yBYtoZE5bPCPEF1zKSCMrTC3DuSOEteltTUxFxbZX9Q38gIVSW61Cl1pYCUthub3p/vEsmRtYVXzFPW7V51Cmx01yWA4l6uAlTc6u45a2vmpQWLW1URXb/Cqrlg273Cl55DiKmXZM1TRJSsT/6Pg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRp5hS9F; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b86671f87eso1998eec.0
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 19:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770608173; x=1771212973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RT02JK91ddCtADJwOpKsEqcnq5cQCb0/NUjhSVNWYnE=;
        b=TRp5hS9FUw8WAKENpFw/N9oRYvmDvrlHvdHO+WGmvJvaP45wOyoYzqkAQ/dI8Wp/ra
         wl4xeVlyM+N+dPcbtowGOiqr/N/z3Hp15zChv8ypp1Gslf3AvVDttpFVDK4EALoluzbi
         Yoh5G6owtko8xouC7nPLX/ju1Ip0/n6T3N9o8Qo6sm/k64Fdu8vV+5LI0sHpUvvyCmTO
         9U7j00Goe70ZezX71sIJe1839XTUW+69tuaKURxrswRsJ/9uQE644La2vwgf8YuhrKAW
         CjHRFBuGXokSE74CqlivSy1veS3ijuGRF1K115fSXpxOCOQLK55PxI/Av2wxVs3b5bol
         wcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770608173; x=1771212973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT02JK91ddCtADJwOpKsEqcnq5cQCb0/NUjhSVNWYnE=;
        b=lJuhH++3srrCr23/871MsXtpVudclFa0AkuIySI/jqNMZWpcAhKbwBl0Aa3vZXeNGS
         JOl17FErtq+eM82t7796NszDUWnAm2ob2c8H1CECcM9/NKHCNC6WHtCvgxVQWyEAR8id
         CYa5O9Q8nB4dQPJkcnDjEHnbiBqvKdJ6XyBU7hgO8z8obz7GM0qgtSOwO9AgW46wKdul
         Zz5G4SsJwtpktzlykY0cjNIowINboJQnIeltDmeXZvp4AvozZp2imf8+Qlo04R/+UTog
         c3X04NuvSIFru5oj59BIsUWd/YiqMB7LzS/DN6JyLHPekptgdnxdnTqP+rBTlENeuBPd
         u9nA==
X-Gm-Message-State: AOJu0YznSkN6AZ6GD/Bp+/WMZPz10BCv+HvO/H6E45GmoxCiQQldqd0w
	c+vlhSfmVNn/g0TGNGbp0gL8MeTs3do55wOwNdVmt/GLirdPhUp3wjImR9WhMe5h
X-Gm-Gg: AZuq6aIj4XHgXdHccM5Ft5t6wJIbuUHf8xlZckFPlBbsmCKwLJgiqlbNiS0u9NQUXVj
	6BxF+wmDdfv17U6QlqSO8S4ROh6oYlDD7VQeqJUTHvpEblayh36OrCvL1GyX+QAVyjhB1U9GPjB
	hS8YA2K8nkgcE4fH2D4SDDVU6WsVFpkbTknWXi6GjCeUTwxdycSPBRZEtrNWwc6C8gIeXInuvZa
	jpwL3b0J6srynNFFnMlkWaaBJDNJxDsoC83QszIUbK7faXZ5bBJVE2qBdS5fOo9DG1o1CNB2FZt
	vcfVQGD2hGsWy5G1n9Ss5LNX9p/mmdfBfhUbMGSUmy3dM7qXKpB9hHVG2lCNoA6kQpnLpTgYdnv
	vzzbZwOTBFF45mXTzMw8S/KT0JcFNgRZT2+zdtv15lHQufxQCRLwvx2Ll1s1SRyMBk2MDvkGp+N
	qmld12n1jxQufXaw39BBdRTOP2Nlmfs2PyNhDKIhZngV6MaKLyE86w8DdTDYqrMLg1UKlv5sfr+
	Sp4c63m4bGwfbvKRQ2peONHXED1bZ2mVmJIji4FRUfgtHV4oc8Mddm6kOp1KwOBOgk54qGak2JL
	cuZZwW4W
X-Received: by 2002:a05:7300:6408:b0:2b7:1ef:5867 with SMTP id 5a478bee46e88-2b85647973dmr4275149eec.16.1770608172469;
        Sun, 08 Feb 2026 19:36:12 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-120.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba6d1c61c3sm2010819eec.19.2026.02.08.19.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 19:36:12 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: arcnet: fix typos in comments
Date: Sun,  8 Feb 2026 19:36:02 -0800
Message-ID: <20260209033604.60033-1-enelsonmoore@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257891-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C96B10B644
X-Rspamd-Action: no action

The ARCnet code contains quite a few typos in comments. Fix them.
Initially noticed by inspection, then augmented using codespell.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/arc-rimi.c  |  2 +-
 drivers/net/arcnet/arcdevice.h | 10 +++++-----
 drivers/net/arcnet/rfc1201.c   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/arcnet/arc-rimi.c b/drivers/net/arcnet/arc-rimi.c
index 53d10a04d1bd..fb3d3565aa9a 100644
--- a/drivers/net/arcnet/arc-rimi.c
+++ b/drivers/net/arcnet/arc-rimi.c
@@ -185,7 +185,7 @@ static int __init arcrimi_found(struct net_device *dev)
 	lp->hw.copy_to_card = arcrimi_copy_to_card;
 	lp->hw.copy_from_card = arcrimi_copy_from_card;
 
-	/* re-reserve the memory region - arcrimi_probe() alloced this reqion
+	/* re-reserve the memory region - arcrimi_probe() allocated this reqion
 	 * but didn't know the real size.  Free that region and then re-get
 	 * with the correct size.  There is a VERY slim chance this could
 	 * fail.
diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index 6a5af0943567..1950df5dbbe6 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -137,7 +137,7 @@ do {									\
 #define TXACKflag       0x02	/* transmitted msg. ackd */
 #define RECONflag       0x04	/* network reconfigured */
 #define TESTflag        0x08	/* test flag */
-#define EXCNAKflag      0x08    /* excesive nak flag */
+#define EXCNAKflag      0x08    /* excessive nak flag */
 #define RESETflag       0x10	/* power-on-reset */
 #define RES1flag        0x20	/* reserved - usually set by jumper */
 #define RES2flag        0x40	/* reserved - usually set by jumper */
@@ -166,7 +166,7 @@ do {									\
 #define RESETclear      0x08	/* power-on-reset */
 #define CONFIGclear     0x10	/* system reconfigured */
 
-#define EXCNAKclear     0x0E    /* Clear and acknowledge the excive nak bit */
+#define EXCNAKclear     0x0E    /* Clear and acknowledge the excessive nak bit */
 
 /* flags for "load test flags" command */
 #define TESTload        0x08	/* test flag (diagnostic) */
@@ -194,7 +194,7 @@ do {									\
 struct ArcProto {
 	char suffix;		/* a for RFC1201, e for ether-encap, etc. */
 	int mtu;		/* largest possible packet */
-	int is_ip;              /* This is a ip plugin - not a raw thing */
+	int is_ip;              /* This is an ip plugin - not a raw thing */
 
 	void (*rx)(struct net_device *dev, int bufnum,
 		   struct archdr *pkthdr, int length);
@@ -257,7 +257,7 @@ struct arcnet_local {
 	char *card_name;	/* card ident string */
 	int card_flags;		/* special card features */
 
-	/* On preemtive and SMB a lock is needed */
+	/* On preemptive and SMP a lock is needed */
 	spinlock_t lock;
 
 	struct led_trigger *tx_led_trig;
@@ -299,7 +299,7 @@ struct arcnet_local {
 	int num_recons;		/* number of RECONs between first and last. */
 	int network_down;	/* do we think the network is down? */
 
-	int excnak_pending;    /* We just got an excesive nak interrupt */
+	int excnak_pending;    /* We just got an excessive nak interrupt */
 
 	/* RESET flag handling */
 	int reset_in_progress;
diff --git a/drivers/net/arcnet/rfc1201.c b/drivers/net/arcnet/rfc1201.c
index 0edf35d971c5..f2ec58d06fc3 100644
--- a/drivers/net/arcnet/rfc1201.c
+++ b/drivers/net/arcnet/rfc1201.c
@@ -235,7 +235,7 @@ static void rx(struct net_device *dev, int bufnum,
 		skb->protocol = type_trans(skb, dev);
 		netif_rx(skb);
 	} else {		/* split packet */
-		/* NOTE: MSDOS ARP packet correction should only need to
+		/* NOTE: MS-DOS ARP packet correction should only need to
 		 * apply to unsplit packets, since ARP packets are so short.
 		 *
 		 * My interpretation of the RFC1201 document is that if a
-- 
2.43.0


