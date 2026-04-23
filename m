Return-Path: <netdev+bounces-280833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK1zCYpn6mkHzAIAu9opvQ
	(envelope-from <netdev+bounces-280833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:40:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E4E45625C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D0CE30080AE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5BE3B0AD6;
	Thu, 23 Apr 2026 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7Z29wgc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D6B3B0AC2
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969594; cv=none; b=bn5zqoyd6r6PlelKkEF3GFRh87rhUtT4vJCQhbfKjqBCzpjatl1Ke028CUHdLcTVlrXPENTeRr6tMyxSzDIwBrzlRiV5IdeIyN9nQd1H7FKHtbZ/HZhA3blOnzyM+F1ExDwbVdfsunggVyXpHRSJBckK/efJSANoEwhQGF3HELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969594; c=relaxed/simple;
	bh=1FwyqCGRN4HjLKuDH3bqgzzS/Yl5LPQZ4J52Uyty7T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMCoP3gt455CJeuVk9IqDoJ8VjAhyD+fuYjZ9UO3987WJ5U7zWDXOhEkI0irVrALed4XAQrhM+2amebz7o3cF7bxi8TE5otmtyPAAvjyMTUi0Vh132WeE1BhaEcjZomAnUwNyXubdplnWu1+FGz2YPYEw/8XMdjLKDmwO1Aoybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7Z29wgc; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c15849aa2cso9554249eec.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776969590; x=1777574390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kO91trHtfz2ojIIwhMZveBPj5V7DEEylyXcbXYUhb0Q=;
        b=m7Z29wgc84t+CwDGIixYpNbVk4gwneOLajfRR6mG5JmUoV+Zun8ZWL5H7MwwzjcpwA
         ttmf6G0DtpKSCJmy5DzGrJ3IQL/p3wdefX2MSu4jonD0kT+HIzjatYmTwyBELtv/l+Tp
         rOU9L/p3xc2wzVdDPKT1+ArS8qa9wB68zetBlanVkRtRQIxIQ/LKyHRjZPHTOE3cTxAb
         q0xEPQTHo2FEktndWSu1BzzyfNsUyU03ZHMrUebyRM4hRziMR++mAgjfM0V3J1xAkANN
         vqICepgN/oeL2RSA/3hJq1ZCxIuqgVTFBOTVzyzb8AuyCfLFCKrPeZNOwo/0MmzlLTGC
         rdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776969590; x=1777574390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kO91trHtfz2ojIIwhMZveBPj5V7DEEylyXcbXYUhb0Q=;
        b=RD5x7ZB5/Fe0M1DWlxszxrP/USYKwC+hiwlP3BizEiM36rMa2JuxCPIdPq5S3U1VRC
         QaMIdM+Iszy/2YFTo7trv3yzNbVQIqPICGbHy6RL4xG4UCh0xsAzACTHpfGvkEDZvuKe
         1rnYaFotceDkYgYXxwEckoZzXyL0QgYDUkik2wBz6Gwjx5HAL7QyHfMFfgvfbPonhfyi
         DU6Zi1kbNma6UlW0uQHjRRnrD2sI8haDsgjbR0nGMGHiUGZDSZsOv/jS7JXbbGR/oUB2
         KmvTqXpg4eJMPYuVt1t1CvdA0gFNmiS8tshYc7+dMHdSa0wNKV4lvL5t6fZaX5mFPzIR
         QDtw==
X-Forwarded-Encrypted: i=1; AFNElJ/q/ZHmaXGt3+7FpsdEzrWocQJbk9YAmzvKuI2HprXA+wI7RG7ToY1SrZDSoH457lqCft9ucrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZR6oBlZ8SF6nTPAjjWu9uSPaKycpRJZ94+c/d2d2/1l7Syxn
	2QbKsFCdO4IJBiBGPCTG5Ibl+PsshTUwd7lElwC4FyBj1LBBlz5QcP18
X-Gm-Gg: AeBDiet44I0qo9BAFE4/5wSfer04Rhjt//gZRjBBfJGd69ZulRCpLrqI6icIxna/839
	KGr1lBNz3UJa8OTYtwzoMcVQNg955MbqF5qUqadA9Ot0uu4IfbGoUWRqoAp9GYuaCEugM6GHAo3
	jHisEHtCwPp+JehFV1x5hTGnR60FQX9zAc3ZTm6y/uQrio1bw10/7Bj/syOaK707cQPDrGpTc/w
	AGhSSqApsDz3phh7I5PZuHbfd2XKR2j9ab1sabISFbvagbK+++wEUn+SBMYphsyns4QS20GJ0Vf
	S0s2AgMVgg7rpr3OsbV1tkmVCpinVkq0VAUwV+XPj8iEwMdXSq9WmKIGf51mg8RQ378jXGwrdkl
	9y5xdLWIxcCCPa6XM+xTjdBDchbXhtyXeIG77qvETvNKMo6jodz/pYu6GuZChnKTCi1JrmMcSdf
	RqY0F2yXQbVtu9hKIwySZXTLcjqs1H/gXLfJHhqy16QsA3EEfhGoKHx+Vxlqv1bG3vVzKLqJvXb
	zi1smiPHRs1Oi2VoUuJ
X-Received: by 2002:a05:7300:6413:b0:2da:a813:a60c with SMTP id 5a478bee46e88-2e4786462fdmr15387478eec.20.1776969590172;
        Thu, 23 Apr 2026 11:39:50 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53dcb487bsm29283790eec.31.2026.04.23.11.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:39:49 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH bpf v2] bpf: Fix NULL pointer dereference in bpf_skb_fib_lookup()
Date: Thu, 23 Apr 2026 11:38:32 -0700
Message-ID: <20260423183831.1325480-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org,asu.edu];
	TAGGED_FROM(0.00)[bounces-280833-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.622];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 27E4E45625C
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

When tot_len is not provided by the user, bpf_skb_fib_lookup()
resolves the FIB result's output device via dev_get_by_index_rcu()
to check skb forwardability and fill in mtu_result. The returned
pointer is dereferenced without a NULL check. If the device is
concurrently unregistered, dev_get_by_index_rcu() returns NULL and
is_skb_forwardable() crashes at dev->flags:

 KASAN: null-ptr-deref in range
  [0x00000000000000b0-0x00000000000000b7]
 Call Trace:
  is_skb_forwardable (include/linux/netdevice.h:4365)
  bpf_skb_fib_lookup (net/core/filter.c:6446)
  bpf_prog_test_run_skb (net/bpf/test_run.c)
  __sys_bpf (kernel/bpf/syscall.c)

Add the missing NULL check, returning -ENODEV to be consistent
with how bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() handle
the same condition.

Fixes: 4f74fede40df ("bpf: Add mtu checking to FIB forwarding helper")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Acked-by: Paul Chaignon <paul.chaignon@gmail.com>
---
v2:
  Fix Fixes tag: 4f74fede40df, not e1850ea9bd9e (Jiayuan Chen)
  Add unlikely() to match bpf_ipv{4,6}_fib_lookup() style (Paul Chaignon)

 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb0..5b4aa9faa707 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6450,6 +6450,8 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 		 * against MTU of FIB lookup resulting net_device
 		 */
 		dev = dev_get_by_index_rcu(net, params->ifindex);
+		if (unlikely(!dev))
+			return -ENODEV;
 		if (!is_skb_forwardable(dev, skb))
 			rc = BPF_FIB_LKUP_RET_FRAG_NEEDED;
 
-- 
2.43.0


