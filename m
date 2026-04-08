Return-Path: <netdev+bounces-276254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLr5N6/D1Wkx9gcAu9opvQ
	(envelope-from <netdev+bounces-276254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:55:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB53B65C8
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF3793039B0E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EB937646E;
	Wed,  8 Apr 2026 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drY41N2E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92337756B
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616766; cv=none; b=BYBzNJEJU3q8qwoE7DRiIYOnU1OFbcuEtvjhIWoJSpXpoy+NfZnIQdw0TrlsT13sklZeWh8GaQv0bVvJ9cU7GWXOQwCTTKEEg9xeKH4o1nmxt+JLZWX/XP4CndSWKXAl13eOkSIwUajrkQHW8iAXQ2cglBbSmISyhRNXEeffl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616766; c=relaxed/simple;
	bh=ysjEMdXBV3p9t7KlXpwCVPcXO8bpDjU9ioNzjR4UBLc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JtQgsjPQ8TnVHyMCGow04jRe/Lg/RViSQwa0YEUh5nEQDKbiDCan8LlrEjyJ5mtJyBfa6vUW+/ilpsXGpG+Fh7t7JSd87xgZaJGqaWOiTrkQaf08phfXkj2Ke0R6nOBhnfJrWRdlwE5GFFyn+RF95QJwIJV/IdKBGY0+bJI1Rtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drY41N2E; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-126e8ee6227so9417393c88.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 19:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775616764; x=1776221564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrKcMgABSh6GKKrkwrLopmtbIwGc13QpOLpRzfT2BBE=;
        b=drY41N2E3LXUoirzE6wqMbHrW2gt9FP1ISpFr360Ppd23p4GSeHsC18yY9vJ5vWoyf
         UNV51Bk8SRVI5Tc9iZgZm7aMqJCp1uNgCZgrECbh2D3D3CUAUWdQpS7/kCzbr+lFb6lm
         Y3mOJH6fSbDpN/xh4PdEQNcjJ61z2GHeRmsv1pSIwz3XuIEsZgVj5GpZ02F/zupcK7v1
         6UbxU/Re+kDNwI9eBdHzkXbHSmliPOhw/oJ1QZbUNucaYzAjPt4LJ3z6Vpv88of1+fV0
         48ZDUCtDfIRV5PCgjFxRiEdelpxmOiOiDPeMnLzMTGOc15UqU9dWuTjjgyhoommZc4W7
         r6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775616764; x=1776221564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrKcMgABSh6GKKrkwrLopmtbIwGc13QpOLpRzfT2BBE=;
        b=JNHPtHD8XAb+GCLpogTZbhY4OvxJi5SreTbcaxWLESa/d6bsyzeFT6Eetva5z/jeYw
         ZE0ggE3pixGB3OT94jSjSuEvOxMmzgWHgAPX7tP9+H+9EfGcGC13OjQbYp8XzJHgm4Dg
         /I3L9UthDdsrfaHMx5e6oXRf+25mDOLuNUdZTEbjahrgexx6BzlPP8HgchY7/8o1V9Iy
         ZoVQqm4pAOLSrY8Gcdad2iKgPaeD2N9OG+Z9J6bz7+4BAOLeot9BOIemwyNnQC9e4w5p
         NiNLr+tFOasTC3rVtUpvGegPyr7f79oEEVy9WhNneSlo0wIVzfYl4OwJnBDTLNL5F3+w
         8xsw==
X-Gm-Message-State: AOJu0YwIsfcKEnvf/4ZfOyA19BZWVfK2yA4gqC49aruezjE/BmVR0R9W
	KPIaQ9PcqCAzueUb/WPTWziSJ8r6IVyE7T6i4tulwPqdumFkHyYQ6H4N9BmPfeQrLvqvAOGr3cD
	iIDlleIhmNeYqZ7UQYW5aJQ==
X-Received: from dygg16.prod.google.com ([2002:a05:693c:80d0:b0:2d1:13bb:389c])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:43a9:b0:129:ea6:a3c7 with SMTP id a92af1059eb24-12bfb639e37mr9363933c88.0.1775616763806;
 Tue, 07 Apr 2026 19:52:43 -0700 (PDT)
Date: Wed, 08 Apr 2026 02:52:28 +0000
In-Reply-To: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775616747; l=3270;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=ysjEMdXBV3p9t7KlXpwCVPcXO8bpDjU9ioNzjR4UBLc=; b=WeElomngepKKrGJFaACju/baucu5g7d7uyJDIiedsr2TZFl6fmNCZ5f84LzbH+BS/iv/umn/v
 guEdVAQ1CpWCBM6f6WPm69vVixdWTS2vfw5TSAkCT45G8SEiyd8iT6h
X-Mailer: b4 0.14.3
Message-ID: <20260408-teaming-driver-internal-v6-9-e5bcdcf72504@google.com>
Subject: [PATCH net-next v6 09/10] net: team: Add new tx_enabled team port option
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276254-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDCB53B65C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This option allows independent control over tx enablement without
affecting rx enablement. Like the rx_enabled option, this also
implicitly affects the enabled option.

If this option is not used, then the enabled option will continue to
behave as it did before.

Tested in a follow-up patch with a new selftest.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v4:
- New patch: split from the original monolithic v3 patch "net: team:
  Decouple rx and tx enablement in the team driver".
- Link to v3: https://lore.kernel.org/netdev/20260402-teaming-driver-internal-v3-6-e8cfdec3b5c2@google.com/
---
 drivers/net/team/team_core.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 67f77de4cf10..0c87f9972457 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -978,6 +978,21 @@ static void __team_port_enable_tx(struct team *team,
 			   team_tx_port_index_hash(team, port->tx_index));
 }
 
