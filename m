Return-Path: <netdev+bounces-100697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1068FB9A4
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64582284881
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B812149007;
	Tue,  4 Jun 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C3B7D6qP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A2149001
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520195; cv=none; b=HYo3SK2iUd/hy9EX0ngWbvInREXmDcwO2IgEYEFTYfMltCshPy1ab/fAlWdgawUGWnkc5CzJqj2tIWYXfB0tsYcUJPj/dv1Sn4doHkhFhBQCeDPrjaHo5YdDDvu0BizkNNluoMGKrasy2nDC6wGgEHQJC8/FiwJTtgIRLPrNCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520195; c=relaxed/simple;
	bh=U+8ANBox0sRimElgtxl6vuFJA8j7eCblQF3rUBq3dmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffsEZb54kYNIcwCF+198z9BPTsix6anj2zpBmRoFw372i0Z8uQ4qroYvd7EIEAEfh6SZFKUgHf1aRuIr82V2i/6oeTwuLXrc1aUMfra2igEECQjAp/8T7Zu8FZR36Im0IFwW0odlGfhauYrj0wl+lEEskgwZdRjJpJUxQRulGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=C3B7D6qP; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717520194; x=1749056194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sLVAZkUkeBChsczsFIfI9rbvAU+zutWF63NrlP8Rdu0=;
  b=C3B7D6qP0XkGaSzQc9llwSsFva1zK/S4O8GG3aKpHXXTn/hVKDkDx2EF
   XXURAJ69WJ6vp+1m+NjLYOJCbk3LtUNLQcUGJEl8DCytGb+6ExbVEStW0
   Xca8IXbfCeM+v6HtxA0we3rp7TQ8U1zY1Ic52llnG4whzrXf5S9bCI3zK
   A=;
X-IronPort-AV: E=Sophos;i="6.08,214,1712620800"; 
   d="scan'208";a="423764520"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:56:33 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:51317]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.111:2525] with esmtp (Farcaster)
 id a8d99cc5-0610-4e43-953e-e4a393a75938; Tue, 4 Jun 2024 16:56:32 +0000 (UTC)
X-Farcaster-Flow-ID: a8d99cc5-0610-4e43-953e-e4a393a75938
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Jun 2024 16:56:31 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 16:56:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 09/15] af_unix: Annotate data-races around sk->sk_state in UNIX_DIAG.
Date: Tue, 4 Jun 2024 09:52:35 -0700
Message-ID: <20240604165241.44758-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604165241.44758-1-kuniyu@amazon.com>
References: <20240604165241.44758-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

While dumping AF_UNIX sockets via UNIX_DIAG, sk->sk_state is read
locklessly.

Let's use READ_ONCE() there.

Note that the result could be inconsistent if the socket is dumped
during the state change.  This is common for other SOCK_DIAG and
similar interfaces.

Fixes: c9da99e6475f ("unix_diag: Fixup RQLEN extension report")
Fixes: 2aac7a2cb0d9 ("unix_diag: Pending connections IDs NLA")
Fixes: 45a96b9be6ec ("unix_diag: Dumping all sockets core")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/diag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/unix/diag.c b/net/unix/diag.c
index ae39538c5042..116cf508aea4 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -65,7 +65,7 @@ static int sk_diag_dump_icons(struct sock *sk, struct sk_buff *nlskb)
 	u32 *buf;
 	int i;
 
-	if (sk->sk_state == TCP_LISTEN) {
+	if (READ_ONCE(sk->sk_state) == TCP_LISTEN) {
 		spin_lock(&sk->sk_receive_queue.lock);
 
 		attr = nla_reserve(nlskb, UNIX_DIAG_ICONS,
@@ -103,7 +103,7 @@ static int sk_diag_show_rqlen(struct sock *sk, struct sk_buff *nlskb)
 {
 	struct unix_diag_rqlen rql;
 
-	if (sk->sk_state == TCP_LISTEN) {
+	if (READ_ONCE(sk->sk_state) == TCP_LISTEN) {
 		rql.udiag_rqueue = sk->sk_receive_queue.qlen;
 		rql.udiag_wqueue = sk->sk_max_ack_backlog;
 	} else {
@@ -136,7 +136,7 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb, struct unix_diag_r
 	rep = nlmsg_data(nlh);
 	rep->udiag_family = AF_UNIX;
 	rep->udiag_type = sk->sk_type;
-	rep->udiag_state = sk->sk_state;
+	rep->udiag_state = READ_ONCE(sk->sk_state);
 	rep->pad = 0;
 	rep->udiag_ino = sk_ino;
 	sock_diag_save_cookie(sk, rep->udiag_cookie);
@@ -215,7 +215,7 @@ static int unix_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		sk_for_each(sk, &net->unx.table.buckets[slot]) {
 			if (num < s_num)
 				goto next;
-			if (!(req->udiag_states & (1 << sk->sk_state)))
+			if (!(req->udiag_states & (1 << READ_ONCE(sk->sk_state))))
 				goto next;
 			if (sk_diag_dump(sk, skb, req, sk_user_ns(skb->sk),
 					 NETLINK_CB(cb->skb).portid,
-- 
2.30.2


