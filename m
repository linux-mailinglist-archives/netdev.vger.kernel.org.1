Return-Path: <netdev+bounces-290940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLvgAO/iEGpqfAYAu9opvQ
	(envelope-from <netdev+bounces-290940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:12:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ECA5BB62D
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C356A302FB77
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38073921CC;
	Fri, 22 May 2026 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFEVQbf8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11893905F5
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491225; cv=none; b=JVMybVuxqvkLdREdn0T9/cMRVqQLatukf7vS+MeRJZFs40kvieiz9aIdvGcw073zEVhVkhE6+GqfyiKmkWN+iVZsZR7hunnuFFyePMi5/0yQvlKUHEAqzKVJrPambm2SKPGR04QwS784pfH/nbKaYlOOm8ZQGKwauRGq9fU43lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491225; c=relaxed/simple;
	bh=x+nn+LtxzWU6UlS1iq54le+l0U4utQgEw2nmsG0qJd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEN6qT0/fJsx2F8igQrI7KXCCYqPjVdamt2zlBRMNRw8AFtpjO59Ev47FDxCl84GmyC1TWhHj9K3blt1k4Q2XDU8g0vhNhAff3xgy6MNUB97+oekZ9lwRut0xTUW6TIG45St3LAq44yojdmpjVnnzyO04GhchTK5kqfdArAMW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFEVQbf8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371AD1F0155A;
	Fri, 22 May 2026 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491224;
	bh=ijPo9Ong7M5Sfw0SoehmLWN6sgxwnXC6ZsXCafyZWj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PFEVQbf8ydJbkcLsan4tXnhCmi3q/YikwknfkWnPYegE0ui8wZbHQu6V9uNqf2gqV
	 797RLUB7X/Gq0eI+ZI6ZKpAiJFap1IT+zikFZUIS8t2VK37AWgXBxPuDuf7jbUSDaK
	 wcXANOZHOeLSmCm/6ss8xWfzqcN8PNul4uZRAQJKHJY0YnlyFsyRJhRcTSR8T8VfU8
	 SHvXNY30G842B3XxetfomQ2Yegou/+tGwkLTQ67xUGdw7tnQyZhEWthhsNn9Wo/90U
	 IZli0gWrcfQfa1G4lqjCIhrfIfUs5Gpv/+rXW9LKJSqKGCOkvCjiNguYIe2ygqhUOc
	 69xKG6FE5UXig==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net 4/6] ethtool: rss: fix indir_table and hkey leak on get_rxfh failure
Date: Fri, 22 May 2026 16:06:45 -0700
Message-ID: <20260522230647.1705600-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522230647.1705600-1-kuba@kernel.org>
References: <20260522230647.1705600-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290940-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,lunn.ch:email]
X-Rspamd-Queue-Id: 62ECA5BB62D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rss_prepare_get() allocates the indirection table and hash key buffer
via rss_get_data_alloc(), then calls ops->get_rxfh() to populate them.
If get_rxfh() fails, the function returns an error without freeing
the allocation.

Fixes: 4f038a6a02d2 ("net: ethtool: Don't call .cleanup_data when prepare_data fails")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: gal@nvidia.com
---
 net/ethtool/rss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 458a4a7907e4..9fb675d29232 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -170,8 +170,10 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
 	rxfh.key = data->hkey;
 
 	ret = ops->get_rxfh(dev, &rxfh);
-	if (ret)
+	if (ret) {
+		rss_get_data_free(data);
 		goto out_unlock;
+	}
 
 	data->hfunc = rxfh.hfunc;
 	data->input_xfrm = rxfh.input_xfrm;
-- 
2.54.0


