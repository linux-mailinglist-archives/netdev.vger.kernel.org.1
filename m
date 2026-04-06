Return-Path: <netdev+bounces-275513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOgADFUj02n1ewcAu9opvQ
	(envelope-from <netdev+bounces-275513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:07:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCE13A13C4
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E83D302AD20
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 03:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAAF330315;
	Mon,  6 Apr 2026 03:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzdSgbUY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA631F9B3
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775444697; cv=none; b=ErVmhLaXAUQZjHoKwVDoDeIL1tzxWoRxj4i83Su0TnUbkBZRMsyPSlcGnl5x6sLrAVhn6VcBLoJdQuwscKN3uKk2RMYUle0W9CGtkGi18GAPePv6R29HsUOQMMzTRWwJG1NLJVij6L5YvDc5wBAxXwlqJ+zWOz1QSPmzfLN9C9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775444697; c=relaxed/simple;
	bh=o6Pod91e7/9t3b2/Bm72vJKPPOfa7e2ANUl5kI+qtIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eHu6oeE7jQaR8W+KpPyvJzsErfswEGC5jubYfixPTpNhXnCMLBcAtPe6tmedvOslM95wz+6yv9T4L4zbro3jkrCsoLk/g33kPGSJ3Lv9yNd74TwHfIcVt+zAgBRxp6OQCOhmveoz3XJejEQ4xnH0ATQ7GFeO+hxbVAX4CAsrE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzdSgbUY; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so23362312eec.1
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 20:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775444694; x=1776049494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4URTC5SIPOJboJ7bC77dvH5LDjPWmAdcDPJzBNM8Qk0=;
        b=XzdSgbUYPhRTcVnSmrQwLYsupAbzqyzkR4nN/sEWdecEToW7PFf3KZ1uZigRCmwBDO
         Jz7aoDxkf1w0E4AwpSCsBRBW1sBDmkxQxTGuxDer9BoyC3F9SpqcQr4xPj3LCpfuMPhG
         CrweWJlM0yYyNiG5E24dGXgd2gMofimbArbgyKQ17ry+zQ86oQHBHydpeLflGn7DZO6l
         0fK69tzZpY2Ekm/eUyL7qcEWPmxnLhzEptKCB3IugtJIwP2KG3ZX9nb03zMsmhUKjtkw
         1VkEZNpdlRO/wNVcMcy3dpWLZ0z/ba2yefiRSPdljAPIrXGNz7aJvUwW3dgZT4j+WyVI
         vDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775444694; x=1776049494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4URTC5SIPOJboJ7bC77dvH5LDjPWmAdcDPJzBNM8Qk0=;
        b=eg02vfNejOsMOsFB6lNZjfdqdTIH9054bWmVwVcQXT7zfU/ubEwUS92INz5SZYcxKe
         NnTtpXrTD1Cpgs9GNftQ5/yA6NWlxjLvU1FgHvIWp6hshFSoRscW0pW+rOvPZ6WGfKvm
         tJdrwAMlEWI+vlIbfRrCmh12uB5ptbv10gE5u/T8A5P7/+FwmghQhqAu0sBTFo0Pzm5w
         APlVKb9fAnKg9Cjheir338NjNemfh7u5c+dgi/DeHiOil9k5qSjzurZOM2G6YpDE0yzx
         1WNBZtRqbGS+VdCoT0czf6t5CfMvz/PfhLOtxwYHILaMV4lforzMdUJtEPK0m1M4tm56
         3RWw==
X-Gm-Message-State: AOJu0YynPgvB7EKz1o+gnNcWOcKDsV4cIl0OloFatbe8MJOMkBktoLqb
	RDDwI+9Uyj+nqNpzWHMXKYbRv3XVaM0aAnmCRbmBSPuCBg5EWQ6aG0hqp1HR9tiDrZxQY68UXVZ
	0q8lUzMysJS5qKEXkd6wgPw==
X-Received: from dycac24.prod.google.com ([2002:a05:7301:5518:b0:2c4:3a40:8acd])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:fd09:b0:2c6:1557:998f with SMTP id 5a478bee46e88-2cbfc16c435mr5221567eec.25.1775444693757;
 Sun, 05 Apr 2026 20:04:53 -0700 (PDT)
Date: Mon, 06 Apr 2026 03:03:39 +0000
In-Reply-To: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775444686; l=2611;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=o6Pod91e7/9t3b2/Bm72vJKPPOfa7e2ANUl5kI+qtIg=; b=zTZohA5zj/dgsl5f+2TjmB6csNXcByUzymeOpU3t0RybGmZFJCp2RtVTm8BvbI0KFTCh6XUBg
 H/fbAcXs6sgAVlVx2yrW5k94zPotbsNiT2B25EIRA9uA3u5LCM7E5Kz
X-Mailer: b4 0.14.3
Message-ID: <20260406-teaming-driver-internal-v5-3-e8a3f348a1c5@google.com>
Subject: [PATCH net-next v5 03/10] net: team: Rename port_disabled team mode
 op to port_tx_disabled
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275513-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CCE13A13C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team mode op is only used by the load balance mode, and it only
uses it in the tx path.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v5:
- None

Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- None
---
 drivers/net/team/team_core.c             | 4 ++--
 drivers/net/team/team_mode_loadbalance.c | 4 ++--
 include/linux/if_team.h                  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index e54bd21bd068..2ce31999c99f 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -968,8 +968,8 @@ static void team_port_disable(struct team *team,
 {
 	if (!team_port_enabled(port))
 		return;
-	if (team->ops.port_disabled)
-		team->ops.port_disabled(team, port);
+	if (team->ops.port_tx_disabled)
+		team->ops.port_tx_disabled(team, port);
 	hlist_del_rcu(&port->hlist);
 	__reconstruct_port_hlist(team, port->index);
 	WRITE_ONCE(port->index, -1);
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 684954c2a8de..840f409d250b 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -655,7 +655,7 @@ static void lb_port_leave(struct team *team, struct team_port *port)
 	free_percpu(lb_port_priv->pcpu_stats);
 }
 
-static void lb_port_disabled(struct team *team, struct team_port *port)
+static void lb_port_tx_disabled(struct team *team, struct team_port *port)
 {
 	lb_tx_hash_to_port_mapping_null_port(team, port);
 }
@@ -665,7 +665,7 @@ static const struct team_mode_ops lb_mode_ops = {
 	.exit			= lb_exit,
 	.port_enter		= lb_port_enter,
 	.port_leave		= lb_port_leave,
-	.port_disabled		= lb_port_disabled,
+	.port_tx_disabled	= lb_port_tx_disabled,
 	.receive		= lb_receive,
 	.transmit		= lb_transmit,
 };
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index a761f5282bcf..740cb3100dfc 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -121,7 +121,7 @@ struct team_mode_ops {
 	int (*port_enter)(struct team *team, struct team_port *port);
 	void (*port_leave)(struct team *team, struct team_port *port);
 	void (*port_change_dev_addr)(struct team *team, struct team_port *port);
-	void (*port_disabled)(struct team *team, struct team_port *port);
+	void (*port_tx_disabled)(struct team *team, struct team_port *port);
 };
 
 extern int team_modeop_port_enter(struct team *team, struct team_port *port);

-- 
2.53.0.1185.g05d4b7b318-goog


