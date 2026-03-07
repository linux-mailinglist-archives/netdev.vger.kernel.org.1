Return-Path: <netdev+bounces-265174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CT/Ej2NrGkCqwEAu9opvQ
	(envelope-from <netdev+bounces-265174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 21:40:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA822D891
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 21:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56B2E3014543
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE10534CFAE;
	Sat,  7 Mar 2026 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CctEjTKc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3814F9FB
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916026; cv=none; b=hsbY6EFvrUGJn3Z02yx13TwpuCWkKVHBXUHiUQmTIVzNvPWY3VloL2YYJoFUWcc0ABog3miKLUb4hgdyUA/euTKQkYT+LDs+mOLNj5/HQ1daY9AeWIHxPyTiziLBAV6jM0U+pW1IjmUFCv/TeiCUcAzbVrmlVPmjcfm7CLqd0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916026; c=relaxed/simple;
	bh=Cpr2Uic3s9rYLSzQPLL1LKje87F3xiYZIGU4Q09hRSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYN58hTWJyfwSVf0T2uF2hCdiKi0OVaz5h48TpDxY8UcpxOYnxCu9l6yjwiYPQm5A7mNGTverhA/UHlxqPGhKGJLW+p+fwOvVaHE8vrFQps+0xbUJTEvYkgMeKXRSasUehWhdsLUgdlwAk+wEojCbdPqK0SAHksUTqto1F+E4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CctEjTKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE6AC19422;
	Sat,  7 Mar 2026 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772916026;
	bh=Cpr2Uic3s9rYLSzQPLL1LKje87F3xiYZIGU4Q09hRSw=;
	h=From:To:Cc:Subject:Date:From;
	b=CctEjTKc1wApTv1oYo8PiGUqfZq3gU5o5d9iazUcSFPwoloJ3RMaXGXOmkrOdacY/
	 i2ci+HXyQhSBALavLdpvZ11QFusuB4c2FwtmiEykTEKSjFwn9XZyq8bPH4IDOWIsQk
	 hUJK7UAREjrBvWn8nDVOwgfc5hnmvwUsgeE4ronjv3nQamh/k5SsUzGZX4gM7IoR7J
	 yQKw+8lJ8bil4X4POt+SiJ8Ui9h5QJR9Ub9lUga5+/7Z/+BIZF82dKOaNFHmlXm5Yz
	 QwE4Fe8KiSZK1bWR4C68wr+V2HeJExw5RS9n0kfXoQoVARbukuVIpruT+OWF73gxpr
	 uPHLtOQcAFS3w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: [PATCH net] page_pool: store detach_time as ktime_t to avoid false-negatives
Date: Sat,  7 Mar 2026 12:40:22 -0800
Message-ID: <20260307204022.1897614-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A2AA822D891
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
	TAGGED_FROM(0.00)[bounces-265174-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email]
X-Rspamd-Action: no action

While testing other changes in vng I noticed that
nl_netdev.page_pool_check flakes. This never happens in real CI.

Turns out vng may boot and get to that test in less than a second.
page_pool_detached() records the detach time in seconds, so if
vng is fast enough detach time is set to 0. Other code treats
0 as "not detached". detach_time is only used to report the state
to the user, so it's not a huge deal in practice but let's fix it.
Store the raw ktime_t (nanoseconds) instead. A nanosecond value
of 0 is practically impossible.

Fixes: 69cb4952b6f6 ("net: page_pool: report when page pool was destroyed")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
---
 include/net/page_pool/types.h | 2 +-
 net/core/page_pool_user.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 0d453484a585..cdd95477af7a 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -247,7 +247,7 @@ struct page_pool {
 	/* User-facing fields, protected by page_pools_lock */
 	struct {
 		struct hlist_node list;
-		u64 detach_time;
+		ktime_t detach_time;
 		u32 id;
 	} user;
 };
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index c82a95beceff..fb4ca27358cd 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -245,7 +245,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		goto err_cancel;
 	if (pool->user.detach_time &&
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DETACH_TIME,
-			 pool->user.detach_time))
+			 ktime_to_seconds(pool->user.detach_time)))
 		goto err_cancel;
 
 	if (pool->mp_ops && pool->mp_ops->nl_fill(pool->mp_priv, rsp, NULL))
@@ -337,7 +337,7 @@ int page_pool_list(struct page_pool *pool)
 void page_pool_detached(struct page_pool *pool)
 {
 	mutex_lock(&page_pools_lock);
-	pool->user.detach_time = ktime_get_boottime_seconds();
+	pool->user.detach_time = ktime_get_boottime();
 	netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_CHANGE_NTF);
 	mutex_unlock(&page_pools_lock);
 }
-- 
2.53.0


