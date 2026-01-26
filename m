Return-Path: <netdev+bounces-253325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOilF9EGd2lGawEAu9opvQ
	(envelope-from <netdev+bounces-253325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:16:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DF68469E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5F84300CC2F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EAA26B742;
	Mon, 26 Jan 2026 06:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgNkYHeC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DF26980F
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408124; cv=none; b=jsgCo0kzIhhyJtHHqQh6aDXPT3ZsJ9PxCRYJJhIT2Dj9YWZgFirkvNwXDQke3tVxx4yqOljLSpAV3LrDejqJQlkIbX1F5HU3UOhjnOgwrkp2lA62uFrlCr8XNJsLSE5wsx6824KErQ34BpK0U3kC/hYhsMNZgZbGmBMfuABMigk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408124; c=relaxed/simple;
	bh=2wpssjHxjFftU46L2ct0nhACoK/GI1O4qsjjvjba/KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XM2eTKQolkEuzOwIOmGi3Tas7ejjnbATO30j0NvnxzC5pOptxSmTQz6SP4w82inhIiBzLThR2MRUizVq9RRDhu1vCD0aoibkg/g53gggqkY8mLIPnagwnRJfxiK4pxyBVpOdGrWkxSzN6ZWFWQl72lBLy4NXC82PHTi3Agb9Cxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgNkYHeC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a12ed4d205so26945615ad.0
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769408122; x=1770012922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JJjobB6PNdLChVyacJVt2J6BgkT8/TCPgnTIdLgQN0=;
        b=IgNkYHeC7XSUQptfx+B5q/3ant5jB30Mx8nJKeX8vtoytk0ThFLADBTRGj2eJJzIMk
         aonVtzLX0x0kurRn4T+POU5WmWvhcQL350TyOmlDYRY871NboXfVQSaDOZneoS50ItXz
         Kt9qtUqi4dmBXsPA5j/pCK5+jlXNyVNgtJdXDJ7IHoqm0AwDDtXdQ6DHnujICzc9Vaba
         AUE2RrkUGyiQb2FHfVFEsV5+mV7OPfQ1oqV/gyyIJUZwLAqekzWE1sL64tKs+qgwHviX
         E1jsxCs4dJgJrEAfVG2Sd5B+4NaSdSSiH1sNwyPJzBeTW53IPzmiwTcD8b87cEe5SU81
         Vyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769408122; x=1770012922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8JJjobB6PNdLChVyacJVt2J6BgkT8/TCPgnTIdLgQN0=;
        b=hPvNDqAHgyHkjBDKKQt/29FRCuJi3NPp1DRObE89YbIUnPOEWiARCLryHy9e7FCp1a
         y8fqKRf0p7Aml4+sNKVYk75pN/PDK27SBUOjGzZjucxzX0TH8A8C03+QIMNxKpJC3Sny
         MkS4/EPkk3T5dnnuMcHNNU56ersl+uH7zzssebbaea3MSYfEJunPQdM1sgtXDPyVZWPM
         8KL0EPENwAi7jDAOvHpvdmZAUPT9IURUlK+z8MU5pp559hqo9e+jG1aviyRpMvl2ZB3v
         FU6zMevQmi5S0/TOqx03ubb+JReosU/TKy/W1P977rAAeZjj4yM2qWhKJWsRs6HT7ZVr
         zFOQ==
X-Gm-Message-State: AOJu0Yz26d+u2Wnaxo54btI2lSKn049EVlRlA9j+E2c7NiR2jZJELTXx
	lgraM6LtkEbfiIv15FTaqPI/pmf1bhK3tkb6Y7SEpUH3D3+6K+kKMeHkIJjzuQ==
X-Gm-Gg: AZuq6aLmUTvNWQNp/pS7nNRhqcg7+HRdO9fBx+i4cE7op1DfF8erKA13aeyWUqaVIPk
	c7/V3E4y5yqWw396jCCI2vqy/m9c28FQLUEkJVM+WyojknCOAojk5nHNrYsTcnMj47d7W2QA/Jv
	DaV2x6AmXFIUGzN9EXhW+Z7FFLyPH6w1IhxKIITn8qo2eKMdyNJJXLRqluJgu+JTzWvdbwW4YeR
	UIWr/nL0F6VksniNdA9ecLxlyGfY0MieWl/cAeRKJB26BiYGiasxLLpevix87mkhGsh4pw9Etze
	QmshKOn4Wxy87X8AnM5QUA6ctfIlDXK6KgwlZZjrtJxRSPXyRQb32Qhqd994rbXOq4hVCX8IMsI
	LFu5cE16TmOIojVosTQoTo9m12Pdr31rzjGD+4oNrkng+pi73XwKzNAEVhuSXh8fCSpwTLX7oSo
	XDZ5f6ElbiYJN/cPn7cV8Q3sBnRIVsYTnmJNZZdARgIi11YQ0FZrCbMQ==
X-Received: by 2002:a17:902:daca:b0:2a7:d7b8:7661 with SMTP id d9443c01a7336-2a84520a932mr27459565ad.4.1769408122098;
        Sun, 25 Jan 2026 22:15:22 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede745sm79477325ad.44.2026.01.25.22.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 22:15:21 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: dsa: add dsa_mall_policer_tc_entry_type() helper
Date: Mon, 26 Jan 2026 14:13:30 +0800
Message-ID: <20260126061340.757543-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126061340.757543-1-mmyangfl@gmail.com>
References: <20260126061340.757543-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253325-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1DF68469E
X-Rspamd-Action: no action

It has shown FLOW_ACTION_POLICE is not stable, and it's very likely that
options were added at drivers' request.

However, that also means .port_policer_add() would have to check the
parameters themselves. Giving that struct dsa_mall_policer_tc_entry is
not stable, adjusting the interface between the framework and drivers
would be a pain.

Introduce a helper to maximize forward compatibility. Drivers may use it
to recognize the pattern of tc entry reliably, and ensure all
newly-added options are set to 0 / their default values and do not break
the semantics.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/net/dsa.h | 14 ++++++++++++++
 net/dsa/dsa.c     | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 4c177b168ec8..957439846fe5 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1410,4 +1410,18 @@ netdev_tx_t dsa_enqueue_skb(struct sk_buff *skb, struct net_device *dev);
 void dsa_port_phylink_mac_change(struct dsa_switch *ds, int port, bool up);
 bool dsa_supports_eee(struct dsa_switch *ds, int port);
 
+enum dsa_mall_policer_tc_type {
+	/* Pattern recognized, no surprising fields exist */
+	DSA_MALL_POLICER_TC_KNOWN = BIT(0),
+	/* Unset: .burst and .rate_bytes_per_sec valid
+	 * Set: .burst_pkt and .rate_pkt_ps valid
+	 */
+	DSA_MALL_POLICER_TC_PKT_MODE = BIT(1),
+	/* .mtu valid */
+	DSA_MALL_POLICER_TC_MTU = BIT(2),
+};
+
+unsigned long
+dsa_mall_policer_tc_entry_type(struct dsa_mall_policer_tc_entry *entry);
+
 #endif
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 35ce3941fae3..c8102cea5ab3 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1834,6 +1834,39 @@ int dsa_port_simple_hsr_leave(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL_GPL(dsa_port_simple_hsr_leave);
 
+/* dsa_mall_policer_tc_entry_type - map tc_entry to some "known" types
+ * @entry: the tc entry
+ *
+ * A helper to check dsa_mall_policer_tc_entry against some known patterns,
+ * without having to know the exact struct layout.
+ *
+ * Returns: ORs of enum dsa_mall_policer_tc_type with DSA_MALL_POLICER_TC_KNOWN
+ * set if recognized, otherwise 0
+ */
+unsigned long
+dsa_mall_policer_tc_entry_type(struct dsa_mall_policer_tc_entry *entry)
+{
+	bool byte_mode = (entry->burst || entry->rate_bytes_per_sec);
+	bool pkt_mode = (entry->burst_pkt || entry->rate_pkt_ps);
+	unsigned long flags = DSA_MALL_POLICER_TC_KNOWN;
+
+	if (byte_mode == pkt_mode)
+		return 0;
+	if (entry->peakrate_bytes_ps || entry->avrate || entry->overhead)
+		return 0;
+	if (entry->exceed.act_id != FLOW_ACTION_DROP ||
+	    entry->notexceed.act_id != FLOW_ACTION_ACCEPT)
+		return 0;
+
+	if (pkt_mode)
+		flags |= DSA_MALL_POLICER_TC_PKT_MODE;
+	if (entry->mtu)
+		flags |= DSA_MALL_POLICER_TC_MTU;
+
+	return flags;
+}
+EXPORT_SYMBOL_GPL(dsa_mall_policer_tc_entry_type);
+
 static const struct dsa_stubs __dsa_stubs = {
 	.conduit_hwtstamp_validate = __dsa_conduit_hwtstamp_validate,
 };
-- 
2.51.0


