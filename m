Return-Path: <netdev+bounces-170966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71485A4ADC6
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 21:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BB3170630
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC01E9B0F;
	Sat,  1 Mar 2025 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APKo3r/n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868851E9919
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740860076; cv=none; b=TuD54UUTHBuaoC20ug0Qsbt6cCkZDBj319cgAlsIQK8IwE9c4pgLxA3ZVwUXZwU18Lxl4rghdTuHrNVYKiU/46KddT11tmCGy8QKiH3pSklaFY/4IRk12NL8WyX/xPHqk4fM7jvQKfERoPTQpGj++1+Vwh5WFIjMWSl68HQC+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740860076; c=relaxed/simple;
	bh=7cS9lozPjGK6CJDB0rbF/JsDu7ljNWKuNdAb8/+05tc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLCmnP2LesQpVm+jJHgIzStwyrfv4b+UDPG+hH+pYTNslOjIyJlGGi0BWF7NhRz3PXLtEb67uty3AdTZ9xebALD1N1DSEyqlJxhhrzrtZ0oMB3lfvbB0kixPWJSRdJlVHBNFxD61LDPrCevfhG5ra/zD+KFVm69BdZvHs9fm7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=APKo3r/n; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-474bb848a7dso31264581cf.2
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 12:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740860073; x=1741464873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OOQFszIdy08TjK2quwg21U1oq4H1pENWDe9muSGOA0Q=;
        b=APKo3r/niw5Pc1DGAgmlru79ILxyIXLnyAcfMwedOWo3K72yvV79eYwWhZBTgtPrFP
         q1Vh8RYcIUiU5xqhxkMQodguOoTMn8RlnW4Ps4o8OD+PXqCMUirBL44YUCY0oJBIc5y/
         C9lYjNppsiPF1LTGsAeXnSmT24SJ7MH1BO176GBhyF4OBBNNeLNcnVbuuLACBAtzP7sG
         +2rMj/4mGflkel2Zj2SSdHjGD8qlE8ZczZ3pxfQhrIAA9R/VlJXXAdqFHtpJ27MYFa89
         YoRJnzdZBVN8VG5l1al29Rz5LUa7zxj3c/tRcEvIi0wMoMDcLSfQ5tDLwB+Vr1YtzeeK
         bsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740860073; x=1741464873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOQFszIdy08TjK2quwg21U1oq4H1pENWDe9muSGOA0Q=;
        b=n5Lso3akzwWh8gtjO3QffvU2I3W6CcAXXuYSTidYUq8YWICZGHaYvMLMUyfGATKdNo
         eEbsMejKqpDZCB8Jv4hf1YsQzJZGVCaDstzta3CL8TxzeX6O2IoqqkUkdHy1Zt2SA8Kv
         9mpeQWsHD4W9WfI3PfeuDykDCgqoJ01we8O0Zarp/m/EO0qL7qLKSLITnHhiH7liX3sf
         HeIW+f3Q38Bio/pjYm/pzGBBDmPpmTSyuHqQcc0mTTQWxrWiknFGUF5gqkcgdzyWCkxb
         Y/YVoAOFFyQuJAEA6xmpHtVPlUc8FDBphIqOu7XtM1Vp0L6gcMezlTtEsyu0ub7EEpNM
         3psQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs7EIlEMhK8FgRg27i6kGainxFSvKm+UCwdghwbBneFEIrzVKGFQDlhRkAPBLS3IbDjJADspc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/NHVZ2PmeW6RuQ7EOdMqq3DnnZYYHjq8NxgZyhj2w1dgSXGXW
	zRrmJLgWf3Fqmlsxhp9zQmXhfX4YMvBprY5MNa/c1gwDDcd0WJWbfqhphTeK/Qg8bJiHJp4qusp
	c07aKFuSKxw==
