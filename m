Return-Path: <netdev+bounces-265841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFqWEGJzr2lPZgIAu9opvQ
	(envelope-from <netdev+bounces-265841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:26:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEB6243913
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B9A53010713
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8F12BF3E2;
	Tue, 10 Mar 2026 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQBZk145"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D129BD9A
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106011; cv=none; b=cUUwTsRf6URBLYvQr5e41jT9MZ0tWxVwFZJ/KFcIXXJIz5QRjiFO99oIdEF63j6+m/RJlQB/2VCGT87d4DIix+qzwv873xEcjNCbbBC3wSwxPo+D0S+6TwyzK5t6w68C18/ySbCe3T5pqqJCjiNUKa/9TCa2C2o692ITuLxumvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106011; c=relaxed/simple;
	bh=i/CfK21xcP2Dl86/EdnOmx6/a4l8tDz5u5jRT4QD5gg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nEjJ28bb3f8IwCp2dEmp+TJjrEp89mUf2YZc5iFTWbVA70NpSw7m2eAMxihHBbcZyIXUGVAkjlZc21pFQ/E9bibjQJtRHMi3zUrPpir05t/zwIh/x3H/ROts3FPdRfO8yovHT3XLUOx8MZmehdolOZL2Z4yyPxh2/sUDJ7d7TPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQBZk145; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d75d698ee6so71279a34.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 18:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773106008; x=1773710808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kIoAs5tKx7jwvMk/e5P+rCsogpkNXx41D3oZZZC2J4s=;
        b=AQBZk1458nLi8cp5pK4FuRKMUZBPNd8dHXstUVQV55BSHiaQsfmoTtkWNxM0osAASx
         f4AvFLNte7fGZb5oO8Lgs1SGAA+7fvGyabOEVm//0xWKPw1rMVAcjh5kzkfY9GdDYfYb
         SKymcZpyKPhLIo30HKEuvkgMkGgj3IylgkdWebWo7WHgmJm+iy3YxVc8LfO5z1B/zoxq
         Q2OiK6efG9rKXe8JdYd/NEdm/6UouU4ONl+tWI/PyqVUDdI/ka95rfBUfDvVl7IVkYkB
         CeAS//6O8ObAzu0GFQGe8Dx6zYOWZt8JmnB1wYUUrdKlwr2sft/4whFOOhsUBLj2NPXU
         CLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773106008; x=1773710808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIoAs5tKx7jwvMk/e5P+rCsogpkNXx41D3oZZZC2J4s=;
        b=E1sa+z0DF/oSaZqbqjKnnz0MXYvN/BIljVywK3Ed6207Gz40LNkYx3ZrU5sDBz41ND
         Zb2U7SpkbQdNEF7DWW/4jg/VmDeHLi5rxz898GYnB0jqIyQ8qe6idn9n2D2PpjhT3u5q
         Hh+TQv8+fxqnItc03s8a2PkVZwaE+A5YPfLKfA3dZBh8bAJwva++Z293vYBoNJXm7cdo
         myiAmwHxtjQ9s0k0AoTwR+A8lyFrelQkbUW3hNcYBPL1j0gABLLQM8X61Va7JmC9Cs5g
         vUfykcJg4bVj0dFej79HcQ2fgmJky5m6v2FcHTlP4v/kP0FtmnMvKtsRD3+QXfFSbGhk
         ZQOw==
X-Forwarded-Encrypted: i=1; AJvYcCVMRl5hWiHwMEF4tuam+uGT6oyA0fb28lNJAL04abbjhnRM7oZ8+KrJVkssNyH/MacC2DNdVrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+IIgPVqXW4LDC3jHEmkX/kZyOULXjf2LPYXoCkTUGxTd9Mmor
	V1oUYxbZzHz4yAZmFzeThh3O5iu3oWjj5aT0s5XqeFLN9ajsW0A7I8n4
X-Gm-Gg: ATEYQzwxWiSPuGhoTyUJ8KNtpV81wBPnJQeFrKM5AcxfZ1WmLrEhhgpeojonAOWlE0A
	jWNYXOvpwCdp9A9pZ5vIJgZk1CGWCHxR3MR7/wBIA07seeYtz069fcpNnsPoUY2pB/Q7invjuXM
	ySvXKuswdo7h/LC5UH2Rvp1UAqOf2dmoVyv3Kl0pUa406oOkFwWLTPpgbM2bU/hyMnyYOi8IW5M
	Yaz7JfHWmJkqBQAbyaNBL52flRP8YpxvD3FnGKR8hMf2fXIWT5RJFrnkuUA3UEMPLq0UgRMxZP2
	lbv6R/Ob3525Nbb+AVL67CEtybGLDWwtLilQx1ex1fChzPvOBy0dGwz0WfLeisCu0Fpev6MZcR9
	u7pA+RSmMAeJxkx3AG+GEFrsAOQfnH71MZ0SubJC/BXsY0ozkZuI8eLWvO7T+Cn1nD1pb9tdS14
	e/z7ei47KdDXo63xMEy5TvRk5BcsPYeCkcSBAT5jK0WwmO1Emm4vEh10+/IgmpPXfzHUUAeBM9L
	O23efw2bjPrcHvtAv81StGsR9LoiOv9khUJbCYaakkL6qu3
X-Received: by 2002:a05:6830:11d5:b0:7d7:39a9:4c1f with SMTP id 46e09a7af769-7d739a94d4emr4025551a34.28.1773106008565;
        Mon, 09 Mar 2026 18:26:48 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7449b9e57sm3928395a34.22.2026.03.09.18.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 18:26:48 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH] tcp: use WRITE_ONCE() for tsoffset in tcp_v6_connect()
Date: Mon,  9 Mar 2026 19:26:04 -0600
Message-Id: <20260310012604.145661-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4BEB6243913
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-265841-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Commit dd23c9f1e8d5 ("tcp: annotate data-races around tp->tsoffset")
updated do_tcp_getsockopt() to read tp->tsoffset with READ_ONCE()
for TCP_TIMESTAMP because another CPU may change it concurrently.

tcp_v6_connect() still stores tp->tsoffset with a plain write. That
store runs under lock_sock() via inet_stream_connect(), but the socket
lock does not serialize a concurrent getsockopt(TCP_TIMESTAMP) from
another task sharing the socket.

Use WRITE_ONCE() for the tcp_v6_connect() store so the connect-time
writer matches the lockless TCP_TIMESTAMP reader. This also makes the
IPv6 path consistent with tcp_v4_connect().

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/ipv6/tcp_ipv6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index bb09d5ccf599..ba7cd7d3d4da 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -325,7 +325,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 						 inet->inet_dport);
 		if (!tp->write_seq)
 			WRITE_ONCE(tp->write_seq, st.seq);
-		tp->tsoffset = st.ts_off;
+		WRITE_ONCE(tp->tsoffset, st.ts_off);
 	}
 
 	if (tcp_fastopen_defer_connect(sk, &err))
-- 
2.34.1


