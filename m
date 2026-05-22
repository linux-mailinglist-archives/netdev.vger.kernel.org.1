Return-Path: <netdev+bounces-290941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPWsCQnjEGqOfAYAu9opvQ
	(envelope-from <netdev+bounces-290941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:13:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 761035BB634
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A20FE30329A1
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C55C392807;
	Fri, 22 May 2026 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLNyU7cn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342093911C1
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491226; cv=none; b=AYj0rE0XrbMXdjcVatiQUPQ/9yCmQy265nUtUosYnPwDGWOR0ZXsCbcmJKj5rSnncDNiyZ45aM7DNykXnmlAyZBHqX5t0mvaw2xayb40zmKyXMp0knTViYhQM84XQ96QkVGlFnIqrya71Y11mh1hlSheRpZ9EpGgUKbgkzwEji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491226; c=relaxed/simple;
	bh=BXlgqMIUolT+a7vib3gWgC0zfOx2bJecoWQoguF3u80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ/QHF3eL2d6lgocVVgTJfFH8j8PuWKC5mj4ovCz5eDM/ZZPFJHxLNKS0029IUEBehgZTudfuguW8ex2Y7+hGXic2tryAxdXU3jcxyHBVJiSzaGNFy4cCl9ty5Q6YO1T0N3zqrHLpxIJ7t2JGPYY+Ss8uhFwEADLZFezqdddZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLNyU7cn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42791F000E9;
	Fri, 22 May 2026 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491225;
	bh=IHfRhcQiOezImEGlGJhiejVmYV4bFdp6iF0hrcDHuRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kLNyU7cnSFWJD2M9TF4TMocsWz/Hhi+qO8+avMq2BTOPcc1GLnUJjwb4FGoxFto6V
	 V5XWQlQ5E2e1RHhlqU1stUxgIxXwGnErObkAmjRTf12FY5IaaRTW0vCd30c7f5HCF7
	 aE8d7As5NxKKYmA36pxSyE6S2hU0lfFzxHEeF8iquInElBNpK4vMVIq8JFUWzddsRt
	 Rr+0Gn1jT7iI5LorSCJXxTj68DfyhOYgR74W4+QCKAEPMxFosRjRZQHih4FILyRuIw
	 +AC6pZuThoU+GQ4vWMHIb91XtkJBalhjEEvLK0Z4wS/bsUWdipL2W6h2n3PDKmf39q
	 EWJwIiDRzLyCw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	sudheer.mogilappagari@intel.com
Subject: [PATCH net 5/6] ethtool: rss: fix hkey leak when indir_size is 0
Date: Fri, 22 May 2026 16:06:46 -0700
Message-ID: <20260522230647.1705600-6-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-290941-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,intel.com:email,lunn.ch:email]
X-Rspamd-Queue-Id: 761035BB634
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rss_get_data_alloc() allocates a single buffer that backs both the
indirection table and the hash key, but only assigned data->indir_table
when indir_size was nonzero. The expectation was that no driver
implements RSS without supporting indirection table but apparently
enic does just that (it's the only such in-tree driver).
enic has get_rxfh_key_size but no get_rxfh_indir_size.
data->indir_table stays as NULL, hkey gets set but rss_get_data_free()
kfree(data->indir_table) is a nop and the allocation leaks.

Always store the allocation base in data->indir_table so the free path
is unambiguous. No caller treats indir_table as a sentinel; everything
keys off indir_size.

Fixes: 7112a04664bf ("ethtool: add netlink based get rss support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: gal@nvidia.com
CC: sudheer.mogilappagari@intel.com
---
 net/ethtool/rss.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 9fb675d29232..f5cf214f8f85 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -134,8 +134,7 @@ rss_get_data_alloc(struct net_device *dev, struct rss_reply_data *data)
 	if (!rss_config)
 		return -ENOMEM;
 
-	if (data->indir_size)
-		data->indir_table = (u32 *)rss_config;
+	data->indir_table = (u32 *)rss_config;
 	if (data->hkey_size)
 		data->hkey = rss_config + indir_bytes;
 
-- 
2.54.0