X-Google-Smtp-Source: AGHT+IGHvWH8RAS04QJKH7uyftTIwgEbKtMLkkxJHt3dTP0m/GS+sHIp/WmC/tXyHh0MYH1LiIv+ragXUueq9w==
X-Received: from qtbfg15.prod.google.com ([2002:a05:622a:580f:b0:471:f334:1108])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1108:b0:472:1e5:d577 with SMTP id d75a77b69052e-474bc10d546mr127083941cf.49.1740860073471;
 Sat, 01 Mar 2025 12:14:33 -0800 (PST)
Date: Sat,  1 Mar 2025 20:14:23 +0000
In-Reply-To: <20250301201424.2046477-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250301201424.2046477-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250301201424.2046477-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/6] tcp: remove READ_ONCE(req->ts_recent)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Wang Hai <wanghai38@huawei.com>
Content-Type: text/plain; charset="UTF-8"

After commit 8d52da23b6c6 ("tcp: Defer ts_recent changes
until req is owned"), req->ts_recent is not changed anymore.

It is set once in tcp_openreq_init(), bpf_sk_assign_tcp_reqsk()
or cookie_tcp_reqsk_alloc() before the req can be seen by other
cpus/threads.

This completes the revert of eba20811f326 ("tcp: annotate
data-races around tcp_rsk(req)->ts_recent").

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Wang Hai <wanghai38@huawei.com>
---
 net/ipv4/tcp_ipv4.c      | 2 +-
 net/ipv4/tcp_minisocks.c | 4 ++--
 net/ipv4/tcp_output.c    | 2 +-
 net/ipv6/tcp_ipv6.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ae07613e4f335063723f49d7fd70a240412922ef..d9405b012dff079f7cafd9d422ff4445a27eb064 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1155,7 +1155,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			tcp_synack_window(req) >> inet_rsk(req)->rcv_wscale,
 			tcp_rsk_tsval(tcp_rsk(req)),
-			READ_ONCE(req->ts_recent),
+			req->ts_recent,
 			0, &key,
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			ip_hdr(skb)->tos,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ba4a5d7f251d8ed093b38155d9b1a9f50bfcfe32..3cb8f281186b205e2b03d1b78e1750a024b94f6a 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -585,7 +585,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	if (newtp->rx_opt.tstamp_ok) {
 		newtp->tcp_usec_ts = treq->req_usec_ts;
-		newtp->rx_opt.ts_recent = READ_ONCE(req->ts_recent);
+		newtp->rx_opt.ts_recent = req->ts_recent;
 		newtp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 		newtp->tcp_header_len = sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
 	} else {
@@ -673,7 +673,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
 		if (tmp_opt.saw_tstamp) {
-			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
+			tmp_opt.ts_recent = req->ts_recent;
 			if (tmp_opt.rcv_tsecr) {
 				if (inet_rsk(req)->tstamp_ok && !fastopen)
 					tsecr_reject = !between(tmp_opt.rcv_tsecr,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0a660075add5bea05a61b4fe2d9d334a89d956a7..24e56bf96747253c1a508ddfe27ebd38da7c219e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -949,7 +949,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 			tcp_rsk(req)->snt_tsval_first = opts->tsval;
 		}
 		WRITE_ONCE(tcp_rsk(req)->snt_tsval_last, opts->tsval);
-		opts->tsecr = READ_ONCE(req->ts_recent);
+		opts->tsecr = req->ts_recent;
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
 	if (likely(ireq->sack_ok)) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index fe75ad8e606cbca77d69326dc00273e7b214edee..85c4820bfe1588e4553784129d13408dea70763a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1279,7 +1279,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			tcp_synack_window(req) >> inet_rsk(req)->rcv_wscale,
 			tcp_rsk_tsval(tcp_rsk(req)),
-			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
+			req->ts_recent, sk->sk_bound_dev_if,
 			&key, ipv6_get_dsfield(ipv6_hdr(skb)), 0,
 			READ_ONCE(sk->sk_priority),
 			READ_ONCE(tcp_rsk(req)->txhash));
-- 
2.48.1.711.g2feabab25a-goog


