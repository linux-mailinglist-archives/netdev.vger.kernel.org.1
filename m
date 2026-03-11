Return-Path: <netdev+bounces-266449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE2sIHXhsGkuoAIAu9opvQ
	(envelope-from <netdev+bounces-266449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:28:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4248725B95F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E48E9303B158
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796E835CB6B;
	Wed, 11 Mar 2026 03:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjS/sLvT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CBB3290CB;
	Wed, 11 Mar 2026 03:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199725; cv=none; b=LVKTFR3mOSelRrAdaZrdBUaYtnU0Ba8pGrUChe8LE0+VaOD+RfLD0dDd/8+SbWqhtMU5u7cIG9qyxRoP+KWlm3kpRL3GFEjgc2ycUP5aUKNE4yS6466THf+P0jmlbWGwYkvUc6jNF+sVuTJ3RuObwGOOQWSj4DWDSjX6m0f/bDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199725; c=relaxed/simple;
	bh=zWcjXusMF12XB2tOd1fBQy4JpAWbZKwgy/a3Z7UaC6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtcWitocT3+27rsg+AFWUzFceB38cKJIKNisEc1iDD+FVAKp5zJ4L8np6vGAFe4VYdY0/0UrfF62q+L4zAXvninnmv5V7f3+BGTwBAnlOQXS4eT1VthEof7sX/sEsBulienoxtWZtblcEB73eZvwL576GOL67dMk1535yyYD0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjS/sLvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8033C116C6;
	Wed, 11 Mar 2026 03:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773199725;
	bh=zWcjXusMF12XB2tOd1fBQy4JpAWbZKwgy/a3Z7UaC6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjS/sLvTvJP62t5KSQxmNASnTw94j913rNhJLPn5Yjhr7DeA1SK51ZqJiIwn7o7dM
	 kb6tSL5cRcv6HvumMDkXsEEFqZDzY7b4LW6/UezUwl+7hGwp4QlEI5KKtS+iC3R1Ky
	 ZyP0LH3gHOP1Iwi7vHv7voyVlctXnADEwURCVnLOLsgwh5+6S1RN6b9ubVFT5Lmpa6
	 X5NJFUSDSxUzLol2Bz08RQPsu+c/SxXusD+jnhfI36dJumBm1hfe9oyYeljK5Bvb5a
	 LnSyHxdl3Z13nkPxlm2AxRKqpC/RbQAxWoA2cCme+q2nsCGjrt2AetA0B5ma/JeGoL
	 bwf9fRv3eI4Nw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/4] genetlink: use maxattr of 0 for the reject policy
Date: Tue, 10 Mar 2026 20:28:36 -0700
Message-ID: <20260311032839.417748-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311032839.417748-1-kuba@kernel.org>
References: <20260311032839.417748-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4248725B95F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266449-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Commit 4fa86555d1cd ("genetlink: piggy back on resv_op to default to
a reject policy") added genl_policy_reject_all to ensure that ops
without an explicit policy reject all attributes rather than silently
accepting them.

The reject policy had maxattr of 1. Passing info->attrs of size 2
may surprise families. Devlink, for instance, assumes that if
info->attrs is set it's safe to access DEVLINK_ATTR_BUS_NAME (1)
and DEVLINK_ATTR_DEV_NAME (2).

Before plugging reject policies into split ops we need to make sure
the genetlink code will not populate info->attrs if family
had no explicit policy for the op.

While even shared code paths within the families can figure out
that given op has no policy fairly easily themselves, passing attrs
with fixed size of 2 feels fairly useless and error prone.

This change has no user-visible impact, reject attrs are not
reported to the user space via getpolicy. We do have to remove
the safety check in netlink_policy_dump_get_policy_idx()
but it seems to have been there to catch likely faulty input,
the code can handle maxattr = 0 just fine.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/netlink/genetlink.c | 19 +++++++++----------
 net/netlink/policy.c    |  4 ++--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index a23d4c51c089..c00f0586c8d6 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -92,10 +92,8 @@ static unsigned long mc_group_start = 0x3 | BIT(GENL_ID_CTRL) |
 static unsigned long *mc_groups = &mc_group_start;
 static unsigned long mc_groups_longs = 1;
 
-/* We need the last attribute with non-zero ID therefore a 2-entry array */
 static struct nla_policy genl_policy_reject_all[] = {
 	{ .type = NLA_REJECT },
-	{ .type = NLA_REJECT },
 };
 
 static int genl_ctrl_event(int event, const struct genl_family *family,
@@ -106,13 +104,10 @@ static void
 genl_op_fill_in_reject_policy(const struct genl_family *family,
 			      struct genl_ops *op)
 {
-	BUILD_BUG_ON(ARRAY_SIZE(genl_policy_reject_all) - 1 != 1);
-
 	if (op->policy || op->cmd < family->resv_start_op)
 		return;
 
 	op->policy = genl_policy_reject_all;
-	op->maxattr = 1;
 }
 
 static void
@@ -123,7 +118,6 @@ genl_op_fill_in_reject_policy_split(const struct genl_family *family,
 		return;
 
 	op->policy = genl_policy_reject_all;
-	op->maxattr = 1;
 }
 
 static const struct genl_family *genl_family_find_byid(unsigned int id)
@@ -934,12 +928,17 @@ genl_family_rcv_msg_attrs_parse(const struct genl_family *family,
 	struct nlattr **attrbuf;
 	int err;
 
-	if (!ops->maxattr)
+	if (!ops->policy)
 		return NULL;
 
-	attrbuf = kmalloc_objs(struct nlattr *, ops->maxattr + 1);
-	if (!attrbuf)
-		return ERR_PTR(-ENOMEM);
+	if (ops->maxattr) {
+		attrbuf = kmalloc_objs(struct nlattr *, ops->maxattr + 1);
+		if (!attrbuf)
+			return ERR_PTR(-ENOMEM);
+	} else {
+		/* Reject all policy, __nlmsg_parse() will just validate */
+		attrbuf = NULL;
+	}
 
 	err = __nlmsg_parse(nlh, hdrlen, attrbuf, ops->maxattr, ops->policy,
 			    validate, extack);
diff --git a/net/netlink/policy.c b/net/netlink/policy.c
index f39cd7cc4fb5..08b006c48f06 100644
--- a/net/netlink/policy.c
+++ b/net/netlink/policy.c
@@ -31,7 +31,7 @@ static int add_policy(struct netlink_policy_dump_state **statep,
 	struct netlink_policy_dump_state *state = *statep;
 	unsigned int old_n_alloc, n_alloc, i;
 
-	if (!policy || !maxtype)
+	if (!policy)
 		return 0;
 
 	for (i = 0; i < state->n_alloc; i++) {
@@ -85,7 +85,7 @@ int netlink_policy_dump_get_policy_idx(struct netlink_policy_dump_state *state,
 {
 	unsigned int i;
 
-	if (WARN_ON(!policy || !maxtype))
+	if (WARN_ON(!policy))
                 return 0;
 
 	for (i = 0; i < state->n_alloc; i++) {
-- 
2.53.0