+static void team_port_enable_tx(struct team *team,
+				struct team_port *port)
+{
+	if (team_port_tx_enabled(port))
+		return;
+
+	__team_port_enable_tx(team, port);
+	team_adjust_ops(team);
+	team_queue_override_port_add(team, port);
+
+	/* Don't rejoin multicast, since this port might not be receiving. */
+	team_notify_peers(team);
+	team_lower_state_changed(port);
+}
+
 static void __reconstruct_port_hlist(struct team *team, int rm_index)
 {
 	struct hlist_head *tx_port_index_hash;
@@ -1007,6 +1022,19 @@ static void __team_port_disable_tx(struct team *team,
 	WRITE_ONCE(team->tx_en_port_count, team->tx_en_port_count - 1);
 }
 
+static void team_port_disable_tx(struct team *team,
+				 struct team_port *port)
+{
+	if (!team_port_tx_enabled(port))
+		return;
+
+	__team_port_disable_tx(team, port);
+
+	team_queue_override_port_del(team, port);
+	team_adjust_ops(team);
+	team_lower_state_changed(port);
+}
+
 /*
  * Enable TX AND RX on the port.
  */
@@ -1529,6 +1557,26 @@ static int team_port_rx_en_option_set(struct team *team,
 	return 0;
 }
 
+static void team_port_tx_en_option_get(struct team *team,
+				       struct team_gsetter_ctx *ctx)
+{
+	struct team_port *port = ctx->info->port;
+
+	ctx->data.bool_val = team_port_tx_enabled(port);
+}
+
+static int team_port_tx_en_option_set(struct team *team,
+				      struct team_gsetter_ctx *ctx)
+{
+	struct team_port *port = ctx->info->port;
+
+	if (ctx->data.bool_val)
+		team_port_enable_tx(team, port);
+	else
+		team_port_disable_tx(team, port);
+	return 0;
+}
+
 static void team_user_linkup_option_get(struct team *team,
 					struct team_gsetter_ctx *ctx)
 {
@@ -1657,6 +1705,13 @@ static const struct team_option team_options[] = {
 		.getter = team_port_rx_en_option_get,
 		.setter = team_port_rx_en_option_set,
 	},
+	{
+		.name = "tx_enabled",
+		.type = TEAM_OPTION_TYPE_BOOL,
+		.per_port = true,
+		.getter = team_port_tx_en_option_get,
+		.setter = team_port_tx_en_option_set,
+	},
 	{
 		.name = "user_linkup",
 		.type = TEAM_OPTION_TYPE_BOOL,

-- 
2.53.0.1213.gd9a14994de-goog


