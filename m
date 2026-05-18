Return-Path: <netdev+bounces-288852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL23LLyeCmpJ4QQAu9opvQ
	(envelope-from <netdev+bounces-288852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:08:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9E1565DCC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87B1E301E99A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14D38910E;
	Mon, 18 May 2026 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/gzu32k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E3388E46
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080852; cv=none; b=KnU7t22ov6CLHnkMPvhVWtmqj5RNPJDAufxPALu3OYD6Fs85A0SFc3h3KljX/VXjLy2ZKhnZHdM8IjrLqu1Q22Y5GdRzmE06vHz39+MmEWZuca1zVegOQfPVNFtF56MMsfy4FhFHrIGoHXm3ek8RSXN8VDwQZNUK8jo1uUaksnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080852; c=relaxed/simple;
	bh=H3Mw0sLDQ0PrNR0N11yB2FK6Q+aTml5xdW4yQPbZRAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MjkNVnLoWSE0xA7D23wVrcDnwr+Z6v0XaiqGLteFanTPibil88m9cbCj7RTdHuYISTNwS0ji2CYKeSo4z/KLNvWIdUyWfrSzLhc4QMtEX+r0i0XpFMFPY7G3njVnkwoo1zngshkXinuQAd9jt8n9hs7QBvLUs6hgWLGSQV23qCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P/gzu32k; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc977e6aedso17079255ad.2
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779080851; x=1779685651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcvuRqAQjK0dhJhGCruHpLuOAtOmcNsS4wjgr0PhSjY=;
        b=P/gzu32kd/kJQrfbA5uirrXJ/vZT/qe/wPlHC841Fe9FG+rzkBg9U/TMMApzSAmzXe
         U2N5CJLjbs375tfmqC99LFwne4FcEeXaxUdFtmXcpuaQp9GVftXhSghhg4sJFnSwiGtP
         dOym8xt1ZHois11x8KSuS/Jov/qkFUsOQysjcOv9BWSWCDdf5nTZL6b/S1Y37GriH7L5
         LhiBsJbXqYWO9VDOFMTbBHScGimBxxGsZJjZNII886lyRmXeq7gOxynji8UtEpcD2zR7
         7IwWuPl6qp+saT06DvQgyPPVVEgV6y7uClgcf9j5j9KlUw38C8FGNlxONhSzOkhhrw7J
         ipIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779080851; x=1779685651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcvuRqAQjK0dhJhGCruHpLuOAtOmcNsS4wjgr0PhSjY=;
        b=U2KvFCMwVIQ6dkCQnirUVYLeexmSEU/xXpNZUQUJ+Cl6HBmlr/zw6OeDNXoAXZWJEE
         adS9SZzwAQkyi6dbTV9YnA6Be8+gwb1kygbFkLnr8OmtP1yHcHTodgvJTeU0xlbSHBDY
         zoC9GbCa0gQwPB8bcRcISAqGBA+vF4thNmKngghwrBW9QnsbwwNieFTZ4AAr8s5vIXuv
         g/teW3/LtvAth/Ga/+fSGydoa4XCGo0Y3YLzJbLsLUAsjYnxNvR8sSXYmUzKM+/e9st1
         VFvBP7iwgwYKhrBs1V/bXif8G91qGt3enqzlERWgtZF0+B7FYUQlnWttqr11Rout0hck
         BJVQ==
X-Forwarded-Encrypted: i=1; AFNElJ96bXK8RbxlmGTbKX5+79LA1vMPHlzjRWOJqpP5uXidsohPSck6dLmjykCceljOqpAlYQlEV/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXy1o+TT7+S/h6KGcXiEEsnLLJ8TNDKUrS0slF/GVMNW2TU/ci
	41nYwzHjcvQuBtqDa9WR2e0fNkorXQaXt/FnjnMboy51TK5zrxYDfWV95UIpRTN46f2DbC4KvlK
	091hryQ==
X-Received: from pglc12.prod.google.com ([2002:a63:d0c:0:b0:c82:7761:993e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748b:b0:39c:787:f197
 with SMTP id adf61e73a8af0-3b22ec70cacmr14791810637.36.1779080850760; Sun, 17
 May 2026 22:07:30 -0700 (PDT)
Date: Mon, 18 May 2026 05:07:10 +0000
In-Reply-To: <20260518050726.318824-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518050726.318824-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518050726.318824-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/5] geneve: Remove synchronize_net() in geneve_unquiesce().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6C9E1565DCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288852-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When changing the geneve config, geneve_changelink() sandwiches
the config memcpy() between geneve_quiesce() and geneve_unquiesce().

geneve_quiesce() temporarily clears geneve->sock[46] and their
sk_user_data, and then calls synchronize_net() to wait for inflight
fast paths to finish.

geneve_unquiesce() then restores the cleared pointers, but it also
superfluously calls synchronize_net().

The latter synchronize_net() provides no benefit; with or without it,
inflight fast paths can see either the NULL pointers or the original
pointers alongside the new configuration.

Let's remove the redundant synchronize_net() in geneve_unquiesce().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 4e5d0a09a82d..e8ff03ed87dc 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -2206,7 +2206,6 @@ static void geneve_unquiesce(struct geneve_dev *geneve, struct geneve_sock *gs4,
 	if (gs6)
 		rcu_assign_sk_user_data(gs6->sk, gs6);
 #endif
-	synchronize_net();
 }
 
 static int geneve_changelink(struct net_device *dev, struct nlattr *tb[],
-- 
2.54.0.563.g4f69b47b94-goog


