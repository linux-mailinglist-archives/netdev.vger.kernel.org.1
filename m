Return-Path: <netdev+bounces-274907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIZtNDVpz2lPwAYAu9opvQ
	(envelope-from <netdev+bounces-274907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:16:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDEA391A08
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45CF0303B4E9
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347E7377EC5;
	Fri,  3 Apr 2026 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsprvlM6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC90372ED6
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200473; cv=none; b=PP9ApRlNvJoOqeIg6eHCyI/n2a7No0yUZvgYrIktM8Ns0f0y21Z+qG2E96MowN4vpUxYAuZq34l7spjX/kuEQ0eVEwT/scdSCirtrIJxaTy21nFQuqXvkDK9NTnp3fKgZgZpHeGmYAgJHjCePtWwQitDKaCm16UBey8MGdakuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200473; c=relaxed/simple;
	bh=6pngi6AbJj9IjokAnMcUuaAPhwS8Is6Gt3b4MrrqM2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UcYmJ9En+xbB1+cFD0r2xJ5vVYlc1ti/d5x9q82Ncryu8vWoYV3kenMHHtUR/6dK1xifzQvGZOb25D2snb0H2WXs4CT1VHhsS1BiWQ5tBt/zPhVlMVyQERyY5E4EztRLIG2wBrwOXVe4VoRXvNrv8FkTxtPJDbsj7wH0NtqcFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsprvlM6; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2cc75e79b97so1172420eec.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775200471; x=1775805271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9tx+KxgSxiX42Rwpk7xjo8R+fCKMdHqCETpVq4j3oU=;
        b=GsprvlM6/t/1Tc1evZyoVFsDaUfHPBPrpFLPEeb86kfa8e+UBp/yQnW8OySMeYYysr
         Ba0TjZNq5BR0+2joeRgfi3yKvg3oagM0oEvdafRya/z797RY8FW2sLVUfBXUTNqGGsdL
         g/ZL+AVoFeRTN6fT99Uq9xAiD84HfM+1XBLkKyBNqNJbUUBNSl9t8PDgryCklY3KBKjZ
         2GC5Kc7tpJt/RHodOyZYw2QSXcf9vxB+6Lu+IgrOvuWTuF1sx5DuNyOp5VeB3/qkZ5Gd
         Y8RFQ6TL88xvV6fcqNITQHs0Wg/yxIaqfQt0Kk6Dwj4VktN8h9CgHQ2A5bh4MHmRk9mB
         yF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775200471; x=1775805271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9tx+KxgSxiX42Rwpk7xjo8R+fCKMdHqCETpVq4j3oU=;
        b=Oiw9z5EWrA/fWExrimxEP0iSBavOaAq+HuaFLn7rkojRB5GijTSqry2napypfziF1L
         Vq7beAbM/HM1UQbvBn1svO5e/x7TMT24lluEtTxq6i16mqc3LKNbbyyEsMtP6B3tt9Yz
         QjCmYIa2CORoOWzYqn/1ZzMqj2eh6dDInJi1zUz9DK2NRsh+WdcazdSCWoY+e3EStP66
         Is0EpSdLDzz0oc7o7/IyUTsn5+SJ5NQos5kfVddaQ0vHzZB21OCV50r6KT1hS27d8do9
         BZxUuD05qM0STCZ7c2PPmMExZ1nfHp2v8FfOxiOnXb7t3sqyNwgEX0gkVm7nGYXnWALP
         qtIg==
X-Gm-Message-State: AOJu0YyS5Fe6BNDyoxahJfayjLT4KHQwbp2Gbix532jkE/mqmk8Akbne
	DlkD05qYuPeGd/SQyaeVERwQ/ME7lY9dY5MXdGVuS3U4hO6DRCqPfiBTHJoWnYCLeBQl5TV4aSf
	rngZHA7sPB2pKNOTNuW5GYQ==
X-Received: from dybpk7.prod.google.com ([2002:a05:7301:4287:b0:2c5:d9bf:436c])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1e87:b0:2c6:cdb3:bd8d with SMTP id 5a478bee46e88-2cbf9afd61emr1068538eec.7.1775200470904;
 Fri, 03 Apr 2026 00:14:30 -0700 (PDT)
Date: Fri, 03 Apr 2026 07:14:22 +0000
In-Reply-To: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775200467; l=3717;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=6pngi6AbJj9IjokAnMcUuaAPhwS8Is6Gt3b4MrrqM2Y=; b=4kA3H08ExpxSDoz7Uk31FsSlbiXlBRJodlvsA8hHkFHhJOG41Za0obB3F3DKo/OyB+4DFTaut
 JpxnL9txSO6BS8MXI0ukTtUr9fBqS4lbzm/Z5RQY9U43zJBlDb9uMW2
X-Mailer: b4 0.14.3
Message-ID: <20260403-teaming-driver-internal-v4-1-d3032f33ca25@google.com>
Subject: [PATCH net-next v4 01/10] net: team: Annotate reads and writes for
 mixed lock accessed values
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274907-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4BDEA391A08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The team_port's "index" and the team's "en_port_count" are read in
the hot transmit path, but are only written to when holding the rtnl
lock.

Use READ_ONCE() for all lockless reads of these values, and use
WRITE_ONCE() for all writes.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- None
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
2.53.0.1185.g05d4b7b318-goog


