Return-Path: <netdev+bounces-294229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +dp5MmrfHmqoXAAAu9opvQ
	(envelope-from <netdev+bounces-294229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:49:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF2362EA79
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:49:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=d7NlhSDo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294229-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294229-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D31130BA1E5
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D34C3D1A86;
	Tue,  2 Jun 2026 13:36:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641773E7BAF
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 13:36:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407376; cv=none; b=ATPIwTCUCnL/TvHc4m/lnn8R2GXKy/+90iWmqUPdzon0A2gh7JULlk4RsGwHpBWGg1pdr/D0FcSgWmnBaKbPahC91+jInTlmilJ+hhEjc4OQPDgvOx3MUkRdbTD3fDGw1vXmqwIrEg3tr8A72T5yxPZ/KnNk6r14HEzOQgcZPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407376; c=relaxed/simple;
	bh=SOLS464sCwsXb68FsuH5c593Tm26C1l/iV/hYt7J9QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lycRUHsnxmW5h5sDlob+R/HDsxdvVdrPEFh0/wo3awLV8LWMcUzKajlkh1wd+ZL9l5IMrIUA+RYfnI9pUWM8L3TA5BsNZu42bLnQ7NWnZ4vyFGscIUcNDl1qXICNXW3CD4fkZszWo6V+Ie5atnBtO0JYHScp6D6kioxf4uLU+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7NlhSDo; arc=none smtp.client-ip=209.85.222.173
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9157b895c57so55206485a.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407371; x=1781012171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILH0OeVmQKxRCdX8NaniLAKrB5+vOEdfNb+IKt6Bl+4=;
        b=d7NlhSDolCE6yiIhwR99pkdmFT4MCbhsmexwSqDzsRIV+UyBD41QlOUcV7zUGz96pe
         fGgwFErgzkOayrO9j7HfOqllvhs0tDyCO155j8klujjnleiZ03w/VXLX25vxZZCX/aY4
         7eBE2QPT2SreD2suke0fIjp5O2KiFnpAEqbfrVTiD2lZtMEPB2lRb3Rrqkp8O0UR5cpw
         2jpCb0S2R6CkMarqppGDY6qOYFreEYi6CZwZPQ2XyPkdrZy3EIwBb4McESvt+GlmEUQ5
         SBR3EBvfvPrhD8rZ1tNCBEXEnXe7ArJN8/BD7oQWiN/8eG/rNUQyOOUH5pyP26Pf0jDZ
         v7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407371; x=1781012171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ILH0OeVmQKxRCdX8NaniLAKrB5+vOEdfNb+IKt6Bl+4=;
        b=RwspD9PgzCG0/MFFtn2PcC2wldCYcHXVXD2AtFlH6naelEtAXgV2iyCSz9ijSFscNv
         AMwRPjP0fD0ORNQlwv7lEZzpXw3n0gKzHlR8sDIgNWDSaUTH0rkU1Bh58cV5tIk7c1pg
         5yCTNZRdD/DlHfzv7zYd+6Y0P/8y5xmF2RCTv6vtNRajXv35ANY4TtwaaMi3tjIBts4Z
         PYEoChk92yOTFx+twi5aRG6N0/z0lgPO3eJxysnEe3gcxkL+QjRExdIjMaajvfp6yV2n
         EPKW3Jw9SAYTfNBhdcT8JkBbVkRuehVQPEacYf09s2GPMQuDwNq6uMUh3st11y4Fb+de
         JWIw==
X-Forwarded-Encrypted: i=1; AFNElJ93SrvpGMsmOn5pWRXIOz9P+4PZPM5RmD1PeTLbt/g6t6bVSfiIIcnteTCQXPU996zZix8bz9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YytBCb/MTdWXbB79Yiy84nmEnZDC7z5l3MnWKoE3YnjHlr181bJ
	scWkX6vxnuopNdx9tmsMgO/rJ98QTcDOx19npKCj/gIGfdGzvTq+fs81
X-Gm-Gg: Acq92OFWFXBLyzifMxFif7kSXsAlnVAfWKnX+5Hx9ied2tqpsSHXm/zi5rIUMLDWZLv
	jBlvXarPz3NbDeE+xRoHzdYKQj6fmbMbqUObSu//MRcl3x338kD2paMlt/M3SpYVVODhkpDXqYx
	/3M6ZkMgummb1i/7t7XFWBhcBg+hgn3Nutqshp9A7B+Pq3rQqCKrBGh+xIgv/0/eGs0A3LbVU42
	piVAr7yQ5niz2yZMiqvtWwnLNoeFjG66/R0oIIiPU/Q0SXveYns9LtZnnMhIE3tGjf8mnd5H2TD
	oQC7ZZIZuPyscdlfPoMB4rQ+1MLYa7pgbdHsC76jwbNYWaLpshGKfdg27yFidWlZBapwNvP3lBU
	C8e1k9m+4GXNwOR2qHBhXWVHPN22Qp82NtMWddYEDSmlpm6T/IW43m0Oki0verba+QJim7Wy396
	5jMZ7Hom2S8eqJbRGqv4WW07vRxMwZXp1Iv02cqHyd7jzcGHRw+gi/KgZFCGYVqqrknuBcIPe3J
	EapFOBxM8QQflH3T2vdVXM+jfHLzwM=
X-Received: by 2002:a05:620a:284a:b0:915:673a:617b with SMTP id af79cd13be357-915673a62c9mr1075320485a.24.1780407370960;
        Tue, 02 Jun 2026 06:36:10 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915721f7d75sm346036285a.18.2026.06.02.06.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:36:10 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/4] tipc: require net admin for TIPCv2 netlink mutators
