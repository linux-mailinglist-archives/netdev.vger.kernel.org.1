Return-Path: <netdev+bounces-296137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jNi5B/pxJGq96gEAu9opvQ
	(envelope-from <netdev+bounces-296137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 21:16:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1C64E1AD
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 21:16:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="hCsv7nO/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296137-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296137-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A108C30421F4
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 19:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188753BED59;
	Sat,  6 Jun 2026 19:14:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33B3BED1E
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 19:14:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780773273; cv=none; b=QMPrVlIH3sWCFM4Btua7l81vLuyTrPDpv+r7Z45tRoaeKNAxf1v+DDykBFmNMU94XNRkPqBn1gZMy45JjCJRLtvTMPHKmdIRVO4yeduOChmnj04zXteNpqM7xWCb/1BOBEIqO3T4GnPvHWZBGZYVxk9mHd/NMN7z8j6nbykeOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780773273; c=relaxed/simple;
	bh=ZNWWAVNfC9RmhryDBGopsCMLOBQ2uMLl+zRSZ1fBt4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2q2IukfN4cv3r8De36jj8iGzNA6YV0QMuNP0mE3mRA/b7kv+whV6SwRgOh+sbObBsv7aOsUx+Dwte4cHrkEDRBSeLjP9jzpDPeCZAGAfTgoPyM8X1iZOTz1mAGzRMoPJGCjuVi0MLkHUZ+n1WpPO5q5fWI24KPR8qg3ebFQYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCsv7nO/; arc=none smtp.client-ip=209.85.222.180
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-91562bf6c12so397873285a.2
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780773271; x=1781378071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPe7RROwML8YBDC9iBsnC3XTfs6XjaM8KgeZwP62gHY=;
        b=hCsv7nO/m08km98c5OH5PlYLTPM75hCRY5tfm9PaE2xLdiZy8J1CLbGCuK1WbyB1a/
         u++UicEBYGgKxCo74NrY3nk2tjTOKVDFxuYoYM3B2jPpMKvjTcc+nuZop2brzoPjId77
         B7acPbElTpZ5Vw9vFvomTid6ZbH4Rj6EAcdggJhphB9sUt2CMNZSmLGjue1cbVNDdaaa
         EkQwsZpCe7D1FhxAotGsiMzwwbxzlejZycCN0eGnycQ6+CzPl/6VBQFU69ftjsmTmJkY
         JcIN7E6K46/M7wlAsXUBmyd/zX3yLaeT9dryKbMn3g2UcSHruwjxE9xAfgdAAqyhatI2
         wUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780773271; x=1781378071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPe7RROwML8YBDC9iBsnC3XTfs6XjaM8KgeZwP62gHY=;
        b=i46V3U4hC4cLFOQKimnIxk5MPwh8sXeH3p84Mw3l6xHDB+xxUHMJ72SO3SsJNm2Uis
         OndWo5e6necLQz+YFB3DstPRgx6cKND8N1tzTLxmITUnoS137VEbvEcxpJ1pFJetk+nb
         7Y7tREiR4nuHj2NHop2GsDP9WQHRh8e0RNuGFrM2uizQl/2XW8fme3HULKYW7xcLyUml
         GkTb6yNI4ItiHeZb7NQMmpgc9CvJPiFpqLopvivn6w509Ec3MyCR/iulltOzROvKJEji
         JkStDK7MSjnYxsO0hP+688CCkImd3GvCsIwQD1NF2l/BNCTXBmqvkHHo0PG9yBT5ZpRF
         CiGg==
X-Forwarded-Encrypted: i=1; AFNElJ/MUf0Lj1geBTFsaLibUvgcmuPMAxee9GOr72ku0Iu9/T10l6GuG69g8I6Ho8vaalJFP+lm/rI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wXYz/J1cpMUX+p1CBU3235Z26o7P5vyZyBHuRvh6YpWsotZK
	lSHtmhnYfVSUBIpUik8/MbOyYr5dGY4JqoCXSnBP6rfDahE8abp0Noeb
X-Gm-Gg: Acq92OFepY0+6XfzJUJcrTv3O37unXX46XxbTo9Q9ba6tRGibuni5aq6QZO+rsn5f6s
	HeOXkES0/FntnJkZetkZJJopf3A0v/cFGiPLlSt0UqhV3Et7+OPRIAZa0ycw9xlQEcrMqrKHSg5
	StRkw4hiK7vh8bRaB2d+dKmPn1eDDKa7Edcs7kpqKAgbojBNVEdSIuX+/AgF91lUFM/IaazDBGD
	jbBRLtt6fh3/3Hibi4z/AffT7gqq0aDaHWn/wI39l+H0G2ZQkyqR7FBxrlVBYLdOXO/d8AJz26O
	o2HsZ8O8iljdO/r0fYyZ/v7/9q1Q/wwmVQb5x0LETsO8sPzVMkoRjmcdCVx7EbE4n91ZW7bDg+A
	LvgSO4HYAEIGQ8VslrnW7WSGUvbXHaeYHTjNJ5Yy55vRrgEvmvOJZVMYM29enpFxu9qkvDrod6r
	esnQUTKoNmvZCvAELs+qamWkECIjkpdSG3ax/KCfn2SnFnkCxJejoZ7FkTrQTIarV0G9q5mZ50K
	znweEzOphsnRWYauhln+2RvN7xOH/E=
X-Received: by 2002:a05:620a:414f:b0:911:9e67:44cb with SMTP id af79cd13be357-915a9d6ed13mr1563014285a.38.1780773270628;
        Sat, 06 Jun 2026 12:14:30 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00a4f4sm1311699285a.3.2026.06.06.12.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:14:28 -0700 (PDT)
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
Subject: [PATCH net v2 1/4] tipc: require net admin for TIPCv2 netlink mutators
Date: Sat,  6 Jun 2026 15:14:10 -0400
Message-ID: <e5540b9165e1e54c98652383ef3c00d4d74d692f.1780766454.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780766454.git.michael.bommarito@gmail.com>
References: <cover.1780766454.git.michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296137-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BE1C64E1AD

TIPCv2 registers mutating generic-netlink operations without admin
permission flags. Generic netlink only checks CAP_NET_ADMIN when an
operation sets GENL_ADMIN_PERM or GENL_UNS_ADMIN_PERM, so a local
unprivileged process can currently change TIPC state through commands
such as TIPC_NL_NET_SET, TIPC_NL_KEY_SET, TIPC_NL_KEY_FLUSH, and
bearer enable/disable.

The legacy TIPC netlink API already checks netlink_net_capable(...,
CAP_NET_ADMIN) for administrative commands. Give the TIPCv2 mutators
the equivalent generic-netlink gate. Use GENL_UNS_ADMIN_PERM for
network-namespace scoped operations and GENL_ADMIN_PERM for
TIPC_NL_MEDIA_SET, which updates the shared media defaults rather than
state owned only by the target network namespace.

A QEMU/KASAN repro run as uid/gid 65534 with zero effective
capabilities previously succeeded in changing the network id and node
identity, setting and flushing key material, and enabling/disabling a
UDP bearer. With this patch applied the same operations fail with
-EPERM.

Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
Link: https://lore.kernel.org/all/20260604163102.2658553-1-dominik.czarnota@trailofbits.com/
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
- Use GENL_ADMIN_PERM for TIPC_NL_MEDIA_SET because it updates global
  media defaults, while keeping GENL_UNS_ADMIN_PERM for netns-scoped
  mutators.

 net/tipc/netlink.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index 1a9a5bdaccf4f..5bbe134284acc 100644
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
+		.flags	= GENL_ADMIN_PERM,
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

