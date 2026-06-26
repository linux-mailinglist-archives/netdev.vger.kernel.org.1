Return-Path: <netdev+bounces-302149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OHJOOz5gPmpDEwkAu9opvQ
	(envelope-from <netdev+bounces-302149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:19:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B676CC59E
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:19:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GwqEXTXH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302149-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302149-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 043D1300F5C7
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55153E4C87;
	Fri, 26 Jun 2026 11:19:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB13BAD95
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 11:19:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472763; cv=none; b=Wxc4R1GY9X4Dh8JjxJfxWy6qWfoFdQUuCjtBLUBjKNmhEDAgkfMoM7TLyGRpizKMjzqAxM4AVVigy1fuy+mw1Hts3pU031zRQuPEEc6aSi8TPud+RmTkqXStQ6ZmSj3lfxjs1EyTWz+JoctrOxj9Xa94KIKtQfrFZYPSH7AnbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472763; c=relaxed/simple;
	bh=7zD5Fi7fV5fiV7ndB3/RVgbC1Zu7py/z1BLsdmv343w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGDKB3K3LM8+fhFE6MSx3zF+jv3NZ1dY3OciaHQ/Uvn9sTk0gB+R3D40YzaWLM4zbT7T1L4pImkdnAzZCx+Ko0AzXIrrWSkF6qectQ3KvkhZCBM1pGQcbeabZI5By655zTw2tekIooSq9GLt3p1WnGEAxGbvWLRRIzT+zX97kwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwqEXTXH; arc=none smtp.client-ip=209.85.160.178
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51a837c8618so4326141cf.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 04:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782472761; x=1783077561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDH/SnYHD/xgZKkOThtNf8aEYat0HV3qzz2KNui1LE8=;
        b=GwqEXTXHMR19dHNnwtkBVJCrM4Y7EN86EkvSLhYmtq6pGYxSDUmL6MqnQXYr8aF4sw
         vaCEui+jr6S5Zr94xTlUa9n5cLZKrFB2iKkHEqSYtEBOfTTVXonWObk6h+hhB5IPoX8n
         02UZnG91ZVLbxqCWpx1eL4lUfnnIan3ljUlaNjiD7pQMqwO98kfK0qE+5cW545UtRHek
         uj84IQKRnJK+BQm/Y1KqQqd7xTPf+qiQhkQA47sAx4HjXBf2O6dja08YOmo1ePFfJgn3
         bPOzjWE8h8kjw8grOQvq0HRlDQsoG289A7Svy2KAq5miCkBrewdM8cvTIEY41fIOqHJf
         lmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472761; x=1783077561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDH/SnYHD/xgZKkOThtNf8aEYat0HV3qzz2KNui1LE8=;
        b=q8Qecbginn04LjERogaro1TT0YziepLgcQBcUWalLdOumF902HvlBLVWejsglJ+DXz
         yX43fc+0mUK+YY8BeoogGESPEKnPhwdkpm0nzqJ6CR2nHZzTOUWqGkjEu5HckwVYJnFm
         pebgBwS761a4+03lVo3fkpQRMgeop4QnHOqvxqHCGNllsPTY5FUl81UsDagHPTYU0vFP
         ZnBzcEv8tou2Wnw7k3s2GuQGOhHsCIufF0GpwppQdftFM24frSN8woThlHY6VbisyJpv
         kH0NG/cykwEE7Ffdug4M5IcRvZfYw/ujzdJEC10rjO86S0TsTahOWzSwUAPZotYciiLv
         mjwg==
X-Gm-Message-State: AOJu0YyONIb07R0A1ypOGNkLqNiqkgIXJ/UQRLWQoQEeogX6M1Ge94eL
	+y7jNu39TFv5iyzRv56tmmGp2XNOxwm81vnknDDaPEsG1IwEl9peYZvTdoyB1wC9
X-Gm-Gg: AfdE7cmEXB0FbL/CFuObWLSe3ViEp5q1xhb6aRapBG7UpaQ8WrmcW8HCOy50OBgDknq
	z/qzbF5kfTxgs3QJ8NOhk3gq+60mMSnay2fv/x/qyROvILafYM28C3NITwbiY0xoCW50HYpqj9r
	HMTin1CIOfg6zOChRgXi2DNl792+glqK+beYitc6LASWrSWOBh40Q2aXZJdcRuD4JuIVeU4/etk
	udn3JdfLa5ocDp4R5sjP3ByU6mDSoOgc17Nxk64g3/PCjz4o/w2lRRG8unwguzB2fKiEuDeYCmn
	UCDF+ya1FikTvtP1RhkUgLIA9didIwpIwcZww5j7LODlqZh3Gf4Ba6Gyz0wmRqaR7ff5YzX9acy
	3OdtOedpqWi/grvDmm2dBUbmE9QepJxfYfs0QqyPEhM5cXEhLP5G71s/5TPOFkx/HKmZkescsMt
	A+b801zXumoTFFI1LJyHV2VuSEPnMBv+dKZ9tKHTuOerUCVyTSHaseBgxWUyaToCsTuQjCTtUxv
	NoVpkmTWdTIyA2hIq+0pSaQxt+m8CTu
X-Received: by 2002:a05:620a:262a:b0:915:a14a:6837 with SMTP id af79cd13be357-92b3d9a2f4cmr15843385a.35.1782472761313;
        Fri, 26 Jun 2026 04:19:21 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926005a1892sm1122327185a.38.2026.06.26.04.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:19:20 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] amt: don't read the IP header from a reallocated skb head
