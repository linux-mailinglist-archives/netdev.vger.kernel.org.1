Return-Path: <netdev+bounces-271639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNxGOCINxGk+vgQAu9opvQ
	(envelope-from <netdev+bounces-271639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:28:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9C328FC6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BFC5315FC55
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544663ED5AA;
	Wed, 25 Mar 2026 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GZGY8knH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Txo33sfm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GZGY8knH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Txo33sfm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10EA3ED5D7
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455053; cv=none; b=AkWxwewkWkZqhpBtGHKBW6TTttFzK+5hssfRQzCSmk0VxpkZaen/ZkBIAHWiF3U7IbWWz8Uq+Vhoyu8RZmmAEkIcMiLChLqAmkv5vRBBSEhzgYoCWPD3XOniHmVRsS5cmMMPrlISr37XV9fOuxSoLJqVPaR3yJ/8V10sWYu/76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455053; c=relaxed/simple;
	bh=tI3HYP5m3EJ6gzUBsD7UV20Dv1k85tlJ3zVL+tVscRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utpGEcmENGhRHE52v8iPCsDHNoZQrMeqlpKgP6Bazn88/K8n1ee7QtQrqv2R0Vw5UzUUvRkXLqYZYsE7+DXc0hkGtsfB8Y5XxTjaM3tSDAc/StjrbBSDQaG5/aCBoGUzXhd+qBh0k2WXR+7sUwK+cc1O4nl+6y0JigHFVJ9BDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GZGY8knH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Txo33sfm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GZGY8knH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Txo33sfm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B7FA4D24C;
	Wed, 25 Mar 2026 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774455045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XaUD1vY+IkliYanyXNucm6Fr9uIGsZ8qMDo9GTZmHw=;
	b=GZGY8knH9QxwCC+xceI+j2dTpJH/pdc9R/uxDD0j+9QGeV/lLju8hKs34RS+CJoXVWUvtN
	xVS+iNdIMctirfXexy/J5Dt4W1Aa0y4tC3HDfemRaRsKohObOo55iCTnyG4vFHy6tB1MxQ
	a63kTnNg7ej3EVFlkWbSAJXAI4DrY1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774455045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XaUD1vY+IkliYanyXNucm6Fr9uIGsZ8qMDo9GTZmHw=;
	b=Txo33sfmKM9D+83pYGWVqi2aQkOwJBYIde2BsCrsSE0ilbNIQ25uApNb9940yb9187dkpX
	MqNNYgxr3xfrbvBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774455045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XaUD1vY+IkliYanyXNucm6Fr9uIGsZ8qMDo9GTZmHw=;
	b=GZGY8knH9QxwCC+xceI+j2dTpJH/pdc9R/uxDD0j+9QGeV/lLju8hKs34RS+CJoXVWUvtN
	xVS+iNdIMctirfXexy/J5Dt4W1Aa0y4tC3HDfemRaRsKohObOo55iCTnyG4vFHy6tB1MxQ
	a63kTnNg7ej3EVFlkWbSAJXAI4DrY1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774455045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XaUD1vY+IkliYanyXNucm6Fr9uIGsZ8qMDo9GTZmHw=;
	b=Txo33sfmKM9D+83pYGWVqi2aQkOwJBYIde2BsCrsSE0ilbNIQ25uApNb9940yb9187dkpX
	MqNNYgxr3xfrbvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA0EA444AE;
	Wed, 25 Mar 2026 16:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sJ09LgQJxGnnMwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Mar 2026 16:10:44 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net-next] ipv4: ipv4: handle devconf post-set actions on netlink updates
Date: Wed, 25 Mar 2026 17:10:20 +0100
Message-ID: <20260325161020.3516-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325161020.3516-1-fmancera@suse.de>
References: <20260325161020.3516-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 43B9C328FC6
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
 net/ipv4/devinet.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c81bb948d59f..555f85139fb5 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2128,11 +2128,16 @@ static int inet_validate_link_af(const struct net_device *dev,
 	return 0;
 }
 
+static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
+				  int attr, int new, int old, int index);
+
 static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 			    struct netlink_ext_ack *extack)
 {
 	struct in_device *in_dev = __in_dev_get_rtnl(dev);
 	struct nlattr *a, *tb[IFLA_INET_MAX+1];
+	struct net *net = dev_net(dev);
+	bool flush_cache = false;
 	int rem;
 
 	if (!in_dev)
@@ -2142,8 +2147,17 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
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
@@ -2507,6 +2521,10 @@ static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
 		return false;
 
 	switch (attr) {
+	case IPV4_DEVCONF_FORWARDING:
+		if (new == 1)
+			return true;
+		break;
 	case IPV4_DEVCONF_ROUTE_LOCALNET:
 	case IPV4_DEVCONF_ACCEPT_LOCAL:
 		if (new == 0)
-- 
2.53.0


