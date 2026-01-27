Return-Path: <netdev+bounces-253843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A9eOs2xeGkksQEAu9opvQ
	(envelope-from <netdev+bounces-253843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:38:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F029464B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAD52301ABB9
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BB1354AF0;
	Tue, 27 Jan 2026 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXHhJT8y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD45355024
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517514; cv=none; b=GlKBo2XxDuXZxkZF2u4U4Mzb3RbQKRcHT7DPiQ4EvEUB8qqDhy7145M174SEkYT0TfPhR1bNUoMqgJBW83Cy1/UfmhHd0/4TnZzAjkmnR4goAOkmQ1atekEnoUV3LR/vwqyHzpem9pek1097DvE8Fccb19E4Tv66a9SwzsmA6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517514; c=relaxed/simple;
	bh=4ISYUZ3MZCEnLpxGlG0zYM76lzynoNz8qXhq2aCNETc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jEVCZoC1Yg+6OJGVf6HbygKXTbhzctJvYBT5nPQw9I7gHibA5bjrAPdIjEUHs5sITz225Cu5MQwGUzOSePFPg4Y6Me4krtQniSO8MibcZuO+OjuR4UJxkku0/ImhjZTbKY+uUDDdFTLYFP2hMH13T9qvk7Kwdpu85en9vLQkhY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FXHhJT8y; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c6b315185aso734178085a.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769517512; x=1770122312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg77Xqx5rLkQbVR65dPafRyk5SIY8XbEtdDxX7vJ+So=;
        b=FXHhJT8yw49zUAisCzse2q1SADPbx2etC+mLUQYmoR0axBBh3KS6x75vs6VzQw1ooc
         zMeNJ0h1Hfoi4VuP7sICnH/s3Vbu9Xi/OcAC25Gf1txQo6Gat2BFkfrx4D5+p0nt3kF0
         tCqu149UDqqxiuJt4VT4kmtQmyJMx29uBsRpg4hP5do1scy9Te3SVP0aNNJ/Ke+1oD43
         Lcvq/rYqfnv0FsWtJKBuhR63/x6HjxJOaShw0R3uGL5t3ZQ1Ysf5YTFkK4Dii0EMaXaK
         ZVELt9KY0rhsgeHADH1N/qZx+kz0qRkXeH7bgCGZ4NN0fFqEJsWa8j8N+B9jhE33ZbP3
         dGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769517512; x=1770122312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg77Xqx5rLkQbVR65dPafRyk5SIY8XbEtdDxX7vJ+So=;
        b=r1pQIrbJlg7mVxqlO4O81bzmuogS2sRqEvGApPZVZXmtqMw1AFVwZxAxqAM3KbokQN
         2mg9NFxD4e7Q4C8t6w4rjITar+ooTQv8ZIeVEAFk65tOdO+meHEK5dnpOJX3h1TRrSmx
         h14gBeBf+yqCwukdIJYP7J8BiB0wG42xfAf1GCQtAy30f9zj043nKGyMsduzjMFz7p7o
         +la4yMiTHllq3jQnSTOQlduGYV2AvKiC5UFOsL1e5ljNyBN3Z6tiD6d2ZNA2bYKkcOXO
         hIS4islb/Ou4SyXXQukmkfFrJ0P/mOvfXp8aVhFQbLIe9spZPlwK5pkgPhpUHJhnq7OT
         j4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWnf+bcRPiZvkDyHbCjc5Lm3XQdNiW9dYZKJal7Dr4a5zNJS2RMBqeY/8wJ0oSPpc3k+ePPRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcN1AOCQGnrt0Nwl5xD9dUnq3d2zBOXylcFQz9HxVentXjjG6
	SzMRM/FbYPn0j2Kn6TbatOmT54/2B7uB0eA0XNEv2cMi8f39BBB4rsKl/nJ+1WEmeoekXVM0tm7
	KoVOAz0Hl83OuHw==
X-Received: from qkbbl35.prod.google.com ([2002:a05:620a:1aa3:b0:8c5:33be:e624])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2886:b0:8c5:2d4c:4f0e with SMTP id af79cd13be357-8c70b87753cmr173371285a.25.1769517511997;
 Tue, 27 Jan 2026 04:38:31 -0800 (PST)
Date: Tue, 27 Jan 2026 12:38:27 +0000
In-Reply-To: <20260127123828.4098577-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127123828.4098577-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127123828.4098577-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: tcp_tx_timestamp() must look at the rtx queue
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253843-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68F029464B
X-Rspamd-Action: no action

tcp_tx_timestamp() is only called at the end of tcp_sendmsg_locked()
before the final tcp_push().

By the time it is called, it is possible all the copied data
has been sent already (transmit queue is empty).

If this is the case, use the last skb in the rtx queue.

Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 22b7ec192272f680709be171184fdc3b2df813fb..595329fd2c439290141c4ab5a3a4fa7084dbd5b5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -501,6 +501,9 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
 	u32 tsflags = sockc->tsflags;
 
+	if (unlikely(!skb))
+	        skb = skb_rb_last(&sk->tcp_rtx_queue);
+
 	if (tsflags && skb) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
-- 
2.53.0.rc1.217.geba53bf80e-goog


