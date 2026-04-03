Return-Path: <netdev+bounces-274914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P/SLjVqz2lPwAYAu9opvQ
	(envelope-from <netdev+bounces-274914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:20:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE2391ACE
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC4F73054CD0
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE1B37BE65;
	Fri,  3 Apr 2026 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyj9MDqa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7C386C36
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200484; cv=none; b=HjWgWVt4sElXvaPi4HPGqkWdMF2oUYSbNNDxqZEi8OOwbpEYyzhdPSQdtusrP0/12oliCTuPpGxh2gVidlGWFkCJxI+gkQ2EULcT53j8yFtFjUxtB6+jlfVeQDJuXhF1QyVBgqVcYu0MGmgYJxnYBsAYORwPU24kV1kGnJSf2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200484; c=relaxed/simple;
	bh=nuo0DHK7VQ/i6dfq7yT/KT+VIJKVcVO1c6MvP8D9yp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S4zLH+2rWIOoqNmWNCpT33a5lEIOv5Jc3WcyIPcGaLtNpyMkNfK0eyJbtWAnBn0qkowZqUlRO1AtzFg75vuco1vji6Wn4uajgyMz0tunTbBrMJsf50/PYbKs/xv3rKqtpTZAtSDbhL1mr5pOkOL+A4/wsY8QnB0sAUJCAJysWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyj9MDqa; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdd327d970so1121523eec.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775200483; x=1775805283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ5euJZqrhZn3iV1Pl7AmL73nfBI/YKGmKDSeBhbmog=;
        b=vyj9MDqaq1WVcjX4687B0ntn3RhsLvhAY1GwU6Ps4rHrZBdqZykqL7AvvfojPNDznC
         cXE9cWGoU+/Exbq8NUKwiK3nqHv1AoYVpb8xmoaFYpBevhuObIVJ9RuuK4w/XHHuEEqi
         yr+3kyn2S4XfFwNlYyJ5bsyKbaUozL5suxsLyi8VOzzJ/N43RyfHiAduJg1W0wUaE0yC
         TvroGSNh8JqJRcKyAtGxI1WUJZQPkAsIfWOP0oK5sXaXoyjSIQ5YkF5ycwl8+g+D3h7p
         D8DJVH2pg1Rgm7hm4fXzv3QEd6hBRySP6TjMGJZCeVxH+1N7sTeW4+ukOF0FNJmjV8Tx
         aRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775200483; x=1775805283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ5euJZqrhZn3iV1Pl7AmL73nfBI/YKGmKDSeBhbmog=;
        b=d+E6MgZeqfbnsNr7g+FamcQ+YI90fLiAa4h7CM01PTMV0shpheL7DbitCJxXzXy1ZC
         yPd6GSAAQDVJlsNfnStA8DByesc5WK2PLJdZQnt9XX39disdiwmz8N2FspVZdoWf63Zg
         gqy2oNwmEbS1abSOVXlWm9in/89RK4xLNjt7Qg9ZD09yxmSHXP/XvyYRzuO8GCkzlSPD
         x+OyUaypvrYymkeqDV7WwNHnWrW9kkWzpiRabmJZDIJcW1VxLG3EnXGsLF+bwXbiyfYE
         zc49B9PpYuTkWlrP1XOBdEQRWajAE0QBilh4Ba9EUQx2ca5Rs6ZtbWND7eF/bQf5gLrR
         rHuA==
X-Gm-Message-State: AOJu0YzsKgbXv/5uF/wuF7R2d3M3sNfWpb8T+ym+QEhqWlo0ZEJ0BCgi
	SsPFJESMn1pTYqY14DlK2x7pAh6o3z6JwGoic8k/6+iiFIcTfI3qaV3ZIDMTyfl3x9ZdFJRqoxb
	lUZqhKQ+2l346oQxMfv0czg==
X-Received: from dybph22.prod.google.com ([2002:a05:7301:4196:b0:2c1:5ad0:b659])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:1284:b0:128:cf41:d6e4 with SMTP id a92af1059eb24-12bf0899182mr2300718c88.21.1775200482416;
 Fri, 03 Apr 2026 00:14:42 -0700 (PDT)
Date: Fri, 03 Apr 2026 07:14:29 +0000
In-Reply-To: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775200467; l=2883;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=nuo0DHK7VQ/i6dfq7yT/KT+VIJKVcVO1c6MvP8D9yp0=; b=Dl7qLYfcAC/GnZzJvEtW3P4+XWtI0Wi8e+Y5Gw1vvAXU8OB2dic9jCu0ecn6+TUUW7l+0OD1N
 rIgAOrDO8ioCSbACUasgZbgAkcZDf97zf5Rs4rwRgZE7mmjP0hCZ716
X-Mailer: b4 0.14.3
Message-ID: <20260403-teaming-driver-internal-v4-8-d3032f33ca25@google.com>
Subject: [PATCH net-next v4 08/10] net: team: Add new rx_enabled team port option
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274914-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E0CE2391ACE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow independent control over rx enablement via the rx_enabled option
without affecting tx enablement. This affects the normal enabled
option since a port is only considered enabled if both tx and rx are
enabled.

If this option is not used, then the enabled option will continue to
behave exactly as it did before.

Tested in a follow-up patch with a new selftest.

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
index 0f95f2f04d27..78c10111329f 100644
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
@@ -1488,6 +1510,26 @@ static int team_port_en_option_set(struct team *team,
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
@@ -1609,6 +1651,13 @@ static const struct team_option team_options[] = {
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
2.53.0.1185.g05d4b7b318-goog


