Return-Path: <netdev+bounces-265071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJwYCt6tq2nQfQEAu9opvQ
	(envelope-from <netdev+bounces-265071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 05:47:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1DB22A1A5
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 05:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30CC2302485A
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 04:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1034A766;
	Sat,  7 Mar 2026 04:46:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520533B6E3;
	Sat,  7 Mar 2026 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858776; cv=none; b=LunEWqXL6NJGtLc9XjRG4yOCKv090X2UNGdP+52nP1I5LjcDh9K46HEmwAFRpbtdr5+qMWQtPi3mGM5MAGI2b8MPRN4FVkVkp6eDrBpt0urCbEnVfYmZOXX+mE0W4MpMMDX+FEVowROHEf6ntkWjykRiYeptH9lJtD7HBYS2YRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858776; c=relaxed/simple;
	bh=8AwlC0ORjtiYenq6JoteQg3VwOEL409SWItUtfUUlxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7a7m8L2eo4133H9G7MWekPsPKggg7eSVgtxqy6ZWBOo0IDNwMbco1vSkQk7B9+BtC8Wi8Wso/820e9sJuHNJoVNfbpJJek5THWNxHszjiRzzPPjvgengLrhoTSVwKdaWVOLQQn9w13oO2Vsfzl+Lpk9hA/1t9UDojLXRC/izVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1111854CE9E;
	Sat,  7 Mar 2026 05:46:09 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	shuah@kernel.org,
	petrm@nvidia.com,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v4 06/14] net: bridge: mcast: track active state, IPv6 address availability
Date: Sat,  7 Mar 2026 05:45:40 +0100
Message-ID: <20260307044548.5230-7-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260307044548.5230-1-linus.luessing@c0d3.blue>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 4E1DB22A1A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265071-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[c0d3.blue];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.882];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,c0d3.blue];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,c0d3.blue:mid,c0d3.blue:email]
X-Rspamd-Action: no action

If we are the only potential MLD querier but don't have an IPv6
link-local address configured on our bridge interface then we can't
create a valid MLD query and in turn can't reliably receive MLD reports
and can't build a complete MDB. Hence disable the new multicast active
state variable then. Or reenable it if an IPv6 link-local address
became available.

No functional change for the fast/data path yet.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 64aac9c415e2..2eebfb7c5ff9 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1125,6 +1125,8 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
  * The multicast active state is set, per protocol family, if:
  *
  * - an IGMP/MLD querier is present
+ * - for own IPv6 MLD querier: an IPv6 link-local address is configured on the
+ *   bridge
  *
  * And is unset otherwise.
  *
@@ -1223,10 +1225,12 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 			       &ip6h->daddr, 0, &ip6h->saddr)) {
 		kfree_skb(skb);
 		br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, false);
+		br_multicast_update_active(brmctx);
 		return NULL;
 	}
 
 	br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, true);
+	br_multicast_update_active(brmctx);
 	ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 
 	hopopt = (u8 *)(ip6h + 1);
-- 
2.53.0


