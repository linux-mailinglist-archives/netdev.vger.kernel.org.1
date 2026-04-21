Return-Path: <netdev+bounces-280024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HyYFfIn52kf4wEAu9opvQ
	(envelope-from <netdev+bounces-280024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:32:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF414379D8
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE08A307EB60
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4871383C8C;
	Tue, 21 Apr 2026 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqpxbMFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935338736A
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756021; cv=none; b=jvc8iFZHKhbzzMZ5R8rn78VqhtZryi/oXeY1D/jF0DbGHSixI8IlTBaNjFIMHNd/9jBpRHJVrMKR+udgIqzlcV1MvL+ygxVJ7f1SuUeL8rxrhol55Q8rUJp2JGLpWZ6stNGE6EnBJvDGF12sJCbn2O3OG1ZBV9J5ttFyCvHfrfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756021; c=relaxed/simple;
	bh=VX4wqdc8fUaNqb2L3axrt9LF0e/WzvYh0gO2EeYHeUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofXgZj0qmf2s8HIiQLLUeW5mKdUVjtDkFCmzNvv4mid1RvtReTl//D9RBhjKo98YN6W68QIQuMDBb9OPWZPxJncy8Rxm8da9Rz3RnC04A9ta7g1kbYUCj5IBTryO/EKKR8p8iWb5BEqyeuCLgFUVRyqMuzUWhhXNyXha6CtHjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqpxbMFu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b458add85aso40502145ad.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776756019; x=1777360819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=91/4oaAqI5zoOb3jrCgPseC/dJYhauKi+DmlkoNw0/0=;
        b=CqpxbMFusqu8egkendRBAp8jsoXioQQUopk54BMKey2nWy60SHCCM/tXR/pFQVBV7w
         y+alrcihTtO7Iw2FBV8wBToLpOHq0BOuxPNGkcNsSt8G7XpaqLIeSdt+80ify+rfY9Sn
         9eyXLEIdqTmNBuk4xt4ScEA04EY+U6TH7sjoTKwwhAzDjiTte3uTHHIFkolD34QMQkrG
         qkKJk4yfz6QRtqdG68TuQGTZFeZfjzJ+CZ6qRzI7l/kjlSd+upk8AAxDIyK4aAUC3jYF
         2+zCltVgbYZepmJktBJpMtRwI+jx3jU2aDh0hiBgSI46U4IKo3aho2YFA+0UHxh+uDpD
         q+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756019; x=1777360819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91/4oaAqI5zoOb3jrCgPseC/dJYhauKi+DmlkoNw0/0=;
        b=kvjXB2dZ3s31oy1zEuUli69qPcu6RoYD23XSFQN4JdTr1sJJn7tniGeg40IV0KvDQr
         gbD/KPSl3v6aghelNlLMnCkSAdYG+iuI9TruRgso9g/nPEJKskk7UxDWuyVV0ffng4MX
         zP0ujwa7JE9H19pzviFdQ/C2VzXOapK351LvR/1LfN4qu6RKFB4p7QMlL36NKu/C+nBa
         /dARBvf40ArsAVeMX6morwf7I51Rz2h34gkkkjWWmyC2PGdrfdVF1B5DdmZTcUXg8Ot2
         3rFcX7WQxGu5OPFleelE5BP4vj81P32Sn2JzD8LqXk99+f9qOyXAjCQlsAadG4tZmwur
         pNsg==
X-Forwarded-Encrypted: i=1; AFNElJ9w8RHNY2PLPNr2TKU4hkF9t754dH/SSeSPAVoAcePED2RtHgtZH9orFYfmSq2Ve4kx46xOjn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55dr6wPcAbFBB46Oqw0GP3uHj1kqUcSOPbsdJaOvrdhb9qlaI
	EBLWeJ7uvBc4DzVYt6lMEKZxzCKR24IF5HeOirZqWIwUOmb7ijV69zHBgBgUXZgrLAR8QdmwwoO
	W+tlQJg==
X-Received: from plbx11.prod.google.com ([2002:a17:902:ea8b:b0:2b0:6314:419b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0d:b0:2b2:4fe3:7b89
 with SMTP id d9443c01a7336-2b5f9f52879mr163499125ad.38.1776756019292; Tue, 21
 Apr 2026 00:20:19 -0700 (PDT)
Date: Tue, 21 Apr 2026 07:15:09 +0000
In-Reply-To: <20260418181333.1713389-3-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260418181333.1713389-3-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260421072017.1653163-1-kuniyu@google.com>
Subject: Re: [PATCH net v2 2/2] selftests/bpf: check epoll readiness after
 reuseport migration
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jt26wzz@gmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, tamird@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-280024-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FF414379D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Sun, 19 Apr 2026 02:13:33 +0800
> After migrate_dance() moves established children to the target
> listener, add it to an epoll set and verify that epoll_wait(..., 0)
> reports it ready before accept().
> 
> This adds epoll coverage for the TCP_ESTABLISHED reuseport migration
> case in migrate_reuseport.
> 
> Keep the check limited to TCP_ESTABLISHED cases. TCP_SYN_RECV and
> TCP_NEW_SYN_RECV still depend on asynchronous handshake completion,
> so a zero-timeout epoll_wait() would race there.
> 
> Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> ---
>  .../bpf/prog_tests/migrate_reuseport.c        | 32 ++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> index 653b0a20f..580a53424 100644
> --- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> +++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> @@ -18,13 +18,16 @@
>   *   9. call shutdown() for the second server
>   *        and migrate the requests in the accept queue
>   *        to the last server socket.
> - *  10. call accept() for the last server socket.
> + *  10. for TCP_ESTABLISHED cases, call epoll_wait(..., 0)
> + *        for the last server socket.
> + *  11. call accept() for the last server socket.
>   *
>   * Author: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
>   */
>  
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
> +#include <sys/epoll.h>
>  
>  #include "test_progs.h"
>  #include "test_migrate_reuseport.skel.h"
> @@ -522,6 +525,33 @@ static void run_test(struct migrate_reuseport_test_case *test_case,
>  			goto close_clients;
>  	}
>  
> +	/* Only TCP_ESTABLISHED has already-migrated accept-queue entries
> +	 * here.  Later states still depend on follow-up handshake work.
> +	 */
> +	if (test_case->state == BPF_TCP_ESTABLISHED) {
> +		struct epoll_event ev = {
> +			.events = EPOLLIN,
> +		};
> +		int epfd;
> +		int nfds;
> +
> +		epfd = epoll_create1(EPOLL_CLOEXEC);
> +		if (!ASSERT_NEQ(epfd, -1, "epoll_create1"))
> +			goto close_clients;
> +
> +		ev.data.fd = test_case->servers[MIGRATED_TO];
> +		if (!ASSERT_OK(epoll_ctl(epfd, EPOLL_CTL_ADD,
> +					 test_case->servers[MIGRATED_TO], &ev),
> +			       "epoll_ctl"))
> +			goto close_epfd;
> +
> +		nfds = epoll_wait(epfd, &ev, 1, 0);
> +		ASSERT_EQ(nfds, 1, "epoll_wait");

Thanks for the update, but the test passes without patch 1.

I think it would be best to test just after shutdown()
where migration happens.

Also, TCP_SYN_RECV should be covered in the same way.

---8<---
diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
index 580a534249a7..66fea936649e 100644
--- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
@@ -353,8 +353,29 @@ static int update_maps(struct migrate_reuseport_test_case *test_case,
 
 static int migrate_dance(struct migrate_reuseport_test_case *test_case)
 {
+	struct epoll_event ev = {
+		.events = EPOLLIN,
+	};
+	int epoll, nfds;
 	int i, err;
 
+	if (test_case->state != BPF_TCP_NEW_SYN_RECV) {
+		epoll = epoll_create1(0);
+		if (!ASSERT_NEQ(epoll, -1, "epoll_create1"))
+			return -1;
+
+		ev.data.fd = test_case->servers[MIGRATED_TO];
+		if (!ASSERT_OK(epoll_ctl(epoll, EPOLL_CTL_ADD,
+					 test_case->servers[MIGRATED_TO], &ev),
+			       "epoll_ctl")) {
+			goto close_epoll;
+		}
+
+		nfds = epoll_wait(epoll, &ev, 1, 0);
+		if (!ASSERT_EQ(nfds, 0, "epoll_wait 1"))
+			goto close_epoll;
+	}
+
 	/* Migrate TCP_ESTABLISHED and TCP_SYN_RECV requests
 	 * to the last listener based on eBPF.
 	 */
@@ -368,6 +389,15 @@ static int migrate_dance(struct migrate_reuseport_test_case *test_case)
 	if (test_case->state == BPF_TCP_NEW_SYN_RECV)
 		return 0;
 
+	nfds = epoll_wait(epoll, &ev, 1, 0);
+	if (!ASSERT_EQ(nfds, 1, "epoll_wait 2")) {
+close_epoll:
+		close(epoll);
+		return -1;
+	}
+
+	close(epoll);
+
 	/* Note that we use the second listener instead of the
 	 * first one here.
 	 *
@@ -525,33 +555,6 @@ static void run_test(struct migrate_reuseport_test_case *test_case,
 			goto close_clients;
 	}
 
-	/* Only TCP_ESTABLISHED has already-migrated accept-queue entries
-	 * here.  Later states still depend on follow-up handshake work.
-	 */
-	if (test_case->state == BPF_TCP_ESTABLISHED) {
-		struct epoll_event ev = {
-			.events = EPOLLIN,
-		};
-		int epfd;
-		int nfds;
-
-		epfd = epoll_create1(EPOLL_CLOEXEC);
-		if (!ASSERT_NEQ(epfd, -1, "epoll_create1"))
-			goto close_clients;
-
-		ev.data.fd = test_case->servers[MIGRATED_TO];
-		if (!ASSERT_OK(epoll_ctl(epfd, EPOLL_CTL_ADD,
-					 test_case->servers[MIGRATED_TO], &ev),
-			       "epoll_ctl"))
-			goto close_epfd;
-
-		nfds = epoll_wait(epfd, &ev, 1, 0);
-		ASSERT_EQ(nfds, 1, "epoll_wait");
-
-close_epfd:
-		close(epfd);
-	}
-
 	count_requests(test_case, skel);
 
 close_clients:
---8<---

