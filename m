Return-Path: <netdev+bounces-252353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMM8Eu0lcmlJdwAAu9opvQ
	(envelope-from <netdev+bounces-252353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:28:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932B67447
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97EEC96B63C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617E307AC7;
	Thu, 22 Jan 2026 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DQv+e3S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE1186E58
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087589; cv=none; b=LGWcxQx/oNqTpuL+z+K8kLOD8Uy8WZZNEkwoEy9yivsEMFEZOXOhHdU70MLHHktX45FdSFvYpVB1XLMTso+9P8ItnifDVCP2Ufk0Td5Tb3Q8kRnmTlW6p+rdlbGt8dg4Q33KSM9kXk2Kz30h+e64EuMWdkgNOFqMd2f1QQwCG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087589; c=relaxed/simple;
	bh=YO6r2vJD5D65wX74SFkNnkbMp+t7Qba8YyhH3bgpd5E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FDGTKETwwtn2fqF+dyhIhDT0LBlurVK7LcI16QVlmch62xuFLhRhzUb0pJdVqfutshcbG9rqY8QFc9gzYKZ+sZIVIhBqsAWG1B9QBy2KuUcM9O59zBO5noF6f9yr0ZwHCLez3JYeQnVchZEmWRwkcuykObfuC/ScERe8NBA+hgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DQv+e3S; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8946e21ad8cso11532546d6.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 05:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769087587; x=1769692387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2CYPm1a5T3x2R/t1QPKEFCdwMokC6N7Dt1Dc6j76WJo=;
        b=0DQv+e3SN/6ELyKYEkBw25eB0wqBKHtLu70/OAuO1YhJd+t+1eaw9UdubQhoZLlaY6
         MtvHLrH1eme8MptQ+5mNBQxZsFzsNFYZzAstuq+d2QBt+rrvw3COKrjzToSOLELBEibZ
         j0enBjAcSSW5BC4F2KmBnAAIZBBOXeeUJkWwq6FnrVfbAhaBWOkm7UsqE5K15a/9k+Xi
         D872MbPKCk/F3b6tHS4JbgT8xNM25IVXZHx0MtNfzLDqPn7RicLydJg8ud0NKhJ0Qko5
         +vPR8Wj4tUWH6awgbeflzO9CV5FX6fbiAdlIDr82iXrbNygnewW07pykh8sBo0ujOAPw
         5qyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769087587; x=1769692387;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CYPm1a5T3x2R/t1QPKEFCdwMokC6N7Dt1Dc6j76WJo=;
        b=xDklUDrp3/9xcMCBkjhp1gkcWgWCVzdTpb0UyxLgAe6xHTgR+OvVgBm4E2lQpiEgSR
         +gRfbGYKfKXULBDmNaiIjgZ2Y6TM9U6odo3VIciZbPj/5NihRmgcvvpNo0oCAhPZKxMZ
         ZrF4hPtBknLBAxoXb1KdW9eau/sDZj/MfDJ3DL4HKKQ0pv8RH/ycYieLmpKSQ8M41vj/
         apLZsylwDQMP+uoyLdJNujGmAlGqL+o+FKxihI4aQ8zMfAU/P5yDc6LHvBJCWm6APZlU
         rrAI5taWz2b/NVzyy3Mi6YOjPjWkvvhejuL+1b4Dp00wg8FtzSUgzJv9mcW+w6Le78oU
         d4yw==
X-Forwarded-Encrypted: i=1; AJvYcCUJXVh2Trqs7D51ouRx56iXrxwJDIlH7UGFirrDmr5hQe9USVh3ZFT8dmR8/JVegXwe40T8wGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMyPiqGOT/L3nK1KOrTNmd5qe0aY1Cp+0q8dxsRAEiLnhirUP
	wOWs7bJupNqm8zQQgGg2ZyVljfGG8hLtqobcG+u70NLN+RXAUO83T37RZTsbnhTNVvHYnNWHc38
	MdFbRX5H1F0hsTw==
X-Received: from qvbif15.prod.google.com ([2002:a05:6214:1c4f:b0:894:4ac8:bf38])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2aaf:b0:890:183b:4c50 with SMTP id 6a1803df08f44-89463e1bebdmr112787446d6.69.1769087587014;
 Thu, 22 Jan 2026 05:13:07 -0800 (PST)
Date: Thu, 22 Jan 2026 13:13:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122131306.2119853-1-edumazet@google.com>
Subject: [PATCH net] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com, 
	Eulgyu Kim <eulgyukim@snu.ac.kr>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252353-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,strlen.de,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com,snu.ac.kr];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,5498a510ff9de39d37da];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8932B67447
X-Rspamd-Action: no action

syzbot and Eulgyu Kim reported crashes in mptcp_pm_nl_get_local_id()
and/or mptcp_pm_nl_is_backup()

Root cause is list_splice_init() in mptcp_pm_nl_flush_addrs_doit()
which is not RCU ready.

list_splice_init_rcu() can not be called here while holding pernet->lock
spinlock.

Many thanks to Eulgyu Kim for providing a repro and testing our patches.

Fixes: 141694df6573 ("mptcp: remove address when netlink flushes addrs")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6970a46d.a00a0220.3ad28e.5cf0.GAE@google.com/T/
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Cc: Geliang Tang <geliang@kernel.org>
---
 net/mptcp/pm_kernel.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 57570a44e4185370f531047fe97ce9f9fbd1480b..1a97d0eafa2b0c9e4275b90d4a576f837dc286a9 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1294,16 +1294,24 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	LIST_HEAD(free_list);
+	struct list_head free_list;
 
 	spin_lock_bh(&pernet->lock);
-	list_splice_init(&pernet->endp_list, &free_list);
+
+	free_list = pernet->endp_list;
+	INIT_LIST_HEAD_RCU(&pernet->endp_list);
+
 	__reset_counters(pernet);
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
+
+	/* Adjust the pointers to free_list instead of pernet->endp_list */
+	free_list.prev->next = &free_list;
+	free_list.next->prev = &free_list;
+
+	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
 	__flush_addrs(&free_list);
 	return 0;
 }
-- 
2.52.0.457.g6b5491de43-goog


