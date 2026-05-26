Return-Path: <netdev+bounces-291752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAVoF8nJFWpEbgcAu9opvQ
	(envelope-from <netdev+bounces-291752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:26:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E692B5D9A8D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26C1F30AB1EE
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E042937418F;
	Tue, 26 May 2026 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WftkscJm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838E36D9FE
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809757; cv=none; b=RrWe6Eg+VFRyHDMpjrKoBveAkxuIopCsp/ZiSHVKemJRpbH27o+ltHvKBbMMRPr1bEUd7clAS2whjVsLFbIvsoeybFaT8KwEf1avwD2OpR/YHOffr4uXSfe8k7/PwQdfF32NXEg6kypQ75LNPvhUAQ50VVfu99moTw1sP74g/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809757; c=relaxed/simple;
	bh=KDX4HNkml7IV8aU7lMSze1ajfU/82Eaq8IQYthiIen4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj5yB+jeFcICIZd1+H1jxJZ8tiAiFkbxGMmZOcQw8hIpsVxrddCDguY/iroyf4T+OUsMncIz1Gb/xoxcygv4ar4QiUsOT0R+HQgWP+eXIDJOdDjMnrnyLFubVK0JfdkycgFfKMxzjI0TqoRrrJSJNRSWKCiicjOqFtvFz73ZAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WftkscJm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0BF1F00ACF;
	Tue, 26 May 2026 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809753;
	bh=RaDp/RUL2fBgbi6ns2algeqHkIpvo99pX47peb3GWGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WftkscJmREEeKkEuS6cGZ+JSJxCg9mBW5LW/Bq62x7ZXldE8IwId5aR6jdmgSDmUz
	 /fLbrA0YOdi+Uo9qDX028TPODAh21DV7Ihh4TZ05gaj1jESuFtSaZbvuo+LqRRWll1
	 9qkhAw0JA/skTKfA/pikAp3cCW581TStc6OOHWeBw1QO6IHAzojZv8F+1EZVEbXkG/
	 h3V/o86W0SIgM/zn4EAjTSnHilnrLn1NjmRK/VUJ4U1ZT7EA/OWlrVVV1qQRLHceFc
	 zAUmPwLX1DpQY7lLdX06aa4AaiX724R2zTcXxdTfGDzx8nIkRLhW5Riuha1pnmdxT0
	 wAiQdT+I/oRGw==
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
	andrew@lunn.ch,
	kees@kernel.org
Subject: [PATCH net 06/10] ethtool: tsinfo: fix uninitialized stats on the by-PHC path
Date: Tue, 26 May 2026 08:35:29 -0700
Message-ID: <20260526153533.2779187-7-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291752-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Queue-Id: E692B5D9A8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tsinfo_prepare_data() has two code paths: a "by-PHC" path for
user-specified hardware timestamping providers, and the old path.
Commit 89e281ebff72 ("ethtool: init tsinfo stats if requested") added
ethtool_stats_init() to mark stat slots as ETHTOOL_STAT_NOT_SET before
the driver callback populates them, but placed the call inside the
old-path block.

When commit b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to
support several hwtstamp by net topology") added the by-PHC early
return, it landed above the stats initialization. On that path
the stats array retains the zero-fill from ethnl_init_reply_data()'s
zalloc. This leads to the reply including a stats nest with four
zero-valued attributes that should have been absent.

Reject GET requests for stats with HWTSTAMP_PROVIDER or dump.

Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
CC: kory.maincent@bootlin.com
CC: kees@kernel.org
---
 net/ethtool/tsinfo.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index a865f0fdd26b..f54fe6b662b2 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -83,6 +83,11 @@ tsinfo_parse_request(struct ethnl_req_info *req_base,
 	if (!tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER])
 		return 0;
 
+	if (req_base->flags & ETHTOOL_FLAG_STATS) {
+		NL_SET_ERR_MSG(extack, "can't query statistics for a provider");
+		return -EOPNOTSUPP;
+	}
+
 	return ts_parse_hwtst_provider(tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER],
 				       &req->hwprov_desc, extack, &mod);
 }
@@ -523,6 +528,12 @@ int ethnl_tsinfo_start(struct netlink_callback *cb)
 	if (ret < 0)
 		goto free_reply_data;
 
+	if (req_info->base.flags & ETHTOOL_FLAG_STATS) {
+		NL_SET_ERR_MSG(cb->extack, "stats not supported in dump");
+		ret = -EOPNOTSUPP;
+		goto err_dev_put;
+	}
+
 	ctx->req_info = req_info;
 	ctx->reply_data = reply_data;
 	ctx->pos_ifindex = 0;
@@ -532,6 +543,8 @@ int ethnl_tsinfo_start(struct netlink_callback *cb)
 
 	return 0;
 
+err_dev_put:
+	ethnl_parse_header_dev_put(&req_info->base);
 free_reply_data:
 	kfree(reply_data);
 free_req_info:
-- 
2.54.0


