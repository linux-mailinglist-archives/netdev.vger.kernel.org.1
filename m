Return-Path: <netdev+bounces-281318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN5rDeZM72kEAAEAu9opvQ
	(envelope-from <netdev+bounces-281318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:47:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C654471F85
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A24D2303E498
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BC315D21;
	Mon, 27 Apr 2026 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iQvbU5TM"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92BE283C9D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290392; cv=none; b=C+7Zc1c+PMMbtnDD25rrt9A7VslMVoiy67+T1JTaXYqTVw4qRR0zPyffE0ZfcIc9srEQum3Zjdp1q8LsiMmRW/3UYCPDvkzb/pRDzl5VHQZyBd11YJp4/ab0V48EqJ5jh8eZ52zT2OMdN5U6C5j75D91DoQ1/mX4mNz+LFzmkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290392; c=relaxed/simple;
	bh=5mPeKBwAAbgmnWDu0I97IzoRikmrmG05cBi32XW4Blc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUDWiBTxDoQQZ/M6TMbPnOodzlocaQiEmdK8577qoq+DVBB3VvhLzUE7quCTpoAWxZKw85lp7sbJJywEQALB14CLzYJNfg/DRsgmtLRJKh3PAO0olRVB7yhDm+QFWTF71UYwAr2PQjUO8jnyGH8zZOsgjJCuiGCPcnTtLJydC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iQvbU5TM; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777290387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVA1VQUcnFGHRab+BRK84S5Q8hgSd47XLyD2o5djFEI=;
	b=iQvbU5TMxkPyFAnC9KRyNA/R723wtmPLpyGbgaAhAt9CHmayMEB2+603uQ9KRDoiDexckJ
	7e9UdeBIG2dDOBX6eIqgXg8ayeb2Ay5tbBiTLP7z6yVLT2rkJuTeFuWPl3bg1Z7nB+hTul
	YnA05947N63YtVfH9PpisJZltXGRYVc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Tim Bird <tim.bird@sony.com>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v3 2/2] KEYS: annotate struct user_key_payload with __counted_by
Date: Mon, 27 Apr 2026 13:44:24 +0200
Message-ID: <20260427114422.313356-4-thorsten.blum@linux.dev>
In-Reply-To: <20260427114422.313356-3-thorsten.blum@linux.dev>
References: <20260427114422.313356-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=thorsten.blum@linux.dev; h=from:subject; bh=5mPeKBwAAbgmnWDu0I97IzoRikmrmG05cBi32XW4Blc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnvfWQm73gqxRLA6m8je1l1b1Nlz4eJiSGGLGecXYwm7 DzMMi+vo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACZSu4fhN+uVxLAYzuBsT6uo BXfPlCzo7JlcnXVl91/rG7u/NFzRnczI0D0x8Oej1PK4qx3b4/cE+Mh82yGxqphDXa0pqnqaQdh ObgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8C654471F85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281318-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add the __counted_by() compiler attribute to the flexible array member
'data' to improve bounds checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v3:
- Formatting only, do not split the declaration into two lines (Jarkko)
- v2: https://lore.kernel.org/lkml/20260409225703.158552-7-thorsten.blum@linux.dev/

Changes in v2:
- Use __aligned(8) as suggested by David
- v1: https://lore.kernel.org/lkml/20260409073711.57020-6-thorsten.blum@linux.dev/
---
 include/keys/user-type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index 386c31432789..30de4f92a721 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -27,7 +27,7 @@
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
 	unsigned short	datalen;	/* length of this data */
-	char		data[] __aligned(__alignof__(u64)); /* actual data */
+	char		data[] __aligned(8) __counted_by(datalen); /* actual data */
 };
 
 extern struct key_type key_type_user;

