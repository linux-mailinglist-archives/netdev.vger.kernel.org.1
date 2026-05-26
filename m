Return-Path: <netdev+bounces-291755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFhbOtHJFWpEbgcAu9opvQ
	(envelope-from <netdev+bounces-291755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:26:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0BD5D9A95
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA9E930E8D4F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7054D376494;
	Tue, 26 May 2026 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaSwnD7J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3936CDF2
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809758; cv=none; b=SG/vtqe2PYMthJyuCtJ8P0SVbW+Bx2lDT5OydvshyWjZMDguJ2SSq+8G2YdWBJ9/Wnu24l8MQACmW9xrpkmzwIxwsp4B9dEZO6PPuKY3Owf9QtsM1Q5xVNJjEziDZJD5v762jbTMgXmWIt5qwMORGJmPzR2E/wFRATPCzaiNau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809758; c=relaxed/simple;
	bh=QB4b3TADVMdyL5zt32T0oiMFwiGSQvDZTkoUJ50khwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FH6nXooJJQZ71YgMGMfhQ1m9AsKAqkLwD4F/pJO9kAtS9ZMGR95bKr5+6aPO8A/5iGFaMD+II4QwbR9rl40MPyh7E6y+Tmf0M3oZMAVn583t/CXDWK+uib7AQkb0N1JI1g27wIF6CzcLggnTSQfn2mqnNK5VSNEoXDU85QeNXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaSwnD7J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0AF1F00A3F;
	Tue, 26 May 2026 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809753;
	bh=evUkhfT4Qsj5+DVaCtgc5IbUK8k2pmbvL0VMLNQmK5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LaSwnD7JLGLc3RzWAE1XmWj/9xBbLZ56Th8icSw+w20JOIhN9GM+wupOIq9zuBWNT
	 drR5Nq0T5eGayFJGFuhlYumWNY8iZGTIDpYKVCsFnDDXNcFr2eAuTpdCzJh9JDdmBn
	 MejXMUw83evy4ZMA89FTj/GDM7XIooAxM8z9ChGW/cLrGjx47Uy4C4hMa3Rs52tLz3
	 p/7OJdxWNu9KWTqQJahPw1IO0DeUVr6NqYprig5gUnI2hgKq371f01QruKNr++rFqk
	 KI6FxmkNBVklchrHuDMWsWl6mXby9hhkhwMYB0uNOiLNY0vk3cN/tnDsO9vhTPz/zN
	 KSXticXVoOrdQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net 07/10] ethtool: tsinfo: don't pass ERR_PTR to genlmsg_cancel on prepare failure
Date: Tue, 26 May 2026 08:35:30 -0700
Message-ID: <20260526153533.2779187-8-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526153533.2779187-1-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-291755-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,lunn.ch:email]
X-Rspamd-Queue-Id: 8F0BD5D9A95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The goto err label leads to:

	genlmsg_cancel(skb, ehdr);
	return ret;

If ethnl_tsinfo_prepare_dump() failed, it has not started a genlmsg.
There's nothing to cancel, and passing an error pointer to
genlmsg_cancel() would cause a crash.

Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
CC: kory.maincent@bootlin.com
---
 net/ethtool/tsinfo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index f54fe6b662b2..14bf01e3b55c 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -407,10 +407,8 @@ static int ethnl_tsinfo_dump_one_netdev(struct sk_buff *skb,
 			continue;
 
 		ehdr = ethnl_tsinfo_prepare_dump(skb, dev, reply_data, cb);
-		if (IS_ERR(ehdr)) {
-			ret = PTR_ERR(ehdr);
-			goto err;
-		}
+		if (IS_ERR(ehdr))
+			return PTR_ERR(ehdr);
 
 		reply_data->ts_info.phc_qualifier = ctx->pos_phcqualifier;
 		ret = ops->get_ts_info(dev, &reply_data->ts_info);
-- 
2.54.0


