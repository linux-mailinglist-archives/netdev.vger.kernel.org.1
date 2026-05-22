Return-Path: <netdev+bounces-290942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI9xJKThEGo1fAYAu9opvQ
	(envelope-from <netdev+bounces-290942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:07:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3479D5BB591
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F6CB300EE91
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E1339151A;
	Fri, 22 May 2026 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j74q4E+b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C64388E75
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491226; cv=none; b=LeEyWHUmtH7Vvq5hRS+4URzQAax2/3qle9TqO4ZROzSHCAXdckktHVnG47sn5Nw7DS19MVG5Eil8OHmZRbsW8/MuD/xTai9aU8O3naCZ47reUlGsuyq4oUIUzNXK7acDxc0I4Ku/o89I+46BhrbYGybPykzeGRFHKqLko+18bWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491226; c=relaxed/simple;
	bh=XWeepmNHNv9olbISOQNu5gErs4FYFYMayNTVOTidpaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPCdwruTjp3PZa9aXmb3ntNevT3vbB8p6hns8028ZJkioBOgw3ZNx6BjV2Dos6cKT/T7BxPsgoKFbvjsQjnW7H/owZxdERxhiyncOFIxxJoei9LkIPaIBbPfz8aeRt4yYu2klsA5b4gCdHFqMGsp/aJ7l1H6akylVoVSniCKrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j74q4E+b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B421F00A3D;
	Fri, 22 May 2026 23:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491225;
	bh=wXPff/cE86Ot6X5zocdNw/63RCf4dJ8mh7T0RCtEgfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j74q4E+b8PABAf+PliPr/md5V84CXn5ECXNu9EvXzV68dK6txcZA0zyFdkUMnGbUn
	 gRCuIIOPrXD1Dz+xgsJuykS+lQ6Adh4+6S/AxdyxmbE++FVnqPWCpDL17BbdV8ZtyJ
	 EYF1V3OiZSVUO2XNqrzDmVH6QTwWwHG5IRW9YdpTMYFZc72KaqwbyS0bdNgH0AjEiT
	 wClQ0j7QihHMwY0QUDBEL0cnYkTNXaElDNYmPn7ahCDYIbgZNeTjpQbZ9ARTvp8wnm
	 u5bnIKI7OIv3kO/JKZfjTxUV6GXcNtBUSMS5XmhsRxYq+rAv4ubSbNvbTmqaT9k9kL
	 HfU/4AxAwDqow==
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
Subject: [PATCH net 6/6] ethtool: rss: avoid device context leak on reply-build failure
Date: Fri, 22 May 2026 16:06:47 -0700
Message-ID: <20260522230647.1705600-7-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290942-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 3479D5BB591
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We wait with filling the reply for new RSS context creation
until after the driver ->create_rxfh_context call. The driver
needs to fill some of the defaults in the context. The failure
of rss_fill_reply() is somewhat theoretical, but doesn't take
much effort to handle it properly. Call ->remove_rxfh_context().

If the driver's remove callback fails (some implementations like sfc
can return real command errors from firmware RPCs) - skip the xa_erase
and kfree, leaving the context in the xarray. This matches how
ethnl_rss_delete_doit() behaves.

Fixes: a166ab7816c5 ("ethtool: rss: support creating contexts via Netlink")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: gal@nvidia.com
---
 net/ethtool/rss.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index f5cf214f8f85..53792f53f922 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -1106,7 +1106,7 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	ntf_fail |= rss_fill_reply(rsp, &req.base, &data.base);
 	if (WARN_ON(!hdr || ntf_fail)) {
 		ret = -EMSGSIZE;
-		goto exit_unlock;
+		goto err_remove_ctx;
 	}
 
 	genlmsg_end(rsp, hdr);
@@ -1134,6 +1134,10 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	nlmsg_free(rsp);
 	return ret;
 
+err_remove_ctx:
+	if (ops->remove_rxfh_context(dev, ctx, req.rss_context, NULL))
+		/* leave the context on failure, like ethnl_rss_delete_doit() */
+		goto exit_unlock;
 err_ctx_id_free:
 	xa_erase(&dev->ethtool->rss_ctx, req.rss_context);
 err_unlock_free_ctx:
-- 
2.54.0


