Return-Path: <netdev+bounces-276595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJbkBsdz1mkWFggAu9opvQ
	(envelope-from <netdev+bounces-276595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:27:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF513BE2C1
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45B453086436
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C533D6694;
	Wed,  8 Apr 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="XstqB58S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5520137C0F9
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661841; cv=none; b=ANy9okzborD3fjSblAR+5Bi7xQ7KTaIRP3WEVXxViEj3yZSDEp48t4EkaeUL+glxxithLvDR/VI9G8XixWRrRs6uiIdcsqWBeqaurbnDa6XXgDMyA0iZgSf8WJ+CAAVSQFfd/u2lBWqJSFTqAC0Tr3sCs5xC0VRuiJvE97GW6c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661841; c=relaxed/simple;
	bh=6j8AQsAkg8Iwdb8t8Nk+Z6TRfvnCRlmaKOgJJsuYYDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+b/KuHGwV9QLDZ0QnVJ8KjwjaXlG69XIdyFbzYa8FuV98e+lOlLsf3ER+rLxoaRHgGhBfO5YsDKefZTHdrQmY+FMAUr9aXHEZDk6cWHqHCEwMfHlljzgGHHyjJry4P8vJS96/3mp+pZkEb30nAjTdHstrAYATGFsjMcMBChTuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=XstqB58S; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-5a0faa0d15cso7248652e87.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1775661837; x=1776266637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiwGajaEehHYwwjcP14ZyBoW5z0ODgT7HmmzAmYOqhk=;
        b=XstqB58S2RDm93OVVzshrFsaYv7t43YzrPbCiVeGA2ma4GWWmgMhEbLqT0QUM9pZeD
         a/Li5+ruzy6p3c/r/JxI9mk1L8l/0E5IGpzVxgb+yGT4R76n7vcj43dXF44XQ+2YzWhH
         IzYMuiVseRXqPxUwEERHn+YnKT35SoKUGfMSKaJkBMA0kqlobnNOngaSKOZhDp+NGV5k
         mSJJhi5SFfE7rktsAsPlVQTdTvA6I/YpSI3nrnyvFd0772UApMfTjlioUmIrhjkCQ80k
         0w8zMRxMAmbuHFhhBmZHRMirWr9PEWPFPw4eB3TgnVsZ4fPkp3x1jrSUVHwO9yAb47HS
         tBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661837; x=1776266637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iiwGajaEehHYwwjcP14ZyBoW5z0ODgT7HmmzAmYOqhk=;
        b=jlTXvW+VSKomZ9xzU9IdzSiU7Cqa6eOWHmQEddJrRMnyEXdd5nTh8VyyA/ZehrQOBo
         9pnAhQulq1xOqNkdOtRzJwg9UYi09jLHC5hBnlts0YbB7dJ63m+Ryc55ui+akW3ySEco
         bJjOhSkTd41tdma8mIoDItFaXDq7JxURJf0CicuF2nU+yWv+VlJOqK5NKnjlAnOMvNrv
         rWO28hJAYoCtRGjstveTPJsANoZFilHNLfv0reK5aKPHySEh4aiyS/w4m4oSr9z0wxrc
         hQALSgUaIIgf/s/OfqeggK1c/h2Y44Y9Lvp9pCeVzuZSo8lcCOnky2IwK70O5Y010g9u
         pP9w==
X-Gm-Message-State: AOJu0YxuZvVtoYSWxhVEOgPdEdAm8rRyokOpSTrkhZ1rP5ET+K7jTg2E
	U0ZEjCTe69fZmOfFZpD74x20GVCbsXT6Xh9u2NIQmIyXP3K2KMzLlJKpuMD7ela8Mpt3aaWjrKe
	ATvcfFlNpNAeveLS71nHOCIeEKGTaLnqn8Wa4
X-Gm-Gg: AeBDietlwgNfCg4S/r5Fu02RVEO5vLXwAR3rQvf6JUhRYtvCbyoQzsk47e8nGVwcbQB
	8NQY6RuZxtdMeYTOR7nLmZtGIzgqp24BfEg7ZYDbM65AjetrGgAhTV+5al+cdsIO3EcR8LQx+Zf
	PBk1i2JlhHUxbHpWV1582jpYE3PU214esi/nKjDTBnsNet6EbYm0uOfDYfy4pqQ1APNp61BZIFH
	ASxjNM1GiZxzFpsCdtw8l7PvmkroHO15OuCbVhpMhEiRiweJS2eQvF5fWdV3ocvZtIeDGHsiXvv
	IWs83yyBQXGFXvYBpcaGNZDukyECKjTkLBpduWFPuXKiPWnAhBSPMXlu8zhVpT9osXnFFj+CeJt
	t3MMuBPCmQv4EHEvh887UIQ8So8efjCKzdhvIVVJVtW6NCj42IcHk
X-Received: by 2002:a05:6512:6d0:b0:5a2:c05c:118e with SMTP id 2adb3069b0e04-5a337559925mr8176073e87.11.1775661836970;
        Wed, 08 Apr 2026 08:23:56 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5a2c6c9684fsm1926632e87.1.2026.04.08.08.23.56;
        Wed, 08 Apr 2026 08:23:56 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id A137627052;
	Wed,  8 Apr 2026 17:23:56 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v3 1/5] bonding: 3ad: add lacp_fallback configuration knob
