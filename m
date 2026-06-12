Return-Path: <netdev+bounces-298760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tu0THBFJLGpTOwQAu9opvQ
	(envelope-from <netdev+bounces-298760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:59:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FEE67B7B8
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:59:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MCZQS9KX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298760-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298760-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94EA530B828C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BA836C592;
	Fri, 12 Jun 2026 17:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FF136CDE0
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:59:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287183; cv=none; b=rA7KDU+13iUn5DuTaX2rFG7uW5kJjRjj6DMN4VSqG0lHmXLCuw6SOq46GrgVu8XZQ2tF19fBj4TNdpckPFv+iTitIWTjJPcdSyJ1I+9upUhxw6mzlj2wCgN6V7/1pEyazJXM45qnvViqy6KUNLoS75N18G0Yh2pW5oJ1RYbJiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287183; c=relaxed/simple;
	bh=2+9NcgSGtZZ2MaseewhIpBSo/B4svYdZEuJXh+Blyb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVdMUjLGdUYAbNK+kRDi71Wpp4FjD8QVge/9nYZUaV42QkvxhmQ0jtGpgA25iKSG4XJDXONjdmXDv+tqlYj/C6BH2M1SlZTsKOYzmzJcozRApkCP2DGe9gxNwqKC3IBl66qG/XW0WbfJY3OrTBa5u7yNW9yOqbUIoeMZ7n5fV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCZQS9KX; arc=none smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ce3876a50cso12851546d6.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781287180; x=1781891980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxSL2JEpPbZJ1pXhfQ8UIwWu4ZameffAWeN2bTtYEeo=;
        b=MCZQS9KXx/IBN0t3AqYxKKMRw/YVry20PmpYHkDUvoTYm2zfV4D5jPQbBuV4D+s0qz
         MfW237Knifxed+nQj5C1ZpMkZ20Tmo/ziK0Deu/pySqe/15+G1GWB5gqnzISug3lQsed
         PWWldJnFQmDqsWjxwS/q6r4GNUpqIAlCKxcKhabF32wjTjMqGygWxBUfgLLOG4YGEJYx
         X74hHbOzvA8DDFjEK+voD7AiygPjMMhSwRKZwNDoIVa7tLilFbj+7Ku9y51tPHgnCCWO
         Ygbup1TILv59J7Vor4UEYeGczHMZzb3tWhrSBMSBg6AitkcynsHO49FrCAEHvQ0LxT25
         xkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287180; x=1781891980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxSL2JEpPbZJ1pXhfQ8UIwWu4ZameffAWeN2bTtYEeo=;
        b=f5wVBoM8OefRkwuFKAWUrcmP6iV/CrPMWn0uCIJKMJBUNvXuwlz/uZDVQcMm8va/z0
         c2cjkTuV1FoZWJs8b2zxZPnyzE5T2bPvQuzEJ58jNhlpS6ENPyUYRBBxUJAYjVlE9XBY
         41PejDl5kI9zRfUhTYHNm0yPKTOyXl5jGidt/dmeva9qxIT6bGUc6fp0FT0cnaeA3l1i
         2PVOjSW5H8DFpA8aFHPq2zcZ27bSYITGu3jRC8bUB4jdu3wWSFHR5UiJ1dUpxBxg3Ttj
         Cfcvow3QPWI0jhjVoiUTQuJRjiC+BxMEriANvQX6rEJdLqTKWcL5RZCHZQ/G36f7ps2M
         0l3w==
X-Gm-Message-State: AOJu0Yxc9HAtfYrGmd7NpBDG1siIxL1BfzhVAannciPhcD0ymaWUXgPz
	9exzwnAcCKV1A2Ws7/fMpxJf1Qoo+A3rm3UskegBNQrdpa5uWWvHnNm60DyMMtV+
X-Gm-Gg: Acq92OGwoQaax9z45f93Ej4OTI8zkaiq0M/AMsQvRnD2gQs8bnWExZuCdU6YX92c4rJ
	1N5oT1CscAC7t7ImQOc/IuPuS3SlK11Y/YMab7vdDae8e5UCIKrWFNsXSrpKJNVY1/NWnrAAtB1
	6V+ExVbHzhc++Wn6CzYr3mtt2OrAVizwI6vx8+7V2NmeHATXw2pSE96N1Bleilj9DTqB3JzMZcf
	lflI4G6Zbh5p/J0w1Usa0z+b7kX0zMf6bWgwj++cXDs6ibtpSeRacRUnEXXFG1dtLC9+gJNIqmT
	DWUr0RyQMDiWKe3Y0Puvn5V1UXlvIJFvEr1zWcwF6+y3ogzUloem36vLdqJs11KZIgZ+OTVAyuP
	/ZSaQBH1LNhEbxuJTzy1oO6cinAogMogM9ggjARfOFg/ne/tolEXJYZh6sD1lU7IIVNBV3ysW2P
	wcz1pp8cV1ftQGXHJJxXnNY5A3rCQy4B+9dQYVww35hMOl26VI6HCRHMA0W6kEgmYBA6pi5G0XR
	idm/dYMhgq2xz880mqeCpNtYBu11lIrOsqYSBZbZbwwoa8dkrK3e9wdaDb6BQc2nQ==
X-Received: by 2002:a05:620a:628e:b0:915:b852:435e with SMTP id af79cd13be357-917eedbfb4bmr111277485a.14.1781287179748;
        Fri, 12 Jun 2026 10:59:39 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a0541d3sm274646485a.39.2026.06.12.10.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:59:39 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Willy Tarreau <w@1wt.eu>,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
Subject: [PATCH net] sctp: hold socket lock when dumping endpoints in sctp_diag
Date: Fri, 12 Jun 2026 13:59:38 -0400
Message-ID: <1bbd999cf88fb1ea93f4a3743047bce9b51adc24.1781287178.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,1wt.eu,trendmicro.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298760-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:w@1wt.eu,m:zdi-disclosures@trendmicro.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,trendmicro.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0FEE67B7B8

SCTP_DIAG endpoint dumping currently walks the endpoint hash table
without taking the socket lock before calling inet_sctp_diag_fill().

This is problematic because inet_sctp_diag_fill() eventually calls
inet_diag_msg_sctpladdrs_fill(), which traverses the endpoint's local
address list twice: once to count entries for nla_reserve(), and once
again to copy the addresses into the netlink buffer.

Since these two traversals are protected only by separate RCU read-side
critical sections, concurrent socket operations such as
SCTP_SOCKOPT_BINDX_REM may remove entries from the address list between
them. In that case, the number of copied addresses becomes smaller than
the originally reserved buffer size, leaving part of the netlink payload
uninitialized and potentially leaking kernel memory to user space.

Fix this by changing sctp_for_each_endpoint() to iterate with net and
position awareness while taking a reference on each socket, then release
the endpoint hash bucket read_lock_bh() before invoking the callback.

A socket reference is required because the callback acquires lock_sock(),
which must be called outside of read_lock_bh() since lock_sock() may
sleep. Holding a socket reference ensures the socket remains valid after
dropping the bucket lock and before acquiring the socket lock.

With the socket lock held, concurrent bind-address modifications are
serialized against the diagnostic dump, ensuring the local address list
remains stable during buffer sizing and initialization.

This also simplifies endpoint traversal by removing the temporary
callback local position tracking args[4] and moving dump progress
tracking into sctp_for_each_endpoint() itself.

While at it, fix the idiag_states check in sctp_ep_dump() and skip ep
dumping when non LISTEN|CLOSE states are also requested and the ep has
assocs, since such cases will be handled later by sctp_sock_dump().

Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 include/net/sctp/sctp.h |  3 +-
 net/sctp/diag.c         | 62 +++++++++++++++++++----------------------
 net/sctp/socket.c       | 34 +++++++++++++++++-----
 3 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 58242b37b47a..cd82b05354a3 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -111,7 +111,8 @@ int sctp_transport_lookup_process(sctp_callback_t cb, struct net *net,
 				  const union sctp_addr *paddr, void *p, int dif);
 int sctp_transport_traverse_process(sctp_callback_t cb, sctp_callback_t cb_done,
 				    struct net *net, int *pos, void *p);
-int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *), void *p);
+int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
+			   struct net *net, int *pos, void *p);
 int sctp_get_sctp_info(struct sock *sk, struct sctp_association *asoc,
 		       struct sctp_info *info);
 
diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index d758f5c3e06e..9108272ca527 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -92,6 +92,7 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
 		if (!--addrcnt)
 			break;
 	}
+	WARN_ON_ONCE(addrcnt);
 	rcu_read_unlock();
 
 	return 0;
@@ -373,42 +374,36 @@ static int sctp_ep_dump(struct sctp_endpoint *ep, void *p)
 	struct sk_buff *skb = commp->skb;
 	struct netlink_callback *cb = commp->cb;
 	const struct inet_diag_req_v2 *r = commp->r;
-	struct net *net = sock_net(skb->sk);
 	struct inet_sock *inet = inet_sk(sk);
 	int err = 0;
 
-	if (!net_eq(sock_net(sk), net))
+	lock_sock(sk);
+	if (sctp_sstate(sk, CLOSED))
 		goto out;
 
-	if (cb->args[4] < cb->args[1])
-		goto next;
-
-	if (!(r->idiag_states & TCPF_LISTEN) && !list_empty(&ep->asocs))
-		goto next;
+	if ((r->idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)) &&
+	    !list_empty(&ep->asocs))
+		goto out;
 
 	if (r->sdiag_family != AF_UNSPEC &&
 	    sk->sk_family != r->sdiag_family)
-		goto next;
+		goto out;
 
 	if (r->id.idiag_sport != inet->inet_sport &&
 	    r->id.idiag_sport)
