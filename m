Return-Path: <netdev+bounces-307299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ex9zL5V1VWrsogAAu9opvQ
	(envelope-from <netdev+bounces-307299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 01:32:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A32C74FBC4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 01:32:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=FH5Wd08z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307299-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307299-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C931630071F8
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9363B8BDB;
	Mon, 13 Jul 2026 23:32:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDAC38947F
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 23:32:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783985554; cv=none; b=LAm0wAG0m8HkrNaIC6M4oqOw57u9PRqmV/lYfJgoQgVsU2ufxCpIuP6yb77+uh+bxCl8QZxYjkTS3Sr4Xwir0QMPRnqqLMZnv9ChmR23X/z3f3tRGskzu/pNrOwLMCrhQhHydQpSxtSi6u/vDSskPitKUuCwNGhSpYLTxd4Ph9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783985554; c=relaxed/simple;
	bh=I8cVX0/mSzLFIdIg9RF+8d27raSzMYxFSQj1EqVpbcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTKyymRtPueZ2KUWVlVuYc8mAdDFvQhMy/WNF+HYCBnbg/2tCL0bJMI7IKemDGD7gfXqidCh3fKGpyebp0vUx4fEkozNu3yViHYcCH44QCxYW/5ldtNUPnD9c773Zmui+GuiZCAD28wQLjpzi+pVZxc1IPBMpOgcWf6rVljoDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=FH5Wd08z; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so3517690a91.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 16:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783985553; x=1784590353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qnqTky8wONGeiH1Gjpg0s2khivj3YtWdqTGDCWAoFvc=;
        b=FH5Wd08zO5yTrpsQlVjNAP2cU0nZJ7T2Brms80ecwbjWAhau+qKsDrWrcwyerI3sSB
         lp9fv932Z8xCOwKr+69IxAtHChcEw1O+1XXUVMYLVE3Jwo1+6oIGobP1zxNB+8UmNSIK
         wEUh60zXXY1N3jtqlX12CJL8E3LPvQGp1QL4uWIMUVbxGvy2Vv7yNRog/4o5kQLy1x6i
         2POgAgbXxE9/KABUybmpp4YOmjzm8smRz32i+q+UHY3IUmXJf9bvuZEbTsWqmlQQCYqa
         XbNta21lW8mKHG6X3aBWsttFU9WoANsjcH/zaGcd9O+T3TSD2IXrhd4yAoDeOsUfnhtN
         GL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783985553; x=1784590353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qnqTky8wONGeiH1Gjpg0s2khivj3YtWdqTGDCWAoFvc=;
        b=gsBfZt/iT55e9WnclZd6IZxuvt63SCXNPIIvjroP1nDDZsbcodTBjDv8IpCeFvzUL9
         li64PfrjxBFyHSe/G564Ub3lOVU+aZve2YArDb+5tWMX03ymtFIjdjujxgKB/j6nXA5N
         wU556jJIDYy0wrCB8qNsXTOV3ZWR/kcgnyJcLlulqSreoJclOg+2QFmFrKV63Xdvyylg
         twzxYAINRoJKt99pKW9/SStRn/c9ejdssN2LOlq3uI7QEgRzQfrarQWLKjC/EiulQYli
         HKkf+r6AjR1napnIqD5C0VOtOPoRAeNwl/UCNPH/icG5eBluHjm/umThKiKWiIl9aT80
         4FvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDjtm+Qnx9KWF/DtOiN0FHAztfATe8DmLl40QpT4ZF6CvLHSsJscahfQiZCMnSezVZBc227CI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4zHql3xac7X0wuYGZhjJ9WrBcqWnJvpAYrCg+C2nAAsbl5zT
	O3MWQbFbdWxasq2Fl166ZIPaJYDC44L6DpQcMJPJLnWYO2blVZG5Ja9LkxIAHC5UXA==
X-Gm-Gg: AfdE7ckMQpfviTREd3y6ilpd2UAUdqCjHPAix783Dw/zdAaTZf9mwE3GRbqC2LXFHdA
	996vrOdMA/N1nYG6SDqKVYSFkPZTf5hRszFG5jgGiaXCVM5Hs9AR9c0dSjdITeVUzVF3LSot3tl
	KHji1OGDWeZvq4MCgkcdTjVgmalCmHbhvqAMdtUtacKLLt04f2KwlKCSfepwWUZedQUCaba1jeS
	H/IbRY7M0uHSkmpCRhZui5QXPrkXynPBI5du+sA5h6NXXDNpNJTcx04Ok9I+nhO/R8YZigJrFrM
	ZFFUlfsUIUKE7ORHpIxHxfRPFYTaJxQS5iJUQ26nHuNMTnfL6XFK73eaPnMwQgikQsey81+vUYq
	O0j+4l1cWpisXt5MVCrIr8rbwwRI0y8VLR+XZ85BHPQs53JE9p3lc9IFaJvB4pyOZFUev2TimOK
	xLHoYNURq3dUoXBCX/DA==
X-Received: by 2002:a17:90a:ec8d:b0:380:9d0d:7ade with SMTP id 98e67ed59e1d1-38e17c7f921mr894108a91.0.1783985552902;
        Mon, 13 Jul 2026 16:32:32 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311b00048a3sm44507367eec.5.2026.07.13.16.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 16:32:32 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] bpf: tcp: fix double sock release on batch realloc