Date: Fri, 26 Jun 2026 07:19:17 -0400
Message-ID: <20260626111917.802243-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617123443.3586930-1-michael.bommarito@gmail.com>
References: <20260617123443.3586930-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302149-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ap420073@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93B676CC59E

Several AMT receive paths cache a pointer into the skb header
(ip_hdr() / ipv6_hdr()) and then call a helper that can reallocate
the skb head before reading the cached pointer:

  amt_rcv()                 caches ip_hdr(skb), then amt_parse_type()
                            does pskb_may_pull() before reading
                            iph->saddr;
  amt_update_handler()      caches ip_hdr(skb), then pskb_may_pull() /
                            iptunnel_pull_header() before reading
                            iph->saddr;
  amt_igmpv3_report_handler() caches ip_hdr(skb), then ip_mc_may_pull()
                            in the record loop before reading
                            iph->saddr;
  amt_mldv2_report_handler() caches ipv6_hdr(skb), then
                            ipv6_mc_may_pull() in the record loop
                            before reading ip6h->saddr.

pskb_may_pull() and the *_mc_may_pull() helpers can reallocate the
skb head; when they do, the old head is freed and the cached pointer
dangles, so the later source-address read is a use-after-free of the
freed head.

The only field used after the pull in each case is the source
address, which is stable across the pull. Snapshot it before the
pull and use the snapshot.

The sibling handlers that re-derive ip_hdr() after the pull
(amt_multicast_data_handler(), amt_membership_query_handler()) and
the handlers that read the source address with no intervening pull
(amt_discovery_handler(), amt_request_handler(), the IGMPv2/MLDv1
report and leave handlers) are not affected.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v3: address Jakub Kicinski's and Taehee Yoo's review of v2: fix all of
    the stale-iph reads Sashiko flagged in amt.c in one patch, not just
    amt_update_handler(). v2 fixed only amt_update_handler(); this also
    covers amt_rcv(), amt_igmpv3_report_handler() and
    amt_mldv2_report_handler(), which have the same pre-pull cached
    header read. The amt_update_handler() change is functionally the
    same as v2 (snapshot the source address before the pull).
    v2: https://lore.kernel.org/all/20260617123443.3586930-1-michael.bommarito@gmail.com/

Built for x86_64 (CONFIG_AMT=m) with W=1, no new warnings; checkpatch
--strict clean.

 drivers/net/amt.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 724a8163a5142..7094bdab0f463 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2000,13 +2000,15 @@ static void amt_igmpv3_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 	struct igmpv3_report *ihrv3 = igmpv3_report_hdr(skb);
 	int len = skb_transport_offset(skb) + sizeof(*ihrv3);
 	void *zero_grec = (void *)&igmpv3_zero_grec;
