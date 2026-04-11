Return-Path: <netdev+bounces-277690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TZgqNFMs2mnbywgAu9opvQ
	(envelope-from <netdev+bounces-277690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 13:11:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6BA3DF717
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D51EB3020027
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C02340DAB;
	Sat, 11 Apr 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ddpfNvsL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CD25392A;
	Sat, 11 Apr 2026 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775905854; cv=none; b=gMwQj92ojBQBcP7qmf3i3i1ReacJ17ilLGJjFummv8jHaioVigrFubAbQJGRzdLIOvCgKq+qcwb0qbDHQS+E3TH4jOovVeT5X2ZObliOJHQha9YWV5oGr4bdkp3BkL0Cu3pvFlZ8JGAknb3MCzLqkn/+c3Ae89z9SeR1eehEu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775905854; c=relaxed/simple;
	bh=/WrS6DgC2aQAdxt9LOkuyP7uS1pGbZzKbI695oVDDpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IF+2vpzN3sVc+nbvkzU9JrA0w5qEyvPEbLt0XjffKa/zrmjKzKexTI1MYDoog0C5fBYQLo9K7Y9Jjf9UIKn3r0kQgCu3mUuogU76/E8g0/kCP7xpaZHE1/QmaGN9yqZ2st0R9RfngJ2ibW4Q63wYDO6U2zks7NwYPD1J63Eadfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ddpfNvsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91DDC4CEF7;
	Sat, 11 Apr 2026 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775905854;
	bh=/WrS6DgC2aQAdxt9LOkuyP7uS1pGbZzKbI695oVDDpE=;
	h=From:To:Cc:Subject:Date:From;
	b=ddpfNvsL284bWauwR+w2bv7GPsFWZFAXj2Sqzytc+lXEgecJ8/C8Y7gBsYPmsDmg5
	 dXrs7l0Q/567LijB5NGE3iWt370lNhrnUbK3DVA8rxKHnLvIVR7Y+uRJjZvyX2Iiao
	 f1N7MdWkM523n++pPHoDBM5W6ROzHjNPGcQzbnLo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH net] net: sched: em_text: require NUL-terminated algo name
Date: Sat, 11 Apr 2026 13:10:51 +0200
Message-ID: <2026041150-task-path-81dd@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 49
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=/WrS6DgC2aQAdxt9LOkuyP7uS1pGbZzKbI695oVDDpE=; b=owGbwMvMwCRo6H6F97bub03G02pJDJm3dKxjlB8wyH/4Nv3txF+WKx1WTmaa1/zjk5mbt1niP 9kPP1W7OmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiW7YzLDjE7Gvo5Lj51YU7 2px8UXO2phRJPmeYX7C19/DeHo+Qvyw94t5n1J9zdkl1AwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277690-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,davemloft.net:email]
X-Rspamd-Queue-Id: AF6BA3DF717
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

em_text_change() copies the user-supplied tcf_em_text struct from
netlink and passes conf->algo straight to textsearch_prepare(), which
forwards it to lookup_ts_algo() (strcmp) and request_module() (vsnprintf
%s).  But the algo[16] field is never validated to be NULL-terminated,
so a fully populated array reads past it into the adjacent
from_offset/to_offset/pattern_len fields and the trailing pattern bytes
during the string operations.

This type of pattern is properly checked in the string_mt_check() for
xt_string netfilter matching function, but for some reason was not added
here, so fix this up by doing the same exact thing.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, my tools flagged this, so I fixed this up the same way that
string_mt_check() did, but if there is some other way that this should
be resolved, or I got this totally wrong that this isn't an issue,
please let me know, thanks!


 net/sched/em_text.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 343f1aebeec2..24a8aa21971d 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -58,6 +58,9 @@ static int em_text_change(struct net *net, void *data, int len,
 	if (len < sizeof(*conf) || len < (sizeof(*conf) + conf->pattern_len))
 		return -EINVAL;
 
+	if (conf->algo[sizeof(conf->algo) - 1] != '\0')
+		return -EINVAL;
+
 	if (conf->from_layer > conf->to_layer)
 		return -EINVAL;
 
-- 
2.53.0


