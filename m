Return-Path: <netdev+bounces-276821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMLoIF0W12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:00:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5233C5D58
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C47213020FCB
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 03:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950AE371D11;
	Thu,  9 Apr 2026 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUlGFsZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DE36EA98
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703597; cv=none; b=vAtUhRJciylAN4hcCof5MNk1y7hf7NgzSWTHXSQ8PrEaGrU3jsoS1kK5Rf2nZB1tvVBLBbADCHh8DyJdehTJvx8LD1dM99T1M+A9X0+RAZPbXWq7IZzHjfmLpHQrHVD/QUaWd4El/e5BDR2pDUUR9GB79rYt3ODDYxcNAm118nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703597; c=relaxed/simple;
	bh=dBMLccK+J+0/DzFeaxJbXeK8uOY7wkjClTEHtsz1Xv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dzr05dkaYD/fxAwUNKo++TVH0rmvhO9WPHNyMXA8WywF9sbjg+E5ggpIJfyAbTnJ1P1lQ3a80Khc2nMyZ+RKFXeG3CP8dOVICvbkNpVfC2QVhGW/+Kykd4dh7d5vvQEyHgZ2R+bKway8LABwVT2fWcm1Ti1MeXYgPHasWZ9TleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUlGFsZK; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso349629eec.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 19:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775703595; x=1776308395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5z3QxMvishe4U8CjYjl/4RpCskWtOirL2kQpSgWFR0=;
        b=IUlGFsZKt6MEnM/BfHeS4mPNnqDLrB8ZHjhbP/M+IQWcEAph+d1wLZPYc200VlmX78
         Llu27uQU5/fPigL2LlILeUNQke8yHqfX/31FvQJfisej/BzW/l2cbXdWmBaeSiLDQvoK
         uWwNW9fn7zXJJOxPgwg6yPg1nWh5xiIsG+bWHu+ic47rD2t1tbTl6jhGhgz8FYUbDNmO
         ySY4/hdbq9TTqqmkoZUGhiH1n4GegTmeoqHzvi91qBs8xnDHemDH4vczZcpng31lWa28
         TuxpL+SSQPDIF7BE2wZi4kirRbat8yYVz3k3Tr1s+Pm5DCI+3/ReE6VYhYHkvCIwjmzC
         UMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775703595; x=1776308395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5z3QxMvishe4U8CjYjl/4RpCskWtOirL2kQpSgWFR0=;
        b=o8fAtojw2nK/62WMnlm8ZHgb1ycaJ0gJVBNNcC5kchHv8T8LA527qFIUeYc+IbHGnO
         Zb5x3x3mm2EBoA1E9JUyEzszCNWdC7KX2MrQhCKaLaCeARh9SZZJiOSZl5REKpg/HdFD
         Eesj/7aHs0J9cP83fY5Zo1Il01hUCZYSzxvmH7LxRwogGlYsXv6C7iRBKXne9nVnqURL
         89Op3j+RYhvTsUvqB5RdsZmRbe+ZsNd59z+YZlEFj6WxYw1TZvccEId3gqCW+Ww7YusS
         zVRD/QYnAhi4ZZ96jDq0B4y5ntcSiCUyD92BL34f/LfJi48uLbMHCqGKtlb/qulxkhod
         ESDw==
X-Gm-Message-State: AOJu0YwaZFB+eKwSprkvPgzVCZ1//riPJdYhuu81uNa0P1ZAC3/MJMno
	nzjzHTkvxYGmJlcdQcDPr8fVViLdi+/3uwVCLBOBnSPaemcm1eLBrYlwvCC7f7gpJU9KF/btw9J
	4ho7BFKpbr2OASB3GBvSltQ==
X-Received: from dyclw17.prod.google.com ([2002:a05:693c:2111:b0:2cc:9943:d1b2])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:8628:b0:2cf:ec48:6307 with SMTP id 5a478bee46e88-2cfec4872a9mr7743506eec.25.1775703594393;
 Wed, 08 Apr 2026 19:59:54 -0700 (PDT)
