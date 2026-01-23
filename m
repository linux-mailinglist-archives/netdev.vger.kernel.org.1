Return-Path: <netdev+bounces-252622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vYn4NRPlcmlzrAAAu9opvQ
	(envelope-from <netdev+bounces-252622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:03:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 390096FE3A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3BF63005E84
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5723AE9B;
	Fri, 23 Jan 2026 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuT0oK9A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091A2DAFB4
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137423; cv=none; b=szqUPLoEV8UKqnE6gHoMw0DXD+VUMtArgfUBwcp/KKqKyNs0Z7qXYD3OShN2F5DDeJnepAKQ1xzv+k19tgqBNgtWbHOI/ZekmktX9vqPocNlb2lV/nuaZdfRbejzW0hquGjgHjiZ+FwtxFV58idJ0ratGt38FPFDdVTVUpyrkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137423; c=relaxed/simple;
	bh=U/FNq5rdpbdcZGN7Huo5dHrKnrH2MlVUn0VSIsLzWvg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uK6ahJjaPp2sqsKaJHBbfUQwBPzPW7qs0LJn0aOug/CQNKSs8/SIqf8Go/pohq3/1N5pbaVczdHt6qkbUgMAFce+vEzFcpWQmzy1hwpuK3sbK38aKLe0Uu6xjbKPkDKbvNNmSL0jMJuRIRybDOhOg2la6bgp1hpBovIAk7s1iOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuT0oK9A; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c6a291e7faso574195785a.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769137409; x=1769742209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fA6qxRoEFh+rpwIl41Oht/rMATH6zAaeudQmjuunb0g=;
        b=IuT0oK9Au0MrqobZlkgNsCr4vPhBjmJMjGemovvJlKz06n4ZIVf8jMBJ4xVddSIXNb
         gWGMB/EburXlupJnCd17EGx5yxbs0+9+2pa/70gdO2wApFHE3Gjv3Lqs+ylRKRRElgqu
         AlZe8PlQtsHBsefd08JBdDM0LqTIZ+7WMGZtFtZme49IdqkJKsCRVDP9+AJpbRnJOQZl
         4gOTTAgBDuE184BcInXGOI/HinadyvIE2v03s/OgYQ2dpG0+2tDwK7/0OvQJYjAqOR3e
         oojywr2kq2UOGJNT8ouSPShpIzxW2EijRobEJcqQuZK+5RlL/ybFkeYleP5EBS+gWN0f
         r/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137409; x=1769742209;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fA6qxRoEFh+rpwIl41Oht/rMATH6zAaeudQmjuunb0g=;
        b=nPEijlNE+X7b3BOJ99GhYZL4BdLQpt9kMll1DRyiBoVRq9bfDnkbOavR7Vd/9VuNyz
         YcRtc65hBYgWBsLhnDWFTpxoebovSNztg3iIl1diznd2T+2a0d8ezsrmBh0eaTnaV9Zn
         pW57/FXx8iSqfjDpYSfB0VX1T7u8lncxUdgXXWAk8T1sDmox2HuzBmfPCOeBmHXOxE9g
         ZP03bb7XdNfTKXgD+mq+73Jzz2jZ5tK/3svXjZ+WPohhpa5vbjD9t21ko6FyOGxlIYYe
         Ee5lbUhZ/VtYp9/2cXXoHBGiyHQJSzGvfB1ubMSFFxdSCftoPa9eDco36u1HgI8LMfW5
         KIbA==
X-Forwarded-Encrypted: i=1; AJvYcCVHPQ80V2CDxFG2nj7xOlu0Hmzdpsf1w+EKkeNkw+Cqnevsupt8tPpGAzFb9Go38VaEXPMTcrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOnTvZAfqyR7a27xxpdxssV/zKYqq2a4xffTv1BndABTPm56pY
	bk4KFsTk9KVeill9bdxjkID3MNTb0eVbd/083cZOCm6tSrew6xlQ1aMwlxaZOxyCmDocw3YyGpz
	Ngg5aptg+KrZmuQ==
X-Received: from qkbdv10.prod.google.com ([2002:a05:620a:1b8a:b0:8c5:335a:95f3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:44d6:b0:8c6:af59:5e2c with SMTP id af79cd13be357-8c6e2d8d992mr218217985a.18.1769137409254;
 Thu, 22 Jan 2026 19:03:29 -0800 (PST)
Date: Fri, 23 Jan 2026 03:03:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123030327.3041148-1-edumazet@google.com>
Subject: [PATCH v2 net] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@linux.dev>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com, 
	Eulgyu Kim <eulgyukim@snu.ac.kr>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,strlen.de,vger.kernel.org,lists.linux.dev,gmail.com,google.com,syzkaller.appspotmail.com,snu.ac.kr];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,5498a510ff9de39d37da];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,snu.ac.kr:email]
X-Rspamd-Queue-Id: 390096FE3A
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
v2: Make sure the list was not empty, return early otherwise.
v1: https://lore.kernel.org/netdev/20260122131306.2119853-1-edumazet@google.com/

 net/mptcp/pm_kernel.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 57570a44e4185370f531047fe97ce9f9fbd1480b..af23be6658ded4860133bb9495c7738014815d28 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1294,16 +1294,28 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
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
+
+	if (free_list.next == &pernet->endp_list)
+		return 0;
+
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