-	struct iphdr *iph = ip_hdr(skb);
 	struct amt_group_node *gnode;
 	union amt_addr group, host;
 	struct igmpv3_grec *grec;
+	__be32 saddr;
 	u16 nsrcs;
 	int i;
 
+	saddr = ip_hdr(skb)->saddr;
+
 	for (i = 0; i < ntohs(ihrv3->ngrec); i++) {
 		len += sizeof(*grec);
 		if (!ip_mc_may_pull(skb, len))
@@ -2022,7 +2024,7 @@ static void amt_igmpv3_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 		memset(&group, 0, sizeof(union amt_addr));
 		group.ip4 = grec->grec_mca;
 		memset(&host, 0, sizeof(union amt_addr));
-		host.ip4 = iph->saddr;
+		host.ip4 = saddr;
 		gnode = amt_lookup_group(tunnel, &group, &host, false);
 		if (!gnode) {
 			gnode = amt_add_group(amt, tunnel, &group, &host,
@@ -2162,13 +2164,15 @@ static void amt_mldv2_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 	struct mld2_report *mld2r = (struct mld2_report *)icmp6_hdr(skb);
 	int len = skb_transport_offset(skb) + sizeof(*mld2r);
 	void *zero_grec = (void *)&mldv2_zero_grec;
-	struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct amt_group_node *gnode;
 	union amt_addr group, host;
 	struct mld2_grec *grec;
+	struct in6_addr saddr;
 	u16 nsrcs;
 	int i;
 
+	saddr = ipv6_hdr(skb)->saddr;
+
 	for (i = 0; i < ntohs(mld2r->mld2r_ngrec); i++) {
 		len += sizeof(*grec);
 		if (!ipv6_mc_may_pull(skb, len))
@@ -2184,7 +2188,7 @@ static void amt_mldv2_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 		memset(&group, 0, sizeof(union amt_addr));
 		group.ip6 = grec->grec_mca;
 		memset(&host, 0, sizeof(union amt_addr));
-		host.ip6 = ip6h->saddr;
+		host.ip6 = saddr;
 		gnode = amt_lookup_group(tunnel, &group, &host, true);
 		if (!gnode) {
 			gnode = amt_add_group(amt, tunnel, &group, &host,
@@ -2455,8 +2459,10 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	struct ethhdr *eth;
 	struct iphdr *iph;
 	int len, hdr_size;
+	__be32 saddr;
 
 	iph = ip_hdr(skb);
+	saddr = iph->saddr;
 
 	hdr_size = sizeof(*amtmu) + sizeof(struct udphdr);
 	if (!pskb_may_pull(skb, hdr_size))
@@ -2472,7 +2478,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb_reset_network_header(skb);
 
 	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->ip4 == iph->saddr) {
+		if (tunnel->ip4 == saddr) {
 			if ((amtmu->nonce == tunnel->nonce &&
 			     amtmu->response_mac == tunnel->mac)) {
 				mod_delayed_work(amt_wq, &tunnel->gc_wq,
@@ -2772,7 +2778,7 @@ static void amt_gw_rcv(struct amt_dev *amt, struct sk_buff *skb)
 static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct amt_dev *amt;
-	struct iphdr *iph;
+	__be32 saddr;
 	int type;
 	bool err;
 
@@ -2785,7 +2791,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	skb->dev = amt->dev;
-	iph = ip_hdr(skb);
+	saddr = ip_hdr(skb)->saddr;
 	type = amt_parse_type(skb);
 	if (type == -1) {
 		err = true;
@@ -2795,7 +2801,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 	if (amt->mode == AMT_MODE_GATEWAY) {
 		switch (type) {
 		case AMT_MSG_ADVERTISEMENT:
-			if (iph->saddr != amt->discovery_ip) {
+			if (saddr != amt->discovery_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2807,7 +2813,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (iph->saddr != amt->remote_ip) {
+			if (saddr != amt->remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2818,7 +2824,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (iph->saddr != amt->remote_ip) {
+			if (saddr != amt->remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;

base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
-- 
2.53.0


