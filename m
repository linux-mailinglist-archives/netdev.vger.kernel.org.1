Return-Path: <netdev+bounces-274909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFt3Lappz2lPwAYAu9opvQ
	(envelope-from <netdev+bounces-274909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:18:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E074A391A7A
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14CB13037BD1
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895EE37EFF3;
	Fri,  3 Apr 2026 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4g99Lkd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3254437C911
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200476; cv=none; b=SSmKNN3FPigwjGXdDCXUk1uXNAkyQJxXanif/j3//ARCv0klnVeBGNuot9GPmRrL4Sfojs6aswmOnLh4IzHKVGdUCUVUkfOh25AUUmOy7dVvFT8ziH2InvjmfxQVa3eZVpl92lZZbxIRrZOUXXfdJyqDnLRfiSMa+wPVWGO2uRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200476; c=relaxed/simple;
	bh=/N3Ja4dG8+jpoPt6AyAOHBDaHZGDjq1at+rTrxPopSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iwDWFt3ABcRVhHu2v5MoGzEBy8mxtla/KMPB0SVk4oxxQJZPxvkiahEn0ejTrdlhHCSiIe8gkL9tx+onRcx0gn4G3HUkLTFrkZdz62I/FcS/BtuPZwwAzbHib43jMzuNnTGnXoTf1FUsR6xo+2PVc/LFXHA4mwCyMfn/VuvcbJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4g99Lkd; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1270dcd11c1so2780709c88.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775200474; x=1775805274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/oRMa+U4zWiyNm2ajh9HytcVZ9+GoADzxNsQhgJNjBI=;
        b=j4g99LkdW4vMmUjAsT3fHAIWFmbEtnRYFdscXqh1SneuBW3dlJN3GF2VHeyP3k6gW2
         kEFt86KSwn6dFpzBHYOo9LYlrzqyn/SD0BMVUDKm+GI9w7aQZGyvYSp9Cwr/6Y97QczK
         hiEOHEhQAw2TIKSWG1bUAkWpFmveueEzk3psoLDsFUlOzepPtT5TVRvbL5VYGJTl/A3o
         K3GzxWEHR0s/wA3tZIbNJyiMYdsRm6hZHhH0XtB1sWk3nbbaCG9Sa6BTKCobZN4RImyv
         bqbic2FgTWnujgIF6L4mG+sdIrkSi+b34lyCZPc8tLYo9fxt/dVaYUhk0wR+3GZeNesf
         cZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775200474; x=1775805274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oRMa+U4zWiyNm2ajh9HytcVZ9+GoADzxNsQhgJNjBI=;
        b=gfuNkY88ouEPzVPMT2mXNUAQUlNegSB6ra8fTaGU1wGmsayjvjlxVGmPyEAVgyTlom
         JAiMHI+PSr1RIHsmZDKL3eCCkdmo2zF10q5+RHaZwnRvBcZ8Lfu3wC69yUAUIxrBLevd
         1YokCft+dANEviFQseeHKMwPAZw5zKvWoq12XjAjr74NIPW5WcyQURgaekGr+/ENDHbD
         3E0UFTNzCS9M2oLAzk/50lGsWcdWAHPyLRmH9d3qEdgL02SqzHOADcw0bIOyGzJHUkRV
         1YPigrdcB63WEpmurHGfiR7EUVRMuYhPQzCGOaG6QjUGHg6TWaqkvDH7MRAuueXxBuGk
         Uyxw==
X-Gm-Message-State: AOJu0YyPr1boGGx5iPPhcRi36A62ic1H5sP3OK/Yj9g+mAx/eGcE8wKV
	V/T4KcGFBwLbKKCnPBsZyr3P0FR0O+EGJS860Rex5yhLemNWM7/0MJKwDetWlqI3Ar4G0qoOzxf
	qUHHP8IuYGS/Cn3cIxt74RQ==
X-Received: from dlcio26.prod.google.com ([2002:a05:7023:c01a:b0:128:bbbe:13df])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:b0c:b0:119:e56b:98a4 with SMTP id a92af1059eb24-12bfb700b66mr954561c88.11.1775200474159;
 Fri, 03 Apr 2026 00:14:34 -0700 (PDT)
Date: Fri, 03 Apr 2026 07:14:24 +0000
In-Reply-To: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775200467; l=2585;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=/N3Ja4dG8+jpoPt6AyAOHBDaHZGDjq1at+rTrxPopSQ=; b=HHr4OYKRZ3b9aY/0kw0j+0+dy3qCGxeh/d9NEuDX6U8rTwBUfqCDbTi1xEgr7R9xcYz7GuBwK
 MGZ4WUfQsfGDXNPwfAC+u/mZi5GvXYzxuP09k+eEpbRt7vDg57RY7TM
X-Mailer: b4 0.14.3
Message-ID: <20260403-teaming-driver-internal-v4-3-d3032f33ca25@google.com>
Subject: [PATCH net-next v4 03/10] net: team: Rename port_disabled team mode
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274909-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E074A391A7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team mode op is only used by the load balance mode, and it only
uses it in the tx path.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
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


