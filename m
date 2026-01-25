Return-Path: <netdev+bounces-253152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNelK7T8dWk1KQEAu9opvQ
	(envelope-from <netdev+bounces-253152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 12:21:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72380802E9
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1E1330057BC
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 11:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50918318ED7;
	Sun, 25 Jan 2026 11:21:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60742749D6
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340079; cv=none; b=TudBAqlN3PUVL2nr5FqXXXpiJJUULRp0L6HSXPn26gHx/Qu2rFfqEHl8OoDyoHrNMbG6584LT2I2HANXBnS5p0pK3tpym+16UFE/7rm9zAK+Z8AdOHeNYR1x8Sv3V3yZTyLnpqf8Dt5VzVqIrbWybjA509k1ACafa8Wc2mDz848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340079; c=relaxed/simple;
	bh=d60DzLb0C8T/SVZzyO+WsCasg8mBhIms9JkK5WP9Ukc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRn6ycndcP1tFPOGYEoobgvL1QivCRyRjSnWBvm6I0zxMhNh4F+3L3uwlc408nYXEd1yeXBglcHEv612wrfFwFKQYoWi6CTHny21CsncQJ28SeV9GH8cX7/Kc9vaA335Zsx9wozTsGqsINwCPlatgH61PtPr/5FLb8e62GZwb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60PBL84c094889;
	Sun, 25 Jan 2026 20:21:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60PBL8c9094886
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 25 Jan 2026 20:21:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <29ffd5ac-07b1-4424-ad3f-8304a28d2946@I-love.SAKURA.ne.jp>
Date: Sun, 25 Jan 2026 20:21:08 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv4: don't call inetdev_init() if device is no longer
 registered
To: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <7fe2645c-680d-4fbe-981b-67a041f0d9c9@I-love.SAKURA.ne.jp>
 <20260125085835.GA54633@shredder>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260125085835.GA54633@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-253152-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72380802E9
X-Rspamd-Action: no action

On 2026/01/25 17:58, Ido Schimmel wrote:
> Thanks for the report and fix. You can reproduce with [1], but the
> proposed fix doesn't help. Problem is that NETDEV_UNREGISTER is first
> caught by inetdev_event(), which calls inetdev_destroy(), but then the
> team driver restores dummy1's MTU and initializes the idev again.

Thank you for the reproducer. I thought the proposed patch can prevent
the idev from initializing again, but your reproducer showed that it can't
because dev->reg_state == NETREG_REGISTERED.

We would need to update team driver side not to trigger dev_set_mtu().
Below diff passed the reproducer, but I don't know whether it is safe
to trigger dev_set_mtu() for team_uninit() and team_del_slave() and
the err_port_enter: label of team_port_add()...

 drivers/net/team/team_core.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index c08a5c1bd6e4..30c89490545a 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1292,7 +1292,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 static void __team_port_change_port_removed(struct team_port *port);
 
-static int team_port_del(struct team *team, struct net_device *port_dev)
+static int team_port_del(struct team *team, struct net_device *port_dev, bool no_restore)
 {
 	struct net_device *dev = team->dev;
 	struct team_port *port;
@@ -1330,7 +1330,8 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	__team_port_change_port_removed(port);
 
 	team_port_set_orig_dev_addr(port);
-	dev_set_mtu(port_dev, port->orig.mtu);
+	if (!no_restore)
+		dev_set_mtu(port_dev, port->orig.mtu);
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
 	netdev_compute_master_upper_features(team->dev, true);
@@ -1634,7 +1635,7 @@ static void team_uninit(struct net_device *dev)
 	ASSERT_RTNL();
 
 	list_for_each_entry_safe(port, tmp, &team->port_list, list)
-		team_port_del(team, port->dev);
+		team_port_del(team, port->dev, false);
 
 	__team_change_mode(team, NULL); /* cleanup */
 	__team_options_unregister(team, team_options, ARRAY_SIZE(team_options));
@@ -1933,7 +1934,16 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 
 	ASSERT_RTNL();
 
-	return team_port_del(team, port_dev);
+	return team_port_del(team, port_dev, false);
+}
+
+static int team_del_slave_no_restore(struct net_device *dev, struct net_device *port_dev)
+{
+	struct team *team = netdev_priv(dev);
+
+	ASSERT_RTNL();
+
+	return team_port_del(team, port_dev, true);
 }
 
 static netdev_features_t team_fix_features(struct net_device *dev,
@@ -2926,7 +2936,7 @@ static int team_device_event(struct notifier_block *unused,
 					       !!netif_oper_up(port->dev));
 		break;
 	case NETDEV_UNREGISTER:
-		team_del_slave(port->team->dev, dev);
+		team_del_slave_no_restore(port->team->dev, dev);
 		break;
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {


