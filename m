Return-Path: <netdev+bounces-263201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EUUGWPgpmkPYQAAu9opvQ
	(envelope-from <netdev+bounces-263201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:21:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DFE1F01B6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 849133029AF9
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CA434C9A3;
	Tue,  3 Mar 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyYqaB5r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A9C27E1DC;
	Tue,  3 Mar 2026 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543921; cv=none; b=R08IUJdSbkYWhozzt9T6/HBMzSKJKEsiTgs/slaz75DquonwFmYsKGZ7OwPFhhXA9g4+MjmktRrZSHeKrzlbhzcnmuuHJxLuZgsovQV3jRvvhAKLtMK3DlxgucjEPXhHXaEcKkcOv86xIIIEuxSAAIbC7oM7SLhqcWgqbrXnReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543921; c=relaxed/simple;
	bh=S4vp4JQ72s3eWuG8J9mcgxDfPnpnYZ+oZQ9woXEJC0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UjJauge9UEQ7YmS9VfpDSaZk/BSJoYt+3aSud1eQvBICQs8YCPO+j93C9JkYISkLLk9BtA9NBI/hG7mg6zmu+LKqTVUEjOqsFERBLcGLUSP+hR3kUZNeEobW6GEgc+UYLCNeo+IC6lJ+BK58uV1ZTxH0vev6LaH5VDbPpGOj49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyYqaB5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A45E8C2BC9E;
	Tue,  3 Mar 2026 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772543920;
	bh=S4vp4JQ72s3eWuG8J9mcgxDfPnpnYZ+oZQ9woXEJC0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TyYqaB5rYDZ7OJf8DsvtXCspw/YmCp5o1ltlUiEZ2wcBEhwslkw6pWOcjEpr5aeJv
	 g+mAJ74krEXwZTxA630/aBz+Q9rAp2qndnkpoZUcL98v12wAp66pOMos5pMTTY6Ihu
	 vxuPZBVvSG7up4wVv1TFrd0DigHbNJcvE8wJNiMHpYaX5AaoBL+iht87NGwLN+l0XE
	 dERQ2mfmhDFjpz5sS6MKjG1hDXdxAkQbVZ6RIqJkcdzCjt/8lW+ztYqs2d7ZflK04W
	 E7ACsBo3rXeeCQ7lvXMSKEi4cAydEURyoM8f0T58Ewm+BrVwrDbyxkoHhhIZSOHf26
	 2sztwy2PevH6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC4EC143C;
	Tue,  3 Mar 2026 13:18:40 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Date: Tue, 03 Mar 2026 14:18:23 +0100
Subject: [PATCH net-next v5 1/2] net/sched: cls_flower: remove unions from
 fl_flow_key
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-net-next-mv88e6xxx-tcam-v5-1-6f9129687276@luminex.be>
References: <20260303-net-next-mv88e6xxx-tcam-v5-0-6f9129687276@luminex.be>
In-Reply-To: <20260303-net-next-mv88e6xxx-tcam-v5-0-6f9129687276@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772543918; l=1808;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=XHxAavS3OSIr6KhDGV4nKk6jIBOKNR2K6BPZWurwweQ=;
 b=gbTT7fjU3RO8peEn8VdgpzNxuE3GHZv6YwDBC+asrnpgA0gTLml6+wwTTZVUvuKASiuNom4yq
 OSR+1nd3pOMCBeoxEgqUrBjZHOcB0UGRfrI/byA8CGmtH+DW97Z0Q75
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Rspamd-Queue-Id: B7DFE1F01B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263201-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,mojatatu.com,resnulli.us];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Cedric Jehasse <cedric.jehasse@luminex.be>

When creating a flower classifier with an ipv4 address the
flow_dissector has both FLOW_DISSECTOR_KEY_IPV4_ADDRS and
FLOW_DISSECTOR_KEY_IPV6_ADDRS bits set in used_keys.
This happens because ipv4/ipv6 fields are a union and
FL_KEY_SET_IF_MASKED() will interpret either being set as both.

Removing the unions fixes this behavior without needing special handling
for union fields.

Example of a command that caused FLOW_DISSECTOR_KEY_IPV4_ADDRS and
FLOW_DISSECTOR_KEY_IPV6_ADDRS to be set:
tc filter add dev p1 ingress protocol ip flower skip_sw \
    dst_ip 224.0.1.129 action trap

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
 net/sched/cls_flower.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 7669371c1354..b95dbe847dde 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -59,18 +59,14 @@ struct fl_flow_key {
 	struct flow_dissector_key_eth_addrs eth;
 	struct flow_dissector_key_vlan vlan;
 	struct flow_dissector_key_vlan cvlan;
-	union {
-		struct flow_dissector_key_ipv4_addrs ipv4;
-		struct flow_dissector_key_ipv6_addrs ipv6;
-	};
+	struct flow_dissector_key_ipv4_addrs ipv4;
+	struct flow_dissector_key_ipv6_addrs ipv6;
 	struct flow_dissector_key_ports tp;
 	struct flow_dissector_key_icmp icmp;
 	struct flow_dissector_key_arp arp;
 	struct flow_dissector_key_keyid enc_key_id;
-	union {
-		struct flow_dissector_key_ipv4_addrs enc_ipv4;
-		struct flow_dissector_key_ipv6_addrs enc_ipv6;
-	};
+	struct flow_dissector_key_ipv4_addrs enc_ipv4;
+	struct flow_dissector_key_ipv6_addrs enc_ipv6;
 	struct flow_dissector_key_ports enc_tp;
 	struct flow_dissector_key_mpls mpls;
 	struct flow_dissector_key_tcp tcp;

-- 
2.43.0



