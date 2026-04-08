Return-Path: <netdev+bounces-276246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PzRNLDD1Wkx9gcAu9opvQ
	(envelope-from <netdev+bounces-276246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:55:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA4D3B65CF
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D768230786F6
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C02A371CFF;
	Wed,  8 Apr 2026 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mn4+cd0x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A563F36CDEF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616753; cv=none; b=SxMcRFZDq/HJDPtvuVFoNrFdZEgjFFL6+ZnXgrWzbWlNyNhHbX1OS3OCvzHxqBK2HwfUnGkp4Q8c0lAtRQ87aFIO92T4fEy65i97Cv/ncId4wiE+89GthTojyYnDhM8UKbUjBiM/qMxkqEqURcVnd3bDWDfTv2uR4eXf2R6XZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616753; c=relaxed/simple;
	bh=Xc9JIcJ5tZ/hkJqVabouvK2yaEMKFNhceFeC8ZkDcNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M+pOE1JvYRSOf2UvdrXrucWd8L/Cw76PZDTcpB3Roz2LeLZiwmHOfIXWBjkfYvwBDiYwb0xZBrvKRwyvB+o5FbIyArNEPLAFt2qqPxn1OFJD7Exh7RAXq/zhmwoYkhiQpUcfjiuy3xKN6A+KMm7k1nfnFdLn8SCFkHUyHU93nAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mn4+cd0x; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so34275041eec.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 19:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775616751; x=1776221551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2f0Yof1DLXmda+Ua8QZmvkVah9DOsLozAWk9vmUBRA=;
        b=Mn4+cd0xpBy7ek4ATccBqepKgfmxBtiItjN22LRHilvyWWxidt7/meYupouRTlRJGa
         7cuezWpoEhPrs8awJWz5DEQdjB3TZBphBLwDoQvGhKh4Df5fKK8Rs3BP38ju6w5fBtc+
         Y+tji1yqz4a9ZZbyENhDLbcfC760f2GBdwimF7rL3+2opdNgJqpv3pOGP91E19U2GiGq
         MJ9Kr9fGEbN4ioli20X4zu8nZMu0kZEDp35PBYl0qzF83nesMGRwzzazgHcx3ocL6QMS
         wQtIEYGI3H5e/H2NcYh4GY+wLuHDdSwWbhdEKPD6tfHPWJBI8/9cN26twQPjYYfllTNW
         ETSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775616751; x=1776221551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2f0Yof1DLXmda+Ua8QZmvkVah9DOsLozAWk9vmUBRA=;
        b=qpmfnPVdvh73KxAjK9zQlxCsG7Hzw8dJnHG21FzkFIuB7L02gxGmis2mepBXjrviDk
         GhBzMYpl6NUPhCm5hsYIklxVgekiwgPiqfxCiTdJc0Dp3GKo5mkhjN+lOR4cNRw+ZR50
         YoyIqcEjuNbNfTpFHxPj02h41G9m7gvgjeOVjRbYqskI03rPIHfBRKWW+YGN7sD514Xe
         CjaW/uGq+0K1LWD2mQD0TCNzISGVvSikP7zESerAW0qBTaS+ZAe5YH7GbWcMoVvQfZre
         V1RxgNdOhVoyxaec9AFcYx9DjKinKvQmBLh8ttadZqWLxMN2TxFeQxiMTN9PtlcJ4M09
         qbvw==
X-Gm-Message-State: AOJu0YzkWqEoMqzE53aTYgeyOSJVKKV8WzjzptZrUI4nFu0Au15vzEZq
	BAI4GC3kpbgl3m3pv1KIL8Bq5NoM8pUrhrl/o+BrOheRXCQD77JJYmPq+peUyzpDeYSsrGybk3k
	/ioq7E/+ir2Zc/zC0zmZD3Q==
X-Received: from dyaw3-n1.prod.google.com ([2002:a05:693c:4143:10b0:2c5:2b09:16ef])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:dc88:b0:2c5:3b87:2fec with SMTP id 5a478bee46e88-2cbfca5c3c3mr9675586eec.31.1775616750606;
 Tue, 07 Apr 2026 19:52:30 -0700 (PDT)
Date: Wed, 08 Apr 2026 02:52:20 +0000
In-Reply-To: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775616747; l=3679;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=Xc9JIcJ5tZ/hkJqVabouvK2yaEMKFNhceFeC8ZkDcNI=; b=2tGrfq8QKie9svHpoZm/C1pa+XSVE0HMxc1jYKrhz70twfNKSQhHWJRvLkTuv0kq3x5+Hgsi+
 kor24m5SRTIB1P9bELhgNUVWD/lPC+lQ5lKtsKq2LOIwElTCus7ofAl
X-Mailer: b4 0.14.3
Message-ID: <20260408-teaming-driver-internal-v6-1-e5bcdcf72504@google.com>
Subject: [PATCH net-next v6 01/10] net: team: Annotate reads and writes for
 mixed lock accessed values
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>, 
	Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276246-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 3DA4D3B65CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The team_port's "index" and the team's "en_port_count" are read in
the hot transmit path, but are only written to when holding the rtnl
lock.

Use READ_ONCE() for all lockless reads of these values, and use
WRITE_ONCE() for all writes.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Marc Harvey <marcharvey@google.com>
---
 drivers/net/team/team_core.c        | 11 ++++++-----
 drivers/net/team/team_mode_random.c |  2 +-
 include/linux/if_team.h             |  4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 566a5d102c23..becd066279a6 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -938,7 +938,8 @@ static void team_port_enable(struct team *team,
 {
 	if (team_port_enabled(port))
 		return;
-	port->index = team->en_port_count++;
+	WRITE_ONCE(port->index, team->en_port_count);
+	WRITE_ONCE(team->en_port_count, team->en_port_count + 1);
 	hlist_add_head_rcu(&port->hlist,
 			   team_port_index_hash(team, port->index));
 	team_adjust_ops(team);
@@ -958,7 +959,7 @@ static void __reconstruct_port_hlist(struct team *team, int rm_index)
 	for (i = rm_index + 1; i < team->en_port_count; i++) {
 		port = team_get_port_by_index(team, i);
 		hlist_del_rcu(&port->hlist);
-		port->index--;
+		WRITE_ONCE(port->index, port->index - 1);
 		hlist_add_head_rcu(&port->hlist,
 				   team_port_index_hash(team, port->index));
 	}
@@ -973,8 +974,8 @@ static void team_port_disable(struct team *team,
 		team->ops.port_disabled(team, port);
 	hlist_del_rcu(&port->hlist);
 	__reconstruct_port_hlist(team, port->index);
-	port->index = -1;
-	team->en_port_count--;
+	WRITE_ONCE(port->index, -1);
+	WRITE_ONCE(team->en_port_count, team->en_port_count - 1);
 	team_queue_override_port_del(team, port);
 	team_adjust_ops(team);
 	team_lower_state_changed(port);
@@ -1245,7 +1246,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		netif_addr_unlock_bh(dev);
 	}
 
-	port->index = -1;
+	WRITE_ONCE(port->index, -1);
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
 	netdev_compute_master_upper_features(dev, true);
diff --git a/drivers/net/team/team_mode_random.c b/drivers/net/team/team_mode_random.c
index 53d0ce34b8ce..169a7bc865b2 100644
--- a/drivers/net/team/team_mode_random.c
+++ b/drivers/net/team/team_mode_random.c
@@ -16,7 +16,7 @@ static bool rnd_transmit(struct team *team, struct sk_buff *skb)
 	struct team_port *port;
 	int port_index;
 
-	port_index = get_random_u32_below(team->en_port_count);
+	port_index = get_random_u32_below(READ_ONCE(team->en_port_count));
 	port = team_get_port_by_index_rcu(team, port_index);
 	if (unlikely(!port))
 		goto drop;
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index ccb5327de26d..06f4d7400c1e 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -77,7 +77,7 @@ static inline struct team_port *team_port_get_rcu(const struct net_device *dev)
 
 static inline bool team_port_enabled(struct team_port *port)
 {
-	return port->index != -1;
+	return READ_ONCE(port->index) != -1;
 }
 
 static inline bool team_port_txable(struct team_port *port)
@@ -272,7 +272,7 @@ static inline struct team_port *team_get_port_by_index_rcu(struct team *team,
 	struct hlist_head *head = team_port_index_hash(team, port_index);
 
 	hlist_for_each_entry_rcu(port, head, hlist)
-		if (port->index == port_index)
+		if (READ_ONCE(port->index) == port_index)
 			return port;
 	return NULL;
 }

-- 
2.53.0.1213.gd9a14994de-goog


