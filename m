Return-Path: <netdev+bounces-280273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFPJEnkA6GlJEAIAu9opvQ
	(envelope-from <netdev+bounces-280273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:55:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3739F440550
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAD7D30060AF
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B583A6B6B;
	Tue, 21 Apr 2026 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1rFC0W8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52932386C0C
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812147; cv=pass; b=N2SFRFhQU42+O4rqdgO4lMfzFB3FFIlNn/0GokIJ4a4hoD4Bz0NMNjWwmkXLq6A61aJRLlJA3PuE4rYy81Mzv2X490LGaOWfg112myt9DzurU07iIDKUBxftUBpVv1uAhCeN0r17EWUukcIHQj0wOUoZLOPrWszTvdoK3P7iIuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812147; c=relaxed/simple;
	bh=7g+6Nj4I9wlSgMa6eYN57nLSLjoKXWzdMIwO8KfWfA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSzEnI+hEnhu1xY34Vn4HYnFLu2HYpJHaEE5ouYKmD/yPU/WtxueiuO4JL4ym1jMO3KTMUA9n6dEHTBlBX7ny0hiQ9qi3uG3y21FhhiClPACiJRavHrSXB6+/3pUB0svci2WbReniyzvsy6NMz9hARyyy/HMzKH5A6mq7FyyL1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T1rFC0W8; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c1a170a50so5944467c88.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776812145; cv=none;
        d=google.com; s=arc-20240605;
        b=BP2ONHvSsE+7TBkwRZCDVKaICJnfwWlE6bSvboCe6FlTpIOkaNGui2qKbEKqnTbbL7
         tizR6ktFpN456KyewoNdJRpJG2KwhpLGdjMqRdFYD8dqU6eS3MIp2xYVc8UccDiCxLpm
         3AsI+x5ZjaFfvtEzl4cMKg8wAMVC/Y8MjCdMMjFoJFh7zCqtu3oTDGaRPQcBeXjkfFQD
         qAOE7jZ1JAYUCCMakfhABHhsJ/ljFydtRzNnf/AED9Tg0f4+FjVkgf47utqCpng49l7N
         Pr7POELc1VAKBbKhL+v868Wrt70T3L5/vqkmlSCOkcRRN5LxjSlt97Re1SnEoZERbi2X
         W+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7g+6Nj4I9wlSgMa6eYN57nLSLjoKXWzdMIwO8KfWfA0=;
        fh=L2Iaf/jDpg1GxFyjIbNnelz23/LTaZpTzC/mk8CwgOE=;
        b=TzuC/zUW11Ba+oOCH4EOAIy7755mblxULot9jCqgA3uG4p8HdaJhpyUKVevovcztYm
         /0beU18m7KcwXhHPKDCHmqS41X0Sc6c3iz+dHE6ZaJ1fPRH5PabCE6ndrHPsoj34+tT7
         0in9sm4RCOrkWGkc5KBX2WZ7mh0RQ3ltDCcfr55spNmgGgFsqLWz/BRzu0fJ02tP937y
         xEYrwseto5jSe6S4JUaMDzAjgXiJX47ttqDtt3OZ1L2vogX+kOV8AZZ7i49qUORHnUEY
         /pEjmSXiborpHv+veXF21fb/FMibWcRC6xh1NFG5YyM37eG610jIMh4hVJ0CU3mZ/xCt
         ZILA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776812145; x=1777416945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g+6Nj4I9wlSgMa6eYN57nLSLjoKXWzdMIwO8KfWfA0=;
        b=T1rFC0W8HJjEU5SYA02Yi58j2YaXzPiQfqL+81p8TaMFaUhTnYnp0fMRhmKsRdY4vW
         ROjCRNiuafgBnFCzoVCuvtgYyZHlGBuJyMB0OQWu73QxEBrHz0WqzkmD/uUgRjCpWLp3
         pfW9IBLsuNEqRRhUcJamdHgV/Ajncj2v8JVDqYQ1vAv2YC5Ui1LmgRpeuqE6w4O0p40+
         xXzSwMO3NaQQZ/tLGkzd3X51HGIAWIg1kjgI5VhsnNGOo6RxU6OFTxAo9TmG4JPmLSHF
         MEiVGFRbNRuBzxyOCM4s+2VlFVXE83XLAAIxgOh7pCrq1Slz6+MuBWHv8tumHp1WgWz7
         JXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812145; x=1777416945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7g+6Nj4I9wlSgMa6eYN57nLSLjoKXWzdMIwO8KfWfA0=;
        b=W7DsbSF1F/GWdTMfIW+eRddUScGRf/Hswd3mMtynGVXE/y02vCIKfK/Ac7npxDlPMa
         n9BXhLrOj7SE81y40HNxRWSCc4/m9d8rCxz1qd7hsN7YxnTnnKFueDumWUDzcwAvLRZ+
         fUw2NxPNKBKVK0rp5seEYRItIvmnFaRRt/+Z+JcinnrgNjtRotHFANJiFpdi8BSGkRQn
         FBIYD1uqt7YRLh2SQ+LdkiqiTxDRJGIk/FyqxIxcs4LWUjR1/pAOiSmvtznYSMZpW+zN
         MbY2UtXD+XJkjnytSARC3qSrtq14qPoU59wE0IgnWhgWL8WB/qLCKMwhTU3idOTfdxwa
         Gq1Q==
X-Gm-Message-State: AOJu0YxsEwNoqDvi+UpBYaRPJXVbIPeh8jDesAjnb/1ZX3TXtzPwG1PH
	rhhgmzqr5CD8+zpdVykAmchpw1IxjIhuXVB7QWKmz3exrPu982Y/Ggw3Rupo6XF4mq5I+AZ/bKk
	Aa33D0UzhIAGSa4DRSm0MP8ttF4utyjWaxEltgP+0
X-Gm-Gg: AeBDievkqYtOOrQ4Ttbyvetcz2UYp4o7IMDzOQzAvgwpbFNrXKDRfJ8TAaDDptli/Xe
	lV+mE5X1bs+WuM8FzAmravp7Y2IyKm5DefwaHYW0/WLciK7TMka66y/10W1/s23jphn0Yynphjs
	Hl318Zu0+Rrsae72IYCW8nZOumlf727KeqSYsZrXxdNq2bzJ0ONL+kmZSFp/8MH9yjq7kE7Rcv7
	Fowh7etRjpx2XwOjUZ9VCeeTV2pVQby/2UbA6RvW3UNUEK78jCK9G3LWYYZQw/aiRoidiwKjHnT
	DEgdV261zdXc9gBGv4V1m4b1oYTTrqZj1NP7zWbHsMgaWOqhWocm0vcijkqpYL6a47WFZUpHE3n
	82lPDgRQw9CTxTGls2f1WvQrvJDQbx+gxCNZxvNGeDjKIRbCLjB6HGBJBk8tHJoNxn96id8eESQ
	==
X-Received: by 2002:a05:7022:6627:b0:128:ca83:5aa1 with SMTP id
 a92af1059eb24-12c73f9217dmr11175890c88.16.1776812144868; Tue, 21 Apr 2026
 15:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421123106.142299-1-jt26wzz@gmail.com> <20260421123106.142299-2-jt26wzz@gmail.com>
In-Reply-To: <20260421123106.142299-2-jt26wzz@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 21 Apr 2026 15:55:33 -0700
X-Gm-Features: AQROBzD2b51gLvsY15bbLEJ6mf5qB0jtCSoEC5dNs0R6RYbWMCDYXu37HOUp92I
Message-ID: <CAAVpQUCW2rAdz47kYM-YN7Er2iKVReyZbFSCJXG04Cw-8y_VjA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] tcp: call sk_data_ready() after listener migration
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, tamird@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280273-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3739F440550
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 5:31=E2=80=AFAM Zhenzhong Wu <jt26wzz@gmail.com> wr=
ote:
>
> When inet_csk_listen_stop() migrates an established child socket from
> a closing listener to another socket in the same SO_REUSEPORT group,
> the target listener gets a new accept-queue entry via
> inet_csk_reqsk_queue_add(), but that path never notifies the target
> listener's waiters. A nonblocking accept() still works because it
> checks the queue directly, but poll()/epoll_wait() waiters and
> blocking accept() callers can also remain asleep indefinitely.
>
> Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
> in inet_csk_listen_stop().
>
> However, after inet_csk_reqsk_queue_add() succeeds, the ref acquired
> in reuseport_migrate_sock() is effectively transferred to
> nreq->rsk_listener. Another CPU can then dequeue nreq via accept()
> or listener shutdown, hit reqsk_put(), and drop that listener ref.
> Since listeners are SOCK_RCU_FREE, wrap the post-queue_add()
> dereferences of nsk in rcu_read_lock()/rcu_read_unlock(), which also
> covers the existing sock_net(nsk) access in that path.
>
> The reqsk_timer_handler() path does not need the same changes for two
> reasons: half-open requests become readable only after the final ACK,
> where tcp_child_process() already wakes the listener; and once nreq is
> visible via inet_ehash_insert(), the success path no longer touches
> nsk directly.
>
> Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets i=
n accept queues.")
> Cc: stable@vger.kernel.org
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