Date: Mon, 13 Jul 2026 23:32:30 +0000
Message-ID: <20260713233230.3553593-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307299-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:jordan@jrife.io,m:martin.lau@kernel.org,m:sdf@fomichev.me,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:from_mime,asu.edu:mid,asu.edu:email,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A32C74FBC4

bpf_iter_tcp_batch() releases the current batch via
bpf_iter_tcp_put_batch(), which drops the socket refs and rewrites
each slot with the socket cookie, then grows the batch. cur_sk/end_sk
are kept for bpf_iter_tcp_resume(), but on realloc failure the function
returns ERR_PTR() before resume runs, leaving cur_sk < end_sk over
slots that now hold cookies rather than sock pointers.
bpf_iter_tcp_seq_stop() then calls bpf_iter_tcp_put_batch() again and
dereferences a cookie as a struct sock.

Empty the batch on the failure path so stop() does not release it
again. The sockets were already freed by the first
bpf_iter_tcp_put_batch(), so nothing leaks, and a later read() rescans
the bucket from the start instead of skipping it. The sibling
GFP_NOWAIT failure path still holds real socket references and is left
for stop() to release.

  BUG: KASAN: null-ptr-deref in __sock_gen_cookie
  Read of size 8 at addr 0000000000000059 by task exploit
   ...
   __sock_gen_cookie (net/core/sock_diag.c:28)
   bpf_iter_tcp_put_batch (net/ipv4/tcp_ipv4.c:2918)
   bpf_iter_tcp_seq_stop (net/ipv4/tcp_ipv4.c:3270)
   bpf_seq_read (kernel/bpf/bpf_iter.c:205)
   vfs_read (fs/read_write.c:572)
   ksys_read (fs/read_write.c:716)
   do_syscall_64
   entry_SYSCALL_64_after_hwframe
  Kernel panic - not syncing: Fatal exception

Fixes: cdec67a489d4 ("bpf: tcp: Make sure iter->batch always contains a full bucket snapshot")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/ipv4/tcp_ipv4.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 209ef7522508..dd3ed62704f9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3141,8 +3141,11 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	bpf_iter_tcp_put_batch(iter);
 	err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
 					 GFP_USER);
-	if (err)
+	if (err) {
+		iter->cur_sk = 0;
+		iter->end_sk = 0;
 		return ERR_PTR(err);
+	}
 
 	sk = bpf_iter_tcp_resume(seq);
 	if (!sk)
-- 
2.43.0


