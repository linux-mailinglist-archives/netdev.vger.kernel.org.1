Return-Path: <netdev+bounces-274915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGEGDT1qz2lPwAYAu9opvQ
	(envelope-from <netdev+bounces-274915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:20:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4EB391AD6
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D883030E3BBB
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65738C2D0;
	Fri,  3 Apr 2026 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3IczgZV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAD38A711
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200486; cv=none; b=m+kBaSeejef2IxIviDcKgpSSowfJCTx/brTkOcReumdUcOaenywQ9JtIl5VHeeaN+1IxJ6bLyVJKDeqdJLTWQg8zTbQR0BF2soCJlLL+EChwngO3akifFGvbO/ieybs6iDr0fBEnpVuvKpcQxgmfqT42h8HDYId9AKSZufEbjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200486; c=relaxed/simple;
	bh=tmxI5GX4cvbYDzW23oM8dCMm4F3jODVwv5cyJLTbatw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aWcF/lqEsK6EN63FfV6ua0BoGO9DvZT94xVWSNaPmtgwdPDYIs+BBsc8GAlgDoVBT70C0b4tujT43clRP8YoJS4ZSFibZCYIWLXyXwHNBErW0gjPiyAAMuAYd7Qvcm5ohjt0Mz4qCN15b8UJVTEle7Ed3m6gQnDq7C1EeMzabj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3IczgZV; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127133794b6so2499980c88.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775200484; x=1775805284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPACWJnTPULcN8fRgqAR/tqtJCCYKpSkXHAMdJtNRJU=;
        b=P3IczgZVojx1VwXRlwCsvVUPMdEMusinmpUufwkOtcx0KyF0SYMkcaelBIRKY7PV3A
         VHpx+kIPtAUurIw77hsYZY9Hiwij+tpZXCtWsqxWPAFRS1dYjYEXEFmfAJ6V6Eg5q+9c
         Sg7hOB3qFcA6HOLv37Efozi17pEyunbg36tsRf/mAfUlDQFiHJ1sQrmFFw2f8PxgpJ95
         LpsPoPjiBEQPKkMDp2oepl2TM6Aqsu6aBiXdMb21yDqOQ+jLmMW7iRFD28Z4gRV9m7zP
         RyEFS1jCTkDtYTDPwHZX4QjSZIFIuTntMXa+OIX3XQIXzNlL6j/dCfWRSv6yU1fk4I5g
         6WPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775200484; x=1775805284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPACWJnTPULcN8fRgqAR/tqtJCCYKpSkXHAMdJtNRJU=;
        b=ld9kpx7qLV3kNpLDPbtT3ZX5DtPoE77l0yIxOp71L+qjYADLEqn0JyDkFMf6pgvNa/
         Limpgc+giE0LtLBUJq+eF3nJbwhx0PIjp+o4ye5qfba2YCQRDDzBmxfj3TifTlMzfMwF
         XMydPieJU05BuvEtyOj2YWIbioM1BfUu0z7BRpJ0Hg0mjZjLkPSVFN2P0ZkWiwaLf+rW
         1Ksssb2sp3B5Va/DFJvaLGHVsh9O5LEl4wrDhN/HI5gacr2dbfR+wbxP9+P7mysUJPTR
         fji8zajmPYha43zWBB8jStwIrhkQvdnawn7go9iZ4SCLbk/+dNkh7dW16jwRExSCKM+E
         UIVA==
X-Gm-Message-State: AOJu0YwNBKjoTZ+I+K0Wv3e7SBPwDwCN6djDy0IOpzTJW1m7G75g5PO4
	tIgIKhuB1aAjWoOcRa7LnWoWJhZQrPwOOoXLcA2eWmFqxx9Na6FLZJwtpCcU8AP6stoWyBEMP7E
	2jstUgqbuev28j+yyK32hSw==
X-Received: from dlcio26.prod.google.com ([2002:a05:7023:c01a:b0:128:bbbe:13df])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6199:b0:128:cda8:3a12 with SMTP id a92af1059eb24-12bfb6fb2bamr971278c88.11.1775200484185;
 Fri, 03 Apr 2026 00:14:44 -0700 (PDT)
Date: Fri, 03 Apr 2026 07:14:30 +0000
In-Reply-To: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775200467; l=3227;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=tmxI5GX4cvbYDzW23oM8dCMm4F3jODVwv5cyJLTbatw=; b=KtmgsAigcobiNoLl6kqR/En0YpyY3Jk2exAFT4Y7yzITLbo29UzXnER0hkyz4NLjoVPuw3nob
 Hkh5MbP+sAPD6esM9NBtdYpgE8gePF3VywOB8PoOMoTA48GyuD3zpOl
X-Mailer: b4 0.14.3
Message-ID: <20260403-teaming-driver-internal-v4-9-d3032f33ca25@google.com>
Subject: [PATCH net-next v4 09/10] net: team: Add new tx_enabled team port option
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
	TAGGED_FROM(0.00)[bounces-274915-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CB4EB391AD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This option allows independent control over tx enablement without
affecting rx enablement. Like the rx_enabled option, this also
implicitly affects the enabled option.

If this option is not used, then the enabled option will continue to
behave as it did before.

Tested in a follow-up patch with a new selftest.

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
index 78c10111329f..b8f37054c717 100644
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
@@ -1530,6 +1558,26 @@ static int team_port_rx_en_option_set(struct team *team,
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
@@ -1658,6 +1706,13 @@ static const struct team_option team_options[] = {
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
2.53.0.1185.g05d4b7b318-goog