Date: Wed,  8 Apr 2026 17:23:49 +0200
Message-Id: <20260408152353.276204-2-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260408152353.276204-1-louis.scalbert@6wind.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276595-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid]
X-Rspamd-Queue-Id: ACF513BE2C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an 802.3ad (LACP) bonding interface has no slaves in the
collecting/distributing state, the bonding master still reports
carrier as up as long as at least 'min_links' slaves have carrier.

In this situation, only one slave is effectively used for TX/RX,
while traffic received on other slaves is dropped. Upper-layer
daemons therefore consider the interface operational, even though
traffic may be blackholed if the lack of LACP negotiation means
the partner is not ready to deal with traffic.

Introduce a configuration knob to control this behavior. It allows
the bonding master to assert carrier only when at least 'min_links'
slaves are in collecting/distributing state (or collecting only
when coupled_control is disabled).

The default mode preserves the current (legacy) behavior. This
patch only introduces the knob; its behavior is implemented in
the subsequent commit.

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 Documentation/networking/bonding.rst | 33 ++++++++++++++++++++++++++++
 drivers/net/bonding/bond_main.c      |  1 +
 drivers/net/bonding/bond_netlink.c   | 16 ++++++++++++++
 drivers/net/bonding/bond_options.c   | 26 ++++++++++++++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  1 +
 include/uapi/linux/if_link.h         |  1 +
 7 files changed, 79 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index e700bf1d095c..465d06aead27 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -619,6 +619,39 @@ min_links
 	aggregator cannot be active without at least one available link,
 	setting this option to 0 or to 1 has the exact same effect.
 
+lacp_fallback
+
+	Specifies the fallback behavior of a bonding when LACP negotiation fails on
+	all slave links, i.e. when no slave is in the Collecting/Distributing state
+	(or only in Collecting state when coupled_control is disabled), while at
+	least `min_links` link still reports carrier up.
+
+	This option is only applicable to 802.3ad mode (mode 4).
+
+	Valid values are:
+
+	legacy or 0
+		In this situation, the bonding master remains carrier up and
+		randomly selects a single slave to transmit and receive traffic.
+		Traffic received on other slaves is dropped.
+
+		This mode is deprecated, as it may lead to traffic blackholing
+		when the absence of LACP negotiation means the partner is not
+		ready to collect and distribute traffic.
+
+		This is the legacy default behavior.
+
+	strict or 1
+		In this situation, the bonding master reports carrier down, allowing
+		upper-layer processes to detect that the interface is not usable for
+		collecting and distributing traffic.
+
+		The master transitions to carrier up only when at least
+		`min_links` slaves reach the Collecting(/Distributing) state,
+		allowing traffic to flow.
+
+	The default value is 0 (legacy).
+
 mode
 
 	Specifies one of the bonding policies. The default is
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a5484d11553d..02cba0560a39 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6440,6 +6440,7 @@ static int __init bond_check_params(struct bond_params *params)
 	params->ad_user_port_key = ad_user_port_key;
 	params->coupled_control = 1;
 	params->broadcast_neighbor = 0;
+	params->lacp_fallback = 0;
 	if (packets_per_slave > 0) {
 		params->reciprocal_packets_per_slave =
 			reciprocal_value(packets_per_slave);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 286f11c517f7..1f92ad786b51 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -130,6 +130,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_NS_IP6_TARGET]	= { .type = NLA_NESTED },
 	[IFLA_BOND_COUPLED_CONTROL]	= { .type = NLA_U8 },
 	[IFLA_BOND_BROADCAST_NEIGH]	= { .type = NLA_U8 },
