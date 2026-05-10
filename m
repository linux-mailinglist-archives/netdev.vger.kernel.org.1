Return-Path: <netdev+bounces-286389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBw1D93cAGoZNwEAu9opvQ
	(envelope-from <netdev+bounces-286389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCAC505FD1
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FE6A302A079
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32DE332907;
	Sun, 10 May 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgRAWDzC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2733260D;
	Sun, 10 May 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441351; cv=none; b=G+gZZjO10PdBZfRTOI2aRNnQBAwFKnMoJFni6eFzO0E5MP6/8/3oPZBJ+zAd+vXCdJneWihmAGXPKhAMFuvjsSKY0j8upmbO34fZVtZHUzRHP0tfs8sG/BxbWIYhHUVaPlUGh7MG3azjtclIHU0YN9656o5g8jbTLv4IePXtJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441351; c=relaxed/simple;
	bh=tOgil0HpV0Q1URMlTYQMOxZJZY/D7eP0YfOUKTdXP54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoaZ/0LEx4/si2Fuw8WzUZJOdLiLCRskkA/xdLa5H8BJr6vX72zx05ZkbbgKwkRaVhx1XtGVI7YEDQsO+iUe1kKew4dbmklqS8tAZudHe+N3dY6T1iVqkvbKOG52MilAv1S72qOQ2P8QMDtRKBkBawaqW4RN9Mitg9shih74vJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgRAWDzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A4DC2BCF7;
	Sun, 10 May 2026 19:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778441351;
	bh=tOgil0HpV0Q1URMlTYQMOxZJZY/D7eP0YfOUKTdXP54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YgRAWDzCI8MuUdlwawZvYqRB+5qPqjL71QHYn2dPcgnx4+BcXm2Hwq12dOj+vvKFd
	 U5Rgb+ZIwx8BYiuHzUnM3HIMWyhdw01v8T9gY5eOG496D+B3x6W5XeTM7LxXNOhKo+
	 Xnhh7k72VwJI1KEPuN9XcF3UQN8g5P2qz2U2PoQnkuNBEqX1CgsmzHGhTJ1sXSQfJC
	 GIEEr8rXYILoqYUGSZO1skuioKUVp4ISutETe546M7437PpoCP4Qwmjjjvmir4KtZX
	 09Z5+14Jha/mx+ujd3ZQn0lrnGNYCTWRIR8GcksbqZu4ez0OgWh/r03Fm+WGFpxgYr
	 +56TUCV5+LPZg==
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
Subject: [PATCH net v2 05/10] net: shaper: set ret to -ENOMEM when genlmsg_new() fails in group_doit
Date: Sun, 10 May 2026 12:28:59 -0700
Message-ID: <20260510192904.3987113-6-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510192904.3987113-1-kuba@kernel.org>
References: <20260510192904.3987113-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBCAC505FD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286389-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

genlmsg_new() alloc failure path in net_shaper_nl_group_doit() forgets
to set ret before jumping to error handling.

Fixes: 5d5d4700e75d ("net-shapers: implement NL group operation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index c8960821cf23..12e5e0c18643 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1276,8 +1276,10 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	 * rollback on allocation failure.
 	 */
 	msg = genlmsg_new(net_shaper_handle_size(), GFP_KERNEL);
-	if (!msg)
+	if (!msg) {
+		ret = -ENOMEM;
 		goto free_leaves;
+	}
 
 	hierarchy = net_shaper_hierarchy_setup(binding);
 	if (!hierarchy) {
-- 
2.54.0


