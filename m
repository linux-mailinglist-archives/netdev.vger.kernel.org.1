Return-Path: <netdev+bounces-275519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBQsHSAk02n1ewcAu9opvQ
	(envelope-from <netdev+bounces-275519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:10:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0143A1431
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD85304E0E0
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 03:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A7D33B966;
	Mon,  6 Apr 2026 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZxsBvKs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881AC331218
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775444707; cv=none; b=hUfB+GFB8nAlCgr4oS5RN2KX2uxpj97x9FZknwfEwtSmZ/ud0WIRPHzz8gbXiIcVfPn2sM2P3/SGyUoG7UBiLeXHSGSTDE1/mgtkUtFnlWL4q9r96eAMrO19eAdHQ7ClBrDT41ZkIgRDBvADBRD5nOrJaxvR0FWIDWNumtB+0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775444707; c=relaxed/simple;
	bh=2rtJWUTXapLA4inY98q2d8R63sOMNqI7U9/VEg93OkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hOXwO3cF3Roqh/d1yvSuJy3yQKTRjCsPc8pVcx/GUvD8XpcgtVk+Bpo0LJQEbsawj7mdbU49T+aYUXfVAUVItgX4LnbdQBRCny1IxY31HvN2gJm1nN6nSFVi5BvahJGHHZhXPKEHMuQLUIrZ1evu1O12y3bV/11w7I/Myu/C3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZxsBvKs; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c3b8880ca9so4037372eec.1
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 20:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775444702; x=1776049502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ylM4a3PCnVxbY6JaU7231btKbSKhmAN8iSf776QMAk=;
        b=OZxsBvKsUwybtriZx5P5A4bgjxazVP6pEUCfTCo6udFeOxPDH4Fl0bjzZKPDsBvTIH
         Ua6JPgCg2TjbcMLv8FTpxAYN+jESMv3cHGA9lYEIDeL1S8thEljITC0vulf3qjdflRSQ
         DXZfCGWwZrCQVbl/Bq34EwfRpuAro3ckWHvYOJayxZPlW8lVFHF6zIr7nw4cbBqdRwvm
         gjVaG6dRAYj0I/DMbBRBGn1cX9FcPWMwKA+JSPm0mYRexs+SP38dSQlShFBAKIZ13bj/
         1zFC1YEY5v3zRH01b9gnDomR84yX59NLcsq3oWLK6e+VkxNBe2Qd1TRuNAPpghBYBulF
         yljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775444702; x=1776049502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ylM4a3PCnVxbY6JaU7231btKbSKhmAN8iSf776QMAk=;
        b=hKjg5i5o4k1YXxSEt+Wa86Z6ReFwr726OJ2wRVM5CAEkOFyJO4yI3s9PqwYVeE0H0J
         2U5Ek7KpjuHNZBpdzw8iECSDGylwCIW2jDE2PEBzK8f58ihpOu1AMQH4NPgtlVS44Ubo
         UT6xhULLX21mr+HbDm8xypHDqKM5Dtgb9PbFxY03DLvu46W5md7gFcKZfgdDL+h1Fv09
         72xizPZhqZFhmsaHyOtXo4i71fIdE4acFs5Wld1Y1Xqh23LUaOI/6hPAWaFjoar4P3He
         tN8PPDwLstXJB7XSPUFj4N95EJ4Tf0PkNNeuQCCE0YIc62oUHXDBW9o7bGZaHeTDs2cy
         J0wg==
X-Gm-Message-State: AOJu0Yw83uwdgY8fAeOoE5OenTSFEgXb3fuj2Slhylm0Y1TXvzFbxxNQ
	A4lOTgnsTwn8WRfuV4cIT1uYFNJ2Ig8vp6ySxf8T9h6Ta0fWaW4RSzh1xD0AafBbKl7e/VRDwGO
	5FYmmrWR1kbU/CQXID4Mgtg==
X-Received: from dyek19.prod.google.com ([2002:a05:7300:6413:b0:2ca:f172:3f06])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4090:b0:2c3:df83:1347 with SMTP id 5a478bee46e88-2cbf99e8c88mr5171878eec.1.1775444701521;
 Sun, 05 Apr 2026 20:05:01 -0700 (PDT)
Date: Mon, 06 Apr 2026 03:03:44 +0000
In-Reply-To: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775444686; l=2909;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=2rtJWUTXapLA4inY98q2d8R63sOMNqI7U9/VEg93OkQ=; b=BxSq+eNr8ZdlXRnHAOHVaohWryZua/Jefdw8xQDuoct4dJ6JFOKrEaBWCcnyXGmSQ3d+9qjHn
 x+ML9HbTiAGCIqHPUAJ5vfH/eY0FEsGb14Q/2RHkawT52ahl/8eERua
X-Mailer: b4 0.14.3
Message-ID: <20260406-teaming-driver-internal-v5-8-e8a3f348a1c5@google.com>
Subject: [PATCH net-next v5 08/10] net: team: Add new rx_enabled team port option
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275519-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A0143A1431
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
Changes in v5:
- None

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
2.53.0.1185.g05d4b7b318-goog