+	[IFLA_BOND_LACP_FALLBACK]	= { .type = NLA_U8 },
 };
 
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
@@ -586,6 +587,16 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BOND_LACP_FALLBACK]) {
+		int fallback_mode = nla_get_u8(data[IFLA_BOND_LACP_FALLBACK]);
+
+		bond_opt_initval(&newval, fallback_mode);
+		err = __bond_opt_set(bond, BOND_OPT_LACP_FALLBACK, &newval,
+				     data[IFLA_BOND_LACP_FALLBACK], extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -658,6 +669,7 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 		nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TARGETS +
 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_COUPLED_CONTROL */
 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_BROADCAST_NEIGH */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_LACP_FALLBACK */
 		0;
 }
 
@@ -825,6 +837,10 @@ static int bond_fill_info(struct sk_buff *skb,
 		       bond->params.broadcast_neighbor))
 		goto nla_put_failure;
 
+	if (nla_put_u8(skb, IFLA_BOND_LACP_FALLBACK,
+		       bond->params.lacp_fallback))
+		goto nla_put_failure;
+
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		struct ad_info info;
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 7380cc4ee75a..b672b8a881bb 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -68,6 +68,8 @@ static int bond_option_lacp_active_set(struct bonding *bond,
 				       const struct bond_opt_value *newval);
 static int bond_option_lacp_rate_set(struct bonding *bond,
 				     const struct bond_opt_value *newval);
+static int bond_option_lacp_fallback_set(struct bonding *bond,
+					 const struct bond_opt_value *newval);
 static int bond_option_ad_select_set(struct bonding *bond,
 				     const struct bond_opt_value *newval);
 static int bond_option_queue_id_set(struct bonding *bond,
@@ -162,6 +164,12 @@ static const struct bond_opt_value bond_lacp_rate_tbl[] = {
 	{ NULL,   -1,           0},
 };
 
+static const struct bond_opt_value bond_lacp_fallback_tbl[] = {
+	{ "legacy", 0, BOND_VALFLAG_DEFAULT},
+	{ "strict",  1, 0},
+	{ NULL, -1, 0 }
+};
+
 static const struct bond_opt_value bond_ad_select_tbl[] = {
 	{ "stable",          BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
 	{ "bandwidth",       BOND_AD_BANDWIDTH, 0},
@@ -363,6 +371,14 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.values = bond_lacp_rate_tbl,
 		.set = bond_option_lacp_rate_set
 	},
+	[BOND_OPT_LACP_FALLBACK] = {
+		.id = BOND_OPT_LACP_FALLBACK,
+		.name = "lacp_fallback",
+		.desc = "Define the LACP fallback mode when no slaves have negotiated",
+		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
+		.values = bond_lacp_fallback_tbl,
+		.set = bond_option_lacp_fallback_set
+	},
 	[BOND_OPT_MINLINKS] = {
 		.id = BOND_OPT_MINLINKS,
 		.name = "min_links",
@@ -1684,6 +1700,16 @@ static int bond_option_lacp_rate_set(struct bonding *bond,
 	return 0;
 }
 
+static int bond_option_lacp_fallback_set(struct bonding *bond,
+					 const struct bond_opt_value *newval)
+{
+	netdev_dbg(bond->dev, "Setting LACP fallback to %s (%llu)\n",
+		   newval->string, newval->value);
+	bond->params.lacp_fallback = newval->value;
+
+	return 0;
+}
+
 static int bond_option_ad_select_set(struct bonding *bond,
 				     const struct bond_opt_value *newval)
 {
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index e6eedf23aea1..5eb64c831f54 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -79,6 +79,7 @@ enum {
 	BOND_OPT_COUPLED_CONTROL,
 	BOND_OPT_BROADCAST_NEIGH,
 	BOND_OPT_ACTOR_PORT_PRIO,
+	BOND_OPT_LACP_FALLBACK,
 	BOND_OPT_LAST
 };
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 395c6e281c5f..d8cb02643f8b 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -132,6 +132,7 @@ struct bond_params {
 	int peer_notif_delay;
 	int lacp_active;
 	int lacp_fast;
+	int lacp_fallback;
 	unsigned int min_links;
 	int ad_select;
 	char primary[IFNAMSIZ];
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index e9b5f79e1ee1..7ad3fc600c71 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1539,6 +1539,7 @@ enum {
 	IFLA_BOND_NS_IP6_TARGET,
 	IFLA_BOND_COUPLED_CONTROL,
 	IFLA_BOND_BROADCAST_NEIGH,
+	IFLA_BOND_LACP_FALLBACK,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.39.2


