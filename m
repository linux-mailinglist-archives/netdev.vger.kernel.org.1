Return-Path: <netdev+bounces-264307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iADhHfRlqWlN6wAAu9opvQ
	(envelope-from <netdev+bounces-264307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:16:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 858352106E6
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 106DA312D1A4
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DF384244;
	Thu,  5 Mar 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="erX9PcWp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3262382368
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709016; cv=none; b=aRGwg58lr51jQeeVmYmIC6/wvniCYEK/mzCPHVyuQyQGQvYVr+mxuV2vd8iWJeEAzUb68gu25Dt41AK6Lf3nXnkvhepFvfqcYSGnxVutVwTnWNwADcZ/suOrnwHuVipfqT2vwtK3wfNri054cTeiCqcNpEuxkGCRgAjzMX6osyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709016; c=relaxed/simple;
	bh=x0d+Wu02y+l5RGSc94GT+Dvd2idg4Yr3hzETsqoCJJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4V50TqUUbvU89iaMpVICLZujIxt4NiD78jO6gnhjE8eL9K8VCzDr+WsqYFnNNtTzn6XxeEmQTgxfcrPhdYbCc8pYe1d9oEqv7PNmP2axnX0TUQY+HNMLUEXFpzu6mr0vTIxzLJT+frpAuZjvvrEXZNp7wtBRTvvmM8O/KrlUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=erX9PcWp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2adbfab4501so35605605ad.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1772709012; x=1773313812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQZNtnLYKtNFjePC1tTguFNpzwwlyU97MLzkI1UYxwc=;
        b=erX9PcWpi9kIRflxQSZzZr+oNnVgLBfq9tOHLT1QFAF4JG3N1FKbwwpIjx1BqcFffK
         XAK1Ez+vSamqo9JowGS0GGmke/Jbe3BQWNmT334A2EMnLAEitNJt6drluWMCPAp6CDLo
         NdRZbkU87zoqmE7ApQ3IxDlsSLPDL107iQMIwyCMgKSvAkad9VHZ1eNjFbix+EZG7RWS
         vgo6FpcmkH4/JmdzjDGiR7lnfK6wdb2PJ0KPAUrVuDUZbKsbeoTl0VobwrLpmesGbEO8
         GgS3uiDgDm3IR0HEnBPlsfFx+fjNc4/FFxwNsp7IK3i8h5DS7QFbxgZFqPYs+u2iOtNV
         fEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772709012; x=1773313812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eQZNtnLYKtNFjePC1tTguFNpzwwlyU97MLzkI1UYxwc=;
        b=mf2JJR4vPN8N3b1n/IzWnjuHpjkqt3IuyN9KdLngEQ8Y8+sBl0LwqvQH6UtlwV/VOr
         bMrGaq5PtveDPBOC5/tio21DwG8kQQVZ19BnQc+gkyvPgc6E62qouI6C7SZ7kpuwUC7i
         vke82TpwHKzEWppxJnrBVmOOQRaoliOL7AlYriFbzmKaWhwIPIfLL6lEOv5VdlKKxMVc
         rd+hEGqnqK8nNb206jWbGBRZCPBVYUaKRzYP5Y7SHN8IqXDjgyfCG9tNepd6jPT05HqX
         WPEW8fygnlh8fukcjECimF5jx9xAPmYU25aJNf34yYIbm4iJspd8qQpK1vzzixKGNwI6
         ImkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUItLks1L9hY5D+4CYGxhyA0iOASpGshKBs3RscuY/x9znWrN9eETvPk8OIZcjv+jKev4j450Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5peoRuJ4bwvkwxZ82mOm+3we/jXK5ElkMbl1z/1j+2CiSHpIB
	Xiat2iOhQUkrXgX2rU76ec5cE3iljAYTDlxF3/g9mPgfRHRh7jJsW9TN39b31xdjVAY=
X-Gm-Gg: ATEYQzyM0HaCgv2PN1Sd/Vw80w0aRvcQGc74eU/8pMFCGDxdrXiWlz7ctsKm3Xs3JeU
	BFvggK92vdUgnaO6nxg0kyP8CbxyXYU+pDi+n1iZIAfr3g13wER+HKRGmjQlDxMrWf9i9iQrbBf
	QgAAGyER/CnGFWGsRGmXDpWPST7xlDyihFpKjtvRfAG3P5Pa3zLkI/10cdnM6+22oWyvlKmUuyu
	sVvG6ggr2GFKKDt9eeysvyBUYyx0FA8sfcAuSRkibGHcmMcZIpP/1n5fM2TRnCvr0egX+OnvWny
	8pKPNOWyLZnL5LWDPJ/r18nz9NeZrNmsAtQtkm9eGUtvwVAeeyTqDTOkUPfLDMl2W1W4/mhbRXx
	f25jDs63Vk1BilW22k+btrUI+lhtAw4JxHfRkfhYQ/DL2EQJMqyF1wvmHb8TdKANG9PUPWv+0Qo
	+iYfQ2gjIHTkdvlSUQgJ/7aZmNSfukgTzBqZHd/mrMOOgJscYIsoTXAl6/Nd72G0PmcIyCPMtzU
	eBGyMuhZ7Mi5EjoGCRa6l8=
X-Received: by 2002:a17:902:db09:b0:2ae:3cf0:3aa1 with SMTP id d9443c01a7336-2ae6aaa73c6mr56519505ad.37.1772709012059;
        Thu, 05 Mar 2026 03:10:12 -0800 (PST)
Received: from cachyos.camel-monitor.ts.net (akacd-04p3-188.ppp11.odn.ad.jp. [210.237.248.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3e4e34fesm153501155ad.28.2026.03.05.03.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:10:11 -0800 (PST)
From: Kota Toda <kota.toda@gmo-cybersecurity.com>
To: Jeff Garzik <jeff@garzik.org>,
	Jay Vosburgh <fubar@us.ibm.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Kota Toda <kota.toda@gmo-cybersecurity.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Subject: [PATCH v4 1/2] net: bonding: fix type-confusion in bonding header_ops
Date: Thu,  5 Mar 2026 20:07:48 +0900
Message-ID: <20260305110751.167489-2-kota.toda@gmo-cybersecurity.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305110751.167489-1-kota.toda@gmo-cybersecurity.com>
References: <20260305110751.167489-1-kota.toda@gmo-cybersecurity.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 858352106E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmo-cybersecurity.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmo-cybersecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-264307-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kota.toda@gmo-cybersecurity.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmo-cybersecurity.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmo-cybersecurity.com:dkim,gmo-cybersecurity.com:email,gmo-cybersecurity.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

In bond_setup_by_slave(), the slave’s header_ops are unconditionally
copied into the bonding device. As a result, the bonding device may invoke
the slave-specific header operations on itself, causing
netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
as the slave's private-data type.

This type-confusion bug can lead to out-of-bounds writes into the skb,
resulting in memory corruption.

This patch stores the slave's header_ops in struct bonding and sets
wrapper callbacks in bond_In bond_setup_by_slave(), the slave’s
header_ops are unconditionally
copied into the bonding device. As a result, the bonding device may invoke
the slave-specific header operations on itself, causing
netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
as the slave's private-data type.

Fixes: 1284cd3a2b74 ("bonding: two small fixes for IPoIB support")
Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
---
 drivers/net/bonding/bond_main.c | 67 ++++++++++++++++++++++++++++++++-
 include/net/bonding.h           |  5 +++
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f17a170d1..14d3e5298 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1616,14 +1616,71 @@ static void bond_compute_features(struct bonding *bond)
 	netdev_change_features(bond_dev);
 }
 
+static int bond_hard_header(struct sk_buff *skb, struct net_device *dev,
+			    unsigned short type, const void *daddr,
+			    const void *saddr, unsigned int len)
+{
+	struct bonding *bond = netdev_priv(dev);
+	struct net_device *slave_dev;
+
+	slave_dev = bond->header_slave_dev;
+
+	return dev_hard_header(skb, slave_dev, type, daddr, saddr, len);
+}
+
+static void bond_header_cache_update(struct hh_cache *hh, const
+struct net_device *dev,
+	const unsigned char *haddr)
+{
+	const struct bonding *bond = netdev_priv(dev);
+	void (*cache_update)(struct hh_cache *hh,
+			     const struct net_device *dev,
+			     const unsigned char *haddr);
+	struct net_device *slave_dev;
+
+	slave_dev = bond->header_slave_dev;
+	if (!slave_dev->header_ops)
+		return;
+	cache_update = READ_ONCE(slave_dev->header_ops->cache_update);
+	if (!cache_update)
+		return;
+	cache_update(hh, slave_dev, haddr);
+}
+
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
+	struct bonding *bond = netdev_priv(bond_dev);
 	bool was_up = !!(bond_dev->flags & IFF_UP);
 
 	dev_close(bond_dev);
 
-	bond_dev->header_ops	    = slave_dev->header_ops;
+	/* Some functions are given dev as an argument
+	 * while others not. When dev is not given, we cannot
+	 * find out what is the slave device through struct bonding
+	 * (the private data of bond_dev). Therefore, we need a raw
+	 * header_ops variable instead of its pointer to const header_ops
+	 * and assign slave's functions directly.
+	 * For the other case, we set the wrapper functions that pass
+	 * slave_dev to the wrapped functions.
+	 */
+	bond->bond_header_ops.create = bond_hard_header;
+	bond->bond_header_ops.cache_update = bond_header_cache_update;
+	if (slave_dev->header_ops) {
+		WRITE_ONCE(bond->bond_header_ops.parse, slave_dev->header_ops->parse);
+		WRITE_ONCE(bond->bond_header_ops.cache, slave_dev->header_ops->cache);
+		WRITE_ONCE(bond->bond_header_ops.validate, slave_dev->header_ops->validate);
+		WRITE_ONCE(bond->bond_header_ops.parse_protocol,
+			   slave_dev->header_ops->parse_protocol);
+	} else {
+		WRITE_ONCE(bond->bond_header_ops.parse, NULL);
+		WRITE_ONCE(bond->bond_header_ops.cache, NULL);
+		WRITE_ONCE(bond->bond_header_ops.validate, NULL);
+		WRITE_ONCE(bond->bond_header_ops.parse_protocol, NULL);
+	}
+
+	WRITE_ONCE(bond_dev->header_ops, &bond->bond_header_ops);
+	bond->header_slave_dev      = slave_dev;
 
 	bond_dev->type		    = slave_dev->type;
 	bond_dev->hard_header_len   = slave_dev->hard_header_len;
@@ -2682,6 +2739,14 @@ static int bond_release_and_destroy(struct net_device *bond_dev,
 	struct bonding *bond = netdev_priv(bond_dev);
 	int ret;
 
+	/* If slave_dev is the earliest registered one, we must clear
+	 * the variables related to header_ops to avoid dangling pointer.
+	 */
+	if (bond->header_slave_dev == slave_dev) {
+		WRITE_ONCE(bond_dev->header_ops, NULL);
+		bond->header_slave_dev = NULL;
+	}
+
 	ret = __bond_release_one(bond_dev, slave_dev, false, true);
 	if (ret == 0 && !bond_has_slaves(bond) &&
 	    bond_dev->reg_state != NETREG_UNREGISTERING) {
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 95f67b308..cf8206187 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -215,6 +215,11 @@ struct bond_ipsec {
  */
 struct bonding {
 	struct   net_device *dev; /* first - useful for panic debug */
+	struct   net_device *header_slave_dev;  /* slave net_device for header_ops */
+	/* maintained as a non-const variable
+	 * because bond's header_ops should change depending on slaves.
+	 */
+	struct   header_ops bond_header_ops;
 	struct   slave __rcu *curr_active_slave;
 	struct   slave __rcu *current_arp_slave;
 	struct   slave __rcu *primary_slave;
-- 
2.53.0