Date: Tue,  2 Jun 2026 09:35:52 -0400
Message-ID: <20260602133555.769727-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602133555.769727-1-michael.bommarito@gmail.com>
References: <20260602133555.769727-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAF2362EA79

TIPCv2 registers mutating generic-netlink operations without admin
permission flags. Generic netlink only checks CAP_NET_ADMIN when an
operation sets GENL_ADMIN_PERM or GENL_UNS_ADMIN_PERM, so a local
unprivileged process can currently change TIPC state through commands
such as TIPC_NL_NET_SET, TIPC_NL_KEY_SET, TIPC_NL_KEY_FLUSH, and
bearer enable/disable.

The legacy TIPC netlink API already checks netlink_net_capable(...,
CAP_NET_ADMIN) for administrative commands. Give the TIPCv2 mutators
the equivalent network-namespace-aware generic-netlink gate by setting
GENL_UNS_ADMIN_PERM.

A QEMU/KASAN repro run as uid/gid 65534 with zero effective
capabilities previously succeeded in changing the network id and node
identity, setting and flushing key material, and enabling/disabling a
UDP bearer. With this patch applied the same operations fail with
-EPERM.

Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/tipc/netlink.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index 1a9a5bdaccf4f..8336a9664703f 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -152,11 +152,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_BEARER_DISABLE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_disable,
 	},
 	{
 		.cmd	= TIPC_NL_BEARER_ENABLE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_enable,
 	},
 	{
@@ -168,11 +170,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_BEARER_ADD,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_add,
 	},
 	{
 		.cmd	= TIPC_NL_BEARER_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_set,
 	},
 	{
@@ -197,11 +201,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_LINK_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_set_link,
 	},
 	{
 		.cmd	= TIPC_NL_LINK_RESET_STATS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit   = tipc_nl_node_reset_link_stats,
 	},
 	{
@@ -213,6 +219,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_MEDIA_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_media_set,
 	},
 	{
@@ -228,6 +235,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_NET_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_net_set,
 	},
 	{
@@ -238,6 +246,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_MON_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_set_monitor,
 	},
 	{
@@ -255,6 +264,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_PEER_REMOVE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_peer_rm,
 	},
 #ifdef CONFIG_TIPC_MEDIA_UDP
@@ -269,11 +279,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_KEY_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_set_key,
 	},
 	{
 		.cmd	= TIPC_NL_KEY_FLUSH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_flush_key,
 	},
 #endif
-- 
2.53.0


