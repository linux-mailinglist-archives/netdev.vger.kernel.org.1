Return-Path: <netdev+bounces-290939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCWVHt7iEGqOfAYAu9opvQ
	(envelope-from <netdev+bounces-290939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:12:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D92105BB625
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9400302DF61
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6D364047;
	Fri, 22 May 2026 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+sdhDYf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4138B130
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491225; cv=none; b=Mfs0Sfq7+L3ETEzqvV2YGiE8+zphsKGcvUadj3BxT2/XHNco5uvAUm3//VwE9LWHZ0eB3km2VTApu+JyxylwnblrzT20IsS53pOuEk9z0qppRedMcLjm/53pCo/t11JqRsy42CnPZl/2QLDK4ASl8KtBv4h34cHbFK4QRZu7sqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491225; c=relaxed/simple;
	bh=6S9wYcZImySBkhG25SRUNvDQFFge/giUOm7Vs+S1Dx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OplOcNoIwAsrA0JsUF3HlJqPRpieDtnEB8c4LTSKwBIi1O8PTrpds+iScASSYYsAihXVnK4jaeCL7kozO9s1Oe0rDovT3VkfXkaUJI1nTGogVB1Ut/4eWuWkWghBGWMX/8C3iqpOtZ8b3Ds3/xBIJkBoARSZwUPI/HdvZhz+TLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+sdhDYf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5CB1F00ADE;
	Fri, 22 May 2026 23:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491224;
	bh=fT9NyrBAJIrDB/eTQmTWpEWzN2hg9dBkMkatr6vy69s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l+sdhDYfYM64J5xu+rkecJIjXPlE3+bEIA8rVE0jU9m2i+vcRTE8Ko1YzjMx8CaMI
	 BycEbWlUOE6HvLZqmE5zioQc7qijngNVqe+SQa1rpd1S68QpUChlnH5cO4GJOjll3o
	 MFncjMC58WQ7e3/yaPRgegV+BHWcnGqmKY4p0vzxHehbJiw71qjxvUBn0i3V5CwDA0
	 Urj3VBqiFYdW24dPxoNwQZ6jPBaP9u93hNFp8W/GKpenLVFCkgv0o5MU2PFa4LHPMT
	 CDVnDDDcK71sNMZTtnRM6C3hi9Q7xGkhygspxvWlAPPGZ/wNHFaKo0a+FU1Eb7li03
	 Fk0pKY8gP0nqg==
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
Subject: [PATCH net 3/6] ethtool: rss: fix falsely ignoring indir table updates
Date: Fri, 22 May 2026 16:06:44 -0700
Message-ID: <20260522230647.1705600-4-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290939-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: D92105BB625
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rss_set_prep_indir() compares the new indirection table against the
current one to determine whether any update is needed. The memcmp
call passes data->indir_size as the length argument, but indir_size
is the number of u32 entries, not the byte count.

Fixes: c0ae03588bbb ("ethtool: rss: initial RSS_SET (indirection table handling)")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: gal@nvidia.com
---
 net/ethtool/rss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index a16ee1e8e640..458a4a7907e4 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -686,7 +686,7 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 				ethtool_rxfh_indir_default(i, num_rx_rings);
 	}
 
-	*mod |= memcmp(rxfh->indir, data->indir_table, data->indir_size);
+	*mod |= memcmp(rxfh->indir, data->indir_table, alloc_size);
 
 	return user_size;
 
-- 
2.54.0


