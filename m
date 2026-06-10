Return-Path: <netdev+bounces-297662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O+owFDBbKWphVgMAu9opvQ
	(envelope-from <netdev+bounces-297662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:40:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F26695D8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:40:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KPqhoypF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297662-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297662-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C80430451E6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D844407CF0;
	Wed, 10 Jun 2026 12:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2E3BADB1
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:40:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095211; cv=none; b=VbwWe8yOis6egxTNnohBvbwr5Mb9TkbaKa6ccK7Y1DUl4Zamc+aq1ahie8Qjm75FKjZespDs+s2aI6sLOKM4Oj+6f0LMR9TZeRUQrtXXghoRdTsDVL7AC/zTiEm2CiCs1Xi/w2k5d8Z1fqUrGecYMrFWA9rHDRpe1N6ME9o7AqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095211; c=relaxed/simple;
	bh=6GLaNtAOvcr+X26Nb+AM8LIJ8VknGJTaxaZw4baqneQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlBNHboaLYHu3mggfbENrkqLD5QWQhrTyBAE+pYMW8pbDUwzQ5jbaMY6uP27Ri2BPXkOlgkxF3F4iPmNlNvR/C+H1HngKmSAWLl3FsaQZAOqVeOsTXIKtr+WH2cwQccRrbNxLLHWoZh0cgraBK/RvKu6J0HoKXH0FgL9ja2O8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPqhoypF; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9156ceb55ffso577706385a.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095209; x=1781700009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLVHzGu2Du1k4J9c4p+zgX4sdLFgy4zvRmNg1eHlph8=;
        b=KPqhoypFYrAA+6sAIJ0w9FlDj+xkDSkdNKBZEM7rM8k+vgbtVFuu65/gOJtu58koik
         YbOoSas0cZJo6/bwr+pZWxAMQgmCz5mnT0uOCY56GY/h0EE6n8Z4WcEM8iM36vmDgVjM
         K04/9QahT8qE62nHBMCH7xlxgPzgLgwThImnd4JFr1kjrvfREMCResnjTSMbV2gjGxx4
         9JUY5BHF1SsX+7lnFykNGRXwS9nYLEUuLonwmq4tI05tnbvgLAzsOcGZixqOoUfaN5O/
         KSKoStKZ97VpLdf7VGgS5VIfR+xWX/raSm1uVr6JtfGpV1zlRePXrLkwDLsER907QsQw
         xGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095209; x=1781700009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tLVHzGu2Du1k4J9c4p+zgX4sdLFgy4zvRmNg1eHlph8=;
        b=gPwG4+u3e2k3CZcEjPq5LF2KJbkqLX4L+/SWCYprBRNJ2dy/fWX/s6gBD5x42gu0D1
         OTeyZ4Kqv0N6YBw0GIETbof/tDp3KzyOW+4hfxtXnVK36dYkpKNEGvXwDyJ1wBqiamn6
         yj1gNBXlzFhNThwqu+gf6N8qMyoQpKyMmF2n4HawVwwD1gEsNPp25Pc9QAVhZuk/EdT0
         DHqcJvab+2mwVyOF41s6MxS9JU3ne8QcXOy+0RHdRiUd21uaBptq6nb0u4jMDjDg3g5v
         9llfuU0ANP0vEMv0FPvsVwXXcQUIieT6g3FryE5hv+XHa6k8eTetWZ3ap1Bmv5l1OFCr
         5Nbw==
X-Forwarded-Encrypted: i=1; AFNElJ95h6E3teXJ6y/fc3uWJcEp/lG0m8F/FMVT0Vo4J+SBL6IF15w2q3hfQoysPDvPG9d7T4Lc/OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTYsBCkIKL3iAo85ZqpCRcGO5W1lIwR7FDv+eYic8lNLo3/znp
	9avNGivKyhJxXUW/T/TzkYKZzPCMj+cfHr2+x1PXUW8EDJImdNxzs1uQ
X-Gm-Gg: Acq92OF+jbqQUWgxEx1apA+3tdxJlYjJCG243uHyTWURnShSXEyTzDHG4q19jJLHqQz
	+LmuE/V9PcMjK/OokbbrLOLPBIIK+YYNlSS7F9LT7DUU3sOTZwxtl4dWQxxtOeMbOITaxrX5t6Q
	Zct+bMbduPF+R9z8hk18WUyG/JOqkCaADgjbys9jdi3pvbJvZ12E0mmu9ZuWe33RE5px0or+ZH5
	RkBqT0hmKWT4Y0+8ZJkVhetmBYlE5YYfpT2u1ZSFvcURxDdRI+YxeenVC7mDyFStMpAhPHmGs0z
	Q3lZ3mnBGumIj6EwTxf3cd4nVLSnVW2ACSHbRlnG8YRcVa0bs56EzTKmU5RdotwhflecZsB7BtK
	PwqaAnEE7EQnhgnnunFx9xiTQ4UpabvX0o4awt7+pcS7/85o8Wap+LZ7U/F7wD0ij+POJ4m/53Q
	gPpRBvBCXXJQFdPyZ5SHqeu/urSfHItNtRj2BOTb+bYRxWY6JqOmy8fWPjXJXeX+KB/OTOLEjlQ
	RvzZLBa4ugJBUQUTDukV5zpzEr5faI=
X-Received: by 2002:a05:620a:1d0b:b0:915:c4de:7ac0 with SMTP id af79cd13be357-915e82e7f40mr1123809485a.31.1781095208799;
        Wed, 10 Jun 2026 05:40:08 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a237330sm2499096885a.16.2026.06.10.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:40:08 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 1/3] tipc: require net admin for TIPCv2 netlink mutators
Date: Wed, 10 Jun 2026 08:40:01 -0400
Message-ID: <20260610124003.3831170-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610124003.3831170-1-michael.bommarito@gmail.com>
References: <20260610124003.3831170-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:tung.quang.nguyen@est.tech,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B99F26695D8

TIPCv2 registers mutating generic-netlink operations without admin
permission flags. Generic netlink only checks CAP_NET_ADMIN when an
operation sets GENL_ADMIN_PERM or GENL_UNS_ADMIN_PERM, so a local
unprivileged process can currently change TIPC state through commands
such as TIPC_NL_NET_SET, TIPC_NL_KEY_SET, TIPC_NL_KEY_FLUSH, and
bearer enable/disable.

The legacy TIPC netlink API already checks netlink_net_capable(...,
CAP_NET_ADMIN) for administrative commands. Give the TIPCv2 mutators
the equivalent generic-netlink gate. Use GENL_UNS_ADMIN_PERM, which
maps to the same namespace-aware CAP_NET_ADMIN check that
netlink_net_capable() performs, so the behaviour matches the legacy
path and keeps working for CAP_NET_ADMIN holders in a non-initial user
namespace (containers).

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


