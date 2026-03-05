Return-Path: <netdev+bounces-264245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KhNHjdNqWk14AAAu9opvQ
	(envelope-from <netdev+bounces-264245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:30:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F920E6C0
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E5E33005157
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B640337883B;
	Thu,  5 Mar 2026 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="apjlGpC1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C2375F97
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702858; cv=none; b=uIFJGAt9rpBgqzx9GH3TK0vErdqTMoFJVmaWgI/cQfQHppFzbJrJY8Y8RWwrywxc/FJIpRy8RXUp0zX1ygppyH25mem0OZLufHHtgCNgisaegUnp7wtJLeifcHgCIq6RoBXFDxdlRILkoBGtYfxbwOoLV3u/dzjiTkJAkkwYYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702858; c=relaxed/simple;
	bh=dCKksn63Iwao5/9PDtyfSecGgF0qBWe7qMdJfO7cg18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtXl2iwZbApmpp1kbZHJZu+YrIF7FfPQ2H47mxoaqdCmJPxQi1Kp2ax9rF6eg7inRvpwifDVs/2FYo3ws/S4GcM8phW21GAGXcCbfuiW4+ZaXRQ6VCDGNdRY/dpZe/BwwR4YGY5BKcZMUGVOFqM4jGlPO/mRIDj2qySUTIdbOCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=apjlGpC1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8272a56b91cso6586149b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1772702857; x=1773307657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlZr/f1YfH8ETuaOzpKLszu0Ah6qy/QnffRr2RQOGS8=;
        b=apjlGpC1DKHuqe/sczI7YkRV0po/S13RocNGah+AStAZNOCXrGSqHjvZ00tgjTxcYn
         fE4uou8TYqGAU3jtb1YUF57xYng1tv/+OyWVYO9jXAyQ7NfBkJhHIBq8Aj7nBx9Bbf1L
         S6RAemwfUM5ABtEkOamL8lCCUNFAv/EfvAPp472Oc8vj9DY2jAOVPgshsMWjthCt980l
         RdSBwBxYQSee2GQBpLfICXx3uFUGbqMrmi6NVH+Jlpin2rPEAskhu8MUdmiKfx5+fVyK
         4ObbIA3BvxCaK2DWbdvtq3DC1mzU9oECU1Sjoox8I9dbldPGzVhjSwbeotB26IUMjL7D
         pQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702857; x=1773307657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZlZr/f1YfH8ETuaOzpKLszu0Ah6qy/QnffRr2RQOGS8=;
        b=YQnZPbaAozrzFcGVwxrJ6pxZDuyp6w0HxiOztVS1HSq/n6J6SpsdJTVI7duG4mv19G
         WcfpzM2uKuBOhdBKhA3RMDsUY4q2AeVA37MmsbnGJhMNF7h8D+icyTn+KMZy+9zTBoRB
         OZ/3DPcBKxoyvORnLnAuCBM+PrsPTs9ka8EZsHxcqSzGvmW1XJcA2byvLKsWYgCjMcuw
         bhcyZFgZMhD6vqRjKG9aqW+O7UuDDh/2qWFdwCGM5lM5vB2s92IjtjuqKt2qUdszwy77
         YZNGxsySnsOQyizw5PpZgLR9+qMZ3BJhPDb2EbD19/SuEj9246jdMWVO+R/YaO6aMzlw
         PNWA==
X-Forwarded-Encrypted: i=1; AJvYcCViL5iXnoo4X+dcs8SFG5MyTspJKF0RVlpbsT4fMPh98E0Gt02JRB3YfZb7KaAv0w03lN0YJLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9h8kpIOgkThO5JMXT2EZFFDvkZswmWC2MHZSvSTme2b5j+P0i
	46Qjoot/HHkRRTcjiGTeQul3eSbkCCtqve/AOr5g1CajV6sUzLl4sAMhyX+IUjYY+d8=
X-Gm-Gg: ATEYQzyPU4JGn0pAvc/sCfC5PWYdDlqKjg+MghXtNeSyIp1rN8f6cdEAolnlX8xWO6y
	fSyEzyLYo+vZqmKNeb773wnN/mi4xCvTfY5hV8snKdIZHBasmpyxMvXtFNxhrHfKNQPb1Gmi5p3
	YbpoDytRw9fl4MggycbpJWVNYd99aCadWR7jX243XmeCoP0GWxH1wlUfx7ONpsm6tT5JxatnC2+
	8cO8GjJ5tQmW0UWSssH9XodAsEgEOKzVXOGuYaTwAmy3ypsVuQPQZOrSusS8/CHSD8YEv5+5lLo
	q7/nLvKqwYNXXstZj5kN5sA64R8lG+IRpoPv2VJKgZMfBqG6EEraoT2eCm2ZReRzsWbHkZ466dI
	Nt52OrH0zfpdU4Lem5nAgorVMjGSJJmYyEDRY6uV452ZQ0XXpAoPPNmwmmsrRguxHpK3nWb5Y/r
	HUkLtGY0n+66H8jZzYgxLVkFEL7Wh41E0Axycx195L07aUrsBgMMN1JaT+dn2o2+coEcMLXqbv2
	j/M4Z2Wnj+cdOny62PCCa8=
X-Received: by 2002:a05:6a00:2303:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-829727299b5mr5320380b3a.0.1772702856651;
        Thu, 05 Mar 2026 01:27:36 -0800 (PST)
Received: from cachyos.camel-monitor.ts.net (akacd-04p3-188.ppp11.odn.ad.jp. [210.237.248.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82974e75a4csm3606530b3a.30.2026.03.05.01.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:27:36 -0800 (PST)
From: Kota Toda <kota.toda@gmo-cybersecurity.com>
To: Kota Toda <kota.toda@gmo-cybersecurity.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Subject: [PATCH 1/2] net: bonding: fix type-confusion in bonding header_ops
Date: Thu,  5 Mar 2026 18:27:03 +0900
Message-ID: <20260305092706.145085-2-kota.toda@gmo-cybersecurity.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305092706.145085-1-kota.toda@gmo-cybersecurity.com>
References: <20260305092706.145085-1-kota.toda@gmo-cybersecurity.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED7F920E6C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmo-cybersecurity.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmo-cybersecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264245-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmo-cybersecurity.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kota.toda@gmo-cybersecurity.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmo-cybersecurity.com:dkim,gmo-cybersecurity.com:email,gmo-cybersecurity.com:mid]
X-Rspamd-Action: no action

Add two members to struct bonding, bond_header_ops and
header_slave_dev, to avoid type-confusion while keeping track of the
slave's header_ops.

Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
---
 drivers/net/bonding/bond_main.c | 66 ++++++++++++++++++++++++++++++++-
 include/net/bonding.h           |  5 +++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f17a170d1..2efad75ac 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1616,14 +1616,70 @@ static void bond_compute_features(struct bonding *bond)
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
+	cache_update = READ_ONCE(slave_dev->header_ops->cache_update);
+	if (!slave_dev->header_ops || !cache_update)
+		return;
+
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
@@ -2682,6 +2738,14 @@ static int bond_release_and_destroy(struct net_device *bond_dev,
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