-		goto next;
+		goto out;
 
 	if (r->id.idiag_dport != inet->inet_dport &&
 	    r->id.idiag_dport)
-		goto next;
-
-	if (inet_sctp_diag_fill(sk, NULL, skb, r,
-				sk_user_ns(NETLINK_CB(cb->skb).sk),
-				NETLINK_CB(cb->skb).portid,
-				cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				cb->nlh, commp->net_admin) < 0) {
-		err = 2;
 		goto out;
-	}
-next:
-	cb->args[4]++;
+
+	err = inet_sctp_diag_fill(sk, NULL, skb, r,
+				  sk_user_ns(NETLINK_CB(cb->skb).sk),
+				  NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
+				  cb->nlh, commp->net_admin);
 out:
+	release_sock(sk);
 	return err;
 }
 
@@ -479,41 +474,40 @@ static void sctp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		.r = r,
 		.net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN),
 	};
-	int pos = cb->args[2];
+	int pos;
 
 	/* eps hashtable dumps
 	 * args:
 	 * 0 : if it will traversal listen sock
 	 * 1 : to record the sock pos of this time's traversal
-	 * 4 : to work as a temporary variable to traversal list
 	 */
 	if (cb->args[0] == 0) {
-		if (!(idiag_states & TCPF_LISTEN))
-			goto skip;
-		if (sctp_for_each_endpoint(sctp_ep_dump, &commp))
-			goto done;
-skip:
+		if (idiag_states & TCPF_LISTEN) {
+			pos = cb->args[1];
+			if (sctp_for_each_endpoint(sctp_ep_dump, net, &pos,
+						   &commp)) {
+				cb->args[1] = pos;
+				return;
+			}
+		}
 		cb->args[0] = 1;
 		cb->args[1] = 0;
-		cb->args[4] = 0;
 	}
 
+	if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
+		return;
+
 	/* asocs by transport hashtable dump
 	 * args:
 	 * 1 : to record the assoc pos of this time's traversal
 	 * 2 : to record the transport pos of this time's traversal
 	 * 3 : to mark if we have dumped the ep info of the current asoc
 	 * 4 : to work as a temporary variable to traversal list
-	 * 5 : to save the sk we get from travelsing the tsp list.
 	 */
-	if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
-		goto done;
-
+	pos = cb->args[2];
 	sctp_transport_traverse_process(sctp_sock_filter, sctp_sock_dump,
 					net, &pos, &commp);
 	cb->args[2] = pos;
-
-done:
 	cb->args[1] = cb->args[4];
 	cb->args[4] = 0;
 }
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 66e12fb0c646..1ed405dedc01 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5369,24 +5369,44 @@ struct sctp_transport *sctp_transport_get_idx(struct net *net,
 }
 
 int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
-			   void *p) {
-	int err = 0;
-	int hash = 0;
-	struct sctp_endpoint *ep;
+			   struct net *net, int *pos, void *p) {
+	int err, hash = 0, idx = 0, start;
 	struct sctp_hashbucket *head;
+	struct sctp_endpoint *ep;
+	struct sock *sk;
 
 	for (head = sctp_ep_hashtable; hash < sctp_ep_hashsize;
 	     hash++, head++) {
+		start = idx;
+again:
+		sk = NULL;
 		read_lock_bh(&head->lock);
 		sctp_for_each_hentry(ep, &head->chain) {
-			err = cb(ep, p);
-			if (err)
+			if (sock_net(ep->base.sk) != net)
+				continue;
+			if (idx++ >= *pos) {
+				sk = ep->base.sk;
+				sock_hold(sk);
 				break;
+			}
 		}
 		read_unlock_bh(&head->lock);
+
+		if (sk) {
+			err = cb(ep, p);
+			if (err) {
+				sock_put(sk);
+				return err;
+			}
+			sock_put(sk);
+			(*pos)++;
+
+			idx = start;
+			goto again;
+		}
 	}
 
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(sctp_for_each_endpoint);
 
-- 
2.47.1


