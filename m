Return-Path: <netdev+bounces-272522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMqdCSJzxmkCKgUAu9opvQ
	(envelope-from <netdev+bounces-272522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:08:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A60E343F74
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5DEA3004C90
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FA036922F;
	Fri, 27 Mar 2026 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0bBqBti/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UHtuOWxW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0bBqBti/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UHtuOWxW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83340286AC
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612942; cv=none; b=Sv/Yi2wwitOMpQ+aO06NODY1jimgudfon6+annN3y+uPy/Y/1cc9K7+VjjUYCCgsuP/ybgfT5fDQhKTojbGcZRnqGqpJVzoqFyuENFaVcVKs8eLeyLJmJHtuLcb+/dnpD1kpHC+2Pw0g5D3SwfMXfVlgbkehXNqPV7a6qOQbtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612942; c=relaxed/simple;
	bh=AsQHG1/kPVntJ4KM5uSNT7jWzIykzXVytvqW1/naGks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvuoXJpIE1krrt3yNA8/ddErHlvblXO0TjfRsqJq+jVTDSknEO9URMh4o44JD4vP2MMivSc6GEkZDMT1ejgcBuI+gJaL/QibZqQZBfgq4eMKBLz0APJqa4PVoyciZxDbASLSywCaUB45rwHUNtayBgAi5XJYD75a+jjbopo0iuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0bBqBti/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UHtuOWxW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0bBqBti/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UHtuOWxW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E53FF5BDD8;
	Fri, 27 Mar 2026 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774612935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H75Bx4MerlIUwQyFP6BC8a9V8lAdM0Y1ZT1UR74nPkc=;
	b=0bBqBti/YP5UbEDN5MVtiFQ2UKO+PqohGtAakToGeyoUTWL6HWFytvuzQ+RvMNUXLYaiVM
	LlyzaVcF9W5Y8l+1dwr11b8z6vKdFwDntTw/KNab4ZyrG82Ie9END/syrADnUgcTKbh2rj
	CC8eLh7T8xKhzQdY6XH/fj7dsvGlOaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774612935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H75Bx4MerlIUwQyFP6BC8a9V8lAdM0Y1ZT1UR74nPkc=;
	b=UHtuOWxWH/8YyJxxSTKu6f/LeGRe2CA0+BqL7+qiBCfuM+BCwVBB9MjXL3NJaanuuwush1
	mKGiQwNUruREH0AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774612935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H75Bx4MerlIUwQyFP6BC8a9V8lAdM0Y1ZT1UR74nPkc=;
	b=0bBqBti/YP5UbEDN5MVtiFQ2UKO+PqohGtAakToGeyoUTWL6HWFytvuzQ+RvMNUXLYaiVM
	LlyzaVcF9W5Y8l+1dwr11b8z6vKdFwDntTw/KNab4ZyrG82Ie9END/syrADnUgcTKbh2rj
	CC8eLh7T8xKhzQdY6XH/fj7dsvGlOaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774612935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H75Bx4MerlIUwQyFP6BC8a9V8lAdM0Y1ZT1UR74nPkc=;
	b=UHtuOWxWH/8YyJxxSTKu6f/LeGRe2CA0+BqL7+qiBCfuM+BCwVBB9MjXL3NJaanuuwush1
	mKGiQwNUruREH0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6036D4A0A2;
	Fri, 27 Mar 2026 12:02:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ePRWFMdxxmlfOwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 27 Mar 2026 12:02:15 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net-next v2] ipv4: handle devconf post-set actions on netlink updates
Date: Fri, 27 Mar 2026 13:02:02 +0100
Message-ID: <20260327120202.4761-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327120202.4761-1-fmancera@suse.de>
References: <20260327120202.4761-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272522-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 0A60E343F74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: handled forwarding notification and disabling LRO
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
2.53.0


