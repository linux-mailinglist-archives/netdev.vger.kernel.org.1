Return-Path: <netdev+bounces-297281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JifEFIl7KGpFFQMAu9opvQ
	(envelope-from <netdev+bounces-297281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:46:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B21D664201
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:46:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297281-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297281-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 060B2300CF34
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB2236BCFB;
	Tue,  9 Jun 2026 20:45:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0B40D58B
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 20:45:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037947; cv=none; b=gvK9iDW0vmYI3za2aZpvTpChcgVhrijUoDF4VbXZbXHS3i1sE+FB7zpjTELd0CQc5GGyn9/U2cTqH38NFv6gSupYzpWv9O8WuqowC5tJx9PqjN5F8XdXXszLzi4nkA4IvkB2wDgCoWZ1gQkWHkpt1dKjQjmF2WXRmtqqofXZcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037947; c=relaxed/simple;
	bh=89asEXevv4YE8NLyNqCiW7IlO4v3DKeN/0W7ohqC63Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI+nIvl1OsmTT1ufupAkdK5MrKl2f3VaBz13B4mD52LIYluQZQwmOE899E54eA13nbB61+kOvA3C57cTD6o4Osdp7z4YvTVqEEXcilYIgmjRB3ocorHx5oF8Lh0Jo9kB0hH3l/m7vLktkLB943mFngJm5NQb/iZKg540TCWUgfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4083A5D73E;
	Tue,  9 Jun 2026 20:45:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CA76779A7;
	Tue,  9 Jun 2026 20:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +ExMI3J7KGq7PwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 09 Jun 2026 20:45:38 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH 2/3 net-next v6] ipv4: handle devconf post-set actions on netlink updates
Date: Tue,  9 Jun 2026 22:45:19 +0200
Message-ID: <20260609204520.4670-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260609204520.4670-1-fmancera@suse.de>
References: <20260609204520.4670-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:fmancera@suse.de,m:nicolas.dichtel@6wind.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297281-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:email,suse.de:mid,suse.de:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B21D664201

When IPv4 device configuration parameters are updated via netlink, the
kernel currently only updates the value. This bypasses several
post-modification actions that occur when these same parameters are
updated via sysctl, such as flushing the routing cache or emitting
RTM_NEWNETCONF notifications.

This patch addresses the inconsistency by calling the
devinet_conf_post_set() helper inside inet_set_link_af(). If a flush is
required, we defer it until the netlink attribute parsing loop
completes.

This ensures consistent behavior and side-effects for devconf changes,
regardless of whether they are initiated via sysctl or netlink.

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: handled forwarding notification and disabling LRO
v3: no changes
v4: no changes
v5: no changes
v6: no changes
---
 net/ipv4/devinet.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 8300516fb38f..a35b72662e43 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2161,6 +2161,20 @@ static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
 					    NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
 					    ifindex, cnf);
 		break;
+	case IPV4_DEVCONF_FORWARDING:
+		if (new == 1) {
+			/* it is safe to use container_of() because forwarding case
+			 * is only used by the netlink path
+			 */
+			struct in_device *idev = container_of(cnf, struct in_device, cnf);
+
+			netif_disable_lro(idev->dev);
+		}
+
+		inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
+					    NETCONFA_FORWARDING,
+					    ifindex, cnf);
+		return true;
 	default:
 		break;
 	}
@@ -2173,6 +2187,8 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 {
 	struct in_device *in_dev = __in_dev_get_rtnl(dev);
 	struct nlattr *a, *tb[IFLA_INET_MAX+1];
+	struct net *net = dev_net(dev);
+	bool flush_cache = false;
 	int rem;
 
 	if (!in_dev)
@@ -2182,8 +2198,17 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 		return -EINVAL;
 
 	if (tb[IFLA_INET_CONF]) {
-		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem)
-			ipv4_devconf_set(in_dev, nla_type(a), nla_get_u32(a));
+		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
+			int old_value = ipv4_devconf_get(in_dev, nla_type(a));
+			int new_value = nla_get_u32(a);
+
+			ipv4_devconf_set(in_dev, nla_type(a), new_value);
+			if (devinet_conf_post_set(net, &in_dev->cnf, nla_type(a), new_value,
+						  old_value, dev->ifindex))
+				flush_cache = true;
+		}
+		if (flush_cache)
+			rt_cache_flush(net);
 	}
 
 	return 0;
-- 
2.54.0


