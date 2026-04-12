Return-Path: <netdev+bounces-277731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ+dHC7/2mkQ8AgAu9opvQ
	(envelope-from <netdev+bounces-277731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 04:10:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C37E83E2720
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 04:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B34AA300F107
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 02:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB42046BA;
	Sun, 12 Apr 2026 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCcG9hVp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBCB19ADA4
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959700; cv=none; b=sJmQtrSzdmEDhdzNQs1EsqvD2TEcGpoUKlu0mcNEijwSC7URj5UI8QidAiptdPXYq1+ygIhA0W864F+irwUSDMqHgnxy509qBGwrIPKsJzqiOla4YV2B4d2o6v9jWZ5PGuxO1VWGLI8FB7So7NHZpGuLElj/aHV24q516GltsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959700; c=relaxed/simple;
	bh=mFrqE7lagXsStiOP0X5yiw/yF1d4Ff2IenPECsOcHyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mquMRg4fC/eeNr9NHWmFH3GnIG6JApgyUp1xIYDA83V9FFkiM8Stj93NRCoWcWpsed49ybb/sf0qmuSu233u1MX/cZ6WWkFQ2WjrNbEBcUTAQPGlBBwaCEYoahIUSxgNaPrpGqm1GQKYyR5HMCqbves0APcPsjNHTXSo6Tz/pCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCcG9hVp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c766cf593daso2301497a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 19:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775959699; x=1776564499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikzjZv1iNggTetoTHsLYE3t4Vk7xU7GQd3FBLtlxYmA=;
        b=lCcG9hVpuogR376NiO57mPJmnDX6iEVrchJ8ZVqRYvYb6Gq9VkkAEhQ1nvpLv8R+q9
         dUmqGKtc1ibkCnNCCBOTHs4zYSafsvxHzpE4Wvr1rIzuwkLCo0P527oyXHxvGVvkanuW
         h7REUct16UdBjjAeELkIJUR7bxUYmVExpEZYS8snHLHklO/tQ05+3p2v7NzRMZ2Xo3Xw
         wF9C+HeOCt36egf14UePQi5rHm3eHwEmYxnCqNYQsxi1cXBJ+sDGraw67OUwfC1HzEVn
         xbG9+g3+BXk7w6frQNhDje4mCT4tms+Cg3+UPTJkM4v02MG9epNbQ1ANCSf+5o5wrMyS
         pZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959699; x=1776564499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikzjZv1iNggTetoTHsLYE3t4Vk7xU7GQd3FBLtlxYmA=;
        b=PdIb/fX+JVFceH5K5Y+H8KOwbUqnZFK5tQgfmCrNIGHnAx1nFi/45uNrjZl7mnQIeM
         iciQRrsvzmIpB2DkWNgjjOccpO++IzzK5T33OXRFIcervmdIjHhNFO1xU4/MJpB+6n9H
         nSa/pSzPW8IL6uDQam6xE7v2IzFZeB0hSS8FrF5t3isznGpNwNQl3FVlK9ghrpBQYhIG
         OVHcBN67xnXjKMUladGLm2TUoYyYYG7OK7DjO8bQNN6PA2F2I9CoeDlpN/BPxGU1Z1iB
         16EUsLP3nrLTqLyhd0FMMIAfokqjGhoWBqd2CdqdgMIrZMj9/trGfdEmSJw5nkQQh9bs
         H7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtS6A8b5U/fqmD/3uSrSCZUKvYgTcCBTXXLpJwm4ivbdjXFVeScYMcD27hPsQKuNIdbk8fb74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDeWd96YjeAYm4riYJHTrWPZ+wsUhqrjqWU4K2C65DDfrSOX97
	0jGtfDbkIvQgChNr3KlOz4pL9gX6oWLQOimwhWusw3XYOs0Voqp03CAT
X-Gm-Gg: AeBDies2XtYTnNxaszeaREJw4OtwtYVA2SJRU7JiQOuZY+urmk28jwyImOZRVKC5sTE
	rvF70pBJzZ+SgDRhOumGxFkaaGgnwJTzZ0Bq30Q6DQxbosd1RbBbjrM0HRPrfthDV3c5wNip03t
	1dnSCZRxBlYzQFhby49K/cMe5gweQZAXiu/xpLZ8DXGgF8KWG0QvbOCPH1b5BR9jfAejR4HRVv/
	qmQin+ymK1ytpUpUGad0RujmRSoqcN4L4dsvAKYaJ/5aYlqOYVzl8LOdSjMUJ82qao38GNM/l6/
	sJluldl5iqUrW8udjKEMRCXcC8cxtfUTnHwUklrjDjZuBYuVAftQIXzHWJhlHx6IXDXvrk3aGjs
	9nbIMleGx2MimuwxoeOlNF65Q9Ir4Us/hjM1xWMw6rTNqIK7MiE+eYsHjrGDV+Jny+PayoqEADT
	PkN5GwHtTix3fl1K8XctUad3Czqn8GzWW50iLPIvU9ROPosTXxja4eI+11d12oT+9lHOpyGV4tq
	QNwlQ==
X-Received: by 2002:a05:6a20:8d07:b0:398:4a5c:d5a3 with SMTP id adf61e73a8af0-39fe3f4f2ebmr6849021637.34.1775959698904;
        Sat, 11 Apr 2026 19:08:18 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:eeca:64a:ce77:d090])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ffa87sm5677058a12.5.2026.04.11.19.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 19:08:18 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: leon@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+901d48e0b95aed4a2548@syzkaller.appspotmail.com
Subject: [PATCH] xfrm: fix memory leak in xfrm_add_policy()
Date: Sun, 12 Apr 2026 07:38:09 +0530
Message-ID: <20260412020809.35465-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-277731-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,901d48e0b95aed4a2548];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: C37E83E2720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When xfrm_policy_insert() fails, the error path performs manual
cleanup by calling xfrm_dev_policy_free(), security_xfrm_policy_free()
and kfree() directly. This is incorrect because xfrm_policy_destroy()
already handles all of these, causing a memory leak detected by
kmemleak.

Replace the open-coded cleanup with xfrm_policy_destroy(), consistent
with the error handling in xfrm_policy_construct(). The walk.dead
flag must be set before calling xfrm_policy_destroy() as it requires
it via BUG_ON(!policy->walk.dead).

Fixes: 94b95dfaa814 ("xfrm: release all offloaded policy memory")
Reported-by: syzbot+901d48e0b95aed4a2548@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=901d48e0b95aed4a2548
Tested-by: syzbot+901d48e0b95aed4a2548@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/xfrm/xfrm_user.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d56450f61669..ae144d1e4a65 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2267,9 +2267,8 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (err) {
 		xfrm_dev_policy_delete(xp);
-		xfrm_dev_policy_free(xp);
-		security_xfrm_policy_free(xp->security);
-		kfree(xp);
+		xp->walk.dead = 1;
+		xfrm_policy_destroy(xp);
 		return err;
 	}
 
-- 
2.43.0


