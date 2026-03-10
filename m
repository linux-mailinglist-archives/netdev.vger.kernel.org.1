Return-Path: <netdev+bounces-265814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uER6MzFor2myXgIAu9opvQ
	(envelope-from <netdev+bounces-265814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:39:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F06724312B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E465301C6D3
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C9823DD;
	Tue, 10 Mar 2026 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlfXZi6X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F374C14
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773103149; cv=none; b=HG7LgBQAyap/pDCgAzEQ6kLfBl6jOnJIIL2uS2nWsfF326x0oz1oA/rz+GQCl60fRDfDdjvi0xKdN7WqBHkovyRjzI0L3KHZfLg71sUSAYgwp5loFB9m/Le0yoV/RPdin3O7XFiMBU8C/foJhEz/nxsuMXnmAru1Wy5HyvrOkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773103149; c=relaxed/simple;
	bh=d5ZTjxp9qrV1J2ikD7jMeZdBfSA6ldodNhntJyxDJEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a0qCs7D1tYy50Wg8/Fgnydh/d8wLgFBES4PlVSU/vMqZalYju2U8uAuJFz/JFg3/SawyitkqCBCREMdOUD3db0C0D0PWcWZXxsNDtMpuwe/ZOJLCspJl/D4TPT7qW1J0K89joo+/AIyb6RTyvoRlQQ+6P3Mfr31czz6iXzSCWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlfXZi6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1CFC4CEF7;
	Tue, 10 Mar 2026 00:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773103149;
	bh=d5ZTjxp9qrV1J2ikD7jMeZdBfSA6ldodNhntJyxDJEs=;
	h=From:To:Cc:Subject:Date:From;
	b=JlfXZi6XNz43t1w2yTt0kE7fXM/zRi8+mGtvoeXEc2SoavPfoVF+UoS0tHHKpLq8S
	 seYEvQasw5CfPQibr55x0YA3NG5Wmla9tH8MDCcTQTfii4PPRvesVRQAIYyWVmJ07G
	 tkUQHj6Rlu+xoedX7rqiHKyVSBXqJ4yv8VpvxMt3tYkFLlbLHi3i1s0ea0Cz3WDpsZ
	 Q+VfCyAWkcAYaacShljVc6KoKGDE1hDisam2joEDKQBRYhhC5maOahnvQVQ6xkhllY
	 Sol03Bk/iP86hUrhD1wj4x6FP2xmhsqBCJvtYtYEMIwUUvf3ABQJ/abb7y0YP7k5qe
	 K9t143zDp/fgA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	ilias.apalodimas@linaro.org
Subject: [PATCH net v2] page_pool: store detach_time as ktime_t to avoid false-negatives
Date: Mon,  9 Mar 2026 17:39:07 -0700
Message-ID: <20260310003907.3540019-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F06724312B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265814-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
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

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Fixes: 69cb4952b6f6 ("net: page_pool: report when page pool was destroyed")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - make it build
v1: https://lore.kernel.org/4e45407b-5c6b-4832-b403-ea62b1e4bcb5@kernel.org

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
index c82a95beceff..ee5060d8eec0 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -245,7 +245,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		goto err_cancel;
 	if (pool->user.detach_time &&
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DETACH_TIME,
-			 pool->user.detach_time))
+			 ktime_divns(pool->user.detach_time, NSEC_PER_SEC)))
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


