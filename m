Return-Path: <netdev+bounces-299680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0fMXIT2ZMGqNUwUAu9opvQ
	(envelope-from <netdev+bounces-299680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:30:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76368AF1D
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:30:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=feB7STRW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299680-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299680-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88748300F779
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2921C1A6801;
	Tue, 16 Jun 2026 00:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046378F26
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 00:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569850; cv=none; b=ARVp+MUBFsldCDBuW1zMRavEsYWaIpTGVeqzu6pzCCUuuvb4obU71uz4OzldTScFbOYxUSqjpj4bv2X5yKaAtVxrW3dWDYLRdqL6dTw927L3aDmh69Hf/754g+vikbJUHmsqTaN4dhqHhKjrspQzVqsvI5w+rADhuaUGMckI5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569850; c=relaxed/simple;
	bh=ogqhqw9MTk4wiyv+yy/tQ9xJEPd9C82de43KoP7cCbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pW2OTbFm9wUmi81vTDPuIlVqbq67g7YJuL/fV061z5zyOal87Qybt6HtID6DUyLG5BU+Jhg1QMeKMZSusoc+lPONV0es9D8ehwSGvHvMcLhX3oFTJmQnetw27FptY0e5bj6KqKU6Y4p/RyjdXPZBnlVv8k66b4h1TbrwBXR1PJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feB7STRW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324D21F000E9;
	Tue, 16 Jun 2026 00:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781569848;
	bh=wVyYAaJOZHGmPuGVTnYPiAm/XmP7EdBC5Kvf48oDZyc=;
	h=From:To:Cc:Subject:Date;
	b=feB7STRWOmDCLRYhINfDmwYkljsn2OXsyzGOTy98cwxZWmzP0iDKz16SHu89BAoj2
	 NhPBnZLDnLpFVq4addO3I6vy5NQela4h+6172z74zezbbTZZnWEYYGZQG//gKnkQt/
	 L8DDkrCfyuM84HHrniCypjvDdWnflF/4yCXfC8+L0cK+xRfb5DpQ1GAxhYWNCjFKVD
	 KrU7x8O7nJIE63El3IwYXWf23grM5UqCMC2/8LmUFY/4Gv3g67Y7CXHGaKb3fYZDjc
	 72fPQEPv4wrDbbwJdtT71haxNPh7pdq/d8YdbdHID1oHT8FjGHqs9gelY0XItV8l9l
	 mjmdWjTz724fw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>,
	yotam.gi@gmail.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Subject: [PATCH net] net: psample: fix info leak in PSAMPLE_ATTR_DATA
Date: Mon, 15 Jun 2026 17:30:46 -0700
Message-ID: <20260616003046.1099490-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,mojatatu.com,resnulli.us];
	TAGGED_FROM(0.00)[bounces-299680-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:bestswngs@gmail.com,m:yotam.gi@gmail.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:andrew@lunn.ch,m:yotamgi@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mojatatu.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A76368AF1D

psample open codes nla_put() presumably to avoid wiping
the data with 0s just to override it with packet data.
This open coding is missing clearing the pad, however,
each netlink attr is padded to 4B and data_len may
not be divisible by 4B.

Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: yotam.gi@gmail.com
CC: jhs@mojatatu.com
CC: jiri@resnulli.us
---
 net/psample/psample.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/psample/psample.c b/net/psample/psample.c
index 7763662036fb..c112e1f0ccac 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -476,15 +476,17 @@ void psample_sample_packet(struct psample_group *group,
 		goto error;
 
 	if (data_len) {
-		int nla_len = nla_total_size(data_len);
+		int nla_len = nla_attr_size(data_len);
 		struct nlattr *nla;
 
 		nla = skb_put(nl_skb, nla_len);
 		nla->nla_type = PSAMPLE_ATTR_DATA;
-		nla->nla_len = nla_attr_size(data_len);
+		nla->nla_len = nla_len;
 
 		if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
 			goto error;
+
+		skb_put_zero(nl_skb, nla_padlen(data_len));
 	}
 
 #ifdef CONFIG_INET
-- 
2.54.0