Date: Thu, 09 Apr 2026 02:59:30 +0000
In-Reply-To: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775703578; l=2926;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=dBMLccK+J+0/DzFeaxJbXeK8uOY7wkjClTEHtsz1Xv4=; b=NfiqHhmi+/BfDNh7E9CIFLUwHq+1gOvaeCT/08BmemUkVpaz6yFOMDD/LCYUJuTYQxFPFZUAn
 Wj/63nDRYlPDSFjSPUlWEz1YuYyj1kouEbo7A0n1Zp4tTE+ffdFLBRd
X-Mailer: b4 0.14.3
Message-ID: <20260409-teaming-driver-internal-v7-8-f47e7589685d@google.com>
Subject: [PATCH net-next v7 08/10] net: team: Add new rx_enabled team port option
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
	Marc Harvey <marcharvey@google.com>, Jiri Pirko <jiri@resnulli.us>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276821-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 1A5233C5D58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow independent control over rx enablement via the rx_enabled option
without affecting tx enablement. This affects the normal enabled
option since a port is only considered enabled if both tx and rx are
enabled.

If this option is not used, then the enabled option will continue to
behave exactly as it did before.

Tested in a follow-up patch with a new selftest.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v4:
- New patch: split from the original monolithic v3 patch "net: team:
  Decouple rx and tx enablement in the team driver".
- Link to v3: https://lore.kernel.org/netdev/20260402-teaming-driver-internal-v3-6-e8cfdec3b5c2@google.com/
---
 drivers/net/team/team_core.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index e437099a5a17..67f77de4cf10 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -941,6 +941,28 @@ static void __team_port_disable_rx(struct team *team,
 	WRITE_ONCE(port->rx_enabled, false);
 }
 
+static void team_port_enable_rx(struct team *team,
+				struct team_port *port)
+{
+	if (team_port_rx_enabled(port))
+		return;
+
+	__team_port_enable_rx(team, port);
+	team_adjust_ops(team);
+	team_notify_peers(team);
+	team_mcast_rejoin(team);
+}
+
+static void team_port_disable_rx(struct team *team,
+				 struct team_port *port)
+{
+	if (!team_port_rx_enabled(port))
+		return;
+
+	__team_port_disable_rx(team, port);
+	team_adjust_ops(team);
+}
+
 /*
  * Enable just TX on the port by adding to tx-enabled port hashlist and
  * setting port->tx_index (Might be racy so reader could see incorrect
@@ -1487,6 +1509,26 @@ static int team_port_en_option_set(struct team *team,
 	return 0;
 }
 
+static void team_port_rx_en_option_get(struct team *team,
+				       struct team_gsetter_ctx *ctx)
+{
+	struct team_port *port = ctx->info->port;
+
+	ctx->data.bool_val = team_port_rx_enabled(port);
+}
+
+static int team_port_rx_en_option_set(struct team *team,
+				      struct team_gsetter_ctx *ctx)
+{
+	struct team_port *port = ctx->info->port;
+
+	if (ctx->data.bool_val)
+		team_port_enable_rx(team, port);
+	else
+		team_port_disable_rx(team, port);
+	return 0;
+}
+
 static void team_user_linkup_option_get(struct team *team,
 					struct team_gsetter_ctx *ctx)
 {
@@ -1608,6 +1650,13 @@ static const struct team_option team_options[] = {
 		.getter = team_port_en_option_get,
 		.setter = team_port_en_option_set,
 	},
+	{
+		.name = "rx_enabled",
+		.type = TEAM_OPTION_TYPE_BOOL,
+		.per_port = true,
+		.getter = team_port_rx_en_option_get,
+		.setter = team_port_rx_en_option_set,
+	},
 	{
 		.name = "user_linkup",
 		.type = TEAM_OPTION_TYPE_BOOL,

-- 
2.53.0.1213.gd9a14994de-goog


